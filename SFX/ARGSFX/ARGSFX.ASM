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

; The following is a test program, so this does something other than hang when I run it
cld
mov	cx, seg	seg003
mov	ss, cx ; set stack segment to seg003
assume ss:seg003

push cs
pop ds ; seg000 -> ds

mov	dx, offset teststring
call	_OS2PRTSTRING

jmp far ptr	_OS2EXIT

teststring:
db "Hello, world!",0dh,0ah,"$",0

_ARGSFX endp

seg000 ends

; include _OS2* system call routines
include call.asm ; TODO is CALL included or assembled and linked together w/ ARGSFX?

; temporary home for the data segments until I
; get around to properly disassembling them
include datasegs.asm

end _ARGSFX