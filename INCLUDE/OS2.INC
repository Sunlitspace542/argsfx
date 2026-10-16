;
; Module Name: OS2.INC
;
; This is the top level include file that includes all the files necessary
; for writing an OS/2 application.
;
; Copyright (c) 1987-1990, Microsoft Corporation.  All rights reserved.
;
;

OS2_INCLUDED    EQU     1

; DEFINED macro to emulate C 'defined' preprocessor operators
DEFINED MACRO   symbol
    IFDEF   symbol
        EXITM <-1>
    ELSE
        EXITM <0>
    ENDIF
ENDM

; Common definitions

IFNDEF  OS2DEF_INCLUDED         ; Only include it once
INCLUDE os2def.inc
ENDIF

; OS/2 Base include file

INCLUDE bse.inc

; OS/2 Presentation Manager include files not implemented for assembler

;IFNDEF  INCL_NOPM
;INCLUDE pm.inc
;ENDIF
