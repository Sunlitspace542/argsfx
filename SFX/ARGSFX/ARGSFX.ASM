.386
.model large


; Segment type:	Pure code
seg000 segment byte public 'CODE' use16
assume cs:seg000
assume es:nothing, ss:seg000, ds:nothing, fs:nothing, gs:nothing



public start
start proc near

_ARGSFX:
	cld
	mov	cx,8AC9h
	mov	ss,cx
	mov	word	ptr	ss:[9BDEh],ds
	mov	word	ptr	ss:[9BE0h],0080h
	mov	dx,79DDh
	mov	bx,0052h
	call	far	ptr	_OS2INITTERM
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
STOPASSEM:
	if	0
	call	DO_END
	endif
	jmp	OVERRET
CTRLCHAN:
	push	ds
	push	dx
	mov	dx,8AC9h
	mov	ds,dx
	mov	dx,8A14h
	call	far	ptr	_OS2PRTSTRING
	pop	dx
	pop	ds
	jmp	far	ptr	_OS2EXITERR





start endp
seg000 ends

; Segment type:	Pure code
seg001 segment byte public 'CODE' use16
assume cs:seg001
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
;might be a function?
unkfunc1:
	or	ax,ax
	jne	unkfunc1_sub
	clc
	ret
unkfunc1_sub:
	stc
	ret

_OS2EXIT:
mov	ax,4C00h
int	21h

_OS2EXITERR:
mov	ax,4C01h
int	21h

_OS2OPENFILE:
mov	ax,3D00h
int	21h
retf

_OS2OPENNEWFILE:
mov	ax,3C00h
int	21h
retf

_OS2OPENAPPENDFILE:
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

_OS2CLOSEFILE:
mov	ah,3Eh
int	21h
retf

_OS2READBYTES:
mov	ah,3Fh
int	21h
retf

_OS2WRITEBYTES:
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
int	21h
pop	cx
pop	dx
pop	ds
pop	bx

loc_CE5A:
mov	ah,40h
int	21h
retf

_OS2SEEKFILE:
mov	ax,4200h
int	21h
retf

_OS2SEEKEND:
mov	ax,4202h
int	21h
retf

_OS2ALLOCSEG:
mov	ah,48h
int	21h
retf

_OS2FREESEG:
mov	ah,49h
int	21h
retf

_OS2AVAILMEM:
mov	bx,0FFFFh
mov	ah,48h
int	21h
shr	bx,06h
mov	ax,bx
xor	dx,dx
retf

_OS2GETDATE:
mov	ah,2Ah
int	21h
retf

_OS2GETTIME:
mov	ah,2Ch
int	21h
retf

_OS2PRTSTRING:
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

; Stub function used in the OS/2 version
_OS2INITTERM:
retf

_OS2RENAMEFILE:
mov	ah,56h
int	21h
retf

_OS2DELETEFILE:
mov	ah,41h
int	21h
retf

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