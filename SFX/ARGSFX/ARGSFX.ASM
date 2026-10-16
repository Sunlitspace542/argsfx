; ArgAsm-Super FX (ArgSfx)
; Filename: ARGSFX.ASM
; Purpose: Main assembler module.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

include	defines.inc
include	macros.inc

NAME ARGSFX

.386
.model large

; Segment type:	Pure code
; Main assembler logic
seg000 segment byte public 'CODE' use16
assume cs:seg000
assume es:nothing, ss:seg000, ds:nothing, fs:nothing, gs:nothing

public _ARGSFX
_ARGSFX proc near

_ARGSFX endp

seg000 ends

; include _OS2* system call routines
include call.asm ; TODO is CALL included or assembled and linked together w/ ARGSFX?

; temporary home for the data segments until I
; get around to properly disassembling them
include datasegs.asm

end _ARGSFX