; ArgAsm-Super FX (ArgSfx)
; Filename: ARGSFX.ASM
; Purpose: Main assembler module.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

include	defines.inc
include	macros.inc

.386
.model large
.stack ; fixes no stack segment error, probably not accurate


; Segment type:	Pure code
; Main assembler logic
seg000 segment byte public 'CODE' use16
assume cs:seg000
assume es:nothing, ss:seg000, ds:nothing, fs:nothing, gs:nothing



public _ARGSFX
_ARGSFX proc near
	cld
	mov	cx, seg	seg003
	mov	ss,cx
	assume ss:seg003
	mov	ss:word_1AA9E, ds
	mov	ss:word_1AAA0, 80h ; '�'
	mov	dx, seg	seg000
	mov	bx,0052h
	call	far	ptr	_OS2INITTERM ; ArgSfx OS/2 leftover
	if	UNIMPLEMENTED_ROUTINES
	call	GETMEM
	call	ADD_ASSEMVARS
	call	PARSECLI
	call	OPEN_MAP_FILE
	call	ASSEMBLE
	call	EVAL_FRS
	endif
	call	LINK
	if	UNIMPLEMENTED_ROUTINES
	call	WRITESYMBOLS
	call	GEN_MAP_SYMBOLS
	call	DO_END
	endif

OVERRET:
	mov	ax, ss:word_12284
	or	ax,ax
	if	UNIMPLEMENTED_ROUTINES
	jne	loc_48
	jmp	far	ptr	_OS2EXIT
loc_48:
	jmp	far	ptr	_OS2EXITERR
	endif
_ARGSFX endp

STOPASSEM:
	if	UNIMPLEMENTED_ROUTINES
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
	mov	al, ss:byte_12260
	or	al,al
	jne	DOLINK
	ret
DOLINK:
	mov	ax, ss:word_12284
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
	mov	byte	ptr	[si-1],24h ; '$'
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
	if	UNIMPLEMENTED_ROUTINES
	call	ERROR_ROUT
	endif
	pop	dx
LBUFOK:
	mov	ss:word_1A942, ax
	mov	ax,ss
	mov	ds,ax
	assume ds:seg003
	mov	dx,9B1Ch
	xor	cx,cx
	call	far	ptr	_OS2OPENNEWFILE
	mov	ss:word_11D9D, ax
	jae	LDISKOK
	if	UNIMPLEMENTED_ROUTINES
	call	NEEDCR
	endif
	push	ds
	push	dx
	mov	dx, seg	seg003
	mov	ds,dx
	mov	dx,891Ch
	call	far	ptr	_OS2PRTSTRING
	pop	dx
	pop	ds
	assume ds:nothing
	ret
LDISKOK:
	mov	ss:byte_13358, 1
	mov	ss:byte_1227A, 4
	mov	es, ss:word_1A942
	xor	di,di
	mov	ax,4F53h
	stosw
	mov	ax,4A42h
	stosw
	mov	ax,0101h
	stosw
	xor	ax,ax
	stosw
	mov	ds, ss:word_1A942
	xor	dx,dx
	mov	cx,0008h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	call	WRITEBLOCKS
	call	WRITEPUBLICS
	call	WRITEEXTERNS
	xor	cx,cx
	mov	dx,0006h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2SEEKFILE
	mov	ax,ss
	mov	ds,ax
	assume ds:seg003
	mov	dx,13A2h
	mov	cx,0002h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2CLOSEFILE
	ret
LINK endp

	mov	ds, ss:word_11D99
	assume ds:nothing
	xor	dx, dx
	mov	cx, ss:word_11D9B
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	ret

WRITEEXTERNS	proc near
	mov	ax, ss:word_1226A
	or	ax, ax
	jne	WEDO
	ret
WEDO:
	mov	ds, ss:word_12264
	mov	si,0002
	xor	di,di
WELP:
	xor	cx,cx
	push	si
	add	si,02
	lodsw
	jmp	WELP3
WELP2:
	lodsw
	or	ax,ax
	if	UNIMPLEMENTED_ROUTINES
	je	WEENDEXP
	endif
