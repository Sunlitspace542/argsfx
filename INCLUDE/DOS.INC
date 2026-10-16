; DOS Interface Macros - Version 1.2 - for Microsoft Macro Assembler 6.0
; (C) Copyright Microsoft Corporation, 1987, 1988, 1989, 1990

; Typedefs for testing pointers
NPVOID  TYPEDEF NEAR PTR
FPVOID  TYPEDEF FAR  PTR

; Internal
__LdAdr MACRO reg:REQ, adr:REQ
    IF (OPATTR (adr)) AND 00010000y
        mov     reg, adr               ;; Register
    ELSEIF (OPATTR (adr)) AND 00000100y
        mov     reg, adr               ;; Constant
    ELSEIF (TYPE (adr) EQ BYTE)  OR (TYPE (adr) EQ SBYTE)
        mov    reg, OFFSET adr         ;; Bytes
    ELSEIF (TYPE (adr) EQ NPVOID) OR (TYPE (adr) EQ WORD)
        mov    reg, adr                ;; Near pointer
    ELSEIF (TYPE (adr) EQ FPVOID) OR (TYPE (adr) EQ DWORD)
        mov    reg, WORD PTR adr[0]    ;; Far pointer
        mov    ds,  WORD PTR adr[2]
    ELSE
        .ERR <Illegal argument>
    ENDIF
ENDM


; Internal
__LdSeg MACRO dest:REQ, src:REQ
    IFIDNI <src>, <es>                 ;; Segment register
        mov     ax, src
        mov     dest, ax
    ELSEIFIDNI <src>, <ss>
        mov     ax, src
        mov     dest, ax
    ELSEIFIDNI <src>, <ds>
        mov     ax, src
        mov     dest, ax
    ELSEIFIDNI <src>, <cs>
        mov     ax, src
        mov     dest, ax
    ELSEIF (OPATTR (src)) AND 00000100y ;; Constant
        mov     ax, src
        mov     dest, ax
    ELSE                                ;; Memory or general register
        mov     dest, src
    ENDIF
ENDM

; Internal
__LdDub MACRO dub:REQ
    IF ((OPATTR (dub)) AND 00000100y)
        IF ((dub) LE 0FFFFh)
             sub  cx, cx
             mov  dx, dub
        ELSE
             sub  cx, HIGWORD dub
             mov  dx, LOWWORD dub
        ENDIF
    ELSEIF   TYPE (dub) EQ 2
        sub  cx, cx
        mov  dx, dub
    ELSEIF TYPE (dub) EQ 4
        mov  cx, dub[2]
        mov  dx, dub[0]
    ELSEIF TYPE (dub) EQ 0
        sub     cx, cx
        mov     dx, dub
    ELSE
        .ERR
        ECHO Illegal argument
    ENDIF
ENDM

; 01h, 07h, 08h, 0Ch
@GetChar MACRO ech:=<1>, cc:=<1>, clear:=<0>
    LOCAL   funct, disp
    disp    = 1
    IF  ech
        IF  cc
            funct   = 01h       ;; Echo with break checking
        ELSE
            funct   = 07h       ;; Echo without break checking
            disp    = 02h       ;; Need separate call to echo
        ENDIF
    ELSE
        IF  cc
            funct   = 08h       ;; No echo with break checking
        ELSE
            funct   = 07h       ;; No echo without break checking
        ENDIF
    ENDIF
    IFE clear
        mov     ah, funct       ;; Load function directly
    ELSE
        mov     ah, 0Ch         ;; If clear set, call function
        mov     al, funct       ;;  indirectly with function 0Ch
    ENDIF
    int     21h                 ;; Call DOS
    IF disp EQ 02h              ;; Separate call for echo without
        mov     dl, al          ;;  break checking
        mov     ah, disp
        int     21h
    ENDIF
ENDM

; 0Ah
@GetStr MACRO ofset:REQ, terminator, limit, segmnt
    __LdAdr dx, <ofset>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 0Ah
    mov     si, dx
    IFNB    <limit>
        mov     BYTE PTR [si], limit
    ENDIF
    int     21h
    inc     si
    mov     bl, [si]
    sub     bh, bh
    inc     si
    IFNB    <terminator>
        mov     BYTE PTR [bx+si], terminator
    ENDIF
ENDM

