# ArgAsm-Super FX (ArgSfx) Disassembly
A work-in-progress disassembly of the ArgAsm-Super FX (ArgSfx) 65816/SuperFX macro assembler by Argonaut Software Ltd.  
The aim is to reconstruct the x86 assembly source code so it can be further modified and expanded by the Star Fox hacking community.  

The non-DOS extender version of version 1.50 has been used as a base as it is the most recent non-extender version currently known to exist to also include debug data, which after being opened in Zortech ZDB 3.0r1, was used to produce a code listing with all labels intact.  

Currently, work is in progress to reconstruct source code assemblable by MASM by cross-referencing the IDA and ZDB disassemblies.

```diff
- WARNING! -

This codebase is in an early research/development phase and the binary this repository
builds is currently not complete enough to be anywhere near usable,
so it cannot yet be used as a codebase for general changes.
```

# Disassembly Progress:

| Segment | Type | Purpose                   | Status      |
|---------|------|---------------------------|-------------|
| 0       | Code | Main assembler logic      | In Progress |
| 1       | Code | I/O routines (``_OS2*``)  | Implemented |
| 2       | Data | Data                      | X           |
| 3       | Data | Data, Stack               | X           |

## Plan:
- [ ] 1. Disassemble ArgSfx v1.50
- [ ] 2. Using the ArgSfx v1.50 disassembly as a basis, disassemble the ArgSfx-Extender v1.50
- [ ] 3. Find and implement ArgSfx-Extender v1.52 changes
- [ ] 4. Use ArgSfx-OS/2 1.35 to reconstruct OS/2 target?

## Plans after completion
- [ ] Try to reconstruct SASMX source using the reconstructed ArgSfx source as a basis?
- [ ] Create buildable disassembly of the linker? (I don't think I'm going to be able to decompile it but there is some HASM in there)
- [ ] Investigate porting - 32-bit conversion, static recomp, reimplementation? (the OS/2 version may be the key here)

## TODO
- [x] Locate Zortech C/C++ 3.0r1
- [x] Locate LINK 5.13 (for OS/2)
- [ ] Locate libraries for OS/2? (DOSCALLS)
- [ ] Locate LINK 5.10 (for DOS)
- [ ] Find/make a good way to dump reliable debug info from the NB02 symbol data left in the standard DOS EXEs (in progress)

# Building

## Importing symbols into IDA
- From the tools directory, run ``python extract_zortech_symbols.py original\ARGSFX.EXE reverse\publics.csv`` to extract the typed publics and local labels from the NB02 overlay.
- Run ``python generate_ida_idc.py`` to generate ``reverse\import_publics.idc`` from the CSV.
- Load the original DOS executable in IDA with image base ``0``, then run the generated script using IDA's IDC file command.
- The script imports each symbol at ``segment * 16 + offset``. Multiple symbols at the same address are represented by one primary name; the remaining aliases are listed in comments in the IDC file.
- The extractor records the compact local-label format separately and maps its segment index ``0x0b`` to load segment ``0``; this mapping was checked against the ZDB listing.

## Processing ZDB symbol dumps
- To join the ``SYMBOLS`` and ``DATA`` names in a ZDB text dump, run ``python parse_zdb_dump.py ..\6_extra-data\ARGSFX_full.DBG``. This writes ``ARGSFX_full_symbols.csv`` alongside the dump and includes linked definition metadata for ``DATA`` entries. Duplicate ``SYMBOLS`` rows are omitted when the same name and address has a richer ``DATA`` row, and the ``#argsfx`` suffix is removed from names.
- The CSV can be passed to ``generate_ida_idc.py``. Its ``source_section`` column preserves the source table; ZDB's dump does not identify publics versus locals, and ``LINES`` is intentionally omitted from the symbol CSV.

## Windows
- Download or clone the repo.  
- Extract it somewhere if you downloaded as ZIP, or go to the repo directory if you cloned it.  
- Run ``build.cmd`` to assemble.  
- Run ``build to log.cmd`` to assemble, writing console output to a log file.  

# Known Info
- OS/2 Originally linked with LINK 5.13
- DOS extender versions linked with LINK 5.10
- Built with version 3.0r1 of the Zortech C/C++ toolchain, according to 'stamps' left in the data of the DOS extender builds.  

All known versions of the assembler:  
- SASMX 2.02 (``SASMX.EXE``) (ArgSfx's codebase descended from this assembler)  
- ArgSfx versions 1.33, 1.40, 1.44, 1.49, 1.50 (``ARGSFX.EXE``)  
- ArgSfx-Extender versions 1.33, 1.40, 1.44, 1.48-1.50, 1.52 (``ARGSFXX.EXE``)  
- ArgSfx-OS/2 1.35 (``ARGOS2.EXE``)  

All known versions of the companion linker:
- SL (SLink?) 1.01 (``SL.EXE``) (ArgLink's codebase descended from here)  
- ArgLink SFX versions 1.06, 1.08, 1.11 (``ARGLINK.EXE``)

## Original source structure from leftover debug data:
```
D:
└── SFX
    ├── ARGSFX
    │   ├── ARGSFX.ASM: Presumably the main assembler logic and 65816 parser
    │   └── MARIOP.ASM: Presumably the MARIO Chip (SuperFX) code parser
    └── ARGLINK: Source directory for the ARGLINK linker (Currently out of scope for this project)
        ├── EXPRESS.ASM
        ├── SENDER.ASM
        └── ARGLINK.C
```