WELP3:
	test	al,80
	je	WENOTLAB
	mov	es,word	ptr	[si]
	mov	bp,word	ptr	[si+2]
	mov	al,byte	ptr	es:[bp+0]
	test	byte	ptr	es:[bp+4],40h
	je	loc_1AA
	jmp	WRITESTR
loc_1AA:
	test	byte ptr es:[bp+4], 10h
	jz	short loc_1B4
;	jmp	E_EXTNOTDEF
loc_1B4:
	mov	dx,word	ptr	es:[bp+0Ch]
	mov	word	ptr	[si],dx
	mov	dx,word	ptr	es:[bp+0Ah]
	mov	word	ptr	[si+2],dx
	and	byte	ptr	[si-2],7Fh
WENOTLAB:
	add	si,4
	jmp	WELP2
WEENDEXP:
	mov	es, ss:word_1A942
	xor	al,al
	stosb
	mov	dx,si
	mov	bx,si
	pop	si
	sub	bx,si
	add	bx,5
WEWEPLP:
	lodsb
	stosb
	dec	bx
	jne	WEWEPLP
	mov	si,dx
	cmp	di,7E00h
	jb	WENOTENDBUF
	push	ds
	push	si
	push	cx
	mov	ds, ss:word_1A942
	xor	dx,dx
	mov	cx,di
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
loc_200:
	pop	si
	pop	ds
loc_202:
	xor	di,di
WENOTENDBUF:
	add	si, 5
loc_207:
	cmp	si, 3F00h
	jb	short WEOK
	xor	si, si
	mov	ax, [si]
	mov	ds, ax
	mov	si, 2
WEOK:
	dec	ss:word_1226A
	jz	short loc_220
	jmp	WELP
loc_220:
	mov	es, ss:word_1A942
	xor	al, al
	stosb
	mov	ds, ss:word_1A942
	xor	dx, dx
	mov	cx, di
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	ret
WRITESTR:
	push	ds
	push	si
	push	cx
	push	es
	mov	ds, word ptr es:[bp+6]
	mov	si, es:[bp+8]
	mov	cl, es:[bp+5]
	mov	es, ss:word_1A942
WEWSLP:
	lodsb
	stosb
	dec	cl
	jne	WEWSLP
	pop	es
	pop	cx
	pop	si
	pop	ds
	mov	word	ptr	[si],cx
	inc	cx
	jmp	WENOTLAB
E_EXTNOTDEF:
	push	ds
	push	dx
	mov	dx, seg	seg003
	mov	ds, dx
	assume ds:seg003
	mov	dx, 88C4h
	call	far	ptr	_OS2PRTSTRING
	pop	dx
	pop	ds
	assume ds:nothing
	push	ds
	push	dx
	push	si
	push	ax
	mov	bx, es:[bp+6]
	mov	dx, es:[bp+8]
	mov	ds, bx
	mov	si, dx

loc_282:
	lodsb
	or	al,al
	jnz	short loc_282
	mov	byte ptr [si-1], 24h ; '$'
	call	far	ptr	_OS2PRTSTRING
	mov	byte ptr [si-1], 0
	pop	ax
	pop	si
	pop	dx
	pop	ds
	inc	ss:word_12284
	jmp	WENOTLAB
WRITEEXTERNS	endp

WRITEPUBLICS	proc near
	mov	es, ss:word_1A942
	xor	di,di
	mov	bx,1472h
	WPUBLP:
	mov	ax,word	ptr	ss:[bx]
	or	ax,ax
	je	WPUBNEXT
	mov	ds,ax
	mov	si,word	ptr	ss:[bx+02]
	push	bx
WPUBLP2:
	test	byte	ptr	[si+04h],80h
	je	WPUBNEXT2
	test	byte	ptr	[si+04h],10h
	jne	WPUBUNDEF
	push	ds
	push	si
	mov	ax,word	ptr	[si+06h]
	mov	bp,word	ptr	[si+08h]
	mov	cl,byte	ptr	[si+05h]
	mov	si,bp
	mov	ds,ax
