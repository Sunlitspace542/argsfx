###################
# ARGSFX Makefile #
###################

# Assembler
ASM=MASM

# Linker
LINK=ML

LOPTS= /FmARGSFX.MAP

ALLFILES= ARGSFX.OBJ

# Recipe to assemble a .ASM file and create a linkable .OBJ file
.asm.obj:
	@$(ASM) $<

# Everything that should be done when make is executed
all: argsfx

# Clean
clean:
	@echo Cleaning...
	@del *.obj
	@del *.exe
	@del *.map

# Link EXE
argsfx: $(ALLFILES)
	@$(LINK) $(LOPTS) argsfx.obj

## Files to assemble

ARGSFX.OBJ: \
ARGSFX.ASM
