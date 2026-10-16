"""Convert a ZDB text dump into a joined symbol CSV."""

import argparse
import csv
import re
from pathlib import Path


SECTION_RE = re.compile(r"^([A-Z][A-Z0-9 ]*):$")
STRING_RE = re.compile(r"^\s*([0-9a-fA-F]+) text = (.*)$")
SYMBOL_RE = re.compile(
    r"^\s*([0-9a-fA-F]+) : name=([0-9a-fA-F]+) "
    r"off=([0-9a-fA-F]+) seg=([0-9a-fA-F]+) "
    r"overlay=([0-9a-fA-F]+)$"
)
DATA_RE = re.compile(
    r"^\s*([0-9a-fA-F]+) : def=([0-9a-fA-F]+) "
    r"off=([0-9a-fA-F]+) seg=([0-9a-fA-F]+)$"
)
DEFINITION_RE = re.compile(
    r"^\s*([0-9a-fA-F]+) : name=([0-9a-fA-F]+) "
    r"at=([0-9a-fA-F]+) scope=([0-9a-fA-F]+):([0-9a-fA-F]+) "
    r"sz=([0-9a-fA-F]+) val=([0-9a-fA-F]+) "
    r"decl=([0-9a-fA-F]+) link=([0-9a-fA-F]+)$"
)


def number(value: str) -> int:
    return int(value, 16)


def hex_value(value: int | None, width: int = 4) -> str:
    return "" if value is None else f"0x{value:0{width}x}"


def parse_dump(text: str) -> list[dict[str, str]]:
    strings: dict[int, str] = {}
    definitions: dict[int, dict[str, int]] = {}
    symbols: list[dict[str, int]] = []
    data_entries: list[dict[str, int]] = []
    section = ""

    for line_number, line in enumerate(text.splitlines(), 1):
        section_match = SECTION_RE.fullmatch(line)
        if section_match:
            section = section_match.group(1)
            continue

        if section == "STRINGS":
            match = STRING_RE.fullmatch(line)
            if match:
                string_id = number(match.group(1))
                if string_id in strings:
                    raise ValueError(f"duplicate string ID {string_id:04x} on line {line_number}")
                strings[string_id] = match.group(2)
        elif section == "DEFINITIONS":
            match = DEFINITION_RE.fullmatch(line)
            if match:
                values = [number(value) for value in match.groups()]
                definition_id, name_id, at, scope_segment, scope_offset, size, value, decl, link = values
                if definition_id in definitions:
                    raise ValueError(
                        f"duplicate definition ID {definition_id:04x} on line {line_number}"
                    )
                definitions[definition_id] = {
                    "name_id": name_id,
                    "at": at,
                    "scope_segment": scope_segment,
                    "scope_offset": scope_offset,
                    "size": size,
                    "value": value,
                    "declaration": decl,
                    "link": link,
                }
        elif section == "SYMBOLS":
            match = SYMBOL_RE.fullmatch(line)
            if match:
                record_id, name_id, offset, segment, overlay = (
                    number(value) for value in match.groups()
                )
                symbols.append(
                    {
                        "record_id": record_id,
                        "name_id": name_id,
                        "offset": offset,
                        "segment": segment,
                        "overlay": overlay,
                    }
                )
        elif section == "DATA":
            match = DATA_RE.fullmatch(line)
            if match:
                record_id, definition_id, offset, segment = (
                    number(value) for value in match.groups()
                )
                data_entries.append(
                    {
                        "record_id": record_id,
                        "definition_id": definition_id,
                        "offset": offset,
                        "segment": segment,
                    }
                )

    rows: list[dict[str, str]] = []
    for symbol in symbols:
        name_id = symbol["name_id"]
        if name_id not in strings:
            raise ValueError(f"SYMBOLS references missing string ID {name_id:04x}")
        rows.append(
            make_row(
                name=strings[name_id],
                segment=symbol["segment"],
                offset=symbol["offset"],
                source_section="SYMBOLS",
                record_id=symbol["record_id"],
                name_id=name_id,
                overlay=symbol["overlay"],
            )
        )

    for entry in data_entries:
        definition_id = entry["definition_id"]
        definition = definitions.get(definition_id)
        if definition is None:
            raise ValueError(f"DATA references missing definition ID {definition_id:04x}")
        name_id = definition["name_id"]
        if name_id not in strings:
            raise ValueError(
                f"DEFINITIONS {definition_id:04x} references missing string ID {name_id:04x}"
            )
        rows.append(
            make_row(
                name=strings[name_id],
                segment=entry["segment"],
                offset=entry["offset"],
                source_section="DATA",
                record_id=entry["record_id"],
                name_id=name_id,
                definition_id=definition_id,
                definition=definition,
            )
        )

    data_labels = {
        (row["name"], row["segment"], row["offset"])
        for row in rows
        if row["source_section"] == "DATA"
    }
    rows = [
        row
        for row in rows
        if row["source_section"] == "DATA"
        or (row["name"], row["segment"], row["offset"]) not in data_labels
    ]

    rows.sort(
        key=lambda row: (
            int(row["segment"], 16),
            int(row["offset"], 16),
            row["source_section"],
            row["name"],
        )
    )
    return rows