WPWSLP:
	lodsb
	stosb
	dec	cl
	jne	WPWSLP
	pop	si
	pop	ds
	mov	ax,word	ptr	[si+0Ch]
	stosw
	mov	ax,word	ptr	[si+0Ah]
	stosw
	cmp	di,7F00h
	jb	WPUBNEXT2
	push	ds
	push	si
	push	bx
	mov	ds, ss:word_1A942
	xor	dx,dx
	mov	cx,di
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	bx
	pop	si
	pop	ds
	xor	di,di
WPUBNEXT2:
	mov	ax,word	ptr	[si]
	mov	si,word	ptr	[si+02]
	mov	ds,ax
	or	ax,ax
	jne	WPUBLP2
	pop	bx
WPUBNEXT:
	add	bx,04h
	cmp	bx,2472h
	jb	WPUBLP
	xor	al,al
	stosb
	mov	ds, ss:word_1A942
	xor	dx,dx
	mov	cx,di
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	ret
WPUBUNDEF:
	push	es
	push	di
	push	ds
	push	si
	push	ds
	push	dx
	mov	dx, seg	seg003
	mov	ds, dx
	assume ds:seg003
	mov	dx,8899h
	call	far	ptr	_OS2PRTSTRING
	pop	dx
	pop	ds
	assume ds:nothing
	inc	ss:word_12284
	pop	si
	pop	ds
	pop	di
	pop	es
	push	ds
	push	dx
	push	si
	push	ax
	mov	bx,word	ptr	[si+06h]
	mov	dx,word	ptr	[si+08h]
	mov	ds,bx
	mov	si,dx
loc_35C:
	lodsb
	or	al,al
	jne	loc_35C
	mov	byte	ptr	[si-1],24h
	call	far	ptr	_OS2PRTSTRING
	mov	byte	ptr	[si-1],00h
	pop	ax
	pop	si
	pop	dx
	pop	ds
	jmp	WPUBNEXT2
WRITEPUBLICS	endp

WRITEBLOCKS	proc near
	mov	ds, ss:word_12270
	mov	si, ss:word_12272
LINKLOOP:
	mov	ax,word	ptr	[si+0Ch]
	mov	ss:word_1227E, ax
	mov	ax,word	ptr	[si+0Eh]
	mov	ss:word_1227C, ax
	push	ds
	push	si
	push	dx
	push	cx
	mov	ax, seg	seg003
	mov	ds,ax
	assume ds:seg003
	mov	dx,13BCh
	mov	cx,0004h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	pop	dx
	pop	si
	pop	ds
	assume ds:nothing
	mov	ax,word	ptr	[si+04h]
	mov	ss:word_1227E, ax
	mov	ax,word	ptr	[si+06h]
	mov	ss:word_1227C, ax
	push	ds
	push	si
	push	dx
	push	cx
	mov	ax, seg	seg003
	mov	ds,ax
	assume ds:seg003
	mov	dx,13BCh
	mov	cx,0004h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	pop	dx
	pop	si
	pop	ds
	assume ds:nothing
	mov	al,byte	ptr	[si+10h]
	test	al,01h
	jne	LINKNORM
	test	al,08h
	je	loc_3E2
	jmp	LINKGAP
loc_3E2:
	test	al,02h
	jne	LINKINCBIN
	mov	dx,7E8Dh
	IF	UNIMPLEMENTED_ROUTINES
	call	FATALERR_ROUT
	ENDIF
	jmp	STOPASSEM
LINKWRITERET:
	inc	ss:word_12262
	mov	ax,word	ptr	[si]
	mov	bx,word	ptr	[si+02h]
	mov	ds,ax
	mov	si,bx
	or	ax,ax
	je	locret_404
	jmp	LINKLOOP
locret_404:
	ret
