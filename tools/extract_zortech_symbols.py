"""Extract public records from the NB00 debug overlay emitted by Zortech C 3.x.

The overlay stores public names as a one-byte length prefixed string. Six bytes
immediately before the length encode offset, load-relative segment, and a debug
type. This deliberately conservative extractor only accepts identifier-shaped
names and records whose segment points inside the MZ load image.
"""

import csv
import re
import struct
import sys
from pathlib import Path


source = Path(sys.argv[1] if len(sys.argv) > 1 else "original/SHAPED.EXE")
target = Path(sys.argv[2] if len(sys.argv) > 2 else "reverse/publics.csv")
data = source.read_bytes()

_, last_bytes, pages, _, header_paragraphs = struct.unpack_from("<5H", data)
image_size = (pages - 1) * 512 + last_bytes
header_size = header_paragraphs * 16
overlay = image_size
if data[overlay : overlay + 4] != b"NB02":
    raise SystemExit(f"No NB02 overlay at calculated image end {overlay:#x}")

ident = re.compile(rb"[A-Za-z_][A-Za-z0-9_#$@?.]*")
rows = []
for match in ident.finditer(data, overlay + 4):
    name = match.group().decode("ascii")
    length_pos = match.start() - 1
    if length_pos < overlay or data[length_pos] != len(name) or length_pos < 6:
        continue
    offset, segment, debug_type = struct.unpack_from("<HHH", data, length_pos - 6)
    file_offset = header_size + segment * 16 + offset
    if file_offset >= image_size:
        continue
    rows.append((name, segment, offset, debug_type, file_offset, match.start()))

# Keep the first record for exact duplicates; local names can legitimately recur.
target.parent.mkdir(parents=True, exist_ok=True)
with target.open("w", newline="", encoding="utf-8") as out:
    writer = csv.writer(out)
    writer.writerow(("name", "segment", "offset", "debug_type", "file_offset", "overlay_offset"))
    for name, segment, offset, debug_type, file_offset, symbol_offset in rows:
        writer.writerow((name, f"0x{segment:04x}", f"0x{offset:04x}", f"0x{debug_type:04x}", f"0x{file_offset:05x}", f"0x{symbol_offset:05x}"))

print(f"wrote {len(rows)} records to {target}")
