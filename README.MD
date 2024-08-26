# ARGSFX
A work-in-progress disassembly of the ArgAsm-Super FX (ArgSfx) 65816/SuperFX assembler by Argonaut Software Ltd.  
The aim is to reconstruct the x86 assembly source code so it can be further modified and expanded by the Star Fox hacking community.  

The non-DOS extender version of version 1.50 has been used as a base as it is the most recent non-extender version currently known to exist to also include debug data, which after being opened in Zortech ZDB, was used to produce a code listing with all labels intact.  

## Known info

- Originally assembled with version 3.0r1 of the Zortech C/C++ toolchain.  

## Original source structure from leftover debug data:
```
D:
└── SFX
    ├── ARGSFX
    ├── ARGSFX.ASM: Presumably the Main assembler logic and 65816 parser
    └── MARIOP.ASM: Presumably the MARIO (SuperFX) code parser
```