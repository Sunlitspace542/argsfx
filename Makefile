#########################
# ArgSfx Linux Makefile #
#########################

# Use Wine to run DOSBox on nix, may be faster depending on your situation
WINE ?= 0

DOSBOX=dosbox-x
DOSBOXOPTS=-fastlaunch -nolog

ifeq ($(WINE),1)
DOS=wine $(DOSBOX).exe $(DOSBOXOPTS)
else
DOS=$(DOSBOX) $(DOSBOXOPTS)
endif

all: 
	@$(DOS) BUILD.BAT

log: 
	@$(DOS) BLDTOLOG.BAT

clean:
	@$(DOS) CLEAN.BAT
