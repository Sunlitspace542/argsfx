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
	if	0
	call	far	ptr	_OS2INITTERM
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

start endp
seg000 ends
end