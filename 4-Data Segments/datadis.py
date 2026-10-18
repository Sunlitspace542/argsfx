import re

# Constants based on your formula
SEGMENT_BASE = 0x10EC
OFFSET_CORRECTION = 0x380
SEGMENT_SHIFT = SEGMENT_BASE << 4
DATA_START_ADDR = 0xD233  # where the data segment starts in the original EXE

# Helper: Convert DBG offset to EXE physical address
def dbg_to_physical(dbg_offset: int) -> int:
    return dbg_offset + OFFSET_CORRECTION + SEGMENT_SHIFT

# Load DBG symbols
labels = []
with open("ARGSFX_DATA.DBG", "r") as f:
    for line in f:
        match = re.match(r"0x([0-9a-fA-F]+):0x([0-9a-fA-F]+)\s*=\s*(\w+)\s+(.*)", line)
        if match:
            seg_str, off_str, dtype, label = match.groups()
            segment = int(seg_str, 16)
            offset = int(off_str, 16)
            dbg_addr = offset
            physical_addr = dbg_to_physical(dbg_addr)
            labels.append((physical_addr, dtype, label))

# Sort by physical address
labels.sort()

# Load binary data segment
with open("ARGSFX_DATA.BIN", "rb") as f:
    data = f.read()

# Disassemble and annotate
output_lines = []
for i, (addr, dtype, label) in enumerate(labels):
    next_addr = labels[i + 1][0] if i + 1 < len(labels) else DATA_START_ADDR + len(data)
    rel_offset = addr - DATA_START_ADDR
    length = next_addr - addr
    bytes_out = data[rel_offset:rel_offset + length]
    hex_data = ', '.join(f"{b:02X}h" for b in bytes_out)
    clean_label = label.split('#')[0]
#    output_lines.append(f";0x{addr:05X}\n{clean_label}:\ndb\t{hex_data}\n")
    output_lines.append(f"; 0x{addr:05X}")
    output_lines.append(f"{clean_label}:")
    for i in range(0, len(bytes_out), 8):
        chunk = bytes_out[i:i+8]
        line = ', '.join(f"{b:02X}h" for b in chunk)
        output_lines.append(f"    db {line}")
    output_lines.append("")  # blank line after each label


# Write to file
with open("datasegs.asm", "w") as out:
    out.write('\n'.join(output_lines))

print("✅ Disassembly complete: see 'datasegs.asm'")
