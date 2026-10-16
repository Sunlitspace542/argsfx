;
; Module Name: BSE.INC
;
; This file includes the definitions necessary for writing Base OS/2
; applications.
;
; Copyright (c) 1987-1990, Microsoft Corporation.  All rights reserved.
;
; ===========================================================================
;
; The following symbols are used in this file for conditional sections.
;
;   INCL_BASE        -  ALL of OS/2 Base
;   INCL_DOS         -  OS/2 DOS Kernel
;   INCL_SUB         -  OS/2 VIO/KBD/MOU
;   INCL_DOSERRORS   -  OS/2 Errors - only included if symbol defined
;   INCL_DOSDEVIOCTL - Structures and constants for DosDevIOCtl
;

INCL_BASEINCLUDED       EQU     1

; If INCL_BASE defined then define all the symbols
IFDEF  INCL_BASE
INCL_DOS                EQU     1
INCL_SUB                EQU     1
INCL_DOSERRORS          EQU     1
INCL_DOSDEVICES         EQU     1
INCL_DOSDEVIOCTL        EQU     1
ENDIF

INCLUDE bsedos.inc      ; Base definitions

IFNDEF  BSESUB_INCLUDED ; Only include it once
INCLUDE bsesub.inc      ; VIO/KBD/MOU definitions
ENDIF

IFNDEF  BSEERR_INCLUDED ; Only include it once
INCLUDE bseerr.inc      ; Base error code definitions
ENDIF

IF DEFINED( INCL_DOSDEVICES ) OR DEFINED( INCL_DOSDEVIOCTL )
IFNDEF  BSEDEV_INCLUDED ; Only include it once
INCLUDE bsedev.inc      ; IOCtls
ENDIF
ENDIF
