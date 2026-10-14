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

## Disassembly Progress:

| Segment | Type | Purpose                   | Status      |
|---------|------|---------------------------|-------------|
| 0       | Code | Main assembler logic      | In Progress |
| 1       | Code | I/O routines (``_OS2*``)  | Implemented |
| 2       | Data | Strings                   | X           |
| 3       | Data | Strings                   | X           |

## Building

## Importing symbols into IDA
- From the tools directory, run ``python extract_zortech_symbols.py original\ARGSFX.EXE reverse\publics.csv`` to extract the typed publics and local labels from the NB02 overlay.
- Run ``python generate_ida_idc.py`` to generate ``reverse\import_publics.idc`` from the CSV.
- Load the original DOS executable in IDA with image base ``0``, then run the generated script using IDA's IDC file command.
- The script imports each symbol at ``segment * 16 + offset``. Multiple symbols at the same address are represented by one primary name; the remaining aliases are listed in comments in the IDC file.
- The extractor records the compact local-label format separately and maps its segment index ``0x0b`` to load segment ``0``; this mapping was checked against the ZDB listing.

## Windows
- Download or clone the repo.  
- Extract it somewhere if you downloaded as ZIP, or go to the repo directory if you cloned it.  
- Run ``build.cmd`` to assemble.  
- Run ``build to log.cmd`` to assemble, writing console output to a log file.  

## Known Info
- Originally assembled with MASM 5.13 (According to the header of ArgSfx OS/2 1.35)
- Built with version 3.0r1 of the Zortech C/C++ toolchain, according to 'stamps' left in the data of the DOS extender builds.  

All known versions of the assembler:  
- SASM (DOS extender) 2.02 (``SASMX.EXE``) (ARGSFX's codebase descended from this assembler)  
- ARGSFX (DOS extender) versions 1.33, 1.40, 1.44, 1.48-1.50, 1.52 (``ARGSFXX.EXE``)  
- ARGSFX OS/2 1.35 (``ARGOS2.EXE``)  
- ARGSFX (no DOS extender) versions 1.33, 1.40, 1.44, 1.49, 1.50 (``ARGSFX.EXE``)  
All known versions of the companion linker:
- SL 1.01 (``SL.EXE``) (ARGLINK's codebase descended from here)  
- ARGLINK SFX versions 1.06, 1.08, 1.11 (``ARGLINK.EXE``)

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