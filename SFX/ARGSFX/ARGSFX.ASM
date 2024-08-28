.386
.model large


; Segment type:	Pure code
; Main assembler logic
seg000 segment byte public 'CODE' use16
assume cs:seg000
assume es:nothing, ss:seg000, ds:nothing, fs:nothing, gs:nothing



public _ARGSFX

_ARGSFX proc near
	cld
	mov	cx,8AC9h
	mov	ss,cx
	assume ss:seg003
	mov	word	ptr	ss:[9BDEh],ds
	mov	word	ptr	ss:[9BE0h],0080h
	mov	dx,seg000
	mov	bx,0052h
	call	far	ptr	_OS2INITTERM ; ArgSfx OS/2 leftover
	if	0
	call	GETMEM
	call	ADD_ASSEMVARS
	call	PARSECLI
	call	OPEN_MAP_FILE
	call	ASSEMBLE
	call	EVAL_FRS
	call	LINK
	call	WRITESYMBOLS
	call	GEN_MAP_SYMBOLS
	call	DO_END
	endif

OVERRET:
	mov	ax,word	ptr	[13C4h]
	or	ax,ax
	if	0
	jne	loc_48
	jmp	far	ptr	_OS2EXIT
loc_48:
	jmp	far	ptr	_OS2EXITERR
	endif
_ARGSFX endp

STOPASSEM:
	if	0
	call	DO_END
	endif
	jmp	OVERRET
CTRLCHAN:
	push	ds
	push	dx
	mov	dx, seg	seg003
	mov	ds,dx
	assume ds:seg003
	mov	dx,8A14h
	call	far	ptr	_OS2PRTSTRING
	pop	dx
	pop	ds
	assume ds:nothing
	jmp	far	ptr	_OS2EXITERR

LINK proc near
	mov	al,byte	ptr	[13A0h]
	or	al,al
	jne	DOLINK
	ret
DOLINK:
	mov	ax,word	ptr	[13C4h]
	or	ax,ax
	je	DOLINK2
	ret
DOLINK2:
	push	ds
	push	dx
	mov	dx, seg	seg003
	mov	ds,dx
	assume ds:seg003
	mov	dx,89FCh
	call	far	ptr	_OS2PRTSTRING
	pop	dx
	pop	ds
	assume ds:nothing
	push	ds
	push	dx
	push	si
	push	ax
	mov	bx, seg	seg003
	mov	dx,9B1Ch
	mov	ds,bx
	assume ds:seg003
	mov	si,dx

loc_99:
	lodsb
	or	al,al
	jne	loc_99
	mov	byte	ptr	[si-1],24h
	call	far	ptr	_OS2PRTSTRING
	mov	byte	ptr	[si-1],00h
	pop	ax
	pop	si
	pop	dx
	pop	ds
	assume ds:nothing
	mov	bx,0800h
	call	far	ptr	_OS2ALLOCSEG
	jae	LBUFOK
	push	dx
	mov	dx,8535h
	if	0
	call	ERROR_ROUT
	endif
	pop	dx
LBUFOK:

LINK endp

seg000 ends

; Segment type:	Pure code
; Functions dealing with I/O
seg001 segment byte public 'CODE' use16
assume cs:seg001
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

;TODO find out if this is either a separate function or part of CSY6
unkfunc1:
	or	ax,ax
	jne	unkfunc1_sub
	clc
	ret
unkfunc1_sub:
	stc
	ret

; These exit functions might be far? not sure
_OS2EXIT proc far
mov	ax,4C00h
int	21h
_OS2EXIT endp

_OS2EXITERR proc far
mov	ax,4C01h
int	21h
_OS2EXITERR endp

; IDA labels the rest as far so we'll do the same
_OS2OPENFILE proc far
mov	ax,3D00h
int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
			; DS:DX	-> ASCIZ filename
			; AL = access mode
			; 0 - read
retf
_OS2OPENFILE endp

_OS2OPENNEWFILE proc far
mov	ax,3C00h
int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
			; CX = attributes for file
			; DS:DX	-> ASCIZ filename (may include drive and path)
retf
_OS2OPENNEWFILE endp


