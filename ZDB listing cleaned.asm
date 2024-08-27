; The full code listing for ArgSfx 1.50 (non-extender) with labels
; Brought to you by ZDB 3.0r1 (cleaned)

_ARGSFX:
cld
mov	cx,8AC9
mov	ss,cx
mov	word	ptr	ss:[9BDE],ds
mov	word	ptr	ss:[9BE0],0080
mov	dx,79DD
mov	bx,0052
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
OVERRET:
mov	ax,word	ptr	[13C4]
or	ax,ax
jne	0048
jmp	far	ptr	_OS2EXIT
jmp	far	ptr	_OS2EXITERR
STOPASSEM:
call	DO_END
jmp	OVERRET
CTRLCHAN:
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A14
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
jmp	far	ptr	_OS2EXITERR
LINK:
mov	al,byte	ptr	[13A0]
or	al,al
jne	DOLINK
ret
DOLINK:
mov	ax,word	ptr	[13C4]
or	ax,ax
je	DOLINK2
ret
DOLINK2:
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,89FC
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
push	si
push	ax
mov	bx,8AC9
mov	dx,9B1C
mov	ds,bx
mov	si,dx
lodsb
or	al,al
jne	0099
mov	byte	ptr	[si+FF],24
call	far	ptr	_OS2PRTSTRING
mov	byte	ptr	[si+FF],00
pop	ax
pop	si
pop	dx
pop	ds
mov	bx,0800
call	far	ptr	_OS2ALLOCSEG
jae	LBUFOK
push	dx
mov	dx,8535
call	ERROR_ROUT
pop	dx
LBUFOK:
mov	word	ptr	[9A82],ax
mov	ax,ss
mov	ds,ax
mov	dx,9B1C
xor	cx,cx
call	far	ptr	_OS2OPENNEWFILE
mov	word	ptr	[0EDD],ax
jae	LDISKOK
call	NEEDCR
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,891C
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
ret
LDISKOK:
mov	byte	ptr	ss:[2498],01
mov	byte	ptr	ss:[13BA],04
mov	es,word	ptr	ss:[9A82]
xor	di,di
mov	ax,4F53
stosw
mov	ax,4A42
stosw
mov	ax,0101
stosw
xor	ax,ax
stosw
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,0008
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
call	WRITEBLOCKS
call	WRITEPUBLICS
call	WRITEEXTERNS
xor	cx,cx
mov	dx,0006
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2SEEKFILE
mov	ax,ss
mov	ds,ax
mov	dx,13A2
mov	cx,0002
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2CLOSEFILE
ret
mov	ds,word	ptr	ss:[0ED9]
xor	dx,dx
mov	cx,word	ptr	ss:[0EDB]
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
ret
WRITEEXTERNS:
mov	ax,word	ptr	[13AA]
or	ax,ax
jne	WEDO
ret
WEDO:
mov	ds,word	ptr	ss:[13A4]
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
je	WEENDEXP
WELP3:
test	al,80
je	WENOTLAB
mov	es,word	ptr	[si]
mov	bp,word	ptr	[si+02]
mov	al,byte	ptr	es:[bp+00]
test	byte	ptr	es:[bp+04],40
je	01AA
jmp	WRITESTR
test	byte	ptr	es:[bp+04],10
je	01B4
jmp	E_EXTNOTDEF
mov	dx,word	ptr	es:[bp+0C]
mov	word	ptr	[si],dx
mov	dx,word	ptr	es:[bp+0A]
mov	word	ptr	[si+02],dx
and	byte	ptr	[si+FE],7F
WENOTLAB:
add	si,04
jmp	WELP2
WEENDEXP:
mov	es,word	ptr	ss:[9A82]
xor	al,al
stosb
mov	dx,si
mov	bx,si
pop	si
sub	bx,si
add	bx,05
WEWEPLP:
lodsb
stosb
dec	bx
jne	WEWEPLP
mov	si,dx
cmp	di,7E00
jb	WENOTENDBUF
push	ds
push	si
push	cx
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,di
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	si
pop	ds
xor	di,di
WENOTENDBUF:
add	si,05
cmp	si,3F00
jb	WEOK
xor	si,si
mov	ax,word	ptr	[si]
mov	ds,ax
mov	si,0002
WEOK:
dec	word	ptr	ss:[13AA]
je	0220
jmp	WELP
mov	es,word	ptr	ss:[9A82]
xor	al,al
stosb
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,di
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
ret
WRITESTR:
push	ds
push	si
push	cx
push	es
mov	ds,word	ptr	es:[bp+06]
mov	si,word	ptr	es:[bp+08]
mov	cl,byte	ptr	es:[bp+05]
mov	es,word	ptr	ss:[9A82]
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
mov	dx,8AC9
mov	ds,dx
mov	dx,88C4
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
push	si
push	ax
mov	bx,word	ptr	es:[bp+06]
mov	dx,word	ptr	es:[bp+08]
mov	ds,bx
mov	si,dx
lodsb
or	al,al
jne	0282
mov	byte	ptr	[si+FF],24
call	far	ptr	_OS2PRTSTRING
mov	byte	ptr	[si+FF],00
pop	ax
pop	si
pop	dx
pop	ds
inc	word	ptr	ss:[13C4]
jmp	WENOTLAB
WRITEPUBLICS:
mov	es,word	ptr	ss:[9A82]
xor	di,di
mov	bx,1472
WPUBLP:
mov	ax,word	ptr	ss:[bx]
or	ax,ax
je	WPUBNEXT
mov	ds,ax
mov	si,word	ptr	ss:[bx+02]
push	bx
WPUBLP2:
test	byte	ptr	[si+04],80
je	WPUBNEXT2
test	byte	ptr	[si+04],10
jne	WPUBUNDEF
push	ds
push	si
mov	ax,word	ptr	[si+06]
mov	bp,word	ptr	[si+08]
mov	cl,byte	ptr	[si+05]
mov	si,bp
mov	ds,ax
WPWSLP:
lodsb
stosb
dec	cl
jne	WPWSLP
pop	si
pop	ds
mov	ax,word	ptr	[si+0C]
stosw
mov	ax,word	ptr	[si+0A]
stosw
cmp	di,7F00
jb	WPUBNEXT2
push	ds
push	si
push	bx
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,di
mov	bx,word	ptr	ss:[0EDD]
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
add	bx,04
cmp	bx,2472
jb	WPUBLP
xor	al,al
stosb
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,di
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
ret
WPUBUNDEF:
push	es
push	di
push	ds
push	si
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8899
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
inc	word	ptr	ss:[13C4]
pop	si
pop	ds
pop	di
pop	es
push	ds
push	dx
push	si
push	ax
mov	bx,word	ptr	[si+06]
mov	dx,word	ptr	[si+08]
mov	ds,bx
mov	si,dx
lodsb
or	al,al
jne	035C
mov	byte	ptr	[si+FF],24
call	far	ptr	_OS2PRTSTRING
mov	byte	ptr	[si+FF],00
pop	ax
pop	si
pop	dx
pop	ds
jmp	WPUBNEXT2
WRITEBLOCKS:
mov	ds,word	ptr	ss:[13B0]
mov	si,word	ptr	ss:[13B2]
LINKLOOP:
mov	ax,word	ptr	[si+0C]
mov	word	ptr	[13BE],ax
mov	ax,word	ptr	[si+0E]
mov	word	ptr	[13BC],ax
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,13BC
mov	cx,0004
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
mov	ax,word	ptr	[si+04]
mov	word	ptr	[13BE],ax
mov	ax,word	ptr	[si+06]
mov	word	ptr	[13BC],ax
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,13BC
mov	cx,0004
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
mov	al,byte	ptr	[si+10]
test	al,01
jne	LINKNORM
test	al,08
je	03E2
jmp	LINKGAP
test	al,02
jne	LINKINCBIN
mov	dx,7E8D
call	FATALERR_ROUT
jmp	STOPASSEM
LINKWRITERET:
inc	word	ptr	ss:[13A2]
mov	ax,word	ptr	[si]
mov	bx,word	ptr	[si+02]
mov	ds,ax
mov	si,bx
or	ax,ax
je	0404
jmp	LINKLOOP
ret
LINKNORM:
mov	word	ptr	ss:[13BC],0000
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,13BC
mov	cx,0001
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
push	si
mov	cx,word	ptr	[si+06]
mov	bx,word	ptr	ss:[0EDD]
mov	dx,si
add	dx,13
call	INT21R
pop	si
jmp	LINKWRITERET
LINKINCBIN:
mov	word	ptr	ss:[13BC],0001
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,13BC
mov	cx,0001
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
mov	ax,word	ptr	[si+11]
mov	word	ptr	[13BC],ax
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,13BC
mov	cx,0002
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
push	ds
push	si
mov	ax,word	ptr	[si+08]
mov	dx,word	ptr	[si+0A]
mov	ds,ax
mov	si,dx
xor	cx,cx
LILP:
lodsb
inc	cx
or	al,al
jne	LILP
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	si
pop	ds
jmp	LINKWRITERET
LINKGAP:
mov	word	ptr	ss:[13BC],0000
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,13BC
mov	cx,0001
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
mov	bx,word	ptr	[si+04]
mov	cx,word	ptr	[si+06]
call	SENDGAP
jmp	LINKWRITERET
INT21R:
cmp	byte	ptr	ss:[2498],00
je	DONTWRITE
push	dx
push	ds
push	bx
call	far	ptr	_OS2WRITEBYTES
pop	bx
pop	ds
pop	dx
DONTWRITE:
ret
WRITESYMBOLS:
mov	al,byte	ptr	[13F8]
or	al,al
jne	DOWSYM
ret
DOWSYM:
mov	ax,ss
mov	ds,ax
mov	dx,9B5C
xor	cx,cx
call	far	ptr	_OS2OPENNEWFILE
mov	word	ptr	[0EDD],ax
jae	SDISKOK
call	NEEDCR
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,891C
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
ret
SDISKOK:
mov	bx,1472
SYMLP:
mov	ax,word	ptr	ss:[bx]
or	ax,ax
je	SYMNEXT
mov	es,ax
mov	di,word	ptr	ss:[bx+02]
push	bx
SYMLP2:
test	byte	ptr	es:[di+04],5E
jne	SYMNEXT2
push	es
push	di
mov	ds,word	ptr	es:[di+06]
mov	dx,word	ptr	es:[di+08]
mov	cl,byte	ptr	es:[di+05]
dec	cl
xor	ch,ch
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
mov	dx,word	ptr	es:[di+0A]
mov	cx,word	ptr	es:[di+0C]
mov	ax,ss
mov	es,ax
mov	di,8A6E
mov	ax,2409
stosw
call	BIN2HEXL
mov	ax,0A0D
stosw
push	ds
push	si
push	dx
push	cx
mov	ax,8AC9
mov	ds,ax
mov	dx,8A6E
mov	cx,000C
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	dx
pop	si
pop	ds
pop	di
pop	es
SYMNEXT2:
mov	ax,word	ptr	es:[di]
mov	di,word	ptr	es:[di+02]
mov	es,ax
or	ax,ax
jne	SYMLP2
pop	bx
SYMNEXT:
add	bx,04
cmp	bx,2472
jae	05A5
jmp	SYMLP
mov	bx,word	ptr	ss:[0EDD]
call	far	ptr	_OS2CLOSEFILE
ret
mov	word	ptr	ss:[9A90],bx
mov	word	ptr	ss:[9A92],cx
push	ds
push	si
mov	dx,word	ptr	[si+11]
push	dx
mov	ax,word	ptr	[si+08]
mov	word	ptr	[0F98],ax
mov	dx,word	ptr	[si+0A]
mov	word	ptr	ss:[0F9A],dx
mov	ds,ax
call	far	ptr	_OS2OPENFILE
mov	word	ptr	[9A84],ax
pop	dx
jae	05E0
jmp	SINCERROR
xor	cx,cx
or	dx,dx
je	SINC
mov	bx,word	ptr	ss:[9A84]
call	far	ptr	_OS2SEEKFILE
SINC:
cmp	word	ptr	ss:[9A90],00
je	NOBX
LOTSCX:
mov	bx,word	ptr	ss:[9A84]
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,8000
sub	word	ptr	ss:[9A92],cx
sbb	word	ptr	ss:[9A90],00
call	far	ptr	_OS2READBYTES
push	ax
mov	cx,8000
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	bx,word	ptr	ss:[0EDD]
call	INT21R
pop	ax
jmp	SINC
NOBX:
cmp	word	ptr	ss:[9A92],8000
jae	LOTSCX
mov	bx,word	ptr	ss:[9A84]
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	cx,word	ptr	ss:[9A92]
call	far	ptr	_OS2READBYTES
mov	cx,word	ptr	ss:[9A92]
mov	ds,word	ptr	ss:[9A82]
xor	dx,dx
mov	bx,word	ptr	ss:[0EDD]
call	INT21R
mov	bx,word	ptr	ss:[9A84]
call	far	ptr	_OS2CLOSEFILE
pop	si
pop	ds
ret
SINCERROR:
mov	dx,80FF
call	FATALERR_ROUT
jmp	STOPASSEM
SENDGAP:
push	ds
push	si
mov	ax,86C9
mov	ds,ax
GAPLOOP:
sub	cx,4000
sbb	bx,00
js	GAPLAST
push	bx
push	cx
mov	dx,0000
mov	bx,word	ptr	ss:[0EDD]
mov	cx,4000
call	INT21R
pop	cx
pop	bx
jmp	GAPLOOP
GAPLAST:
add	cx,4000
mov	dx,0000
mov	bx,word	ptr	ss:[0EDD]
call	INT21R
pop	si
pop	ds
ret
DO_END:
mov	bx,word	ptr	ss:[13F6]
call	far	ptr	_OS2CLOSEFILE
mov	bx,word	ptr	ss:[2476]
call	far	ptr	_OS2CLOSEFILE
mov	ax,ss
mov	ds,ax
mov	si,261F
call	P_PRINTF2
ret
EVAL_FRS:
mov	word	ptr	ss:[2474],0000
mov	byte	ptr	ss:[0AD0],01
mov	byte	ptr	ss:[0ACD],00
mov	byte	ptr	ss:[0F8A],01
mov	word	ptr	ss:[0AA6],0000
mov	es,word	ptr	ss:[0AC5]
mov	di,word	ptr	ss:[0AC7]
mov	word	ptr	es:[di],4321
mov	word	ptr	ss:[9A90],di
mov	ds,word	ptr	ss:[0ACB]
mov	si,0002
INSFRLP:
cmp	word	ptr	[si],4321
je	INSFREXIT
NOTEX:
mov	word	ptr	ss:[A49D],si
call	FREXPRESS
jne	INSFRERR
mov	bp,word	ptr	[si+02]
mov	es,word	ptr	[si+04]
mov	di,word	ptr	[si+06]
call	word	ptr	[bp+7407]
NEXTFR:
add	si,15
cmp	si,7F00
jb	INSFRLP
xor	si,si
mov	ax,word	ptr	[si]
mov	ds,ax
inc	si
inc	si
jmp	INSFRLP
INSFREXIT:
cmp	si,word	ptr	ss:[9A90]
jne	NOTEX
ret
INSFRERR:
mov	es,word	ptr	ss:[9A8C]
mov	bp,word	ptr	ss:[9A8E]
test	byte	ptr	es:[bp+04],40
jne	EXTNEXTFR
mov	byte	ptr	ss:[0ACD],01
push	dx
mov	dx,8886
call	INSFRERR1
pop	dx
mov	byte	ptr	ss:[0ACD],00
mov	ax,word	ptr	[13C4]
cmp	ax,word	ptr	ss:[13FD]
jb	IFRE0
mov	dx,7EB4
call	FATALERR_ROUT
jmp	STOPASSEM
IFRE0:
jmp	NEXTFR
EXTNEXTFR:
push	es
push	di
push	bp
mov	si,word	ptr	ss:[A49D]
mov	es,word	ptr	ss:[13A6]
mov	di,word	ptr	ss:[13A8]
xor	ax,ax
stosw
movsw
jmp	ENF2
ENF0:
lodsw
stosw
or	ax,ax
je	ENF1
ENF2:
movsw
movsw
jmp	ENF0
ENF1:
mov	ax,word	ptr	[si+11]
stosw
mov	ax,word	ptr	[si+13]
stosw
mov	al,byte	ptr	[si+02]
stosb
mov	bp,word	ptr	ss:[13A8]
mov	ax,word	ptr	[si+08]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	ss:[13A8],di
inc	word	ptr	ss:[13AA]
cmp	di,3F00
jb	07C7
call	MOREEXT
pop	bp
pop	di
pop	es
jmp	NEXTFR
INSFRERR1:
lodsw
cmp	ax,FFFE
jne	INSFRERR1
dec	si
dec	si
push	ds
push	es
push	ax
push	di
push	si
mov	ax,word	ptr	[si+08]
mov	word	ptr	[13F0],ax
mov	ax,word	ptr	[0ED9]
mov	word	ptr	[0F98],ax
mov	ax,word	ptr	[si+0E]
mov	word	ptr	[0F9A],ax
mov	al,byte	ptr	[0EE1]
or	al,al
je	ERROK3
mov	dx,7CF5
call	FATALERR_ROUT
jmp	STOPASSEM
ERROK3:
call	NEEDCR
mov	si,dx
inc	dx
mov	al,byte	ptr	ss:[si]
or	al,al
je	ERRORT2
mov	cx,8A5A
inc	word	ptr	ss:[13C6]
jmp	DONEEW2
ERRORT2:
mov	cx,8A54
inc	word	ptr	ss:[13C4]
DONEEW2:
mov	al,byte	ptr	[13E9]
or	al,al
jne	ERRSUPDO2
mov	word	ptr	ss:[13DE],cx
mov	word	ptr	ss:[13E0],dx
mov	ax,ss
mov	ds,ax
mov	si,2557
mov	byte	ptr	ss:[0EE1],01
call	P_PRINTF2
mov	byte	ptr	ss:[0EE1],00
ERRSUPDO2:
pop	si
pop	di
pop	ax
pop	es
pop	ds
ret
FR_DOBYTE:
or	dx,dx
je	DFRB1
cmp	dx,FF
jne	FRBERR
cmp	ch,FF
jne	FRBERR
or	cl,cl
jns	FRBERR
mov	byte	ptr	es:[di+01],cl
ret
FRBERR:
push	dx
mov	dx,7F28
call	INSFRERR1
pop	dx
ret
DFRB1:
or	ch,ch
jne	FRBERR
mov	byte	ptr	es:[di+01],cl
ret
FR_DODBYTE:
or	dx,dx
je	DDFRB1
cmp	dx,FF
jne	FRBERR
cmp	ch,FF
jne	FRBERR
or	cl,cl
jns	FRBERR
mov	byte	ptr	es:[di],cl
ret
DDFRB1:
or	ch,ch
jne	FRBERR
mov	byte	ptr	es:[di],cl
ret
FR_DOWORD:
or	dx,dx
je	DFRW2
cmp	dx,FF
jne	FRWERR
or	cx,cx
jns	FRWERR
DFRW2:
mov	word	ptr	es:[di+01],cx
ret
FRWERR:
push	dx
mov	dx,7F37
call	INSFRERR1
pop	dx
jmp	DFRW2
FR_DODWORD:
or	dx,dx
je	DDFRW2
cmp	dx,FF
jne	FRWERR
or	cx,cx
jns	FRWERR
DDFRW2:
mov	word	ptr	es:[di],cx
ret
FR_DOLONG:
mov	word	ptr	es:[di+01],cx
mov	byte	ptr	es:[di+03],dl
ret
FR_DOJMWORD:
mov	al,byte	ptr	[si+0A]
cmp	dl,al
jne	FRBANKERR
mov	word	ptr	es:[di+01],cx
ret
FRBANKERR:
push	dx
mov	dx,85DD
call	INSFRERR1
pop	dx
ret
FR_DOJMIDXWORD:
mov	word	ptr	es:[di+01],cx
ret
FR_DOBRANCH:
sub	dx,word	ptr	[si+0A]
jne	FRBCCERR
sub	cx,word	ptr	[si+0C]
sub	cx,02
cmp	cx,80
jl	FRBCCERR
cmp	cx,7F
jg	FRBCCERR
mov	byte	ptr	es:[di+01],cl
ret
FRBCCERR:
push	dx
mov	dx,7F46
call	INSFRERR1
pop	dx
ret
FR_DOLBRANCH:
sub	cx,word	ptr	[si+0C]
sbb	dx,word	ptr	[si+0A]
sub	cx,03
sbb	dx,00
js	FRBRLMIN
jne	FRBCCERR
cmp	cx,7FFF
jg	FRBCCERR
FRSETBRL:
mov	word	ptr	es:[di+01],cx
ret
FRBRLMIN:
cmp	dx,FF
jne	FRBCCERR
cmp	cx,8000
jl	FRBCCERR
jmp	FRSETBRL
FR_DONIBBLE:
cmp	dx,00
jne	DFRNERR
cmp	cx,0F
jg	DFRNERR
or	byte	ptr	es:[di+01],cl
ret
DFRNERR:
push	dx
mov	dx,8251
call	INSFRERR1
pop	dx
ret
FR_DOLMS:
or	cx,cx
jns	094F
jmp	FRBERR
cmp	cx,0200
jb	0958
jmp	FRBERR
shr	cx,1
mov	word	ptr	es:[di+01],cx
ret
CONVEXPRESS:
mov	word	ptr	ss:[A49F],di
push	bx
push	es
push	di
mov	es,word	ptr	ss:[0AC5]
mov	di,word	ptr	ss:[0AC7]
xor	ax,ax
stosw
mov	byte	ptr	[0ACF],al
mov	byte	ptr	[0ACE],al
EXPLOOP:
xor	ah,ah
lodsb
mov	bp,ax
add	bp,bp
jmp	word	ptr	[bp+6A29]
NUM0:
mov	bx,741D
mov	dx,si
NUM0LP:
lodsb
xlat
or	al,al
jns	NUM0LP
mov	al,byte	ptr	[si+FE]
mov	si,dx
and	al,DF
cmp	al,48
je	NUMHEX
jmp	NUM0DEC
NUMHEX:
mov	bx,749F
xor	cx,cx
xor	dx,dx
HEXLP:
lodsb
cmp	al,30
je	HEXLP
xlat
or	al,al
jns	09B6
jmp	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	09D2
jmp	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	09EE
jmp	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0A0A
jmp	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0A26
jmp	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0A42
jmp	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	ENDHEX
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	ENDHEX
dec	si
push	dx
mov	dx,844E
call	ERROR_ROUT
pop	dx
ENDHEX:
mov	al,byte	ptr	[si+FF]
and	al,DF
cmp	al,48
je	0AD4
jmp	NUMOUT
inc	si
jmp	NUMOUT
NUM0DEC:
cmp	al,42
jne	0ADF
jmp	NUM0BIN
lodsb
NUMDEC:
mov	bx,7521
push	si
push	di
xor	cx,cx
xor	dx,dx
xlat
or	al,al
jns	0AF2
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0B15
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0B38
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0B5B
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0B7E
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0BA1
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0BC4
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0BE7
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0C0A
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
jns	0C2D
jmp	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
js	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
js	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
xlat
or	al,al
js	ENDDEC
add	cx,cx
adc	dx,dx
mov	bp,cx
mov	di,dx
add	cx,cx
adc	dx,dx
add	cx,cx
adc	dx,dx
add	cx,bp
adc	dx,di
add	cx,ax
adc	dx,00
lodsb
push	dx
mov	dx,844E
call	ERROR_ROUT
pop	dx
ENDDEC:
pop	di
pop	bp
mov	al,byte	ptr	[si+FF]
and	al,DF
cmp	al,48
je	NUMDECTOHEX
cmp	al,42
je	0CC1
jmp	NUMOUT
mov	si,bp
dec	si
jmp	NUM0BIN
NUMDECTOHEX:
mov	si,bp
dec	si
jmp	NUMHEX
NUMASC:
mov	ah,al
xor	cx,cx
xor	dx,dx
lodsb
cmp	ah,al
je	ENDASC
mov	dh,dl
mov	dl,ch
mov	ch,cl
mov	cl,al
lodsb
cmp	ah,al
je	ENDASC
mov	dh,dl
mov	dl,ch
mov	ch,cl
mov	cl,al
lodsb
cmp	ah,al
je	ENDASC
mov	dh,dl
mov	dl,ch
mov	ch,cl
mov	cl,al
lodsb
cmp	ah,al
je	ENDASC
mov	dh,dl
mov	dl,ch
mov	ch,cl
mov	cl,al
lodsb
cmp	ah,al
je	ENDASC
mov	dh,dl
mov	dl,ch
mov	ch,cl
mov	cl,al
push	dx
mov	dx,844E
call	ERROR_ROUT
pop	dx
ENDASC:
inc	si
jmp	NUMOUT
NUM0BIN:
NUMBIN:
mov	bx,75A3
xor	cx,cx
xor	dx,dx
lodsb
xlat
or	al,al
jns	0D30
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0D40
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0D50
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0D60
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0D70
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0D80
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0D90
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0DA0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0DB0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0DC0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0DD0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0DE0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0DF0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E00
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E10
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E20
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E30
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E40
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E50
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E60
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E70
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E80
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0E90
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
jns	0EA0
jmp	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
lodsb
xlat
or	al,al
js	BINOUT
add	cx,cx
adc	dx,dx
or	cl,al
push	dx
mov	dx,844E
call	ERROR_ROUT
pop	dx
BINOUT:
mov	al,byte	ptr	[si+FF]
and	al,DF
cmp	al,42
je	0F2F
jmp	NUMOUT
inc	si
jmp	NUMOUT
NUMPC:
mov	dx,word	ptr	ss:[0F92]
mov	cx,word	ptr	ss:[0F94]
inc	si
jmp	NUMOUT
NUMROMPOS:
push	es
push	bx
mov	es,word	ptr	ss:[13B6]
mov	bp,word	ptr	ss:[13B8]
mov	dx,word	ptr	es:[bp+0C]
mov	cx,word	ptr	es:[bp+0E]
mov	bx,sp
mov	bp,word	ptr	ss:[bx+04]
sub	bp,word	ptr	ss:[13B4]
add	cx,bp
adc	dx,00
inc	si
pop	bx
pop	es
jmp	NUMOUT
NUMOPEN:
mov	ax,word	ptr	[si]
and	ax,DFDF
cmp	ax,5453
je	EXP_S
EXP_RET:
add	byte	ptr	ss:[0ACF],10
jmp	EXPLOOP
EXP_S:
mov	ax,word	ptr	[si+02]
and	ax,DFDF
cmp	ax,4352
je	EXP_STRC
cmp	ax,4C52
jne	EXP_RET
mov	ax,word	ptr	[si+04]
and	ax,DFDF
cmp	ax,4E45
jne	EXP_RET
mov	al,byte	ptr	[si+06]
push	bx
mov	bx,76A7
SOURCEBLK:
cmpsw
jbe	0FD7
xlat
pop	bx
or	al,al
jns	EXP_RET
add	si,06
call	EVAL_STRLEN
add	si,02
jmp	NUMOUT
EXP_STRC:
mov	ax,word	ptr	[si+04]
and	ax,DFDF
cmp	ax,504D
jne	EXP_RET
mov	al,byte	ptr	[si+06]
push	bx
mov	bx,76A7
xlat
pop	bx
or	al,al
jns	EXP_RET
add	si,06
call	EVAL_STRCMP
add	si,02
jmp	NUMOUT
NUMCLOSE:
inc	si
inc	si
sub	byte	ptr	ss:[0ACF],10
jns	0FE5
jmp	E_UNBALBRAC
jmp	GETOPERATOR
NUMSHIFTR:
cmp	byte	ptr	es:[di+FF],06
jne	NUMHI
mov	ax,0208
add	al,byte	ptr	ss:[0ACF]
mov	word	ptr	es:[di+FE],ax
jmp	EXPLOOP
NUMSHIFTL:
cmp	byte	ptr	es:[di+FF],08
jne	NUMLO
mov	ax,0408
add	al,byte	ptr	ss:[0ACF]
mov	word	ptr	es:[di+FE],ax
jmp	EXPLOOP
NUMHI:
xor	ax,ax
stosw
stosw
mov	ax,1A0A
add	al,byte	ptr	ss:[0ACF]
stosw
jmp	EXPLOOP
NUMLO:
xor	ax,ax
stosw
stosw
mov	ax,1C0A
add	al,byte	ptr	ss:[0ACF]
stosw
jmp	EXPLOOP
NUMNOT:
xor	ax,ax
stosw
stosw
mov	ax,2209
add	al,byte	ptr	ss:[0ACF]
stosw
jmp	EXPLOOP
NUMNEG:
xor	ax,ax
stosw
stosw
mov	ax,2009
add	al,byte	ptr	ss:[0ACF]
stosw
jmp	EXPLOOP
LNUMOUT:
je	NUMOK
or	byte	ptr	es:[di+FE],80
NUMOK:
inc	si
NUMOUT:
mov	ax,cx
stosw
mov	ax,dx
stosw
GETOPERATOR:
mov	al,byte	ptr	[si+FF]
mov	bx,6B2D
xlat
or	al,al
js	CEEND
mov	ah,al
mov	bx,6C31
xlat
add	al,byte	ptr	ss:[0ACF]
stosw
jmp	EXPLOOP
CEEND:
dec	si
mov	al,byte	ptr	[si]
mov	bx,6BAF
xlat
or	al,al
jns	OPERR
test	byte	ptr	ss:[0ACF],00
jne	E_UNBALBRAC
xor	ax,ax
stosw
test	byte	ptr	ss:[0ACE],C0
jne	FREXP
sub	di,word	ptr	ss:[0AC7]
cmp	di,08
je	QUICKNUM
push	ds
push	si
mov	ax,es
mov	ds,ax
mov	si,word	ptr	ss:[0AC7]
call	NORMEXPRESS
pop	si
pop	ds
EXPOUT:
pop	di
pop	es
pop	bx
ret
or	byte	ptr	ss:[0ACE],80
jmp	EXPOUT
QUICKNUM:
pop	di
pop	es
pop	bx
ret
OPERR:
jne	10CB
jmp	NUMCLOSE
push	dx
mov	dx,8405
call	ERROR_ROUT
pop	dx
NUMERR:
push	dx
mov	dx,83E9
call	ERROR_ROUT
pop	dx
E_UNBALBRAC:
push	dx
mov	dx,8425
call	ERROR_ROUT
pop	dx
FREXP:
test	byte	ptr	ss:[0ACE],40
jne	EXTEXP
push	bx
mov	ax,word	ptr	[A49F]
sub	ax,word	ptr	ss:[13B4]
xor	bx,bx
add	ax,word	ptr	ss:[13BE]
adc	bx,word	ptr	ss:[13BC]
mov	word	ptr	es:[di+11],ax
mov	word	ptr	es:[di+13],bx
pop	bx
mov	ax,word	ptr	[0F9A]
mov	word	ptr	es:[di+0E],ax
mov	ax,word	ptr	[13AC]
mov	word	ptr	es:[di+04],ax
call	GETLINE
mov	word	ptr	es:[di+08],ax
mov	word	ptr	es:[di],FFFE
mov	word	ptr	ss:[0AC9],di
xor	cx,cx
mov	dx,cx
pop	di
pop	es
pop	bx
ret
EXTEXP:
push	ds
push	si
mov	bp,di
mov	ds,word	ptr	ss:[0AC5]
mov	si,word	ptr	ss:[0AC7]
mov	es,word	ptr	ss:[13A6]
mov	di,word	ptr	ss:[13A8]
call	GETLINE
stosw
EXTEXPLP:
lodsw
stosw
cmp	si,bp
jne	EXTEXPLP
mov	word	ptr	ss:[13A8],di
inc	word	ptr	ss:[13AA]
mov	byte	ptr	ss:[0ACE],40
xor	cx,cx
mov	dx,cx
pop	si
pop	ds
pop	di
pop	es
pop	bx
ret
NUMLOC:
dec	si
mov	word	ptr	ss:[9A8C],ds
mov	word	ptr	ss:[9A8E],si
mov	bx,79A9
xor	ah,ah
xor	cx,cx
lodsb
inc	cx
xlat
mov	dx,ax
add	dx,dx
LG_SYMLOOP:
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	LG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
jmp	LG_SYMLOOP
LG_ENDSYMHASH:
inc	cx
and	dx,0FFD
mov	ax,ss
mov	ds,ax
mov	bp,1472
add	bp,dx
LG_NEXT:
mov	ax,word	ptr	ds:[bp+00]
or	ax,ax
jne	1204
jmp	LG_NOTTHERE
mov	bp,word	ptr	ds:[bp+02]
mov	ds,ax
cmp	cl,byte	ptr	ds:[bp+05]
jne	LG_NEXT
mov	dx,word	ptr	ss:[0F82]
cmp	dx,word	ptr	ds:[bp+10]
jne	LG_NEXT
mov	dx,word	ptr	ss:[0F80]
cmp	dx,word	ptr	ds:[bp+0E]
jne	LG_NEXT
push	es
push	di
mov	es,word	ptr	ds:[bp+06]
mov	di,word	ptr	ds:[bp+08]
mov	dx,ds
mov	ds,word	ptr	ss:[9A8C]
mov	si,word	ptr	ss:[9A8E]
push	cx
dec	cx
LG_LOOP:
lodsb
xlat
cmp	al,byte	ptr	es:[di]
jne	LG_NOTSAME
inc	di
dec	cx
jne	LG_LOOP
pop	cx
pop	di
pop	es
mov	ds,dx
mov	al,byte	ptr	ds:[bp+04]
test	al,10
jne	LG_FR
and	al,7F
or	byte	ptr	ss:[0ACE],al
mov	dx,word	ptr	ds:[bp+0A]
mov	cx,word	ptr	ds:[bp+0C]
mov	ds,word	ptr	ss:[9A8C]
xor	al,al
jmp	LNUMOUT
LG_FR:
mov	cx,ds
mov	dx,bp
mov	ds,word	ptr	ss:[9A8C]
or	byte	ptr	ss:[0ACE],80
mov	al,01
or	al,al
jmp	LNUMOUT
LG_NOTSAME:
pop	cx
pop	di
pop	es
mov	ds,dx
jmp	LG_NEXT
LG_NOTTHERE:
mov	ds,word	ptr	ss:[9A8C]
mov	si,word	ptr	ss:[9A8E]
mov	al,byte	ptr	[0F8B]
push	ax
call	ADDSYMBOL
pop	ax
mov	byte	ptr	[0F8B],al
push	es
push	di
mov	es,word	ptr	ss:[0F7C]
mov	di,word	ptr	ss:[0F7E]
mov	byte	ptr	es:[di+04],11
mov	cx,es
mov	dx,di
push	ds
push	si
mov	ds,word	ptr	ss:[9A88]
mov	si,word	ptr	ss:[9A8A]
mov	ax,word	ptr	[0F72]
mov	bx,word	ptr	ss:[0F74]
mov	word	ptr	es:[di+06],ax
mov	word	ptr	es:[di+08],bx
mov	es,ax
mov	di,bx
FRCOP:
lodsb
stosb
or	al,al
jne	FRCOP
mov	word	ptr	ss:[0F74],di
cmp	di,3F80
jb	12EF
call	MORESYMTX
pop	si
pop	ds
pop	di
pop	es
mov	byte	ptr	ss:[0ACE],80
mov	al,01
or	al,al
jmp	LNUMOUT
NUMLAB:
dec	si
mov	word	ptr	ss:[9A8C],ds
mov	word	ptr	ss:[9A8E],si
mov	bx,79A9
xor	ah,ah
xor	cx,cx
lodsb
inc	cx
xlat
mov	dx,ax
add	dx,dx
G_SYMLOOP:
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	G_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
jmp	G_SYMLOOP
G_ENDSYMHASH:
inc	cx
and	dx,0FFD
mov	ax,ss
mov	ds,ax
mov	bp,1472
add	bp,dx
_NEXT:
mov	ax,word	ptr	ds:[bp+00]
or	ax,ax
jne	1395
jmp	_NOTTHERE
mov	bp,word	ptr	ds:[bp+02]
mov	ds,ax
cmp	cl,byte	ptr	ds:[bp+05]
jne	_NEXT
test	byte	ptr	ds:[bp+04],01
je	_NEXT
push	es
push	di
mov	es,word	ptr	ds:[bp+06]
mov	di,word	ptr	ds:[bp+08]
mov	dx,ds
mov	ds,word	ptr	ss:[9A8C]
mov	si,word	ptr	ss:[9A8E]
push	cx
dec	cx
_LOOP:
lodsb
xlat
cmp	al,byte	ptr	es:[di]
jne	_NOTSAME
inc	di
dec	cx
jne	_LOOP
pop	cx
pop	di
pop	es
mov	ds,dx
mov	al,byte	ptr	ds:[bp+04]
test	al,10
jne	_FR
test	al,40
jne	_EXT
and	al,7F
or	byte	ptr	ss:[0ACE],al
mov	dx,word	ptr	ds:[bp+0A]
mov	cx,word	ptr	ds:[bp+0C]
mov	ds,word	ptr	ss:[9A8C]
xor	al,al
jmp	LNUMOUT
_EXT:
mov	cx,ds
mov	dx,bp
mov	ds,word	ptr	ss:[9A8C]
or	byte	ptr	ss:[0ACE],40
mov	al,01
or	al,al
jmp	LNUMOUT
_FR:
mov	cx,ds
mov	dx,bp
mov	ds,word	ptr	ss:[9A8C]
or	byte	ptr	ss:[0ACE],80
mov	al,01
or	al,al
jmp	LNUMOUT
_NOTSAME:
pop	cx
pop	di
pop	es
mov	ds,dx
jmp	_NEXT
_NOTTHERE:
or	byte	ptr	ss:[0ACE],80
mov	ds,word	ptr	ss:[9A8C]
mov	si,word	ptr	ss:[9A8E]
mov	al,byte	ptr	[0F88]
or	al,al
jne	_NOFRBLK
mov	al,byte	ptr	[0F8B]
push	ax
call	ADDSYMBOL
pop	ax
mov	byte	ptr	[0F8B],al
push	es
push	di
mov	es,word	ptr	ss:[0F7C]
mov	di,word	ptr	ss:[0F7E]
mov	byte	ptr	es:[di+04],11
mov	cx,es
mov	dx,di
pop	di
pop	es
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
mov	al,01
or	al,al
jmp	LNUMOUT
_NOFRBLK:
mov	bx,79A9
_NOFRBLP:
lodsb
xlat
or	al,al
jns	_NOFRBLP
dec	si
mov	al,01
or	al,al
jmp	LNUMOUT
push	dx
mov	dx,87D2
call	ERROR_ROUT
pop	dx
EVAL_STRLEN:
push	bx
mov	bx,76A7
lodsb
xlat
or	al,al
js	14A3
dec	si
pop	bx
push	es
push	di
mov	ax,ss
mov	es,ax
mov	di,9778
call	GETSTR
pop	di
pop	es
push	ds
push	si
mov	ax,ss
mov	ds,ax
mov	si,9778
xor	cx,cx
STRLENLP:
lodsb
inc	cx
or	al,al
jne	STRLENLP
dec	cx
pop	si
pop	ds
xor	dx,dx
ret
EVAL_STRCMP:
push	bx
mov	bx,76A7
lodsb
xlat
or	al,al
js	14D5
dec	si
pop	bx
push	es
push	di
mov	ax,ss
mov	es,ax
mov	di,9778
call	GETSTR
lodsb
cmp	al,2C
je	14F2
jmp	EAERR
mov	ax,ss
mov	es,ax
mov	di,9878
call	GETSTR
call	COMPSTRINGS
pop	di
pop	es
ret
GETSTRREAL1:
lodsb
stosb
cmp	al,22
jne	GETSTRREAL1
mov	byte	ptr	es:[di+FF],00
ret
GETSTRREAL2:
lodsb
stosb
cmp	al,27
jne	GETSTRREAL2
mov	byte	ptr	es:[di+FF],00
ret
GETSTR:
lodsb
cmp	al,22
je	GETSTRREAL1
cmp	al,27
je	GETSTRREAL2
dec	si
call	GETSTRINGADDR
push	ds
push	si
mov	si,cx
mov	ds,dx
GETSTRLP:
lodsb
stosb
or	al,al
jne	GETSTRLP
pop	si
pop	ds
ret
COMPSTRINGS:
push	ds
push	si
push	es
push	di
mov	ax,ss
mov	ds,ax
mov	es,ax
mov	si,9778
mov	di,9878
COMPLP:
lodsb
mov	dl,byte	ptr	es:[di]
inc	di
or	al,al
je	STRCMPSAME
or	dl,dl
je	STRCMPSAME2
cmp	al,dl
jne	STRCMPDIFF
jmp	COMPLP
STRCMPSAME2:
or	al,al
jne	STRCMPDIFF
STRCMPSAME:
or	dl,dl
jne	STRCMPDIFF
pop	di
pop	es
pop	si
pop	ds
mov	cx,FFFF
mov	dx,FFFF
ret
STRCMPDIFF:
pop	di
pop	es
pop	si
pop	ds
xor	cx,cx
xor	dx,dx
ret
NORMEXPRESS:
mov	ax,ss
mov	es,ax
mov	di,0BCB
lodsw
mov	word	ptr	[0BCF],ax
lodsw
mov	word	ptr	[0BCB],ax
lodsw
mov	word	ptr	[0BCD],ax
NEXPLOOP:
lodsw
NEXPLOOP2:
mov	dx,ax
and	dx,00FF
mov	cx,word	ptr	es:[di+04]
and	cx,00FF
cmp	dx,cx
ja	HIGHER
push	ax
xor	ah,ah
mov	al,byte	ptr	es:[di+05]
mov	bp,ax
jmp	word	ptr	[bp+6CDB]
HIGHER:
mov	word	ptr	es:[di+FE],ax
lodsw
mov	word	ptr	es:[di+FA],ax
lodsw
mov	word	ptr	es:[di+FC],ax
sub	di,06
jmp	NEXPLOOP
NCALC:
pop	ax
jmp	NEXPLOOP2
CALCEND:
mov	cx,word	ptr	es:[di]
mov	dx,word	ptr	es:[di+02]
pop	ax
ret
CALCSHIFTR:
cmp	word	ptr	es:[di+02],00
jne	N_TOOBIGSHIFT
mov	cx,word	ptr	es:[di]
cmp	cx,20
ja	N_TOOBIGSHIFT
mov	ax,word	ptr	es:[di+08]
mov	dx,word	ptr	es:[di+06]
cmp	cx,00
je	EASR2
EASR1:
shr	ax,1
rcr	dx,1
dec	cx
jne	EASR1
EASR2:
mov	word	ptr	es:[di+08],ax
mov	word	ptr	es:[di+06],dx
add	di,06
jmp	NCALC
N_TOOBIGSHIFT:
test	byte	ptr	ss:[0AD0],FF
jne	N_FR
push	dx
mov	dx,843A
call	ERROR_ROUT
pop	dx
N_FR:
push	dx
mov	dx,843A
call	INSFRERR1
pop	dx
mov	cx,0001
xor	dx,dx
jmp	CALCEND
CALCSHIFTL:
cmp	word	ptr	es:[di+02],00
jne	N_TOOBIGSHIFT
mov	cx,word	ptr	es:[di]
cmp	cx,20
ja	N_TOOBIGSHIFT
mov	ax,word	ptr	es:[di+08]
mov	dx,word	ptr	es:[di+06]
cmp	cx,00
je	EASL2
EASL1:
shl	dx,1
rcl	ax,1
dec	cx
jne	EASL1
EASL2:
mov	word	ptr	es:[di+08],ax
mov	word	ptr	es:[di+06],dx
add	di,06
jmp	NCALC
CALCEQ:
mov	ax,word	ptr	es:[di+08]
cmp	ax,word	ptr	es:[di+02]
jne	CALCEQ_F
mov	ax,word	ptr	es:[di+06]
cmp	ax,word	ptr	es:[di]
jne	CALCEQ_F
mov	word	ptr	es:[di+06],FFFF
mov	word	ptr	es:[di+08],FFFF
add	di,06
jmp	NCALC
CALCEQ_F:
mov	word	ptr	es:[di+06],0000
mov	word	ptr	es:[di+08],0000
add	di,06
jmp	NCALC
CALCGT:
mov	ax,word	ptr	es:[di+08]
cmp	ax,word	ptr	es:[di+02]
jb	CALCEQ_F
mov	ax,word	ptr	es:[di+06]
cmp	ax,word	ptr	es:[di]
jbe	CALCEQ_F
mov	word	ptr	es:[di+06],FFFF
mov	word	ptr	es:[di+08],FFFF
add	di,06
jmp	NCALC
CALCLT:
mov	ax,word	ptr	es:[di+08]
cmp	ax,word	ptr	es:[di+02]
ja	CALCEQ_F
mov	ax,word	ptr	es:[di+06]
cmp	ax,word	ptr	es:[di]
jae	CALCEQ_F
mov	word	ptr	es:[di+06],FFFF
mov	word	ptr	es:[di+08],FFFF
add	di,06
jmp	NCALC
CALCADD:
mov	ax,word	ptr	es:[di+06]
add	ax,word	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
mov	ax,word	ptr	es:[di+08]
adc	ax,word	ptr	es:[di+02]
mov	word	ptr	es:[di+08],ax
add	di,06
jmp	NCALC
CALCSUB:
mov	ax,word	ptr	es:[di+06]
sub	ax,word	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
mov	ax,word	ptr	es:[di+08]
sbb	ax,word	ptr	es:[di+02]
mov	word	ptr	es:[di+08],ax
add	di,06
jmp	NCALC
CALCMUL:
mov	ax,word	ptr	es:[di]
mov	dx,word	ptr	es:[di+02]
mov	cx,word	ptr	es:[di+08]
mov	bx,word	ptr	es:[di+06]
push	si
mov	si,dx
xchg	cx,ax
or	ax,ax
je	EM1
mul	cx
EM1:
xchg	si,ax
or	ax,ax
je	EM2
mul	bx
add	si,ax
EM2:
mov	ax,cx
mul	bx
add	dx,si
pop	si
mov	word	ptr	es:[di+08],dx
mov	word	ptr	es:[di+06],ax
add	di,06
jmp	NCALC
ULDIV:
or	dx,dx
jne	D3
div	bx
mov	bx,dx
mov	dx,cx
ret
D3:
mov	cx,ax
mov	ax,dx
xor	dx,dx
div	bx
xchg	cx,ax
div	bx
mov	bx,dx
mov	dx,cx
xor	cx,cx
ret
_ULDIV:
jcxz	ULDIV
push	di
push	bp
mov	bp,0001
or	ch,ch
js	L1
jne	L2
add	bp,08
mov	ch,cl
mov	cl,bh
mov	bh,bl
xor	bl,bl
or	ch,ch
js	L1
L2:
inc	bp
shl	bx,1
rcl	cx,1
jno	L2
L1:
mov	si,cx
mov	di,bx
mov	cx,dx
mov	bx,ax
xor	ax,ax
cwd
L4:
cmp	si,cx
ja	L3
jb	L5
cmp	di,bx
ja	L3
L5:
sub	bx,di
sbb	cx,si
stc
L3:
rcl	ax,1
rcl	dx,1
shr	si,1
rcr	di,1
dec	bp
jne	L4
pop	bp
pop	di
ret
L10:
or	cx,cx
jns	_ULDIV
neg	cx
neg	bx
sbb	cx,00
call	_ULDIV
L12:
neg	dx
neg	ax
sbb	dx,00
ret
CALCMOD:
mov	dx,word	ptr	ss:[di+02]
mov	ax,word	ptr	ss:[di]
mov	cx,word	ptr	ss:[di+08]
or	cx,cx
jne	CLMODER
mov	cx,word	ptr	ss:[di+06]
or	cx,cx
je	CLMODER
div	cx
mov	word	ptr	ss:[di+06],dx
xor	dx,dx
mov	word	ptr	ss:[di+08],dx
add	di,06
jmp	NCALC
CLMODER:
push	dx
mov	dx,847A
call	ERROR_ROUT
pop	dx
CALCDIV:
push	si
mov	dx,word	ptr	es:[di+08]
mov	ax,word	ptr	es:[di+06]
mov	cx,word	ptr	es:[di+02]
mov	bx,word	ptr	es:[di]
or	bx,bx
je	EDIVZ
EDIV1:
call	_LDIV
mov	word	ptr	es:[di+08],dx
mov	word	ptr	es:[di+06],ax
pop	si
add	di,06
jmp	NCALC
EDIVZ:
or	cx,cx
jne	EDIV1
push	dx
mov	dx,846A
call	ERROR_ROUT
pop	dx
_LDIV:
or	dx,dx
jns	L10
neg	dx
neg	ax
sbb	dx,00
or	cx,cx
jns	L11
neg	cx
neg	bx
sbb	cx,00
call	_ULDIV
neg	cx
neg	bx
sbb	cx,00
ret
L11:
call	_ULDIV
neg	cx
neg	bx
sbb	cx,00
jmp	L12
CALCOR:
mov	ax,word	ptr	es:[di+08]
or	ax,word	ptr	es:[di+02]
mov	word	ptr	es:[di+08],ax
mov	ax,word	ptr	es:[di+06]
or	ax,word	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
add	di,06
jmp	NCALC
CALCAND:
mov	ax,word	ptr	es:[di+08]
and	ax,word	ptr	es:[di+02]
mov	word	ptr	es:[di+08],ax
mov	ax,word	ptr	es:[di+06]
and	ax,word	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
add	di,06
jmp	NCALC
CALCXOR:
mov	ax,word	ptr	es:[di+08]
xor	ax,word	ptr	es:[di+02]
mov	word	ptr	es:[di+08],ax
mov	ax,word	ptr	es:[di+06]
xor	ax,word	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
add	di,06
jmp	NCALC
CALCNOT:
mov	ax,word	ptr	es:[di]
not	ax
mov	word	ptr	es:[di+06],ax
mov	ax,word	ptr	es:[di+02]
not	ax
mov	word	ptr	es:[di+08],ax
add	di,06
jmp	NCALC
CALCNEG:
xor	ax,ax
sub	ax,word	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
mov	ax,0000
sbb	ax,word	ptr	es:[di+02]
mov	word	ptr	es:[di+08],ax
add	di,06
jmp	NCALC
CALCHIBYTE:
xor	ax,ax
mov	word	ptr	es:[di+08],ax
mov	al,byte	ptr	es:[di+01]
mov	word	ptr	es:[di+06],ax
add	di,06
jmp	NCALC
CALCLOBYTE:
xor	ax,ax
mov	word	ptr	es:[di+08],ax
mov	al,byte	ptr	es:[di]
mov	word	ptr	es:[di+06],ax
add	di,06
jmp	NCALC
FREXPRESS:
mov	byte	ptr	ss:[0ACE],00
mov	di,0BCB
lodsw
test	al,80
je	1926
mov	es,word	ptr	[si]
mov	bp,word	ptr	[si+02]
test	byte	ptr	es:[bp+04],52
jne	FEXPERR
mov	dx,word	ptr	es:[bp+0C]
mov	word	ptr	[si],dx
mov	dx,word	ptr	es:[bp+0A]
mov	word	ptr	[si+02],dx
and	ax,FF7F
mov	word	ptr	[0BCF],ax
lodsw
mov	word	ptr	[0BCB],ax
lodsw
mov	word	ptr	[0BCD],ax
FEXPLOOP:
lodsw
test	al,80
je	FEXPLOOP2
mov	es,word	ptr	[si]
mov	bp,word	ptr	[si+02]
test	byte	ptr	es:[bp+04],52
jne	FEXPERR
mov	dx,word	ptr	es:[bp+0C]
mov	word	ptr	[si],dx
mov	dx,word	ptr	es:[bp+0A]
mov	word	ptr	[si+02],dx
and	ax,FF7F
FEXPLOOP2:
mov	dx,ax
and	dx,00FF
mov	cx,word	ptr	ss:[di+04]
and	cx,00FF
cmp	dx,cx
ja	FHIGHER
push	ax
xor	ah,ah
mov	al,byte	ptr	ss:[di+05]
mov	bp,ax
jmp	word	ptr	[bp+6D03]
FHIGHER:
mov	word	ptr	ss:[di+FE],ax
lodsw
mov	word	ptr	ss:[di+FA],ax
lodsw
mov	word	ptr	ss:[di+FC],ax
sub	di,06
jmp	FEXPLOOP
FCALC:
pop	ax
jmp	FEXPLOOP2
FEXPERR:
mov	word	ptr	ss:[9A8C],es
mov	word	ptr	ss:[9A8E],bp
xor	cx,cx
xor	dx,dx
mov	al,01
or	al,al
ret
FCALCEND:
mov	cx,word	ptr	ss:[di]
mov	dx,word	ptr	ss:[di+02]
pop	ax
ret
FCALCSHIFTR:
cmp	word	ptr	ss:[di+02],00
jne	FTOOBIGSHIFT
mov	cx,word	ptr	ss:[di]
cmp	cx,20
ja	FTOOBIGSHIFT
mov	ax,word	ptr	ss:[di+08]
mov	dx,word	ptr	ss:[di+06]
cmp	cx,00
je	FEASR2
FEASR1:
shr	ax,1
rcr	dx,1
dec	cx
jne	FEASR1
FEASR2:
mov	word	ptr	ss:[di+08],ax
mov	word	ptr	ss:[di+06],dx
add	di,06
jmp	FCALC
FTOOBIGSHIFT:
push	dx
mov	dx,843A
call	ERROR_ROUT
pop	dx
FCALCSHIFTL:
cmp	word	ptr	ss:[di+02],00
jne	FTOOBIGSHIFT
mov	cx,word	ptr	ss:[di]
cmp	cx,20
ja	FTOOBIGSHIFT
mov	ax,word	ptr	ss:[di+08]
mov	dx,word	ptr	ss:[di+06]
cmp	cx,00
je	FEASL2
FEASL1:
shl	dx,1
rcl	ax,1
dec	cx
jne	FEASL1
FEASL2:
mov	word	ptr	ss:[di+08],ax
mov	word	ptr	ss:[di+06],dx
add	di,06
jmp	FCALC
FCALCEQ:
mov	ax,word	ptr	ss:[di+08]
cmp	ax,word	ptr	ss:[di+02]
jne	FCALCEQ_F
mov	ax,word	ptr	ss:[di+06]
cmp	ax,word	ptr	ss:[di]
jne	FCALCEQ_F
mov	word	ptr	ss:[di+06],FFFF
mov	word	ptr	ss:[di+08],FFFF
add	di,06
jmp	FCALC
FCALCEQ_F:
mov	word	ptr	ss:[di+06],0000
mov	word	ptr	ss:[di+08],0000
add	di,06
jmp	FCALC
FCALCGT:
mov	ax,word	ptr	ss:[di+08]
cmp	ax,word	ptr	ss:[di+02]
jb	FCALCEQ_F
mov	ax,word	ptr	ss:[di+06]
cmp	ax,word	ptr	ss:[di]
jbe	FCALCEQ_F
mov	word	ptr	ss:[di+06],FFFF
mov	word	ptr	ss:[di+08],FFFF
add	di,06
jmp	FCALC
FCALCLT:
mov	ax,word	ptr	ss:[di+08]
cmp	ax,word	ptr	ss:[di+02]
ja	FCALCEQ_F
mov	ax,word	ptr	ss:[di+06]
cmp	ax,word	ptr	ss:[di]
jae	FCALCEQ_F
mov	word	ptr	ss:[di+06],FFFF
mov	word	ptr	ss:[di+08],FFFF
add	di,06
jmp	FCALC
FCALCADD:
mov	ax,word	ptr	ss:[di+06]
add	ax,word	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
mov	ax,word	ptr	ss:[di+08]
adc	ax,word	ptr	ss:[di+02]
mov	word	ptr	ss:[di+08],ax
add	di,06
jmp	FCALC
FCALCSUB:
mov	ax,word	ptr	ss:[di+06]
sub	ax,word	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
mov	ax,word	ptr	ss:[di+08]
sbb	ax,word	ptr	ss:[di+02]
mov	word	ptr	ss:[di+08],ax
add	di,06
jmp	FCALC
FCALCMUL:
mov	ax,word	ptr	ss:[di]
mov	dx,word	ptr	ss:[di+02]
mov	cx,word	ptr	ss:[di+08]
mov	bx,word	ptr	ss:[di+06]
push	si
mov	si,dx
xchg	cx,ax
or	ax,ax
je	FEM1
mul	cx
FEM1:
xchg	si,ax
or	ax,ax
je	FEM2
mul	bx
add	si,ax
FEM2:
mov	ax,cx
mul	bx
add	dx,si
pop	si
mov	word	ptr	ss:[di+08],dx
mov	word	ptr	ss:[di+06],ax
add	di,06
jmp	FCALC
FULDIV:
or	dx,dx
jne	FD3
div	bx
mov	bx,dx
mov	dx,cx
ret
FD3:
mov	cx,ax
mov	ax,dx
xor	dx,dx
div	bx
xchg	cx,ax
div	bx
mov	bx,dx
mov	dx,cx
xor	cx,cx
ret
F_ULDIV:
jcxz	FULDIV
push	di
push	bp
mov	bp,0001
or	ch,ch
js	FL1
jne	FL2
add	bp,08
mov	ch,cl
mov	cl,bh
mov	bh,bl
xor	bl,bl
or	ch,ch
js	FL1
FL2:
inc	bp
shl	bx,1
rcl	cx,1
jno	FL2
FL1:
mov	si,cx
mov	di,bx
mov	cx,dx
mov	bx,ax
xor	ax,ax
cwd
FL4:
cmp	si,cx
ja	FL3
jb	FL5
cmp	di,bx
ja	FL3
FL5:
sub	bx,di
sbb	cx,si
stc
FL3:
rcl	ax,1
rcl	dx,1
shr	si,1
rcr	di,1
dec	bp
jne	FL4
pop	bp
pop	di
ret
FL10:
or	cx,cx
jns	F_ULDIV
neg	cx
neg	bx
sbb	cx,00
call	F_ULDIV
FL12:
neg	dx
neg	ax
sbb	dx,00
ret
FCALCMOD:
mov	dx,word	ptr	ss:[di+02]
mov	ax,word	ptr	ss:[di]
mov	cx,word	ptr	ss:[di+08]
or	cx,cx
jne	FCLMODER
mov	cx,word	ptr	ss:[di+06]
or	cx,cx
je	FCLMODER
div	cx
mov	word	ptr	ss:[di+06],dx
xor	dx,dx
mov	word	ptr	ss:[di+08],dx
add	di,06
jmp	FCALC
FCLMODER:
push	dx
mov	dx,847A
call	INSFRERR1
pop	dx
FCALCDIV:
push	si
mov	dx,word	ptr	ss:[di+08]
mov	ax,word	ptr	ss:[di+06]
mov	cx,word	ptr	ss:[di+02]
mov	bx,word	ptr	ss:[di]
or	bx,bx
je	FEDIVZ
FEDIV1:
call	F_LDIV
FEDIV2:
mov	word	ptr	ss:[di+08],dx
mov	word	ptr	ss:[di+06],ax
pop	si
add	di,06
jmp	FCALC
FEDIVZ:
or	cx,cx
jne	FEDIV1
xor	ax,ax
mov	dx,ax
jmp	FEDIV2
F_LDIV:
or	dx,dx
jns	FL10
neg	dx
neg	ax
sbb	dx,00
or	cx,cx
jns	FL11
neg	cx
neg	bx
sbb	cx,00
call	F_ULDIV
neg	cx
neg	bx
sbb	cx,00
ret
FL11:
call	F_ULDIV
neg	cx
neg	bx
sbb	cx,00
jmp	FL12
FCALCOR:
mov	ax,word	ptr	ss:[di+08]
or	ax,word	ptr	ss:[di+02]
mov	word	ptr	ss:[di+08],ax
mov	ax,word	ptr	ss:[di+06]
or	ax,word	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
add	di,06
jmp	FCALC
FCALCAND:
mov	ax,word	ptr	ss:[di+08]
and	ax,word	ptr	ss:[di+02]
mov	word	ptr	ss:[di+08],ax
mov	ax,word	ptr	ss:[di+06]
and	ax,word	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
add	di,06
jmp	FCALC
FCALCXOR:
mov	ax,word	ptr	ss:[di+08]
xor	ax,word	ptr	ss:[di+02]
mov	word	ptr	ss:[di+08],ax
mov	ax,word	ptr	ss:[di+06]
xor	ax,word	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
add	di,06
jmp	FCALC
FCALCNOT:
mov	ax,word	ptr	ss:[di]
not	ax
mov	word	ptr	ss:[di+06],ax
mov	ax,word	ptr	ss:[di+02]
not	ax
mov	word	ptr	ss:[di+08],ax
add	di,06
jmp	FCALC
FCALCNEG:
xor	ax,ax
sub	ax,word	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
mov	ax,0000
sbb	ax,word	ptr	ss:[di+02]
mov	word	ptr	ss:[di+08],ax
add	di,06
jmp	FCALC
FCALCHIBYTE:
xor	ax,ax
mov	word	ptr	ss:[di+08],ax
mov	al,byte	ptr	ss:[di+01]
mov	word	ptr	ss:[di+06],ax
add	di,06
jmp	FCALC
FCALCLOBYTE:
xor	ax,ax
mov	word	ptr	ss:[di+08],ax
mov	al,byte	ptr	ss:[di]
mov	word	ptr	ss:[di+06],ax
add	di,06
jmp	FCALC
ADD_ASSEMVARS:
mov	ax,ss
mov	ds,ax
mov	es,ax
mov	si,24A4
VARSLP:
lodsw
or	ax,ax
je	VARSEND
mov	di,ax
mov	ax,word	ptr	[0F76]
stosw
mov	ax,word	ptr	[0F78]
stosw
mov	word	ptr	ss:[0F92],0000
mov	word	ptr	ss:[0F94],0000
call	ADDSYMBOL
inc	si
jmp	VARSLP
VARSEND:
call	far	ptr	_OS2GETDATE
push	cx
mov	bx,dx
and	bx,00FF
mov	dl,bl
xchg	dh,dl
push	dx
xor	bx,bx
mov	ax,07C8
YEARLP:
cmp	cx,ax
je	GOTYEAR
add	bx,016D
test	cx,0003
jne	NOTLEAP
inc	bx
NOTLEAP:
inc	ax
jmp	YEARLP
GOTYEAR:
mov	di,8C17
test	cx,0003
jne	NOTLEAP2
mov	di,8C31
NOTLEAP2:
mov	al,01
MONTHLP:
cmp	dl,al
je	GOTMONTH
mov	cl,al
and	cx,00FF
add	cx,cx
add	cx,di
mov	si,cx
add	bx,word	ptr	ss:[si]
inc	al
jmp	MONTHLP
GOTMONTH:
dec	cl
mov	cl,dh
and	cx,00FF
add	bx,cx
mov	cx,bx
xor	dx,dx
mov	ax,bx
mov	bx,0007
div	bx
mul	bx
sub	cx,ax
mov	bx,cx
add	bx,bx
mov	bx,word	ptr	ss:[bx+8C4B]
mov	ax,ss
mov	es,ax
mov	di,9778
mov	al,09
stosb
mov	ax,4144
stosw
mov	ax,4554
stosw
mov	ax,535F
stosw
mov	ax,5254
stosw
mov	ax,365B
stosw
mov	ax,5D34
stosw
mov	ax,223D
stosw
DAYLP:
mov	al,byte	ptr	ss:[bx]
inc	bx
stosb
or	al,al
jne	DAYLP
dec	di
mov	al,20
stosb
pop	cx
push	cx
and	cx,FF00
xchg	cl,ch
xor	dx,dx
call	BIN2DECL
mov	di,word	ptr	ss:[2488]
dec	di
mov	ax,6874
pop	bx
cmp	bh,01
jne	NOT1ST
mov	ax,7473
NOT1ST:
cmp	bh,02
jne	NOT2ND
mov	ax,646E
NOT2ND:
cmp	bh,03
jne	NOT3RD
mov	ax,6472
NOT3RD:
stosw
mov	al,20
stosb
and	bx,00FF
add	bx,bx
mov	bx,word	ptr	ss:[bx+8C92]
MONLP:
mov	al,byte	ptr	ss:[bx]
inc	bx
stosb
or	al,al
jne	MONLP
dec	di
mov	al,20
stosb
pop	cx
xor	dx,dx
call	BIN2DECL
mov	di,word	ptr	ss:[2488]
dec	di
mov	al,22
stosb
mov	al,0D
stosb
mov	al,0A
stosb
mov	bx,76A7
mov	ax,ss
mov	ds,ax
mov	si,9778
call	P_STRING
ret
MOREFR:
push	ax
push	bx
push	cx
push	dx
push	ds
push	es
push	si
push	di
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jae	1E12
jmp	_CANTALLOC
mov	es,word	ptr	ss:[0AC5]
xor	di,di
mov	word	ptr	es:[di],ax
mov	word	ptr	[0AC5],ax
mov	word	ptr	ss:[0AC7],0002
mov	word	ptr	ss:[0AC9],0002
pop	di
pop	si
pop	es
pop	ds
pop	dx
pop	cx
pop	bx
pop	ax
ret
MOREEXT:
push	ax
push	bx
push	cx
push	dx
push	ds
push	es
push	si
push	di
mov	bx,0401
call	far	ptr	_OS2ALLOCSEG
jae	1E4C
jmp	_CANTALLOC
mov	es,word	ptr	ss:[13A6]
xor	di,di
mov	word	ptr	es:[di],ax
mov	word	ptr	[13A6],ax
mov	word	ptr	ss:[13A8],0002
pop	di
pop	si
pop	es
pop	ds
pop	dx
pop	cx
pop	bx
pop	ax
ret
MORESYM:
push	ax
push	bx
push	cx
push	dx
push	ds
push	es
push	si
push	di
mov	bx,06D7
call	far	ptr	_OS2ALLOCSEG
jae	1E7F
jmp	_CANTALLOC
mov	word	ptr	[0F76],ax
mov	word	ptr	ss:[0F78],0000
pop	di
pop	si
pop	es
pop	ds
pop	dx
pop	cx
pop	bx
pop	ax
ret
MOREHEAP:
push	ax
push	bx
push	cx
push	dx
push	ds
push	es
push	si
push	di
mov	bx,0201
call	far	ptr	_OS2ALLOCSEG
jae	1EA8
jmp	_CANTALLOC
mov	es,word	ptr	ss:[0ED9]
xor	di,di
mov	word	ptr	es:[di],ax
mov	word	ptr	[0ED9],ax
mov	word	ptr	ss:[0EDB],0002
pop	di
pop	si
pop	es
pop	ds
pop	dx
pop	cx
pop	bx
pop	ax
ret
MORESTRING:
push	ax
push	bx
push	cx
push	dx
push	ds
push	es
push	si
push	di
mov	bx,0201
call	far	ptr	_OS2ALLOCSEG
jae	1EDB
jmp	_CANTALLOC
mov	es,word	ptr	ss:[0ED5]
xor	di,di
mov	word	ptr	es:[di],ax
mov	word	ptr	[0ED5],ax
mov	word	ptr	ss:[0ED7],0002
pop	di
pop	si
pop	es
pop	ds
pop	dx
pop	cx
pop	bx
pop	ax
ret
MORESYMTX:
push	ax
push	bx
push	cx
push	dx
push	ds
push	es
push	si
push	di
mov	bx,0401
call	far	ptr	_OS2ALLOCSEG
jae	1F0E
jmp	_CANTALLOC
mov	word	ptr	[0F72],ax
mov	word	ptr	ss:[0F74],0000
pop	di
pop	si
pop	es
pop	ds
pop	dx
pop	cx
pop	bx
pop	ax
ret
GETMEM:
mov	bx,0401
call	far	ptr	_OS2ALLOCSEG
jae	1F2F
jmp	_CANTALLOC
mov	word	ptr	[0F72],ax
mov	word	ptr	ss:[0F74],0000
mov	bx,0201
call	far	ptr	_OS2ALLOCSEG
jae	1F47
jmp	_CANTALLOC
mov	word	ptr	[0ED9],ax
mov	word	ptr	ss:[0EDB],0002
mov	bx,0201
call	far	ptr	_OS2ALLOCSEG
jae	1F5F
jmp	_CANTALLOC
mov	word	ptr	[0ED3],ax
mov	word	ptr	[0ED5],ax
mov	word	ptr	ss:[0ED7],0002
mov	es,ax
mov	word	ptr	es:[0000],0000
mov	word	ptr	es:[0002],FFFF
mov	bx,06D7
call	far	ptr	_OS2ALLOCSEG
jae	1F8B
jmp	_CANTALLOC
mov	word	ptr	[0F76],ax
mov	word	ptr	ss:[0F78],0000
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jae	1FA3
jmp	_CANTALLOC
mov	word	ptr	[0AA2],ax
mov	word	ptr	ss:[0AA4],0000
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jb	_CANTALLOC
mov	word	ptr	[13AC],ax
mov	word	ptr	[13B6],ax
mov	word	ptr	[13B0],ax
mov	word	ptr	ss:[13AE],0000
mov	word	ptr	ss:[13B8],0000
mov	word	ptr	ss:[13B2],0000
mov	es,ax
xor	di,di
xor	al,al
mov	cx,0013
CLROBJ:
stosb
dec	cx
jne	CLROBJ
mov	word	ptr	ss:[13B4],di
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jb	_CANTALLOC
mov	word	ptr	[0ACB],ax
mov	word	ptr	[0AC5],ax
mov	word	ptr	ss:[0AC7],0002
mov	word	ptr	ss:[0AC9],0002
mov	bx,0401
call	far	ptr	_OS2ALLOCSEG
jb	_CANTALLOC
mov	word	ptr	[13A4],ax
mov	word	ptr	[13A6],ax
mov	word	ptr	ss:[13A8],0002
ret
_CANTALLOC:
mov	dx,7C3F
call	FATALERR_ROUT
jmp	STOPASSEM
LISTLINE:
push	bx
push	ds
push	si
push	es
push	di
mov	word	ptr	ss:[9A86],di
mov	al,byte	ptr	[0EE3]
mov	byte	ptr	ss:[0EE3],00
or	al,al
jne	_NOTM
cmp	word	ptr	ss:[0AA6],00
je	_NOTM
cmp	byte	ptr	ss:[13EB],00
jne	_NOTM
jmp	_NOLIST
MUSTDOL:
_NOTM:
std
cmp	bp,word	ptr	ss:[248A]
jne	LLLP2
cld
jmp	_NOLIST
LLLP2:
lodsb
cmp	al,0A
je	LLGOTCR
cmp	si,FF
jne	LLLP2
dec	si
LLGOTCR:
cld
inc	si
inc	si
push	si
call	NEEDCR
call	GETLINE
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8995
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
mov	ax,word	ptr	[0F92]
mov	word	ptr	[9A82],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	[9A84],ax
mov	cx,word	ptr	ss:[9A86]
sub	cx,word	ptr	ss:[0F90]
sub	word	ptr	ss:[9A84],cx
sbb	byte	ptr	ss:[9A82],00
push	dx
push	cx
mov	dx,word	ptr	ss:[9A82]
mov	cx,word	ptr	ss:[9A84]
call	PRTHEXL
pop	cx
pop	dx
cmp	word	ptr	ss:[0AA6],00
je	NOLMAC
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8997
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
NOLMAC:
cmp	byte	ptr	ss:[0F8C],00
je	NOLIF
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,899A
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
NOLIF:
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8995
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
pop	si
pop	di
pop	es
push	es
push	di
mov	cx,di
sub	cx,word	ptr	ss:[0F90]
je	NOCODE
and	cx,07
mov	di,word	ptr	ss:[0F90]
LLPLP:
mov	al,byte	ptr	es:[di]
inc	di
call	PRTHEXB
dec	cx
jne	LLPLP
NOCODE:
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8995
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
mov	ax,ss
mov	es,ax
mov	di,8A6E
xor	cx,cx
LLLP3:
lodsb
stosb
inc	cx
cmp	al,1A
je	LLEOF
cmp	al,0D
jne	LLLP3
jmp	LLLF
LLEOF:
mov	al,0D
stosb
LLLF:
mov	al,0A
stosb
inc	cx
mov	ax,ss
mov	ds,ax
mov	ax,4002
mov	bx,0001
mov	dx,8A6E
call	far	ptr	_OS2WRITEBYTES
_NOLIST:
pop	di
pop	es
pop	si
pop	ds
pop	bx
ret
pop	di
pop	es
pop	si
pop	ds
pop	bx
ret
ERROR_ROUT:
and	byte	ptr	ss:[0F8B],FE
push	word	ptr	ss:[247D]
mov	byte	ptr	ss:[247D],00
push	word	ptr	ss:[2474]
mov	word	ptr	ss:[2474],0000
mov	word	ptr	ss:[13E2],ds
mov	word	ptr	ss:[13E4],si
push	es
push	ax
push	di
push	ds
push	si
call	GETLINE
cmp	ax,word	ptr	ss:[0EDF]
je	ERRSUPDO
mov	word	ptr	[0EDF],ax
mov	al,byte	ptr	[0EE1]
or	al,al
je	ERROK2
mov	dx,7CF5
call	FATALERR_ROUT
jmp	STOPASSEM
ERROK2:
call	NEEDCR
mov	si,dx
inc	dx
mov	al,byte	ptr	ss:[si]
or	al,al
je	ERRORT
mov	cx,8A5A
inc	word	ptr	ss:[13C6]
jmp	DONEEW
ERRORT:
mov	cx,8A54
inc	word	ptr	ss:[13C4]
DONEEW:
mov	al,byte	ptr	[13E9]
or	al,al
jne	ERRSUPDO
mov	word	ptr	ss:[13DE],cx
mov	word	ptr	ss:[13E0],dx
mov	ax,ss
mov	ds,ax
mov	si,2557
mov	byte	ptr	ss:[0EE1],01
call	P_PRINTF2
mov	byte	ptr	ss:[0EE1],00
mov	byte	ptr	ss:[0EE3],01
ERRSUPDO:
mov	word	ptr	ss:[2472],8A6E
mov	ax,word	ptr	[13C4]
cmp	ax,word	ptr	ss:[13FD]
jb	ERRROK
mov	dx,7EB4
call	FATALERR_ROUT
jmp	STOPASSEM
ERRROK:
pop	si
pop	ds
pop	di
pop	ax
pop	es
pop	word	ptr	ss:[2474]
pop	word	ptr	ss:[247D]
mov	ss,word	ptr	ss:[24A0]
mov	sp,word	ptr	ss:[24A2]
test	byte	ptr	ss:[0F8B],02
je	NSLL1
and	byte	ptr	ss:[0F8B],FD
mov	ds,word	ptr	ss:[13E2]
mov	si,word	ptr	ss:[13E4]
call	LISTLINE
NSLL1:
lodsb
cmp	al,0D
jne	NSLL1
inc	si
inc	word	ptr	ss:[13F0]
mov	al,byte	ptr	[0F8D]
or	al,al
jne	226D
jmp	DO_65816
jmp	DO_MARIO
NEEDCR:
mov	al,byte	ptr	[247C]
or	al,al
je	NONEEDCR
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,2552
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
mov	byte	ptr	ss:[247C],00
NONEEDCR:
ret
FATALERR_ROUT:
push	ds
push	es
push	ax
push	di
push	dx
mov	ax,ss
mov	ds,ax
mov	es,ax
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A3C
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
mov	ds,word	ptr	ss:[0F98]
mov	dx,word	ptr	ss:[0F9A]
mov	si,dx
xor	cx,cx
FERRLP:
inc	cx
lodsb
or	al,al
jne	FERRLP
mov	bx,0001
call	far	ptr	_OS2WRITEBYTES
mov	ax,es
mov	ds,ax
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,899D
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
call	GETLINE
mov	word	ptr	[9A7C],ax
push	cx
mov	byte	ptr	ss:[2480],00
mov	cx,word	ptr	ss:[9A7C]
call	PRTDECW
pop	cx
mov	ax,ss
mov	es,ax
mov	di,8A6E
mov	al,2F
stosb
call	GETLINE_MACROS
mov	cx,ax
mov	al,24
stosb
dec	di
or	cx,cx
je	FERNOM
mov	cx,0002
call	BIN2DECW
FERNOM:
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A6E
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,899F
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,89A3
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
pop	dx
inc	dx
call	far	ptr	_OS2PRTSTRING
inc	word	ptr	ss:[13C4]
mov	bx,76A7
pop	di
pop	ax
pop	es
pop	ds
ret
GETLINE_MACROS:
push	bp
mov	bp,word	ptr	ss:[0F9C]
test	byte	ptr	[bp+14],05
je	GLESNOTCUR
mov	ax,word	ptr	[13F0]
pop	bp
ret
GLESNOTCUR:
sub	bp,1F
test	byte	ptr	[bp+14],05
je	GLESNOTCUR
add	bp,1F
push	ds
push	si
GLESLP:
mov	ds,word	ptr	[bp+1D]
mov	si,word	ptr	[bp+1F]
GLESLP2:
lodsb
stosb
inc	dl
or	al,al
jne	GLESLP2
mov	byte	ptr	es:[di+FF],2F
add	bp,1F
cmp	bp,word	ptr	ss:[0F9C]
jbe	GLESLP
mov	ax,word	ptr	[13F0]
pop	si
pop	ds
pop	bp
ret
GETLINE:
push	bp
mov	bp,word	ptr	ss:[0F9C]
test	byte	ptr	[bp+14],05
jne	CURSRC
GLLP:
sub	bp,1F
test	byte	ptr	[bp+14],05
je	GLLP
mov	ax,word	ptr	[bp+15]
pop	bp
ret
CURSRC:
mov	ax,word	ptr	[13F0]
pop	bp
ret
PRINTLASTFNAME:
push	es
push	si
push	ds
mov	ax,ss
mov	ds,ax
mov	es,ax
mov	ds,word	ptr	ss:[0F98]
mov	dx,word	ptr	ss:[0F9A]
mov	si,dx
xor	cx,cx
FLP:
inc	cx
lodsb
or	al,al
jne	FLP
dec	cx
mov	bx,0001
call	far	ptr	_OS2WRITEBYTES
pop	ds
pop	si
pop	es
ret
ASSEMBLE:
mov	es,word	ptr	ss:[13AC]
mov	di,word	ptr	ss:[13B4]
mov	ax,ss
mov	ds,ax
mov	si,9068
mov	word	ptr	ss:[13F0],0001
mov	bx,76A7
xor	ax,ax
mov	word	ptr	[0AAE],ax
mov	word	ptr	[0AB6],ax
mov	word	ptr	[0AB2],ax
mov	word	ptr	[0AB4],ax
mov	word	ptr	[0AB0],ax
mov	word	ptr	[0AB8],ax
mov	word	ptr	[13FF],ax
mov	word	ptr	[0EDF],ax
mov	word	ptr	[248A],ax
push	ds
push	si
push	es
push	di
mov	ax,ss
mov	ds,ax
mov	si,925C
mov	es,ax
mov	di,9778
mov	al,09
stosb
mov	ax,4E49
stosw
mov	ax,5449
stosw
mov	ax,4946
stosw
mov	ax,454C
stosw
mov	ax,535F
stosw
mov	ax,5254
stosw
mov	ax,365B
stosw
mov	ax,5D34
stosw
mov	ax,223D
stosw
ASSLP:
lodsb
stosb
xlat
or	al,al
jns	ASSLP
dec	di
mov	al,22
stosb
mov	al,0D
stosb
mov	al,0A
stosb
mov	si,9778
HASHTABLEEND:
js	240B
call	P_STRING
pop	di
pop	es
pop	si
pop	ds
mov	word	ptr	ss:[24A0],ss
mov	word	ptr	ss:[24A2],sp
jmp	DO_65816
mov	bx,7827
xlat
mov	bx,76A7
or	al,al
je	249E
inc	al
je	24B2
jo	GOTEOLDO_65816
js	24E9
jmp	25C9
dec	si
call	ADDSYMBOL
DO_65816:
test	byte	ptr	ss:[0F8B],08
VARSINFO:
push	es
mov	cx,word	ptr	[bx]
or	byte	ptr	[si+03],dh
jmp	E_CTRLC_HIT
lodsb
cmp	al,09
jne	2487
mov	word	ptr	ss:[0F90],di
call	PARSE65816
mov	cx,di
sub	cx,word	ptr	ss:[0F90]
add	word	ptr	ss:[0F94],cx
adc	byte	ptr	ss:[0F92],00
GOTEOLDO_65816:
cmp	byte	ptr	ss:[0F8B],00
jne	2523
cmp	byte	ptr	[si+01],0A
jne	2507
inc	si
inc	si
inc	word	ptr	ss:[13F0]
cmp	di,7F00
jb	DO_65816
jmp	254A
cmp	byte	ptr	ss:[0F8B],00
jne	24FF
inc	si
inc	word	ptr	ss:[13F0]
cmp	di,7F00
jb	DO_65816
jmp	254A
dec	si
mov	word	ptr	ss:[0F90],di
jmp	2523
push	es
push	ds
pop	es
xchg	di,si
mov	al,0A
mov	cx,00FF
repne
scasb
xchg	di,si
pop	es
inc	word	ptr	ss:[13F0]
cmp	di,7F00
jb	DO_65816
jmp	254A
mov	al,byte	ptr	[0F8B]
test	al,01
je	253B
and	al,FE
push	ax
push	dx
mov	dx,7FAA
call	ERROR_ROUT
pop	dx
pop	ax
or	al,02
and	al,FE
test	al,04
je	2544
push	ax
call	LISTLINE
pop	ax
mov	byte	ptr	[0F8B],al
jmp	24D4
call	CALCLENLASTBLK
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jae	255A
jmp	_CANTALLOC
mov	word	ptr	[13AC],ax
mov	word	ptr	ss:[13AE],0000
mov	es,word	ptr	ss:[13B6]
mov	di,word	ptr	ss:[13B8]
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],0000
mov	ax,word	ptr	[13C0]
mov	cx,word	ptr	ss:[13C2]
mov	word	ptr	es:[di+04],ax
mov	word	ptr	es:[di+06],cx
mov	es,word	ptr	ss:[13AC]
xor	di,di
mov	word	ptr	ss:[13B6],es
mov	word	ptr	ss:[13B8],di
mov	byte	ptr	es:[di+10],01
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
call	CALCROMPOS
mov	word	ptr	[13BC],ax
mov	word	ptr	ss:[13BE],cx
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	es:[di+0E],cx
add	di,13
mov	word	ptr	ss:[13B4],di
mov	bx,76A7
jmp	DO_65816
cmp	al,03
jne	25D8
push	dx
mov	dx,837E
call	ERROR_ROUT
pop	dx
jmp	24B2
mov	bp,word	ptr	ss:[0F9C]
mov	al,byte	ptr	[bp+14]
test	al,02
jne	2619
test	al,08
jne	2610
test	al,01
jne	25FC
test	al,04
je	25F6
call	READMORESOURCE
jmp	DO_65816
mov	dx,7EDC
call	FATALERR_ROUT
mov	bx,word	ptr	[bp+02]
call	far	ptr	_OS2CLOSEFILE
push	es
mov	es,word	ptr	[bp+10]
call	far	ptr	_OS2FREESEG
pop	es
jmp	261E
mov	ax,word	ptr	[0F96]
mov	word	ptr	[bp+E5],ax
jmp	261E
dec	word	ptr	ss:[0AA6]
mov	ax,word	ptr	[13F0]
add	word	ptr	ss:[13D2],ax
adc	word	ptr	ss:[13D0],00
sub	bp,1F
push	es
push	di
mov	ds,word	ptr	[bp+0C]
mov	si,word	ptr	[bp+0E]
mov	ax,word	ptr	[bp+04]
cmp	word	ptr	ss:[0F96],ax
je	2645
jmp	E_CONDUNBAL
mov	word	ptr	[0F96],ax
mov	ax,word	ptr	[bp+00]
cmp	word	ptr	ss:[1470],ax
je	2656
jmp	E_REPTUNBAL
mov	word	ptr	[1470],ax
mov	ax,word	ptr	[bp+15]
mov	word	ptr	[13F0],ax
mov	ax,word	ptr	[bp+0A]
mov	es,word	ptr	ss:[0A9E]
mov	di,word	ptr	ss:[0AA0]
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	[0204],ax
mov	ax,word	ptr	[bp+1B]
mov	word	ptr	[0200],ax
mov	ax,word	ptr	[bp+17]
mov	word	ptr	[0F98],ax
mov	ax,word	ptr	[bp+19]
mov	word	ptr	[0F9A],ax
mov	word	ptr	ss:[0F9C],bp
pop	di
pop	es
mov	bx,76A7
dec	byte	ptr	ss:[0F8A]
je	269F
jmp	2507
cmp	byte	ptr	ss:[9BDD],01
jne	26AA
jmp	2507
call	CALCLENLASTBLK
mov	es,word	ptr	ss:[13B6]
mov	di,word	ptr	ss:[13B8]
mov	word	ptr	es:[di+04],ax
mov	word	ptr	es:[di+06],dx
xor	ax,ax
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],ax
ret
mov	bx,7827
xlat
mov	bx,76A7
or	al,al
je	26E0
inc	al
je	26F4
jo	GOTEOLDO_MARIO
js	272B
jmp	280B
dec	si
call	ADDSYMBOL
DO_MARIO:
test	byte	ptr	ss:[0F8B],08
je	26EF
jmp	E_CTRLC_HIT
lodsb
cmp	al,09
jne	26C9
mov	word	ptr	ss:[0F90],di
call	PARSEMARIO
mov	cx,di
sub	cx,word	ptr	ss:[0F90]
add	word	ptr	ss:[0F94],cx
adc	byte	ptr	ss:[0F92],00
GOTEOLDO_MARIO:
cmp	byte	ptr	ss:[0F8B],00
jne	2765
cmp	byte	ptr	[si+01],0A
jne	2749
inc	si
inc	si
inc	word	ptr	ss:[13F0]
cmp	di,7F00
jb	DO_MARIO
jmp	278C
cmp	byte	ptr	ss:[0F8B],00
jne	2741
inc	si
inc	word	ptr	ss:[13F0]
cmp	di,7F00
jb	DO_MARIO
jmp	278C
dec	si
mov	word	ptr	ss:[0F90],di
jmp	2765
push	es
push	ds
pop	es
xchg	di,si
mov	al,0A
mov	cx,00FF
repne
scasb
xchg	di,si
pop	es
inc	word	ptr	ss:[13F0]
cmp	di,7F00
jb	DO_MARIO
jmp	278C
mov	al,byte	ptr	[0F8B]
test	al,01
je	277D
and	al,FE
push	ax
push	dx
mov	dx,7FAA
call	ERROR_ROUT
pop	dx
pop	ax
or	al,02
and	al,FE
test	al,04
je	2786
push	ax
call	LISTLINE
pop	ax
mov	byte	ptr	[0F8B],al
jmp	2716
call	CALCLENLASTBLK
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jae	279C
jmp	_CANTALLOC
mov	word	ptr	[13AC],ax
mov	word	ptr	ss:[13AE],0000
mov	es,word	ptr	ss:[13B6]
mov	di,word	ptr	ss:[13B8]
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],0000
mov	ax,word	ptr	[13C0]
mov	cx,word	ptr	ss:[13C2]
mov	word	ptr	es:[di+04],ax
mov	word	ptr	es:[di+06],cx
mov	es,word	ptr	ss:[13AC]
xor	di,di
mov	word	ptr	ss:[13B6],es
mov	word	ptr	ss:[13B8],di
mov	byte	ptr	es:[di+10],01
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
call	CALCROMPOS
mov	word	ptr	[13BC],ax
mov	word	ptr	ss:[13BE],cx
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	es:[di+0E],cx
add	di,13
mov	word	ptr	ss:[13B4],di
mov	bx,76A7
jmp	DO_MARIO
cmp	al,03
jne	281A
push	dx
mov	dx,837E
call	ERROR_ROUT
pop	dx
jmp	26F4
mov	bp,word	ptr	ss:[0F9C]
mov	al,byte	ptr	[bp+14]
test	al,02
jne	285B
test	al,08
jne	2852
test	al,01
jne	283E
test	al,04
je	2838
call	READMORESOURCE
jmp	DO_MARIO
mov	dx,7EDC
call	FATALERR_ROUT
mov	bx,word	ptr	[bp+02]
call	far	ptr	_OS2CLOSEFILE
push	es
mov	es,word	ptr	[bp+10]
call	far	ptr	_OS2FREESEG
pop	es
jmp	2860
mov	ax,word	ptr	[0F96]
mov	word	ptr	[bp+E5],ax
jmp	2860
dec	word	ptr	ss:[0AA6]
mov	ax,word	ptr	[13F0]
add	word	ptr	ss:[13D2],ax
adc	word	ptr	ss:[13D0],00
sub	bp,1F
push	es
push	di
mov	ds,word	ptr	[bp+0C]
mov	si,word	ptr	[bp+0E]
mov	ax,word	ptr	[bp+04]
cmp	word	ptr	ss:[0F96],ax
je	2887
jmp	E_CONDUNBAL
mov	word	ptr	[0F96],ax
mov	ax,word	ptr	[bp+00]
cmp	word	ptr	ss:[1470],ax
jne	E_REPTUNBAL
mov	word	ptr	[1470],ax
mov	ax,word	ptr	[bp+15]
mov	word	ptr	[13F0],ax
mov	ax,word	ptr	[bp+0A]
mov	es,word	ptr	ss:[0A9E]
mov	di,word	ptr	ss:[0AA0]
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	[0204],ax
mov	ax,word	ptr	[bp+1B]
mov	word	ptr	[0200],ax
mov	ax,word	ptr	[bp+17]
mov	word	ptr	[0F98],ax
mov	ax,word	ptr	[bp+19]
mov	word	ptr	[0F9A],ax
mov	word	ptr	ss:[0F9C],bp
pop	di
pop	es
mov	bx,76A7
dec	byte	ptr	ss:[0F8A]
je	28DE
jmp	2749
cmp	byte	ptr	ss:[9BDD],01
jne	28E9
jmp	2749
call	CALCLENLASTBLK
mov	es,word	ptr	ss:[13B6]
mov	di,word	ptr	ss:[13B8]
mov	word	ptr	es:[di+04],ax
mov	word	ptr	es:[di+06],dx
xor	ax,ax
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],ax
ret
E_REPTUNBAL:
mov	dx,7C60
call	FATALERR_ROUT
jmp	STOPASSEM
E_CONDUNBAL:
jg	E_TOOMANYIFS
mov	dx,7CCA
call	FATALERR_ROUT
jmp	STOPASSEM
E_TOOMANYIFS:
mov	dx,7C82
call	FATALERR_ROUT
jmp	STOPASSEM
E_CTRLC_HIT:
mov	dx,7CAB
call	FATALERR_ROUT
jmp	STOPASSEM
E_EXTRACHARS:
push	dx
mov	dx,85FA
call	ERROR_ROUT
pop	dx
PM:
mov	si,dx
mov	word	ptr	ss:[13EC],ds
mov	word	ptr	ss:[13EE],si
mov	word	ptr	ss:[0AAC],0000
call	GETMACRO
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AAC]
jne	PMOK
push	dx
mov	dx,7F13
call	ERROR_ROUT
pop	dx
PMOK:
push	es
push	di
mov	es,dx
mov	dx,word	ptr	es:[bp+0A]
mov	cx,word	ptr	es:[bp+0C]
push	dx
push	cx
test	byte	ptr	ss:[0F8B],06
je	PMOKNOL
call	LISTLINE
PMOKNOL:
call	PARSE_MACRO_PARAMETERS
mov	bp,word	ptr	ss:[0F9C]
dec	si
dec	si
mov	word	ptr	[bp+0C],ds
mov	word	ptr	[bp+0E],si
mov	ax,word	ptr	[1470]
mov	word	ptr	[bp+00],ax
mov	ax,word	ptr	[0F96]
mov	word	ptr	[bp+04],ax
mov	ax,word	ptr	[13F0]
mov	word	ptr	[bp+15],ax
mov	ax,word	ptr	[0204]
mov	word	ptr	[bp+0A],ax
mov	ax,word	ptr	[0200]
mov	word	ptr	[bp+1B],ax
mov	ax,word	ptr	[bp+17]
mov	di,word	ptr	[bp+19]
add	bp,1F
mov	byte	ptr	[bp+14],02
mov	word	ptr	[bp+17],ax
mov	word	ptr	[bp+19],di
mov	ax,word	ptr	[020A]
mov	word	ptr	[bp+1D],ax
mov	ax,word	ptr	[020C]
mov	word	ptr	[bp+1F],ax
mov	word	ptr	ss:[0F9C],bp
cmp	byte	ptr	ss:[0F8A],20
jl	SRCLOK2
pop	cx
pop	dx
pop	di
pop	es
mov	dx,7D45
call	FATALERR_ROUT
jmp	STOPASSEM
SRCLOK2:
inc	byte	ptr	ss:[0F8A]
inc	word	ptr	ss:[0AA6]
inc	byte	ptr	ss:[0209]
cmp	byte	ptr	ss:[0209],5A
jb	_MACNUMOK
mov	byte	ptr	ss:[0209],41
inc	byte	ptr	ss:[0208]
cmp	byte	ptr	ss:[0208],5A
jb	_MACNUMOK
mov	byte	ptr	ss:[0208],41
inc	byte	ptr	ss:[0207]
cmp	byte	ptr	ss:[0207],5A
jb	_MACNUMOK
mov	byte	ptr	ss:[0207],41
inc	byte	ptr	ss:[0206]
_MACNUMOK:
mov	al,byte	ptr	[0203]
inc	al
mov	es,word	ptr	ss:[0A9E]
mov	di,word	ptr	ss:[0AA0]
and	ax,00FF
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	[0204],ax
pop	cx
pop	dx
call	EXPAND_THE_MACRO
pop	di
pop	es
mov	si,ax
mov	ax,86C9
mov	ds,ax
mov	bx,76A7
xor	ax,ax
mov	word	ptr	[0AAE],ax
mov	word	ptr	[0AB6],ax
mov	word	ptr	[0AB2],ax
mov	word	ptr	[0AB4],ax
mov	word	ptr	[0AB0],ax
mov	word	ptr	[0AB8],ax
mov	word	ptr	[13FF],ax
mov	word	ptr	[0EDF],ax
mov	word	ptr	[248A],ax
mov	word	ptr	ss:[13F0],0000
ret
PARSE_MACRO_PARAMETERS:
cmp	byte	ptr	[si],2E
jne	NOBS
mov	al,byte	ptr	[si+01]
and	al,DF
mov	byte	ptr	[0202],al
add	si,02
jmp	BSPRESENT
NOBS:
mov	byte	ptr	ss:[0202],4E
BSPRESENT:
mov	byte	ptr	ss:[0203],FF
mov	bx,7AA9
SCANPARS:
lodsb
cmp	al,3B
je	NOPARS
cmp	al,0D
je	MACCR
cmp	al,2C
je	GOTPAR
xlat
or	al,al
js	SCANPARS
GOTPAR:
mov	ax,ss
mov	es,ax
mov	di,0000
NEWARG:
inc	byte	ptr	ss:[0203]
mov	ax,si
mov	cx,si
dec	ax
stosw
mov	al,byte	ptr	[si+FF]
cmp	al,3C
je	ANGLEBRAC
cmp	al,2C
je	MACOOPS
xlat
or	al,al
js	MACMISS
ENDPARLP:
lodsb
xlat
or	al,al
jns	ENDPARLP
cmp	byte	ptr	[si+FF],2C
jne	CALCLEN
MACOOPS:
mov	ax,si
sub	ax,cx
stosw
lodsb
jmp	NEWARG
MACMISS:
dec	si
dec	cx
jmp	CALCLEN
ANGLEERR:
dec	si
push	dx
mov	dx,8024
call	ERROR_ROUT
pop	dx
ANGLEBRAC:
mov	word	ptr	es:[di+FE],cx
inc	cx
mov	ah,3E
MACSRCH:
lodsb
cmp	al,0D
je	ANGLEERR
cmp	al,ah
jne	MACSRCH
lodsb
cmp	al,2C
jne	SPEND1
mov	ax,si
sub	ax,cx
dec	ax
stosw
lodsb
jmp	NEWARG
SPEND1:
inc	cx
CALCLEN:
mov	ax,si
sub	ax,cx
stosw
NOPARS:
dec	si
mov	ah,0D
MACSKIPEOL:
lodsb
cmp	al,ah
jne	MACSKIPEOL
MACCR:
inc	si
ret
EXPAND_THE_MACRO:
mov	word	ptr	ss:[9A82],ds
mov	ds,dx
mov	si,cx
mov	ax,86C9
mov	es,ax
mov	di,word	ptr	ss:[0200]
shl	byte	ptr	ss:[0203],1
shl	byte	ptr	ss:[0203],1
mov	ax,0A0D
stosw
mov	bx,7B29
EXPANDMACRO:
mov	cl,5C
EXPANDMACRO2:
lodsw
stosw
cmp	al,cl
je	EMEX
cmp	ah,cl
jne	EXPANDMACRO2
jmp	EMEX2
EMEX:
dec	di
mov	al,ah
jmp	EMEX3
EMEX2:
lodsb
EMEX3:
xlat
or	al,al
js	EMSPECIAL
cmp	al,byte	ptr	ss:[0203]
jg	PARTOOMUCH
dec	di
push	ds
push	si
xor	ah,ah
mov	bp,ax
mov	dl,al
mov	cx,word	ptr	[bp+0002]
or	cx,cx
je	COPYPAR1
mov	si,word	ptr	[bp+0000]
mov	ds,word	ptr	ss:[9A82]
COPYPAR:
lodsb
stosb
dec	cx
jne	COPYPAR
COPYPAR1:
pop	si
pop	ds
jmp	EXPANDMACRO
PARTOOMUCH:
dec	di
jmp	EXPANDMACRO
EMSPECIAL:
mov	al,byte	ptr	[si+FF]
cmp	al,40
je	EMATSA
cmp	al,30
je	EMBSCHAR
cmp	al,24
je	EMSTR
cmp	al,7F
je	GETNEXTMACEMS
cmp	al,5C
je	EXPANDMACRO
or	al,al
je	EMEND
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
EMATSA:
mov	byte	ptr	es:[di+FF],5F
mov	ax,word	ptr	[0206]
stosw
mov	ax,word	ptr	[0208]
stosw
jmp	EXPANDMACRO
EMSTR:
dec	di
call	GETSTRINGADDR
push	ds
push	si
mov	si,cx
mov	ds,dx
EMSTRLP:
lodsb
stosb
or	al,al
jne	EMSTRLP
dec	di
pop	si
pop	ds
mov	bx,7B29
jmp	EXPANDMACRO
EMBSCHAR:
mov	al,byte	ptr	[0202]
mov	byte	ptr	es:[di+FF],al
jmp	EXPANDMACRO
GETNEXTMACEMS:
push	bx
lodsw
mov	ds,ax
xor	si,si
dec	di
pop	bx
jmp	EXPANDMACRO
EMEND:
mov	byte	ptr	es:[di+FF],1A
mov	ax,word	ptr	[0200]
mov	word	ptr	ss:[0200],di
ret
DOTERR:
push	dx
mov	dx,800A
call	ERROR_ROUT
pop	dx
PARSE65816:
mov	dx,si
lodsw
mov	bp,ax
and	bp,00FF
add	bp,bp
jmp	word	ptr	[bp+672B]
P_MORE:
dec	si
inc	dx
lodsw
mov	bp,ax
and	bp,00FF
add	bp,bp
jmp	word	ptr	[bp+672B]
P_EOL:
ret
P_GOTEOL:
dec	si
dec	si
ret
P_EXPR:
mov	al,byte	ptr	[13E6]
or	al,al
je	P_EOK
ret
P_EOK:
call	NEEDCR
dec	si
push	es
push	di
push	si
mov	ax,ss
mov	es,ax
mov	di,8A6E
PELP:
lodsb
stosb
xlat
or	al,al
jns	PELP
mov	al,24
mov	byte	ptr	es:[di+FF],al
pop	si
pop	di
pop	es
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	2C6D
jmp	P_IFERR
mov	word	ptr	ss:[9A7C],dx
mov	word	ptr	ss:[9A7E],cx
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A62
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A6E
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,89A9
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	cx
mov	byte	ptr	ss:[2480],00
mov	cx,word	ptr	ss:[13F0]
call	PRTDECW
pop	cx
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,89B3
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	dx
push	cx
mov	byte	ptr	ss:[2480],00
mov	dx,word	ptr	ss:[9A7C]
mov	cx,word	ptr	ss:[9A7E]
call	PRTDECL
pop	cx
pop	dx
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,899D
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
mov	ax,word	ptr	[9A7D]
or	al,al
jne	P_EXPR1
mov	ax,word	ptr	[9A7C]
or	al,al
jne	P_EXPR2
mov	ax,word	ptr	[9A7F]
or	al,al
jne	P_EXPR3
mov	ax,word	ptr	[9A7E]
call	PRTHEXB
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,899F
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
ret
P_EXPR1:
call	PRTHEXB
mov	ax,word	ptr	[9A7C]
P_EXPR2:
call	PRTHEXB
mov	ax,word	ptr	[9A7F]
P_EXPR3:
call	PRTHEXB
mov	ax,word	ptr	[9A7E]
call	PRTHEXB
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,899F
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
ret
P_ADC:
mov	al,byte	ptr	[0ABA]
test	al,01
je	2D5E
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	2D6C
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6E2D]
or	al,al
je	2D7C
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_AND:
mov	al,byte	ptr	[0ABA]
test	al,01
je	2D95
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	2DA3
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6E5B]
or	al,al
je	2DB3
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_ASL:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	2DCA
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6E89]
or	al,al
je	2DDA
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_BCC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	2DEE
jmp	PM
lodsb
xlat
or	al,al
js	2DEE
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	2E50
test	byte	ptr	ss:[0ACE],40
jne	2E47
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	2E40
call	MOREFR
pop	bp
pop	es
mov	ax,0090
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	2E73
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	2E73
cmp	cx,7F
jg	2E73
mov	ah,cl
mov	al,90
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
P_BCS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	2E87
jmp	PM
lodsb
xlat
or	al,al
js	2E87
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	2EE9
test	byte	ptr	ss:[0ACE],40
jne	2EE0
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	2ED9
call	MOREFR
pop	bp
pop	es
mov	ax,00B0
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	2F0C
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	2F0C
cmp	cx,7F
jg	2F0C
mov	ah,cl
mov	al,B0
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
P_BEQ:
lodsb
xlat
or	al,al
js	P_BEQ
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	2F77
test	byte	ptr	ss:[0ACE],40
jne	2F6E
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	2F67
call	MOREFR
pop	bp
pop	es
mov	ax,00F0
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	2F9A
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	2F9A
cmp	cx,7F
jg	2F9A
mov	ah,cl
mov	al,F0
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
P_BIT:
mov	al,byte	ptr	[0ABA]
test	al,01
je	2FB3
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	2FC1
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6EB7]
or	al,al
je	2FD1
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_BMI:
lodsb
xlat
or	al,al
js	P_BMI
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	303C
test	byte	ptr	ss:[0ACE],40
jne	3033
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	302C
call	MOREFR
pop	bp
pop	es
mov	ax,0030
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	305F
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	305F
cmp	cx,7F
jg	305F
mov	ah,cl
mov	al,30
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
P_BNE:
lodsb
xlat
or	al,al
js	P_BNE
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	30CA
test	byte	ptr	ss:[0ACE],40
jne	30C1
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	30BA
call	MOREFR
pop	bp
pop	es
mov	ax,00D0
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	30ED
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	30ED
cmp	cx,7F
jg	30ED
mov	ah,cl
mov	al,D0
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
P_BPL:
lodsb
xlat
or	al,al
js	P_BPL
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	3158
test	byte	ptr	ss:[0ACE],40
jne	314F
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	3148
call	MOREFR
pop	bp
pop	es
mov	ax,0010
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	317B
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	317B
cmp	cx,7F
jg	317B
mov	ah,cl
mov	al,10
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
P_BRA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	318F
jmp	PM
lodsb
xlat
or	al,al
js	318F
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	31F1
test	byte	ptr	ss:[0ACE],40
jne	31E8
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	31E1
call	MOREFR
pop	bp
pop	es
mov	ax,0080
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	3214
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	3214
cmp	cx,7F
jg	3214
mov	ah,cl
mov	al,80
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
BCCERR:
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
P_BRK:
mov	al,00
stosb
ret
P_BRL:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3234
jmp	PM
mov	byte	ptr	es:[di],82
P_LCC:
lodsb
xlat
or	al,al
js	P_LCC
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	NOTFR
test	byte	ptr	ss:[0ACE],40
jne	LCCEXTERN
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000A
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	328A
call	MOREFR
pop	bp
pop	es
xor	ax,ax
mov	word	ptr	es:[di+01],ax
add	di,03
ret
NOTFR:
sub	cx,word	ptr	ss:[0F94]
sbb	dx,word	ptr	ss:[0F92]
sub	cx,03
sbb	dx,00
js	BRLMIN
je	32AD
jmp	BCCERR
cmp	cx,7FFF
jle	SETBRL
jmp	BCCERR
SETBRL:
inc	di
mov	ax,cx
stosw
ret
BRLMIN:
cmp	dx,FF
je	32C3
jmp	BCCERR
cmp	cx,8000
jge	32CC
jmp	BCCERR
jmp	SETBRL
LCCEXTERN:
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
P_BVC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	32E1
jmp	PM
lodsb
xlat
or	al,al
js	32E1
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	3343
test	byte	ptr	ss:[0ACE],40
jne	333A
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	3333
call	MOREFR
pop	bp
pop	es
mov	ax,0050
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	3366
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	3366
cmp	cx,7F
jg	3366
mov	ah,cl
mov	al,50
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
ret
P_BVS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	337B
jmp	PM
lodsb
xlat
or	al,al
js	337B
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	33DD
test	byte	ptr	ss:[0ACE],40
jne	33D4
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	33CD
call	MOREFR
pop	bp
pop	es
mov	ax,0070
stosw
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
jne	3400
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jl	3400
cmp	cx,7F
jg	3400
mov	ah,cl
mov	al,70
stosw
mov	bx,bp
ret
push	dx
mov	dx,7F46
call	ERROR_ROUT
pop	dx
ret
ret
P_CHECKMAC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3415
jmp	PM
lodsb
xlat
or	al,al
js	3415
dec	si
lodsw
and	ax,DFDF
cmp	ax,4E4F
je	P_CHECKON
cmp	ax,464F
je	P_CHECKOFF
dec	si
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_CHECKON:
mov	byte	ptr	ss:[0AAA],01
ret
P_CHECKOFF:
mov	byte	ptr	ss:[0AAA],00
ret
P_CLC:
mov	al,18
stosb
ret
P_CLD:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3451
jmp	PM
mov	al,D8
stosb
ret
P_CLI:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3460
jmp	PM
mov	al,58
stosb
ret
P_CLV:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	346F
jmp	PM
mov	al,B8
stosb
ret
P_CMP:
mov	al,byte	ptr	[0ABA]
test	al,01
je	3483
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3491
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6EE5]
or	al,al
je	34A1
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_COP:
mov	al,02
stosb
ret
P_CPX:
mov	al,byte	ptr	[0ABA]
test	al,02
je	34BE
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	34CC
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6F13]
or	al,al
je	34DC
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_CPY:
mov	al,byte	ptr	[0ABA]
test	al,02
je	34F5
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3503
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6F41]
or	al,al
je	3513
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_DEC:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	352A
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6F6F]
or	al,al
je	353A
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_DEX:
mov	al,CA
stosb
ret
P_DEY:
mov	al,88
stosb
ret
P_DEFEND:
push	es
push	di
mov	ax,ss
mov	es,ax
mov	di,261F
call	COPYPF
mov	ax,4509
stosw
mov	ax,444E
stosw
mov	al,0D
stosb
pop	di
pop	es
ret
P_DEFERROR:
push	es
push	di
mov	ax,ss
mov	es,ax
mov	di,2557
call	COPYPF
pop	di
pop	es
ret
COPYPF:
lodsb
xlat
or	al,al
js	COPYPF
dec	si
lodsb
cmp	al,22
jne	MISSOPEN
mov	al,22
DELP:
stosb
lodsb
cmp	al,0D
jne	DELP
stosb
mov	al,0A
stosb
dec	si
ret
MISSOPEN:
push	dx
mov	dx,829D
call	ERROR_ROUT
pop	dx
P_DW:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	35A2
jmp	PM
lodsb
xlat
or	al,al
js	35A2
dec	si
P_DW2:
call	CONVEXPRESS
mov	ax,cx
test	byte	ptr	ss:[0ACE],C0
je	362D
test	byte	ptr	ss:[0ACE],40
jne	35EA
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0010
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	35E6
call	MOREFR
pop	bp
pop	es
jmp	362D
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],10
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	3629
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
stosw
add	word	ptr	ss:[0F94],02
adc	word	ptr	ss:[0F92],00
lodsb
cmp	al,2C
jne	3642
jmp	P_DW2
xlat
or	al,al
js	364B
jmp	P_DBEERR
dec	si
mov	word	ptr	ss:[0F90],di
ret
P_DS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	365D
jmp	PM
lodsb
xlat
or	al,al
js	365D
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	3673
jmp	P_EQUERR2
mov	word	ptr	ss:[9A82],cx
mov	word	ptr	ss:[9A80],dx
call	SPLITOBJBUF
call	CALCROMPOS
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	es:[di+0E],cx
mov	byte	ptr	es:[di+10],08
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
mov	bx,word	ptr	ss:[9A80]
mov	word	ptr	es:[di+04],bx
mov	ax,word	ptr	[9A82]
mov	word	ptr	es:[di+06],ax
add	word	ptr	ss:[0F94],ax
adc	word	ptr	ss:[0F92],bx
mov	bp,di
add	di,13
jmp	SPLITINC
P_DB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	36C6
jmp	PM
lodsb
xlat
or	al,al
js	36C6
dec	si
P_DBA:
lodsb
cmp	al,27
jne	36D6
jmp	P_DBSINGLE
cmp	al,22
jne	36DD
jmp	P_DBSINGLE
dec	si
call	CONVEXPRESS
mov	al,cl
test	byte	ptr	ss:[0ACE],C0
je	3761
test	byte	ptr	ss:[0ACE],40
jne	371E
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000E
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	371A
call	MOREFR
pop	bp
pop	es
jmp	3761
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0E
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	375D
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
stosb
add	word	ptr	ss:[0F94],01
adc	word	ptr	ss:[0F92],00
P_DBS:
lodsb
cmp	al,2C
jne	3776
jmp	P_DBA
xlat
or	al,al
jns	P_DBEERR
dec	si
mov	word	ptr	ss:[0F90],di
ret
P_DBEERR:
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_DBSINGLE:
mov	ah,al
mov	cl,0D
P_DBSING:
lodsb
cmp	al,ah
je	P_DBS
stosb
add	word	ptr	ss:[0F94],01
adc	word	ptr	ss:[0F92],00
cmp	al,cl
jne	P_DBSING
push	dx
mov	dx,8136
call	ERROR_ROUT
pop	dx
P_ELSEIF:
test	byte	ptr	ss:[0F8B],06
je	PELSENOL
call	LISTLINE
PELSENOL:
jmp	FINDENDC
P_EQU:
lodsb
xlat
or	al,al
js	P_EQU
dec	si
test	byte	ptr	ss:[0F8B],01
jne	P_EQUSKIP
mov	bp,word	ptr	ss:[13F0]
cmp	word	ptr	ss:[0F7A],bp
jne	P_EQUERR
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
jne	P_EQUERR2
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	word	ptr	es:[bp+0A],dx
mov	word	ptr	es:[bp+0C],cx
pop	es
P_EQUSKIP:
ret
P_EQUERR:
push	dx
mov	dx,81FA
call	ERROR_ROUT
pop	dx
P_EQUERR2:
push	dx
mov	dx,80D7
call	ERROR_ROUT
pop	dx
P_EQUR:
lodsb
xlat
or	al,al
js	P_EQUR
dec	si
test	byte	ptr	ss:[0F8B],01
jne	EQURSKIP
mov	bp,word	ptr	ss:[13F0]
cmp	word	ptr	ss:[0F7A],bp
jne	P_EQUERR
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
jne	P_EQUERR2
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	word	ptr	es:[bp+0A],dx
mov	word	ptr	es:[bp+0C],cx
mov	byte	ptr	es:[bp+04],05
pop	es
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
EQURSKIP:
ret
P_DEFS:
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	M_DEFS
jmp	PM
M_DEFS:
lodsb
xlat
or	al,al
js	M_DEFS
dec	si
cmp	byte	ptr	[si],24
jne	DSND
inc	si
DSND:
push	si
call	GETSTRINGADDR
pop	ax
cmp	cx,A46D
jne	DSREDEFSTRING
cmp	dx,8AC9
je	P_BADSTRVAL
DSREDEFSTRING:
push	es
push	di
mov	di,cx
mov	es,dx
xor	ch,ch
mov	cl,byte	ptr	es:[di+FF]
push	cx
lodsb
cmp	al,2C
je	38B8
jmp	EAERR
mov	byte	ptr	ss:[247D],01
call	P_PRINTF2
mov	byte	ptr	ss:[247D],00
pop	cx
cmp	cx,word	ptr	ss:[2486]
ja	38D2
jmp	E_STR2LONG
push	ds
push	si
mov	ax,ss
mov	ds,ax
mov	si,8A6E
mov	cx,word	ptr	ss:[2486]
DSCOPYPFLP2:
lodsb
stosb
dec	cx
jns	DSCOPYPFLP2
mov	byte	ptr	es:[di+FF],00
pop	si
pop	ds
pop	di
pop	es
ret
P_BADSTRVAL:
push	dx
mov	dx,87D2
call	ERROR_ROUT
pop	dx
P_EOR:
mov	al,byte	ptr	[0ABA]
test	al,01
je	3907
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3915
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6F9D]
or	al,al
je	3925
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_END:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3939
jmp	PM
mov	bp,word	ptr	ss:[0F9C]
mov	byte	ptr	[bp+14],01
mov	ax,ss
mov	ds,ax
mov	si,254F
ret
P_ENDC:
inc	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3956
jmp	PM
dec	word	ptr	ss:[0F96]
js	P_ENDCERR
ret
P_ENDCERR:
push	dx
mov	dx,8179
call	ERROR_ROUT
pop	dx
P_FAIL:
call	LISTLINE
mov	dx,7D9C
call	FATALERR_ROUT
jmp	STOPASSEM
ADDFLIST:
push	ax
mov	al,byte	ptr	[13F5]
or	al,al
je	NO
push	bp
push	ds
push	dx
push	si
push	cx
mov	si,dx
xor	cx,cx
LP:
inc	cx
lodsb
or	al,al
jne	LP
dec	cx
mov	bx,word	ptr	ss:[13F6]
call	far	ptr	_OS2WRITEBYTES
mov	ax,ss
mov	ds,ax
mov	dx,2552
mov	cx,0002
mov	bx,word	ptr	ss:[13F6]
call	far	ptr	_OS2WRITEBYTES
pop	cx
pop	si
pop	dx
pop	ds
pop	bp
NO:
pop	ax
ret
P_FOPEN:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	39BB
jmp	PM
lodsb
xlat
or	al,al
js	39BB
dec	si
cmp	byte	ptr	[si],2B
je	39CB
jmp	F_OPENNEW
inc	si
push	ds
push	si
push	es
push	di
mov	ax,word	ptr	[2478]
or	ax,ax
je	F_APPENDIT
mov	es,ax
mov	di,word	ptr	ss:[247A]
xor	al,al
PFENDLP:
cmp	al,byte	ptr	es:[di]
je	PFENDEND
inc	di
jmp	PFENDLP
PFENDEND:
dec	di
mov	al,byte	ptr	es:[di]
cmp	al,5C
je	PFENDEND2
or	al,al
jne	PFENDEND
PFENDEND2:
inc	di
mov	bx,76A7
PFCMPLP:
lodsb
and	al,DF
mov	cl,byte	ptr	es:[di]
inc	di
and	cl,DF
cmp	al,cl
je	PFCMPLP
mov	al,byte	ptr	[si+FF]
xlat
or	al,al
jns	F_APPENDIT
mov	al,byte	ptr	es:[di+FF]
or	al,al
jne	F_APPENDIT
pop	di
pop	es
pop	si
pop	ds
mov	word	ptr	ss:[2474],0001
ret
F_APPENDIT:
pop	di
pop	es
pop	si
pop	ds
push	ds
push	si
call	COPYFNAME
mov	ds,word	ptr	ss:[9A7C]
mov	dx,word	ptr	ss:[9A7E]
mov	word	ptr	ss:[2478],ds
mov	word	ptr	ss:[247A],dx
call	ADDFLIST
mov	bx,word	ptr	ss:[2476]
call	far	ptr	_OS2CLOSEFILE
mov	ds,word	ptr	ss:[2478]
mov	dx,word	ptr	ss:[247A]
xor	bx,bx
call	far	ptr	_OS2OPENAPPENDFILE
jae	OK
pop	si
pop	ds
mov	bx,76A7
mov	word	ptr	ss:[2474],0000
push	dx
mov	dx,80FF
call	ERROR_ROUT
pop	dx
OK:
mov	word	ptr	ss:[2474],0001
mov	word	ptr	[2476],ax
xor	cx,cx
mov	dx,cx
mov	bx,word	ptr	ss:[2476]
call	far	ptr	_OS2SEEKEND
pop	si
pop	ds
mov	bx,76A7
ret
F_OPENNEW:
mov	bx,word	ptr	ss:[2476]
call	far	ptr	_OS2CLOSEFILE
push	ds
push	si
push	ax
push	cx
call	COPYFNAME
mov	ds,word	ptr	ss:[9A7C]
mov	dx,word	ptr	ss:[9A7E]
mov	word	ptr	ss:[2478],ds
mov	word	ptr	ss:[247A],dx
call	ADDFLIST
pop	cx
pop	ax
xor	bx,bx
call	far	ptr	_OS2OPENNEWFILE
mov	word	ptr	ss:[2474],0001
mov	word	ptr	[2476],ax
pop	si
pop	ds
jb	PFOPENF
mov	bx,76A7
ret
PFOPENF:
push	dx
mov	dx,80FF
call	ERROR_ROUT
pop	dx
P_FCLOSE:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	FCLOSELP
jmp	PM
FCLOSELP:
M_FCLOSE:
lodsb
cmp	al,09
je	FCLOSELP
cmp	al,20
je	FCLOSELP
cmp	al,3B
je	FCLOSEEND
cmp	al,2A
je	FCLOSEEND
cmp	al,0D
je	FCLOSEEND
cmp	al,21
jne	FCLOSEEND
mov	bx,word	ptr	ss:[2476]
call	far	ptr	_OS2CLOSEFILE
mov	word	ptr	ss:[2478],0000
FCLOSEEND:
mov	word	ptr	ss:[2474],0000
dec	si
ret
P_IF:
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	3B29
jmp	P_NEWIF
lodsw
and	ah,DF
mov	bp,ax
and	bp,00FF
add	bp,bp
jmp	word	ptr	[bp+6925]
P_IFV:
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3B45
jmp	PM
mov	al,00
jmp	IV0
P_IFNV:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3B54
jmp	PM
mov	al,01
IV0:
inc	word	ptr	ss:[0F96]
mov	byte	ptr	[A4A1],al
call	GETENVNAME
call	FINDENVVAR
mov	al,byte	ptr	[A4A2]
xor	al,byte	ptr	ss:[A4A1]
jne	3B73
jmp	FINDENDC
ret
GETENVNAME:
lodsb
xlat
or	al,al
js	GETENVNAME
dec	si
lodsb
cmp	al,22
jne	GEN_ERR1
push	di
push	si
push	bx
mov	bx,7727
mov	di,A4A3
xor	cx,cx
GEN0:
lodsb
xlat
or	al,al
js	GEN1
mov	byte	ptr	ss:[di],al
inc	di
inc	cx
jmp	GEN0
GEN1:
or	cx,cx
je	GEN_ERR3
cmp	byte	ptr	[si+FF],22
jne	GEN_ERR2
inc	cx
mov	byte	ptr	ss:[di],3D
mov	word	ptr	ss:[A5A3],cx
pop	bx
pop	ax
pop	di
ret
GEN_ERR1:
push	dx
mov	dx,814C
call	ERROR_ROUT
pop	dx
GEN_ERR2:
pop	bx
pop	si
pop	di
push	dx
mov	dx,8162
call	ERROR_ROUT
pop	dx
GEN_ERR3:
pop	bx
pop	si
pop	di
push	dx
mov	dx,849F
call	ERROR_ROUT
pop	dx
FINDENVVAR:
push	ds
push	es
push	di
push	si
push	bp
push	dx
push	cx
push	bx
mov	ah,62
int	21
mov	ds,bx
mov	ax,word	ptr	[002C]
mov	ds,ax
xor	si,si
FEV0:
push	si
cld
mov	di,A4A3
mov	ax,8AC9
mov	es,ax
mov	cx,word	ptr	ss:[A5A3]
rep
cmpsb
jne	FEV1
or	cx,cx
jne	FEV1
mov	word	ptr	ss:[A5A5],si
mov	word	ptr	ss:[A5A7],ds
mov	byte	ptr	ss:[A4A2],01
pop	si
pop	bx
pop	cx
pop	dx
pop	bp
pop	si
pop	di
pop	es
pop	ds
ret
FEV1:
pop	si
push	ds
pop	es
mov	di,si
xor	al,al
mov	cx,FFFF
repne
scasb
mov	si,di
cmp	byte	ptr	[si],00
jne	FEV0
mov	byte	ptr	ss:[A4A2],00
pop	bx
pop	cx
pop	dx
pop	bp
pop	si
pop	di
pop	es
pop	ds
ret
P_GETENV:
lodsb
xlat
or	al,al
js	P_GETENV
dec	si
push	si
call	GETSTRINGADDR
pop	ax
cmp	cx,A46D
jne	GE0
cmp	dx,8AC9
je	GE_ERR1
GE0:
lodsb
cmp	al,3D
je	3C59
jmp	EAERR
push	es
push	di
mov	di,cx
mov	es,dx
call	GETENVNAME
call	FINDENVVAR
cmp	byte	ptr	ss:[A4A2],01
jne	GE_ERR2
push	ds
push	si
lds	si,far	ptr	ss:[A5A5]
mov	cl,byte	ptr	es:[di+FF]
sub	cl,02
GE1:
lodsb
stosb
dec	cl
je	GE_ERR3
or	al,al
jne	GE1
pop	si
pop	ds
pop	di
pop	es
ret
GE_ERR1:
push	dx
mov	dx,8702
call	ERROR_ROUT
pop	dx
GE_ERR2:
pop	di
pop	es
push	dx
mov	dx,871E
call	ERROR_ROUT
pop	dx
GE_ERR3:
mov	byte	ptr	es:[di+FF],00
pop	si
pop	ds
pop	di
pop	es
push	dx
mov	dx,86E7
call	ERROR_ROUT
pop	dx
P_IFF:
cmp	ah,45
je	P_IFFE
cmp	ah,4E
je	P_IFFN
jmp	PM
P_IFFE:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3CC5
jmp	PM
mov	al,00
jmp	IFE0
P_IFFN:
lodsb
and	al,DF
cmp	al,45
je	P_IFFNE
jmp	PM
P_IFFNE:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3CDE
jmp	PM
mov	al,01
IFE0:
inc	word	ptr	ss:[0F96]
mov	byte	ptr	[A5A9],al
call	GETFILENAME
call	CHECKFILEEXISTS
mov	al,byte	ptr	[A5AA]
xor	al,byte	ptr	ss:[A5A9]
jne	3CFD
jmp	FINDENDC
ret
GETFILENAME:
lodsb
xlat
or	al,al
js	GETFILENAME
dec	si
lodsb
cmp	al,22
jne	GFN_ERR1
push	di
push	si
push	bx
mov	di,A5AB
xor	cx,cx
GFN0:
lodsb
cmp	al,22
je	GFN1
cmp	al,2A
je	GFN_ERR4
cmp	al,3F
je	GFN_ERR4
cmp	al,00
je	GFN_ERR2
cmp	al,1A
je	GFN_ERR2
cmp	al,0A
je	GFN_ERR2
cmp	al,0D
je	GFN_ERR2
mov	byte	ptr	ss:[di],al
inc	di
inc	cx
jmp	GFN0
GFN1:
or	cx,cx
je	GFN_ERR3
mov	byte	ptr	ss:[di],00
mov	word	ptr	ss:[A5A3],cx
pop	bx
pop	ax
pop	di
ret
GFN_ERR1:
push	dx
mov	dx,814C
call	ERROR_ROUT
pop	dx
GFN_ERR2:
pop	bx
pop	si
pop	di
push	dx
mov	dx,8162
call	ERROR_ROUT
pop	dx
GFN_ERR3:
pop	bx
pop	si
pop	di
push	dx
mov	dx,849F
call	ERROR_ROUT
pop	dx
GFN_ERR4:
pop	bx
pop	si
pop	di
push	dx
mov	dx,873E
call	ERROR_ROUT
pop	dx
CHECKFILEEXISTS:
push	ax
push	bx
push	dx
push	ds
mov	dx,A5AB
push	ss
pop	ds
mov	ax,3D00
int	21
jb	CFE0
mov	bx,ax
mov	ah,3E
int	21
mov	byte	ptr	ss:[A5AA],01
pop	ds
pop	dx
pop	bx
pop	ax
ret
CFE0:
mov	byte	ptr	ss:[A5AA],00
pop	ds
pop	dx
pop	bx
pop	ax
ret
P_IFE:
cmp	ah,51
jne	3DA5
jmp	P_IFEQ
jmp	PM
P_IFN:
cmp	ah,45
jne	3DB0
jmp	P_IFNE
cmp	ah,43
jne	3DB8
jmp	P_IFNC
cmp	ah,44
jne	3DC0
jmp	P_IFND
cmp	ah,53
je	P_IFNS
cmp	ah,56
jne	3DCD
jmp	P_IFNV
jmp	PM
P_IFG:
cmp	ah,54
jne	3DD8
jmp	P_IFGT
cmp	ah,45
jne	3DE0
jmp	P_IFGE
jmp	PM
P_IFL:
cmp	ah,45
jne	3DEB
jmp	P_IFLE
cmp	ah,54
jne	P_IFDT
jmp	P_IFLT
P_IFDT:
mov	al,byte	ptr	[si+FF]
xlat
or	al,al
jns	3DFF
jmp	P_IFD
jmp	PM
P_IFCT:
mov	al,byte	ptr	[si+FF]
xlat
or	al,al
jns	3E0E
jmp	P_IFC
jmp	PM
P_IFS:
call	GETSTRPAR
je	3E19
jmp	FINDENDC
ret
P_IFNS:
call	GETSTRPAR
jne	3E22
jmp	FINDENDC
ret
GETSTRPAR:
lodsb
xlat
or	al,al
js	GETSTRPAR
dec	si
inc	word	ptr	ss:[0F96]
call	GETSTRINGADDR
push	dx
push	cx
lodsb
cmp	al,2C
je	3E3D
jmp	EAERR
call	CONVEXPRESS
mov	word	ptr	ss:[9A7C],cx
lodsb
cmp	al,2C
je	3E4D
jmp	EAERR
call	CONVEXPRESS
mov	byte	ptr	ss:[9A7E],cl
pop	cx
pop	dx
test	byte	ptr	ss:[0ACE],C0
je	3E62
jmp	P_EQUERR2
push	ds
push	si
mov	si,cx
mov	ds,dx
add	si,word	ptr	ss:[9A7C]
mov	al,byte	ptr	[si]
pop	si
pop	ds
cmp	al,byte	ptr	ss:[9A7E]
ret
P_IFND:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3E82
jmp	PM
lodsb
xlat
or	al,al
js	3E82
dec	si
inc	word	ptr	ss:[0F96]
mov	byte	ptr	ss:[0F88],01
call	CONVEXPRESS
mov	byte	ptr	ss:[0F88],00
test	byte	ptr	ss:[0ACE],80
jne	3EA9
jmp	FINDENDC
ret
P_IFD:
lodsb
xlat
or	al,al
js	P_IFD
dec	si
inc	word	ptr	ss:[0F96]
mov	byte	ptr	ss:[0F88],01
call	CONVEXPRESS
mov	byte	ptr	ss:[0F88],00
test	byte	ptr	ss:[0ACE],80
je	3ED1
jmp	FINDENDC
ret
P_IFNC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3EDD
jmp	PM
mov	dh,FF
jmp	P_IFC1
P_IFC:
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	3EED
jmp	PM
xor	dh,dh
P_IFC1:
lodsb
xlat
or	al,al
js	P_IFC1
dec	si
inc	word	ptr	ss:[0F96]
push	es
push	di
mov	es,word	ptr	ss:[0ED9]
mov	di,word	ptr	ss:[0EDB]
xor	cx,cx
lodsb
mov	ah,al
cmp	ah,27
je	IFCCOPY
cmp	ah,22
jne	P_IFCERR
IFCCOPY:
lodsb
cmp	al,ah
je	IFCNEXT
cmp	al,0D
je	P_IFCERR1
stosb
inc	cx
jmp	IFCCOPY
IFCNEXT:
lodsb
cmp	al,2C
jne	P_IFCERR2
mov	es,word	ptr	ss:[0ED9]
mov	di,word	ptr	ss:[0EDB]
lodsb
mov	ah,al
cmp	ah,27
je	IFCCOMP
cmp	ah,22
jne	P_IFCERR
or	cx,cx
je	IFCCOMP1
IFCCOMP:
lodsb
cmp	al,0D
je	P_IFCERR1
cmp	al,byte	ptr	es:[di]
jne	IFCNOTEQUAL
inc	di
dec	cx
jne	IFCCOMP
IFCCOMP1:
lodsb
cmp	al,ah
jne	IFCNOTEQUAL
pop	di
pop	es
or	dh,dh
je	3F60
jmp	FINDENDC
ret
IFCNOTEQUAL:
cmp	al,0D
je	P_IFCERR1
pop	di
pop	es
or	dh,dh
jne	3F6E
jmp	FINDENDC
ret
P_IFCERR:
pop	di
pop	es
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_IFCERR1:
dec	si
pop	di
pop	es
cmp	ah,27
jne	P_IFCERR1A
push	dx
mov	dx,8136
call	ERROR_ROUT
pop	dx
P_IFCERR1A:
push	dx
mov	dx,814C
call	ERROR_ROUT
pop	dx
P_IFCERR2:
dec	si
pop	di
pop	es
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_IFGT:
lodsb
xlat
or	al,al
js	P_IFGT
dec	si
inc	word	ptr	ss:[0F96]
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	3FB7
jmp	P_IFERR
or	dx,dx
jns	3FBE
jmp	FINDENDC
je	P_IFGT1
ret
P_IFGT1:
or	cx,cx
jne	3FC8
jmp	FINDENDC
ret
P_IFGE:
lodsb
xlat
or	al,al
js	P_IFGE
dec	si
inc	word	ptr	ss:[0F96]
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	3FE4
jmp	P_IFERR
or	dx,dx
jns	3FEB
jmp	FINDENDC
ret
P_IFLT:
lodsb
xlat
or	al,al
js	P_IFLT
dec	si
inc	word	ptr	ss:[0F96]
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	4007
jmp	P_IFERR
or	dx,dx
js	400E
jmp	FINDENDC
ret
P_IFLE:
lodsb
xlat
or	al,al
js	P_IFLE
dec	si
inc	word	ptr	ss:[0F96]
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	402A
jmp	P_IFERR
or	dx,dx
jns	P_IFLE1
mov	bx,76A7
ret
P_IFLE1:
je	4037
jmp	FINDENDC
or	cx,cx
je	403E
jmp	FINDENDC
mov	bx,76A7
ret
P_IFNE:
lodsb
xlat
or	al,al
js	P_IFNE
dec	si
inc	word	ptr	ss:[0F96]
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	405D
jmp	P_IFERR
or	dx,dx
jne	EXECCOND
or	cx,cx
jne	EXECCOND
jmp	FINDENDC
P_IFEQ:
lodsb
xlat
or	al,al
js	P_IFEQ
dec	si
inc	word	ptr	ss:[0F96]
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	4083
jmp	P_IFERR
or	dx,dx
je	408A
jmp	FINDENDC
or	cx,cx
je	EXECCOND
jmp	FINDENDC
EXECCOND:
ret
P_NEWIF:
lodsb
xlat
or	al,al
js	P_NEWIF
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
je	40A8
jmp	P_IFERR
lodsb
xlat
or	al,al
js	40A8
dec	si
lodsw
cmp	al,3B
je	P_IFONLY
cmp	al,0A
je	P_IFONLY
cmp	al,3C
je	P_NIFL
cmp	al,3E
je	P_NIFG
cmp	al,3D
jne	40C8
jmp	P_NIFEQ
and	ax,DFDF
cmp	al,45
je	P_CIFE
cmp	al,4E
je	P_CIFN
cmp	al,47
je	P_CIFG
cmp	al,4C
je	P_CIFL
jmp	PM
P_IFONLY:
mov	ax,cx
mov	bx,dx
xor	cx,cx
xor	dx,dx
sub	si,02
jmp	P_IFONLY2
P_NIFL:
cmp	ah,3D
jne	40F4
jmp	P_NIFLE
mov	al,ah
xlat
or	al,al
jns	40FF
jmp	P_NIFLT
jmp	EAERR
P_NIFG:
cmp	ah,3D
je	P_NIFGE
mov	al,ah
xlat
or	al,al
js	P_NIFGT
jmp	EAERR
P_CIFE:
cmp	ah,51
jne	411A
jmp	P_NIFEQ
jmp	PM
P_CIFN:
cmp	ah,45
jne	4125
jmp	P_NIFNE
jmp	PM
P_CIFG:
cmp	ah,54
je	P_NIFGT
cmp	ah,45
je	P_NIFGE
jmp	PM
P_CIFL:
cmp	ah,54
je	P_NIFLT
cmp	ah,45
jne	4142
jmp	P_NIFLE
jmp	PM
P_IFERR:
push	dx
mov	dx,80D7
call	ERROR_ROUT
pop	dx
P_NIFGT:
lodsb
xlat
or	al,al
js	P_NIFGT
dec	si
push	dx
push	cx
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
jne	P_IFERR
inc	word	ptr	ss:[0F96]
pop	ax
pop	bx
cmp	bx,dx
jg	P_IFGTX
je	4172
jmp	FINDENDC
cmp	ax,cx
jg	P_IFGTX
jmp	FINDENDC
P_IFGTX:
mov	bx,76A7
ret
P_NIFGE:
lodsb
xlat
or	al,al
js	P_NIFGE
dec	si
push	dx
push	cx
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
jne	P_IFERR
inc	word	ptr	ss:[0F96]
pop	ax
pop	bx
cmp	bx,dx
jg	P_IFGEX
cmp	ax,cx
jge	P_IFGEX
jmp	FINDENDC
P_IFGEX:
mov	bx,76A7
ret
P_NIFLT:
lodsb
xlat
or	al,al
js	P_NIFLT
dec	si
push	dx
push	cx
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
jne	P_IFERR
inc	word	ptr	ss:[0F96]
pop	ax
pop	bx
cmp	bx,dx
jl	P_IFLTX
je	41CD
jmp	FINDENDC
cmp	ax,cx
jl	P_IFLTX
jmp	FINDENDC
P_IFLTX:
mov	bx,76A7
ret
P_NIFLE:
lodsb
xlat
or	al,al
js	P_NIFLE
dec	si
push	dx
push	cx
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
je	41F0
jmp	P_IFERR
inc	word	ptr	ss:[0F96]
pop	ax
pop	bx
cmp	bx,dx
jl	P_IFLEX
jne	FINDENDC
cmp	ax,cx
jg	FINDENDC
P_IFLEX:
mov	bx,76A7
ret
P_NIFEQ:
lodsb
xlat
or	al,al
js	P_NIFEQ
dec	si
push	dx
push	cx
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
je	421D
jmp	P_IFERR
inc	word	ptr	ss:[0F96]
pop	ax
pop	bx
cmp	dx,bx
jne	FINDENDC
cmp	cx,ax
jne	FINDENDC
mov	bx,76A7
ret
P_NIFNE:
lodsb
xlat
or	al,al
js	P_NIFNE
dec	si
push	dx
push	cx
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],80
je	4248
jmp	P_IFERR
pop	ax
pop	bx
P_IFONLY2:
inc	word	ptr	ss:[0F96]
cmp	cx,ax
je	P_IFNE2
mov	bx,76A7
ret
P_IFNE2:
cmp	dx,bx
je	FINDENDC
mov	bx,76A7
ret
FINDENDC:
mov	bx,76A7
mov	word	ptr	ss:[9A94],0000
mov	word	ptr	ss:[9A90],es
mov	word	ptr	ss:[9A92],di
mov	ax,ds
mov	es,ax
mov	di,si
FINDENDOFLINE:
mov	cx,FFFF
mov	al,0D
repne
scasb
FEOL:
inc	word	ptr	ss:[13F0]
inc	di
FELSKS:
mov	al,byte	ptr	es:[di]
cmp	al,1A
jne	4290
jmp	FEGMS
inc	di
cmp	al,0D
je	FEOL
xlat
or	al,al
jns	FINDENDOFLINE
FELSKS1:
mov	al,byte	ptr	es:[di]
inc	di
cmp	al,0D
je	FEOL
xlat
or	al,al
js	FELSKS1
and	al,DF
cmp	al,45
je	MABENDC
cmp	al,52
jne	42B6
jmp	MABRUN
cmp	al,49
jne	FINDENDOFLINE
mov	al,byte	ptr	es:[di]
and	al,DF
cmp	al,46
jne	FINDENDOFLINE
mov	ax,word	ptr	es:[di+01]
xlat
or	al,al
js	FOUNDREALIF
xchg	ah,al
xlat
push	es
push	di
mov	cx,8AC9
mov	es,cx
mov	di,7BAB
mov	cx,0013
repne
scasw
pop	di
pop	es
or	cx,cx
je	FINDENDOFLINE
FOUNDREALIF:
or	al,al
js	FRIF
mov	al,byte	ptr	es:[di+03]
xlat
cmp	al,45
jne	JSFIF0
mov	al,byte	ptr	es:[di+04]
xlat
or	al,al
js	FRIF
JSFIF0:
mov	al,byte	ptr	es:[di+03]
xlat
or	al,al
js	FRIF
jmp	FINDENDOFLINE
FRIF:
inc	word	ptr	ss:[9A94]
jmp	FINDENDOFLINE
MABENDC:
mov	ax,word	ptr	es:[di]
and	ax,DFDF
cmp	ax,444E
jne	MABELSEIF
mov	ax,word	ptr	es:[di+02]
and	al,DF
cmp	al,43
jne	MABENDIF
mov	al,ah
xlat
or	al,al
js	ISENDC
jmp	FINDENDOFLINE
ISENDC:
dec	word	ptr	ss:[9A94]
js	433D
jmp	FINDENDOFLINE
add	di,03
mov	si,di
mov	ax,es
mov	ds,ax
mov	es,word	ptr	ss:[9A90]
mov	di,word	ptr	ss:[9A92]
dec	word	ptr	ss:[0F96]
ret
MABENDIF:
and	ah,DF
cmp	ax,4649
je	4361
jmp	FINDENDOFLINE
mov	al,byte	ptr	es:[di+04]
xlat
or	al,al
js	ISENDC
jmp	FINDENDOFLINE
MABELSEIF:
cmp	ax,534C
je	4376
jmp	FINDENDOFLINE
mov	ax,word	ptr	es:[di+02]
and	ax,DFDF
cmp	ax,4945
je	4385
jmp	FINDENDOFLINE
mov	ax,word	ptr	es:[di+04]
and	al,DF
cmp	al,46
je	4392
jmp	FINDENDOFLINE
mov	al,ah
xlat
or	al,al
js	439D
jmp	FINDENDOFLINE
cmp	word	ptr	ss:[9A94],00
je	43A8
jmp	FINDENDOFLINE
mov	si,di
mov	ax,es
mov	ds,ax
mov	es,word	ptr	ss:[9A90]
mov	di,word	ptr	ss:[9A92]
ret
MABRUN:
mov	ax,word	ptr	es:[di]
and	ax,DFDF
cmp	ax,4E55
je	43C7
jmp	FINDENDOFLINE
mov	al,byte	ptr	es:[di+02]
xlat
or	al,al
js	43D4
jmp	FINDENDOFLINE
add	di,03
lodsb
xlat
or	al,al
js	43D7
dec	si
mov	ax,es
mov	ds,ax
mov	si,di
mov	byte	ptr	ss:[247D],01
call	P_PRINTF2
mov	byte	ptr	ss:[247D],00
mov	di,si
push	bx
mov	bx,word	ptr	ss:[2486]
add	bx,8A6E
mov	byte	ptr	ss:[bx],0D
mov	byte	ptr	ss:[bx+01],0A
mov	byte	ptr	ss:[bx+02],1A
pop	bx
push	es
push	di
mov	ax,ss
mov	es,ax
mov	di,8A6E
mov	al,byte	ptr	es:[di]
xlat
or	al,al
jns	MABRUNX
inc	di
MABRUNLP:
mov	al,byte	ptr	es:[di]
inc	di
xlat
or	al,al
js	MABRUNLP
mov	ax,word	ptr	es:[di+FF]
and	ax,DFDF
cmp	ax,4649
jne	MABRUNX
add	di,01
mov	ax,word	ptr	es:[di]
xlat
or	al,al
js	RUNIF
xchg	ah,al
xlat
push	es
push	di
mov	cx,8AC9
mov	es,cx
mov	di,7BAB
mov	cx,0013
repne
scasw
pop	di
pop	es
or	cx,cx
je	MABRUNX
or	al,al
js	RUNIF
mov	al,byte	ptr	es:[di+02]
xlat
or	al,al
jns	MABRUNX
RUNIF:
inc	word	ptr	ss:[9A94]
MABRUNX:
pop	di
pop	es
dec	di
jmp	FINDENDOFLINE
FEGMS:
mov	bp,word	ptr	ss:[0F9C]
mov	al,byte	ptr	[bp+14]
test	al,08
jne	FEGMSRUN
call	READMORESOURCE
jne	FEGMSERR
mov	ax,ds
mov	es,ax
mov	di,si
jmp	FELSKS
FEGMSRUN:
sub	bp,1F
mov	es,word	ptr	[bp+0C]
mov	di,word	ptr	[bp+0E]
mov	ax,word	ptr	[bp+00]
mov	word	ptr	[1470],ax
mov	ax,word	ptr	[bp+15]
mov	word	ptr	[13F0],ax
mov	word	ptr	ss:[0F9C],bp
dec	byte	ptr	ss:[0F8A]
jmp	FELSKS
FEGMSERR:
sub	di,02
mov	si,di
mov	ax,es
mov	ds,ax
mov	es,word	ptr	ss:[9A90]
mov	di,word	ptr	ss:[9A92]
mov	byte	ptr	ss:[0F8C],00
push	dx
mov	dx,8110
call	ERROR_ROUT
pop	dx
P_INCDIR:
lodsb
xlat
or	al,al
js	P_INCDIR
dec	si
mov	ax,word	ptr	[si]
cmp	ax,2222
jne	NOTSETI
mov	byte	ptr	ss:[0EE6],00
ret
NOTSETI:
push	di
push	es
push	bx
mov	ax,ss
mov	es,ax
mov	di,0EE6
mov	bx,7929
IDLP:
lodsb
stosb
xlat
or	al,al
jns	IDLP
mov	bx,76A7
mov	byte	ptr	es:[di+FF],00
dec	si
pop	bx
pop	es
pop	di
ret
P_INCCOL:
lodsb
xlat
or	al,al
js	P_INCCOL
dec	si
call	COPYFNAME
push	ds
mov	ds,word	ptr	ss:[9A7C]
mov	dx,word	ptr	ss:[9A7E]
call	ADDFLIST
pop	ds
lodsb
cmp	al,2C
je	452F
jmp	P_INCCOLINFO
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	453D
jmp	P_EQUERR2
mov	word	ptr	ss:[9A80],cx
lodsb
cmp	al,2C
je	454A
jmp	P_INCCOLINFO
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	4558
jmp	P_EQUERR2
mov	ax,word	ptr	[9A80]
sub	cx,ax
js	P_INCCOLINFO
je	P_INCCOLINFO
mov	bx,0020
mul	bx
mov	word	ptr	[9A80],ax
mov	ax,cx
mul	bx
mov	word	ptr	[9A82],ax
call	SPLITOBJBUF
call	CALCROMPOS
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	es:[di+0E],cx
mov	byte	ptr	es:[di+10],02
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
mov	ax,word	ptr	[9A80]
mov	word	ptr	es:[di+11],ax
mov	ax,word	ptr	[9A7C]
mov	word	ptr	es:[di+08],ax
mov	ax,word	ptr	[9A7E]
mov	word	ptr	es:[di+0A],ax
xor	ax,ax
mov	word	ptr	es:[di+04],ax
mov	ax,word	ptr	[9A82]
mov	word	ptr	es:[di+06],ax
add	word	ptr	ss:[0F94],ax
adc	word	ptr	ss:[0F92],00
mov	bp,di
add	di,13
xor	ax,ax
mov	word	ptr	[9A80],ax
inc	word	ptr	ss:[13DC]
jmp	SPLITINC
P_INCCOLINFO:
push	dx
mov	dx,82E7
call	ERROR_ROUT
pop	dx
P_INCBIN:
lodsb
xlat
or	al,al
js	P_INCBIN
dec	si
call	COPYFNAME
push	di
push	ds
push	bx
mov	ax,ss
mov	ds,word	ptr	ss:[9A7C]
mov	dx,word	ptr	ss:[9A7E]
call	ADDFLIST
call	far	ptr	_OS2OPENFILE
jae	4601
jmp	P_INCBINERR
xor	cx,cx
mov	dx,cx
mov	bx,ax
call	far	ptr	_OS2SEEKEND
jae	4611
jmp	P_INCBINERR
mov	word	ptr	ss:[9A80],dx
mov	word	ptr	[9A82],ax
call	far	ptr	_OS2CLOSEFILE
pop	bx
pop	ds
pop	di
call	SPLITOBJBUF
call	CALCROMPOS
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	es:[di+0E],cx
mov	byte	ptr	es:[di+10],02
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
xor	ax,ax
mov	word	ptr	[0011],ax
mov	ax,word	ptr	[9A7C]
mov	word	ptr	es:[di+08],ax
mov	ax,word	ptr	[9A7E]
mov	word	ptr	es:[di+0A],ax
mov	bx,word	ptr	ss:[9A80]
mov	word	ptr	es:[di+04],bx
mov	ax,word	ptr	[9A82]
mov	word	ptr	es:[di+06],ax
add	word	ptr	ss:[0F94],ax
adc	word	ptr	ss:[0F92],bx
mov	bp,di
add	di,13
inc	word	ptr	ss:[13DC]
SPLITINC:
mov	word	ptr	es:[bp+00],es
mov	word	ptr	es:[bp+02],di
mov	word	ptr	ss:[13B6],es
mov	word	ptr	ss:[13B8],di
xor	ax,ax
push	di
mov	cx,0013
CLROBJ3:
stosb
dec	cx
jne	CLROBJ3
pop	di
mov	ax,word	ptr	[13BC]
mov	cx,word	ptr	ss:[13BE]
add	cx,word	ptr	ss:[9A82]
adc	ax,word	ptr	ss:[9A80]
mov	word	ptr	[13BC],ax
mov	word	ptr	ss:[13BE],cx
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	es:[di+0E],cx
mov	byte	ptr	es:[di+10],01
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
add	di,13
mov	word	ptr	ss:[13B4],di
mov	word	ptr	ss:[0F90],di
mov	bx,76A7
ret
P_INCBINERR:
pop	bx
pop	ds
pop	di
push	dx
mov	dx,80FF
call	ERROR_ROUT
pop	dx
P_INCLUDE:
lodsb
xlat
or	al,al
js	P_INCLUDE
dec	si
call	COPYFNAME
push	ds
push	si
push	es
push	di
mov	ds,word	ptr	ss:[9A7C]
mov	si,word	ptr	ss:[9A7E]
mov	ax,ss
mov	es,ax
mov	di,9778
mov	al,09
stosb
mov	ax,4946
stosw
mov	ax,454C
stosw
mov	ax,535F
stosw
mov	ax,5254
stosw
mov	al,byte	ptr	[9BDD]
or	al,al
je	NHEAD
mov	ax,365B
stosw
mov	ax,5D34
stosw
NHEAD:
mov	ax,223D
stosw
ASSLP2:
lodsb
stosb
xlat
or	al,al
jns	ASSLP2
dec	di
mov	al,22
stosb
mov	al,0D
stosb
mov	al,0A
stosb
mov	ax,ss
mov	ds,ax
mov	si,9778
call	P_STRING
pop	di
pop	es
pop	si
pop	ds
mov	bx,76A7
call	INCLUDEFILE
pop	ax
mov	byte	ptr	ss:[9BDD],00
cmp	byte	ptr	ss:[0F8D],00
jne	4761
jmp	DO_65816
jmp	DO_MARIO
INCLUDEFILE:
inc	word	ptr	ss:[13DC]
push	es
push	di
mov	bp,word	ptr	ss:[0F9C]
mov	word	ptr	[bp+0C],ds
mov	word	ptr	[bp+0E],si
mov	ax,word	ptr	[1470]
mov	word	ptr	[bp+00],ax
mov	ax,word	ptr	[0F96]
mov	word	ptr	[bp+04],ax
mov	ax,word	ptr	[13F0]
mov	word	ptr	[bp+15],ax
mov	ax,word	ptr	[0200]
mov	word	ptr	[bp+1B],ax
mov	ax,word	ptr	[0204]
mov	word	ptr	[bp+0A],ax
add	bp,1F
mov	ds,word	ptr	ss:[9A7C]
mov	dx,word	ptr	ss:[9A7E]
call	ADDFLIST
mov	word	ptr	[bp+17],ds
mov	word	ptr	[bp+1D],ds
mov	word	ptr	ss:[0F98],ds
mov	word	ptr	[bp+19],dx
mov	word	ptr	[bp+1F],dx
mov	word	ptr	ss:[0F9A],dx
call	far	ptr	_OS2OPENFILE
jae	47C9
jmp	CANTFINDSOURCEFILE
mov	word	ptr	[bp+02],ax
xor	ax,ax
mov	word	ptr	[bp+06],ax
mov	word	ptr	[bp+08],ax
push	bp
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jae	47E2
jmp	I_CANTALLOC
pop	bp
mov	word	ptr	[bp+10],ax
mov	word	ptr	[bp+12],0000
call	READMORESOURCE
mov	word	ptr	ss:[0F9C],bp
cmp	byte	ptr	ss:[0F8A],20
jl	SRCLOK1
mov	dx,7D45
call	FATALERR_ROUT
jmp	STOPASSEM
SRCLOK1:
inc	byte	ptr	ss:[0F8A]
xor	ax,ax
mov	word	ptr	[0AAE],ax
mov	word	ptr	[0AB6],ax
mov	word	ptr	[0AB2],ax
mov	word	ptr	[0AB4],ax
mov	word	ptr	[0AB0],ax
mov	word	ptr	[0AB8],ax
mov	word	ptr	[13FF],ax
mov	word	ptr	[0EDF],ax
mov	word	ptr	[248A],ax
mov	bx,0001
mov	word	ptr	ss:[13F0],bx
mov	word	ptr	ss:[248A],bx
mov	word	ptr	ss:[13EC],ds
mov	word	ptr	ss:[13EE],si
add	word	ptr	ss:[13EE],01
mov	bx,76A7
pop	di
pop	es
ret
CANTFINDSOURCEFILE:
push	word	ptr	ss:[0F98]
push	word	ptr	ss:[0F9A]
sub	bp,1F
mov	ax,word	ptr	[bp+15]
mov	word	ptr	[13F0],ax
mov	ax,word	ptr	[bp+17]
mov	word	ptr	[0F98],ax
mov	ax,word	ptr	[bp+19]
mov	word	ptr	[0F9A],ax
mov	dx,7BFB
call	FATALERR_ROUT
pop	word	ptr	ss:[0F9A]
pop	word	ptr	ss:[0F98]
call	PRINTLASTFNAME
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,89F8
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
jmp	STOPASSEM
I_CANTALLOC:
mov	dx,7C3F
call	FATALERR_ROUT
jmp	STOPASSEM
READMORESOURCE:
push	bp
mov	bx,word	ptr	[bp+02]
mov	cx,word	ptr	[bp+06]
mov	dx,word	ptr	[bp+08]
call	far	ptr	_OS2SEEKFILE
pop	bp
push	bp
mov	bx,word	ptr	[bp+02]
mov	cx,8000
mov	ds,word	ptr	[bp+10]
mov	dx,word	ptr	[bp+12]
call	far	ptr	_OS2READBYTES
pop	bp
mov	word	ptr	[0EE4],ax
or	ax,ax
je	ENDFILE
cmp	ax,8000
je	_NOTEND
mov	byte	ptr	[bp+14],01
mov	si,word	ptr	ss:[0EE4]
add	si,word	ptr	[bp+12]
mov	byte	ptr	[si],0D
mov	byte	ptr	[si+01],0A
mov	byte	ptr	[si+02],1A
mov	si,word	ptr	ss:[0EE4]
jmp	_DONEEND
_NOTEND:
mov	byte	ptr	[bp+14],04
mov	si,word	ptr	[bp+12]
add	si,7FFF
std
I_LOOP:
lodsb
cmp	al,0D
jne	I_LOOP
cld
inc	si
inc	si
mov	byte	ptr	[si],0A
inc	si
mov	byte	ptr	[si],1A
sub	si,word	ptr	[bp+12]
_DONEEND:
add	word	ptr	[bp+08],si
adc	word	ptr	[bp+06],00
mov	ds,word	ptr	[bp+10]
mov	si,word	ptr	[bp+12]
mov	bx,76A7
xor	al,al
ret
ENDFILE:
mov	al,01
or	al,al
ret
P_INC:
dec	si
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4937
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+6FCB]
or	al,al
je	4947
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_INA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	495B
jmp	PM
mov	al,1A
stosb
ret
P_INX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	496A
jmp	PM
mov	al,E8
stosb
ret
P_INY:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4979
jmp	PM
mov	al,C8
stosb
ret
P_JML:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4988
jmp	PM
lodsb
xlat
or	al,al
js	4988
dec	si
mov	al,byte	ptr	[si]
cmp	al,5B
jne	4999
jmp	P_JMLSB
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	4A1A
test	byte	ptr	ss:[0ACE],40
jne	49D7
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0004
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	49D3
call	MOREFR
pop	bp
pop	es
jmp	4A1A
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],04
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	4A16
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,5C
stosb
mov	word	ptr	es:[di],cx
mov	byte	ptr	es:[di+02],dl
add	di,03
ret
P_JMLSB:
inc	si
call	CONVEXPRESS
lodsb
cmp	al,5D
je	4A34
jmp	P_JMLERR
test	byte	ptr	ss:[0ACE],C0
je	4AB2
test	byte	ptr	ss:[0ACE],40
jne	4A6F
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	4A6B
call	MOREFR
pop	bp
pop	es
jmp	4AB2
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	4AAE
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,DC
stosb
mov	ax,cx
stosw
ret
P_JMLERR:
push	dx
mov	dx,8291
call	ERROR_ROUT
pop	dx
P_JMP:
cmp	byte	ptr	[si],2E
je	TRYJMPDOTL
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB8],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4ADC
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+7027]
or	al,al
je	4AEC
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
TRYJMPDOTL:
inc	si
lodsb
and	al,DF
cmp	al,4C
jne	4B00
jmp	P_JML
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
P_JSL:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4B13
jmp	PM
lodsb
xlat
or	al,al
js	4B13
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	4B9C
test	byte	ptr	ss:[0ACE],40
jne	4B59
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0004
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	4B55
call	MOREFR
pop	bp
pop	es
jmp	4B9C
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],04
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	4B98
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,22
stosb
mov	word	ptr	es:[di],cx
mov	byte	ptr	es:[di+02],dl
add	di,03
ret
P_JSR:
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB8],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4BC0
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+7055]
or	al,al
je	4BD0
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_LOWER:
lodsb
xlat
or	al,al
js	P_LOWER
dec	si
call	GETSTRINGADDR
push	ds
push	si
mov	si,cx
mov	ds,dx
LOLP:
lodsb
or	al,al
je	LOEXIT
cmp	al,41
jb	LOLP
cmp	al,5A
ja	LOLP
or	al,20
mov	byte	ptr	[si+FF],al
jmp	LOLP
LOEXIT:
pop	si
pop	ds
ret
P_LIST:
lodsb
xlat
or	al,al
js	P_LIST
dec	si
cmp	byte	ptr	[si],0A
je	P_LISTEND
lodsw
and	al,DF
cmp	ax,2B54
je	P_LISTTR
cmp	ax,2D54
je	P_LISTTROFF
and	ah,DF
cmp	ax,4E4F
je	P_LISTON
cmp	ax,464F
je	P_LISTOFF
cmp	ax,414D
je	P_LISTMA
dec	si
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_LISTEND:
dec	si
ret
P_LISTTR:
mov	byte	ptr	ss:[9BDC],01
jmp	P_LIST
P_LISTTROFF:
mov	byte	ptr	ss:[9BDC],00
jmp	P_LIST
P_LISTMA:
lodsw
and	ax,DFDF
cmp	ax,5243
jne	P_UNKOPT
add	si,02
mov	byte	ptr	ss:[13EB],01
jmp	P_LIST
P_LISTON:
or	byte	ptr	ss:[0F8B],04
jmp	P_LIST
P_LISTOFF:
inc	si
and	byte	ptr	ss:[0F8B],FB
mov	byte	ptr	ss:[13EB],00
jmp	P_LIST
P_UNKOPT:
push	dx
mov	dx,83C5
call	ERROR_ROUT
pop	dx
P_LOCAL:
test	byte	ptr	ss:[0F8B],01
jne	P_LOCSKIP
mov	bp,word	ptr	ss:[13F0]
cmp	word	ptr	ss:[0F7A],bp
je	4C92
jmp	P_EQUERR
push	es
push	di
push	ds
push	si
mov	ds,word	ptr	ss:[0F80]
mov	si,word	ptr	ss:[0F82]
mov	ax,ss
mov	es,ax
mov	di,8A6E
PLOLP:
lodsb
stosb
or	al,al
jne	PLOLP
dec	di
mov	ds,word	ptr	ss:[9A88]
mov	si,word	ptr	ss:[9A8A]
PLOLP2:
lodsb
stosb
or	al,al
jne	PLOLP2
mov	al,09
stosb
mov	ax,ss
mov	ds,ax
mov	si,8A6E
call	ADDSYMBOL
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
pop	si
pop	ds
pop	di
pop	es
P_LOCSKIP:
ret
P_LDA:
mov	al,byte	ptr	[0ABA]
test	al,01
je	4CF8
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4D06
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+7083]
or	al,al
je	4D16
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_LDX:
mov	al,byte	ptr	[0ABA]
test	al,02
je	4D2F
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4D3D
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+70B1]
or	al,al
je	4D4D
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_LDY:
mov	al,byte	ptr	[0ABA]
test	al,02
je	4D66
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4D74
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+70DF]
or	al,al
je	4D84
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_LONGA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4D98
jmp	PM
call	MAP_LONGA
or	byte	ptr	ss:[0ABA],01
push	es
mov	es,word	ptr	ss:[0AC1]
mov	bp,word	ptr	ss:[0AC3]
mov	word	ptr	es:[bp+0A],FFFF
mov	word	ptr	es:[bp+0C],FFFF
pop	es
ret
P_LONGI:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4DC5
jmp	PM
call	MAP_LONGI
or	byte	ptr	ss:[0ABA],02
push	es
mov	es,word	ptr	ss:[0ABD]
mov	bp,word	ptr	ss:[0ABF]
mov	word	ptr	es:[bp+0A],FFFF
mov	word	ptr	es:[bp+0C],FFFF
pop	es
ret
P_LSR:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	4DF5
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+710D]
or	al,al
je	4E05
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_MARIO:
lodsb
xlat
or	al,al
js	P_MARIO
dec	si
lodsw
and	ax,DFDF
cmp	ax,4E4F
je	P_MARIOON
cmp	ax,464F
je	P_MARIOOFF
dec	si
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_MARIOON:
mov	byte	ptr	ss:[0F8D],01
pop	ax
jmp	GOTEOLDO_MARIO
P_MARIOOFF:
mov	byte	ptr	ss:[0F8D],00
pop	ax
jmp	GOTEOLDO_65816
P_ENDM:
push	dx
mov	dx,82D8
call	ERROR_ROUT
pop	dx
P_MEXIT:
cmp	word	ptr	ss:[0AA6],00
je	P_MEXITERR
mov	ax,ss
mov	ds,ax
mov	si,254F
mov	bp,word	ptr	ss:[0F9C]
sub	bp,1F
mov	ax,word	ptr	[bp+04]
mov	word	ptr	[0F96],ax
mov	ax,word	ptr	[bp+00]
mov	word	ptr	[1470],ax
ret
P_MEXITERR:
push	dx
mov	dx,8241
call	ERROR_ROUT
pop	dx
P_MACRO:
test	byte	ptr	ss:[0F8B],06
je	PMNOLIST
call	LISTLINE
PMNOLIST:
mov	ah,0D
PMPARLP:
lodsb
cmp	ah,al
je	PMGOT1CR
cmp	al,09
je	PMPARLP
cmp	al,20
je	PMPARLP
cmp	al,3B
je	PMCOMM
cmp	al,2A
je	PMCOMM
cmp	al,5B
jne	PMCOMM
push	es
push	di
mov	ax,ss
mov	es,ax
mov	bp,0A0E
mov	di,020E
PMPLP2:
mov	word	ptr	es:[bp+00],di
xor	cx,cx
PMPLP:
lodsb
stosb
inc	cx
cmp	al,2C
je	PMPNEXTPAR
cmp	al,5D
je	PMPEND
cmp	al,0D
jne	PMPLP
pop	di
pop	es
push	dx
mov	dx,8291
call	ERROR_ROUT
pop	dx
PMPNEXTPAR:
dec	cx
mov	word	ptr	es:[bp+02],cx
dec	di
add	bp,04
cmp	bp,0090
cmp	bp,24
jae	PMPLP2
pop	di
pop	es
push	dx
mov	dx,8059
call	ERROR_ROUT
pop	dx
PMPEND:
dec	cx
mov	word	ptr	es:[bp+02],cx
add	bp,08
mov	word	ptr	ss:[0AA8],bp
pop	di
pop	es
mov	ah,0D
PMCOMM:
lodsb
cmp	ah,al
jne	PMCOMM
PMGOT1CR:
inc	si
inc	word	ptr	ss:[13F0]
push	si
mov	bp,word	ptr	ss:[13F0]
dec	bp
cmp	word	ptr	ss:[0F7A],bp
je	4F11
jmp	PM_ADD
push	es
push	di
mov	es,word	ptr	ss:[0F7C]
mov	di,word	ptr	ss:[0F7E]
mov	al,byte	ptr	[0AAA]
or	al,al
je	NONEEDCHK
push	ds
push	si
mov	ax,word	ptr	es:[di+06]
mov	si,word	ptr	es:[di+08]
mov	ds,ax
call	GETMACRO
pop	si
pop	ds
mov	bp,word	ptr	ss:[13F0]
cmp	bp,word	ptr	ss:[0AAC]
je	NONEEDCHK
sub	si,0A
push	es
push	di
push	ds
push	si
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,7FD5
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
push	ds
push	dx
push	si
push	ax
mov	bx,word	ptr	es:[di+06]
mov	dx,word	ptr	es:[di+08]
mov	ds,bx
mov	si,dx
lodsb
or	al,al
jne	4F6A
mov	byte	ptr	[si+FF],24
call	far	ptr	_OS2PRTSTRING
mov	byte	ptr	[si+FF],00
pop	ax
pop	si
pop	dx
pop	ds
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,2552
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
pop	si
pop	ds
pop	di
pop	es
push	dx
mov	dx,7FC0
call	ERROR_ROUT
pop	dx
NONEEDCHK:
xor	ax,ax
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],ax
mov	ax,word	ptr	[0AA2]
mov	word	ptr	es:[di+0A],ax
mov	ax,word	ptr	[0AA4]
mov	word	ptr	es:[di+0C],ax
mov	byte	ptr	es:[di+04],02
pop	di
pop	es
jmp	PM_ADDED
PM_ADD:
std
PMADDLP:
lodsb
cmp	al,0A
jne	PMADDLP
PMADDLP2:
lodsb
cmp	al,0A
jne	PMADDLP2
inc	si
inc	si
cld
call	ADDMACRO
PM_ADDED:
and	byte	ptr	ss:[0F8B],FE
pop	si
push	es
push	di
mov	es,word	ptr	ss:[0AA2]
mov	di,word	ptr	ss:[0AA4]
mov	ax,0A0D
stosw
COPYMAC:
lodsb
cmp	al,1A
jne	4FEF
jmp	MAC_MORE
cmp	al,0D
je	MACEOL
mov	bx,78A9
xlat
mov	bx,76A7
or	al,al
js	MACWHITE
cmp	al,3B
je	MACGOTOEOL
cmp	al,2A
je	MACGOTOEOL
stosb
cmp	al,7B
jne	MACSYM
call	P_CHKMACPAR
MACSYM:
lodsb
stosb
cmp	al,7B
jne	5018
call	P_CHKMACPAR
xlat
or	al,al
jns	MACSYM
dec	di
mov	al,byte	ptr	[si+FF]
cmp	al,0D
je	MACEOL
cmp	al,3B
je	MACGOTOEOL
cmp	al,2A
je	MACGOTOEOL
MACWHITE:
lodsb
cmp	al,0D
je	MACEOL
xlat
or	al,al
js	MACWHITE
mov	al,09
stosb
cmp	al,7B
jne	5043
call	P_CHKMACPAR
dec	si
lodsb
stosb
cmp	al,7B
jne	504D
call	P_CHKMACPAR
and	al,DF
cmp	al,45
je	TRYENDM
MAC_STORE:
lodsb
MACEOL:
stosb
cmp	al,7B
jne	505C
call	P_CHKMACPAR
cmp	al,0D
jne	MAC_STORE
lodsb
stosb
cmp	al,7B
jne	MACEOL2
call	P_CHKMACPAR
MACEOL2:
test	byte	ptr	ss:[0F8B],04
jne	MACLL
MACLLRET:
cmp	di,7F80
jbe	OUTMACRET
jmp	ERR_OUTMACSPACE
OUTMACRET:
inc	word	ptr	ss:[13F0]
inc	word	ptr	ss:[13F0]
jmp	COPYMAC
MACGOTOEOL:
lodsb
cmp	al,0D
jne	MACGOTOEOL
inc	si
jmp	MACEOL2
MACLL:
dec	si
dec	si
push	di
mov	di,word	ptr	ss:[0F90]
call	LISTLINE
pop	di
inc	si
inc	si
jmp	MACLLRET
TRYENDM:
lodsb
stosb
cmp	al,7B
jne	50A3
call	P_CHKMACPAR
mov	dl,al
and	dl,DF
cmp	dl,4E
jne	MAC_STORE
lodsb
stosb
cmp	al,7B
jne	50B6
call	P_CHKMACPAR
mov	dl,al
and	dl,DF
cmp	dl,44
jne	MAC_STORE
lodsb
stosb
cmp	al,7B
jne	50C9
call	P_CHKMACPAR
mov	dl,al
and	dl,DF
cmp	dl,4D
jne	MAC_STORE
lodsb
stosb
cmp	al,7B
jne	50DC
call	P_CHKMACPAR
xlat
or	al,al
js	50E5
jmp	MAC_STORE
sub	di,06
mov	al,5C
stosb
xor	al,al
stosb
dec	si
mov	word	ptr	ss:[0AA4],di
pop	di
pop	es
ret
P_CHKMACPAR:
cmp	byte	ptr	[si],7B
jne	CHKOK
lodsb
stosb
ret
CHKOK:
dec	di
push	ax
push	es
push	di
mov	word	ptr	ss:[9A7C],ds
mov	word	ptr	ss:[9A7E],si
mov	ax,ss
mov	es,ax
mov	bp,0A0E
mov	dx,0031
CHKLP:
mov	di,word	ptr	es:[bp+00]
mov	cx,word	ptr	es:[bp+02]
add	bp,04
cmp	bp,word	ptr	ss:[0AA8]
jb	CHKTRY
pop	di
pop	es
pop	ax
push	dx
mov	dx,8091
call	ERROR_ROUT
pop	dx
CHKTRY:
mov	ds,word	ptr	ss:[9A7C]
mov	si,word	ptr	ss:[9A7E]
CHKLP2:
lodsb
cmp	byte	ptr	es:[di],al
jne	CHKNEXT
inc	di
dec	cx
jne	CHKLP2
mov	al,byte	ptr	[si]
cmp	al,7D
je	CHKGOT
xlat
or	al,al
js	CHKGOT2
CHKNEXT:
inc	dx
cmp	dx,3A
jne	CHKLP
mov	dx,0041
jmp	CHKLP
CHKGOT:
inc	si
CHKGOT2:
pop	di
pop	es
mov	al,5C
mov	ah,dl
stosw
pop	ax
ret
ERR_OUTMACSPACE:
mov	ax,7F5C
stosw
mov	bx,0801
call	far	ptr	_OS2ALLOCSEG
jb	MOREMAC
mov	word	ptr	es:[di],ax
mov	word	ptr	[0AA2],ax
mov	es,ax
xor	di,di
mov	bx,76A7
jmp	OUTMACRET
MOREMAC:
mov	dx,82B5
call	FATALERR_ROUT
jmp	STOPASSEM
MAC_MORE:
push	bp
mov	bp,word	ptr	ss:[0F9C]
call	READMORESOURCE
jne	MAC_NOENDM
pop	bp
jmp	COPYMAC
MAC_NOENDM:
mov	dx,804B
call	FATALERR_ROUT
jmp	STOPASSEM
P_MVN:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	51B4
jmp	PM
mov	byte	ptr	es:[di],54
jmp	P_MVM
P_MVP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	51C5
jmp	PM
mov	byte	ptr	es:[di],44
P_MVM:
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	51D7
jmp	P_EQUERR2
mov	byte	ptr	es:[di+01],dl
lodsb
cmp	al,2C
je	E_BADSEP
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	51EE
jmp	P_EQUERR2
mov	byte	ptr	es:[di+02],dl
add	di,03
ret
E_BADSEP:
push	dx
mov	dx,8276
call	ERROR_ROUT
pop	dx
P_NOP:
mov	al,EA
stosb
ret
P_ORA:
mov	al,byte	ptr	[0ABA]
test	al,01
je	5212
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5220
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+713B]
or	al,al
je	5230
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
M_ORG:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	P_ORG
jmp	PM
P_ORG:
lodsb
xlat
or	al,al
js	P_ORG
dec	si
call	SPLITOBJBUF
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	525D
jmp	P_EQUERR2
mov	word	ptr	ss:[0F92],dx
mov	word	ptr	ss:[0F94],cx
inc	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	5276
jmp	P_EQUERR2
mov	word	ptr	ss:[13BC],dx
mov	word	ptr	ss:[13BE],cx
mov	word	ptr	es:[di+0C],dx
mov	word	ptr	es:[di+0E],cx
mov	byte	ptr	es:[di+10],01
mov	al,byte	ptr	[13BA]
or	byte	ptr	es:[di+10],al
mov	es,word	ptr	ss:[13B6]
mov	di,word	ptr	ss:[13B8]
add	di,13
mov	word	ptr	ss:[13B4],di
mov	word	ptr	ss:[0F8E],es
mov	word	ptr	ss:[0F90],di
ret
SPLITOBJBUF:
cmp	word	ptr	ss:[13B4],di
je	NOSPLIT
call	CALCLENLASTBLK
mov	es,word	ptr	ss:[13B6]
mov	bp,word	ptr	ss:[13B8]
mov	word	ptr	es:[bp+06],dx
mov	word	ptr	es:[bp+04],ax
mov	word	ptr	es:[bp+00],es
mov	word	ptr	es:[bp+02],di
mov	word	ptr	ss:[13B6],es
mov	word	ptr	ss:[13B8],di
xor	ax,ax
push	di
mov	cx,0013
CLROBJ2:
stosb
dec	cx
jne	CLROBJ2
pop	di
ret
NOSPLIT:
mov	es,word	ptr	ss:[13B6]
mov	di,word	ptr	ss:[13B8]
xor	ax,ax
mov	word	ptr	[13C0],ax
mov	word	ptr	[13C2],ax
ret
CALCLENLASTBLK:
xor	ax,ax
mov	dx,di
sub	dx,word	ptr	ss:[13B4]
mov	word	ptr	ss:[13C2],dx
mov	word	ptr	[13C0],ax
ret
CALCROMPOS:
mov	ax,word	ptr	[13BC]
mov	cx,word	ptr	ss:[13BE]
add	cx,word	ptr	ss:[13C2]
adc	ax,word	ptr	ss:[13C0]
mov	word	ptr	[13BC],ax
mov	word	ptr	ss:[13BE],cx
ret
P_OUTPUT:
lodsb
xlat
or	al,al
js	P_OUTPUT
dec	si
mov	ax,word	ptr	[si]
and	ax,DFDF
cmp	ax,464F
je	OUTPUTOFF
NOTOFF:
call	COPYNAMENID
mov	ax,word	ptr	[9A7C]
mov	word	ptr	[249C],ax
mov	ax,word	ptr	[9A7E]
mov	word	ptr	[249E],ax
mov	byte	ptr	ss:[2498],01
mov	byte	ptr	ss:[2499],04
ret
OUTPUTOFF:
mov	al,byte	ptr	[si+02]
and	al,DF
cmp	al,46
jne	NOTOFF
mov	al,byte	ptr	[si+03]
xlat
or	al,al
jns	NOTOFF
mov	byte	ptr	ss:[2499],00
ret
COPYNAMENID:
push	di
push	es
mov	es,word	ptr	ss:[0ED9]
mov	di,word	ptr	ss:[0EDB]
mov	word	ptr	ss:[9A7C],es
mov	word	ptr	ss:[9A7E],di
mov	bx,7929
OULOOP:
lodsb
stosb
xlat
or	al,al
jns	OULOOP
mov	byte	ptr	es:[di+FF],00
mov	bx,76A7
dec	si
mov	word	ptr	ss:[0EDB],di
cmp	di,1F00
jb	53B4
call	MOREHEAP
pop	es
pop	di
ret
COPYFNAME:
push	di
push	es
mov	es,word	ptr	ss:[0ED9]
mov	di,word	ptr	ss:[0EDB]
mov	word	ptr	ss:[9A7C],es
mov	word	ptr	ss:[9A7E],di
mov	bx,7929
mov	dx,si
CFLP1:
lodsb
xlat
or	al,al
js	CIDIR
cmp	al,5C
je	CNAME
cmp	al,2F
je	CNAME
jmp	CFLP1
CIDIR:
mov	si,dx
push	ds
push	si
mov	si,ss
mov	ds,si
mov	si,0EE6
IDLOOP:
lodsb
stosb
or	al,al
jne	IDLOOP
dec	di
pop	si
pop	ds
CNAME:
mov	si,dx
mov	bx,7929
OULOOP2:
lodsb
stosb
xlat
or	al,al
jns	OULOOP2
mov	byte	ptr	es:[di+FF],00
mov	bx,76A7
dec	si
mov	word	ptr	ss:[0EDB],di
cmp	di,1F00
jb	541B
call	MOREHEAP
pop	es
pop	di
ret
P_PRINTF:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5429
jmp	PM
lodsb
xlat
or	al,al
js	5429
dec	si
P_PRINTF2:
mov	word	ptr	ss:[0ED1],di
mov	al,byte	ptr	[0EE1]
or	al,al
jne	MUSTDOF
mov	al,byte	ptr	[13EA]
or	al,al
jne	MUSTDOF
ret
MUSTDOF:
push	es
push	di
mov	ax,ss
mov	es,ax
mov	di,word	ptr	ss:[2472]
PFOUTLP:
lodsb
cmp	al,22
je	PFGOT
cmp	al,27
je	PFGOT
cmp	al,3B
jne	5462
jmp	PFEND
mov	bx,76A7
xlat
or	al,al
jns	546E
jmp	PFNOVAL
dec	si
call	GETFIELD
push	dx
push	di
mov	di,word	ptr	ss:[0ED1]
call	CONVEXPRESS
pop	di
test	byte	ptr	ss:[0ACE],C0
je	PFOK
pop	dx
pop	di
pop	es
push	dx
mov	dx,80D7
call	ERROR_ROUT
pop	dx
PFOK:
call	PFPRTNUM
pop	dx
jmp	PFEND2
PFGOT:
mov	dh,al
mov	byte	ptr	ss:[2482],FF
mov	byte	ptr	ss:[2483],20
cmp	byte	ptr	[si],5B
jne	PFGOTFLD2
inc	si
cmp	byte	ptr	[si],5B
je	PFGOTFLD2
mov	bl,0A
xor	ax,ax
PFGTLP:
mov	cl,byte	ptr	[si]
inc	si
sub	cl,30
cmp	cl,09
jle	54C2
jmp	PFFLD
add	al,cl
cmp	byte	ptr	[si],5D
je	PFGOTFLD
cmp	byte	ptr	[si],2C
je	PFGETCOM
mul	bl
cmp	ax,00FF
jle	54D8
jmp	PFFLD
jmp	PFGTLP
PFGETCOM:
mov	cl,al
inc	si
lodsb
mov	byte	ptr	[2483],al
lodsb
cmp	al,5D
je	54EA
jmp	PFFLD
dec	si
mov	al,cl
PFGOTFLD:
mov	byte	ptr	[2482],al
inc	si
PFGOTFLD2:
xor	dl,dl
PFLOOP:
lodsb
cmp	al,25
jne	54FC
jmp	PFSPEC
cmp	al,dh
je	PFEND
cmp	al,0D
jne	PFPERC
jmp	PFNOEND
PFPERC:
inc	dl
cmp	dl,byte	ptr	ss:[2482]
ja	PFLOOP
stosb
jmp	PFLOOP
PFEND:
mov	byte	ptr	ss:[2485],dl
call	PFDOTFIELD
PFEND2:
lodsb
cmp	al,2C
jne	5523
jmp	PFOUTLP
mov	bx,76A7
xlat
or	al,al
js	552F
jmp	PFNOVAL
push	di
sub	di,word	ptr	ss:[2472]
mov	cx,di
pop	di
mov	word	ptr	ss:[2486],cx
mov	al,byte	ptr	[247D]
or	al,al
jne	PFOUT
mov	byte	ptr	ss:[247C],00
cmp	byte	ptr	es:[di+FE],0D
je	PFOKCR
mov	byte	ptr	ss:[247C],01
PFOKCR:
push	ds
push	si
mov	ax,ss
mov	ds,ax
mov	ax,4002
mov	dx,word	ptr	ss:[2472]
mov	bx,word	ptr	ss:[2474]
or	bx,bx
je	PFSCR
mov	bx,word	ptr	ss:[2476]
call	far	ptr	_OS2WRITEBYTES
pop	si
pop	ds
jmp	PFOUT
PFSCR:
mov	bx,0001
call	far	ptr	_OS2WRITEBYTES
pop	si
pop	ds
PFOUT:
mov	bx,76A7
pop	di
pop	es
ret
PFNOEND:
dec	si
dec	si
dec	si
pop	di
pop	es
push	dx
mov	dx,8162
call	ERROR_ROUT
pop	dx
PFSPEC:
call	GETFIELD
lodsb
mov	bp,ax
and	bp,00FF
add	bp,bp
jmp	word	ptr	[bp+6D2B]
BADPF:
PF:
pop	di
pop	es
push	dx
mov	dx,87E2
call	ERROR_ROUT
pop	dx
EXTPF:
lodsb
and	al,DF
cmp	al,42
jne	55BE
jmp	PFNUMBYTES
cmp	al,57
jne	55C5
jmp	PFNUMWARNINGS
cmp	al,45
jne	55CC
jmp	PFNUMERRORS
cmp	al,4C
jne	55D3
jmp	PFNUMLINES
cmp	al,46
jne	55DA
jmp	PFNUMFILES
cmp	al,53
jne	55E1
jmp	PFNUMSYMBOLS
jmp	BADPF
PFPREXP:
call	GETFIELD
push	dx
push	di
mov	di,word	ptr	ss:[0ED1]
call	CONVEXPRESS
pop	di
test	byte	ptr	ss:[0ACE],C0
je	PFOK2
pop	dx
pop	di
pop	es
push	dx
mov	dx,80D7
call	ERROR_ROUT
pop	dx
PFOK2:
call	PFPRTNUM
inc	si
pop	dx
jmp	PFLOOP
PFUNK:
mov	al,byte	ptr	[0ACD]
or	al,al
je	NOUNK
push	ds
push	si
mov	ds,word	ptr	ss:[9A8C]
mov	si,word	ptr	ss:[9A8E]
mov	ax,word	ptr	[si+06]
mov	cx,word	ptr	[si+08]
mov	ds,ax
mov	si,cx
mov	ax,2220
stosw
inc	dl
inc	dl
mov	bx,76A7
FRELP:
inc	dl
lodsb
stosb
xlat
or	al,al
jns	FRELP
dec	di
mov	al,22
stosb
inc	dl
pop	si
pop	ds
NOUNK:
jmp	PFLOOP
PFHEX:
xor	cx,cx
lodsb
cmp	al,41
jb	PFHEX1
and	al,DF
sub	al,07
PFHEX1:
sub	al,30
cmp	al,0F
jg	BADPFHEX
and	al,0F
mov	cl,al
add	cl,cl
add	cl,cl
add	cl,cl
add	cl,cl
lodsb
cmp	al,41
jb	PFHEX2
and	al,DF
sub	al,07
PFHEX2:
sub	al,30
cmp	al,0F
jg	BADPFHEX
and	al,0F
or	al,cl
stosb
jmp	PFLOOP
BADPFHEX:
push	dx
mov	dx,87B1
call	ERROR_ROUT
pop	dx
PFC:
mov	al,byte	ptr	[13E8]
or	al,al
je	NOANSI
mov	ax,5B1B
stosw
dec	si
lodsw
lodsw
stosw
mov	al,6D
stosb
jmp	PFLOOP
NOANSI:
inc	si
jmp	PFLOOP
PFPARENT:
push	ds
push	si
mov	ds,word	ptr	ss:[0F80]
mov	si,word	ptr	ss:[0F82]
PFPLP:
lodsb
stosb
inc	dl
or	al,al
jne	PFPLP
pop	si
pop	ds
jmp	PFLOOP
PFSTR:
mov	word	ptr	ss:[9A86],dx
call	GETSTRINGADDR
push	ds
push	si
mov	si,cx
mov	ds,dx
mov	dx,word	ptr	ss:[9A86]
PFSTRLP:
lodsb
stosb
inc	dl
or	al,al
jne	PFSTRLP
dec	dl
dec	di
pop	si
pop	ds
jmp	PFLOOP
PFBS:
mov	al,08
stosb
inc	dl
jmp	PFLOOP
PFQUOTE:
mov	al,22
stosb
inc	dl
jmp	PFLOOP
PFNUMSYMBOLS:
push	dx
mov	cx,word	ptr	ss:[13CA]
mov	dx,word	ptr	ss:[13C8]
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFNUMBYTES:
push	dx
mov	cx,word	ptr	ss:[13CE]
mov	dx,word	ptr	ss:[13CC]
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFNUMWARNINGS:
push	dx
mov	cx,word	ptr	ss:[13C6]
xor	dx,dx
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFMEM:
push	dx
call	far	ptr	_OS2AVAILMEM
mov	cx,ax
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFNUMERRORS:
push	dx
mov	cx,word	ptr	ss:[13C4]
xor	dx,dx
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFNUMLINES:
push	dx
mov	cx,word	ptr	ss:[13D2]
mov	dx,word	ptr	ss:[13D0]
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFNUMFILES:
push	dx
mov	cx,word	ptr	ss:[13DC]
xor	dx,dx
call	PFPRTNUM
pop	dx
jmp	PFLOOP
PFERRDESC:
push	si
mov	si,word	ptr	ss:[13DE]
PFERDLP:
mov	al,byte	ptr	es:[si]
inc	si
cmp	al,24
je	PFERDEND
stosb
jmp	PFERDLP
PFERDEND:
pop	si
jmp	PFLOOP
PFERROR:
push	si
mov	si,word	ptr	ss:[13E0]
PFERLP:
mov	al,byte	ptr	es:[si]
inc	si
cmp	al,24
je	PFEREND
stosb
jmp	PFERLP
PFEREND:
pop	si
jmp	PFLOOP
PFSWITCH:
or	byte	ptr	ss:[0F8B],02
jmp	PFLOOP
PFFILE:
push	ds
push	si
mov	al,byte	ptr	[0AD0]
or	al,al
jne	PFFILEFR
mov	bp,word	ptr	ss:[0F9C]
test	byte	ptr	[bp+14],05
jne	PFFCURSRC
PFFLP:
sub	bp,1F
test	byte	ptr	[bp+14],05
je	PFFLP
mov	ds,word	ptr	[bp+17]
mov	si,word	ptr	[bp+19]
jmp	PFFILELP
PFFCURSRC:
mov	ds,word	ptr	[bp+17]
mov	si,word	ptr	[bp+19]
jmp	PFFILELP
PFFILEFR:
mov	ds,word	ptr	ss:[0F98]
mov	si,word	ptr	ss:[0F9A]
PFFILELP:
lodsb
stosb
inc	dl
or	al,al
jne	PFFILELP
dec	di
pop	si
pop	ds
jmp	PFLOOP
PFCR:
mov	ax,0A0D
stosw
mov	dl,00
jmp	PFLOOP
PFTAB:
mov	al,09
stosb
add	dl,08
jmp	PFLOOP
PFMACRO:
push	ds
push	si
mov	bp,word	ptr	ss:[0F9C]
mov	ax,word	ptr	[bp+1D]
mov	si,word	ptr	[bp+1F]
mov	ds,ax
PFMACLP:
lodsb
stosb
inc	dl
or	al,al
jne	PFMACLP
dec	di
pop	si
pop	ds
jmp	PFLOOP
PFMACRO2:
push	ds
push	si
mov	bp,word	ptr	ss:[0F9C]
NEXTLEVUP:
sub	bp,1F
cmp	bp,0F9E
jbe	LEVOK
test	byte	ptr	[bp+14],02
je	NEXTLEVUP
LEVOK:
mov	ax,word	ptr	[bp+1D]
mov	si,word	ptr	[bp+1F]
mov	ds,ax
PFMACLP2:
lodsb
stosb
inc	dl
or	al,al
jne	PFMACLP2
dec	di
pop	si
pop	ds
jmp	PFLOOP
PFLINE:
mov	al,byte	ptr	[0AD0]
or	al,al
jne	PF_FRLINE
push	dx
call	GETLINE
mov	cx,ax
xor	dx,dx
call	PFPRTNUM
pop	dx
add	dl,byte	ptr	ss:[2485]
mov	al,2F
stosb
inc	dl
call	GETLINE_MACROS
dec	di
dec	dl
or	ax,ax
je	PFNOMACL
inc	di
inc	dl
push	dx
mov	cx,ax
xor	dx,dx
call	PFPRTNUM
pop	dx
add	dl,byte	ptr	ss:[2485]
PFNOMACL:
jmp	PFLOOP
PF_FRLINE:
push	dx
mov	cx,word	ptr	ss:[13F0]
xor	dx,dx
call	PFPRTNUM
pop	dx
add	dl,byte	ptr	ss:[2485]
jmp	PFLOOP
GETFIELD:
mov	byte	ptr	ss:[2480],00
mov	byte	ptr	ss:[2481],20
mov	byte	ptr	ss:[2484],00
cmp	byte	ptr	[si],3A
jne	GETF
cmp	byte	ptr	[si+01],24
jne	PFBADRADIX
mov	byte	ptr	ss:[2484],01
inc	si
inc	si
GETF:
mov	al,byte	ptr	[si]
cmp	al,5B
jne	PFNOF
inc	si
lodsb
sub	al,30
cmp	al,09
jg	PFFLD
mov	cl,al
lodsb
cmp	al,5D
je	PFFOK
cmp	al,2C
jne	PFFLD
lodsb
mov	byte	ptr	[2481],al
lodsb
cmp	al,5D
jne	PFFLD
PFFOK:
mov	byte	ptr	ss:[2480],cl
PFNOF:
ret
PFFLD:
pop	di
pop	es
push	dx
mov	dx,8827
call	ERROR_ROUT
pop	dx
PFNOVAL:
pop	di
pop	es
push	dx
mov	dx,8809
call	ERROR_ROUT
pop	dx
PFBADRADIX:
push	dx
mov	dx,8787
call	ERROR_ROUT
pop	dx
PFPRTNUM:
push	di
mov	al,byte	ptr	[2484]
or	al,al
jne	PFDOPRTHEX
call	BIN2DECL
pop	di
call	PFDOFIELD
call	BIN2DECL
mov	di,word	ptr	ss:[2488]
dec	di
ret
PFDOPRTHEX:
pop	di
call	BIN2HEXL
ret
PFDOFIELD:
mov	bl,byte	ptr	ss:[2480]
or	bl,bl
je	ENDFIELD2
sub	bl,byte	ptr	ss:[2485]
js	ENDFIELD2
je	ENDFIELD2
mov	al,byte	ptr	[2481]
FIELDLP2:
stosb
dec	bl
jne	FIELDLP2
ENDFIELD2:
ret
PFDOTFIELD:
mov	bl,byte	ptr	ss:[2482]
or	bl,bl
je	ENDTFIELD
sub	bl,dl
js	ENDTFIELD
je	ENDTFIELD
mov	al,byte	ptr	[2483]
TFIELDLP:
stosb
dec	bl
jne	TFIELDLP
ENDTFIELD:
ret
P_EXTERN:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	M_EXTERN
jmp	PM
M_EXTERN:
lodsb
xlat
or	al,al
js	M_EXTERN
dec	si
P_EXTERNLP:
cmp	byte	ptr	[si],2E
je	E_EXTNOLOCALS
mov	byte	ptr	ss:[A49C],01
call	ADDSYMBOL
mov	byte	ptr	ss:[A49C],00
test	byte	ptr	ss:[0F8B],01
jne	EXT2
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	byte	ptr	es:[bp+04],41
pop	es
lodsb
cmp	al,2C
je	P_EXTERNLP
dec	si
ret
EXT2:
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	al,byte	ptr	es:[bp+04]
pop	es
test	al,80
jne	E_EXTERNISPUB
E_EXTERNISPUB:
push	dx
mov	dx,864D
call	ERROR_ROUT
pop	dx
E_EXTNOLOCALS:
push	dx
mov	dx,8574
call	ERROR_ROUT
pop	dx
P_PUBLIC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	59B5
jmp	PM
lodsb
xlat
or	al,al
js	59B5
dec	si
P_PUBLICLP:
cmp	byte	ptr	[si],2E
je	E_PUBNOLOCALS
call	ADDSYMBOL
test	byte	ptr	ss:[0F8B],01
jne	PUB2
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	byte	ptr	es:[bp+04],91
pop	es
PUB2RET:
lodsb
cmp	al,2C
je	P_PUBLICLP
dec	si
ret
PUB2:
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
test	byte	ptr	es:[bp+04],40
jne	E_PUBISEXTERN
or	byte	ptr	es:[bp+04],80
and	byte	ptr	ss:[0F8B],FE
pop	es
jmp	PUB2RET
E_PUBISEXTERN:
pop	es
push	dx
mov	dx,8630
call	ERROR_ROUT
pop	dx
E_PUBNOLOCALS:
push	dx
mov	dx,8553
call	ERROR_ROUT
pop	dx
P_PEA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5A21
jmp	PM
lodsb
xlat
or	al,al
js	5A21
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	5AAA
test	byte	ptr	ss:[0ACE],40
jne	5A67
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	5A63
call	MOREFR
pop	bp
pop	es
jmp	5AAA
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	5AA6
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,F4
stosb
mov	ax,cx
stosw
ret
P_PEI:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5ABC
jmp	PM
lodsb
xlat
or	al,al
js	5ABC
dec	si
cmp	byte	ptr	[si],28
je	5ACC
jmp	P_PEIERR
call	CONVEXPRESS
or	dx,dx
je	5AD6
jmp	P_PEIERR1
or	ch,ch
je	5ADD
jmp	P_PEIERR1
test	byte	ptr	ss:[0ACE],C0
je	5B5B
test	byte	ptr	ss:[0ACE],40
jne	5B18
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	5B14
call	MOREFR
pop	bp
pop	es
jmp	5B5B
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	5B57
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,D4
mov	ah,cl
stosw
ret
P_PEIERR:
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
P_PEIERR1:
push	dx
mov	dx,7F28
call	ERROR_ROUT
pop	dx
P_PER:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5B7C
jmp	PM
mov	byte	ptr	es:[di],62
jmp	P_LCC
P_PHA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5B8E
jmp	PM
mov	al,48
stosb
ret
P_PHB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5B9D
jmp	PM
mov	al,8B
stosb
ret
P_PHD:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5BAC
jmp	PM
mov	al,0B
stosb
ret
P_PHK:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5BBB
jmp	PM
mov	al,4B
stosb
ret
P_PHP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5BCA
jmp	PM
mov	al,08
stosb
ret
P_PHX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5BD9
jmp	PM
mov	al,DA
stosb
ret
P_PHY:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5BE8
jmp	PM
mov	al,5A
stosb
ret
P_PLA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5BF7
jmp	PM
mov	al,68
stosb
ret
P_PLB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5C06
jmp	PM
mov	al,AB
stosb
ret
P_PLD:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5C15
jmp	PM
mov	al,2B
stosb
ret
P_PLP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5C24
jmp	PM
mov	al,28
stosb
ret
P_PLX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5C33
jmp	PM
mov	al,FA
stosb
ret
P_PLY:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5C42
jmp	PM
mov	al,7A
stosb
ret
M_RUN:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	P_RUN
jmp	PM
P_RUN:
lodsb
xlat
or	al,al
js	P_RUN
dec	si
push	word	ptr	ss:[2472]
mov	word	ptr	ss:[2472],8B36
mov	byte	ptr	ss:[247D],01
call	P_PRINTF2
mov	byte	ptr	ss:[247D],00
pop	word	ptr	ss:[2472]
push	bx
mov	bx,word	ptr	ss:[2486]
add	bx,8B36
mov	word	ptr	ss:[bx],0A0D
mov	byte	ptr	ss:[bx+02],1A
mov	bp,word	ptr	ss:[0F9C]
dec	si
mov	word	ptr	[bp+0C],ds
mov	word	ptr	[bp+0E],si
mov	ax,word	ptr	[1470]
mov	word	ptr	[bp+00],ax
mov	ax,word	ptr	[0F96]
mov	word	ptr	[bp+04],ax
mov	ax,word	ptr	[13F0]
mov	word	ptr	[bp+15],ax
mov	ax,word	ptr	[0204]
mov	word	ptr	[bp+0A],ax
mov	ax,word	ptr	[0200]
mov	word	ptr	[bp+1B],ax
mov	ax,word	ptr	[bp+17]
mov	bx,word	ptr	[bp+19]
add	bp,1F
mov	byte	ptr	[bp+14],08
mov	word	ptr	[bp+17],ax
mov	word	ptr	[bp+19],bx
mov	ax,8AC9
mov	word	ptr	[bp+1D],ax
mov	ax,8BFE
mov	word	ptr	[bp+1F],ax
mov	word	ptr	ss:[0F9C],bp
cmp	byte	ptr	ss:[0F8A],20
jl	SRCLOK3
mov	dx,7D45
call	FATALERR_ROUT
jmp	STOPASSEM
SRCLOK3:
inc	byte	ptr	ss:[0F8A]
mov	ax,ss
mov	ds,ax
mov	si,8B36
pop	bx
pop	ax
cmp	byte	ptr	ss:[0F8D],00
jne	5D0A
jmp	DO_65816
jmp	DO_MARIO
P_REP:
lodsb
xlat
or	al,al
js	P_REP
dec	si
lodsb
cmp	al,23
je	5D1D
jmp	P_REPERR
call	CONVEXPRESS
or	dx,dx
je	5D27
jmp	BADVAL
or	ch,ch
je	5D2E
jmp	BADVAL
test	byte	ptr	ss:[0ACE],C0
je	5DAC
test	byte	ptr	ss:[0ACE],40
jne	5D69
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	5D65
call	MOREFR
pop	bp
pop	es
jmp	5DAC
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	5DA8
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,C2
mov	ah,cl
stosw
ret
P_REPERR:
push	dx
mov	dx,80AE
call	ERROR_ROUT
pop	dx
M_IRP:
P_IRP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5DC5
jmp	PM
cmp	word	ptr	ss:[1470],00
jne	5DD0
jmp	P_NOTINREPT
lodsb
xlat
or	al,al
js	5DD0
dec	si
call	ADDSYMBOL
mov	bx,76A7
test	byte	ptr	ss:[0F8B],01
jne	NOIRP2
mov	bp,word	ptr	ss:[13F0]
cmp	word	ptr	ss:[0F7A],bp
jne	NOIRP
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	byte	ptr	es:[bp+04],05
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
push	bp
mov	bp,word	ptr	ss:[1401]
inc	si
mov	cx,word	ptr	[bp+10]
sub	cx,word	ptr	[bp+06]
je	IRPGOT
IRPLOOP:
lodsb
cmp	al,2C
je	IRPCOMMA
xlat
or	al,al
jns	IRPLOOP
pop	bp
pop	es
push	dx
mov	dx,84D4
call	ERROR_ROUT
pop	dx
IRPCOMMA:
dec	cx
jne	IRPLOOP
IRPGOT:
call	CONVEXPRESS
pop	bp
test	byte	ptr	ss:[0ACE],C0
jne	IRPERR
mov	word	ptr	es:[bp+0A],dx
mov	word	ptr	es:[bp+0C],cx
pop	es
ret
IRPERR:
pop	bp
pop	es
NOIRP:
push	dx
mov	dx,80D7
call	ERROR_ROUT
pop	dx
NOIRP2:
ret
P_NOTINREPT:
push	dx
mov	dx,84C2
call	ERROR_ROUT
pop	dx
M_IRS:
P_IRS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5E75
jmp	PM
cmp	word	ptr	ss:[1470],00
je	P_NOTINREPT
lodsb
xlat
or	al,al
js	5E7D
dec	si
call	GETSTRINGADDR
push	di
mov	di,cx
mov	word	ptr	ss:[9A7C],dx
mov	bp,word	ptr	ss:[1401]
inc	si
mov	cx,word	ptr	[bp+10]
sub	cx,word	ptr	[bp+06]
je	IRCGOT2
mov	bp,si
IRCLOOP:
lodsb
mov	dl,al
cmp	dl,27
je	IRCL1
cmp	dl,22
je	IRCL1
pop	di
push	dx
mov	dx,85A9
call	ERROR_ROUT
pop	dx
IRCL1:
lodsb
cmp	al,0D
je	IRCEOL
cmp	dl,al
jne	IRCL1
inc	si
mov	al,byte	ptr	[si]
cmp	al,0A
je	IRCEOL
xlat
or	al,al
jns	IRCNEOL
IRCEOL:
mov	si,bp
IRCNEOL:
dec	cx
jne	IRCLOOP
IRCGOT2:
lodsb
mov	dl,al
cmp	dl,27
je	IRCGOT
cmp	dl,22
je	IRCGOT
pop	di
push	dx
mov	dx,85A9
call	ERROR_ROUT
pop	dx
IRCGOT:
push	es
mov	es,word	ptr	ss:[9A7C]
IRCCOPY:
lodsb
stosb
cmp	al,0D
je	IRCEND
cmp	al,dl
jne	IRCCOPY
IRCEND:
mov	byte	ptr	es:[di+FF],00
pop	es
pop	di
ret
P_REPT:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	5F0A
jmp	PM
lodsb
xlat
or	al,al
js	5F0A
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	5F20
jmp	P_IFERR
or	dx,dx
js	P_REPTERR1
jne	DOREPT
or	cx,cx
je	P_REPTERR1
DOREPT:
cmp	byte	ptr	[si],0A
je	REPFOUNDLF0
mov	ah,0D
REPFINDLF:
lodsb
cmp	ah,al
jne	REPFINDLF
REPFOUNDLF0:
dec	si
cmp	word	ptr	ss:[1470],06
jge	P_REPTERROR
inc	word	ptr	ss:[1470]
push	es
push	di
add	word	ptr	ss:[1401],12
mov	di,word	ptr	ss:[1401]
mov	ax,8AC9
mov	es,ax
sub	cx,01
sbb	dx,00
mov	word	ptr	es:[di],ds
mov	word	ptr	es:[di+02],si
mov	word	ptr	es:[di+04],dx
mov	word	ptr	es:[di+06],cx
mov	word	ptr	es:[di+0E],dx
mov	word	ptr	es:[di+10],cx
mov	ax,word	ptr	[13F0]
inc	ax
mov	word	ptr	es:[di+08],ax
mov	bp,word	ptr	ss:[0F9C]
mov	ax,word	ptr	[bp+06]
mov	word	ptr	es:[di+0A],ax
mov	ax,word	ptr	[bp+08]
mov	word	ptr	es:[di+0C],ax
pop	di
pop	es
ret
P_REPTERROR:
push	dx
mov	dx,819A
call	ERROR_ROUT
pop	dx
P_REPTERR1:
push	dx
mov	dx,818A
call	ERROR_ROUT
pop	dx
P_ENDR:
test	word	ptr	ss:[1470],FFFF
jne	5FAE
jmp	P_ENDRERR
mov	bp,word	ptr	ss:[0F9C]
sub	bp,1F
mov	dx,word	ptr	[bp+00]
cmp	dx,word	ptr	ss:[1470]
jl	5FC3
jmp	P_ENDRERROR
mov	bp,word	ptr	ss:[1401]
mov	ax,word	ptr	[bp+04]
mov	cx,word	ptr	[bp+06]
sub	cx,01
sbb	ax,0000
jns	SETREPT
sub	word	ptr	ss:[1401],12
dec	word	ptr	ss:[1470]
dec	word	ptr	ss:[13F0]
ret
SETREPT:
mov	word	ptr	[bp+04],ax
mov	word	ptr	[bp+06],cx
mov	ax,word	ptr	[bp+0A]
mov	cx,word	ptr	[bp+0C]
push	bp
mov	bp,word	ptr	ss:[0F9C]
cmp	word	ptr	[bp+06],ax
jne	REPTRELOAD
cmp	word	ptr	[bp+08],cx
jne	REPTRELOAD
pop	bp
REPTRELOADRET:
mov	ds,word	ptr	[bp+00]
mov	si,word	ptr	[bp+02]
mov	ax,word	ptr	[bp+08]
mov	cx,word	ptr	ss:[13F0]
mov	word	ptr	[13F0],ax
sub	cx,ax
dec	cx
add	word	ptr	ss:[13D2],cx
adc	word	ptr	ss:[13D0],00
ret
REPTRELOAD:
pop	bp
push	bp
mov	bp,word	ptr	ss:[0F9C]
mov	word	ptr	[bp+06],ax
mov	word	ptr	[bp+08],cx
mov	byte	ptr	[bp+14],04
call	READMORESOURCE
pop	bp
jne	P_ENDRERROR2
mov	ax,word	ptr	[bp+08]
cmp	word	ptr	ss:[13FF],ax
je	RELOADOK
mov	word	ptr	[13FF],ax
RELOADOK:
jmp	REPTRELOADRET
P_ENDRERROR2:
pop	di
pop	es
push	dx
mov	dx,81D7
call	ERROR_ROUT
pop	dx
P_ENDRERROR:
push	dx
mov	dx,81BA
call	ERROR_ROUT
pop	dx
P_ENDRERR:
push	dx
mov	dx,81AA
call	ERROR_ROUT
pop	dx
P_ROL:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6071
jmp	PM
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	607F
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+7169]
or	al,al
je	608F
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_ROR:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	60A6
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+7197]
or	al,al
je	60B6
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_RTI:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	60CA
jmp	PM
mov	al,40
stosb
ret
P_RTL:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	60D9
jmp	PM
mov	al,6B
stosb
ret
P_RTS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	60E8
jmp	PM
mov	al,60
stosb
ret
P_SBC:
mov	al,byte	ptr	[0ABA]
test	al,01
je	60FC
mov	ax,word	ptr	[13F0]
mov	word	ptr	[0AB2],ax
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	610A
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+71C5]
or	al,al
je	611A
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_SEC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	612E
jmp	PM
mov	al,38
stosb
ret
P_SED:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	613D
jmp	PM
mov	al,F8
stosb
ret
P_SEI:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	614C
jmp	PM
mov	al,78
stosb
ret
P_SEP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	615B
jmp	PM
lodsb
xlat
or	al,al
js	615B
dec	si
lodsb
cmp	al,23
je	616B
jmp	P_REPERR
call	CONVEXPRESS
or	dx,dx
je	6175
jmp	BADVAL
or	ch,ch
je	617C
jmp	BADVAL
test	byte	ptr	ss:[0ACE],C0
je	61FA
test	byte	ptr	ss:[0ACE],40
jne	61B7
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	61B3
call	MOREFR
pop	bp
pop	es
jmp	61FA
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	61F6
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,E2
mov	ah,cl
stosw
ret
P_SET:
lodsb
xlat
or	al,al
js	P_SET
dec	si
test	byte	ptr	ss:[0F8B],01
jne	SETSKIP
mov	bp,word	ptr	ss:[13F0]
cmp	word	ptr	ss:[0F7A],bp
je	621F
jmp	P_EQUERR
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	6245
jmp	P_EQUERR2
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	word	ptr	es:[bp+0A],dx
mov	word	ptr	es:[bp+0C],cx
or	byte	ptr	es:[bp+04],04
pop	es
SETSKIP:
ret
P_SHORTA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	626A
jmp	PM
call	MAP_SHORTA
and	byte	ptr	ss:[0ABA],FE
push	es
mov	es,word	ptr	ss:[0AC1]
mov	bp,word	ptr	ss:[0AC3]
mov	word	ptr	es:[bp+0A],0000
mov	word	ptr	es:[bp+0C],0000
pop	es
ret
P_SHORTI:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6297
jmp	PM
call	MAP_SHORTI
and	byte	ptr	ss:[0ABA],FD
push	es
mov	es,word	ptr	ss:[0ABD]
mov	bp,word	ptr	ss:[0ABF]
mov	word	ptr	es:[bp+0A],0000
mov	word	ptr	es:[bp+0C],0000
pop	es
ret
P_STA:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	62C7
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+71F3]
or	al,al
je	62D7
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_STP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	62EB
jmp	PM
mov	al,DB
stosb
ret
P_STX:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	62FD
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+7221]
or	al,al
je	630D
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_SUPPRESS:
P_SUPPRESS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6321
jmp	PM
lodsb
xlat
or	al,al
js	6321
dec	si
lodsw
and	ax,DFDF
cmp	ax,4157
je	SUR_WA
cmp	ax,5245
je	SUR_ER
cmp	ax,5845
je	SUR_EX
cmp	ax,4E41
je	SUR_AN
cmp	ax,5250
je	SUR_PR
SURERR:
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
SUR_PR:
lodsw
and	ax,DFDF
cmp	ax,4654
jne	SURERR
mov	byte	ptr	ss:[13EA],00
ret
SUR_AN:
lodsw
and	ax,DFDF
cmp	ax,4953
jne	SURERR
mov	byte	ptr	ss:[13E8],00
ret
SUR_EX:
lodsw
and	ax,DFDF
cmp	ax,5250
jne	SURERR
mov	byte	ptr	ss:[13E6],01
ret
SUR_WA:
lodsw
and	ax,DFDF
cmp	ax,4E52
jne	SURERR
lodsw
and	ax,DFDF
cmp	ax,4E49
jne	SURERR
lodsw
and	ax,DFDF
cmp	ax,5347
jne	SURERR
mov	byte	ptr	ss:[13E7],01
ret
SUR_ER:
lodsw
and	ax,DFDF
cmp	ax,4F52
jne	SURERR
lodsw
and	ax,DFDF
cmp	ax,5352
jne	SURERR
mov	byte	ptr	ss:[13E9],01
ret
P_RELEASE:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	63C4
jmp	PM
lodsb
xlat
or	al,al
js	63C4
dec	si
lodsw
and	ax,DFDF
cmp	ax,4157
je	REL_WA
cmp	ax,5245
je	REL_ER
cmp	ax,5845
je	REL_EX
cmp	ax,4E41
je	REL_AN
cmp	ax,5250
je	REL_PR
jmp	SURERR
REL_PR:
lodsw
and	ax,DFDF
cmp	ax,4654
je	63F8
jmp	SURERR
mov	byte	ptr	ss:[13EA],00
ret
REL_AN:
lodsw
and	ax,DFDF
cmp	ax,4953
je	640B
jmp	SURERR
mov	byte	ptr	ss:[13E8],01
ret
REL_EX:
lodsw
and	ax,DFDF
cmp	ax,5250
je	641E
jmp	SURERR
mov	byte	ptr	ss:[13E6],00
ret
REL_WA:
lodsw
and	ax,DFDF
cmp	ax,4E52
je	6431
jmp	SURERR
lodsw
and	ax,DFDF
cmp	ax,4E49
je	643D
jmp	SURERR
lodsw
and	ax,DFDF
cmp	ax,5347
je	6449
jmp	SURERR
mov	byte	ptr	ss:[13E7],00
ret
REL_ER:
lodsw
and	ax,DFDF
cmp	ax,4F52
je	645C
jmp	SURERR
lodsw
and	ax,DFDF
cmp	ax,5352
je	6468
jmp	SURERR
mov	byte	ptr	ss:[13E9],00
ret
P_STY:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	647D
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+724F]
or	al,al
je	648D
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_STZ:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	64A4
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+727D]
or	al,al
je	64B4
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
ret
P_TAX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	64C9
jmp	PM
mov	al,AA
stosb
ret
P_TAY:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	64D8
jmp	PM
mov	al,A8
stosb
ret
P_TCD:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	64E7
jmp	PM
mov	al,5B
stosb
ret
P_TCS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	64F6
jmp	PM
mov	al,1B
stosb
ret
P_TDC:
mov	al,7B
stosb
ret
P_TRB:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	650C
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+72D9]
or	al,al
je	651C
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
P_TSB:
call	GETEA
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6533
jmp	E_EXTRACHARS
mov	ax,word	ptr	[bp+72AB]
or	al,al
je	6543
stosb
mov	al,ah
xor	ah,ah
add	di,ax
ret
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
ret
ret
P_TSC:
mov	al,3B
stosb
ret
P_TSX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	655C
jmp	PM
mov	al,BA
stosb
ret
P_TXA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	656B
jmp	PM
mov	al,8A
stosb
ret
P_TXS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	657A
jmp	PM
mov	al,9A
stosb
ret
P_TXY:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6589
jmp	PM
mov	al,9B
stosb
ret
P_TYA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6598
jmp	PM
mov	al,98
stosb
ret
P_TYX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	65A7
jmp	PM
mov	al,BB
stosb
ret
P_TYPE:
lodsb
xlat
or	al,al
js	P_TYPE
dec	si
call	COPYNAMENID
push	di
push	es
push	si
push	ds
mov	ds,word	ptr	ss:[9A7C]
mov	dx,word	ptr	ss:[9A7E]
call	far	ptr	_OS2OPENFILE
jb	TYPEFAIL2
mov	bx,ax
TYPELP:
mov	ds,word	ptr	ss:[0ED9]
mov	cx,word	ptr	ss:[0EDB]
mov	dx,1F00
sub	dx,cx
xchg	cx,dx
push	bx
push	cx
call	far	ptr	_OS2READBYTES
jb	TYPEFAIL
push	ax
mov	cx,ax
mov	ds,word	ptr	ss:[0ED9]
mov	dx,word	ptr	ss:[0EDB]
mov	bx,0001
call	far	ptr	_OS2WRITEBYTES
pop	ax
pop	cx
pop	bx
cmp	ax,cx
je	TYPELP
call	far	ptr	_OS2CLOSEFILE
pop	ds
pop	si
pop	es
pop	di
ret
TYPEFAIL:
pop	cx
pop	bx
TYPEFAIL2:
pop	ds
pop	si
pop	es
pop	di
push	dx
mov	dx,80FF
call	ERROR_ROUT
pop	dx
P_TIME:
lodsb
xlat
or	al,al
js	P_TIME
dec	si
call	far	ptr	_OS2GETTIME
push	dx
push	cx
call	ADDSYMBOL
pop	cx
pop	dx
mov	bx,76A7
test	byte	ptr	ss:[0F8B],01
jne	NOTIME
push	es
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
and	byte	ptr	es:[bp+04],EF
or	byte	ptr	es:[bp+04],05
mov	word	ptr	es:[bp+0A],cx
mov	word	ptr	es:[bp+0C],dx
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
pop	es
NOTIME:
ret
P_UPPER:
lodsb
xlat
or	al,al
js	P_UPPER
dec	si
call	GETSTRINGADDR
push	ds
push	si
mov	si,cx
mov	ds,dx
UPLP:
lodsb
or	al,al
je	UPEXIT
cmp	al,61
jb	UPLP
cmp	al,7A
ja	UPLP
and	al,DF
mov	byte	ptr	[si+FF],al
jmp	UPLP
UPEXIT:
pop	si
pop	ds
ret
P_WAI:
inc	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	66A5
jmp	PM
mov	al,CB
stosb
ret
P_WRITE:
lodsb
xlat
or	al,al
js	P_WRITE
dec	si
lodsw
and	ax,DFDF
cmp	ax,4E4F
je	P_WRITEON
cmp	ax,464F
je	P_WRITEOFF
dec	si
push	dx
mov	dx,8078
call	ERROR_ROUT
pop	dx
P_WRITEON:
or	byte	ptr	ss:[13BA],04
ret
P_WRITEOFF:
and	byte	ptr	ss:[13BA],FB
ret
P_XBA:
P_SWA:
mov	al,EB
stosb
ret
P_XCE:
mov	al,FB
stosb
ret
P_A:
and	ah,DF
cmp	ah,44
je	P_AD
cmp	ah,53
LOCALEND:
cld
push	bx
je	P_AS
cmp	ah,4E
je	66F3
jmp	PM
lodsb
and	al,DF
cmp	al,44
jne	66FD
jmp	P_AND
jmp	PM
P_AD:
lodsb
and	al,DF
cmp	al,43
jne	670A
jmp	P_ADC
jmp	PM
P_AS:
lodsb
and	al,DF
cmp	al,4C
jne	6717
jmp	P_ASL
jmp	PM
P_B:
mov	al,ah
xor	ah,ah
xlat
sub	al,41
jge	6727
jmp	PM
shl	al,1
mov	bp,ax
jmp	word	ptr	[bp+66F7]
P_BC:
lodsb
and	al,DF
cmp	al,53
jne	6739
jmp	P_BCS
cmp	al,43
jne	6740
jmp	P_BCC
jmp	PM
P_BE:
lodsb
and	al,DF
cmp	al,51
je	674D
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_BI
jmp	P_BEQ
P_BI:
lodsb
and	al,DF
cmp	al,54
jne	6762
jmp	P_BIT
jmp	PM
P_BM:
lodsb
and	al,DF
cmp	al,49
je	676F
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_BN
jmp	P_BMI
P_BN:
lodsb
and	al,DF
cmp	al,45
je	6784
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_BP
jmp	P_BNE
P_BP:
lodsb
and	al,DF
cmp	al,4C
je	6799
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_BR
jmp	P_BPL
P_BR:
lodsb
and	al,DF
cmp	al,41
jne	67AE
jmp	P_BRA
cmp	al,4B
jne	67B5
jmp	P_BRK
cmp	al,4C
jne	67BC
jmp	P_BRL
jmp	PM
P_BV:
lodsb
and	al,DF
cmp	al,53
jne	67C9
jmp	P_BVS
cmp	al,43
jne	67D0
jmp	P_BVC
jmp	PM
P_C:
and	ah,DF
cmp	ah,4C
je	P_CL
cmp	ah,4D
je	P_CM
cmp	ah,4F
je	P_CO
cmp	ah,50
je	P_CP
cmp	ah,48
je	P_CH
jmp	PM
P_CH:
lodsw
and	ax,DFDF
cmp	ax,4345
je	67FE
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4D4B
je	680A
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4341
jne	6816
jmp	P_CHECKMAC
jmp	PM
P_CL:
lodsb
and	al,DF
cmp	al,43
jne	6823
jmp	P_CLC
cmp	al,44
jne	682A
jmp	P_CLD
cmp	al,49
jne	6831
jmp	P_CLI
cmp	al,56
jne	6838
jmp	P_CLV
jmp	PM
P_CM:
lodsb
and	al,DF
cmp	al,50
jne	6845
jmp	P_CMP
jmp	PM
P_CO:
lodsb
and	al,DF
cmp	al,50
je	6852
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_CP
jmp	P_COP
P_CP:
lodsb
and	al,DF
cmp	al,58
jne	6867
jmp	P_CPX
cmp	al,59
jne	686E
jmp	P_CPY
jmp	PM
P_D:
and	ah,DF
cmp	ah,45
jne	P_DX
P_DE:
lodsb
and	al,DF
cmp	al,43
jne	6883
jmp	P_DEC
cmp	al,58
jne	688A
jmp	P_DEX
cmp	al,59
jne	6891
jmp	P_DEY
cmp	al,46
je	P_DEF
jmp	PM
P_DEF:
lodsw
and	ax,DFDF
cmp	al,53
jne	68A3
jmp	P_DEFS
cmp	ax,5245
je	P_DEFER
cmp	ax,4E45
je	68B0
jmp	PM
lodsb
and	al,DF
cmp	al,44
je	68BA
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_DEFER
jmp	P_DEFEND
P_DEFER:
lodsw
and	ax,DFDF
cmp	ax,4F52
je	68D1
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	68DB
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_DX
jmp	P_DEFERROR
P_DX:
cmp	ah,42
jne	68EE
jmp	P_DB
cmp	ah,57
jne	68F6
jmp	P_DW
cmp	ah,53
jne	68FE
jmp	P_DS
cmp	ah,41
je	6906
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4554
je	6912
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	691D
jmp	PM
lodsb
xlat
or	al,al
js	691D
dec	si
call	ADDSYMBOL
mov	bx,76A7
test	byte	ptr	ss:[0F8B],01
jne	NODATE
push	es
push	di
call	far	ptr	_OS2GETDATE
mov	es,word	ptr	ss:[0F7C]
mov	bp,word	ptr	ss:[0F7E]
mov	byte	ptr	es:[bp+04],05
mov	word	ptr	es:[bp+0A],cx
mov	word	ptr	es:[bp+0C],dx
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
pop	di
pop	es
NODATE:
ret
P_E:
and	ah,DF
cmp	ah,4F
jne	6977
jmp	P_EO
cmp	ah,4E
jne	697F
jmp	P_EN
cmp	ah,51
je	P_EQ
cmp	ah,4C
je	P_EL
cmp	ah,58
jne	6991
jmp	P_EX
cmp	ah,52
jne	6999
jmp	P_ER
jmp	PM
P_EL:
lodsb
and	al,DF
cmp	al,53
je	P_ELS
jmp	PM
P_ELS:
lodsb
and	al,DF
cmp	al,45
je	69B0
jmp	PM
lodsb
and	al,DF
cmp	al,49
je	69BA
jmp	PM
lodsb
and	al,DF
cmp	al,46
je	69C4
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_EQ
jmp	P_ELSEIF
P_EQ:
lodsb
and	al,DF
cmp	al,55
je	M_EQU
jmp	PM
M_EQU:
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	69E4
jmp	P_EQU
lodsb
and	al,DF
cmp	al,52
je	69EE
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_EO
jmp	P_EQUR
P_EO:
lodsb
and	al,DF
cmp	al,52
jne	6A03
jmp	P_EOR
jmp	PM
P_EN:
lodsb
and	al,DF
cmp	al,44
je	M_END
jmp	PM
M_END:
mov	al,byte	ptr	[si]
and	al,DF
cmp	al,52
jne	6A1B
jmp	P_ENDR
cmp	al,43
jne	6A22
jmp	P_ENDC
cmp	al,4D
jne	6A29
jmp	P_ENDM
jmp	P_END
P_EX:
lodsw
and	ax,DFDF
cmp	ax,4554
je	6A38
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4E52
jne	6A44
jmp	P_EXTERN
jmp	PM
P_ER:
lodsw
and	ax,DFDF
cmp	ax,4F52
je	6A53
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	6A5D
jmp	PM
lodsb
cmp	al,2B
je	6A65
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6A70
jmp	PM
inc	word	ptr	ss:[13C4]
ret
P_F:
dec	si
lodsw
and	ax,DFDF
cmp	ax,4941
je	P_FAI
cmp	ax,504F
je	P_FOP
cmp	ax,4C43
je	P_FCL
jmp	PM
P_FAI:
lodsb
and	al,DF
cmp	al,4C
je	6A97
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_FOP
jmp	P_FAIL
P_FOP:
lodsw
and	ax,DFDF
cmp	ax,4E45
jne	6AAE
jmp	P_FOPEN
jmp	PM
P_FCL:
lodsw
and	ax,DFDF
cmp	ax,534F
je	6ABD
jmp	PM
lodsb
and	al,DF
cmp	al,45
je	6AC7
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_G
jmp	P_FCLOSE
P_G:
and	ah,DF
cmp	ah,45
je	6ADD
jmp	PM
lodsb
and	al,DF
cmp	al,54
je	6AE7
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4E45
je	6AF3
jmp	PM
lodsb
and	al,DF
cmp	al,56
je	6AFD
jmp	PM
jmp	P_GETENV
P_I:
and	ah,DF
cmp	ah,4E
je	P_IN
cmp	ah,46
jne	6B10
jmp	P_IF
cmp	ah,52
jne	6B18
jmp	P_IR
jmp	PM
P_IN:
lodsb
and	al,DF
cmp	al,43
je	P_INC2
cmp	al,58
jne	6B29
jmp	P_INX
cmp	al,59
jne	6B30
jmp	P_INY
cmp	al,41
jne	6B37
jmp	P_INA
jmp	PM
P_INC2:
lodsb
and	al,DF
cmp	al,4C
je	P_INCL
cmp	al,42
je	P_INCB
cmp	al,43
je	P_INCC
cmp	al,44
je	P_INCD
jmp	P_INC
P_INCD:
lodsb
and	al,DF
cmp	al,49
je	6B5A
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	6B64
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	6B6F
jmp	P_INCDIR
jmp	PM
P_INCB:
lodsb
and	al,DF
cmp	al,49
je	6B7C
jmp	PM
lodsb
and	al,DF
cmp	al,4E
je	6B86
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	6B91
jmp	P_INCBIN
jmp	PM
P_INCL:
lodsb
and	al,DF
cmp	al,55
je	6B9E
jmp	PM
lodsb
and	al,DF
cmp	al,44
je	6BA8
jmp	PM
lodsb
and	al,DF
cmp	al,45
je	6BB2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	6BBD
jmp	P_INCLUDE
jmp	PM
P_INCC:
lodsb
and	al,DF
cmp	al,4F
je	6BCA
jmp	PM
lodsb
and	al,DF
cmp	al,4C
je	6BD4
jmp	PM
lodsb
xlat
or	al,al
jns	6BDE
jmp	P_INCCOL
jmp	PM
P_IR:
lodsb
and	al,DF
cmp	al,50
jne	6BEB
jmp	M_IRP
cmp	al,53
jne	6BF2
jmp	M_IRS
jmp	PM
P_J:
and	ah,DF
cmp	ah,4D
je	P_JM
cmp	ah,53
je	P_JS
jmp	PM
P_JM:
lodsb
and	al,DF
cmp	al,4C
jne	6C0F
jmp	P_JML
cmp	al,50
jne	6C16
jmp	P_JMP
jmp	PM
P_JS:
lodsb
and	al,DF
cmp	al,4C
jne	6C23
jmp	P_JSL
cmp	al,52
jne	6C2A
jmp	P_JSR
jmp	PM
P_L:
and	ah,DF
cmp	ah,44
jne	P_LS
lodsb
and	al,DF
cmp	al,41
jne	6C3F
jmp	P_LDA
cmp	al,58
jne	6C46
jmp	P_LDX
cmp	al,59
jne	6C4D
jmp	P_LDY
jmp	PM
P_LS:
cmp	ah,4F
je	P_LO
cmp	ah,49
je	P_LI
cmp	ah,53
je	6C62
jmp	PM
lodsb
and	al,DF
cmp	al,52
jne	6C6C
jmp	P_LSR
jmp	PM
P_LO:
lodsw
and	ax,DFDF
cmp	ax,474E
jne	NO_LO
lodsb
and	al,DF
cmp	al,41
jne	6C82
jmp	P_LONGA
cmp	al,49
jne	6C89
jmp	P_LONGI
jmp	PM
NO_LO:
cmp	ax,4143
jne	NO_LOAC
lodsb
and	al,DF
cmp	al,4C
je	6C9B
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	NO_LOAC
jmp	P_LOCAL
NO_LOAC:
cmp	ax,4557
je	6CAE
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	6CB8
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_LI
jmp	P_LOWER
P_LI:
lodsb
and	al,DF
cmp	al,53
je	M_LIS
jmp	PM
M_LIS:
lodsb
and	al,DF
cmp	al,54
je	6CD7
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_M
jmp	P_LIST
P_M:
and	ah,DF
cmp	ah,41
je	P_MA
cmp	ah,45
je	P_ME
cmp	ah,56
je	P_MV
jmp	PM
P_ME:
lodsb
and	al,DF
cmp	al,58
je	6D01
jmp	PM
lodsb
and	al,DF
cmp	al,49
je	6D0B
jmp	PM
lodsb
and	al,DF
cmp	al,54
je	6D15
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_MA
jmp	P_MEXIT
P_MA:
lodsb
and	al,DF
cmp	al,43
jne	P_TRYMA
M_MAC:
lodsb
and	al,DF
cmp	al,52
je	6D31
jmp	PM
lodsb
and	al,DF
cmp	al,4F
je	6D3B
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_TRYMA
jmp	P_MACRO
P_TRYMA:
cmp	al,52
je	M_MAR
jmp	PM
M_MAR:
lodsb
and	al,DF
cmp	al,49
je	6D57
jmp	PM
lodsb
and	al,DF
cmp	al,4F
je	6D61
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_MV
jmp	P_MARIO
P_MV:
lodsb
and	al,DF
cmp	al,4E
jne	6D76
jmp	P_MVN
cmp	al,50
jne	6D7D
jmp	P_MVP
jmp	PM
P_N:
and	ah,DF
cmp	ah,4F
je	6D8B
jmp	PM
lodsb
and	al,DF
cmp	al,50
je	6D95
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_O
jmp	P_NOP
P_O:
and	ah,DF
cmp	ah,52
je	P_OR
cmp	ah,55
je	P_OU
jmp	PM
P_OR:
lodsb
and	al,DF
cmp	al,41
jne	6DBA
jmp	P_ORA
cmp	al,47
jne	6DC1
jmp	P_ORG
jmp	PM
P_OU:
lodsb
and	al,DF
cmp	al,54
je	6DCE
jmp	PM
lodsb
and	al,DF
cmp	al,50
je	6DD8
jmp	PM
lodsb
and	al,DF
cmp	al,55
je	6DE2
jmp	PM
lodsb
and	al,DF
cmp	al,54
je	6DEC
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_P
jmp	P_OUTPUT
P_P:
and	ah,DF
cmp	ah,45
je	P_PE
cmp	ah,48
je	P_PH
cmp	ah,4C
je	P_PL
cmp	ah,52
jne	6E11
jmp	P_PR
cmp	ah,55
jne	6E19
jmp	P_PU
jmp	PM
P_PE:
lodsb
and	al,DF
cmp	al,41
jne	6E26
jmp	P_PEA
cmp	al,49
jne	6E2D
jmp	P_PEI
cmp	al,52
jne	6E34
jmp	P_PER
jmp	PM
P_PH:
lodsb
and	al,DF
cmp	al,41
jne	6E41
jmp	P_PHA
cmp	al,58
jne	6E48
jmp	P_PHX
cmp	al,59
jne	6E4F
jmp	P_PHY
cmp	al,50
jne	6E56
jmp	P_PHP
cmp	al,42
jne	6E5D
jmp	P_PHB
cmp	al,44
jne	6E64
jmp	P_PHD
cmp	al,4B
jne	6E6B
jmp	P_PHK
jmp	PM
P_PL:
lodsb
and	al,DF
cmp	al,41
jne	6E78
jmp	P_PLA
cmp	al,58
jne	6E7F
jmp	P_PLX
cmp	al,59
jne	6E86
jmp	P_PLY
cmp	al,50
jne	6E8D
jmp	P_PLP
cmp	al,42
jne	6E94
jmp	P_PLB
cmp	al,44
jne	6E9B
jmp	P_PLD
jmp	PM
P_PR:
lodsw
and	ax,DFDF
cmp	ax,4E49
je	6EAA
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4654
jne	6EB6
jmp	P_PRINTF
jmp	PM
P_PU:
lodsw
and	ax,DFDF
cmp	ax,4C42
je	6EC5
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4349
jne	6ED1
jmp	P_PUBLIC
jmp	PM
P_R:
and	ah,DF
cmp	ah,45
je	P_RE
cmp	ah,54
je	P_RT
cmp	ah,4F
je	P_RO
cmp	ah,55
je	P_RU
jmp	PM
P_RE:
lodsb
and	al,DF
cmp	al,50
je	M_REP
cmp	al,4C
jne	P_REL
P_REL:
lodsw
and	ax,DFDF
cmp	ax,4145
je	6F05
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4553
jne	6F11
jmp	P_RELEASE
jmp	PM
M_REP:
lodsb
and	al,DF
cmp	al,54
jne	6F1E
jmp	P_REPT
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	6F2A
jmp	P_REP
jmp	PM
P_RO:
lodsb
and	al,DF
cmp	al,4C
jne	6F37
jmp	P_ROL
cmp	al,52
jne	6F3E
jmp	P_ROR
jmp	PM
P_RT:
lodsb
and	al,DF
cmp	al,4C
jne	6F4B
jmp	P_RTL
cmp	al,53
jne	6F52
jmp	P_RTS
cmp	al,49
jne	6F59
jmp	P_RTI
jmp	PM
P_RU:
lodsb
and	al,DF
cmp	al,4E
je	6F66
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_S
jmp	P_RUN
P_S:
and	ah,DF
cmp	ah,42
jne	6F7C
jmp	P_SB
cmp	ah,48
jne	6F84
jmp	P_SH
cmp	ah,45
jne	6F8C
jmp	P_SE
cmp	ah,54
jne	6F94
jmp	P_ST
cmp	ah,57
jne	6F9C
jmp	P_SW
cmp	ah,49
jne	6FA4
jmp	P_SI
cmp	ah,55
je	P_SU
jmp	PM
P_SU:
lodsw
and	ax,DFDF
cmp	ax,5342
je	P_SUBS
cmp	ax,5050
je	6FBD
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4552
je	6FC9
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,5353
jne	6FD5
jmp	P_SUPPRESS
jmp	PM
P_SUBS:
lodsw
and	ax,DFDF
cmp	ax,5254
je	P_SUBSTR
jmp	PM
P_SUBSTR:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	6FEF
jmp	PM
lodsb
xlat
or	al,al
js	6FEF
dec	si
mov	word	ptr	ss:[9A80],0020
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	700C
jmp	P_IFERR
mov	word	ptr	ss:[9A7C],cx
lodsb
cmp	al,5B
jne	SSNOPAD
lodsb
mov	byte	ptr	[9A80],al
lodsb
cmp	al,5D
je	7023
jmp	EAERR
lodsb
SSNOPAD:
cmp	al,2C
je	702B
jmp	EAERR
mov	word	ptr	ss:[9A7E],0096
cmp	byte	ptr	[si],2C
je	SUBSTRDEF
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	7045
jmp	P_IFERR
mov	word	ptr	ss:[9A7E],cx
SUBSTRDEF:
lodsb
cmp	al,2C
je	7052
jmp	EAERR
call	GETSTRINGADDR
push	ds
push	si
push	es
push	di
mov	si,cx
mov	ds,dx
mov	ax,ss
mov	es,ax
mov	di,9778
mov	ax,word	ptr	[9A7C]
or	ax,ax
jns	SSOK
neg	ax
mov	cx,ax
mov	al,byte	ptr	[9A80]
SSLP1:
stosb
dec	cx
jne	SSLP1
mov	word	ptr	ss:[9A7C],0000
SSOK:
push	ds
push	si
add	si,word	ptr	ss:[9A7C]
mov	cx,word	ptr	ss:[9A7E]
SUBSTRLP:
lodsb
stosb
dec	cx
jns	SUBSTRLP
mov	byte	ptr	es:[di+FF],00
pop	di
pop	es
mov	ax,ss
mov	ds,ax
mov	si,9778
SUBSTRLP2:
lodsb
stosb
or	al,al
jne	SUBSTRLP2
pop	di
pop	es
pop	si
pop	ds
ret
P_SI:
lodsb
and	al,DF
cmp	al,43
je	P_SIC
jmp	PM
P_SIC:
lodsb
and	al,DF
cmp	al,45
je	70BD
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	P_SICE
P_SICE:
????
ret
P_SW:
lodsb
and	al,DF
cmp	al,41
je	70D2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_SB
jmp	P_XBA
P_SB:
lodsb
and	al,DF
cmp	al,43
jne	70E7
jmp	P_SBC
jmp	PM
P_SH:
lodsb
and	al,DF
cmp	al,4F
je	70F4
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	70FE
jmp	PM
lodsb
and	al,DF
cmp	al,54
je	7108
jmp	PM
lodsb
and	al,DF
cmp	al,41
jne	7112
jmp	P_SHORTA
cmp	al,49
jne	7119
jmp	P_SHORTI
jmp	PM
P_SE:
lodsb
and	al,DF
cmp	al,43
jne	7126
jmp	P_SEC
cmp	al,44
jne	712D
jmp	P_SED
cmp	al,49
jne	7134
jmp	P_SEI
cmp	al,50
jne	713B
jmp	P_SEP
cmp	al,54
je	P_SET2
jmp	PM
P_SET2:
lodsw
and	ax,DFDF
cmp	ax,4244
je	714E
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	7158
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	P_SETDBR
P_SETDBR:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	716B
jmp	PM
lodsb
xlat
or	al,al
js	716B
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	7181
jmp	P_EQUERR2
or	dx,dx
jne	E_INVDBR
cmp	cx,00FF
ja	E_INVDBR
mov	word	ptr	ss:[0ABB],cx
ret
E_INVDBR:
push	dx
mov	dx,861B
call	ERROR_ROUT
pop	dx
P_ST:
lodsb
and	al,DF
cmp	al,41
jne	71A3
jmp	P_STA
cmp	al,58
jne	71AA
jmp	P_STX
cmp	al,59
jne	71B1
jmp	P_STY
cmp	al,5A
jne	71B8
jmp	P_STZ
cmp	al,50
jne	71BF
jmp	P_STP
cmp	al,52
je	P_STR
jmp	PM
P_STR:
lodsw
and	ax,DFDF
cmp	ax,4E49
je	P_STRIN
cmp	ax,5043
je	71D7
jmp	PM
lodsb
and	al,DF
cmp	al,59
je	71E1
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_STRIN
jmp	P_STRCPY
P_STRIN:
lodsb
and	al,DF
cmp	al,47
je	71F6
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	P_STRING
P_STRING:
lodsb
xlat
or	al,al
js	P_STRING
dec	si
push	si
call	GETSTRINGADDR
pop	ax
cmp	cx,A46D
jne	REDEFSTRING
cmp	dx,8AC9
je	P_NEWSTRING
REDEFSTRING:
push	es
push	di
mov	di,cx
mov	es,dx
xor	ch,ch
mov	cl,byte	ptr	es:[di+FF]
push	cx
lodsb
cmp	al,3D
je	722C
jmp	EAERR
mov	byte	ptr	ss:[247D],01
call	P_PRINTF2
mov	byte	ptr	ss:[247D],00
pop	cx
cmp	cx,word	ptr	ss:[2486]
jbe	E_STR2LONG
push	ds
push	si
mov	ax,ss
mov	ds,ax
mov	si,8A6E
mov	cx,word	ptr	ss:[2486]
COPYPFLP2:
lodsb
stosb
dec	cx
jns	COPYPFLP2
mov	byte	ptr	es:[di+FF],00
pop	si
pop	ds
pop	di
pop	es
ret
E_STR2LONG:
push	dx
mov	dx,86E7
call	ERROR_ROUT
pop	dx
P_NEWSTRING:
mov	si,ax
push	es
push	di
mov	al,byte	ptr	[9BDD]
or	al,al
jne	NCN
mov	al,byte	ptr	[si]
cmp	al,30
jae	727D
jmp	P_BADSTRVAL
cmp	al,39
ja	NCN
jmp	P_BADSTRVAL
NCN:
mov	es,word	ptr	ss:[0ED5]
mov	di,word	ptr	ss:[0ED7]
mov	bp,di
inc	di
xor	cl,cl
NSTRNLP:
lodsb
xlat
stosb
add	cl,01
or	al,al
jns	72A1
jmp	E_INVARRAY
cmp	al,5B
jne	NSTRNLP
dec	cl
mov	byte	ptr	es:[bp+00],cl
dec	di
cmp	byte	ptr	[si],5D
je	DEFLEN
mov	bx,76A7
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	72C2
jmp	E_INVSTR
or	dx,dx
je	72C9
jmp	E_INVSTR
cmp	cx,00FF
jbe	72D2
jmp	E_INVSTR
mov	word	ptr	ss:[9BE4],cx
jmp	GOTLEN
DEFLEN:
mov	word	ptr	ss:[9BE4],0000
GOTLEN:
lodsb
cmp	al,5D
je	72E8
jmp	EAERR
lodsb
cmp	al,3D
jne	NSTRNODEF
mov	byte	ptr	ss:[247D],01
call	P_PRINTF2
mov	byte	ptr	ss:[247D],00
jmp	STRDEF
NSTRNODEF:
mov	byte	ptr	ss:[8A6E],00
mov	word	ptr	ss:[2486],0001
STRDEF:
cmp	word	ptr	ss:[9BE4],00
jne	GOTLEN2
mov	ax,word	ptr	[2486]
mov	word	ptr	[9BE4],ax
GOTLEN2:
push	di
push	ds
push	si
mov	ax,ss
mov	ds,ax
mov	si,8A6E
mov	cx,word	ptr	ss:[2486]
cmp	cx,word	ptr	ss:[9BE4]
ja	E_INVARRAY
mov	ax,word	ptr	[9BE4]
add	ax,0002
stosb
COPYPFLP:
lodsb
stosb
dec	cx
jns	COPYPFLP
mov	byte	ptr	es:[di+FF],00
pop	si
pop	ds
pop	di
add	di,word	ptr	ss:[9BE4]
add	di,02
mov	word	ptr	es:[di],FFFF
mov	word	ptr	ss:[0ED7],di
cmp	di,1F00
jb	7361
call	MORESTRING
pop	di
pop	es
ret
E_INVARRAY:
pop	si
pop	ds
pop	di
pop	di
pop	es
push	dx
mov	dx,86D8
call	ERROR_ROUT
pop	dx
E_INVSTR:
pop	di
pop	es
push	dx
mov	dx,80D7
call	ERROR_ROUT
pop	dx
GETSTRINGADDR:
push	es
push	di
push	bx
mov	al,byte	ptr	[si]
cmp	al,30
jb	GSLET
cmp	al,39
ja	GSLET
mov	bx,77A7
jmp	GSGLET
GSLET:
mov	bx,7727
GSGLET:
mov	es,word	ptr	ss:[0ED3]
mov	di,0002
cmp	word	ptr	es:[di],FF
je	GSMISSING
mov	word	ptr	ss:[9BE4],si
GSALP1:
mov	cl,byte	ptr	es:[di]
inc	di
mov	dx,di
xor	ch,ch
add	dx,cx
mov	si,word	ptr	ss:[9BE4]
mov	ch,cl
GSALP2:
lodsb
xlat
or	al,al
js	GSEND1
mov	cl,byte	ptr	es:[di]
inc	di
or	cl,cl
je	GSNEXT
dec	ch
cmp	al,cl
je	GSALP2
GSNEXT:
mov	di,dx
mov	cl,byte	ptr	es:[di]
xor	ch,ch
add	di,cx
cmp	word	ptr	es:[di],FF
jne	GSALP1
mov	ax,word	ptr	[0000]
or	ax,ax
je	GSMISSING
mov	di,0002
jmp	GSALP1
GSSAME:
mov	cx,dx
inc	cx
mov	dx,es
dec	si
pop	bx
pop	di
pop	es
ret
GSEND1:
or	ch,ch
je	GSSAME
jmp	GSNEXT
GSMISSING:
mov	cx,A46D
mov	dx,8AC9
GSMISLP:
lodsb
xlat
or	al,al
jns	GSMISLP
dec	si
pop	bx
pop	di
pop	es
ret
P_STRCPY:
lodsb
xlat
or	al,al
js	P_STRCPY
dec	si
call	GETSTRINGADDR
mov	word	ptr	ss:[9A7C],dx
mov	word	ptr	ss:[9A7E],cx
lodsb
cmp	al,2C
je	7424
jmp	EAERR
call	GETSTRINGADDR
push	es
push	di
push	ds
push	si
mov	ds,dx
mov	si,cx
mov	es,word	ptr	ss:[9A7C]
mov	di,word	ptr	ss:[9A7E]
STRCPYLP:
lodsb
stosb
or	al,al
jne	STRCPYLP
pop	si
pop	ds
pop	di
pop	es
ret
P_T:
and	ah,DF
cmp	ah,41
je	P_TA
cmp	ah,43
je	P_TC
cmp	ah,44
je	P_TD
cmp	ah,52
je	P_TR
cmp	ah,53
jne	7463
jmp	P_TS
cmp	ah,58
jne	746B
jmp	P_TX
cmp	ah,59
jne	7473
jmp	P_TY
cmp	ah,49
je	P_TI
jmp	PM
P_TI:
lodsb
and	al,DF
cmp	al,4D
je	7485
jmp	PM
lodsb
and	al,DF
cmp	al,45
je	748F
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_TA
jmp	P_TIME
P_TA:
lodsb
and	al,DF
cmp	al,58
jne	74A4
jmp	P_TAX
cmp	al,59
jne	74AB
jmp	P_TAY
jmp	PM
P_TC:
lodsb
and	al,DF
cmp	al,44
jne	74B8
jmp	P_TCD
cmp	al,53
jne	74BF
jmp	P_TCS
jmp	PM
P_TD:
lodsb
and	al,DF
cmp	al,43
je	74CC
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_TR
jmp	P_TDC
P_TR:
lodsb
and	al,DF
cmp	al,42
je	74E1
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_TS
jmp	P_TRB
P_TS:
lodsb
and	al,DF
cmp	al,42
jne	74F6
jmp	P_TSB
cmp	al,43
jne	74FD
jmp	P_TSC
cmp	al,58
jne	7504
jmp	P_TSX
jmp	PM
P_TX:
lodsb
and	al,DF
cmp	al,41
jne	7511
jmp	P_TXA
cmp	al,59
jne	7518
jmp	P_TXY
cmp	al,53
jne	751F
jmp	P_TXS
jmp	PM
P_TY:
lodsb
and	al,DF
cmp	al,41
jne	752C
jmp	P_TYA
cmp	al,58
jne	7533
jmp	P_TYX
cmp	al,50
je	P_TYP
jmp	PM
P_TYP:
lodsb
and	al,DF
cmp	al,45
je	7544
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_U
jmp	P_TYPE
P_U:
and	ah,DF
cmp	ah,50
je	755A
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,4550
je	7566
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	7570
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_W
jmp	P_UPPER
P_W:
and	ah,DF
cmp	ah,41
je	P_WA
cmp	ah,52
je	758B
jmp	PM
lodsw
and	ax,DFDF
cmp	ax,5449
je	7597
jmp	PM
lodsb
and	al,DF
cmp	al,45
je	75A1
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_WA
jmp	P_WRITE
P_WA:
mov	al,byte	ptr	[si]
and	al,DF
cmp	al,49
jne	75B7
jmp	P_WAI
jmp	PM
P_X:
and	ah,DF
cmp	ah,42
je	P_XB
cmp	ah,43
je	P_XC
jmp	PM
P_XB:
lodsb
and	al,DF
cmp	al,41
je	75D4
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	P_XC
jmp	P_XBA
P_XC:
lodsb
and	al,DF
cmp	al,45
je	75E9
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	BADVAL
jmp	P_XCE
BADVAL:
push	dx
mov	dx,7EFE
call	ERROR_ROUT
pop	dx
GETEA:
xor	cl,cl
mov	al,byte	ptr	[si]
xlat
or	al,al
js	GTAB
cmp	al,2E
je	GOK
pop	ax
jmp	PM
GOK:
lodsw
mov	bp,word	ptr	ss:[13F0]
and	ah,DF
cmp	ah,4C
je	GLONG
cmp	ah,57
je	GWORD
cmp	ah,4E
je	GTAB
cmp	ah,44
je	762E
jmp	DOTERR
inc	cl
mov	word	ptr	ss:[0AAE],bp
jmp	GTAB
GWORD:
inc	cl
mov	word	ptr	ss:[0AB2],bp
mov	word	ptr	ss:[0AB4],bp
jmp	GTAB
GLONG:
inc	cl
mov	word	ptr	ss:[0AB6],bp
GTAB:
lodsb
xlat
or	al,al
js	GTAB
dec	si
lodsb
xor	ah,ah
mov	bp,ax
add	bp,bp
jmp	word	ptr	[bp+7307]
EAACC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	766A
jmp	EAEXP
mov	bp,0002
ret
EAIMM:
or	cl,cl
je	7675
jmp	A_LA_GILES
call	CONVEXPRESS
mov	bp,word	ptr	ss:[13F0]
cmp	bp,word	ptr	ss:[0AB2]
jne	7687
jmp	EAIMMW
or	ch,ch
je	EAIMMOK
cmp	ch,FF
je	EAIMMOK
jmp	EAIMMERR
EAIMMOK:
mov	byte	ptr	es:[di+01],cl
mov	bp,0004
test	byte	ptr	ss:[0ACE],C0
je	7718
test	byte	ptr	ss:[0ACE],40
jne	76D5
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	76D1
call	MOREFR
pop	bp
pop	es
jmp	7718
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7714
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAIMMW:
cmp	dx,FF
je	EAIMMW2
or	dx,dx
je	EAIMMW2
jmp	EAIMMERR1
EAIMMW2:
mov	word	ptr	es:[di+01],cx
mov	bp,002C
test	byte	ptr	ss:[0ACE],C0
je	77AA
test	byte	ptr	ss:[0ACE],40
jne	7767
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7763
call	MOREFR
pop	bp
pop	es
jmp	77AA
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	77A6
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAEXP:
dec	si
call	CONVEXPRESS
or	dx,dx
jns	77B6
jmp	EAEXPERR
mov	bp,word	ptr	ss:[13F0]
cmp	bp,word	ptr	ss:[0AB6]
jne	77C5
jmp	EAEXPL
cmp	bp,word	ptr	ss:[0AAE]
jne	77CF
jmp	EAZP
test	byte	ptr	ss:[0ACE],C0
jne	.FR
cmp	word	ptr	ss:[0AB8],bp
je	EAJMP
cmp	byte	ptr	[si],2C
jne	77E6
jmp	IFSUNBAL
cmp	bp,word	ptr	ss:[0AB4]
je	FORCEABSW
cmp	cx,00FF
ja	FORCEABSW
jmp	EAZPABS
FORCEABSW:
mov	word	ptr	es:[di+01],cx
mov	bp,0006
ret
EAJMP:
cmp	dl,byte	ptr	ss:[0F92]
je	7808
jmp	EAJMPERR
cmp	byte	ptr	[si],2C
jne	7810
jmp	IFSUNBAL
cmp	bp,word	ptr	ss:[0AB4]
jne	781A
jmp	EAERR
mov	word	ptr	es:[di+01],cx
mov	bp,0006
ret
.FR:
cmp	byte	ptr	[si],2C
jne	782A
jmp	EAINDEXFR
test	byte	ptr	ss:[0ACE],C0
jne	7835
jmp	7901
test	byte	ptr	ss:[0ACE],40
jne	7883
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AB8]
je	7860
mov	word	ptr	es:[bp+02],0002
jmp	786E
mov	word	ptr	es:[bp+02],0006
mov	al,byte	ptr	[0F92]
mov	byte	ptr	es:[bp+0A],al
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	787F
call	MOREFR
pop	bp
pop	es
jmp	7901
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AB8]
je	78BE
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
jmp	78EC
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],06
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	78FD
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
xor	ax,ax
mov	word	ptr	es:[di+01],ax
mov	bp,0006
ret
EAEXPL:
cmp	byte	ptr	[si],2C
jne	7913
jmp	EAEXPLX
mov	word	ptr	es:[di+01],cx
mov	byte	ptr	es:[di+03],dl
test	byte	ptr	ss:[0ACE],C0
je	7999
test	byte	ptr	ss:[0ACE],40
jne	7956
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0004
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7952
call	MOREFR
pop	bp
pop	es
jmp	7999
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],04
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7995
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	bp,0022
ret
EAEXPLX:
inc	si
lodsb
and	al,DF
cmp	al,58
je	79A8
jmp	E_EAEXPLXERR
mov	word	ptr	es:[di+01],cx
mov	byte	ptr	es:[di+03],dl
test	byte	ptr	ss:[0ACE],C0
je	7A2E
test	byte	ptr	ss:[0ACE],40
jne	79EB
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0004
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	79E7
call	MOREFR
pop	bp
pop	es
jmp	7A2E
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],04
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7A2A
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	bp,0024
ret
E_EAEXPLXERR:
mov	bp,0000
ret
EAZP:
cmp	byte	ptr	[si],2C
jne	EAZPABS
jmp	EAZPINDEX
EAZPABS:
cmp	cx,00FF
jbe	7A47
jmp	EAZPTOOBIG
mov	byte	ptr	es:[di+01],cl
mov	bp,000C
test	byte	ptr	ss:[0ACE],C0
je	7ACC
test	byte	ptr	ss:[0ACE],40
jne	7A89
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7A85
call	MOREFR
pop	bp
pop	es
jmp	7ACC
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7AC8
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAZPINDEX:
inc	si
lodsb
and	al,DF
cmp	al,58
je	EAZPINDEXX
cmp	al,59
jne	7ADC
jmp	EAZPINDEXY
cmp	al,53
jne	7AE3
jmp	EAZPINDEXS
mov	bp,0000
ret
EAZPINDEXX:
mov	byte	ptr	es:[di+01],cl
mov	bp,0012
test	byte	ptr	ss:[0ACE],C0
je	7B6C
test	byte	ptr	ss:[0ACE],40
jne	7B29
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7B25
call	MOREFR
pop	bp
pop	es
jmp	7B6C
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7B68
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAZPINDEXY:
mov	byte	ptr	es:[di+01],cl
mov	bp,0014
test	byte	ptr	ss:[0ACE],C0
je	7BF2
test	byte	ptr	ss:[0ACE],40
jne	7BAF
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7BAB
call	MOREFR
pop	bp
pop	es
jmp	7BF2
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7BEE
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAZPINDEXS:
cmp	cx,00FF
jle	7BFC
jmp	EATOOBIGB
INVSRCNAMETXT:
pop	es
mov	byte	ptr	es:[di+01],cl
mov	bp,001E
test	byte	ptr	ss:[0ACE],C0
je	7C81
test	byte	ptr	ss:[0ACE],40
jne	7C3E
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7C3A
call	MOREFR
pop	bp
pop	es
jmp	7C81
push	es
CANTALLOC:
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
REPTUNBAL:
mov	word	ptr	[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7C7D
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAINDEX:
IFSUNBAL:
inc	si
lodsb
and	al,DF
cmp	al,58
je	EAINDEXX
cmp	al,59
je	EAINDEXY
cmp	al,53
jne	7C95
jmp	EAZPINDEXS
mov	bp,0000
ret
EAINDEXX:
mov	bp,word	ptr	ss:[13F0]
cmp	bp,word	ptr	ss:[0AB4]
je	FORCEABSX
cmp	cx,00FF
ja	FORCEABSX
CTRLC_HIT:
jmp	EAZPINDEXX
FORCEABSX:
mov	word	ptr	es:[di+01],cx
mov	bp,000E
ret
EAINDEXY:
mov	bp,word	ptr	ss:[13F0]
cmp	bp,word	ptr	ss:[0AB4]
je	FORCEABSY
cmp	cx,00FF
ja	FORCEABSY
jmp	EAZPINDEXY
ENDCSUNBAL:
????
FORCEABSY:
mov	word	ptr	es:[di+01],cx
mov	bp,0010
ret
EAINDEXFR:
inc	si
lodsb
and	al,DF
cmp	al,58
je	EAINDEXXFR
cmp	al,59
jne	7CE2
jmp	EAINDEXYFR
cmp	al,53
jne	7CE9
jmp	EAZPINDEXS
mov	bp,0000
ret
EAINDEXXFR:
test	byte	ptr	ss:[0ACE],C0
jne	7CF8
NESTEDERR:
jmp	7DC4
test	byte	ptr	ss:[0ACE],40
jne	7D46
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AB8]
je	7D23
mov	word	ptr	es:[bp+02],0002
jmp	7D31
mov	word	ptr	es:[bp+02],0006
mov	al,byte	ptr	[0F92]
mov	byte	ptr	es:[bp+0A],al
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7D42
call	MOREFR
pop	bp
pop	es
jmp	7DC4
NOSRCLEV:
jle	7D7D
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AB8]
je	7D81
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
MORELOCMEM:
add	ax,word	ptr	[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
jmp	7DAF
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
FAIL:
adc	si,word	ptr	[0E13]
mov	sp,2613
mov	word	ptr	[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],06
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7DC0
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
xor	ax,ax
mov	word	ptr	es:[di+01],ax
mov	bp,000E
ret
EAINDEXYFR:
test	byte	ptr	ss:[0ACE],C0
jne	7DD9
jmp	7EA5
test	byte	ptr	ss:[0ACE],40
jne	7E27
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AB8]
je	7E04
mov	word	ptr	es:[bp+02],0002
jmp	7E12
mov	word	ptr	es:[bp+02],0006
mov	al,byte	ptr	[0F92]
mov	byte	ptr	es:[bp+0A],al
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	7E23
call	MOREFR
pop	bp
pop	es
jmp	7EA5
mov	ax,word	ptr	[13F0]
cmp	ax,word	ptr	ss:[0AB8]
je	7E62
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
jmp	7E90
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],06
UNKBLK:
inc	si
add	al,06
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7EA1
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
xor	ax,ax
mov	word	ptr	es:[di+01],ax
mov	bp,0010
ret
EAIND:
dec	si
call	CONVEXPRESS
mov	al,byte	ptr	[si]
MAXERRORSTXT:
add	al,3C
sub	al,75
add	bp,cx
pop	word	ptr	[bx+si]
xlat
or	al,al
js	7EC5
jmp	EAERR
mov	word	ptr	es:[di+01],cx
MAPFILE_ERROR:
mov	word	ptr	[di+01],cx
mov	bp,0016
test	byte	ptr	ss:[0ACE],C0
je	7F4A
test	byte	ptr	ss:[0ACE],40
jne	7F07
INVTYPE:
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
BADVALUE:
jb	7F03
call	MOREFR
pop	bp
pop	es
jmp	7F4A
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
UNKNOWNINST:
test	al,13
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
BADSIZEB:
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
BADSIZEW:
add	ax,8936
test	al,13
cmp	bp,3F00
jb	PCTOOBIG
call	MOREEXT
PCTOOBIG:
pop	ax
pop	cx
pop	bp
pop	es
ret
INDCOMMA:
cmp	cx,00FF
jle	NEGADDR
jmp	EAINDABSX
NEGADDR:
mov	al,byte	ptr	[si+01]
and	al,DF
cmp	al,58
jne	7F60
jmp	EAINDINDEX
inc	si
lodsb
xlat
or	al,al
TOOBIGFORD:
jns	7F6B
jmp	EAERR
cmp	al,53
jne	7F72
jmp	EAINDSY
cmp	al,59
je	7F79
jmp	EAERR
mov	word	ptr	es:[di+01],cx
mov	bp,0018
NOSUCHEA:
add	byte	ptr	[06F6],dh
into
or	al,al
je	7FFE
test	byte	ptr	ss:[0ACE],40
jne	7FBB
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
SYMBOLTWICE:
mov	word	ptr	[0AC7],bp
cmp	bp,7F00
jb	7FB7
call	MOREFR
pop	bp
pop	es
jmp	7FFE
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
MACTWICE:
mov	es,word	ptr	[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
MACDEFEDTWICE:
mov	si,3613
adc	cx,word	ptr	[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	7FFA
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAINDABSX:
inc	si
lodsb
and	al,DF
cmp	al,58
je	BADSIZELWDN
jmp	EATOOBIGB
BADSIZELWDN:
lodsb
cmp	al,29
je	8012
jmp	EATOOBIGB
mov	bp,word	ptr	ss:[13F0]
cmp	word	ptr	ss:[0AB8],bp
je	8021
jmp	EAERR
mov	word	ptr	es:[di+01],cx
ABMISSING:
add	word	ptr	[di+001C],di
ret
EAINDINDEX:
cmp	byte	ptr	[si+02],29
je	8032
jmp	EAERR
add	si,03
mov	bp,word	ptr	ss:[13F0]
cmp	bp,word	ptr	ss:[0AB8]
jne	8044
jmp	EAINDIDXJ
mov	byte	ptr	es:[di+01],cl
mov	bp,001A
NOENDM:
test	byte	ptr	ss:[0ACE],C0
je	80C9
test	byte	ptr	ss:[0ACE],40
TOOMANYPARS:
jne	8086
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
BADPARM:
or	al,byte	ptr	[bx+di+00FD]
jg	80F0
add	bp,ax
jnp	801F
pop	bp
pop	es
jmp	80C9
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
PARNOTHERE:
test	al,13
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
REPIMM:
add	ah,byte	ptr	[46C6]
add	al,00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	80C5
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
ret
EAINDIDXJ:
mov	word	ptr	es:[di+01],cx
mov	bp,001C
test	byte	ptr	ss:[0ACE],C0
MUSTEVAL:
je	814F
test	byte	ptr	ss:[0ACE],40
jne	810C
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0014
add	bp,15
mov	word	ptr	ss:[0AC7],bp
CANTOPENFILE:
cmp	bp,7F00
jb	8108
call	MOREFR
pop	bp
pop	es
jmp	814F
push	es
push	bp
push	cx
push	ax
PREMEOF:
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],06
MISSINGSINGLE:
mov	byte	ptr	[bp+04],06
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	814B
call	MOREEXT
pop	ax
MISSINGDOUBLE:
pop	cx
pop	bp
pop	es
ret
EAINDSY:
lodsw
cmp	ax,2C29
je	8159
jmp	EAERR
lodsb
and	al,DF
cmp	al,59
je	8163
jmp	EAERR
MISSINGBOTH:
add	ah,byte	ptr	[4D88]
add	word	ptr	[06F6],si
into
or	al,al
je	81E5
test	byte	ptr	ss:[0ACE],40
jne	81A2
push	es
push	bp
TOOMANYENDCS:
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
BADREPTCOUNT:
add	al,byte	ptr	[bx+si]
add	byte	ptr	[bp+di+15C5],al
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	819E
TMREPTS:
add	bp,ax
pop	di
pushf
pop	bp
pop	es
jmp	81E5
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
TOOMANYENDRS:
adc	si,word	ptr	[2E8B]
test	al,13
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
TOOOLDREPT:
add	ax,word	ptr	[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
REPTFILEERR:
adc	ax,word	ptr	[bx+di+00FD]
aas
jb	81E1
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	bp,0020
ret
EADPIND:
call	CONVEXPRESS
or	dx,dx
jns	81F3
jmp	EAERR
cmp	byte	ptr	[si],2E
jne	EADPIND1
inc	si
lodsb
MUSTHAVELAB:
and	al,DF
cmp	al,57
je	EADPINDW
EADPIND1:
cmp	cx,00FF
ja	8209
jmp	EADPINDDP
or	dx,dx
je	EADPINDW
jmp	EADPINDERR
EADPINDW:
lodsb
cmp	al,5D
je	8218
jmp	EAERR
mov	word	ptr	es:[di+01],cx
test	byte	ptr	ss:[0ACE],C0
je	829A
test	byte	ptr	ss:[0ACE],40
jne	8257
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
NOTINMAC:
add	byte	ptr	[bp+di+15C5],al
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	8253
call	MOREFR
BADMVAL:
stosb
fwait
pop	bp
pop	es
jmp	829A
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
BADMREG:
test	al,13
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
BADSEP:
mov	sp,2613
mov	word	ptr	[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
OSBRACKET:
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
CSBRACKET:
jb	8296
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	bp,002A
MISSINGQUOTES:
ret
EADPINDDP:
lodsb
cmp	al,5D
je	82A6
jmp	EAERR
mov	al,byte	ptr	[si]
cmp	al,2C
jne	82AF
jmp	EADPINDY
test	byte	ptr	ss:[0ACE],C0
OUTMACSPACE:
je	832D
test	byte	ptr	ss:[0ACE],40
jne	82EA
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
SPURENDM:
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	82E6
call	MOREFR
pop	bp
INCCOLINFO:
pop	es
jmp	832D
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	8329
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	byte	ptr	es:[di+01],cl
mov	bp,0026
ret
EADPINDY:
inc	si
lodsb
and	al,DF
cmp	al,59
je	8340
jmp	EAERR
test	byte	ptr	ss:[0ACE],C0
je	83BE
test	byte	ptr	ss:[0ACE],40
jne	837B
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	8377
call	MOREFR
pop	bp
pop	es
jmp	83BE
push	es
push	bp
push	cx
ILLFIRST:
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
GILESSPEC:
adc	sp,word	ptr	[4689]
add	byte	ptr	[4E89],ah
add	ah,byte	ptr	[46C6]
add	al,00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	83BA
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	byte	ptr	es:[di+01],cl
mov	bp,0028
UNKOPT:
ret
EAJMPERR:
push	dx
mov	dx,85DD
call	ERROR_ROUT
pop	dx
xor	bp,bp
ret
EATOOBIGB:
xor	bp,bp
push	dx
mov	dx,7F28
MISSINGEXP:
sub	byte	ptr	[bx+E8],bh
xchg	si,ax
popf
pop	dx
EAERR:
xor	bp,bp
push	dx
mov	dx,7F7F
call	ERROR_ROUT
pop	dx
EAMISSEXP:
xor	bp,bp
push	dx
mov	dx,83D5
ILLEGALBASE:
aad
call	ERROR_ROUT
pop	dx
EADPINDERR:
xor	bp,bp
push	dx
mov	dx,7F37
call	ERROR_ROUT
pop	dx
EAZPTOOBIG:
xor	bp,bp
push	dx
mov	dx,7F66
call	ERROR_ROUT
pop	dx
EAIMMERR1:
xor	bp,bp
ILLEGALOP:
push	dx
mov	dx,7F37
call	ERROR_ROUT
pop	dx
EAIMMERR:
xor	bp,bp
push	dx
mov	dx,7F28
call	ERROR_ROUT
pop	dx
EAEXPERR:
xor	bp,bp
push	dx
mov	dx,7F54
call	ERROR_ROUT
pop	dx
A_LA_GILES:
xor	bp,bp
push	dx
mov	dx,839B
UNBALBRAC:
fwait
sub	ax,46
popf
pop	dx
ADDSYMBOL:
cmp	byte	ptr	[si],2E
je	8433
jmp	ADDPARENT
push	bx
push	es
push	di
push	ds
mov	es,word	ptr	ss:[0F6C]
TOOBIGSHIFT:
insb
????
mov	di,word	ptr	[0F6E]
mov	word	ptr	ss:[9A88],es
mov	word	ptr	ss:[9A8A],di
mov	bx,79A9
NUMTOOBIG:
xor	ah,ah
mov	cx,si
lodsb
xlat
stosb
mov	dx,ax
add	dx,dx
L_SYMLOOP:
lodsb
xlat
or	al,al
js	L_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
DIVZERO:
sar	byte	ptr	[bx+si+4F],AA
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	L_ENDSYMHASH
stosb
MODLOW:
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	L_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	L_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	L_ENDSYMHASH
stosb
add	dx,ax
NULLSTR:
rol	byte	ptr	[bp+di],1
shr	byte	ptr	[si+D736],cl
or	al,al
js	L_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	L_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
jmp	L_SYMLOOP
L_ENDSYMHASH:
xor	al,al
stosb
and	dx,0FFD
NOTINREPT:
????
mov	word	ptr	[0F6E],di
push	si
sub	si,cx
mov	cx,si
pop	si
dec	si
mov	ax,ss
mov	ds,ax
mov	bp,1472
ENDOFIRP:
jb	84EA
add	bp,dx
L_FIND:
mov	ax,word	ptr	ds:[bp+00]
or	ax,ax
je	L_HASHOK
mov	bp,word	ptr	ds:[bp+02]
mov	ds,ax
cmp	cl,byte	ptr	ds:[bp+05]
jne	L_FIND
mov	dx,word	ptr	ss:[0F82]
cmp	dx,word	ptr	ds:[bp+10]
jne	L_FIND
mov	dx,word	ptr	ss:[0F80]
cmp	dx,word	ptr	ds:[bp+0E]
jne	L_FIND
push	ds
push	si
mov	dl,cl
mov	es,word	ptr	ds:[bp+06]
mov	di,word	ptr	ds:[bp+08]
mov	ds,word	ptr	ss:[9A88]
mov	si,word	ptr	ss:[9A8A]
L_TEST:
lodsb
cmp	al,byte	ptr	es:[di]
jne	L_SYMBOLSNOTSAME
inc	di
dec	dl
jne	L_TEST
pop	si
pop	ds
jmp	L_SYM2
L_SYMBOLSNOTSAME:
pop	si
pop	ds
jmp	L_FIND
L_HASHOK:
mov	es,word	ptr	ss:[0F76]
mov	di,word	ptr	ss:[0F78]
NOINCMEM:
????
mov	word	ptr	[bp+00],es
mov	word	ptr	ds:[bp+02],di
pop	ds
xor	ax,ax
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],ax
mov	byte	ptr	es:[di+05],cl
mov	ax,word	ptr	[9A88]
mov	word	ptr	es:[di+06],ax
PUBNOLOCALS:
push	es
mov	ax,word	ptr	[9A8A]
mov	word	ptr	es:[di+08],ax
mov	byte	ptr	es:[di+04],09
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[di+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[di+0C],ax
mov	ax,word	ptr	[0F80]
EXTNOLOCALS:
mov	tr1,ecx
inc	bp
push	cs
mov	ax,word	ptr	[0F82]
mov	word	ptr	es:[di+10],ax
mov	word	ptr	ss:[0F7C],es
mov	word	ptr	ss:[0F7E],di
add	di,12
mov	word	ptr	ss:[0F78],di
cmp	di,6D52
ILLEGALEXTUSE:
push	dx
insw
jb	859C
call	MORESYM
mov	di,word	ptr	ss:[0F6E]
cmp	di,66E7
jb	85B0
mov	dx,7D69
INVALIDIRS:
jge	8593
jcxz	8549
jmp	STOPASSEM
mov	bp,word	ptr	ss:[13F0]
mov	word	ptr	ss:[0F7A],bp
add	word	ptr	ss:[13CA],01
adc	word	ptr	ss:[13C8],00
LMSODD:
adc	ax,word	ptr	[bx+si]
pop	di
pop	es
pop	bx
ret
L_SYM2:
mov	bx,word	ptr	ss:[9A8A]
mov	word	ptr	ss:[0F6E],bx
mov	al,byte	ptr	ds:[bp+04]
test	al,04
je	L_NOTSET
mov	bx,word	ptr	ss:[13F0]
DIFFBANK:
mov	bx,word	ptr	[13F0]
mov	word	ptr	ss:[0F7A],bx
mov	word	ptr	ss:[0F7C],ds
mov	word	ptr	ss:[0F7E],bp
pop	ds
pop	di
pop	es
pop	bx
ret
L_NOTSET:
test	al,10
je	L_NOTFR
mov	bx,word	ptr	ss:[13F0]
EXTRACHARS:
mov	bx,word	ptr	[13F0]
mov	word	ptr	ss:[0F7A],bx
mov	byte	ptr	ds:[bp+04],09
mov	ax,word	ptr	[0F92]
mov	word	ptr	ds:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	ds:[bp+0C],ax
mov	word	ptr	ss:[0F7C],ds
INVALIDDBR:
jl	862C
mov	word	ptr	ss:[0F7E],bp
add	word	ptr	ss:[13CA],01
adc	word	ptr	ss:[13C8],00
pop	ds
pop	di
PUBISEXTERN:
pop	es
pop	bx
ret
L_NOTFR:
or	byte	ptr	ss:[0F8B],01
pop	ds
pop	di
pop	es
pop	bx
ret
ADDPARENT:
push	bx
push	es
push	di
push	ds
mov	ax,word	ptr	[0F80]
mov	word	ptr	[0F84],ax
mov	ax,word	ptr	[0F82]
EXTERNISPUB:
????
mov	word	ptr	[0F86],ax
mov	ax,word	ptr	[0F6E]
mov	word	ptr	[0F70],ax
mov	es,word	ptr	ss:[0F72]
mov	di,word	ptr	ss:[0F74]
mov	word	ptr	ss:[0F80],es
mov	word	ptr	ss:[0F82],di
mov	bx,79A9
xor	ah,ah
mov	cx,si
lodsb
xlat
stosb
mov	dx,ax
add	dx,dx
_SYMLOOP:
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	_ENDSYMHASH
INVARRAY:
stosb
add	dx,ax
add	dx,dx
jmp	_SYMLOOP
_ENDSYMHASH:
xor	al,al
stosb
and	dx,0FFD
mov	word	ptr	ss:[0F74],di
STR2LONG:
mov	word	ptr	[0F74],di
push	si
sub	si,cx
mov	cx,si
pop	si
dec	si
mov	ax,ss
mov	ds,ax
mov	bp,1472
add	bp,dx
_FIND:
mov	ax,word	ptr	ds:[bp+00]
or	ax,ax
je	_HASHOK
NOSTRINGDEF:
cmp	ax,8B3E
outsb
add	cl,byte	ptr	[bp+3ED8]
cmp	cl,byte	ptr	[bp+05]
jne	_FIND
test	byte	ptr	ds:[bp+04],01
je	_FIND
push	ds
push	si
mov	dl,cl
mov	es,word	ptr	ds:[bp+06]
NOSUCHENV:
mov	di,word	ptr	ds:[bp+08]
mov	ds,word	ptr	ss:[0F80]
mov	si,word	ptr	ss:[0F82]
_TEST:
lodsb
cmp	al,byte	ptr	es:[di]
jne	_SYMBOLSNOTSAME
inc	di
dec	dl
jne	_TEST
pop	si
pop	ds
jmp	_SYM2
_SYMBOLSNOTSAME:
pop	si
pop	ds
BADFILENAME:
jmp	_FIND
_HASHOK:
mov	es,word	ptr	ss:[0F76]
mov	di,word	ptr	ss:[0F78]
mov	word	ptr	ds:[bp+00],es
mov	word	ptr	ds:[bp+02],di
pop	ds
xor	ax,ax
mov	word	ptr	es:[di],ax
mov	word	ptr	es:[di+02],ax
mov	byte	ptr	es:[di+05],cl
mov	ax,word	ptr	[0F80]
mov	word	ptr	es:[di+06],ax
mov	ax,word	ptr	[0F82]
mov	word	ptr	es:[di+08],ax
mov	byte	ptr	es:[di+04],01
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[di+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[di+0C],ax
mov	word	ptr	ss:[0F7C],es
BADRADIX:
push	es
jl	8799
mov	word	ptr	ss:[0F7E],di
add	di,0E
mov	word	ptr	ss:[0F78],di
cmp	di,6D52
jb	87A0
call	MORESYM
mov	di,word	ptr	ss:[0F74]
cmp	di,3F80
jb	87AE
call	MORESYMTX
mov	bp,word	ptr	ss:[13F0]
BADHEX:
lock
adc	si,word	ptr	[2E89]
jp	87C7
mov	ax,word	ptr	[0F6E]
mov	word	ptr	[0F70],ax
mov	word	ptr	ss:[0F6E],26E7
add	word	ptr	ss:[13CA],01
adc	word	ptr	ss:[13C8],00
BADSTRVAL:
add	byte	ptr	[bx+07],bl
pop	bx
ret
_SYM2:
mov	bx,word	ptr	ss:[0F82]
mov	word	ptr	ss:[0F74],bx
mov	al,byte	ptr	ds:[bp+04]
BADPFSPEC:
mov	al,byte	ptr	[bp+04]
test	al,04
je	_NOTSET
mov	bx,word	ptr	ss:[13F0]
mov	word	ptr	ss:[0F7A],bx
mov	word	ptr	ss:[0F7C],ds
mov	word	ptr	ss:[0F7E],bp
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
PRINTFNOVAL:
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
mov	word	ptr	[0F6E],ax
pop	ds
pop	di
pop	es
pop	bx
ret
_NOTSET:
test	al,10
je	CANTFINDFR
test	byte	ptr	ss:[A49C],01
je	_NOT_FREF2EXT
mov	word	ptr	ss:[0F7C],ds
BADFIELD:
mov	word	ptr	[0F7C],ds
mov	word	ptr	ss:[0F7E],bp
pop	ds
pop	di
pop	es
pop	bx
ret
_NOT_FREF2EXT:
mov	bx,word	ptr	ss:[13F0]
mov	word	ptr	ss:[0F7A],bx
mov	al,byte	ptr	ds:[bp+04]
and	al,80
or	al,01
mov	byte	ptr	ds:[bp+04],al
mov	ax,word	ptr	[0F92]
mov	word	ptr	ds:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	ds:[bp+0C],ax
mov	ax,word	ptr	ds:[bp+06]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	ds:[bp+08]
mov	word	ptr	[0F82],ax
mov	word	ptr	ss:[0F7C],ds
mov	word	ptr	ss:[0F7E],bp
add	word	ptr	ss:[13CA],01
adc	word	ptr	ss:[13C8],00
pop	ds
pop	di
pop	es
pop	bx
ret
_NOTFR:
CANTFINDFR:
mov	ax,word	ptr	[0F84]
mov	word	ptr	[0F80],ax
mov	ax,word	ptr	[0F86]
mov	word	ptr	[0F82],ax
mov	ax,word	ptr	[0F70]
PUBLICNOTDEF:
????
mov	word	ptr	[0F6E],ax
or	byte	ptr	ss:[0F8B],01
pop	ds
pop	di
pop	es
pop	bx
ret
GETMACRO:
push	ds
push	bx
push	di
push	es
push	si
push	ds
mov	bx,7A29
xor	ah,ah
xor	cx,cx
lodsb
inc	cx
xlat
mov	dx,ax
add	dx,dx
MG_SYMLOOP:
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
EXTNOTDEF:
pop	bx
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
lodsb
xlat
or	al,al
js	MG_ENDSYMHASH
add	dx,ax
add	dx,dx
inc	cx
jmp	MG_SYMLOOP
MG_ENDSYMHASH:
inc	cx
and	dx,0FFD
mov	ax,ss
mov	ds,ax
mov	bp,1472
add	bp,dx
MG_NEXT:
mov	ax,word	ptr	ds:[bp+00]
or	ax,ax
je	MG_NOTTHERE
mov	bp,word	ptr	ds:[bp+02]
mov	ds,ax
cmp	cl,byte	ptr	ds:[bp+05]
jne	MG_NEXT
test	byte	ptr	ds:[bp+04],02
je	MG_NEXT
mov	es,word	ptr	ds:[bp+06]
mov	di,word	ptr	ds:[bp+08]
mov	word	ptr	ss:[020A],es
mov	word	ptr	ss:[020C],di
mov	dx,ds
pop	ds
pop	si
mov	word	ptr	ss:[9A80],cx
dec	cx
push	si
MG_LOOP:
lodsb
xlat
cmp	al,byte	ptr	es:[di]
jne	MG_NOTSAME
inc	di
dec	cx
jne	MG_LOOP
mov	cx,word	ptr	ss:[9A80]
pop	ax
pop	es
pop	di
pop	bx
pop	ds
ret
MG_NOTSAME:
push	ds
mov	ds,dx
mov	cx,word	ptr	ss:[9A80]
jmp	MG_NEXT
MG_NOTTHERE:
mov	si,word	ptr	ss:[13F0]
mov	word	ptr	ss:[0AAC],si
pop	ds
pop	si
pop	es
pop	di
pop	bx
pop	ds
ret
ADDMACRO:
push	bx
push	es
push	di
push	ds
mov	es,word	ptr	ss:[0F72]
mov	di,word	ptr	ss:[0F74]
mov	word	ptr	ss:[9A7C],es
mov	word	ptr	ss:[9A7E],di
mov	bx,79A9
xor	ah,ah
mov	cx,si
lodsb
xlat
stosb
mov	dx,ax
add	dx,dx
M_SYMLOOP:
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
QUOTETXT:
rol	byte	ptr	[bp+di],1
shr	byte	ptr	[si+D736],cl
LINKSTRTMES:
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
lodsb
xlat
or	al,al
js	M_ENDSYMHASH
stosb
add	dx,ax
add	dx,dx
jmp	M_SYMLOOP
M_ENDSYMHASH:
xor	al,al
stosb
and	dx,0FFD
mov	word	ptr	ss:[0F74],di
cmp	di,3F80
jb	8A36
call	MORESYMTX
push	si
sub	si,cx
mov	cx,si
pop	si
dec	si
mov	ax,ss
mov	ds,ax
mov	bp,1472
add	bp,dx
M_FIND:
mov	ax,word	ptr	ds:[bp+00]
or	ax,ax
je	M_SYMOK
mov	bp,word	ptr	ds:[bp+02]
mov	ds,ax
cmp	cl,byte	ptr	ds:[bp+05]
jne	M_FIND
test	byte	ptr	ds:[bp+04],02
je	M_FIND
push	ds
push	si
push	cx
mov	es,word	ptr	ds:[bp+06]
mov	di,word	ptr	ds:[bp+08]
mov	ds,word	ptr	ss:[9A7C]
mov	si,word	ptr	ss:[9A7E]
M_TEST:
lodsb
cmp	al,byte	ptr	es:[di]
jne	M_SYMBOLSNOTSAME
inc	di
dec	cx
jne	M_TEST
pop	cx
pop	si
pop	ds
pop	ds
pop	di
pop	es
pop	bx
push	dx
mov	dx,7FC0
call	ERROR_ROUT
pop	dx
M_SYMBOLSNOTSAME:
pop	cx
pop	si
pop	ds
jmp	M_FIND
M_SYMOK:
mov	es,word	ptr	ss:[0F76]
mov	di,word	ptr	ss:[0F78]
mov	word	ptr	ds:[bp+00],es
mov	word	ptr	ds:[bp+02],di
pop	ds
mov	bp,di
xor	ax,ax
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],ax
mov	byte	ptr	es:[bp+04],02
mov	byte	ptr	es:[bp+05],cl
mov	ax,word	ptr	[9A7C]
mov	word	ptr	es:[bp+06],ax
mov	ax,word	ptr	[9A7E]
mov	word	ptr	es:[bp+08],ax
mov	ax,word	ptr	[0AA2]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0AA4]
mov	word	ptr	es:[bp+0C],ax
add	di,0E
mov	word	ptr	ss:[0F78],di
cmp	di,6D52
jb	8AED
call	MORESYM
pop	di
pop	es
pop	bx
ret
CALCFIELD:
mov	cl,byte	ptr	ss:[2480]
or	cl,cl
je	ENDFIELD
sub	cl,byte	ptr	ss:[2485]
js	ENDFIELD
FIELDLP:
mov	dx,2555
call	far	ptr	_OS2PRTSTRING
dec	cl
jne	FIELDLP
ENDFIELD:
ret
PRTDECW:
push	di
push	es
push	ds
push	ss
pop	es
push	cx
push	dx
mov	di,8A6E
call	BIN2DECW
push	ss
pop	ds
call	CALCFIELD
push	bx
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A6E
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
pop	bx
pop	dx
pop	cx
pop	ds
pop	es
pop	di
ret
BIN2DECW:
push	ax
push	bx
push	cx
push	di
mov	byte	ptr	ss:[2485],00
cmp	cx,270F
ja	BIN10000
cmp	cx,03E7
ja	BIN1000
cmp	cx,63
ja	BIN100
cmp	cx,09
ja	BIN10
jmp	BIN1
BIN10000:
mov	al,FF
mov	bx,2710
BINDIGIT1:
inc	al
sub	cx,bx
jae	BINDIGIT1
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
BIN1000:
mov	al,FF
mov	bx,03E8
BINDIGIT2:
inc	al
sub	cx,bx
jae	BINDIGIT2
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
BIN100:
mov	al,FF
mov	bx,0064
BINDIGIT3:
inc	al
sub	cx,bx
jae	BINDIGIT3
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
BIN10:
mov	al,FF
mov	bl,0A
BINDIGIT4:
inc	al
sub	cl,bl
jae	BINDIGIT4
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cl,bl
BIN1:
mov	al,cl
add	al,30
stosb
inc	byte	ptr	ss:[2485]
mov	al,24
stosb
mov	word	ptr	ss:[2488],di
pop	di
pop	cx
pop	bx
pop	ax
ret
BIN2HEXL:
push	dx
push	cx
push	ax
mov	word	ptr	ss:[9A78],dx
mov	word	ptr	ss:[9A7A],cx
mov	al,byte	ptr	[9A79]
call	BIN2HEXB
mov	al,byte	ptr	[9A78]
call	BIN2HEXB
mov	al,byte	ptr	[9A7B]
call	BIN2HEXB
mov	al,byte	ptr	[9A7A]
call	BIN2HEXB
pop	ax
pop	cx
pop	dx
ret
BIN2HEXB:
push	ax
shr	al,1
shr	al,1
shr	al,1
shr	al,1
add	al,30
cmp	al,39
jle	BHOK2
add	al,07
BHOK2:
stosb
pop	ax
and	al,0F
add	al,30
cmp	al,39
jle	BHOK1
add	al,07
BHOK1:
stosb
ret
PRTDECL:
push	di
push	es
push	ds
push	ss
pop	es
push	cx
push	dx
mov	di,8A6E
call	BIN2DECL
push	ss
pop	ds
call	CALCFIELD
push	bx
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A6E
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
pop	bx
pop	dx
pop	cx
pop	ds
pop	es
pop	di
ret
BIN2DECL:
push	ax
push	bx
push	cx
push	dx
push	di
push	bp
mov	byte	ptr	ss:[2485],00
cmp	dx,00
js	B2DLBS
B2DLBS1:
cmp	dx,3B9A
jbe	8C56
jmp	BINL1000000000
je	BINL1000000000A
cmp	dx,05F5
jbe	8C61
jmp	BINL100000000
je	BINL100000000A
cmp	dx,0098
jbe	8C6C
jmp	BINL10000000
je	BINL10000000A
cmp	dx,0F
jbe	8C76
jmp	BINL1000000
je	BINL1000000A
cmp	dx,01
jbe	8C80
jmp	BINL100000
je	BINL100000A
cmp	cx,270F
jbe	8C8B
jmp	BINL10000
cmp	cx,03E7
jbe	8C94
jmp	BINL1000
cmp	cx,63
jbe	8C9C
jmp	BINL100
cmp	cx,09
jbe	8CA4
jmp	BINL10
jmp	BINL1
B2DLBS:
not	cx
not	dx
add	cx,01
adc	dx,00
mov	al,2D
stosb
inc	byte	ptr	ss:[2485]
jmp	B2DLBS1
BINL1000000000A:
cmp	cx,CA00
jb	BINL100000000
jmp	BINL1000000000
BINL100000000A:
cmp	cx,E100
jb	BINL10000000
jmp	BINL100000000
BINL10000000A:
cmp	cx,9680
jb	BINL1000000
jmp	BINL10000000
BINL1000000A:
cmp	cx,4240
jb	BINL100000
jmp	BINL1000000
BINL100000A:
cmp	cx,86A0
jae	8CE4
jmp	BINL10000
jmp	BINL100000
BINL1000000000:
mov	al,FF
mov	bx,CA00
mov	bp,3B9A
BINLDIGIT1:
inc	al
sub	cx,bx
sbb	dx,bp
jae	BINLDIGIT1
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
adc	dx,bp
BINL100000000:
HELPTXT:
mov	al,FF
mov	bx,E100
mov	bp,05F5
BINLDIGIT2:
inc	al
sub	cx,bx
sbb	dx,bp
jae	BINLDIGIT2
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
adc	dx,bp
BINL10000000:
mov	al,FF
mov	bx,9680
mov	bp,0098
BINLDIGIT3:
inc	al
sub	cx,bx
sbb	dx,bp
jae	BINLDIGIT3
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
adc	dx,bp
BINL1000000:
mov	al,FF
mov	bx,4240
mov	bp,000F
BINLDIGIT4:
inc	al
sub	cx,bx
sbb	dx,bp
jae	BINLDIGIT4
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
adc	dx,bp
BINL100000:
mov	al,FF
mov	bx,86A0
mov	bp,0001
BINLDIGIT5:
inc	al
sub	cx,bx
sbb	dx,bp
jae	BINLDIGIT5
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
adc	dx,bp
BINL10000:
mov	al,FF
mov	bx,2710
BINDIGIT1B:
inc	al
sub	cx,bx
sbb	dx,00
jae	BINDIGIT1B
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
BINL1000:
mov	al,FF
mov	bx,03E8
BINDIGIT2B:
inc	al
sub	cx,bx
jae	BINDIGIT2B
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
BINL100:
mov	al,FF
mov	bx,0064
BINDIGIT3B:
inc	al
sub	cx,bx
jae	BINDIGIT3B
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cx,bx
BINL10:
mov	al,FF
mov	bl,0A
BINDIGIT4B:
inc	al
sub	cl,bl
jae	BINDIGIT4B
add	al,30
stosb
inc	byte	ptr	ss:[2485]
add	cl,bl
BINL1:
mov	al,cl
add	al,30
stosb
inc	byte	ptr	ss:[2485]
mov	al,24
stosb
mov	word	ptr	ss:[2488],di
pop	bp
pop	di
pop	dx
pop	cx
pop	bx
pop	ax
ret
PRTHEXB:
push	ax
and	al,0F
add	al,30
cmp	al,39
jle	OK1
add	al,07
OK1:
mov	byte	ptr	[8A6F],al
pop	ax
shr	al,1
shr	al,1
shr	al,1
shr	al,1
add	al,30
cmp	al,39
jle	OK2
add	al,07
OK2:
mov	byte	ptr	[8A6E],al
mov	byte	ptr	ss:[8A70],24
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8A6E
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
ret
PRTHEXL:
push	di
push	es
push	ds
push	si
mov	word	ptr	ss:[9A78],dx
mov	word	ptr	ss:[9A7A],cx
mov	al,byte	ptr	[9A79]
call	PRTHEXB
mov	al,byte	ptr	[9A78]
call	PRTHEXB
mov	al,byte	ptr	[9A7B]
call	PRTHEXB
mov	al,byte	ptr	[9A7A]
call	PRTHEXB
pop	si
pop	ds
pop	es
pop	di
ret
PARSECLI:
mov	ds,word	ptr	ss:[9BDE]
mov	si,word	ptr	ss:[9BE0]
lodsb
or	al,al
jne	OP_LP
jmp	OP_ERROR
OP_LP:
lodsb
cmp	al,20
je	OP_LP
cmp	al,09
je	OP_LP
cmp	al,2D
je	OPTION
cmp	al,2F
je	OPTION
cmp	al,00
je	OP_RET
cmp	al,0D
je	OP_RET
mov	ax,ss
mov	es,ax
mov	di,925C
mov	word	ptr	ss:[9A90],es
mov	word	ptr	ss:[9A92],di
call	COPYNAME
mov	byte	ptr	es:[di+FF],0D
mov	byte	ptr	es:[di],0A
mov	byte	ptr	ss:[0EE6],00
jmp	OP_LP
OP_RET:
cmp	byte	ptr	ss:[925C],00
je	OP_ERROR
ret
OPTION:
lodsb
and	al,DF
cmp	al,46
jne	8EAF
jmp	OP_FILELIST
cmp	al,4F
jne	8EB6
jmp	OP_OBJECT
cmp	al,45
jne	8EBD
jmp	OP_EQUATE
cmp	al,53
jne	8EC4
jmp	OP_SET
cmp	al,44
jne	8ECB
jmp	OP_DEFS
cmp	al,58
je	OP_SYMBOLS
cmp	al,4C
je	OP_LIST
cmp	al,49
je	OP_INCDIR
cmp	al,56
jne	8EDE
jmp	OP_LINK
cmp	al,4D
je	OP_ERRORS
cmp	al,5A
jne	8EE9
jmp	OP_MAPFILE
cmp	al,50
jne	OP_ERROR
jmp	OP_PUT
OP_ERROR:
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,8D02
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
jmp	OVERRET
OP_INCDIR:
inc	si
mov	ax,ss
mov	es,ax
mov	di,0EE6
call	COPYNAME
jmp	OP_LP
OP_ERRORS:
call	CONVEXPRESS
mov	word	ptr	ss:[13FD],cx
jmp	OP_LP
OP_LIST:
or	byte	ptr	ss:[0F8B],04
jmp	OP_LP
OP_SYMBOLS:
lodsb
cmp	al,20
je	OP_ERROR
cmp	al,09
je	OP_ERROR
mov	ax,ss
mov	es,ax
mov	di,9B5C
mov	word	ptr	ss:[13F9],es
mov	word	ptr	ss:[13FB],di
call	COPYNAME
mov	byte	ptr	ss:[13F8],01
jmp	OP_LP
OP_FILELIST:
lodsb
cmp	al,20
je	OP_ERROR
cmp	al,09
je	OP_ERROR
mov	byte	ptr	ss:[13F5],01
mov	ax,ss
mov	es,ax
mov	di,9A9C
call	COPYNAME
push	ds
mov	ax,ss
mov	ds,ax
mov	dx,9A9C
xor	cx,cx
call	far	ptr	_OS2OPENNEWFILE
pop	ds
jae	8F7A
jmp	OP_OPER
mov	word	ptr	[13F6],ax
jmp	OP_LP
OP_EQUATE:
mov	bx,76A7
call	ADDSYMBOL
cmp	byte	ptr	[si],3D
je	8F8F
jmp	OP_LP
inc	si
call	CONVEXPRESS
mov	es,word	ptr	ss:[0F7C]
mov	di,word	ptr	ss:[0F7E]
mov	word	ptr	es:[di+0A],dx
mov	word	ptr	es:[di+0C],cx
jmp	OP_LP
OP_SET:
mov	bx,76A7
call	ADDSYMBOL
cmp	byte	ptr	[si],3D
je	8FB6
jmp	OP_LP
inc	si
call	CONVEXPRESS
mov	es,word	ptr	ss:[0F7C]
mov	di,word	ptr	ss:[0F7E]
mov	word	ptr	es:[di+0A],dx
mov	word	ptr	es:[di+0C],cx
mov	byte	ptr	es:[di+04],05
jmp	OP_LP
OP_DEFS:
jmp	OP_LP
OP_PUT:
lodsb
cmp	al,20
jne	8FDF
jmp	OP_ERROR
cmp	al,09
jne	8FE6
jmp	OP_ERROR
mov	byte	ptr	ss:[13F2],01
mov	ax,ss
mov	es,ax
mov	di,9B9C
call	COPYNAME
push	ds
mov	ax,ss
mov	ds,ax
mov	dx,9B9C
xor	cx,cx
call	far	ptr	_OS2OPENNEWFILE
pop	ds
jb	OP_OPER
mov	word	ptr	[13F3],ax
jmp	OP_LP
OP_OBJECT:
lodsb
cmp	al,20
jne	9017
jmp	OP_ERROR
cmp	al,09
jne	901E
jmp	OP_ERROR
mov	ax,ss
mov	es,ax
mov	di,9ADC
mov	word	ptr	ss:[249C],es
mov	word	ptr	ss:[249E],di
call	COPYNAME
mov	byte	ptr	ss:[2498],01
jmp	OP_LP
OP_LINK:
lodsb
cmp	al,20
jne	9043
jmp	OP_ERROR
cmp	al,09
jne	904A
jmp	OP_ERROR
mov	ax,ss
mov	es,ax
mov	di,9B1C
call	COPYNAME
mov	byte	ptr	ss:[13A0],01
jmp	OP_LP
OP_MAPFILE:
mov	byte	ptr	ss:[9BE8],01
jmp	OP_LP
OP_OPER:
push	ds
push	dx
DEFAULTSRC:
mov	dx,8AC9
mov	ds,dx
mov	dx,89C4
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
jmp	OVERRET
COPYNAME:
dec	si
mov	bx,7929
CNLOOP:
lodsb
stosb
xlat
or	al,al
jns	CNLOOP
mov	byte	ptr	es:[di+FF],00
dec	si
ret
REGNERR1:
pop	ax
REGNERR:
push	dx
mov	dx,8251
call	ERROR_ROUT
pop	dx
ret
GREGERR:
push	dx
mov	dx,8262
call	ERROR_ROUT
pop	dx
ret
PARSEMARIO:
mov	dx,si
lodsb
mov	bp,ax
and	bp,00FF
add	bp,bp
jmp	word	ptr	[bp+6821]
M_MORE:
mov	dx,si
lodsb
mov	bp,ax
and	bp,00FF
add	bp,bp
jmp	word	ptr	[bp+6821]
ret
M_GOTEOL:
dec	si
ret
M_A:
lodsw
and	ax,DFDF
cmp	ax,4444
jne	90CD
jmp	M_ADD
cmp	ax,4344
jne	90D5
jmp	M_ADC
cmp	ax,444E
jne	90DD
jmp	M_AND
cmp	ax,5253
jne	90E5
jmp	M_ASR
jmp	PM
M_B:
lodsw
and	ax,DFDF
cmp	ax,4152
jne	90F4
jmp	M_BRA
cmp	ax,4547
jne	90FC
jmp	M_BGE
cmp	ax,544C
jne	9104
jmp	M_BLT
cmp	ax,454E
jne	910C
jmp	M_BNE
cmp	ax,5145
jne	9114
jmp	M_BEQ
cmp	ax,4C50
jne	911C
jmp	M_BPL
cmp	ax,494D
jne	9124
jmp	M_BMI
cmp	ax,4343
jne	912C
jmp	M_BCC
cmp	ax,5343
jne	9134
jmp	M_BCS
cmp	ax,4356
jne	913C
jmp	M_BVC
cmp	ax,5356
jne	9144
jmp	M_BVS
cmp	ax,4349
jne	914C
jmp	M_BIC
jmp	PM
M_C:
lodsw
and	ax,DFDF
cmp	ax,4341
jne	915B
jmp	M_CAC
cmp	ax,4C4F
jne	9163
jmp	M_COL
cmp	ax,4F4D
jne	916B
jmp	M_CMO
cmp	ax,504D
jne	9173
jmp	M_CMP
cmp	ax,4F4C
je	M_CLO
dec	si
cmp	al,48
jne	9180
jmp	P_CH
jmp	PM
M_CLO:
lodsb
and	al,DF
cmp	al,53
je	918D
jmp	PM
lodsb
and	al,DF
cmp	al,45
je	9197
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	M_D
jmp	P_FCLOSE
M_D:
lodsw
and	ax,DFDF
cmp	ax,5649
jne	91AE
jmp	M_DIV
cmp	ax,4345
jne	91B6
jmp	M_DEC
cmp	ax,4645
je	M_DEF
dec	si
cmp	al,42
jne	91C3
jmp	P_DB
cmp	al,57
jne	91CA
jmp	P_DW
cmp	al,53
jne	91D1
jmp	P_DS
cmp	al,45
jne	91D8
jmp	P_DE
jmp	PM
M_DEF:
lodsb
and	al,DF
cmp	al,53
je	91E5
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	M_E
jmp	M_DEFS
M_E:
lodsw
and	ax,DFDF
cmp	ax,5551
jne	91FC
jmp	M_EQU
cmp	ax,444E
jne	9204
jmp	M_END
cmp	ax,534C
jne	920C
jmp	P_ELS
cmp	ax,5458
je	M_EXT
jmp	PM
M_EXT:
lodsw
and	ax,DFDF
cmp	ax,5245
je	M_EXTER
jmp	PM
M_EXTER:
lodsb
and	al,DF
cmp	al,4E
je	922A
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	M_F
jmp	M_EXTERN
M_F:
lodsw
and	ax,DFDF
cmp	ax,554D
jne	9241
jmp	M_FMU
cmp	ax,4F52
jne	9249
jmp	M_FRO
cmp	ax,504F
je	M_FOP
cmp	ax,4C43
je	M_FCL
jmp	PM
M_FOP:
lodsw
and	ax,DFDF
cmp	ax,4E45
DEFNAME:
dec	si
jne	9262
jmp	P_FOPEN
jmp	PM
M_FCL:
lodsw
and	ax,DFDF
cmp	ax,534F
je	M_FCLOS
jmp	PM
M_FCLOS:
lodsb
and	al,DF
cmp	al,45
je	927B
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	M_G
jmp	FCLOSELP
M_G:
lodsw
and	ax,DFDF
cmp	ax,5445
jne	9292
jmp	M_GET
jmp	PM
M_H:
lodsw
and	ax,DFDF
cmp	ax,4249
jne	92A1
jmp	M_HIB
jmp	PM
M_I:
lodsw
and	ax,DFDF
cmp	ax,5442
jne	92B0
jmp	M_IBT
cmp	ax,434E
je	M_INC2
cmp	ax,5457
jne	92BD
jmp	M_IWT
cmp	ax,5352
jne	92C5
jmp	M_IRS
cmp	ax,5052
jne	92CD
jmp	M_IRP
cmp	al,46
je	92D4
jmp	PM
dec	si
jmp	P_IF
M_INC2:
lodsb
and	al,DF
cmp	al,4C
jne	92E2
jmp	P_INCL
cmp	al,42
jne	92E9
jmp	P_INCB
cmp	al,43
jne	92F0
jmp	P_INCC
cmp	al,44
jne	92F7
jmp	P_INCD
dec	si
jmp	M_INC
M_J:
lodsw
and	ax,DFDF
cmp	ax,504D
jne	9307
jmp	M_JMP
jmp	PM
M_L:
lodsw
and	ax,DFDF
cmp	ax,5253
jne	9316
jmp	M_LSR
cmp	ax,4E49
jne	931E
jmp	M_LINK
cmp	ax,424F
jne	9326
jmp	M_LOB
cmp	ax,554D
jne	932E
jmp	M_LMU
cmp	ax,4244
jne	9336
jmp	M_LDB
cmp	ax,5744
jne	933E
jmp	M_LDW
cmp	ax,4D4A
jne	9346
jmp	M_LJM
cmp	ax,534D
jne	934E
jmp	M_LMS
cmp	ax,4F4F
jne	9356
jmp	M_LOO
cmp	ax,4145
jne	935E
jmp	M_LEA
cmp	ax,434F
je	M_LOC
cmp	ax,5349
jne	936B
jmp	M_LIS
cmp	al,4D
jne	9372
jmp	M_LM
jmp	PM
M_LOC:
lodsb
and	al,DF
cmp	al,41
je	937F
jmp	PM
lodsb
and	al,DF
cmp	al,4C
je	9389
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
jns	M_M
jmp	P_LOCAL
M_M:
lodsw
and	ax,DFDF
cmp	ax,564F
jne	93A0
jmp	M_MOV
cmp	ax,5245
jne	93A8
jmp	M_MER
cmp	ax,4C55
jne	93B0
jmp	M_MUL
cmp	ax,5241
jne	93B8
jmp	M_MAR
cmp	ax,4341
jne	93C0
jmp	M_MAC
jmp	PM
M_N:
lodsw
and	ax,DFDF
cmp	ax,504F
jne	93CF
jmp	M_NOP
cmp	ax,544F
jne	93D7
jmp	M_NOT
jmp	PM
M_O:
lodsb
and	al,DF
cmp	al,52
jne	93E4
jmp	M_OR
jmp	PM
M_P:
lodsw
and	ax,DFDF
cmp	ax,4F4C
jne	93F3
jmp	M_PLO
cmp	ax,4952
je	M_PRI
jmp	PM
M_PRI:
lodsw
and	ax,DFDF
cmp	ax,544E
je	M_PRINT
jmp	PM
M_PRINT:
lodsb
and	al,DF
cmp	al,46
jne	9411
jmp	P_PRINTF
jmp	PM
M_R:
lodsw
and	ax,DFDF
cmp	ax,4C4F
jne	9420
jmp	M_ROL
cmp	ax,4950
jne	9428
jmp	M_RPI
cmp	ax,524F
jne	9430
jmp	M_ROR
cmp	ax,4D41
jne	9438
jmp	M_RAM
cmp	ax,4D4F
jne	9440
jmp	M_ROM
cmp	ax,5045
jne	9448
jmp	M_REP
cmp	ax,4E55
jne	9450
jmp	M_RUN
jmp	PM
M_S:
lodsw
and	ax,DFDF
cmp	ax,4F54
jne	945F
jmp	M_STO
cmp	ax,4157
jne	9467
jmp	M_SWA
cmp	ax,4B42
jne	946F
jmp	M_SBK
cmp	ax,5845
jne	9477
jmp	M_SEX
cmp	ax,5754
jne	947F
jmp	M_STW
cmp	ax,4254
jne	9487
jmp	M_STB
cmp	ax,4255
jne	948F
jmp	M_SUB
cmp	ax,4342
jne	9497
jmp	M_SBC
cmp	ax,534D
jne	949F
jmp	M_SMS
cmp	ax,4349
jne	94A7
jmp	P_SIC
cmp	al,4D
jne	94AE
jmp	M_SM
jmp	PM
M_T:
lodsb
and	al,DF
cmp	al,4F
jne	94BB
jmp	M_TO
cmp	al,49
jne	94C2
jmp	P_TI
jmp	PM
M_U:
lodsw
and	ax,DFDF
cmp	ax,554D
jne	94D1
jmp	M_UMU
jmp	PM
M_W:
lodsw
and	ax,DFDF
cmp	ax,5449
jne	94E0
jmp	M_WIT
jmp	PM
M_X:
lodsw
and	ax,DFDF
cmp	ax,524F
jne	94EF
jmp	M_XOR
jmp	PM
M_ADC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	94FD
jmp	PM
lodsb
xlat
or	al,al
js	94FD
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	9512
inc	cl
jmp	9509
xlat
or	al,al
jns	9509
mov	si,bp
cmp	cl,02
jne	M_ADCCONT
jmp	M_ADC3
M_ADCCONT:
lodsb
xlat
or	al,al
js	M_ADCCONT
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	9594
lodsb
and	al,DF
cmp	al,52
jne	954A
lodsb
sub	al,30
js	9549
cmp	al,09
jg	9549
cmp	al,01
je	9567
mov	cl,al
jmp	9580
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	9580
jmp	GREGERR
cmp	ah,05
jg	9548
add	ah,0A
mov	cl,ah
jmp	9580
lodsb
cmp	al,5D
je	957D
cmp	al,2C
je	957D
mov	ah,al
sub	ah,30
jns	955B
xlat
or	al,al
jns	9548
mov	cl,01
dec	si
add	cl,50
mov	al,byte	ptr	[si]
xlat
or	al,al
js	958E
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	95A0
jmp	REGNERR
cmp	cx,0F
jle	95A8
jmp	REGNERR
add	cl,50
test	byte	ptr	ss:[0ACE],C0
je	9629
test	byte	ptr	ss:[0ACE],40
jne	95E6
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	95E2
call	MOREFR
pop	bp
pop	es
jmp	9629
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	9625
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9634
jmp	PM
mov	al,3F
mov	ah,cl
stosw
ret
M_ADC3:
lodsb
and	al,DF
cmp	al,52
jne	9654
lodsb
sub	al,30
js	9653
cmp	al,09
jg	9653
cmp	al,01
je	9671
mov	cl,al
jmp	9686
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	9686
jmp	GREGERR
cmp	ah,05
jg	9652
add	ah,0A
mov	cl,ah
jmp	9686
lodsb
cmp	al,2C
je	9683
mov	ah,al
sub	ah,30
jns	9665
xlat
or	al,al
jns	9652
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	9693
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	96AD
lodsb
sub	al,30
js	96AC
cmp	al,09
jg	96AC
cmp	al,01
je	96CA
mov	cl,al
jmp	96DF
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	96DF
jmp	GREGERR
cmp	ah,05
jg	96AB
add	ah,0A
mov	cl,ah
jmp	96DF
lodsb
cmp	al,2C
je	96DC
mov	ah,al
sub	ah,30
jns	96BE
xlat
or	al,al
jns	96AB
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	96EC
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_ADCCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
M_ADD:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9708
jmp	PM
lodsb
xlat
or	al,al
js	9708
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	971D
inc	cl
jmp	9714
xlat
or	al,al
jns	9714
mov	si,bp
cmp	cl,02
jne	M_ADDCONT
jmp	M_ADD3
M_ADDCONT:
lodsb
xlat
or	al,al
js	M_ADDCONT
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	979D
lodsb
and	al,DF
cmp	al,52
jne	9755
lodsb
sub	al,30
js	9754
cmp	al,09
jg	9754
cmp	al,01
je	9772
mov	cl,al
jmp	978B
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	978B
jmp	GREGERR
cmp	ah,05
jg	9753
add	ah,0A
mov	cl,ah
jmp	978B
lodsb
cmp	al,5D
je	9788
cmp	al,2C
je	9788
mov	ah,al
sub	ah,30
jns	9766
xlat
or	al,al
jns	9753
mov	cl,01
dec	si
add	cl,50
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9799
jmp	PM
mov	al,cl
stosb
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	97A9
jmp	REGNERR
cmp	cx,0F
jle	97B1
jmp	REGNERR
add	cl,50
test	byte	ptr	ss:[0ACE],C0
je	9832
test	byte	ptr	ss:[0ACE],40
jne	97EF
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	97EB
call	MOREFR
pop	bp
pop	es
jmp	9832
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	982E
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	983D
jmp	PM
mov	al,3E
mov	ah,cl
stosw
ret
M_ADD3:
lodsb
and	al,DF
cmp	al,52
jne	985D
lodsb
sub	al,30
js	985C
cmp	al,09
jg	985C
cmp	al,01
je	987A
mov	cl,al
jmp	988F
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	988F
jmp	GREGERR
cmp	ah,05
jg	985B
add	ah,0A
mov	cl,ah
jmp	988F
lodsb
cmp	al,2C
je	988C
mov	ah,al
sub	ah,30
jns	986E
xlat
or	al,al
jns	985B
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	989C
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	98B6
lodsb
sub	al,30
js	98B5
cmp	al,09
jg	98B5
cmp	al,01
je	98D3
mov	cl,al
jmp	98E8
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	98E8
jmp	GREGERR
cmp	ah,05
jg	98B4
add	ah,0A
mov	cl,ah
jmp	98E8
lodsb
cmp	al,2C
je	98E5
mov	ah,al
sub	ah,30
jns	98C7
xlat
or	al,al
jns	98B4
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	98F5
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_ADDCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
M_AND:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9911
jmp	PM
lodsb
xlat
or	al,al
js	9911
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	9926
inc	cl
jmp	991D
xlat
or	al,al
jns	991D
mov	si,bp
cmp	cl,02
jne	M_ANDCONT
jmp	M_AND3
M_ANDCONT:
lodsb
xlat
or	al,al
js	M_ANDCONT
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	99AE
lodsb
and	al,DF
cmp	al,52
jne	995E
lodsb
sub	al,30
js	995D
cmp	al,09
jg	995D
cmp	al,01
je	997B
mov	cl,al
jmp	9994
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	9994
jmp	GREGERR
cmp	ah,05
jg	995C
add	ah,0A
mov	cl,ah
jmp	9994
lodsb
cmp	al,5D
je	9991
cmp	al,2C
je	9991
mov	ah,al
sub	ah,30
jns	996F
xlat
or	al,al
jns	995C
mov	cl,01
dec	si
cmp	cl,00
jne	999C
jmp	GREGERR
add	cl,70
mov	al,byte	ptr	[si]
xlat
or	al,al
js	99AA
jmp	PM
mov	al,cl
stosb
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	99BA
jmp	REGNERR
cmp	cx,0F
jle	99C2
jmp	REGNERR
cmp	cl,00
jne	99CA
jmp	REGNERR
add	cl,70
test	byte	ptr	ss:[0ACE],C0
je	9A4B
test	byte	ptr	ss:[0ACE],40
jne	9A08
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9A04
call	MOREFR
pop	bp
pop	es
jmp	9A4B
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	9A47
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9A56
jmp	PM
mov	al,3E
mov	ah,cl
stosw
ret
M_AND3:
lodsb
and	al,DF
cmp	al,52
jne	9A76
lodsb
sub	al,30
js	9A75
cmp	al,09
jg	9A75
cmp	al,01
je	9A93
mov	cl,al
jmp	9AA8
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	9AA8
jmp	GREGERR
cmp	ah,05
jg	9A74
add	ah,0A
mov	cl,ah
jmp	9AA8
lodsb
cmp	al,2C
je	9AA5
mov	ah,al
sub	ah,30
jns	9A87
xlat
or	al,al
jns	9A74
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	9AB5
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	9ACF
lodsb
sub	al,30
js	9ACE
cmp	al,09
jg	9ACE
cmp	al,01
je	9AEC
mov	cl,al
jmp	9B01
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	9B01
jmp	GREGERR
cmp	ah,05
jg	9ACD
add	ah,0A
mov	cl,ah
jmp	9B01
lodsb
cmp	al,2C
je	9AFE
mov	ah,al
sub	ah,30
jns	9AE0
xlat
or	al,al
jns	9ACD
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	9B0E
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_ANDCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
M_ASR:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9B2A
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9B35
jmp	PM
mov	al,96
stosb
ret
M_BIC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9B44
jmp	PM
lodsb
xlat
or	al,al
js	9B44
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	9BBE
lodsb
and	al,DF
cmp	al,52
jne	9B6C
lodsb
sub	al,30
js	9B6B
cmp	al,09
jg	9B6B
cmp	al,01
je	9B89
mov	cl,al
jmp	9BA2
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	9BA2
jmp	GREGERR
cmp	ah,05
jg	9B6A
add	ah,0A
mov	cl,ah
jmp	9BA2
lodsb
cmp	al,5D
je	9B9F
cmp	al,2C
je	9B9F
mov	ah,al
sub	ah,30
jns	9B7D
xlat
or	al,al
jns	9B6A
mov	cl,01
dec	si
cmp	cl,00
jne	9BAA
jmp	GREGERR
add	cl,70
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9BB8
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	9BCA
jmp	REGNERR
cmp	cx,0F
jle	9BD2
jmp	REGNERR
cmp	cl,00
jne	9BDA
jmp	REGNERR
add	cl,70
test	byte	ptr	ss:[0ACE],C0
je	9C5B
test	byte	ptr	ss:[0ACE],40
jne	9C18
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9C14
call	MOREFR
pop	bp
pop	es
jmp	9C5B
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	9C57
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	9C66
jmp	PM
mov	al,3F
mov	ah,cl
stosw
ret
M_BRA:
lodsb
xlat
or	al,al
js	M_BRA
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	9CC6
test	byte	ptr	ss:[0ACE],40
jne	9CF2
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9CBE
call	MOREFR
pop	bp
pop	es
mov	al,05
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	9CD2
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	9CE2
jmp	BCCERR
cmp	cx,7F
jle	9CEA
jmp	BCCERR
mov	ah,cl
mov	al,05
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BGE:
lodsb
xlat
or	al,al
js	M_BGE
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	9D55
test	byte	ptr	ss:[0ACE],40
jne	9D81
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9D4D
call	MOREFR
pop	bp
pop	es
mov	al,06
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	9D61
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	9D71
jmp	BCCERR
cmp	cx,7F
jle	9D79
jmp	BCCERR
mov	ah,cl
mov	al,06
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BLT:
lodsb
xlat
or	al,al
js	M_BLT
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	9DE4
test	byte	ptr	ss:[0ACE],40
jne	9E10
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9DDC
call	MOREFR
pop	bp
pop	es
mov	al,07
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	9DF0
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	9E00
jmp	BCCERR
cmp	cx,7F
jle	9E08
jmp	BCCERR
mov	ah,cl
mov	al,07
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BNE:
lodsb
xlat
or	al,al
js	M_BNE
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	9E73
test	byte	ptr	ss:[0ACE],40
jne	9E9F
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9E6B
call	MOREFR
pop	bp
pop	es
mov	al,08
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	9E7F
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	9E8F
jmp	BCCERR
cmp	cx,7F
jle	9E97
jmp	BCCERR
mov	ah,cl
mov	al,08
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BEQ:
lodsb
xlat
or	al,al
js	M_BEQ
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	9F02
test	byte	ptr	ss:[0ACE],40
jne	9F2E
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9EFA
call	MOREFR
pop	bp
pop	es
mov	al,09
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	9F0E
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	9F1E
jmp	BCCERR
cmp	cx,7F
jle	9F26
jmp	BCCERR
mov	ah,cl
mov	al,09
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BPL:
lodsb
xlat
or	al,al
js	M_BPL
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	9F91
test	byte	ptr	ss:[0ACE],40
jne	9FBD
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	9F89
call	MOREFR
pop	bp
pop	es
mov	al,0A
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	9F9D
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	9FAD
jmp	BCCERR
cmp	cx,7F
jle	9FB5
jmp	BCCERR
mov	ah,cl
mov	al,0A
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BMI:
lodsb
xlat
or	al,al
js	M_BMI
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	A020
test	byte	ptr	ss:[0ACE],40
jne	A04C
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A018
call	MOREFR
pop	bp
pop	es
mov	al,0B
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	A02C
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	A03C
jmp	BCCERR
cmp	cx,7F
jle	A044
jmp	BCCERR
mov	ah,cl
mov	al,0B
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BCC:
lodsb
xlat
or	al,al
js	M_BCC
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	A0AF
test	byte	ptr	ss:[0ACE],40
jne	A0DB
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A0A7
call	MOREFR
pop	bp
pop	es
mov	al,0C
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	A0BB
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	A0CB
jmp	BCCERR
cmp	cx,7F
jle	A0D3
jmp	BCCERR
mov	ah,cl
mov	al,0C
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BCS:
lodsb
xlat
or	al,al
js	M_BCS
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	A13E
test	byte	ptr	ss:[0ACE],40
jne	A16A
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A136
call	MOREFR
pop	bp
pop	es
mov	al,0D
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	A14A
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	A15A
jmp	BCCERR
cmp	cx,7F
jle	A162
jmp	BCCERR
mov	ah,cl
mov	al,0D
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BVC:
lodsb
xlat
or	al,al
js	M_BVC
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	A1CD
test	byte	ptr	ss:[0ACE],40
jne	A1F9
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A1C5
call	MOREFR
pop	bp
pop	es
mov	al,0E
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	A1D9
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	A1E9
jmp	BCCERR
cmp	cx,7F
jle	A1F1
jmp	BCCERR
mov	ah,cl
mov	al,0E
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_BVS:
lodsb
xlat
or	al,al
js	M_BVS
dec	si
call	CONVEXPRESS
test	byte	ptr	ss:[0ACE],C0
je	A25C
test	byte	ptr	ss:[0ACE],40
jne	A288
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	ax,word	ptr	[0F92]
mov	word	ptr	es:[bp+0A],ax
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[bp+0C],ax
mov	word	ptr	es:[bp+02],0008
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A254
call	MOREFR
pop	bp
pop	es
mov	al,0F
xor	ah,ah
stosw
ret
mov	bp,bx
sub	dx,word	ptr	ss:[0F92]
je	A268
jmp	BCCERR
sub	cx,word	ptr	ss:[0F94]
sub	cx,02
cmp	cx,80
jge	A278
jmp	BCCERR
cmp	cx,7F
jle	A280
jmp	BCCERR
mov	ah,cl
mov	al,0F
stosw
mov	bx,bp
ret
push	dx
mov	dx,8595
call	ERROR_ROUT
pop	dx
ret
M_CAC:
lodsw
and	ax,DFDF
cmp	ax,4548
je	A29D
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A2A8
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A2B3
jmp	PM
mov	al,02
stosb
ret
M_COL:
lodsw
and	ax,DFDF
cmp	ax,554F
je	A2C3
jmp	PM
lodsb
and	al,DF
cmp	al,52
je	A2CD
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A2D8
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A2E3
jmp	PM
mov	al,4E
stosb
ret
M_CMO:
lodsw
and	ax,DFDF
cmp	ax,4544
je	A2F3
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A2FE
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A309
jmp	PM
mov	al,3D
mov	ah,4E
stosw
ret
M_CMP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A31A
jmp	PM
lodsb
xlat
or	al,al
js	A31A
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A33C
lodsb
sub	al,30
js	A33B
cmp	al,09
jg	A33B
cmp	al,01
je	A359
mov	cl,al
jmp	A372
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A372
jmp	GREGERR
cmp	ah,05
jg	A33A
add	ah,0A
mov	cl,ah
jmp	A372
lodsb
cmp	al,5D
je	A370
cmp	al,2C
je	A36F
mov	ah,al
sub	ah,30
jns	A34D
xlat
or	al,al
jns	A33A
dec	si
mov	cl,01
add	cl,60
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A380
jmp	PM
mov	al,3F
mov	ah,cl
stosw
ret
M_DEC:
lodsb
xlat
or	al,al
js	M_DEC
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A3A8
lodsb
sub	al,30
js	A3A7
cmp	al,09
jg	A3A7
cmp	al,01
je	A3C5
mov	cl,al
jmp	A3DE
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A3DE
jmp	GREGERR
cmp	ah,04
jg	A3A6
add	ah,0A
mov	cl,ah
jmp	A3DE
lodsb
cmp	al,5D
je	A3DB
cmp	al,2C
je	A3DB
mov	ah,al
sub	ah,30
jns	A3B9
xlat
or	al,al
jns	A3A6
mov	cl,01
dec	si
add	cl,E0
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A3EC
jmp	PM
mov	al,cl
stosb
ret
M_DIV:
lodsb
cmp	al,32
je	A3F8
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A403
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A40E
jmp	PM
mov	al,3D
mov	ah,96
stosw
ret
M_FMU:
lodsw
and	ax,DFDF
cmp	ax,544C
je	A420
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A42B
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A436
jmp	PM
mov	al,9F
stosb
ret
M_FRO:
lodsb
and	al,DF
cmp	al,4D
je	A444
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A44F
jmp	PM
lodsb
xlat
or	al,al
js	A44F
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A471
lodsb
sub	al,30
js	A470
cmp	al,09
jg	A470
cmp	al,01
je	A48E
mov	cl,al
jmp	A4A7
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A4A7
jmp	GREGERR
cmp	ah,05
jg	A46F
add	ah,0A
mov	cl,ah
jmp	A4A7
lodsb
cmp	al,5D
je	A4A5
cmp	al,2C
je	A4A4
mov	ah,al
sub	ah,30
jns	A482
xlat
or	al,al
jns	A46F
dec	si
mov	cl,01
add	cl,B0
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A4B5
jmp	PM
mov	al,cl
stosb
ret
M_GET:
lodsb
and	al,DF
cmp	al,43
je	M_GETC
cmp	al,42
je	M_GETB
jmp	PM
M_GETC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A4D2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A4DD
jmp	PM
mov	al,DF
stosb
ret
M_GETB:
lodsb
xlat
or	al,al
js	M_GETBWS
cmp	al,48
je	M_GETBH
cmp	al,4C
je	M_GETBL
cmp	al,53
je	M_GETBS
jmp	PM
M_GETBWS:
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A503
jmp	PM
mov	al,EF
stosb
ret
M_GETBH:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A512
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A51D
jmp	PM
mov	al,3D
mov	ah,EF
stosw
ret
M_GETBL:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A52E
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A539
jmp	PM
mov	al,3E
mov	ah,EF
stosw
ret
M_GETBS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A54A
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A555
jmp	PM
mov	al,3F
mov	ah,EF
stosw
ret
M_HIB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A566
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A571
jmp	PM
mov	al,C0
stosb
ret
M_IBT:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A580
jmp	PM
lodsb
xlat
or	al,al
js	A580
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A5A2
lodsb
sub	al,30
js	A5A1
cmp	al,09
jg	A5A1
cmp	al,01
je	A5BF
mov	cl,al
jmp	A5D8
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A5D8
jmp	GREGERR
cmp	ah,05
jg	A5A0
add	ah,0A
mov	cl,ah
jmp	A5D8
lodsb
cmp	al,5D
je	A5D6
cmp	al,2C
je	A5D5
mov	ah,al
sub	ah,30
jns	A5B3
xlat
or	al,al
jns	A5A0
dec	si
mov	cl,01
add	cl,A0
push	cx
lodsw
cmp	al,2C
je	A5E4
jmp	IBTERR
cmp	ah,23
je	A5EC
jmp	REGNERR1
call	CONVEXPRESS
pop	dx
cmp	cx,80
jge	A5F8
jmp	REGNERR
cmp	cx,7F
jle	A600
jmp	REGNERR
test	byte	ptr	ss:[0ACE],C0
je	A67E
test	byte	ptr	ss:[0ACE],40
jne	A63B
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A637
call	MOREFR
pop	bp
pop	es
jmp	A67E
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	A67A
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A689
jmp	PM
mov	al,dl
mov	ah,cl
stosw
ret
IBTERR:
dec	si
pop	cx
push	dx
mov	dx,8276
call	ERROR_ROUT
pop	dx
ret
M_IWT:
lodsb
xlat
or	al,al
js	M_IWT
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A6BC
lodsb
sub	al,30
js	A6BB
cmp	al,09
jg	A6BB
cmp	al,01
je	A6D9
mov	cl,al
jmp	A6F2
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A6F2
jmp	GREGERR
cmp	ah,05
jg	A6BA
add	ah,0A
mov	cl,ah
jmp	A6F2
lodsb
cmp	al,5D
je	A6F0
cmp	al,2C
je	A6EF
mov	ah,al
sub	ah,30
jns	A6CD
xlat
or	al,al
jns	A6BA
dec	si
mov	cl,01
add	cl,F0
push	cx
lodsw
cmp	al,2C
jne	IBTERR
cmp	ah,23
je	A703
jmp	REGNERR1
call	CONVEXPRESS
or	dx,dx
je	A70D
jmp	M_IWT2
pop	dx
test	byte	ptr	ss:[0ACE],C0
je	A78C
test	byte	ptr	ss:[0ACE],40
jne	A749
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	A745
call	MOREFR
pop	bp
pop	es
jmp	A78C
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	A788
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A797
jmp	PM
mov	al,dl
stosb
mov	ax,cx
stosw
ret
M_IWT2:
cmp	dx,FF
pop	dx
je	A7A7
jmp	REGNERR
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A7B2
jmp	PM
mov	al,dl
stosb
mov	ax,cx
stosw
ret
M_INC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A7C4
jmp	PM
lodsb
xlat
or	al,al
js	A7C4
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A7E6
lodsb
sub	al,30
js	A7E5
cmp	al,09
jg	A7E5
cmp	al,01
je	A803
mov	cl,al
jmp	A81C
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A81C
jmp	GREGERR
cmp	ah,04
jg	A7E4
add	ah,0A
mov	cl,ah
jmp	A81C
lodsb
cmp	al,5D
je	A819
cmp	al,2C
je	A819
mov	ah,al
sub	ah,30
jns	A7F7
xlat
or	al,al
jns	A7E4
mov	cl,01
dec	si
add	cl,D0
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A82A
jmp	PM
mov	al,cl
stosb
ret
M_JMP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A839
jmp	PM
lodsb
xlat
or	al,al
js	A839
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A85B
lodsb
sub	al,30
js	A85A
cmp	al,09
jg	A85A
cmp	al,01
je	A878
mov	cl,al
jmp	A891
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A891
jmp	GREGERR
cmp	ah,03
jg	A859
add	ah,0A
mov	cl,ah
jmp	A891
lodsb
cmp	al,5D
je	A88E
cmp	al,2C
je	A88E
mov	ah,al
sub	ah,30
jns	A86C
xlat
or	al,al
jns	A859
mov	cl,01
dec	si
cmp	cl,08
jge	A899
jmp	GREGERR
add	cl,90
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A8A7
jmp	PM
mov	al,cl
stosb
ret
M_LDB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A8B6
jmp	PM
lodsb
xlat
or	al,al
js	A8B6
dec	si
lodsb
cmp	al,5B
je	A8C6
jmp	M_SMERR
lodsb
and	al,DF
cmp	al,52
jne	A8E0
lodsb
sub	al,30
js	A8DF
cmp	al,09
jg	A8DF
cmp	al,01
je	A8FD
mov	cl,al
jmp	A916
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A916
jmp	GREGERR
cmp	ah,01
jg	A8DE
add	ah,0A
mov	cl,ah
jmp	A916
lodsb
cmp	al,5D
je	A913
cmp	al,2C
je	A913
mov	ah,al
sub	ah,30
jns	A8F1
xlat
or	al,al
jns	A8DE
mov	cl,01
dec	si
lodsb
cmp	al,5D
je	A91E
jmp	M_SMERR1
add	cl,40
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A92C
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
M_LDW:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A93D
jmp	PM
lodsb
xlat
or	al,al
js	A93D
dec	si
lodsb
cmp	al,5B
je	A94D
jmp	M_SMERR
lodsb
and	al,DF
cmp	al,52
jne	A967
lodsb
sub	al,30
js	A966
cmp	al,09
jg	A966
cmp	al,01
je	A984
mov	cl,al
jmp	A99D
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	A99D
jmp	GREGERR
cmp	ah,01
jg	A965
add	ah,0A
mov	cl,ah
jmp	A99D
lodsb
cmp	al,5D
je	A99A
cmp	al,2C
je	A99A
mov	ah,al
sub	ah,30
jns	A978
xlat
or	al,al
jns	A965
mov	cl,01
dec	si
lodsb
cmp	al,5D
je	A9A5
jmp	M_SMERR1
add	cl,40
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A9B3
jmp	PM
mov	al,cl
stosb
ret
M_LEA:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	A9C2
jmp	PM
lodsb
xlat
or	al,al
js	A9C2
dec	si
lodsb
and	al,DF
cmp	al,52
jne	A9E4
lodsb
sub	al,30
js	A9E3
cmp	al,09
jg	A9E3
cmp	al,01
je	AA01
mov	cl,al
jmp	AA1A
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	AA1A
jmp	GREGERR
cmp	ah,05
jg	A9E2
add	ah,0A
mov	cl,ah
jmp	AA1A
lodsb
cmp	al,5D
je	AA18
cmp	al,2C
je	AA17
mov	ah,al
sub	ah,30
jns	A9F5
xlat
or	al,al
jns	A9E2
dec	si
mov	cl,01
add	cl,F0
push	cx
lodsb
cmp	al,2C
je	AA26
jmp	IBTERR
call	CONVEXPRESS
and	cx,FF
or	dx,dx
je	AA33
jmp	M_IWT2
pop	dx
test	byte	ptr	ss:[0ACE],C0
je	AAB2
test	byte	ptr	ss:[0ACE],40
jne	AA6F
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	AA6B
call	MOREFR
pop	bp
pop	es
jmp	AAB2
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	AAAE
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AABD
jmp	PM
mov	al,dl
stosb
mov	ax,cx
stosw
ret
M_LJM:
lodsb
and	al,DF
cmp	al,50
je	AACE
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AAD9
jmp	PM
lodsb
xlat
or	al,al
js	AAD9
dec	si
lodsb
and	al,DF
cmp	al,52
jne	AAFB
lodsb
sub	al,30
js	AAFA
cmp	al,09
jg	AAFA
cmp	al,01
je	AB18
mov	cl,al
jmp	AB31
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	AB31
jmp	GREGERR
cmp	ah,03
jg	AAF9
add	ah,0A
mov	cl,ah
jmp	AB31
lodsb
cmp	al,5D
je	AB2E
cmp	al,2C
je	AB2E
mov	ah,al
sub	ah,30
jns	AB0C
xlat
or	al,al
jns	AAF9
mov	cl,01
dec	si
cmp	cl,07
ja	AB39
jmp	GREGERR
add	cl,90
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AB47
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
M_LM:
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AB59
jmp	PM
lodsb
xlat
or	al,al
js	AB59
dec	si
lodsb
and	al,DF
cmp	al,52
jne	AB7B
lodsb
sub	al,30
js	AB7A
cmp	al,09
jg	AB7A
cmp	al,01
je	AB98
mov	cl,al
jmp	ABB1
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	ABB1
jmp	GREGERR
cmp	ah,05
jg	AB79
add	ah,0A
mov	cl,ah
jmp	ABB1
lodsb
cmp	al,5D
je	ABAF
cmp	al,2C
je	ABAE
mov	ah,al
sub	ah,30
jns	AB8C
xlat
or	al,al
jns	AB79
dec	si
mov	cl,01
add	cl,F0
mov	ch,3D
xchg	ch,cl
push	cx
lodsw
cmp	al,2C
je	ABC1
jmp	IBTERR
cmp	ah,5B
je	ABC9
jmp	M_LMERR
call	CONVEXPRESS
lodsb
cmp	al,5D
je	ABD4
jmp	M_LMERR1
pop	dx
test	byte	ptr	ss:[0ACE],C0
jne	ABE0
jmp	AC64
test	byte	ptr	ss:[0ACE],40
jne	AC17
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	AC13
call	MOREFR
pop	bp
pop	es
jmp	AC64
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	AC60
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AC6F
jmp	PM
mov	ax,dx
stosw
mov	ax,cx
stosw
ret
M_LMERR:
pop	cx
push	dx
mov	dx,8285
call	ERROR_ROUT
pop	dx
ret
M_LMERR1:
pop	cx
dec	si
push	dx
mov	dx,8291
call	ERROR_ROUT
pop	dx
ret
M_LINK:
lodsw
and	al,DF
cmp	al,4B
je	AC95
jmp	PM
mov	al,ah
xlat
or	al,al
js	ACA0
jmp	PM
lodsb
xlat
or	al,al
js	ACA0
dec	si
lodsb
cmp	al,23
je	ACB0
jmp	REGNERR
lodsb
cmp	al,31
je	M_LNK1
cmp	al,32
je	M_LNK2
cmp	al,33
je	M_LNK3
cmp	al,34
je	ACC4
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	ACCF
jmp	PM
mov	al,94
stosb
ret
M_LNK1:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	ACDE
jmp	PM
mov	al,91
stosb
ret
M_LNK2:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	ACED
jmp	PM
mov	al,92
stosb
ret
M_LNK3:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	ACFC
jmp	PM
mov	al,93
stosb
ret
M_LMU:
lodsw
and	ax,DFDF
cmp	ax,544C
je	AD0C
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AD17
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AD22
jmp	PM
mov	al,3D
mov	ah,9F
stosw
ret
M_LMS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AD33
jmp	PM
lodsb
xlat
or	al,al
js	AD33
dec	si
lodsb
and	al,DF
cmp	al,52
jne	AD55
lodsb
sub	al,30
js	AD54
cmp	al,09
jg	AD54
cmp	al,01
je	AD72
mov	cl,al
jmp	AD8B
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	AD8B
jmp	GREGERR
cmp	ah,05
jg	AD53
add	ah,0A
mov	cl,ah
jmp	AD8B
lodsb
cmp	al,5D
je	AD89
cmp	al,2C
je	AD88
mov	ah,al
sub	ah,30
jns	AD66
xlat
or	al,al
jns	AD53
dec	si
mov	cl,01
add	cl,A0
mov	ch,3D
xchg	ch,cl
push	cx
lodsw
cmp	al,2C
je	AD9B
jmp	IBTERR
cmp	ah,5B
je	ADA3
jmp	M_LMERR
call	CONVEXPRESS
lodsb
cmp	al,5D
je	ADAE
jmp	M_LMERR1
cmp	cx,00
jns	ADB6
jmp	REGNERR1
cmp	cx,01FF
jle	ADBF
jmp	REGNERR1
test	cx,0001
je	ADC8
jmp	E_LMSODD
shr	cx,1
pop	ax
test	byte	ptr	ss:[0ACE],C0
jne	ADD6
jmp	AE5A
test	byte	ptr	ss:[0ACE],40
jne	AE0D
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0012
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	AE09
call	MOREFR
pop	bp
pop	es
jmp	AE5A
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],12
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	AE56
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
stosw
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AE66
jmp	PM
mov	al,cl
stosb
ret
E_LMSODD:
push	dx
mov	dx,85C4
call	ERROR_ROUT
pop	dx
ret
M_LOB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AE7E
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AE89
jmp	PM
mov	al,9E
stosb
ret
M_LOO:
lodsb
and	al,DF
cmp	al,50
je	AE97
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AEA2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AEAD
jmp	PM
mov	al,3C
stosb
ret
M_LSR:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AEBC
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AEC7
jmp	PM
mov	al,03
stosb
ret
M_MER:
lodsw
and	ax,DFDF
cmp	ax,4547
je	AED7
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AEE2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AEED
jmp	PM
mov	al,70
stosb
ret
M_MOV:
lodsb
and	al,DF
cmp	al,45
je	AEFB
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	M_MOVE
cmp	al,53
jne	AF0A
jmp	M_MOVES
cmp	al,57
jne	AF11
jmp	M_MOVEW
cmp	al,42
jne	M_MOVE
jmp	M_MOVEB
M_MOVE:
lodsb
xlat
or	al,al
js	M_MOVE
dec	si
mov	al,byte	ptr	[si]
cmp	al,5B
jne	AF29
jmp	M_MVSQ
lodsb
and	al,DF
cmp	al,52
jne	AF43
lodsb
sub	al,30
js	AF42
cmp	al,09
jg	AF42
cmp	al,01
je	AF60
mov	cl,al
jmp	AF79
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	AF79
jmp	GREGERR
cmp	ah,05
jg	AF41
add	ah,0A
mov	cl,ah
jmp	AF79
lodsb
cmp	al,5D
je	AF77
cmp	al,2C
je	AF76
mov	ah,al
sub	ah,30
jns	AF54
xlat
or	al,al
jns	AF41
dec	si
mov	cl,01
push	cx
lodsb
cmp	al,2C
je	AF82
jmp	M_MOVESERR
lodsb
cmp	al,23
je	M_MVHA
cmp	al,5B
jne	AF8E
jmp	M_MVSB
dec	si
pop	dx
lodsb
and	al,DF
cmp	al,52
jne	AFAA
lodsb
sub	al,30
js	AFA9
cmp	al,09
jg	AFA9
cmp	al,01
je	AFC7
mov	cl,al
jmp	AFE0
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	AFE0
jmp	GREGERR
cmp	ah,05
jg	AFA8
add	ah,0A
mov	cl,ah
jmp	AFE0
lodsb
cmp	al,5D
je	AFDE
cmp	al,2C
je	AFDD
mov	ah,al
sub	ah,30
jns	AFBB
xlat
or	al,al
jns	AFA8
dec	si
mov	cl,01
add	cl,20
add	dl,10
mov	al,byte	ptr	[si]
xlat
or	al,al
js	AFF1
jmp	PM
mov	al,cl
mov	ah,dl
stosw
ret
M_MVHA:
call	CONVEXPRESS
or	dx,dx
je	M_MVHA1
cmp	dx,FF
je	M_MVHA1
jmp	M_MOVERR2
M_MVHA1:
pop	dx
cmp	cx,7F
jle	B00F
jmp	M_MVIWT
cmp	cx,80
jge	B017
jmp	M_MVIWT
add	dl,A0
test	byte	ptr	ss:[0ACE],C0
je	B098
test	byte	ptr	ss:[0ACE],40
jne	B055
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0000
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	B051
call	MOREFR
pop	bp
pop	es
jmp	B098
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	B094
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B0A3
jmp	PM
mov	al,dl
mov	ah,cl
stosw
ret
M_MVIWT:
add	dl,F0
test	byte	ptr	ss:[0ACE],C0
je	B12A
test	byte	ptr	ss:[0ACE],40
jne	B0E7
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	B0E3
call	MOREFR
pop	bp
pop	es
jmp	B12A
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	B126
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B135
jmp	PM
mov	al,dl
stosb
mov	ax,cx
stosw
ret
M_MVSB:
call	CONVEXPRESS
lodsb
cmp	al,5D
je	B147
jmp	MVSBERR
mov	dx,cx
pop	cx
test	byte	ptr	ss:[0ACE],80
jne	M_MVLM
cmp	dx,0200
jge	M_MVLM
jmp	M_MVLMS
M_MVLM:
add	cl,F0
mov	ch,3D
xchg	cl,ch
test	byte	ptr	ss:[0ACE],C0
jne	B16D
jmp	B1F1
test	byte	ptr	ss:[0ACE],40
jne	B1A4
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	B1A0
call	MOREFR
pop	bp
pop	es
jmp	B1F1
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	B1ED
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B1FC
jmp	PM
mov	ax,cx
stosw
mov	ax,dx
stosw
ret
MVSBERR:
pop	cx
push	dx
mov	dx,8291
call	ERROR_ROUT
pop	dx
ret
M_MVLMS:
shr	dx,1
add	cl,A0
mov	dh,cl
xchg	dl,dh
mov	cl,3D
test	byte	ptr	ss:[0ACE],C0
jne	B223
jmp	B2A7
test	byte	ptr	ss:[0ACE],40
jne	B25A
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0012
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	B256
call	MOREFR
pop	bp
pop	es
jmp	B2A7
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],12
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	B2A3
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B2B2
jmp	PM
mov	al,cl
stosb
mov	ax,dx
stosw
ret
M_MVSQ:
inc	si
call	CONVEXPRESS
lodsw
cmp	ax,2C5D
je	B2C6
jmp	M_MOVERR
mov	dx,cx
lodsb
and	al,DF
cmp	al,52
jne	B2E2
lodsb
sub	al,30
js	B2E1
cmp	al,09
jg	B2E1
cmp	al,01
je	B2FF
mov	cl,al
jmp	B318
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B318
jmp	GREGERR
cmp	ah,05
jg	B2E0
add	ah,0A
mov	cl,ah
jmp	B318
lodsb
cmp	al,5D
je	B316
cmp	al,2C
je	B315
mov	ah,al
sub	ah,30
jns	B2F3
xlat
or	al,al
jns	B2E0
dec	si
mov	cl,01
test	byte	ptr	ss:[0ACE],80
je	B323
jmp	M_MVSM
cmp	dx,0200
jl	B32C
jmp	M_MVSM
shr	dx,1
add	cl,A0
mov	dh,cl
xchg	dl,dh
mov	cl,3E
test	byte	ptr	ss:[0ACE],C0
jne	B342
jmp	B3C6
test	byte	ptr	ss:[0ACE],40
jne	B379
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0012
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	B375
call	MOREFR
pop	bp
pop	es
jmp	B3C6
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],12
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	B3C2
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B3D1
jmp	PM
mov	al,cl
stosb
mov	ax,dx
stosw
ret
M_MVSM:
add	cl,F0
mov	ch,3E
xchg	ch,cl
test	byte	ptr	ss:[0ACE],C0
jne	B3EA
jmp	B46E
test	byte	ptr	ss:[0ACE],40
jne	B421
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	B41D
call	MOREFR
pop	bp
pop	es
jmp	B46E
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	B46A
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B479
jmp	PM
mov	ax,cx
stosw
mov	ax,dx
stosw
ret
M_MOVERR2:
pop	cx
push	dx
mov	dx,8251
call	ERROR_ROUT
pop	dx
ret
M_MOVESERR:
pop	cx
M_MOVERR:
push	dx
mov	dx,8276
call	ERROR_ROUT
pop	dx
ret
M_MOVES:
inc	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B4A0
jmp	PM
lodsb
xlat
or	al,al
js	B4A0
dec	si
lodsb
and	al,DF
cmp	al,52
jne	B4C2
lodsb
sub	al,30
js	B4C1
cmp	al,09
jg	B4C1
cmp	al,01
je	B4DF
mov	cl,al
jmp	B4F8
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B4F8
jmp	GREGERR
cmp	ah,05
jg	B4C0
add	ah,0A
mov	cl,ah
jmp	B4F8
lodsb
cmp	al,5D
je	B4F6
cmp	al,2C
je	B4F5
mov	ah,al
sub	ah,30
jns	B4D3
xlat
or	al,al
jns	B4C0
dec	si
mov	cl,01
mov	dx,cx
lodsb
cmp	al,2C
jne	M_MOVESERR
lodsb
and	al,DF
cmp	al,52
jne	B519
lodsb
sub	al,30
js	B518
cmp	al,09
jg	B518
cmp	al,01
je	B536
mov	cl,al
jmp	B54F
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B54F
jmp	GREGERR
cmp	ah,05
jg	B517
add	ah,0A
mov	cl,ah
jmp	B54F
lodsb
cmp	al,5D
je	B54D
cmp	al,2C
je	B54C
mov	ah,al
sub	ah,30
jns	B52A
xlat
or	al,al
jns	B517
dec	si
mov	cl,01
add	dl,20
add	cl,B0
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B560
jmp	PM
mov	al,dl
mov	ah,cl
stosw
ret
M_MOVEW:
inc	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B572
jmp	PM
lodsb
xlat
or	al,al
js	B572
dec	si
cmp	byte	ptr	[si],5B
jne	B582
jmp	M_MOVEWTOMEM
lodsb
and	al,DF
cmp	al,52
jne	B59C
lodsb
sub	al,30
js	B59B
cmp	al,09
jg	B59B
cmp	al,01
je	B5B9
mov	cl,al
jmp	B5D2
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B5D2
jmp	GREGERR
cmp	ah,05
jg	B59A
add	ah,0A
mov	cl,ah
jmp	B5D2
lodsb
cmp	al,5D
je	B5D0
cmp	al,2C
je	B5CF
mov	ah,al
sub	ah,30
jns	B5AD
xlat
or	al,al
jns	B59A
dec	si
mov	cl,01
mov	dx,cx
lodsw
cmp	al,2C
je	B5DC
jmp	M_MOVERR
cmp	ah,5B
je	B5E4
jmp	M_MNOSB
lodsb
and	al,DF
cmp	al,52
jne	B5FE
lodsb
sub	al,30
js	B5FD
cmp	al,09
jg	B5FD
cmp	al,01
je	B61B
mov	cl,al
jmp	B634
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B634
jmp	GREGERR
cmp	ah,05
jg	B5FC
add	ah,0A
mov	cl,ah
jmp	B634
lodsb
cmp	al,5D
je	B632
cmp	al,2C
je	B631
mov	ah,al
sub	ah,30
jns	B60F
xlat
or	al,al
jns	B5FC
dec	si
mov	cl,01
lodsb
cmp	al,5D
je	B63C
jmp	M_MNOSB
cmp	dl,00
je	M_MOVEW0
add	dl,10
add	cl,40
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B652
jmp	PM
mov	al,dl
mov	ah,cl
stosw
ret
M_MOVEW0:
add	cl,40
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B666
jmp	PM
mov	al,cl
stosb
ret
M_MOVEWTOMEM:
inc	si
lodsb
and	al,DF
cmp	al,52
jne	B685
lodsb
sub	al,30
js	B684
cmp	al,09
jg	B684
cmp	al,01
je	B6A2
mov	cl,al
jmp	B6BB
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B6BB
jmp	GREGERR
cmp	ah,05
jg	B683
add	ah,0A
mov	cl,ah
jmp	B6BB
lodsb
cmp	al,5D
je	B6B9
cmp	al,2C
je	B6B8
mov	ah,al
sub	ah,30
jns	B696
xlat
or	al,al
jns	B683
dec	si
mov	cl,01
lodsb
cmp	al,5D
je	B6C3
jmp	M_MNCSB
lodsb
cmp	al,2C
je	B6CB
jmp	M_MOVERR
mov	dl,cl
lodsb
and	al,DF
cmp	al,52
jne	B6E7
lodsb
sub	al,30
js	B6E6
cmp	al,09
jg	B6E6
cmp	al,01
je	B704
mov	cl,al
jmp	B71D
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B71D
jmp	GREGERR
cmp	ah,05
jg	B6E5
add	ah,0A
mov	cl,ah
jmp	B71D
lodsb
cmp	al,5D
je	B71B
cmp	al,2C
je	B71A
mov	ah,al
sub	ah,30
jns	B6F8
xlat
or	al,al
jns	B6E5
dec	si
mov	cl,01
or	cl,cl
je	M_MOVEW0MEM
xchg	dl,cl
add	dl,B0
add	cl,30
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B734
jmp	PM
mov	al,dl
mov	ah,cl
stosw
ret
M_MOVEW0MEM:
add	cl,30
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B748
jmp	PM
mov	al,cl
stosb
ret
M_MOVEB:
inc	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B758
jmp	PM
lodsb
xlat
or	al,al
js	B758
dec	si
cmp	byte	ptr	[si],5B
jne	B768
jmp	M_MOVEBTOMEM
lodsb
and	al,DF
cmp	al,52
jne	B782
lodsb
sub	al,30
js	B781
cmp	al,09
jg	B781
cmp	al,01
je	B79F
mov	cl,al
jmp	B7B8
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B7B8
jmp	GREGERR
cmp	ah,05
jg	B780
add	ah,0A
mov	cl,ah
jmp	B7B8
lodsb
cmp	al,5D
je	B7B6
cmp	al,2C
je	B7B5
mov	ah,al
sub	ah,30
jns	B793
xlat
or	al,al
jns	B780
dec	si
mov	cl,01
mov	dx,cx
lodsw
cmp	al,2C
je	B7C2
jmp	M_MOVERR
cmp	ah,5B
je	B7CA
jmp	M_MNOSB
lodsb
and	al,DF
cmp	al,52
jne	B7E4
lodsb
sub	al,30
js	B7E3
cmp	al,09
jg	B7E3
cmp	al,01
je	B801
mov	cl,al
jmp	B81A
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B81A
jmp	GREGERR
cmp	ah,05
jg	B7E2
add	ah,0A
mov	cl,ah
jmp	B81A
lodsb
cmp	al,5D
je	B818
cmp	al,2C
je	B817
mov	ah,al
sub	ah,30
jns	B7F5
xlat
or	al,al
jns	B7E2
dec	si
mov	cl,01
lodsb
cmp	al,5D
je	B822
jmp	M_MNCSB
or	dl,dl
je	M_MOVEB0
add	dl,10
add	cl,40
mov	ch,3D
xchg	cl,ch
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B83B
jmp	PM
mov	al,dl
stosb
mov	ax,cx
stosw
ret
M_MOVEB0:
add	cl,40
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B850
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
M_MOVEBTOMEM:
inc	si
lodsb
and	al,DF
cmp	al,52
jne	B871
lodsb
sub	al,30
js	B870
cmp	al,09
jg	B870
cmp	al,01
je	B88E
mov	cl,al
jmp	B8A7
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B8A7
jmp	GREGERR
cmp	ah,05
jg	B86F
add	ah,0A
mov	cl,ah
jmp	B8A7
lodsb
cmp	al,5D
je	B8A5
cmp	al,2C
je	B8A4
mov	ah,al
sub	ah,30
jns	B882
xlat
or	al,al
jns	B86F
dec	si
mov	cl,01
lodsb
cmp	al,5D
je	B8AF
jmp	M_MNCSB
lodsb
cmp	al,2C
je	B8B7
jmp	M_MOVERR
mov	dl,cl
lodsb
and	al,DF
cmp	al,52
jne	B8D3
lodsb
sub	al,30
js	B8D2
cmp	al,09
jg	B8D2
cmp	al,01
je	B8F0
mov	cl,al
jmp	B909
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B909
jmp	GREGERR
cmp	ah,05
jg	B8D1
add	ah,0A
mov	cl,ah
jmp	B909
lodsb
cmp	al,5D
je	B907
cmp	al,2C
je	B906
mov	ah,al
sub	ah,30
jns	B8E4
xlat
or	al,al
jns	B8D1
dec	si
mov	cl,01
or	cl,cl
je	M_MOVEB0MEM
xchg	dl,cl
add	dl,B0
mov	ch,cl
add	ch,30
mov	cl,3D
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B924
jmp	PM
mov	al,dl
stosb
mov	ax,cx
stosw
ret
M_MOVEB0MEM:
add	dl,30
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B939
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
M_MNOSB:
push	dx
mov	dx,8285
call	ERROR_ROUT
pop	dx
ret
M_MNCSB:
dec	si
push	dx
mov	dx,8291
call	ERROR_ROUT
pop	dx
ret
M_MUL:
lodsb
and	al,DF
cmp	al,54
je	B95C
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B967
jmp	PM
lodsb
xlat
or	al,al
js	B967
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	B9D7
lodsb
and	al,DF
cmp	al,52
jne	B98F
lodsb
sub	al,30
js	B98E
cmp	al,09
jg	B98E
cmp	al,01
je	B9AC
mov	cl,al
jmp	B9C5
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	B9C5
jmp	GREGERR
cmp	ah,05
jg	B98D
add	ah,0A
mov	cl,ah
jmp	B9C5
lodsb
cmp	al,5D
je	B9C2
cmp	al,2C
je	B9C2
mov	ah,al
sub	ah,30
jns	B9A0
xlat
or	al,al
jns	B98D
mov	cl,01
dec	si
add	cl,80
mov	al,byte	ptr	[si]
xlat
or	al,al
js	B9D3
jmp	PM
mov	al,cl
stosb
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	B9E3
jmp	REGNERR
cmp	cx,0F
jle	B9EB
jmp	REGNERR
add	cl,80
test	byte	ptr	ss:[0ACE],C0
je	BA6C
test	byte	ptr	ss:[0ACE],40
jne	BA29
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	BA25
call	MOREFR
pop	bp
pop	es
jmp	BA6C
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	BA68
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BA77
jmp	PM
mov	al,3E
mov	ah,cl
stosw
ret
M_NOP:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BA88
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BA93
jmp	PM
mov	al,01
stosb
ret
M_NOT:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BAA2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BAAD
jmp	PM
mov	al,4F
stosb
ret
M_OR:
lodsb
xlat
or	al,al
js	M_OR2
cmp	al,47
jne	BABF
jmp	M_ORG
jmp	PM
M_OR2:
lodsb
xlat
or	al,al
js	M_OR2
dec	si
lodsb
xlat
or	al,al
js	BACA
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	BADF
inc	cl
jmp	BAD6
xlat
or	al,al
jns	BAD6
mov	si,bp
cmp	cl,02
jne	M_ORCONT
jmp	M_OR3
M_ORCONT:
mov	al,byte	ptr	[si]
cmp	al,23
je	ORISHASH
lodsb
and	al,DF
cmp	al,52
jne	BB0F
lodsb
sub	al,30
js	BB0E
cmp	al,09
jg	BB0E
cmp	al,01
je	BB2C
mov	cl,al
jmp	BB45
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	BB45
jmp	GREGERR
cmp	ah,05
jg	BB0D
add	ah,0A
mov	cl,ah
jmp	BB45
lodsb
cmp	al,5D
je	BB43
cmp	al,2C
je	BB42
mov	ah,al
sub	ah,30
jns	BB20
xlat
or	al,al
jns	BB0D
dec	si
mov	cl,01
cmp	cl,01
jge	BB4D
jmp	GREGERR
add	cl,C0
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BB5B
jmp	PM
mov	al,cl
stosb
ret
ORISHASH:
inc	si
call	CONVEXPRESS
cmp	dx,00
je	BB6B
jmp	REGNERR
or	cx,cx
ja	BB72
jmp	REGNERR
cmp	cx,0F
jle	BB7A
jmp	REGNERR
add	cl,C0
test	byte	ptr	ss:[0ACE],C0
je	BBFB
test	byte	ptr	ss:[0ACE],40
jne	BBB8
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	BBB4
call	MOREFR
pop	bp
pop	es
jmp	BBFB
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	BBF7
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BC06
jmp	PM
mov	al,3E
mov	ah,cl
stosw
ret
M_OR3:
lodsb
and	al,DF
cmp	al,52
jne	BC26
lodsb
sub	al,30
js	BC25
cmp	al,09
jg	BC25
cmp	al,01
je	BC43
mov	cl,al
jmp	BC58
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	BC58
jmp	GREGERR
cmp	ah,05
jg	BC24
add	ah,0A
mov	cl,ah
jmp	BC58
lodsb
cmp	al,2C
je	BC55
mov	ah,al
sub	ah,30
jns	BC37
xlat
or	al,al
jns	BC24
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	BC65
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	BC7F
lodsb
sub	al,30
js	BC7E
cmp	al,09
jg	BC7E
cmp	al,01
je	BC9C
mov	cl,al
jmp	BCB1
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	BCB1
jmp	GREGERR
cmp	ah,05
jg	BC7D
add	ah,0A
mov	cl,ah
jmp	BCB1
lodsb
cmp	al,2C
je	BCAE
mov	ah,al
sub	ah,30
jns	BC90
xlat
or	al,al
jns	BC7D
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	BCBE
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_ORCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
M_RPI:
lodsb
and	al,DF
cmp	al,58
je	BCD9
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BCE4
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BCEF
jmp	PM
mov	al,3D
mov	ah,4C
stosw
ret
M_PLO:
lodsb
and	al,DF
cmp	al,54
je	BCFF
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD0A
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD15
jmp	PM
mov	al,4C
stosb
ret
M_RAM:
lodsb
and	al,DF
cmp	al,42
je	BD23
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD2E
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD39
jmp	PM
mov	al,3E
mov	ah,DF
stosw
ret
M_ROL:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD4A
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD55
jmp	PM
mov	al,04
stosb
ret
M_ROM:
lodsb
and	al,DF
cmp	al,42
je	BD63
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD6E
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD79
jmp	PM
mov	al,3F
mov	ah,DF
stosw
ret
M_ROR:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD8A
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BD95
jmp	PM
mov	al,97
stosb
ret
M_SEX:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDA4
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDAF
jmp	PM
mov	al,95
stosb
ret
M_SBK:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDBE
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDC9
jmp	PM
mov	al,90
stosb
ret
M_STO:
lodsb
and	al,DF
cmp	al,50
je	BDD7
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDE2
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDED
jmp	PM
mov	al,00
stosb
ret
M_STB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BDFC
jmp	PM
lodsb
xlat
or	al,al
js	BDFC
dec	si
lodsb
cmp	al,5B
je	BE0C
jmp	M_SMERR
lodsb
and	al,DF
cmp	al,52
jne	BE26
lodsb
sub	al,30
js	BE25
cmp	al,09
jg	BE25
cmp	al,01
je	BE43
mov	cl,al
jmp	BE5C
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	BE5C
jmp	GREGERR
cmp	ah,01
jg	BE24
add	ah,0A
mov	cl,ah
jmp	BE5C
lodsb
cmp	al,5D
je	BE59
cmp	al,2C
je	BE59
mov	ah,al
sub	ah,30
jns	BE37
xlat
or	al,al
jns	BE24
mov	cl,01
dec	si
lodsb
cmp	al,5D
je	BE64
jmp	M_SMERR1
add	cl,30
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BE72
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
M_STW:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BE83
jmp	PM
lodsb
xlat
or	al,al
js	BE83
dec	si
lodsb
cmp	al,5B
je	BE93
jmp	M_SMERR
lodsb
and	al,DF
cmp	al,52
jne	BEAD
lodsb
sub	al,30
js	BEAC
cmp	al,09
jg	BEAC
cmp	al,01
je	BECA
mov	cl,al
jmp	BEE3
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	BEE3
jmp	GREGERR
cmp	ah,01
jg	BEAB
add	ah,0A
mov	cl,ah
jmp	BEE3
lodsb
cmp	al,5D
je	BEE0
cmp	al,2C
je	BEE0
mov	ah,al
sub	ah,30
jns	BEBE
xlat
or	al,al
jns	BEAB
mov	cl,01
dec	si
lodsb
cmp	al,5D
je	BEEB
jmp	M_SMERR1
add	cl,30
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BEF9
jmp	PM
mov	al,cl
stosb
ret
M_SUB:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BF08
jmp	PM
lodsb
xlat
or	al,al
js	BF08
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	BF1D
inc	cl
jmp	BF14
xlat
or	al,al
jns	BF14
mov	si,bp
cmp	cl,02
jne	M_SUBCONT
jmp	M_SUB3
M_SUBCONT:
lodsb
xlat
or	al,al
js	M_SUBCONT
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	BF9D
lodsb
and	al,DF
cmp	al,52
jne	BF55
lodsb
sub	al,30
js	BF54
cmp	al,09
jg	BF54
cmp	al,01
je	BF72
mov	cl,al
jmp	BF8B
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	BF8B
jmp	GREGERR
cmp	ah,05
jg	BF53
add	ah,0A
mov	cl,ah
jmp	BF8B
lodsb
cmp	al,5D
je	BF88
cmp	al,2C
je	BF88
mov	ah,al
sub	ah,30
jns	BF66
xlat
or	al,al
jns	BF53
mov	cl,01
dec	si
add	cl,60
mov	al,byte	ptr	[si]
xlat
or	al,al
js	BF99
jmp	PM
mov	al,cl
stosb
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	BFA9
jmp	REGNERR
cmp	cx,0F
jle	BFB1
jmp	REGNERR
add	cl,60
test	byte	ptr	ss:[0ACE],C0
je	C032
test	byte	ptr	ss:[0ACE],40
jne	BFEF
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	BFEB
call	MOREFR
pop	bp
pop	es
jmp	C032
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	C02E
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C03D
jmp	PM
mov	al,3E
mov	ah,cl
stosw
ret
M_SUB3:
lodsb
and	al,DF
cmp	al,52
jne	C05D
lodsb
sub	al,30
js	C05C
cmp	al,09
jg	C05C
cmp	al,01
je	C07A
mov	cl,al
jmp	C08F
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C08F
jmp	GREGERR
cmp	ah,05
jg	C05B
add	ah,0A
mov	cl,ah
jmp	C08F
lodsb
cmp	al,2C
je	C08C
mov	ah,al
sub	ah,30
jns	C06E
xlat
or	al,al
jns	C05B
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	C09C
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	C0B6
lodsb
sub	al,30
js	C0B5
cmp	al,09
jg	C0B5
cmp	al,01
je	C0D3
mov	cl,al
jmp	C0E8
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C0E8
jmp	GREGERR
cmp	ah,05
jg	C0B4
add	ah,0A
mov	cl,ah
jmp	C0E8
lodsb
cmp	al,2C
je	C0E5
mov	ah,al
sub	ah,30
jns	C0C7
xlat
or	al,al
jns	C0B4
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	C0F5
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_SUBCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
M_SBC:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C111
jmp	PM
lodsb
xlat
or	al,al
js	C111
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	C126
inc	cl
jmp	C11D
xlat
or	al,al
jns	C11D
mov	si,bp
cmp	cl,02
je	M_SBC3
M_SBCCONT:
lodsb
xlat
or	al,al
js	M_SBCCONT
dec	si
lodsb
and	al,DF
cmp	al,52
jne	C155
lodsb
sub	al,30
js	C154
cmp	al,09
jg	C154
cmp	al,01
je	C172
mov	cl,al
jmp	C18B
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C18B
jmp	GREGERR
cmp	ah,05
jg	C153
add	ah,0A
mov	cl,ah
jmp	C18B
lodsb
cmp	al,5D
je	C188
cmp	al,2C
je	C188
mov	ah,al
sub	ah,30
jns	C166
xlat
or	al,al
jns	C153
mov	cl,01
dec	si
add	cl,60
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C199
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
M_SBC3:
lodsb
and	al,DF
cmp	al,52
jne	C1B9
lodsb
sub	al,30
js	C1B8
cmp	al,09
jg	C1B8
cmp	al,01
je	C1D6
mov	cl,al
jmp	C1EB
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C1EB
jmp	GREGERR
cmp	ah,05
jg	C1B7
add	ah,0A
mov	cl,ah
jmp	C1EB
lodsb
cmp	al,2C
je	C1E8
mov	ah,al
sub	ah,30
jns	C1CA
xlat
or	al,al
jns	C1B7
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	C1F8
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	C212
lodsb
sub	al,30
js	C211
cmp	al,09
jg	C211
cmp	al,01
je	C22F
mov	cl,al
jmp	C244
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C244
jmp	GREGERR
cmp	ah,05
jg	C210
add	ah,0A
mov	cl,ah
jmp	C244
lodsb
cmp	al,2C
je	C241
mov	ah,al
sub	ah,30
jns	C223
xlat
or	al,al
jns	C210
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	C251
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_SBCCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
M_SM:
dec	si
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C26E
jmp	PM
lodsb
xlat
or	al,al
js	C26E
dec	si
lodsb
cmp	al,5B
je	C27E
jmp	M_SMERR
call	CONVEXPRESS
lodsw
cmp	al,5D
je	C289
jmp	M_SMERR1
cmp	ah,2C
je	C291
jmp	M_SMERR2
push	cx
lodsb
and	al,DF
cmp	al,52
jne	C2AC
lodsb
sub	al,30
js	C2AB
cmp	al,09
jg	C2AB
cmp	al,01
je	C2C9
mov	cl,al
jmp	C2E2
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C2E2
jmp	GREGERR
cmp	ah,05
jg	C2AA
add	ah,0A
mov	cl,ah
jmp	C2E2
lodsb
cmp	al,5D
je	C2E0
cmp	al,2C
je	C2DF
mov	ah,al
sub	ah,30
jns	C2BD
xlat
or	al,al
jns	C2AA
dec	si
mov	cl,01
add	cl,F0
mov	ch,3E
xchg	ch,cl
pop	dx
test	byte	ptr	ss:[0ACE],C0
jne	C2F5
jmp	C379
test	byte	ptr	ss:[0ACE],40
jne	C32C
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0002
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	C328
call	MOREFR
pop	bp
pop	es
jmp	C379
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],02
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	C375
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C384
jmp	PM
mov	ax,cx
stosw
mov	ax,dx
stosw
ret
M_SMERR:
push	dx
mov	dx,8285
call	ERROR_ROUT
pop	dx
ret
M_SMERR1:
push	dx
mov	dx,8291
call	ERROR_ROUT
pop	dx
ret
M_SMERR2:
push	dx
mov	dx,8276
call	ERROR_ROUT
pop	dx
ret
M_SMS:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C3B1
jmp	PM
lodsb
xlat
or	al,al
js	C3B1
dec	si
lodsb
cmp	al,5B
jne	M_SMERR
call	CONVEXPRESS
cmp	cx,00
jns	C3C9
jmp	REGNERR
cmp	cx,01FF
jle	C3D2
jmp	REGNERR
test	cx,0001
je	C3DB
jmp	E_LMSODD
shr	cx,1
lodsw
cmp	al,5D
jne	M_SMERR1
cmp	ah,2C
jne	M_SMERR2
push	cx
lodsb
and	al,DF
cmp	al,52
jne	C402
lodsb
sub	al,30
js	C401
cmp	al,09
jg	C401
cmp	al,01
je	C41F
mov	cl,al
jmp	C438
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C438
jmp	GREGERR
cmp	ah,05
jg	C400
add	ah,0A
mov	cl,ah
jmp	C438
lodsb
cmp	al,5D
je	C436
cmp	al,2C
je	C435
mov	ah,al
sub	ah,30
jns	C413
xlat
or	al,al
jns	C400
dec	si
mov	cl,01
add	cl,A0
mov	ch,3E
xchg	ch,cl
pop	dx
test	byte	ptr	ss:[0ACE],C0
jne	C44B
jmp	C4CF
test	byte	ptr	ss:[0ACE],40
jne	C482
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0012
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	C47E
call	MOREFR
pop	bp
pop	es
jmp	C4CF
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],12
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	C4CB
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	ax,cx
stosw
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C4DD
jmp	PM
mov	al,dl
stosb
ret
M_SWA:
lodsb
and	al,DF
cmp	al,50
je	C4EB
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C4F6
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C501
jmp	PM
mov	al,4D
stosb
ret
M_TO:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C510
jmp	PM
lodsb
xlat
or	al,al
js	C510
dec	si
lodsb
and	al,DF
cmp	al,52
jne	C532
lodsb
sub	al,30
js	C531
cmp	al,09
jg	C531
cmp	al,01
je	C54F
mov	cl,al
jmp	C568
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C568
jmp	GREGERR
cmp	ah,05
jg	C530
add	ah,0A
mov	cl,ah
jmp	C568
lodsb
cmp	al,5D
je	C565
cmp	al,2C
je	C565
mov	ah,al
sub	ah,30
jns	C543
xlat
or	al,al
jns	C530
mov	cl,01
dec	si
add	cl,10
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C576
jmp	PM
mov	al,cl
stosb
ret
M_UMU:
lodsw
and	ax,DFDF
cmp	ax,544C
je	C586
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C591
jmp	PM
lodsb
xlat
or	al,al
js	C591
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	C603
lodsb
and	al,DF
cmp	al,52
jne	C5B9
lodsb
sub	al,30
js	C5B8
cmp	al,09
jg	C5B8
cmp	al,01
je	C5D6
mov	cl,al
jmp	C5EF
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C5EF
jmp	GREGERR
cmp	ah,05
jg	C5B7
add	ah,0A
mov	cl,ah
jmp	C5EF
lodsb
cmp	al,5D
je	C5EC
cmp	al,2C
je	C5EC
mov	ah,al
sub	ah,30
jns	C5CA
xlat
or	al,al
jns	C5B7
mov	cl,01
dec	si
add	cl,80
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C5FD
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	C60F
jmp	REGNERR
cmp	cx,0F
jle	C617
jmp	REGNERR
add	cl,80
test	byte	ptr	ss:[0ACE],C0
je	C698
test	byte	ptr	ss:[0ACE],40
jne	C655
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	C651
call	MOREFR
pop	bp
pop	es
jmp	C698
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	C694
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C6A3
jmp	PM
mov	al,3F
mov	ah,cl
stosw
ret
M_WIT:
lodsb
and	al,DF
cmp	al,48
je	C6B3
jmp	PM
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C6BE
jmp	PM
lodsb
xlat
or	al,al
js	C6BE
dec	si
lodsb
and	al,DF
cmp	al,52
jne	C6E0
lodsb
sub	al,30
js	C6DF
cmp	al,09
jg	C6DF
cmp	al,01
je	C6FD
mov	cl,al
jmp	C716
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C716
jmp	GREGERR
cmp	ah,05
jg	C6DE
add	ah,0A
mov	cl,ah
jmp	C716
lodsb
cmp	al,5D
je	C713
cmp	al,2C
je	C713
mov	ah,al
sub	ah,30
jns	C6F1
xlat
or	al,al
jns	C6DE
mov	cl,01
dec	si
add	cl,20
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C724
jmp	PM
mov	al,cl
stosb
ret
M_XOR:
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C733
jmp	PM
lodsb
xlat
or	al,al
js	C733
dec	si
mov	bp,si
xor	cl,cl
lodsb
cmp	al,2C
jne	C748
inc	cl
jmp	C73F
xlat
or	al,al
jns	C73F
mov	si,bp
cmp	cl,02
jne	M_XORCONT
jmp	M_XOR3
M_XORCONT:
lodsb
xlat
or	al,al
js	M_XORCONT
dec	si
mov	al,byte	ptr	[si]
cmp	al,23
je	C7D2
lodsb
and	al,DF
cmp	al,52
jne	C780
lodsb
sub	al,30
js	C77F
cmp	al,09
jg	C77F
cmp	al,01
je	C79D
mov	cl,al
jmp	C7B6
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C7B6
jmp	GREGERR
cmp	ah,05
jg	C77E
add	ah,0A
mov	cl,ah
jmp	C7B6
lodsb
cmp	al,5D
je	C7B3
cmp	al,2C
je	C7B3
mov	ah,al
sub	ah,30
jns	C791
xlat
or	al,al
jns	C77E
mov	cl,01
dec	si
cmp	cl,00
jne	C7BE
jmp	GREGERR
add	cl,C0
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C7CC
jmp	PM
mov	al,3D
mov	ah,cl
stosw
ret
inc	si
call	CONVEXPRESS
cmp	dx,00
je	C7DE
jmp	REGNERR
cmp	cx,0F
jle	C7E6
jmp	REGNERR
cmp	cl,00
jne	C7EE
jmp	REGNERR
add	cl,C0
test	byte	ptr	ss:[0ACE],C0
je	C86F
test	byte	ptr	ss:[0ACE],40
jne	C82C
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
mov	word	ptr	es:[bp+02],000C
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	C828
call	MOREFR
pop	bp
pop	es
jmp	C86F
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],0C
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	C86B
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
mov	al,byte	ptr	[si]
xlat
or	al,al
js	C87A
jmp	PM
mov	al,3F
mov	ah,cl
stosw
ret
M_XOR3:
lodsb
and	al,DF
cmp	al,52
jne	C89A
lodsb
sub	al,30
js	C899
cmp	al,09
jg	C899
cmp	al,01
je	C8B7
mov	cl,al
jmp	C8CC
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C8CC
jmp	GREGERR
cmp	ah,05
jg	C898
add	ah,0A
mov	cl,ah
jmp	C8CC
lodsb
cmp	al,2C
je	C8C9
mov	ah,al
sub	ah,30
jns	C8AB
xlat
or	al,al
jns	C898
mov	cl,01
dec	si
mov	byte	ptr	ss:[248D],cl
lodsb
cmp	al,2C
je	C8D9
jmp	EAERR
lodsb
and	al,DF
cmp	al,52
jne	C8F3
lodsb
sub	al,30
js	C8F2
cmp	al,09
jg	C8F2
cmp	al,01
je	C910
mov	cl,al
jmp	C925
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	C925
jmp	GREGERR
cmp	ah,05
jg	C8F1
add	ah,0A
mov	cl,ah
jmp	C925
lodsb
cmp	al,2C
je	C922
mov	ah,al
sub	ah,30
jns	C904
xlat
or	al,al
jns	C8F1
mov	cl,01
dec	si
mov	byte	ptr	ss:[248C],cl
lodsb
cmp	al,2C
je	C932
jmp	EAERR
call	CODEDREGSREG_ROU
call	M_XORCONT
mov	ds,word	ptr	ss:[2494]
mov	si,word	ptr	ss:[2496]
ret
CODEDREGSREG_ROU:
cmp	byte	ptr	[si],5B
je	C94B
jmp	REG2REG
inc	si
mov	byte	ptr	ss:[248E],00
call	CONVEXPRESS
lodsb
cmp	al,3A
jne	REGSPECONT
jmp	REGSPEC
REGSPECONT:
cmp	al,5D
je	C964
jmp	M_LMERR1
cmp	cx,00
jns	C96C
jmp	REGNERR1
cmp	cx,01FF
jle	C975
jmp	REGNERR1
test	cx,0001
je	C97E
jmp	E_LMSODD
shr	cx,1
mov	al,byte	ptr	[248E]
add	al,A0
mov	ah,3D
xchg	ah,al
test	byte	ptr	ss:[0ACE],C0
jne	C995
jmp	CA19
test	byte	ptr	ss:[0ACE],40
jne	C9CC
push	es
push	bp
mov	es,word	ptr	ss:[0AC5]
mov	bp,word	ptr	ss:[0AC9]
mov	word	ptr	es:[bp+06],di
inc	word	ptr	es:[bp+06]
mov	word	ptr	es:[bp+02],0012
add	bp,15
mov	word	ptr	ss:[0AC7],bp
cmp	bp,7F00
jb	C9C8
call	MOREFR
pop	bp
pop	es
jmp	CA19
push	es
push	bp
push	cx
push	ax
mov	es,word	ptr	ss:[13A6]
mov	bp,word	ptr	ss:[13A8]
mov	ax,di
sub	ax,word	ptr	ss:[13B4]
xor	cx,cx
add	ax,word	ptr	ss:[13BE]
adc	cx,word	ptr	ss:[13BC]
mov	word	ptr	es:[bp+00],ax
mov	word	ptr	es:[bp+02],cx
mov	byte	ptr	es:[bp+04],12
add	word	ptr	es:[bp+00],01
adc	word	ptr	es:[bp+02],00
add	bp,05
mov	word	ptr	ss:[13A8],bp
cmp	bp,3F00
jb	CA15
call	MOREEXT
pop	ax
pop	cx
pop	bp
pop	es
stosw
mov	al,cl
stosb
mov	al,byte	ptr	[248C]
cmp	al,byte	ptr	ss:[248D]
je	WITH2
or	al,al
je	CHKDREG2
add	al,B0
stosb
CHKDREG2:
mov	al,byte	ptr	[248D]
or	al,al
je	EXIT2
add	al,10
stosb
jmp	EXIT2
WITH2:
or	al,al
je	EXIT2
add	al,20
stosb
EXIT2:
mov	al,52
mov	byte	ptr	[248F],al
mov	al,byte	ptr	[248E]
cmp	al,0A
jb	DIG1
mov	al,31
mov	byte	ptr	[2490],al
mov	al,byte	ptr	[248E]
sub	al,0A
add	al,30
mov	byte	ptr	[2491],al
mov	byte	ptr	ss:[2492],0D
mov	byte	ptr	ss:[2493],0A
mov	word	ptr	ss:[2494],ds
mov	word	ptr	ss:[2496],si
mov	ax,ss
mov	ds,ax
mov	si,248F
ret
DIG1:
add	al,30
mov	byte	ptr	[2490],al
mov	byte	ptr	ss:[2491],0D
mov	byte	ptr	ss:[2492],0A
mov	word	ptr	ss:[2494],ds
mov	word	ptr	ss:[2496],si
mov	ax,ss
mov	ds,ax
mov	si,248F
ret
REGSPEC:
push	cx
lodsb
and	al,DF
cmp	al,52
jne	CAC0
lodsb
sub	al,30
js	CABF
cmp	al,09
jg	CABF
cmp	al,01
je	CADD
mov	cl,al
jmp	CAF2
dec	si
dec	si
dec	si
push	dx
call	CONVEXPRESS
pop	dx
test	byte	ptr	ss:[0ACE],04
jne	CAF2
jmp	GREGERR
cmp	ah,05
jg	CABE
add	ah,0A
mov	cl,ah
jmp	CAF2
lodsb
cmp	al,2C
je	CAEF
mov	ah,al
sub	ah,30
jns	CAD1
xlat
or	al,al
jns	CABE
mov	cl,01
dec	si
mov	byte	ptr	ss:[248E],cl
pop	cx
lodsb
jmp	REGSPECONT
REG2REG:
mov	al,byte	ptr	[248C]
cmp	al,byte	ptr	ss:[248D]
je	WITH
or	al,al
je	CHKDREG
add	al,B0
stosb
CHKDREG:
mov	al,byte	ptr	[248D]
or	al,al
je	EXIT
add	al,10
stosb
jmp	EXIT
WITH:
or	al,al
je	EXIT
add	al,20
stosb
EXIT:
mov	word	ptr	ss:[2494],ds
mov	word	ptr	ss:[2496],si
ret
OPEN_MAP_FILE:
test	byte	ptr	ss:[9BE8],FF
je	OMFEND
mov	dx,A43D
mov	ax,8AC9
mov	ds,ax
mov	cx,0000
call	far	ptr	_OS2OPENNEWFILE
jae	OMF1
mov	byte	ptr	ss:[9BE8],00
push	dx
mov	dx,7EC6
call	ERROR_ROUT
pop	dx
OMF1:
mov	word	ptr	[9BE9],ax
mov	di,9BED
mov	ax,8AC9
mov	es,ax
mov	ax,4953
stosw
mov	ax,455A
stosw
mov	word	ptr	ss:[9BEB],0004
OMFEND:
ret
GEN_MAP_SYMBOLS:
test	byte	ptr	ss:[9BE8],FF
je	OMFEND
mov	al,byte	ptr	[2498]
or	al,byte	ptr	ss:[13A0]
jne	CB87
jmp	GMFDELETE
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,A44E
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
call	COUNT_SYMBOLS
push	ax
mov	cx,word	ptr	ss:[9BEB]
mov	di,9BED
add	di,cx
mov	ax,8AC9
mov	es,ax
mov	ax,4D53
stosw
mov	ax,3233
stosw
pop	ax
stosw
add	cx,06
mov	si,1472
GMF2:
cmp	word	ptr	ss:[si],00
jne	GMF3
add	si,04
cmp	si,2472
jl	GMF2
jmp	GMF9
GMF3:
push	si
push	ds
mov	ax,word	ptr	ss:[si]
mov	si,word	ptr	ss:[si+02]
mov	ds,ax
GMF4:
test	byte	ptr	[si+04],5E
jne	GMF5
push	si
push	ds
mov	ax,word	ptr	[si+0C]
stosw
mov	ax,word	ptr	[si+0A]
stosw
xor	ah,ah
mov	al,byte	ptr	[si+05]
dec	al
stosb
add	cx,05
add	cx,ax
push	cx
mov	cx,ax
mov	ax,word	ptr	[si+06]
mov	si,word	ptr	[si+08]
mov	ds,ax
rep
movsb
pop	cx
cmp	cx,079C
jl	GMF7
mov	dx,9BED
mov	ax,8AC9
mov	ds,ax
mov	bx,word	ptr	ss:[9BE9]
call	far	ptr	_OS2WRITEBYTES
mov	di,9BED
mov	ax,8AC9
mov	es,ax
xor	cx,cx
GMF7:
pop	ds
pop	si
GMF5:
mov	ax,word	ptr	[si]
or	ax,ax
je	GMF6
mov	si,word	ptr	[si+02]
mov	ds,ax
jmp	GMF4
GMF6:
pop	ds
pop	si
add	si,04
cmp	si,2472
jge	GMF9
jmp	GMF2
GMF9:
or	cx,cx
je	GMFDONE
mov	dx,9BED
mov	ax,8AC9
mov	ds,ax
mov	bx,word	ptr	ss:[9BE9]
call	far	ptr	_OS2WRITEBYTES
GMFDONE:
mov	bx,word	ptr	ss:[9BE9]
call	far	ptr	_OS2CLOSEFILE
mov	si,9ADC
mov	ax,8AC9
mov	ds,ax
test	byte	ptr	ss:[13A0],FF
je	GMF10
mov	si,9B1C
mov	ax,8AC9
mov	ds,ax
GMF10:
mov	di,A3ED
mov	ax,8AC9
mov	es,ax
call	STRCPY
mov	si,A3ED
mov	ax,8AC9
mov	ds,ax
mov	al,2E
call	STRRCHR
mov	bp,si
mov	si,A3ED
mov	ax,8AC9
mov	ds,ax
mov	al,5C
call	STRRCHR
cmp	si,bp
jae	GMF0
mov	byte	ptr	ds:[bp+00],00
GMF0:
mov	si,A3ED
mov	ax,8AC9
mov	ds,ax
mov	di,A449
mov	ax,8AC9
mov	es,ax
call	STRCAT
mov	dx,A3ED
mov	ax,8AC9
mov	ds,ax
call	far	ptr	_OS2DELETEFILE
mov	dx,A43D
mov	ax,8AC9
mov	ds,ax
mov	di,A3ED
mov	ax,8AC9
mov	es,ax
call	far	ptr	_OS2RENAMEFILE
push	ds
push	dx
mov	dx,8AC9
mov	ds,dx
mov	dx,A464
call	far	ptr	_OS2PRTSTRING
pop	dx
pop	ds
ret
GMFDELETE:
mov	bx,word	ptr	ss:[9BE9]
call	far	ptr	_OS2CLOSEFILE
mov	dx,A43D
mov	ax,8AC9
mov	ds,ax
call	far	ptr	_OS2DELETEFILE
ret
MAP_SHORTA:
mov	al,01
jmp	GMS0
MAP_SHORTI:
mov	al,02
jmp	GMS0
MAP_LONGA:
mov	al,03
jmp	GMS0
MAP_LONGI:
mov	al,04
GMS0:
test	byte	ptr	ss:[9BE8],FF
je	GMSEND
push	cx
push	di
push	si
push	es
push	ds
push	bx
mov	cx,word	ptr	ss:[9BEB]
mov	si,9BED
add	si,cx
mov	bx,8AC9
mov	es,bx
mov	byte	ptr	es:[si+03],al
mov	ax,word	ptr	[0F94]
mov	word	ptr	es:[si],ax
mov	al,byte	ptr	[0F92]
mov	byte	ptr	es:[si+02],al
add	cx,04
cmp	cx,079C
jl	GMS1
mov	dx,9BED
mov	ax,8AC9
mov	ds,ax
mov	bx,word	ptr	ss:[9BE9]
call	far	ptr	_OS2WRITEBYTES
xor	cx,cx
GMS1:
mov	word	ptr	ss:[9BEB],cx
pop	bx
pop	ds
pop	es
pop	si
pop	di
pop	cx
GMSEND:
ret
STRRCHR:
xor	cx,cx
mov	ah,al
STRR0:
lodsb
or	al,al
je	STRR1
cmp	ah,al
jne	STRR0
mov	cx,si
dec	cx
jmp	STRR0
STRR1:
mov	si,cx
ret
STRCAT:
push	ds
push	si
STRC0:
lodsb
or	al,al
jne	STRC0
dec	si
STRC1:
mov	al,byte	ptr	es:[di]
mov	byte	ptr	[si],al
inc	si
inc	di
or	al,al
jne	STRC1
pop	si
pop	ds
ret
STRCPY:
push	es
push	di
STRY0:
lodsb
stosb
or	al,al
jne	STRY0
pop	di
pop	es
ret
COUNT_SYMBOLS:
xor	cx,cx
mov	si,1472
CSY2:
cmp	word	ptr	ss:[si],00
jne	CSY3
add	si,04
cmp	si,2472
jl	CSY2
mov	ax,cx
ret
CSY3:
push	si
mov	es,word	ptr	ss:[si]
mov	si,word	ptr	ss:[si+02]
CSY4:
test	byte	ptr	es:[si+04],5E
jne	CSY5
inc	cx
CSY5:
mov	ax,word	ptr	es:[si]
or	ax,ax
je	CSY6
mov	si,word	ptr	es:[si+02]
mov	es,ax
jmp	CSY4
CSY6:
pop	si
add	si,04
cmp	si,2472
jl	CSY2
mov	ax,cx
ret
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
add	byte	ptr	[bx+si],al
or	ax,ax
jne	CE06
clc
ret
stc
ret
_OS2EXIT:
mov	ax,4C00
int	21
_OS2EXITERR:
mov	ax,4C01
int	21
_OS2OPENFILE:
mov	ax,3D00
int	21
retf
_OS2OPENNEWFILE:
mov	ax,3C00
int	21
retf
_OS2OPENAPPENDFILE:
push	ds
push	dx
mov	ax,3D01
int	21
pop	dx
pop	ds
jae	CE33
xor	bx,bx
mov	ax,3C00
mov	cx,0000
int	21
retf
_OS2CLOSEFILE:
mov	ah,3E
int	21
retf
_OS2READBYTES:
mov	ah,3F
int	21
retf
_OS2WRITEBYTES:
mov	al,byte	ptr	[13F2]
or	al,al
je	CE5A
cmp	bx,01
jne	CE5A
push	bx
push	ds
push	dx
push	cx
mov	bx,word	ptr	[13F3]
mov	ah,40
int	21
pop	cx
pop	dx
pop	ds
pop	bx
mov	ah,40
int	21
retf
_OS2SEEKFILE:
mov	ax,4200
int	21
retf
_OS2SEEKEND:
mov	ax,4202
int	21
retf
_OS2ALLOCSEG:
mov	ah,48
int	21
retf
_OS2FREESEG:
mov	ah,49
int	21
retf
_OS2AVAILMEM:
mov	bx,FFFF
mov	ah,48
int	21
shr	bx,06
mov	ax,bx
xor	dx,dx
retf
_OS2GETDATE:
mov	ah,2A
int	21
retf
mov	ah,2C
int	21
retf
_OS2PRTSTRING:
push	cx
xor	cx,cx
push	si
mov	si,dx
lodsb
inc	cx
cmp	al,24
jne	CE94
dec	cx
pop	si
mov	ah,40
mov	bx,0001
call	far	ptr	_OS2WRITEBYTES
pop	cx
retf
_OS2INITTERM:
retf
_OS2RENAMEFILE:
mov	ah,56
int	21
retf
_OS2DELETEFILE:
mov	ah,41
int	21
retf