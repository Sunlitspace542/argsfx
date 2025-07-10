import re

# File paths
input_file = 'datasegs.asm'
output_file = 'datasegsout.asm'

# Regex pattern to match exactly 2-digit hex numbers followed by 'h'
pattern = r'(?<![0-9A-Fa-f])([0-9A-Fa-f]{2})h'

# Read the input file
with open(input_file, 'r', encoding='utf-8') as f:
    content = f.read()

# Perform the replacement
modified_content = re.sub(pattern, r'0\1h', content)

# Write the output to a new file
with open(output_file, 'w', encoding='utf-8') as f:
    f.write(modified_content)

print(f"Hex values processed. Output written to: {output_file}")
