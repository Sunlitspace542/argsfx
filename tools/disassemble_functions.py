"""Produce accurate 16-bit Intel listings for recovered Zortech publics."""

import csv
import sys
from pathlib import Path

from capstone import CS_ARCH_X86, CS_MODE_16, Cs


binary = Path(sys.argv[1] if len(sys.argv) > 1 else "original/ARGSFX.EXE").read_bytes()
symbols_path = Path(sys.argv[2] if len(sys.argv) > 2 else "reverse/publics.csv")
output = Path(sys.argv[3] if len(sys.argv) > 3 else "reverse/functions")
output.mkdir(parents=True, exist_ok=True)

with symbols_path.open(newline="", encoding="utf-8") as stream:
    symbols = list(csv.DictReader(stream))

by_segment = {}
for symbol in symbols:
    if not symbol["name"].startswith("_"):
        continue
    by_segment.setdefault(int(symbol["segment"], 16), []).append(symbol)

decoder = Cs(CS_ARCH_X86, CS_MODE_16)
decoder.detail = False
written = 0
for segment, entries in by_segment.items():
    unique = {}
    for entry in entries:
        unique.setdefault(int(entry["offset"], 16), entry)
    ordered = sorted(unique.items())
    for index, (start, symbol) in enumerate(ordered):
        # A public in the same segment bounds the routine. Cap wildly large gaps;
        # data publics sharing a segment are still useful but not disassembled.
        end = ordered[index + 1][0] if index + 1 < len(ordered) else start + 0x2000
        if end <= start or end - start > 0x10000:
            continue
        file_start = int(symbol["file_offset"], 16)
        code = binary[file_start : file_start + min(end - start, 0x10000 - start)]
        instructions = list(decoder.disasm(code, start))
        if not instructions or instructions[0].mnemonic not in {"push", "retf", "jmp"}:
            continue
        safe = symbol["name"].replace("?", "_").replace("@", "_").replace("#", "_")
        with (output / f"{segment:04x}_{start:04x}_{safe}.asm").open("w", encoding="utf-8") as out:
            out.write(f"; {symbol['name']} segment={segment:04x} offset={start:04x} file={file_start:05x}\n")
            for insn in instructions:
                raw = " ".join(f"{byte:02x}" for byte in insn.bytes)
                out.write(f"{segment:04x}:{insn.address:04x}  {raw:<24} {insn.mnemonic:<8} {insn.op_str}\n")
        written += 1

print(f"wrote {written} function listings to {output}")