_OS2OPENAPPENDFILE proc far
push	ds
push	dx
mov	ax,3D01h
int	21h
pop	dx
pop	ds
jae	locret_CE33
xor	bx,bx
mov	ax,3C00h
mov	cx,0000h
int	21h

locret_CE33:
retf
_OS2OPENAPPENDFILE endp

_OS2CLOSEFILE proc far
mov	ah,3Eh
int	21h		; DOS -	2+ - CLOSE A FILE WITH HANDLE
			; BX = file handle
_OS2CLOSEFILE endp

_OS2READBYTES proc far
mov	ah,3Fh
int	21h		; DOS -	2+ - READ FROM FILE WITH HANDLE
			; BX = file handle, CX = number	of bytes to read
			; DS:DX	-> buffer
retf
_OS2READBYTES endp

_OS2WRITEBYTES proc far
mov	al,byte	ptr	[13F2h]
or	al,al
je	loc_CE5A
cmp	bx,01h
jne	loc_CE5A
push	bx
push	ds
push	dx
push	cx
mov	bx,word	ptr	[13F3h]
mov	ah,40h
int	21h		; DOS -	2+ - WRITE TO FILE WITH	HANDLE
			; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
pop	cx
pop	dx
pop	ds
pop	bx

loc_CE5A:
mov	ah,40h
int	21h
retf
_OS2WRITEBYTES endp

_OS2SEEKFILE proc far
mov	ax,4200h
int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
			; AL = method: offset from beginning of	file
retf
_OS2SEEKFILE endp

_OS2SEEKEND proc far
mov	ax,4202h
int	21h		; DOS -	2+ - MOVE FILE READ/WRITE POINTER (LSEEK)
			; AL = method: offset from end of file
retf
_OS2SEEKEND endp

_OS2ALLOCSEG proc far
mov	ah,48h
int	21h		; DOS -	2+ - ALLOCATE MEMORY
			; BX = number of 16-byte paragraphs desired
retf
_OS2ALLOCSEG endp

_OS2FREESEG proc far
mov	ah,49h
int	21h		; DOS -	2+ - FREE MEMORY
			; ES = segment address of area to be freed
retf
_OS2FREESEG endp


_OS2AVAILMEM proc far
mov	bx,0FFFFh
mov	ah,48h
int	21h		; DOS -	2+ - ALLOCATE MEMORY
			; BX = number of 16-byte paragraphs desired
shr	bx,06h
mov	ax,bx
xor	dx,dx
retf
_OS2AVAILMEM endp

_OS2GETDATE proc far
mov	ah,2Ah
int	21h		; DOS -	GET CURRENT DATE
			; Return: DL = day, DH = month,	CX = year
			; AL = day of the week (0=Sunday, 1=Monday, etc.)
retf
_OS2GETDATE endp

_OS2GETTIME proc far
mov	ah,2Ch
int	21h		; DOS -	GET CURRENT TIME
			; Return: CH = hours, CL = minutes, DH = seconds
			; DL = hundredths of seconds
retf
_OS2GETTIME endp

_OS2PRTSTRING proc far
push	cx
xor	cx,cx
push	si
mov	si,dx

loc_CE94:
lodsb
inc	cx
cmp	al,24h
jne	loc_CE94
dec	cx
pop	si
mov	ah,40h
mov	bx,0001h
call	far	ptr	_OS2WRITEBYTES
pop	cx
retf
_OS2PRTSTRING endp

; Stub function used in the OS/2 version
_OS2INITTERM	proc far
retf
_OS2INITTERM	endp

_OS2RENAMEFILE proc far
mov	ah,56h
int	21h		; DOS -	2+ - RENAME A FILE
			; DS:DX	-> ASCIZ old name (drive and path allowed, no wildcards)
			; ES:DI	-> ASCIZ new name
retf
_OS2RENAMEFILE endp

_OS2DELETEFILE proc far
mov	ah,41h
int	21h		; DOS -	2+ - DELETE A FILE (UNLINK)
			; DS:DX	-> ASCIZ pathname of file to delete (no	wildcards allowed)
retf
_OS2DELETEFILE endp

seg001 ends

; Segment type:	Regular
seg002 segment byte public 'DATA' use16
assume cs:seg002
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing


seg002 ends

; Segment type:	Regular
seg003 segment byte public 'DATA' use16
assume cs:seg003
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing


seg003 ends

end