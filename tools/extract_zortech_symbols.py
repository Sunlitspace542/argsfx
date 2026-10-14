"""Extract symbols from the NB02 debug overlay emitted by Zortech C 3.x.

The overlay contains both typed public records and a compact table of local
labels. The latter stores an 8-bit segment index, 16-bit offset, zero byte, and
length-prefixed name. In this executable, segment index 0x0b maps to load
segment 0, as verified against the ZDB listing.
"""

import argparse
import csv
import re
import struct
from collections import defaultdict
from pathlib import Path


LOCAL_SEGMENTS = {0x0B: 0x0000}
IDENT = re.compile(rb"[A-Za-z_][A-Za-z0-9_#$@?.]*")


def extract_symbols(data: bytes) -> tuple[list[dict[str, object]], int]:
    if data[:2] != b"MZ":
        raise ValueError("input is not an MZ executable")

    _, last_bytes, pages, _, header_paragraphs = struct.unpack_from("<5H", data)
    image_size = (pages - 1) * 512 + last_bytes
    header_size = header_paragraphs * 16
    if header_size > image_size:
        raise ValueError(f"MZ header extends past the load image ({header_size:#x})")
    if image_size > len(data):
        raise ValueError(f"MZ image ends past EOF ({image_size:#x} > {len(data):#x})")

    if data[image_size : image_size + 4] != b"NB02":
        raise ValueError(f"No NB02 overlay at calculated image end {image_size:#x}")

    matches = list(IDENT.finditer(data, image_size + 4))
    local_rows = []
    local_names = set()

    for match in matches:
        name = match.group().decode("ascii")
        name_start = match.start()
        record_start = name_start - 5
        if record_start < image_size or data[name_start - 2] != 0:
            continue
        if data[name_start - 1] != len(name):
            continue

        segment_index = data[record_start]
        if segment_index not in LOCAL_SEGMENTS:
            continue

        offset = struct.unpack_from("<H", data, record_start + 1)[0]
        segment = LOCAL_SEGMENTS[segment_index]
        file_offset = header_size + segment * 16 + offset
        if file_offset >= image_size:
            continue

        local_rows.append(
            {
                "name": name,
                "segment": segment,
                "offset": offset,
                "debug_type": 0,
                "file_offset": file_offset,
                "overlay_offset": name_start,
                "record_format": "local",
                "record_segment": segment_index,
            }
        )
        local_names.add(name)

    rows = list(local_rows)
    for match in matches:
        name = match.group().decode("ascii")
        if name in local_names:
            continue

        length_pos = match.start() - 1
        if length_pos < image_size or data[length_pos] != len(name):
            continue
        record_pos = length_pos - 6
        if record_pos < image_size:
            continue

        offset, segment, debug_type = struct.unpack_from("<HHH", data, record_pos)
        file_offset = header_size + segment * 16 + offset
        if file_offset >= image_size:
            continue

        rows.append(
            {
                "name": name,
                "segment": segment,
                "offset": offset,
                "debug_type": debug_type,
                "file_offset": file_offset,
                "overlay_offset": match.start(),
                "record_format": "public",
                "record_segment": segment,
            }
        )

    by_name = defaultdict(list)
    for row in rows:
        by_name[row["name"]].append(row)
    duplicates = {
        name: entries
        for name, entries in by_name.items()
        if len({(entry["segment"], entry["offset"]) for entry in entries}) > 1
    }
    if duplicates:
        details = ", ".join(
            f"{name} ({len(entries)} locations)" for name, entries in duplicates.items()
        )
        raise ValueError(f"symbol names resolve to multiple addresses: {details}")

    rows.sort(key=lambda row: row["overlay_offset"])
    return rows, image_size


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", nargs="?", type=Path, default=Path("original/ARGSFX.EXE"))
    parser.add_argument("target", nargs="?", type=Path, default=Path("reverse/publics.csv"))
    args = parser.parse_args()

    try:
        rows, _ = extract_symbols(args.source.read_bytes())
    except (OSError, struct.error, ValueError) as error:
        raise SystemExit(f"could not extract symbols: {error}") from error

    args.target.parent.mkdir(parents=True, exist_ok=True)
    with args.target.open("w", newline="", encoding="utf-8") as out:
        columns = (
            "name",
            "segment",
            "offset",
            "debug_type",
            "file_offset",
            "overlay_offset",
            "record_format",
            "record_segment",
        )
        writer = csv.DictWriter(out, fieldnames=columns)
        writer.writeheader()
        for row in rows:
            writer.writerow(
                {
                    **row,
                    "segment": f"0x{row['segment']:04x}",
                    "offset": f"0x{row['offset']:04x}",
                    "debug_type": f"0x{row['debug_type']:04x}",
                    "file_offset": f"0x{row['file_offset']:05x}",
                    "overlay_offset": f"0x{row['overlay_offset']:05x}",
                    "record_segment": f"0x{row['record_segment']:04x}",
                }
            )

    local_count = sum(row["record_format"] == "local" for row in rows)
    print(f"wrote {len(rows)} records ({local_count} local labels) to {args.target}")


if __name__ == "__main__":
    main()
