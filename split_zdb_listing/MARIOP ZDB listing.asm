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