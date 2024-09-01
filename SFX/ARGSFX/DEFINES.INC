; ArgAsm-Super FX (ArgSfx)
; Filename: DEFINES.INC
; Purpose: Equates.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

; Useful labels

; Marks calls to unimplemented code
UNIMPLEMENTED_ROUTINES	equ	0

; Platform Defines

; Target MS-DOS (Real mode)
TARGET_DOS		equ	1

; Target MS-DOS, DOS/16M (ZPM) extended version (Protected Mode)
TARGET_DOS16M	equ	0

; TODO Find MASM 5.13, we need it to be able to target OS/2
; Target IBM OS/2 (Protected Mode)
TARGET_OS2		equ	0

; Assembler Version defines

; SASM/SASMX
VERSION_SASM	equ	0