def make_row(
    *,
    name: str,
    segment: int,
    offset: int,
    source_section: str,
    record_id: int,
    name_id: int,
    overlay: int | None = None,
    definition_id: int | None = None,
    definition: dict[str, int] | None = None,
) -> dict[str, str]:
    address = segment * 16 + offset
    definition = definition or {}
    return {
        "name": name.removesuffix("#argsfx"),
        "segment": hex_value(segment),
        "offset": hex_value(offset),
        "address": hex_value(address, 5),
        "debug_type": "0x0000",
        "source_section": source_section,
        "record_id": hex_value(record_id),
        "name_id": hex_value(name_id),
        "definition_id": hex_value(definition_id),
        "definition_at": hex_value(definition.get("at")),
        "scope_segment": hex_value(definition.get("scope_segment")),
        "scope_offset": hex_value(definition.get("scope_offset")),
        "size": hex_value(definition.get("size")),
        "value": hex_value(definition.get("value")),
        "declaration": hex_value(definition.get("declaration")),
        "link": hex_value(definition.get("link")),
        "overlay": hex_value(overlay),
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="text dump produced by ZDB")
    parser.add_argument(
        "target",
        nargs="?",
        type=Path,
        help="output CSV (defaults to <source>_symbols.csv)",
    )
    args = parser.parse_args()
    target = args.target or args.source.with_name(f"{args.source.stem}_symbols.csv")

    try:
        rows = parse_dump(args.source.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, ValueError) as error:
        raise SystemExit(f"could not parse ZDB dump: {error}") from error
    if not rows:
        raise SystemExit("could not parse ZDB dump: no SYMBOLS or DATA entries found")

    columns = (
        "name",
        "segment",
        "offset",
        "address",
        "debug_type",
        "source_section",
        "record_id",
        "name_id",
        "definition_id",
        "definition_at",
        "scope_segment",
        "scope_offset",
        "size",
        "value",
        "declaration",
        "link",
        "overlay",
    )
    try:
        target.parent.mkdir(parents=True, exist_ok=True)
        with target.open("w", newline="", encoding="utf-8") as output:
            writer = csv.DictWriter(output, fieldnames=columns)
            writer.writeheader()
            writer.writerows(rows)
    except OSError as error:
        raise SystemExit(f"could not write symbol CSV: {error}") from error

    symbol_count = sum(row["source_section"] == "SYMBOLS" for row in rows)
    data_count = sum(row["source_section"] == "DATA" for row in rows)
    print(f"wrote {len(rows)} rows ({symbol_count} symbols, {data_count} data labels) to {target}")


if __name__ == "__main__":
    main()
