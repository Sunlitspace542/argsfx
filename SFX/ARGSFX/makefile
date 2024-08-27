###################
# ARGSFX Makefile #
###################

# Assembler
ASM=MASM

# Linker
LINK=ML

ALLFILES= ARGSFX.OBJ

# Recipe to assemble a .ASM file and create a linkable .OBJ file
.asm.obj:
	@$(ASM) $<

# Everything that should be done when make is executed
all: argsfx

# Link EXE
argsfx: $(ALLFILES)
	@$(LINK) argsfx.obj

## Files to assemble

ARGSFX.OBJ: \
ARGSFX.ASM