; 02h
@ShowChar MACRO chr:VARARG
    mov     ah, 02h
    FOR arg, <chr>
        IFDIFI  <arg>, <dl>
            mov     dl, arg
        ENDIF
        int     21h
    ENDM
ENDM

; 05h
@PrtChar MACRO chr:VARARG
    mov     ah, 05h
    FOR arg, <chr>
        IFDIFI  <arg>, <dl>
            mov     dl, arg
        ENDIF
        int     21h
    ENDM
ENDM

; 09h
@ShowStr MACRO ofset:REQ, segmnt
    LOCAL  msg, sseg
    IF @InStr( 1, ofset, <!"> ) EQ 1
        sseg    TEXTEQU @CurSeg
        .DATA
        msg     BYTE    ofset, "$"
        sseg    SEGMENT
        mov     dx, OFFSET msg
    ELSE
        __LdAdr dx, ofset
        IFNB    <segmnt>
            __LdSeg ds, <segmnt>
        ENDIF
    ENDIF
    mov     ah, 9
    int     21h
ENDM

; 3Fh
@Read MACRO ofset:REQ, bytes:REQ, handle:=<0>, segmnt
    IFDIF   <handle>, <0>
        mov     bx, handle
    ELSE
        sub     bx, bx
    ENDIF
    mov     cx, bytes
    __LdAdr dx, <ofset>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 3Fh
    int     21h
ENDM

; 40h
@Write MACRO ofset:REQ, bytes:REQ, handle:=<1>, segmnt
    mov     bx, handle
    mov     cx, bytes
    __LdAdr dx, <ofset>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 40h
    int     21h
ENDM

; 3Ch, 5Ah, 5Bh
@MakeFile MACRO path:REQ, atrib:=<0>, segmnt, kind
    IFDIF   <atrib>, <0>
        mov     cx, atrib
    ELSE
        sub     cx, cx
    ENDIF
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    IFIDNI  <kind>, <tmp>
        mov     ah, 5Ah
    ELSEIFIDNI <kind>, <new>
        mov    ah, 5Bh
    ELSE
        mov    ah, 3Ch
    ENDIF
    int     21h
ENDM

; 3Dh
@OpenFile MACRO path:REQ, access:=<0>, segmnt
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ax, 3D00h + (access AND 0FFh)
    int     21h
ENDM

; 3Eh
@CloseFile MACRO handle:REQ
    mov     bx, handle
    mov     ah, 3Eh
    int     21h
ENDM

; 41h
@DelFile MACRO path:REQ, segmnt
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 41h
    int     21h
ENDM

; 56h
@MoveFile MACRO old:REQ, new:REQ, segold, segnew
    __LdAdr dx, <old>
    __LdAdr di, <new>
    IFNB    <segold>
        __LdSeg ds, <segold>
    ENDIF
    IFNB    <segnew>
        __LdSeg es, <segnew>
    ENDIF
    mov     ah, 56h
    int     21h
ENDM


;* File information returned from GetFirst procedure
FILE_INFO       STRUCT
  pad           BYTE    21 DUP (?)      ; pad to 43 bytes
  Attrib        BYTE    ?               ; file attribute
  Time          WORD    ?               ; file time
  Date          WORD    ?               ; file date
  Len           DWORD   ?               ; file size
  FName         BYTE    13 DUP (?)      ; file name
FILE_INFO       ENDS

; 4Eh
@GetFirst MACRO path:REQ, atrib, segmnt
    IFNB    <atrib>
        mov     cx, atrib
    ELSE
        sub     cx, cx
    ENDIF
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 4Eh
    int     21h
ENDM


; 4Fh
@GetNext MACRO
    mov     ah, 4Fh
    int     21h
ENDM

; 2Fh
@GetDTA MACRO
    mov     ah, 2Fh
    int     21h
ENDM

; 1Ah
@SetDTA MACRO buffer:REQ, segmnt
    __LdAdr dx, <buffer>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 1Ah
    int     21h
ENDM

; 42h
@GetFileSize MACRO handle:REQ
    mov     bx, handle
    sub     cx, cx
    sub     dx, dx
    mov     ax, 4202h
    int     21h
    push    dx
    push    ax
    sub     dx, dx
    mov     ax, 4200h
    int     21h
    pop     ax
    pop     dx
ENDM

; 42h
@MovePtrAbs MACRO handle:REQ, distance
    IFNB    <distance>
        __LdDub <distance>
    ENDIF
    mov     bx, handle
    mov     ax, 4200h
    int     21h
ENDM

; 42h
@MovePtrRel MACRO handle:REQ, distance
    IFNB    <distance>
        __LdDub <distance>
    ENDIF
    mov     bx, handle
    mov     ax, 4201h
    int     21h
ENDM

; 39h
@MkDir MACRO path:REQ, segmnt
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 39h
    int     21h
ENDM

; 3Ah
@RmDir MACRO path:REQ, segmnt
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 3Ah
    int     21h
ENDM

; 3Bh
@ChDir MACRO path:REQ, segmnt
    __LdAdr dx, <path>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 3Bh
    int     21h
ENDM

; 47h
@GetDir MACRO buffer:REQ, drive, segmnt
    IFNB    <drive>
        mov     dl, drive
    ELSE
        sub     dl, dl
    ENDIF
    __LdAdr si, <buffer>
    IFNB    <segmnt>
        __LdSeg ds, <segmnt>
    ENDIF
    mov     ah, 47h
    int     21h
ENDM

; 19h
@GetDrv MACRO
    mov     ah, 19h
    int     21h
ENDM

; 0Eh
@SetDrv MACRO drive:REQ
    mov     dl, drive
    mov     ah, 0Eh
    int     21h
ENDM

; 1Ch
@ChkDrv MACRO drive
    IFNB    <drive>
        mov     dl, drive
    ELSE
        sub     dl, dl
    ENDIF
    mov     ah, 1Ch
    int     21h
ENDM

; 4Ch
@Exit MACRO return
    IFB     <return>
        mov     ah, 4Ch
    ELSE
        mov     ax, 4C00h + (return AND 0FFh)
    ENDIF
    int     21h
ENDM

; 31h
@TSR MACRO paragraphs:REQ, return
    mov     dx, paragraphs
    IFB     <return>
        mov     ah, 31h
    ELSE
        mov     ax, 3100h + (return AND 0FFh)
    ENDIF
    int     21h
ENDM

; 49h
@FreeBlock MACRO segmnt
    IFNB    <segmnt>
        __LdSeg es, <segmnt>
    ENDIF
    mov     ah, 49h
    int     21h
ENDM

; 48h
@GetBlock MACRO graphs:REQ, retry:=<0>
    LOCAL   tryit
    mov     bx, graphs
    tryit:  mov     ah, 48h
    int     21h

    IF	    retry
	jc  tryit
    ENDIF
ENDM

; 4Ah
@ModBlock MACRO graphs:REQ, segmnt
    IFNB    <segmnt>
        __LdSeg es, <segmnt>
    ENDIF
    mov     bx, graphs
    mov     ah, 4Ah
    int     21h
ENDM

; 2Ah
@GetDate MACRO
    mov     ah, 2Ah
    int     21h
ENDM

; 2Bh
@SetDate MACRO month:REQ, day:REQ, year:REQ
    mov     cx, year
    mov     dh, month
    mov     dl, day
    mov     ah, 2Bh
    int     21h
ENDM

; 2Ch
@GetTime MACRO
    mov     ah, 2Ch
    int     21h
ENDM

; 2Dh
@SetTime MACRO hour:REQ, minutes:REQ, seconds:REQ, hundredths:REQ
    mov     ch, hour
    mov     cl, minutes
    mov     dh, seconds
    mov     dl, hundredths
    mov     ah, 2Dh
    int     21h
ENDM

; 30h
@GetVer MACRO
    mov     ah, 30h
    int     21h
ENDM

; 35h
@GetInt MACRO   interrupt:REQ
    mov     ax, 3500h + (interrupt AND 0FFh)
    int     21h
ENDM

; 25h
@SetInt MACRO interrupt:REQ, vector:REQ, segmnt
    IF  (TYPE (vector) EQ NPVOID) OR (TYPE (vector) EQ FPVOID)
        mov     dx, OFFSET vector
        mov     ax, SEG vector
        mov     ds, ax
    ELSE
        __LdAdr dx, <vector>
        IFNB    <segmnt>
            __LdSeg ds, <segmnt>
        ENDIF
    ENDIF
    mov     ax, 2500h + (interrupt AND 0FFh)
    int     21h
ENDM
