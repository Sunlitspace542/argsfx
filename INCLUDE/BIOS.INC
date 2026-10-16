; BIOS Interface Macros - Version 1.2 - for Microsoft Macro Assembler 6.0
; (C) Copyright Microsoft Corporation, 1987,1988,1989,1990

; 0Fh
@GetMode MACRO
    mov   ah, 0Fh
    int   10h
ENDM

; 00h
@SetMode MACRO mode
    mov   al, mode
    xor   ah, ah
    int   10h
ENDM

; 0Bh
@SetColor MACRO color
    sub   bh, bh
    mov   bl, color
    mov   ah, 0Bh
    int   10h
ENDM

; 0Bh
@SetPalette MACRO color
    mov   bh, 1
    mov   bl, color
    mov   ah, 0Bh
    int   10h
ENDM

; 05h
@SetPage MACRO pagenum
    mov   al, pagenum
    mov   ah, 05h
    int   10h
ENDM

; 03h
@GetCsr MACRO pagenum
    IFNB <pagenum>
        mov   bh, pagenum
    ELSE
        xor   bh, bh
    ENDIF
    mov   ah, 03h
    int   10h
ENDM

; 02h
@SetCsrPos MACRO column, row, pagenum
    IFNB <column>
        mov   dl, column
    ENDIF
    IFNB <row>
        mov   dh, row
    ENDIF
    IFNB <pagenum>
        mov   bh, pagenum
    ELSE
        xor   bh, bh
    ENDIF
    mov   ah, 02h
    int   10h
ENDM

; 01h
@SetCsrSize MACRO first, last
    mov   ch, first
    mov   cl, last
    mov   ah, 01h
    int   10h
ENDM

; 08h
@GetCharAtr MACRO pagenum
    IFNB <pagenum>
        mov   bh, pagenum
    ELSE
        sub   bh, bh
    ENDIF
    mov   ah, 08h
    int   10h
ENDM

; 09h
@PutCharAtr MACRO chr, atrib, pagenum, loops
    IFNB <chr>
        mov   al, chr
    ENDIF
    IFNB    <atrib>
        mov   bl, atrib
    ENDIF
    IFNB <pagenum>
        mov   bh, pagenum
    ELSE
        xor   bh, bh
    ENDIF
    IFNB <loops>
        mov   cx, loops
    ELSE
        mov   cx, 1
    ENDIF
    mov   ah, 09h
    int   10h
ENDM

; 0Ah
@PutChar MACRO chr, atrib, pagenum, loops
    IFNB <chr>
        mov   al, chr
    ENDIF
    IFNB    <atrib>
        mov   bl, atrib
    ENDIF
    IFNB <pagenum>
        mov   bh, pagenum
    ELSE
        xor   bh, bh
    ENDIF
    IFNB <loops>
        mov   cx, loops
    ELSE
        mov   cx, 1
    ENDIF
    mov   ah, 0Ah
    int   10h
ENDM

; 06h and 07h
@Scroll MACRO distance:REQ, atrib:=<07h>, upcol, uprow, dncol, dnrow
    IFNB <upcol>
        mov   cl, upcol
    ENDIF
    IFNB <uprow>
        mov   ch, uprow
    ENDIF
    IFNB <dncol>
        mov   dl, dncol
    ENDIF
    IFNB <dnrow>
        mov   dh, dnrow
    ENDIF
    mov   bh, atrib
    IF distance LE 0
        mov   ax, 0600h + (-(distance) AND 0FFh)
    ELSE
        mov   ax, 0700h + (distance AND 0FFh)
    ENDIF
    int   10h
ENDM

; 08h, 06h, and	02h
@Cls MACRO pagenum
    IFNB <pagenum>
        IFDIFI <pagenum>, <bh>
            mov   bh, pagenum
        ENDIF
    ELSE
        sub   bh, bh
    ENDIF
    mov   ah, 08h
    int   10h
    mov   bh, ah
    sub   cx, cx
    mov   dx, 324Fh
    mov   ax, 0600h
    int   10h
    mov   bh, bl
    sub   dx, dx
    mov   ah, 02h
    int   10h
ENDM
