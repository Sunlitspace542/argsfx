;
; Module Name: OS2DEF.INC
;
; OS/2 Common Definitions file
;
; Copyright (c) 1987-1990, Microsoft Corporation.  All rights reserved.
;

OS2DEF_INCLUDED EQU             1

SHANDLE         TYPEDEF         WORD
LHANDLE         TYPEDEF         FAR PTR

EXPENTRY        TEXTEQU         <EXPORT PASCAL>
APIENTRY        TEXTEQU         <FAR PASCAL>

;  Backwards compatability with 1.1
CALLBACK        TEXTEQU         <EXPORT PASCAL !<LOADDS!>> ;??

CHAR            TYPEDEF         SBYTE   ; ch
; In C, this type is called SHORT, but SHORT is a keyword in assembler
SSHORT          TYPEDEF         SWORD   ; s
LONG            TYPEDEF         SDWORD  ; l
IFNDEF INCL_SAADEFS
; In C, this type is called INT, but INT is a keyword in assembler
IF (@WordSize EQ 2)
INTEGER         TYPEDEF         SWORD   ; i
ELSE
INTEGER         TYPEDEF         SDWORD  ; i
ENDIF ; @WordSize
ENDIF ; INCL_SAADEFS

UCHAR           TYPEDEF         BYTE    ; uch
USHORT          TYPEDEF         WORD    ; us
ULONG           TYPEDEF         DWORD   ; ul
IFNDEF INCL_SAADEFS
IF (@WordSize EQ 2)
UINTEGER        TYPEDEF         WORD    ; ui
ELSE
UINTEGER        TYPEDEF         DWORD   ; ui
ENDIF ; @WordSize
ENDIF ; INCL_SAADEFS
;BYTE already defined for assembler     ; b

; NULL pointer value
NULL            EQU             0

PSZ		TYPEDEF		FAR PTR BYTE
NPSZ		TYPEDEF		NEAR PTR BYTE

PCH		TYPEDEF		FAR PTR BYTE
NPCH		TYPEDEF		NEAR PTR BYTE

;???

PF              TYPEDEF         PROTO FAR PASCAL
PFN             TYPEDEF         PTR PF

NPF             TYPEDEF         PROTO NEAR PASCAL
NPFN            TYPEDEF         PTR NPF

PPFN            TYPEDEF         FAR PTR PFN

PBYTE		TYPEDEF		FAR PTR BYTE
NPBYTE		TYPEDEF		NEAR PTR BYTE

PCHAR           TYPEDEF         FAR PTR CHAR
PSBYTE          TYPEDEF         FAR PTR SBYTE
PSSHORT         TYPEDEF         FAR PTR SSHORT
PSWORD          TYPEDEF         FAR PTR SWORD
PLONG           TYPEDEF         FAR PTR LONG
PSDWORD         TYPEDEF         FAR PTR SDWORD
IFNDEF INCL_SAADEFS
PINTEGER        TYPEDEF         FAR PTR INTEGER
ENDIF ; INCL_SAADEFS

PUCHAR          TYPEDEF         FAR PTR UCHAR
PUSHORT         TYPEDEF         FAR PTR USHORT
PWORD           TYPEDEF         FAR PTR WORD
PULONG          TYPEDEF         FAR PTR ULONG
PDWORD          TYPEDEF         FAR PTR DWORD
IFNDEF INCL_SAADEFS
PUINTEGER       TYPEDEF         FAR PTR UINTEGER
ENDIF ; INCL_SAADEFS

PVOID           TYPEDEF         FAR PTR

BOOL            TYPEDEF         WORD    ; f
PBOOL           TYPEDEF         FAR PTR BOOL

IFNDEF TRUE
TRUE            EQU             1
ENDIF

IFNDEF FALSE
FALSE           EQU             0
ENDIF

HFILE   TYPEDEF WORD    ; hf
PHFILE  TYPEDEF FAR PTR HFILE

IFNDEF INCL_SAADEFS
SEL             TYPEDEF         WORD    ; sel
PSEL            TYPEDEF         FAR PTR SEL
ENDIF  ; INCL_SAADEFS

;comment ^
; Useful Helper Macros

; Create untyped far pointer from selector and offset
MAKEP   MACRO   sel, off, nam
        .DATA
nam     PVOID   ?
        .CODE
        mov     ax, off
        mov     nam[2], ax
        mov     ax, sel
        mov     nam[0], ax
ENDM


; Extract selector or offset from far pointer
SELECTOROF      MACRO   p
        EXITM   <NPVOID PTR p[0]>
ENDM

OFFSETOF        MACRO   p
        EXITM   <NPVOID PTR p[2]>
ENDM

; Combine l and h to form a 32 bit quantity. Both must be constants.
MAKEULONG  MACRO l, h
    EXITM <(LOWWORD l) OR ((LOWWORD h) SHL 16)>
ENDM

; Combine l & h to form a 16 bit quantity. Both must be constants.
MAKEUSHORT MACRO l, h
    EXITM <(LOW l) OR ((LOW h) SHL 8)>
ENDM

; ** Common Error definitions **
ERRORID         TYPEDEF         DWORD   ; errid
PERRORID        TYPEDEF         FAR PTR ERRORID

; Combine severity and error code to produce ERRORID
MAKEERRORID     MACRO sev, error
        EXITM   %MAKEULONG( (error), (sev) )
ENDM

; Extract error number from an errorid
ERRORIDERROR    MACRO errid
        EXITM   <LOWWORD (errid)>
ENDM

; Extract severity from an errorid
ERRORIDSEV      MACRO errid
        EXITM   <HIGHWORD (errid)>
ENDM

;  Severity codes
SEVERITY_NOERROR        EQU     0000h
SEVERITY_WARNING        EQU     0004h
SEVERITY_ERROR          EQU     0008h
SEVERITY_SEVERE         EQU     000Ch
SEVERITY_UNRECOVERABLE  EQU     0010h

;  Base component error values
WINERR_BASE             EQU     1000h   ; Window Manager
GPIERR_BASE             EQU     2000h   ; Graphics Presentation Interface
DEVERR_BASE             EQU     3000h   ; Device Manager
SPLERR_BASE             EQU     4000h   ; Spooler

; ** Common types used across components

; ** Common DOS types
HMODULE         TYPEDEF         WORD    ; hmod
PHMODULE        TYPEDEF         FAR PTR HMODULE

IFNDEF INCL_SAADEFS
PID             TYPEDEF         WORD    ; pid
PPID            TYPEDEF         FAR PTR PID

TID             TYPEDEF         WORD    ; tid
PTID            TYPEDEF         FAR PTR TID

HSEM            TYPEDEF         FAR PTR ; hsem
PHSEM           TYPEDEF         FAR PTR HSEM
ENDIF ; INCL_SAADEFS