LINKNORM:
	mov	ss:word_1227C, 0
	push	ds
	push	si
	push	dx
	push	cx
	mov	ax, seg	seg003
	mov	ds,ax
	assume ds:seg003
	mov	dx,13BCh
	mov	cx,0001h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	pop	dx
	pop	si
	pop	ds
	assume ds:nothing
	push	si
	mov	cx,word	ptr	[si+06h]
	mov	bx, ss:word_11D9D
	mov	dx,si
	add	dx,13h
	call	INT21R
	pop	si
	jmp	LINKWRITERET
LINKINCBIN:
	mov	ss:word_1227C, 1
	push	ds
	push	si
	push	dx
	push	cx
	mov	ax, seg	seg003
	mov	ds,ax
	assume ds:seg003
	mov	dx,13BCh
	mov	cx,0001h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	pop	dx
	pop	si
	pop	ds
	assume ds:nothing
	mov	ax,word	ptr	[si+11h]
	mov	ss:word_1227C, ax
	push	ds
	push	si
	push	dx
	push	cx
	mov	ax, seg	seg003
	mov	ds,ax
	assume ds:seg003
	mov	dx,13BCh
	mov	cx,0002h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	pop	dx
	pop	si
	pop	ds
	assume ds:nothing
	push	ds
	push	si
	mov	ax,word	ptr	[si+08h]
	mov	dx,word	ptr	[si+0Ah]
	mov	ds,ax
	mov	si,dx
	xor	cx,cx
LILP:
	lodsb
	inc	cx
	or	al,al
	jne	LILP
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	si
	pop	ds
	jmp	LINKWRITERET
LINKGAP:
	mov	ss:word_1227C, 0
	push	ds
	push	si
	push	dx
	push	cx
	mov	ax, seg	seg003
	mov	ds,ax
	assume ds:seg003
	mov	dx,13BCh
	mov	cx,0001h
	mov	bx, ss:word_11D9D
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	pop	dx
	pop	si
	pop	ds
	mov	bx,word	ptr	[si+04h]
	mov	cx,word	ptr	[si+06h]
	if	UNIMPLEMENTED_ROUTINES
	call	SENDGAP
	ENDIF
	jmp	LINKWRITERET
WRITEBLOCKS	endp

INT21R	proc near
cmp	ss:byte_13358, 0
jz	short locret_4EB
push	dx
push	ds
push	bx
call	_OS2WRITEBYTES
pop	bx
pop	ds
pop	dx

locret_4EB:
retn
INT21R	endp

GREGERR:

; This is where the MARIO parser will eventually go
include mariop.asm

OPEN_MAP_FILE:

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
	int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
				; AL = exit code
_OS2EXIT endp

_OS2EXITERR proc far
	mov	ax,4C01h
	int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
				; AL = exit code
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
	int	21h		; DOS -	2+ - OPEN DISK FILE WITH HANDLE
				; DS:DX	-> ASCIZ filename
				; AL = access mode
				; 1 - write
	pop	dx
	pop	ds
	jae	locret_CE33
	xor	bx,bx
	mov	ax,3C00h
	mov	cx,0000h
	int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
				; CX = attributes for file
				; DS:DX	-> ASCIZ filename (may include drive and path)


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
	cmp	al,24h	; '$'
	jne	loc_CE94
	dec	cx
	pop	si
	mov	ah,40h	; '@'
	mov	bx,0001h
	call	far	ptr	_OS2WRITEBYTES
	pop	cx
	retf
_OS2PRTSTRING endp

; Stub function used in the OS/2 version
_OS2INITTERM	proc far

; The OS/2 version does this:
	IF	TARGET_OS2	NE	0
	PUSH	DX
	BX
	SS
	PUSH	73e6h
	PUSH	SS
	PUSH	73eah
	PUSH	2h
	PUSH	1h
	CALLF	DOSCALLS::Ordinal_14

	PUSH	DX
	PUSH	BX
	PUSH	SS
	PUSH	73e6h
	PUSH	SS
	PUSH	73eah
	PUSH	2h
	PUSH	4h
	CALLF	DOSCALLS::Ordinal_14
	ENDIF
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

; temporary home for the data segments until I
; get around to properly disassembling them
include datasegs.asm

end _ARGSFX