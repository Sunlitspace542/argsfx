; ArgAsm-Super FX (ArgSfx)
; Filename: CALL.ASM
; Purpose: _OS2* system call abstraction routines.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

name CALL ; TODO is CALL included or assembled and linked together w/ ARGSFX?

; Segment type:	Pure code
seg001 segment byte public 'CODE' use16
assume cs:seg001
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

CALL_unref:
	or	ax,ax
	jne	CALL_unref_sub
	clc
	ret
CALL_unref_sub:
	stc
	ret

; START	OF FUNCTION CHUNK FOR _ARGSFX

public _OS2EXIT
_OS2EXIT:
mov	ax, 4C00h
int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
			; AL = exit code

public _OS2EXITERR
_OS2EXITERR:
mov	ax, 4C01h
int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
; END OF FUNCTION CHUNK	FOR _ARGSFX ; AL = exit	code



public _OS2OPENFILE
_OS2OPENFILE proc far
mov	ax, 3D00h
int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
			; DS:DX	-> ASCIZ filename
			; AL = access mode
			; 0 - read
retf
_OS2OPENFILE endp




public _OS2OPENNEWFILE
_OS2OPENNEWFILE	proc far
mov	ax, 3C00h
int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
			; CX = attributes for file
			; DS:DX	-> ASCIZ filename (may include drive and path)
retf
_OS2OPENNEWFILE	endp




sub_CE1E proc far
push	ds
push	dx
mov	ax, 3D01h
int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
			; DS:DX	-> ASCIZ filename
			; AL = access mode
			; 1 - write
pop	dx
pop	ds
jnb	short locret_CE33
xor	bx, bx
mov	ax, 3C00h
mov	cx, 0
int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
			; CX = attributes for file
			; DS:DX	-> ASCIZ filename (may include drive and path)

locret_CE33:
retf
sub_CE1E endp




sub_CE34 proc far
mov	ah, 3Eh
int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
			; BX = file handle
retf
sub_CE34 endp




public _OS2READBYTES
_OS2READBYTES proc far
mov	ah, 3Fh
int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
			; BX = file handle, CX = number	of bytes to read
			; DS:DX	-> buffer
retf
_OS2READBYTES endp




public _OS2WRITEBYTES
_OS2WRITEBYTES proc far
mov	al, ds:13F2h
or	al, al
jz	short loc_CE5A
cmp	bx, 1
jnz	short loc_CE5A
push	bx
push	ds
push	dx
push	cx
mov	bx, ds:13F3h
mov	ah, 40h
int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
			; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
pop	cx
pop	dx
pop	ds
pop	bx

loc_CE5A:
mov	ah, 40h
int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
			; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
retf
_OS2WRITEBYTES endp




sub_CE5F proc far
mov	ax, 4200h
int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
			; AL = method: offset from beginning of	file
retf
sub_CE5F endp




public _OS2SEEKEND
_OS2SEEKEND proc far
mov	ax, 4202h
int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
			; AL = method: offset from end of file
retf
_OS2SEEKEND endp




sub_CE6B proc far
mov	ah, 48h
int	21h		; DOS -	2+ - ALLOCATE MEMORY
			; BX = number of 16-byte paragraphs desired
retf
sub_CE6B endp




sub_CE70 proc far
mov	ah, 49h
int	21h		; DOS -	2+ - FREE MEMORY
			; ES = segment address of area to be freed
retf
sub_CE70 endp




public _OS2AVAILMEM
_OS2AVAILMEM proc far
mov	bx, 0FFFFh
mov	ah, 48h
int	21h		; DOS -	2+ - ALLOCATE MEMORY
			; BX = number of 16-byte paragraphs desired
shr	bx, 6
mov	ax, bx
xor	dx, dx
retf
_OS2AVAILMEM endp




public _OS2GETDATE
_OS2GETDATE proc far
mov	ah, 2Ah
int	21h		; DOS -	GET CURRENT DATE
			; Return: DL = day, DH = month,	CX = year
			; AL = day of the week (0=Sunday, 1=Monday, etc.)
retf
_OS2GETDATE endp




public _OS2GETTIME
_OS2GETTIME proc far
mov	ah, 2Ch
int	21h		; DOS -	GET CURRENT TIME
			; Return: CH = hours, CL = minutes, DH = seconds
			; DL = hundredths of seconds
retf
_OS2GETTIME endp




public _OS2PRTSTRING
_OS2PRTSTRING proc far
push	cx
xor	cx, cx
push	si
mov	si, dx

loc_CE94:
lodsb
inc	cx
cmp	al, 24h	; '$'
jnz	short loc_CE94
dec	cx
pop	si
mov	ah, 40h	; '@'
mov	bx, 1
call	_OS2WRITEBYTES
pop	cx
retf
_OS2PRTSTRING endp



; Stub function used in the OS/2 version
public _OS2INITTERM
_OS2INITTERM proc far
; The OS/2 version does this:
	; PUSH	DX
	; BX
	; SS
	; PUSH	73e6h
	; PUSH	SS
	; PUSH	73eah
	; PUSH	2h
	; PUSH	1h
	; CALLF	DOSCALLS::Ordinal_14

	; PUSH	DX
	; PUSH	BX
	; PUSH	SS
	; PUSH	73e6h
	; PUSH	SS
	; PUSH	73eah
	; PUSH	2h
	; PUSH	4h
	; CALLF	DOSCALLS::Ordinal_14
retf
_OS2INITTERM endp




public _OS2RENAMEFILE
_OS2RENAMEFILE proc far
mov	ah, 56h
int	21h		; DOS -	2+ - RENAME A FILE
			; DS:DX	-> ASCIZ old name (drive and path allowed, no wildcards)
			; ES:DI	-> ASCIZ new name
retf
_OS2RENAMEFILE endp




public _OS2DELETEFILE
_OS2DELETEFILE proc far
mov	ah, 41h
int	21h		; DOS -	2+ - DELETE A FILE (UNLINK)
			; DS:DX	-> ASCIZ pathname of file to delete (no	wildcards allowed)
retf
_OS2DELETEFILE endp

;align 10h
seg001 ends
