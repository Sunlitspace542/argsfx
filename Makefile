#########################
# ArgSfx Linux Makefile #
#########################

DOSBOX=dosbox-x

all: 
	@$(DOSBOX) BUILD.BAT

log: 
	@$(DOSBOX) BLDTOLOG.BAT

