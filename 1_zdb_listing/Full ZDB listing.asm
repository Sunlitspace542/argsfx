; The full code listing for ArgSfx 1.50 (non-extender) with labels
; Brought to you by ZDB 3.0r1

             _ARGSFX:
    79dd:0000  > cld
    79dd:0001  - mov       cx,8AC9
    79dd:0004  - mov       ss,cx
    79dd:0006  - mov       word ptr ss:[9BDE],ds
    79dd:000b  - mov       word ptr ss:[9BE0],0080
    79dd:0012  - mov       dx,79DD
    79dd:0015  - mov       bx,0052
    79dd:0018  - call      far ptr _OS2INITTERM
    79dd:001d  - call      GETMEM
    79dd:0020  - call      ADD_ASSEMVARS
    79dd:0023  - call      PARSECLI
    79dd:0026  - call      OPEN_MAP_FILE
    79dd:0029  - call      ASSEMBLE
    79dd:002c  - call      EVAL_FRS
    79dd:002f  - call      LINK
    79dd:0032  - call      WRITESYMBOLS
    79dd:0035  - call      GEN_MAP_SYMBOLS
    79dd:0038  - call      DO_END
             OVERRET:
    79dd:003b  - mov       ax,word ptr [13C4]
    79dd:003f  - or        ax,ax
    79dd:0041  - jne       0048
    79dd:0043    jmp       far ptr _OS2EXIT
    79dd:0048  - jmp       far ptr _OS2EXITERR
             STOPASSEM:
    79dd:004d  - call      DO_END
    79dd:0050  - jmp       OVERRET
             CTRLCHAN:
    79dd:0052  - push      ds
    79dd:0053    push      dx
    79dd:0054    mov       dx,8AC9
    79dd:0057    mov       ds,dx
    79dd:0059    mov       dx,8A14
    79dd:005c    call      far ptr _OS2PRTSTRING
    79dd:0061    pop       dx
    79dd:0062    pop       ds
    79dd:0063  - jmp       far ptr _OS2EXITERR
             LINK:
    79dd:0068  - mov       al,byte ptr [13A0]
    79dd:006c  - or        al,al
    79dd:006e  - jne       DOLINK
    79dd:0070  - ret
             DOLINK:
    79dd:0071  - mov       ax,word ptr [13C4]
    79dd:0075  - or        ax,ax
    79dd:0077  - je        DOLINK2
    79dd:0079  - ret
             DOLINK2:
    79dd:007a  - push      ds
    79dd:007b    push      dx
    79dd:007c    mov       dx,8AC9
    79dd:007f    mov       ds,dx
    79dd:0081    mov       dx,89FC
    79dd:0084    call      far ptr _OS2PRTSTRING
    79dd:0089    pop       dx
    79dd:008a    pop       ds
    79dd:008b  - push      ds
    79dd:008c    push      dx
    79dd:008d    push      si
    79dd:008e    push      ax
    79dd:008f    mov       bx,8AC9
    79dd:0092    mov       dx,9B1C
    79dd:0095    mov       ds,bx
    79dd:0097    mov       si,dx
    79dd:0099    lodsb
    79dd:009a    or        al,al
    79dd:009c    jne       0099
    79dd:009e    mov       byte ptr [si+FF],24
    79dd:00a2    call      far ptr _OS2PRTSTRING
    79dd:00a7    mov       byte ptr [si+FF],00
    79dd:00ab    pop       ax
    79dd:00ac    pop       si
    79dd:00ad    pop       dx
    79dd:00ae    pop       ds
    79dd:00af  - mov       bx,0800
    79dd:00b2  - call      far ptr _OS2ALLOCSEG
    79dd:00b7  - jae       LBUFOK
    79dd:00b9  - push      dx
    79dd:00ba    mov       dx,8535
    79dd:00bd    call      ERROR_ROUT
    79dd:00c0    pop       dx
             LBUFOK:
    79dd:00c1    mov       word ptr [9A82],ax
    79dd:00c5  - mov       ax,ss
    79dd:00c7  - mov       ds,ax
    79dd:00c9  - mov       dx,9B1C
    79dd:00cc  - xor       cx,cx
    79dd:00ce  - call      far ptr _OS2OPENNEWFILE
    79dd:00d3  - mov       word ptr [0EDD],ax
    79dd:00d7  - jae       LDISKOK
    79dd:00d9  - call      NEEDCR
    79dd:00dc  - push      ds
    79dd:00dd    push      dx
    79dd:00de    mov       dx,8AC9
    79dd:00e1    mov       ds,dx
    79dd:00e3    mov       dx,891C
    79dd:00e6    call      far ptr _OS2PRTSTRING
    79dd:00eb    pop       dx
    79dd:00ec    pop       ds
    79dd:00ed  - ret
             LDISKOK:
    79dd:00ee  - mov       byte ptr ss:[2498],01
    79dd:00f4  - mov       byte ptr ss:[13BA],04
    79dd:00fa  - mov       es,word ptr ss:[9A82]
    79dd:00ff  - xor       di,di
    79dd:0101  - mov       ax,4F53
    79dd:0104  - stosw
    79dd:0105  - mov       ax,4A42
    79dd:0108  - stosw
    79dd:0109  - mov       ax,0101
    79dd:010c  - stosw
    79dd:010d  - xor       ax,ax
    79dd:010f  - stosw
    79dd:0110  - mov       ds,word ptr ss:[9A82]
    79dd:0115  - xor       dx,dx
    79dd:0117  - mov       cx,0008
    79dd:011a  - mov       bx,word ptr ss:[0EDD]
    79dd:011f  - call      far ptr _OS2WRITEBYTES
    79dd:0124  - call      WRITEBLOCKS
    79dd:0127  - call      WRITEPUBLICS
    79dd:012a  - call      WRITEEXTERNS
    79dd:012d  - xor       cx,cx
    79dd:012f  - mov       dx,0006
    79dd:0132  - mov       bx,word ptr ss:[0EDD]
    79dd:0137  - call      far ptr _OS2SEEKFILE
    79dd:013c  - mov       ax,ss
    79dd:013e  - mov       ds,ax
    79dd:0140  - mov       dx,13A2
    79dd:0143  - mov       cx,0002
    79dd:0146  - mov       bx,word ptr ss:[0EDD]
    79dd:014b  - call      far ptr _OS2WRITEBYTES
    79dd:0150  - mov       bx,word ptr ss:[0EDD]
    79dd:0155  - call      far ptr _OS2CLOSEFILE
    79dd:015a  - ret
    79dd:015b  - mov       ds,word ptr ss:[0ED9]
    79dd:0160  - xor       dx,dx
    79dd:0162  - mov       cx,word ptr ss:[0EDB]
    79dd:0167  - mov       bx,word ptr ss:[0EDD]
    79dd:016c  - call      far ptr _OS2WRITEBYTES
    79dd:0171  - ret
             WRITEEXTERNS:
    79dd:0172  - mov       ax,word ptr [13AA]
    79dd:0176  - or        ax,ax
    79dd:0178  - jne       WEDO
    79dd:017a  - ret
             WEDO:
    79dd:017b  - mov       ds,word ptr ss:[13A4]
    79dd:0180  - mov       si,0002
    79dd:0183  - xor       di,di
             WELP:
    79dd:0185  - xor       cx,cx
    79dd:0187  - push      si
    79dd:0188  - add       si,02
    79dd:018b  - lodsw
    79dd:018c  - jmp       WELP3
             WELP2:
    79dd:018e  - lodsw
    79dd:018f  - or        ax,ax
    79dd:0191  - je        WEENDEXP
             WELP3:
    79dd:0193  - test      al,80
    79dd:0195  - je        WENOTLAB
    79dd:0197  - mov       es,word ptr [si]
    79dd:0199  - mov       bp,word ptr [si+02]
    79dd:019c  - mov       al,byte ptr es:[bp+00]
    79dd:01a0  - test      byte ptr es:[bp+04],40
    79dd:01a5  - je        01AA
    79dd:01a7    jmp       WRITESTR
    79dd:01aa  - test      byte ptr es:[bp+04],10
    79dd:01af  - je        01B4
    79dd:01b1    jmp       E_EXTNOTDEF
    79dd:01b4  - mov       dx,word ptr es:[bp+0C]
    79dd:01b8  - mov       word ptr [si],dx
    79dd:01ba  - mov       dx,word ptr es:[bp+0A]
    79dd:01be  - mov       word ptr [si+02],dx
    79dd:01c1  - and       byte ptr [si+FE],7F
             WENOTLAB:
    79dd:01c5  - add       si,04
    79dd:01c8  - jmp       WELP2
             WEENDEXP:
    79dd:01ca  - mov       es,word ptr ss:[9A82]
    79dd:01cf  - xor       al,al
    79dd:01d1  - stosb
    79dd:01d2  - mov       dx,si
    79dd:01d4  - mov       bx,si
    79dd:01d6  - pop       si
    79dd:01d7  - sub       bx,si
    79dd:01d9  - add       bx,05
             WEWEPLP:
    79dd:01dc  - lodsb
    79dd:01dd  - stosb
    79dd:01de  - dec       bx
    79dd:01df  - jne       WEWEPLP
    79dd:01e1  - mov       si,dx
    79dd:01e3  - cmp       di,7E00
    79dd:01e7  - jb        WENOTENDBUF
    79dd:01e9  - push      ds
    79dd:01ea  - push      si
    79dd:01eb  - push      cx
    79dd:01ec  - mov       ds,word ptr ss:[9A82]
    79dd:01f1  - xor       dx,dx
    79dd:01f3  - mov       cx,di
    79dd:01f5  - mov       bx,word ptr ss:[0EDD]
    79dd:01fa  - call      far ptr _OS2WRITEBYTES
    79dd:01ff  - pop       cx
    79dd:0200  - pop       si
    79dd:0201  - pop       ds
    79dd:0202  - xor       di,di
             WENOTENDBUF:
    79dd:0204  - add       si,05
    79dd:0207  - cmp       si,3F00
    79dd:020b  - jb        WEOK
    79dd:020d  - xor       si,si
    79dd:020f  - mov       ax,word ptr [si]
    79dd:0211  - mov       ds,ax
    79dd:0213  - mov       si,0002
             WEOK:
    79dd:0216  - dec       word ptr ss:[13AA]
    79dd:021b  - je        0220
    79dd:021d    jmp       WELP
    79dd:0220  - mov       es,word ptr ss:[9A82]
    79dd:0225  - xor       al,al
    79dd:0227  - stosb
    79dd:0228  - mov       ds,word ptr ss:[9A82]
    79dd:022d  - xor       dx,dx
    79dd:022f  - mov       cx,di
    79dd:0231  - mov       bx,word ptr ss:[0EDD]
    79dd:0236  - call      far ptr _OS2WRITEBYTES
    79dd:023b  - ret
             WRITESTR:
    79dd:023c  - push      ds
    79dd:023d  - push      si
    79dd:023e  - push      cx
    79dd:023f  - push      es
    79dd:0240  - mov       ds,word ptr es:[bp+06]
    79dd:0244  - mov       si,word ptr es:[bp+08]
    79dd:0248  - mov       cl,byte ptr es:[bp+05]
    79dd:024c  - mov       es,word ptr ss:[9A82]
             WEWSLP:
    79dd:0251  - lodsb
    79dd:0252  - stosb
    79dd:0253  - dec       cl
    79dd:0255  - jne       WEWSLP
    79dd:0257  - pop       es
    79dd:0258  - pop       cx
    79dd:0259  - pop       si
    79dd:025a  - pop       ds
    79dd:025b  - mov       word ptr [si],cx
    79dd:025d  - inc       cx
    79dd:025e  - jmp       WENOTLAB
             E_EXTNOTDEF:
    79dd:0261  - push      ds
    79dd:0262    push      dx
    79dd:0263    mov       dx,8AC9
    79dd:0266    mov       ds,dx
    79dd:0268    mov       dx,88C4
    79dd:026b    call      far ptr _OS2PRTSTRING
    79dd:0270    pop       dx
    79dd:0271    pop       ds
    79dd:0272  - push      ds
    79dd:0273    push      dx
    79dd:0274    push      si
    79dd:0275    push      ax
    79dd:0276    mov       bx,word ptr es:[bp+06]
    79dd:027a    mov       dx,word ptr es:[bp+08]
    79dd:027e    mov       ds,bx
    79dd:0280    mov       si,dx
    79dd:0282    lodsb
    79dd:0283    or        al,al
    79dd:0285    jne       0282
    79dd:0287    mov       byte ptr [si+FF],24
    79dd:028b    call      far ptr _OS2PRTSTRING
    79dd:0290    mov       byte ptr [si+FF],00
    79dd:0294    pop       ax
    79dd:0295    pop       si
    79dd:0296    pop       dx
    79dd:0297    pop       ds
    79dd:0298  - inc       word ptr ss:[13C4]
    79dd:029d  - jmp       WENOTLAB
             WRITEPUBLICS:
    79dd:02a0  - mov       es,word ptr ss:[9A82]
    79dd:02a5  - xor       di,di
    79dd:02a7  - mov       bx,1472
             WPUBLP:
    79dd:02aa  - mov       ax,word ptr ss:[bx]
    79dd:02ad  - or        ax,ax
    79dd:02af  - je        WPUBNEXT
    79dd:02b1  - mov       ds,ax
    79dd:02b3  - mov       si,word ptr ss:[bx+02]
    79dd:02b7  - push      bx
             WPUBLP2:
    79dd:02b8  - test      byte ptr [si+04],80
    79dd:02bc  - je        WPUBNEXT2
    79dd:02be  - test      byte ptr [si+04],10
    79dd:02c2  - jne       WPUBUNDEF
    79dd:02c4  - push      ds
    79dd:02c5  - push      si
    79dd:02c6  - mov       ax,word ptr [si+06]
    79dd:02c9  - mov       bp,word ptr [si+08]
    79dd:02cc  - mov       cl,byte ptr [si+05]
    79dd:02cf  - mov       si,bp
    79dd:02d1  - mov       ds,ax
             WPWSLP:
    79dd:02d3  - lodsb
    79dd:02d4  - stosb
    79dd:02d5  - dec       cl
    79dd:02d7  - jne       WPWSLP
    79dd:02d9  - pop       si
    79dd:02da  - pop       ds
    79dd:02db  - mov       ax,word ptr [si+0C]
    79dd:02de  - stosw
    79dd:02df  - mov       ax,word ptr [si+0A]
    79dd:02e2  - stosw
    79dd:02e3  - cmp       di,7F00
    79dd:02e7  - jb        WPUBNEXT2
    79dd:02e9  - push      ds
    79dd:02ea  - push      si
    79dd:02eb  - push      bx
    79dd:02ec  - mov       ds,word ptr ss:[9A82]
    79dd:02f1  - xor       dx,dx
    79dd:02f3  - mov       cx,di
    79dd:02f5  - mov       bx,word ptr ss:[0EDD]
    79dd:02fa  - call      far ptr _OS2WRITEBYTES
    79dd:02ff  - pop       bx
    79dd:0300  - pop       si
    79dd:0301  - pop       ds
    79dd:0302  - xor       di,di
             WPUBNEXT2:
    79dd:0304  - mov       ax,word ptr [si]
    79dd:0306  - mov       si,word ptr [si+02]
    79dd:0309  - mov       ds,ax
    79dd:030b  - or        ax,ax
    79dd:030d  - jne       WPUBLP2
    79dd:030f  - pop       bx
             WPUBNEXT:
    79dd:0310  - add       bx,04
    79dd:0313  - cmp       bx,2472
    79dd:0317  - jb        WPUBLP
    79dd:0319  - xor       al,al
    79dd:031b  - stosb
    79dd:031c  - mov       ds,word ptr ss:[9A82]
    79dd:0321  - xor       dx,dx
    79dd:0323  - mov       cx,di
    79dd:0325  - mov       bx,word ptr ss:[0EDD]
    79dd:032a  - call      far ptr _OS2WRITEBYTES
    79dd:032f  - ret
             WPUBUNDEF:
    79dd:0330  - push      es
    79dd:0331  - push      di
    79dd:0332  - push      ds
    79dd:0333  - push      si
    79dd:0334  - push      ds
    79dd:0335    push      dx
    79dd:0336    mov       dx,8AC9
    79dd:0339    mov       ds,dx
    79dd:033b    mov       dx,8899
    79dd:033e    call      far ptr _OS2PRTSTRING
    79dd:0343    pop       dx
    79dd:0344    pop       ds
    79dd:0345  - inc       word ptr ss:[13C4]
    79dd:034a  - pop       si
    79dd:034b  - pop       ds
    79dd:034c  - pop       di
    79dd:034d  - pop       es
    79dd:034e  - push      ds
    79dd:034f    push      dx
    79dd:0350    push      si
    79dd:0351    push      ax
    79dd:0352    mov       bx,word ptr [si+06]
    79dd:0355    mov       dx,word ptr [si+08]
    79dd:0358    mov       ds,bx
    79dd:035a    mov       si,dx
    79dd:035c    lodsb
    79dd:035d    or        al,al
    79dd:035f    jne       035C
    79dd:0361    mov       byte ptr [si+FF],24
    79dd:0365    call      far ptr _OS2PRTSTRING
    79dd:036a    mov       byte ptr [si+FF],00
    79dd:036e    pop       ax
    79dd:036f    pop       si
    79dd:0370    pop       dx
    79dd:0371    pop       ds
    79dd:0372  - jmp       WPUBNEXT2
             WRITEBLOCKS:
    79dd:0374  - mov       ds,word ptr ss:[13B0]
    79dd:0379  - mov       si,word ptr ss:[13B2]
             LINKLOOP:
    79dd:037e  - mov       ax,word ptr [si+0C]
    79dd:0381  - mov       word ptr [13BE],ax
    79dd:0385  - mov       ax,word ptr [si+0E]
    79dd:0388  - mov       word ptr [13BC],ax
    79dd:038c  - push      ds
    79dd:038d    push      si
    79dd:038e    push      dx
    79dd:038f    push      cx
    79dd:0390    mov       ax,8AC9
    79dd:0393    mov       ds,ax
    79dd:0395    mov       dx,13BC
    79dd:0398    mov       cx,0004
    79dd:039b    mov       bx,word ptr ss:[0EDD]
    79dd:03a0    call      far ptr _OS2WRITEBYTES
    79dd:03a5    pop       cx
    79dd:03a6    pop       dx
    79dd:03a7    pop       si
    79dd:03a8    pop       ds
    79dd:03a9  - mov       ax,word ptr [si+04]
    79dd:03ac  - mov       word ptr [13BE],ax
    79dd:03b0  - mov       ax,word ptr [si+06]
    79dd:03b3  - mov       word ptr [13BC],ax
    79dd:03b7  - push      ds
    79dd:03b8    push      si
    79dd:03b9    push      dx
    79dd:03ba    push      cx
    79dd:03bb    mov       ax,8AC9
    79dd:03be    mov       ds,ax
    79dd:03c0    mov       dx,13BC
    79dd:03c3    mov       cx,0004
    79dd:03c6    mov       bx,word ptr ss:[0EDD]
    79dd:03cb    call      far ptr _OS2WRITEBYTES
    79dd:03d0    pop       cx
    79dd:03d1    pop       dx
    79dd:03d2    pop       si
    79dd:03d3    pop       ds
    79dd:03d4  - mov       al,byte ptr [si+10]
    79dd:03d7  - test      al,01
    79dd:03d9  - jne       LINKNORM
    79dd:03db  - test      al,08
    79dd:03dd  - je        03E2
    79dd:03df    jmp       LINKGAP
    79dd:03e2  - test      al,02
    79dd:03e4  - jne       LINKINCBIN
    79dd:03e6  - mov       dx,7E8D
    79dd:03e9    call      FATALERR_ROUT
    79dd:03ec  - jmp       STOPASSEM
             LINKWRITERET:
    79dd:03ef  - inc       word ptr ss:[13A2]
    79dd:03f4  - mov       ax,word ptr [si]
    79dd:03f6  - mov       bx,word ptr [si+02]
    79dd:03f9  - mov       ds,ax
    79dd:03fb  - mov       si,bx
    79dd:03fd  - or        ax,ax
    79dd:03ff  - je        0404
    79dd:0401    jmp       LINKLOOP
    79dd:0404  - ret
             LINKNORM:
    79dd:0405  - mov       word ptr ss:[13BC],0000
    79dd:040c  - push      ds
    79dd:040d    push      si
    79dd:040e    push      dx
    79dd:040f    push      cx
    79dd:0410    mov       ax,8AC9
    79dd:0413    mov       ds,ax
    79dd:0415    mov       dx,13BC
    79dd:0418    mov       cx,0001
    79dd:041b    mov       bx,word ptr ss:[0EDD]
    79dd:0420    call      far ptr _OS2WRITEBYTES
    79dd:0425    pop       cx
    79dd:0426    pop       dx
    79dd:0427    pop       si
    79dd:0428    pop       ds
    79dd:0429  - push      si
    79dd:042a  - mov       cx,word ptr [si+06]
    79dd:042d  - mov       bx,word ptr ss:[0EDD]
    79dd:0432  - mov       dx,si
    79dd:0434  - add       dx,13
    79dd:0437  - call      INT21R
    79dd:043a  - pop       si
    79dd:043b  - jmp       LINKWRITERET
             LINKINCBIN:
    79dd:043d  - mov       word ptr ss:[13BC],0001
    79dd:0444  - push      ds
    79dd:0445    push      si
    79dd:0446    push      dx
    79dd:0447    push      cx
    79dd:0448    mov       ax,8AC9
    79dd:044b    mov       ds,ax
    79dd:044d    mov       dx,13BC
    79dd:0450    mov       cx,0001
    79dd:0453    mov       bx,word ptr ss:[0EDD]
    79dd:0458    call      far ptr _OS2WRITEBYTES
    79dd:045d    pop       cx
    79dd:045e    pop       dx
    79dd:045f    pop       si
    79dd:0460    pop       ds
    79dd:0461  - mov       ax,word ptr [si+11]
    79dd:0464  - mov       word ptr [13BC],ax
    79dd:0468  - push      ds
    79dd:0469    push      si
    79dd:046a    push      dx
    79dd:046b    push      cx
    79dd:046c    mov       ax,8AC9
    79dd:046f    mov       ds,ax
    79dd:0471    mov       dx,13BC
    79dd:0474    mov       cx,0002
    79dd:0477    mov       bx,word ptr ss:[0EDD]
    79dd:047c    call      far ptr _OS2WRITEBYTES
    79dd:0481    pop       cx
    79dd:0482    pop       dx
    79dd:0483    pop       si
    79dd:0484    pop       ds
    79dd:0485  - push      ds
    79dd:0486  - push      si
    79dd:0487  - mov       ax,word ptr [si+08]
    79dd:048a  - mov       dx,word ptr [si+0A]
    79dd:048d  - mov       ds,ax
    79dd:048f  - mov       si,dx
    79dd:0491  - xor       cx,cx
             LILP:
    79dd:0493  - lodsb
    79dd:0494  - inc       cx
    79dd:0495  - or        al,al
    79dd:0497  - jne       LILP
    79dd:0499  - mov       bx,word ptr ss:[0EDD]
    79dd:049e  - call      far ptr _OS2WRITEBYTES
    79dd:04a3  - pop       si
    79dd:04a4  - pop       ds
    79dd:04a5  - jmp       LINKWRITERET
             LINKGAP:
    79dd:04a8  - mov       word ptr ss:[13BC],0000
    79dd:04af  - push      ds
    79dd:04b0    push      si
    79dd:04b1    push      dx
    79dd:04b2    push      cx
    79dd:04b3    mov       ax,8AC9
    79dd:04b6    mov       ds,ax
    79dd:04b8    mov       dx,13BC
    79dd:04bb    mov       cx,0001
    79dd:04be    mov       bx,word ptr ss:[0EDD]
    79dd:04c3    call      far ptr _OS2WRITEBYTES
    79dd:04c8    pop       cx
    79dd:04c9    pop       dx
    79dd:04ca    pop       si
    79dd:04cb    pop       ds
    79dd:04cc  - mov       bx,word ptr [si+04]
    79dd:04cf  - mov       cx,word ptr [si+06]
    79dd:04d2  - call      SENDGAP
    79dd:04d5  - jmp       LINKWRITERET
             INT21R:
    79dd:04d8  - cmp       byte ptr ss:[2498],00
    79dd:04de  - je        DONTWRITE
    79dd:04e0  - push      dx
    79dd:04e1  - push      ds
    79dd:04e2  - push      bx
    79dd:04e3  - call      far ptr _OS2WRITEBYTES
    79dd:04e8  - pop       bx
    79dd:04e9  - pop       ds
    79dd:04ea  - pop       dx
             DONTWRITE:
    79dd:04eb  - ret
             WRITESYMBOLS:
    79dd:04ec  - mov       al,byte ptr [13F8]
    79dd:04f0  - or        al,al
    79dd:04f2  - jne       DOWSYM
    79dd:04f4  - ret
             DOWSYM:
    79dd:04f5  - mov       ax,ss
    79dd:04f7  - mov       ds,ax
    79dd:04f9  - mov       dx,9B5C
    79dd:04fc  - xor       cx,cx
    79dd:04fe  - call      far ptr _OS2OPENNEWFILE
    79dd:0503  - mov       word ptr [0EDD],ax
    79dd:0507  - jae       SDISKOK
    79dd:0509  - call      NEEDCR
    79dd:050c  - push      ds
    79dd:050d    push      dx
    79dd:050e    mov       dx,8AC9
    79dd:0511    mov       ds,dx
    79dd:0513    mov       dx,891C
    79dd:0516    call      far ptr _OS2PRTSTRING
    79dd:051b    pop       dx
    79dd:051c    pop       ds
    79dd:051d  - ret
             SDISKOK:
    79dd:051e  - mov       bx,1472
             SYMLP:
    79dd:0521  - mov       ax,word ptr ss:[bx]
    79dd:0524  - or        ax,ax
    79dd:0526  - je        SYMNEXT
    79dd:0528  - mov       es,ax
    79dd:052a  - mov       di,word ptr ss:[bx+02]
    79dd:052e  - push      bx
             SYMLP2:
    79dd:052f  - test      byte ptr es:[di+04],5E
    79dd:0534  - jne       SYMNEXT2
    79dd:0536  - push      es
    79dd:0537  - push      di
    79dd:0538  - mov       ds,word ptr es:[di+06]
    79dd:053c  - mov       dx,word ptr es:[di+08]
    79dd:0540  - mov       cl,byte ptr es:[di+05]
    79dd:0544  - dec       cl
    79dd:0546  - xor       ch,ch
    79dd:0548  - mov       bx,word ptr ss:[0EDD]
    79dd:054d  - call      far ptr _OS2WRITEBYTES
    79dd:0552  - mov       dx,word ptr es:[di+0A]
    79dd:0556  - mov       cx,word ptr es:[di+0C]
    79dd:055a  - mov       ax,ss
    79dd:055c  - mov       es,ax
    79dd:055e  - mov       di,8A6E
    79dd:0561  - mov       ax,2409
    79dd:0564  - stosw
    79dd:0565  - call      BIN2HEXL
    79dd:0568  - mov       ax,0A0D
    79dd:056b  - stosw
    79dd:056c  - push      ds
    79dd:056d    push      si
    79dd:056e    push      dx
    79dd:056f    push      cx
    79dd:0570    mov       ax,8AC9
    79dd:0573    mov       ds,ax
    79dd:0575    mov       dx,8A6E
    79dd:0578    mov       cx,000C
    79dd:057b    mov       bx,word ptr ss:[0EDD]
    79dd:0580    call      far ptr _OS2WRITEBYTES
    79dd:0585    pop       cx
    79dd:0586    pop       dx
    79dd:0587    pop       si
    79dd:0588    pop       ds
    79dd:0589    pop       di
    79dd:058a  - pop       es
             SYMNEXT2:
    79dd:058b  - mov       ax,word ptr es:[di]
    79dd:058e  - mov       di,word ptr es:[di+02]
    79dd:0592  - mov       es,ax
    79dd:0594  - or        ax,ax
    79dd:0596  - jne       SYMLP2
    79dd:0598  - pop       bx
             SYMNEXT:
    79dd:0599  - add       bx,04
    79dd:059c  - cmp       bx,2472
    79dd:05a0  - jae       05A5
    79dd:05a2    jmp       SYMLP
    79dd:05a5  - mov       bx,word ptr ss:[0EDD]
    79dd:05aa  - call      far ptr _OS2CLOSEFILE
    79dd:05af  - ret
    79dd:05b0  - mov       word ptr ss:[9A90],bx
    79dd:05b5  - mov       word ptr ss:[9A92],cx
    79dd:05ba  - push      ds
    79dd:05bb  - push      si
    79dd:05bc  - mov       dx,word ptr [si+11]
    79dd:05bf  - push      dx
    79dd:05c0  - mov       ax,word ptr [si+08]
    79dd:05c3  - mov       word ptr [0F98],ax
    79dd:05c7  - mov       dx,word ptr [si+0A]
    79dd:05ca  - mov       word ptr ss:[0F9A],dx
    79dd:05cf  - mov       ds,ax
    79dd:05d1  - call      far ptr _OS2OPENFILE
    79dd:05d6  - mov       word ptr [9A84],ax
    79dd:05da  - pop       dx
    79dd:05db  - jae       05E0
    79dd:05dd    jmp       SINCERROR
    79dd:05e0  - xor       cx,cx
    79dd:05e2  - or        dx,dx
    79dd:05e4  - je        SINC
    79dd:05e6  - mov       bx,word ptr ss:[9A84]
    79dd:05eb  - call      far ptr _OS2SEEKFILE
             SINC:
    79dd:05f0  - cmp       word ptr ss:[9A90],00
    79dd:05f6  - je        NOBX
             LOTSCX:
    79dd:05f8  - mov       bx,word ptr ss:[9A84]
    79dd:05fd  - mov       ds,word ptr ss:[9A82]
    79dd:0602  - xor       dx,dx
    79dd:0604  - mov       cx,8000
    79dd:0607  - sub       word ptr ss:[9A92],cx
    79dd:060c  - sbb       word ptr ss:[9A90],00
    79dd:0612  - call      far ptr _OS2READBYTES
    79dd:0617  - push      ax
    79dd:0618  - mov       cx,8000
    79dd:061b  - mov       ds,word ptr ss:[9A82]
    79dd:0620  - xor       dx,dx
    79dd:0622  - mov       bx,word ptr ss:[0EDD]
    79dd:0627  - call      INT21R
    79dd:062a  - pop       ax
    79dd:062b  - jmp       SINC
             NOBX:
    79dd:062d  - cmp       word ptr ss:[9A92],8000
    79dd:0634  - jae       LOTSCX
    79dd:0636  - mov       bx,word ptr ss:[9A84]
    79dd:063b  - mov       ds,word ptr ss:[9A82]
    79dd:0640  - xor       dx,dx
    79dd:0642  - mov       cx,word ptr ss:[9A92]
    79dd:0647  - call      far ptr _OS2READBYTES
    79dd:064c  - mov       cx,word ptr ss:[9A92]
    79dd:0651  - mov       ds,word ptr ss:[9A82]
    79dd:0656  - xor       dx,dx
    79dd:0658  - mov       bx,word ptr ss:[0EDD]
    79dd:065d  - call      INT21R
    79dd:0660  - mov       bx,word ptr ss:[9A84]
    79dd:0665  - call      far ptr _OS2CLOSEFILE
    79dd:066a  - pop       si
    79dd:066b  - pop       ds
    79dd:066c  - ret
             SINCERROR:
    79dd:066d  - mov       dx,80FF
    79dd:0670    call      FATALERR_ROUT
    79dd:0673  - jmp       STOPASSEM
             SENDGAP:
    79dd:0676    push      ds
    79dd:0677  - push      si
    79dd:0678  - mov       ax,86C9
    79dd:067b  - mov       ds,ax
             GAPLOOP:
    79dd:067d  - sub       cx,4000
    79dd:0681  - sbb       bx,00
    79dd:0684  - js        GAPLAST
    79dd:0686  - push      bx
    79dd:0687  - push      cx
    79dd:0688  - mov       dx,0000
    79dd:068b  - mov       bx,word ptr ss:[0EDD]
    79dd:0690  - mov       cx,4000
    79dd:0693  - call      INT21R
    79dd:0696  - pop       cx
    79dd:0697  - pop       bx
    79dd:0698  - jmp       GAPLOOP
             GAPLAST:
    79dd:069a  - add       cx,4000
    79dd:069e  - mov       dx,0000
    79dd:06a1  - mov       bx,word ptr ss:[0EDD]
    79dd:06a6  - call      INT21R
    79dd:06a9  - pop       si
    79dd:06aa  - pop       ds
    79dd:06ab  - ret
             DO_END:
    79dd:06ac  - mov       bx,word ptr ss:[13F6]
    79dd:06b1  - call      far ptr _OS2CLOSEFILE
    79dd:06b6  - mov       bx,word ptr ss:[2476]
    79dd:06bb  - call      far ptr _OS2CLOSEFILE
    79dd:06c0  - mov       ax,ss
    79dd:06c2  - mov       ds,ax
    79dd:06c4  - mov       si,261F
    79dd:06c7  - call      P_PRINTF2
    79dd:06ca  - ret
             EVAL_FRS:
    79dd:06cb  - mov       word ptr ss:[2474],0000
    79dd:06d2  - mov       byte ptr ss:[0AD0],01
    79dd:06d8  - mov       byte ptr ss:[0ACD],00
    79dd:06de  - mov       byte ptr ss:[0F8A],01
    79dd:06e4  - mov       word ptr ss:[0AA6],0000
    79dd:06eb  - mov       es,word ptr ss:[0AC5]
    79dd:06f0  - mov       di,word ptr ss:[0AC7]
    79dd:06f5  - mov       word ptr es:[di],4321
    79dd:06fa  - mov       word ptr ss:[9A90],di
    79dd:06ff  - mov       ds,word ptr ss:[0ACB]
    79dd:0704  - mov       si,0002
             INSFRLP:
    79dd:0707  - cmp       word ptr [si],4321
    79dd:070b  - je        INSFREXIT
             NOTEX:
    79dd:070d  - mov       word ptr ss:[A49D],si
    79dd:0712  - call      FREXPRESS
    79dd:0715  - jne       INSFRERR
    79dd:0717  - mov       bp,word ptr [si+02]
    79dd:071a  - mov       es,word ptr [si+04]
    79dd:071d  - mov       di,word ptr [si+06]
    79dd:0720  - call      word ptr [bp+7407]
             NEXTFR:
    79dd:0724  - add       si,15
    79dd:0727  - cmp       si,7F00
    79dd:072b  - jb        INSFRLP
    79dd:072d  - xor       si,si
    79dd:072f  - mov       ax,word ptr [si]
    79dd:0731  - mov       ds,ax
    79dd:0733  - inc       si
    79dd:0734  - inc       si
    79dd:0735  - jmp       INSFRLP
             INSFREXIT:
    79dd:0737  - cmp       si,word ptr ss:[9A90]
    79dd:073c  - jne       NOTEX
    79dd:073e  - ret
             INSFRERR:
    79dd:073f  - mov       es,word ptr ss:[9A8C]
    79dd:0744  - mov       bp,word ptr ss:[9A8E]
    79dd:0749  - test      byte ptr es:[bp+04],40
    79dd:074e  - jne       EXTNEXTFR
    79dd:0750  - mov       byte ptr ss:[0ACD],01
    79dd:0756  - push      dx
    79dd:0757    mov       dx,8886
    79dd:075a    call      INSFRERR1
    79dd:075d    pop       dx
    79dd:075e  - mov       byte ptr ss:[0ACD],00
    79dd:0764  - mov       ax,word ptr [13C4]
    79dd:0768  - cmp       ax,word ptr ss:[13FD]
    79dd:076d  - jb        IFRE0
    79dd:076f  - mov       dx,7EB4
    79dd:0772    call      FATALERR_ROUT
    79dd:0775  - jmp       STOPASSEM
             IFRE0:
    79dd:0778    jmp       NEXTFR
             EXTNEXTFR:
    79dd:077a  - push      es
    79dd:077b  - push      di
    79dd:077c  - push      bp
    79dd:077d  - mov       si,word ptr ss:[A49D]
    79dd:0782  - mov       es,word ptr ss:[13A6]
    79dd:0787  - mov       di,word ptr ss:[13A8]
    79dd:078c  - xor       ax,ax
    79dd:078e  - stosw
    79dd:078f  - movsw
    79dd:0790  - jmp       ENF2
             ENF0:
    79dd:0792  - lodsw
    79dd:0793  - stosw
    79dd:0794  - or        ax,ax
    79dd:0796  - je        ENF1
             ENF2:
    79dd:0798  - movsw
    79dd:0799  - movsw
    79dd:079a  - jmp       ENF0
             ENF1:
    79dd:079c  - mov       ax,word ptr [si+11]
    79dd:079f  - stosw
    79dd:07a0  - mov       ax,word ptr [si+13]
    79dd:07a3  - stosw
    79dd:07a4  - mov       al,byte ptr [si+02]
    79dd:07a7  - stosb
    79dd:07a8  - mov       bp,word ptr ss:[13A8]
    79dd:07ad  - mov       ax,word ptr [si+08]
    79dd:07b0  - mov       word ptr es:[bp+00],ax
    79dd:07b4  - mov       word ptr ss:[13A8],di
    79dd:07b9  - inc       word ptr ss:[13AA]
    79dd:07be  - cmp       di,3F00
    79dd:07c2    jb        07C7
    79dd:07c4    call      MOREEXT
    79dd:07c7  - pop       bp
    79dd:07c8  - pop       di
    79dd:07c9  - pop       es
    79dd:07ca  - jmp       NEXTFR
             INSFRERR1:
    79dd:07cd  - lodsw
    79dd:07ce  - cmp       ax,FFFE
    79dd:07d1  - jne       INSFRERR1
    79dd:07d3  - dec       si
    79dd:07d4  - dec       si
    79dd:07d5  - push      ds
    79dd:07d6  - push      es
    79dd:07d7  - push      ax
    79dd:07d8  - push      di
    79dd:07d9  - push      si
    79dd:07da  - mov       ax,word ptr [si+08]
    79dd:07dd  - mov       word ptr [13F0],ax
    79dd:07e1  - mov       ax,word ptr [0ED9]
    79dd:07e5  - mov       word ptr [0F98],ax
    79dd:07e9  - mov       ax,word ptr [si+0E]
    79dd:07ec  - mov       word ptr [0F9A],ax
    79dd:07f0  - mov       al,byte ptr [0EE1]
    79dd:07f4  - or        al,al
    79dd:07f6  - je        ERROK3
    79dd:07f8  - mov       dx,7CF5
    79dd:07fb    call      FATALERR_ROUT
    79dd:07fe  - jmp       STOPASSEM
             ERROK3:
    79dd:0801  - call      NEEDCR
    79dd:0804  - mov       si,dx
    79dd:0806  - inc       dx
    79dd:0807  - mov       al,byte ptr ss:[si]
    79dd:080a  - or        al,al
    79dd:080c  - je        ERRORT2
    79dd:080e  - mov       cx,8A5A
    79dd:0811  - inc       word ptr ss:[13C6]
    79dd:0816  - jmp       DONEEW2
             ERRORT2:
    79dd:0818  - mov       cx,8A54
    79dd:081b  - inc       word ptr ss:[13C4]
             DONEEW2:
    79dd:0820  - mov       al,byte ptr [13E9]
    79dd:0824  - or        al,al
    79dd:0826  - jne       ERRSUPDO2
    79dd:0828  - mov       word ptr ss:[13DE],cx
    79dd:082d  - mov       word ptr ss:[13E0],dx
    79dd:0832  - mov       ax,ss
    79dd:0834  - mov       ds,ax
    79dd:0836  - mov       si,2557
    79dd:0839  - mov       byte ptr ss:[0EE1],01
    79dd:083f  - call      P_PRINTF2
    79dd:0842  - mov       byte ptr ss:[0EE1],00
             ERRSUPDO2:
    79dd:0848  - pop       si
    79dd:0849  - pop       di
    79dd:084a  - pop       ax
    79dd:084b  - pop       es
    79dd:084c  - pop       ds
    79dd:084d  - ret
             FR_DOBYTE:
    79dd:084e  - or        dx,dx
    79dd:0850  - je        DFRB1
    79dd:0852  - cmp       dx,FF
    79dd:0855  - jne       FRBERR
    79dd:0857  - cmp       ch,FF
    79dd:085a  - jne       FRBERR
    79dd:085c  - or        cl,cl
    79dd:085e  - jns       FRBERR
    79dd:0860  - mov       byte ptr es:[di+01],cl
    79dd:0864  - ret
             FRBERR:
    79dd:0865  - push      dx
    79dd:0866    mov       dx,7F28
    79dd:0869    call      INSFRERR1
    79dd:086c    pop       dx
    79dd:086d  - ret
             DFRB1:
    79dd:086e  - or        ch,ch
    79dd:0870  - jne       FRBERR
    79dd:0872  - mov       byte ptr es:[di+01],cl
    79dd:0876  - ret
             FR_DODBYTE:
    79dd:0877  - or        dx,dx
    79dd:0879  - je        DDFRB1
    79dd:087b  - cmp       dx,FF
    79dd:087e  - jne       FRBERR
    79dd:0880  - cmp       ch,FF
    79dd:0883  - jne       FRBERR
    79dd:0885  - or        cl,cl
    79dd:0887  - jns       FRBERR
    79dd:0889  - mov       byte ptr es:[di],cl
    79dd:088c  - ret
             DDFRB1:
    79dd:088d  - or        ch,ch
    79dd:088f  - jne       FRBERR
    79dd:0891  - mov       byte ptr es:[di],cl
    79dd:0894  - ret
             FR_DOWORD:
    79dd:0895  - or        dx,dx
    79dd:0897  - je        DFRW2
    79dd:0899  - cmp       dx,FF
    79dd:089c  - jne       FRWERR
    79dd:089e  - or        cx,cx
    79dd:08a0  - jns       FRWERR
             DFRW2:
    79dd:08a2  - mov       word ptr es:[di+01],cx
    79dd:08a6  - ret
             FRWERR:
    79dd:08a7  - push      dx
    79dd:08a8    mov       dx,7F37
    79dd:08ab    call      INSFRERR1
    79dd:08ae    pop       dx
    79dd:08af  - jmp       DFRW2
             FR_DODWORD:
    79dd:08b1  - or        dx,dx
    79dd:08b3  - je        DDFRW2
    79dd:08b5  - cmp       dx,FF
    79dd:08b8  - jne       FRWERR
    79dd:08ba  - or        cx,cx
    79dd:08bc  - jns       FRWERR
             DDFRW2:
    79dd:08be  - mov       word ptr es:[di],cx
    79dd:08c1  - ret
             FR_DOLONG:
    79dd:08c2  - mov       word ptr es:[di+01],cx
    79dd:08c6  - mov       byte ptr es:[di+03],dl
    79dd:08ca  - ret
             FR_DOJMWORD:
    79dd:08cb  - mov       al,byte ptr [si+0A]
    79dd:08ce  - cmp       dl,al
    79dd:08d0  - jne       FRBANKERR
    79dd:08d2  - mov       word ptr es:[di+01],cx
    79dd:08d6  - ret
             FRBANKERR:
    79dd:08d7  - push      dx
    79dd:08d8    mov       dx,85DD
    79dd:08db    call      INSFRERR1
    79dd:08de    pop       dx
    79dd:08df  - ret
             FR_DOJMIDXWORD:
    79dd:08e0  - mov       word ptr es:[di+01],cx
    79dd:08e4  - ret
             FR_DOBRANCH:
    79dd:08e5  - sub       dx,word ptr [si+0A]
    79dd:08e8  - jne       FRBCCERR
    79dd:08ea  - sub       cx,word ptr [si+0C]
    79dd:08ed  - sub       cx,02
    79dd:08f0  - cmp       cx,80
    79dd:08f3  - jl        FRBCCERR
    79dd:08f5  - cmp       cx,7F
    79dd:08f8  - jg        FRBCCERR
    79dd:08fa  - mov       byte ptr es:[di+01],cl
    79dd:08fe  - ret
             FRBCCERR:
    79dd:08ff  - push      dx
    79dd:0900    mov       dx,7F46
    79dd:0903    call      INSFRERR1
    79dd:0906    pop       dx
    79dd:0907  - ret
             FR_DOLBRANCH:
    79dd:0908  - sub       cx,word ptr [si+0C]
    79dd:090b  - sbb       dx,word ptr [si+0A]
    79dd:090e  - sub       cx,03
    79dd:0911  - sbb       dx,00
    79dd:0914  - js        FRBRLMIN
    79dd:0916  - jne       FRBCCERR
    79dd:0918  - cmp       cx,7FFF
    79dd:091c  - jg        FRBCCERR
             FRSETBRL:
    79dd:091e  - mov       word ptr es:[di+01],cx
    79dd:0922  - ret
             FRBRLMIN:
    79dd:0923  - cmp       dx,FF
    79dd:0926  - jne       FRBCCERR
    79dd:0928  - cmp       cx,8000
    79dd:092c  - jl        FRBCCERR
    79dd:092e  - jmp       FRSETBRL
             FR_DONIBBLE:
    79dd:0930  - cmp       dx,00
    79dd:0933  - jne       DFRNERR
    79dd:0935  - cmp       cx,0F
    79dd:0938  - jg        DFRNERR
    79dd:093a  - or        byte ptr es:[di+01],cl
    79dd:093e  - ret
             DFRNERR:
    79dd:093f  - push      dx
    79dd:0940    mov       dx,8251
    79dd:0943    call      INSFRERR1
    79dd:0946    pop       dx
    79dd:0947  - ret
             FR_DOLMS:
    79dd:0948  - or        cx,cx
    79dd:094a  - jns       094F
    79dd:094c    jmp       FRBERR
    79dd:094f  - cmp       cx,0200
    79dd:0953  - jb        0958
    79dd:0955    jmp       FRBERR
    79dd:0958  - shr       cx,1
    79dd:095a  - mov       word ptr es:[di+01],cx
    79dd:095e  - ret
             CONVEXPRESS:
    79dd:095f  - mov       word ptr ss:[A49F],di
    79dd:0964  - push      bx
    79dd:0965  - push      es
    79dd:0966  - push      di
    79dd:0967  - mov       es,word ptr ss:[0AC5]
    79dd:096c  - mov       di,word ptr ss:[0AC7]
    79dd:0971  - xor       ax,ax
    79dd:0973  - stosw
    79dd:0974  - mov       byte ptr [0ACF],al
    79dd:0978  - mov       byte ptr [0ACE],al
             EXPLOOP:
    79dd:097c  - xor       ah,ah
    79dd:097e  - lodsb
    79dd:097f  - mov       bp,ax
    79dd:0981  - add       bp,bp
    79dd:0983  - jmp       word ptr [bp+6A29]
             NUM0:
    79dd:0987  - mov       bx,741D
    79dd:098a  - mov       dx,si
             NUM0LP:
    79dd:098c  - lodsb
    79dd:098d  - xlat
    79dd:098f  - or        al,al
    79dd:0991  - jns       NUM0LP
    79dd:0993  - mov       al,byte ptr [si+FE]
    79dd:0996  - mov       si,dx
    79dd:0998  - and       al,DF
    79dd:099a  - cmp       al,48
    79dd:099c  - je        NUMHEX
    79dd:099e    jmp       NUM0DEC
             NUMHEX:
    79dd:09a1  - mov       bx,749F
    79dd:09a4  - xor       cx,cx
    79dd:09a6  - xor       dx,dx
             HEXLP:
    79dd:09a8  - lodsb
    79dd:09a9  - cmp       al,30
    79dd:09ab  - je        HEXLP
    79dd:09ad  - xlat
    79dd:09af  - or        al,al
    79dd:09b1  - jns       09B6
    79dd:09b3    jmp       ENDHEX
    79dd:09b6  - add       cx,cx
    79dd:09b8    adc       dx,dx
    79dd:09ba    add       cx,cx
    79dd:09bc    adc       dx,dx
    79dd:09be    add       cx,cx
    79dd:09c0    adc       dx,dx
    79dd:09c2    add       cx,cx
    79dd:09c4    adc       dx,dx
    79dd:09c6    or        cl,al
    79dd:09c8    lodsb
    79dd:09c9    xlat
    79dd:09cb    or        al,al
    79dd:09cd    jns       09D2
    79dd:09cf    jmp       ENDHEX
    79dd:09d2    add       cx,cx
    79dd:09d4    adc       dx,dx
    79dd:09d6    add       cx,cx
    79dd:09d8    adc       dx,dx
    79dd:09da    add       cx,cx
    79dd:09dc    adc       dx,dx
    79dd:09de    add       cx,cx
    79dd:09e0    adc       dx,dx
    79dd:09e2    or        cl,al
    79dd:09e4    lodsb
    79dd:09e5    xlat
    79dd:09e7    or        al,al
    79dd:09e9    jns       09EE
    79dd:09eb    jmp       ENDHEX
    79dd:09ee    add       cx,cx
    79dd:09f0    adc       dx,dx
    79dd:09f2    add       cx,cx
    79dd:09f4    adc       dx,dx
    79dd:09f6    add       cx,cx
    79dd:09f8    adc       dx,dx
    79dd:09fa    add       cx,cx
    79dd:09fc    adc       dx,dx
    79dd:09fe    or        cl,al
    79dd:0a00    lodsb
    79dd:0a01    xlat
    79dd:0a03    or        al,al
    79dd:0a05    jns       0A0A
    79dd:0a07    jmp       ENDHEX
    79dd:0a0a    add       cx,cx
    79dd:0a0c    adc       dx,dx
    79dd:0a0e    add       cx,cx
    79dd:0a10    adc       dx,dx
    79dd:0a12    add       cx,cx
    79dd:0a14    adc       dx,dx
    79dd:0a16    add       cx,cx
    79dd:0a18    adc       dx,dx
    79dd:0a1a    or        cl,al
    79dd:0a1c    lodsb
    79dd:0a1d    xlat
    79dd:0a1f    or        al,al
    79dd:0a21    jns       0A26
    79dd:0a23    jmp       ENDHEX
    79dd:0a26    add       cx,cx
    79dd:0a28    adc       dx,dx
    79dd:0a2a    add       cx,cx
    79dd:0a2c    adc       dx,dx
    79dd:0a2e    add       cx,cx
    79dd:0a30    adc       dx,dx
    79dd:0a32    add       cx,cx
    79dd:0a34    adc       dx,dx
    79dd:0a36    or        cl,al
    79dd:0a38    lodsb
    79dd:0a39    xlat
    79dd:0a3b    or        al,al
    79dd:0a3d    jns       0A42
    79dd:0a3f    jmp       ENDHEX
    79dd:0a42    add       cx,cx
    79dd:0a44    adc       dx,dx
    79dd:0a46    add       cx,cx
    79dd:0a48    adc       dx,dx
    79dd:0a4a    add       cx,cx
    79dd:0a4c    adc       dx,dx
    79dd:0a4e    add       cx,cx
    79dd:0a50    adc       dx,dx
    79dd:0a52    or        cl,al
    79dd:0a54    lodsb
    79dd:0a55    xlat
    79dd:0a57    or        al,al
    79dd:0a59    js        ENDHEX
    79dd:0a5b    add       cx,cx
    79dd:0a5d    adc       dx,dx
    79dd:0a5f    add       cx,cx
    79dd:0a61    adc       dx,dx
    79dd:0a63    add       cx,cx
    79dd:0a65    adc       dx,dx
    79dd:0a67    add       cx,cx
    79dd:0a69    adc       dx,dx
    79dd:0a6b    or        cl,al
    79dd:0a6d    lodsb
    79dd:0a6e    xlat
    79dd:0a70    or        al,al
    79dd:0a72    js        ENDHEX
    79dd:0a74    add       cx,cx
    79dd:0a76    adc       dx,dx
    79dd:0a78    add       cx,cx
    79dd:0a7a    adc       dx,dx
    79dd:0a7c    add       cx,cx
    79dd:0a7e    adc       dx,dx
    79dd:0a80    add       cx,cx
    79dd:0a82    adc       dx,dx
    79dd:0a84    or        cl,al
    79dd:0a86    lodsb
    79dd:0a87    xlat
    79dd:0a89    or        al,al
    79dd:0a8b    js        ENDHEX
    79dd:0a8d    add       cx,cx
    79dd:0a8f    adc       dx,dx
    79dd:0a91    add       cx,cx
    79dd:0a93    adc       dx,dx
    79dd:0a95    add       cx,cx
    79dd:0a97    adc       dx,dx
    79dd:0a99    add       cx,cx
    79dd:0a9b    adc       dx,dx
    79dd:0a9d    or        cl,al
    79dd:0a9f    lodsb
    79dd:0aa0    xlat
    79dd:0aa2    or        al,al
    79dd:0aa4    js        ENDHEX
    79dd:0aa6    add       cx,cx
    79dd:0aa8    adc       dx,dx
    79dd:0aaa    add       cx,cx
    79dd:0aac    adc       dx,dx
    79dd:0aae    add       cx,cx
    79dd:0ab0    adc       dx,dx
    79dd:0ab2    add       cx,cx
    79dd:0ab4    adc       dx,dx
    79dd:0ab6    or        cl,al
    79dd:0ab8    lodsb
    79dd:0ab9    xlat
    79dd:0abb    or        al,al
    79dd:0abd    js        ENDHEX
    79dd:0abf  - dec       si
    79dd:0ac0  - push      dx
    79dd:0ac1    mov       dx,844E
    79dd:0ac4    call      ERROR_ROUT
    79dd:0ac7    pop       dx
             ENDHEX:
    79dd:0ac8    mov       al,byte ptr [si+FF]
    79dd:0acb  - and       al,DF
    79dd:0acd  - cmp       al,48
    79dd:0acf  - je        0AD4
    79dd:0ad1    jmp       NUMOUT
    79dd:0ad4  - inc       si
    79dd:0ad5  - jmp       NUMOUT
             NUM0DEC:
    79dd:0ad8  - cmp       al,42
    79dd:0ada  - jne       0ADF
    79dd:0adc    jmp       NUM0BIN
    79dd:0adf  - lodsb
             NUMDEC:
    79dd:0ae0  - mov       bx,7521
    79dd:0ae3  - push      si
    79dd:0ae4  - push      di
    79dd:0ae5  - xor       cx,cx
    79dd:0ae7  - xor       dx,dx
    79dd:0ae9  - xlat
    79dd:0aeb    or        al,al
    79dd:0aed    jns       0AF2
    79dd:0aef    jmp       ENDDEC
    79dd:0af2    add       cx,cx
    79dd:0af4    adc       dx,dx
    79dd:0af6    mov       bp,cx
    79dd:0af8    mov       di,dx
    79dd:0afa    add       cx,cx
    79dd:0afc    adc       dx,dx
    79dd:0afe    add       cx,cx
    79dd:0b00    adc       dx,dx
    79dd:0b02    add       cx,bp
    79dd:0b04    adc       dx,di
    79dd:0b06    add       cx,ax
    79dd:0b08    adc       dx,00
    79dd:0b0b    lodsb
    79dd:0b0c    xlat
    79dd:0b0e    or        al,al
    79dd:0b10    jns       0B15
    79dd:0b12    jmp       ENDDEC
    79dd:0b15    add       cx,cx
    79dd:0b17    adc       dx,dx
    79dd:0b19    mov       bp,cx
    79dd:0b1b    mov       di,dx
    79dd:0b1d    add       cx,cx
    79dd:0b1f    adc       dx,dx
    79dd:0b21    add       cx,cx
    79dd:0b23    adc       dx,dx
    79dd:0b25    add       cx,bp
    79dd:0b27    adc       dx,di
    79dd:0b29    add       cx,ax
    79dd:0b2b    adc       dx,00
    79dd:0b2e    lodsb
    79dd:0b2f    xlat
    79dd:0b31    or        al,al
    79dd:0b33    jns       0B38
    79dd:0b35    jmp       ENDDEC
    79dd:0b38    add       cx,cx
    79dd:0b3a    adc       dx,dx
    79dd:0b3c    mov       bp,cx
    79dd:0b3e    mov       di,dx
    79dd:0b40    add       cx,cx
    79dd:0b42    adc       dx,dx
    79dd:0b44    add       cx,cx
    79dd:0b46    adc       dx,dx
    79dd:0b48    add       cx,bp
    79dd:0b4a    adc       dx,di
    79dd:0b4c    add       cx,ax
    79dd:0b4e    adc       dx,00
    79dd:0b51    lodsb
    79dd:0b52    xlat
    79dd:0b54    or        al,al
    79dd:0b56    jns       0B5B
    79dd:0b58    jmp       ENDDEC
    79dd:0b5b    add       cx,cx
    79dd:0b5d    adc       dx,dx
    79dd:0b5f    mov       bp,cx
    79dd:0b61    mov       di,dx
    79dd:0b63    add       cx,cx
    79dd:0b65    adc       dx,dx
    79dd:0b67    add       cx,cx
    79dd:0b69    adc       dx,dx
    79dd:0b6b    add       cx,bp
    79dd:0b6d    adc       dx,di
    79dd:0b6f    add       cx,ax
    79dd:0b71    adc       dx,00
    79dd:0b74    lodsb
    79dd:0b75    xlat
    79dd:0b77    or        al,al
    79dd:0b79    jns       0B7E
    79dd:0b7b    jmp       ENDDEC
    79dd:0b7e    add       cx,cx
    79dd:0b80    adc       dx,dx
    79dd:0b82    mov       bp,cx
    79dd:0b84    mov       di,dx
    79dd:0b86    add       cx,cx
    79dd:0b88    adc       dx,dx
    79dd:0b8a    add       cx,cx
    79dd:0b8c    adc       dx,dx
    79dd:0b8e    add       cx,bp
    79dd:0b90    adc       dx,di
    79dd:0b92    add       cx,ax
    79dd:0b94    adc       dx,00
    79dd:0b97    lodsb
    79dd:0b98    xlat
    79dd:0b9a    or        al,al
    79dd:0b9c    jns       0BA1
    79dd:0b9e    jmp       ENDDEC
    79dd:0ba1    add       cx,cx
    79dd:0ba3    adc       dx,dx
    79dd:0ba5    mov       bp,cx
    79dd:0ba7    mov       di,dx
    79dd:0ba9    add       cx,cx
    79dd:0bab    adc       dx,dx
    79dd:0bad    add       cx,cx
    79dd:0baf    adc       dx,dx
    79dd:0bb1    add       cx,bp
    79dd:0bb3    adc       dx,di
    79dd:0bb5    add       cx,ax
    79dd:0bb7    adc       dx,00
    79dd:0bba    lodsb
    79dd:0bbb    xlat
    79dd:0bbd    or        al,al
    79dd:0bbf    jns       0BC4
    79dd:0bc1    jmp       ENDDEC
    79dd:0bc4    add       cx,cx
    79dd:0bc6    adc       dx,dx
    79dd:0bc8    mov       bp,cx
    79dd:0bca    mov       di,dx
    79dd:0bcc    add       cx,cx
    79dd:0bce    adc       dx,dx
    79dd:0bd0    add       cx,cx
    79dd:0bd2    adc       dx,dx
    79dd:0bd4    add       cx,bp
    79dd:0bd6    adc       dx,di
    79dd:0bd8    add       cx,ax
    79dd:0bda    adc       dx,00
    79dd:0bdd    lodsb
    79dd:0bde    xlat
    79dd:0be0    or        al,al
    79dd:0be2    jns       0BE7
    79dd:0be4    jmp       ENDDEC
    79dd:0be7    add       cx,cx
    79dd:0be9    adc       dx,dx
    79dd:0beb    mov       bp,cx
    79dd:0bed    mov       di,dx
    79dd:0bef    add       cx,cx
    79dd:0bf1    adc       dx,dx
    79dd:0bf3    add       cx,cx
    79dd:0bf5    adc       dx,dx
    79dd:0bf7    add       cx,bp
    79dd:0bf9    adc       dx,di
    79dd:0bfb    add       cx,ax
    79dd:0bfd    adc       dx,00
    79dd:0c00    lodsb
    79dd:0c01    xlat
    79dd:0c03    or        al,al
    79dd:0c05    jns       0C0A
    79dd:0c07    jmp       ENDDEC
    79dd:0c0a    add       cx,cx
    79dd:0c0c    adc       dx,dx
    79dd:0c0e    mov       bp,cx
    79dd:0c10    mov       di,dx
    79dd:0c12    add       cx,cx
    79dd:0c14    adc       dx,dx
    79dd:0c16    add       cx,cx
    79dd:0c18    adc       dx,dx
    79dd:0c1a    add       cx,bp
    79dd:0c1c    adc       dx,di
    79dd:0c1e    add       cx,ax
    79dd:0c20    adc       dx,00
    79dd:0c23    lodsb
    79dd:0c24    xlat
    79dd:0c26    or        al,al
    79dd:0c28    jns       0C2D
    79dd:0c2a    jmp       ENDDEC
    79dd:0c2d    add       cx,cx
    79dd:0c2f    adc       dx,dx
    79dd:0c31    mov       bp,cx
    79dd:0c33    mov       di,dx
    79dd:0c35    add       cx,cx
    79dd:0c37    adc       dx,dx
    79dd:0c39    add       cx,cx
    79dd:0c3b    adc       dx,dx
    79dd:0c3d    add       cx,bp
    79dd:0c3f    adc       dx,di
    79dd:0c41    add       cx,ax
    79dd:0c43    adc       dx,00
    79dd:0c46    lodsb
    79dd:0c47    xlat
    79dd:0c49    or        al,al
    79dd:0c4b    js        ENDDEC
    79dd:0c4d    add       cx,cx
    79dd:0c4f    adc       dx,dx
    79dd:0c51    mov       bp,cx
    79dd:0c53    mov       di,dx
    79dd:0c55    add       cx,cx
    79dd:0c57    adc       dx,dx
    79dd:0c59    add       cx,cx
    79dd:0c5b    adc       dx,dx
    79dd:0c5d    add       cx,bp
    79dd:0c5f    adc       dx,di
    79dd:0c61    add       cx,ax
    79dd:0c63    adc       dx,00
    79dd:0c66    lodsb
    79dd:0c67    xlat
    79dd:0c69    or        al,al
    79dd:0c6b    js        ENDDEC
    79dd:0c6d    add       cx,cx
    79dd:0c6f    adc       dx,dx
    79dd:0c71    mov       bp,cx
    79dd:0c73    mov       di,dx
    79dd:0c75    add       cx,cx
    79dd:0c77    adc       dx,dx
    79dd:0c79    add       cx,cx
    79dd:0c7b    adc       dx,dx
    79dd:0c7d    add       cx,bp
    79dd:0c7f    adc       dx,di
    79dd:0c81    add       cx,ax
    79dd:0c83    adc       dx,00
    79dd:0c86    lodsb
    79dd:0c87    xlat
    79dd:0c89    or        al,al
    79dd:0c8b    js        ENDDEC
    79dd:0c8d    add       cx,cx
    79dd:0c8f    adc       dx,dx
    79dd:0c91    mov       bp,cx
    79dd:0c93    mov       di,dx
    79dd:0c95    add       cx,cx
    79dd:0c97    adc       dx,dx
    79dd:0c99    add       cx,cx
    79dd:0c9b    adc       dx,dx
    79dd:0c9d    add       cx,bp
    79dd:0c9f    adc       dx,di
    79dd:0ca1    add       cx,ax
    79dd:0ca3    adc       dx,00
    79dd:0ca6    lodsb
    79dd:0ca7  - push      dx
    79dd:0ca8    mov       dx,844E
    79dd:0cab    call      ERROR_ROUT
    79dd:0cae    pop       dx
             ENDDEC:
    79dd:0caf    pop       di
    79dd:0cb0  - pop       bp
    79dd:0cb1  - mov       al,byte ptr [si+FF]
    79dd:0cb4  - and       al,DF
    79dd:0cb6  - cmp       al,48
    79dd:0cb8  - je        NUMDECTOHEX
    79dd:0cba  - cmp       al,42
    79dd:0cbc  - je        0CC1
    79dd:0cbe    jmp       NUMOUT
    79dd:0cc1  - mov       si,bp
    79dd:0cc3  - dec       si
    79dd:0cc4  - jmp       NUM0BIN
             NUMDECTOHEX:
    79dd:0cc6  - mov       si,bp
    79dd:0cc8  - dec       si
    79dd:0cc9  - jmp       NUMHEX
             NUMASC:
    79dd:0ccc  - mov       ah,al
    79dd:0cce  - xor       cx,cx
    79dd:0cd0  - xor       dx,dx
    79dd:0cd2  - lodsb
    79dd:0cd3    cmp       ah,al
    79dd:0cd5    je        ENDASC
    79dd:0cd7    mov       dh,dl
    79dd:0cd9    mov       dl,ch
    79dd:0cdb    mov       ch,cl
    79dd:0cdd    mov       cl,al
    79dd:0cdf    lodsb
    79dd:0ce0    cmp       ah,al
    79dd:0ce2    je        ENDASC
    79dd:0ce4    mov       dh,dl
    79dd:0ce6    mov       dl,ch
    79dd:0ce8    mov       ch,cl
    79dd:0cea    mov       cl,al
    79dd:0cec    lodsb
    79dd:0ced    cmp       ah,al
    79dd:0cef    je        ENDASC
    79dd:0cf1    mov       dh,dl
    79dd:0cf3    mov       dl,ch
    79dd:0cf5    mov       ch,cl
    79dd:0cf7    mov       cl,al
    79dd:0cf9    lodsb
    79dd:0cfa    cmp       ah,al
    79dd:0cfc    je        ENDASC
    79dd:0cfe    mov       dh,dl
    79dd:0d00    mov       dl,ch
    79dd:0d02    mov       ch,cl
    79dd:0d04    mov       cl,al
    79dd:0d06    lodsb
    79dd:0d07    cmp       ah,al
    79dd:0d09    je        ENDASC
    79dd:0d0b    mov       dh,dl
    79dd:0d0d    mov       dl,ch
    79dd:0d0f    mov       ch,cl
    79dd:0d11    mov       cl,al
    79dd:0d13  - push      dx
    79dd:0d14    mov       dx,844E
    79dd:0d17    call      ERROR_ROUT
    79dd:0d1a    pop       dx
             ENDASC:
    79dd:0d1b    inc       si
    79dd:0d1c  - jmp       NUMOUT
             NUM0BIN:
             NUMBIN:
    79dd:0d1f  - mov       bx,75A3
    79dd:0d22  - xor       cx,cx
    79dd:0d24  - xor       dx,dx
    79dd:0d26  - lodsb
    79dd:0d27    xlat
    79dd:0d29    or        al,al
    79dd:0d2b    jns       0D30
    79dd:0d2d    jmp       BINOUT
    79dd:0d30    add       cx,cx
    79dd:0d32    adc       dx,dx
    79dd:0d34    or        cl,al
    79dd:0d36    lodsb
    79dd:0d37    xlat
    79dd:0d39    or        al,al
    79dd:0d3b    jns       0D40
    79dd:0d3d    jmp       BINOUT
    79dd:0d40    add       cx,cx
    79dd:0d42    adc       dx,dx
    79dd:0d44    or        cl,al
    79dd:0d46    lodsb
    79dd:0d47    xlat
    79dd:0d49    or        al,al
    79dd:0d4b    jns       0D50
    79dd:0d4d    jmp       BINOUT
    79dd:0d50    add       cx,cx
    79dd:0d52    adc       dx,dx
    79dd:0d54    or        cl,al
    79dd:0d56    lodsb
    79dd:0d57    xlat
    79dd:0d59    or        al,al
    79dd:0d5b    jns       0D60
    79dd:0d5d    jmp       BINOUT
    79dd:0d60    add       cx,cx
    79dd:0d62    adc       dx,dx
    79dd:0d64    or        cl,al
    79dd:0d66    lodsb
    79dd:0d67    xlat
    79dd:0d69    or        al,al
    79dd:0d6b    jns       0D70
    79dd:0d6d    jmp       BINOUT
    79dd:0d70    add       cx,cx
    79dd:0d72    adc       dx,dx
    79dd:0d74    or        cl,al
    79dd:0d76    lodsb
    79dd:0d77    xlat
    79dd:0d79    or        al,al
    79dd:0d7b    jns       0D80
    79dd:0d7d    jmp       BINOUT
    79dd:0d80    add       cx,cx
    79dd:0d82    adc       dx,dx
    79dd:0d84    or        cl,al
    79dd:0d86    lodsb
    79dd:0d87    xlat
    79dd:0d89    or        al,al
    79dd:0d8b    jns       0D90
    79dd:0d8d    jmp       BINOUT
    79dd:0d90    add       cx,cx
    79dd:0d92    adc       dx,dx
    79dd:0d94    or        cl,al
    79dd:0d96    lodsb
    79dd:0d97    xlat
    79dd:0d99    or        al,al
    79dd:0d9b    jns       0DA0
    79dd:0d9d    jmp       BINOUT
    79dd:0da0    add       cx,cx
    79dd:0da2    adc       dx,dx
    79dd:0da4    or        cl,al
    79dd:0da6    lodsb
    79dd:0da7    xlat
    79dd:0da9    or        al,al
    79dd:0dab    jns       0DB0
    79dd:0dad    jmp       BINOUT
    79dd:0db0    add       cx,cx
    79dd:0db2    adc       dx,dx
    79dd:0db4    or        cl,al
    79dd:0db6    lodsb
    79dd:0db7    xlat
    79dd:0db9    or        al,al
    79dd:0dbb    jns       0DC0
    79dd:0dbd    jmp       BINOUT
    79dd:0dc0    add       cx,cx
    79dd:0dc2    adc       dx,dx
    79dd:0dc4    or        cl,al
    79dd:0dc6    lodsb
    79dd:0dc7    xlat
    79dd:0dc9    or        al,al
    79dd:0dcb    jns       0DD0
    79dd:0dcd    jmp       BINOUT
    79dd:0dd0    add       cx,cx
    79dd:0dd2    adc       dx,dx
    79dd:0dd4    or        cl,al
    79dd:0dd6    lodsb
    79dd:0dd7    xlat
    79dd:0dd9    or        al,al
    79dd:0ddb    jns       0DE0
    79dd:0ddd    jmp       BINOUT
    79dd:0de0    add       cx,cx
    79dd:0de2    adc       dx,dx
    79dd:0de4    or        cl,al
    79dd:0de6    lodsb
    79dd:0de7    xlat
    79dd:0de9    or        al,al
    79dd:0deb    jns       0DF0
    79dd:0ded    jmp       BINOUT
    79dd:0df0    add       cx,cx
    79dd:0df2    adc       dx,dx
    79dd:0df4    or        cl,al
    79dd:0df6    lodsb
    79dd:0df7    xlat
    79dd:0df9    or        al,al
    79dd:0dfb    jns       0E00
    79dd:0dfd    jmp       BINOUT
    79dd:0e00    add       cx,cx
    79dd:0e02    adc       dx,dx
    79dd:0e04    or        cl,al
    79dd:0e06    lodsb
    79dd:0e07    xlat
    79dd:0e09    or        al,al
    79dd:0e0b    jns       0E10
    79dd:0e0d    jmp       BINOUT
    79dd:0e10    add       cx,cx
    79dd:0e12    adc       dx,dx
    79dd:0e14    or        cl,al
    79dd:0e16    lodsb
    79dd:0e17    xlat
    79dd:0e19    or        al,al
    79dd:0e1b    jns       0E20
    79dd:0e1d    jmp       BINOUT
    79dd:0e20    add       cx,cx
    79dd:0e22    adc       dx,dx
    79dd:0e24    or        cl,al
    79dd:0e26    lodsb
    79dd:0e27    xlat
    79dd:0e29    or        al,al
    79dd:0e2b    jns       0E30
    79dd:0e2d    jmp       BINOUT
    79dd:0e30    add       cx,cx
    79dd:0e32    adc       dx,dx
    79dd:0e34    or        cl,al
    79dd:0e36    lodsb
    79dd:0e37    xlat
    79dd:0e39    or        al,al
    79dd:0e3b    jns       0E40
    79dd:0e3d    jmp       BINOUT
    79dd:0e40    add       cx,cx
    79dd:0e42    adc       dx,dx
    79dd:0e44    or        cl,al
    79dd:0e46    lodsb
    79dd:0e47    xlat
    79dd:0e49    or        al,al
    79dd:0e4b    jns       0E50
    79dd:0e4d    jmp       BINOUT
    79dd:0e50    add       cx,cx
    79dd:0e52    adc       dx,dx
    79dd:0e54    or        cl,al
    79dd:0e56    lodsb
    79dd:0e57    xlat
    79dd:0e59    or        al,al
    79dd:0e5b    jns       0E60
    79dd:0e5d    jmp       BINOUT
    79dd:0e60    add       cx,cx
    79dd:0e62    adc       dx,dx
    79dd:0e64    or        cl,al
    79dd:0e66    lodsb
    79dd:0e67    xlat
    79dd:0e69    or        al,al
    79dd:0e6b    jns       0E70
    79dd:0e6d    jmp       BINOUT
    79dd:0e70    add       cx,cx
    79dd:0e72    adc       dx,dx
    79dd:0e74    or        cl,al
    79dd:0e76    lodsb
    79dd:0e77    xlat
    79dd:0e79    or        al,al
    79dd:0e7b    jns       0E80
    79dd:0e7d    jmp       BINOUT
    79dd:0e80    add       cx,cx
    79dd:0e82    adc       dx,dx
    79dd:0e84    or        cl,al
    79dd:0e86    lodsb
    79dd:0e87    xlat
    79dd:0e89    or        al,al
    79dd:0e8b    jns       0E90
    79dd:0e8d    jmp       BINOUT
    79dd:0e90    add       cx,cx
    79dd:0e92    adc       dx,dx
    79dd:0e94    or        cl,al
    79dd:0e96    lodsb
    79dd:0e97    xlat
    79dd:0e99    or        al,al
    79dd:0e9b    jns       0EA0
    79dd:0e9d    jmp       BINOUT
    79dd:0ea0    add       cx,cx
    79dd:0ea2    adc       dx,dx
    79dd:0ea4    or        cl,al
    79dd:0ea6    lodsb
    79dd:0ea7    xlat
    79dd:0ea9    or        al,al
    79dd:0eab    js        BINOUT
    79dd:0ead    add       cx,cx
    79dd:0eaf    adc       dx,dx
    79dd:0eb1    or        cl,al
    79dd:0eb3    lodsb
    79dd:0eb4    xlat
    79dd:0eb6    or        al,al
    79dd:0eb8    js        BINOUT
    79dd:0eba    add       cx,cx
    79dd:0ebc    adc       dx,dx
    79dd:0ebe    or        cl,al
    79dd:0ec0    lodsb
    79dd:0ec1    xlat
    79dd:0ec3    or        al,al
    79dd:0ec5    js        BINOUT
    79dd:0ec7    add       cx,cx
    79dd:0ec9    adc       dx,dx
    79dd:0ecb    or        cl,al
    79dd:0ecd    lodsb
    79dd:0ece    xlat
    79dd:0ed0    or        al,al
    79dd:0ed2    js        BINOUT
    79dd:0ed4    add       cx,cx
    79dd:0ed6    adc       dx,dx
    79dd:0ed8    or        cl,al
    79dd:0eda    lodsb
    79dd:0edb    xlat
    79dd:0edd    or        al,al
    79dd:0edf    js        BINOUT
    79dd:0ee1    add       cx,cx
    79dd:0ee3    adc       dx,dx
    79dd:0ee5    or        cl,al
    79dd:0ee7    lodsb
    79dd:0ee8    xlat
    79dd:0eea    or        al,al
    79dd:0eec    js        BINOUT
    79dd:0eee    add       cx,cx
    79dd:0ef0    adc       dx,dx
    79dd:0ef2    or        cl,al
    79dd:0ef4    lodsb
    79dd:0ef5    xlat
    79dd:0ef7    or        al,al
    79dd:0ef9    js        BINOUT
    79dd:0efb    add       cx,cx
    79dd:0efd    adc       dx,dx
    79dd:0eff    or        cl,al
    79dd:0f01    lodsb
    79dd:0f02    xlat
    79dd:0f04    or        al,al
    79dd:0f06    js        BINOUT
    79dd:0f08    add       cx,cx
    79dd:0f0a    adc       dx,dx
    79dd:0f0c    or        cl,al
    79dd:0f0e    lodsb
    79dd:0f0f    xlat
    79dd:0f11    or        al,al
    79dd:0f13    js        BINOUT
    79dd:0f15    add       cx,cx
    79dd:0f17    adc       dx,dx
    79dd:0f19    or        cl,al
    79dd:0f1b  - push      dx
    79dd:0f1c    mov       dx,844E
    79dd:0f1f    call      ERROR_ROUT
    79dd:0f22    pop       dx
             BINOUT:
    79dd:0f23    mov       al,byte ptr [si+FF]
    79dd:0f26  - and       al,DF
    79dd:0f28  - cmp       al,42
    79dd:0f2a  - je        0F2F
    79dd:0f2c    jmp       NUMOUT
    79dd:0f2f  - inc       si
    79dd:0f30  - jmp       NUMOUT
             NUMPC:
    79dd:0f33  - mov       dx,word ptr ss:[0F92]
    79dd:0f38  - mov       cx,word ptr ss:[0F94]
    79dd:0f3d  - inc       si
    79dd:0f3e  - jmp       NUMOUT
             NUMROMPOS:
    79dd:0f41  - push      es
    79dd:0f42  - push      bx
    79dd:0f43  - mov       es,word ptr ss:[13B6]
    79dd:0f48  - mov       bp,word ptr ss:[13B8]
    79dd:0f4d  - mov       dx,word ptr es:[bp+0C]
    79dd:0f51  - mov       cx,word ptr es:[bp+0E]
    79dd:0f55  - mov       bx,sp
    79dd:0f57  - mov       bp,word ptr ss:[bx+04]
    79dd:0f5b  - sub       bp,word ptr ss:[13B4]
    79dd:0f60  - add       cx,bp
    79dd:0f62  - adc       dx,00
    79dd:0f65  - inc       si
    79dd:0f66  - pop       bx
    79dd:0f67  - pop       es
    79dd:0f68  - jmp       NUMOUT
             NUMOPEN:
    79dd:0f6b  - mov       ax,word ptr [si]
    79dd:0f6d  - and       ax,DFDF
    79dd:0f70  - cmp       ax,5453
    79dd:0f73  - je        EXP_S
             EXP_RET:
    79dd:0f75  - add       byte ptr ss:[0ACF],10
    79dd:0f7b  - jmp       EXPLOOP
             EXP_S:
    79dd:0f7e  - mov       ax,word ptr [si+02]
    79dd:0f81  - and       ax,DFDF
    79dd:0f84  - cmp       ax,4352
    79dd:0f87  - je        EXP_STRC
    79dd:0f89  - cmp       ax,4C52
    79dd:0f8c  - jne       EXP_RET
    79dd:0f8e  - mov       ax,word ptr [si+04]
    79dd:0f91  - and       ax,DFDF
    79dd:0f94  - cmp       ax,4E45
    79dd:0f97  - jne       EXP_RET
    79dd:0f99  - mov       al,byte ptr [si+06]
    79dd:0f9c  - push      bx
    79dd:0f9d  - mov       bx,76A7
             SOURCEBLK:
    79dd:0f9e    cmpsw
    79dd:0f9f    jbe       0FD7
    79dd:0fa1    xlat
    79dd:0fa2    pop       bx
    79dd:0fa3    or        al,al
    79dd:0fa5    jns       EXP_RET
    79dd:0fa7    add       si,06
    79dd:0faa    call      EVAL_STRLEN
    79dd:0fad    add       si,02
    79dd:0fb0    jmp       NUMOUT
             EXP_STRC:
    79dd:0fb3    mov       ax,word ptr [si+04]
    79dd:0fb6    and       ax,DFDF
    79dd:0fb9    cmp       ax,504D
    79dd:0fbc    jne       EXP_RET
    79dd:0fbe    mov       al,byte ptr [si+06]
    79dd:0fc1    push      bx
    79dd:0fc2    mov       bx,76A7
    79dd:0fc5    xlat
    79dd:0fc7    pop       bx
    79dd:0fc8    or        al,al
    79dd:0fca    jns       EXP_RET
    79dd:0fcc    add       si,06
    79dd:0fcf    call      EVAL_STRCMP
    79dd:0fd2    add       si,02
    79dd:0fd5    jmp       NUMOUT
             NUMCLOSE:
    79dd:0fd8    inc       si
    79dd:0fd9    inc       si
    79dd:0fda    sub       byte ptr ss:[0ACF],10
    79dd:0fe0    jns       0FE5
    79dd:0fe2    jmp       E_UNBALBRAC
    79dd:0fe5    jmp       GETOPERATOR
             NUMSHIFTR:
    79dd:0fe7    cmp       byte ptr es:[di+FF],06
    79dd:0fec    jne       NUMHI
    79dd:0fee    mov       ax,0208
    79dd:0ff1    add       al,byte ptr ss:[0ACF]
    79dd:0ff6    mov       word ptr es:[di+FE],ax
    79dd:0ffa    jmp       EXPLOOP
             NUMSHIFTL:
    79dd:0ffd    cmp       byte ptr es:[di+FF],08
    79dd:1002    jne       NUMLO
    79dd:1004    mov       ax,0408
    79dd:1007    add       al,byte ptr ss:[0ACF]
    79dd:100c    mov       word ptr es:[di+FE],ax
    79dd:1010    jmp       EXPLOOP
             NUMHI:
    79dd:1013    xor       ax,ax
    79dd:1015    stosw
    79dd:1016    stosw
    79dd:1017    mov       ax,1A0A
    79dd:101a    add       al,byte ptr ss:[0ACF]
    79dd:101f    stosw
    79dd:1020    jmp       EXPLOOP
             NUMLO:
    79dd:1023    xor       ax,ax
    79dd:1025    stosw
    79dd:1026    stosw
    79dd:1027    mov       ax,1C0A
    79dd:102a    add       al,byte ptr ss:[0ACF]
    79dd:102f    stosw
    79dd:1030    jmp       EXPLOOP
             NUMNOT:
    79dd:1033    xor       ax,ax
    79dd:1035    stosw
    79dd:1036    stosw
    79dd:1037    mov       ax,2209
    79dd:103a    add       al,byte ptr ss:[0ACF]
    79dd:103f    stosw
    79dd:1040    jmp       EXPLOOP
             NUMNEG:
    79dd:1043    xor       ax,ax
    79dd:1045    stosw
    79dd:1046    stosw
    79dd:1047    mov       ax,2009
    79dd:104a    add       al,byte ptr ss:[0ACF]
    79dd:104f    stosw
    79dd:1050    jmp       EXPLOOP
             LNUMOUT:
    79dd:1053    je        NUMOK
    79dd:1055    or        byte ptr es:[di+FE],80
             NUMOK:
    79dd:105a    inc       si
             NUMOUT:
    79dd:105b    mov       ax,cx
    79dd:105d    stosw
    79dd:105e    mov       ax,dx
    79dd:1060    stosw
             GETOPERATOR:
    79dd:1061    mov       al,byte ptr [si+FF]
    79dd:1064    mov       bx,6B2D
    79dd:1067    xlat
    79dd:1069    or        al,al
    79dd:106b    js        CEEND
    79dd:106d    mov       ah,al
    79dd:106f    mov       bx,6C31
    79dd:1072    xlat
    79dd:1074    add       al,byte ptr ss:[0ACF]
    79dd:1079    stosw
    79dd:107a    jmp       EXPLOOP
             CEEND:
    79dd:107d    dec       si
    79dd:107e    mov       al,byte ptr [si]
    79dd:1080    mov       bx,6BAF
    79dd:1083    xlat
    79dd:1085    or        al,al
    79dd:1087    jns       OPERR
    79dd:1089    test      byte ptr ss:[0ACF],00
    79dd:108f    jne       E_UNBALBRAC
    79dd:1091    xor       ax,ax
    79dd:1093    stosw
    79dd:1094    test      byte ptr ss:[0ACE],C0
    79dd:109a    jne       FREXP
    79dd:109c    sub       di,word ptr ss:[0AC7]
    79dd:10a1    cmp       di,08
    79dd:10a4    je        QUICKNUM
    79dd:10a6    push      ds
    79dd:10a7    push      si
    79dd:10a8    mov       ax,es
    79dd:10aa    mov       ds,ax
    79dd:10ac    mov       si,word ptr ss:[0AC7]
    79dd:10b1    call      NORMEXPRESS
    79dd:10b4    pop       si
    79dd:10b5    pop       ds
             EXPOUT:
    79dd:10b6    pop       di
    79dd:10b7    pop       es
    79dd:10b8    pop       bx
    79dd:10b9    ret
    79dd:10ba    or        byte ptr ss:[0ACE],80
    79dd:10c0    jmp       EXPOUT
             QUICKNUM:
    79dd:10c2    pop       di
    79dd:10c3    pop       es
    79dd:10c4    pop       bx
    79dd:10c5    ret
             OPERR:
    79dd:10c6    jne       10CB
    79dd:10c8    jmp       NUMCLOSE
    79dd:10cb    push      dx
    79dd:10cc    mov       dx,8405
    79dd:10cf    call      ERROR_ROUT
    79dd:10d2    pop       dx
             NUMERR:
    79dd:10d3    push      dx
    79dd:10d4    mov       dx,83E9
    79dd:10d7    call      ERROR_ROUT
    79dd:10da    pop       dx
             E_UNBALBRAC:
    79dd:10db    push      dx
    79dd:10dc    mov       dx,8425
    79dd:10df    call      ERROR_ROUT
    79dd:10e2    pop       dx
             FREXP:
    79dd:10e3    test      byte ptr ss:[0ACE],40
    79dd:10e9    jne       EXTEXP
    79dd:10eb    push      bx
    79dd:10ec    mov       ax,word ptr [A49F]
    79dd:10f0    sub       ax,word ptr ss:[13B4]
    79dd:10f5    xor       bx,bx
    79dd:10f7    add       ax,word ptr ss:[13BE]
    79dd:10fc    adc       bx,word ptr ss:[13BC]
    79dd:1101    mov       word ptr es:[di+11],ax
    79dd:1105    mov       word ptr es:[di+13],bx
    79dd:1109    pop       bx
    79dd:110a    mov       ax,word ptr [0F9A]
    79dd:110e    mov       word ptr es:[di+0E],ax
    79dd:1112    mov       ax,word ptr [13AC]
    79dd:1116    mov       word ptr es:[di+04],ax
    79dd:111a    call      GETLINE
    79dd:111d    mov       word ptr es:[di+08],ax
    79dd:1121    mov       word ptr es:[di],FFFE
    79dd:1126  - mov       word ptr ss:[0AC9],di
    79dd:112b  - xor       cx,cx
    79dd:112d  - mov       dx,cx
    79dd:112f  - pop       di
    79dd:1130  - pop       es
    79dd:1131  - pop       bx
    79dd:1132  - ret
             EXTEXP:
    79dd:1133  - push      ds
    79dd:1134  - push      si
    79dd:1135  - mov       bp,di
    79dd:1137  - mov       ds,word ptr ss:[0AC5]
    79dd:113c  - mov       si,word ptr ss:[0AC7]
    79dd:1141  - mov       es,word ptr ss:[13A6]
    79dd:1146  - mov       di,word ptr ss:[13A8]
    79dd:114b  - call      GETLINE
    79dd:114e  - stosw
             EXTEXPLP:
    79dd:114f  - lodsw
    79dd:1150  - stosw
    79dd:1151  - cmp       si,bp
    79dd:1153  - jne       EXTEXPLP
    79dd:1155  - mov       word ptr ss:[13A8],di
    79dd:115a  - inc       word ptr ss:[13AA]
    79dd:115f  - mov       byte ptr ss:[0ACE],40
    79dd:1165  - xor       cx,cx
    79dd:1167  - mov       dx,cx
    79dd:1169  - pop       si
    79dd:116a  - pop       ds
    79dd:116b  - pop       di
    79dd:116c  - pop       es
    79dd:116d  - pop       bx
    79dd:116e  - ret
             NUMLOC:
    79dd:116f  - dec       si
    79dd:1170  - mov       word ptr ss:[9A8C],ds
    79dd:1175  - mov       word ptr ss:[9A8E],si
    79dd:117a  - mov       bx,79A9
    79dd:117d  - xor       ah,ah
    79dd:117f  - xor       cx,cx
    79dd:1181  - lodsb
    79dd:1182  - inc       cx
    79dd:1183  - xlat
    79dd:1185  - mov       dx,ax
    79dd:1187  - add       dx,dx
             LG_SYMLOOP:
    79dd:1189  - lodsb
    79dd:118a    xlat
    79dd:118c    or        al,al
    79dd:118e    js        LG_ENDSYMHASH
    79dd:1190    add       dx,ax
    79dd:1192    add       dx,dx
    79dd:1194    inc       cx
    79dd:1195    lodsb
    79dd:1196    xlat
    79dd:1198    or        al,al
    79dd:119a    js        LG_ENDSYMHASH
    79dd:119c    add       dx,ax
    79dd:119e    add       dx,dx
    79dd:11a0    inc       cx
    79dd:11a1    lodsb
    79dd:11a2    xlat
    79dd:11a4    or        al,al
    79dd:11a6    js        LG_ENDSYMHASH
    79dd:11a8    add       dx,ax
    79dd:11aa    add       dx,dx
    79dd:11ac    inc       cx
    79dd:11ad    lodsb
    79dd:11ae    xlat
    79dd:11b0    or        al,al
    79dd:11b2    js        LG_ENDSYMHASH
    79dd:11b4    add       dx,ax
    79dd:11b6    add       dx,dx
    79dd:11b8    inc       cx
    79dd:11b9    lodsb
    79dd:11ba    xlat
    79dd:11bc    or        al,al
    79dd:11be    js        LG_ENDSYMHASH
    79dd:11c0    add       dx,ax
    79dd:11c2    add       dx,dx
    79dd:11c4    inc       cx
    79dd:11c5    lodsb
    79dd:11c6    xlat
    79dd:11c8    or        al,al
    79dd:11ca    js        LG_ENDSYMHASH
    79dd:11cc    add       dx,ax
    79dd:11ce    add       dx,dx
    79dd:11d0    inc       cx
    79dd:11d1    lodsb
    79dd:11d2    xlat
    79dd:11d4    or        al,al
    79dd:11d6    js        LG_ENDSYMHASH
    79dd:11d8    add       dx,ax
    79dd:11da    add       dx,dx
    79dd:11dc    inc       cx
    79dd:11dd    lodsb
    79dd:11de    xlat
    79dd:11e0    or        al,al
    79dd:11e2    js        LG_ENDSYMHASH
    79dd:11e4    add       dx,ax
    79dd:11e6    add       dx,dx
    79dd:11e8    inc       cx
    79dd:11e9  - jmp       LG_SYMLOOP
             LG_ENDSYMHASH:
    79dd:11eb  - inc       cx
    79dd:11ec  - and       dx,0FFD
    79dd:11f0  - mov       ax,ss
    79dd:11f2  - mov       ds,ax
    79dd:11f4  - mov       bp,1472
    79dd:11f7  - add       bp,dx
             LG_NEXT:
    79dd:11f9  - mov       ax,word ptr ds:[bp+00]
    79dd:11fd  - or        ax,ax
    79dd:11ff  - jne       1204
    79dd:1201    jmp       LG_NOTTHERE
    79dd:1204  - mov       bp,word ptr ds:[bp+02]
    79dd:1208  - mov       ds,ax
    79dd:120a  - cmp       cl,byte ptr ds:[bp+05]
    79dd:120e  - jne       LG_NEXT
    79dd:1210  - mov       dx,word ptr ss:[0F82]
    79dd:1215  - cmp       dx,word ptr ds:[bp+10]
    79dd:1219  - jne       LG_NEXT
    79dd:121b  - mov       dx,word ptr ss:[0F80]
    79dd:1220  - cmp       dx,word ptr ds:[bp+0E]
    79dd:1224  - jne       LG_NEXT
    79dd:1226  - push      es
    79dd:1227  - push      di
    79dd:1228  - mov       es,word ptr ds:[bp+06]
    79dd:122c  - mov       di,word ptr ds:[bp+08]
    79dd:1230  - mov       dx,ds
    79dd:1232  - mov       ds,word ptr ss:[9A8C]
    79dd:1237  - mov       si,word ptr ss:[9A8E]
    79dd:123c  - push      cx
    79dd:123d  - dec       cx
             LG_LOOP:
    79dd:123e  - lodsb
    79dd:123f  - xlat
    79dd:1241  - cmp       al,byte ptr es:[di]
    79dd:1244  - jne       LG_NOTSAME
    79dd:1246  - inc       di
    79dd:1247  - dec       cx
    79dd:1248  - jne       LG_LOOP
    79dd:124a  - pop       cx
    79dd:124b  - pop       di
    79dd:124c  - pop       es
    79dd:124d  - mov       ds,dx
    79dd:124f  - mov       al,byte ptr ds:[bp+04]
    79dd:1253  - test      al,10
    79dd:1255  - jne       LG_FR
    79dd:1257  - and       al,7F
    79dd:1259  - or        byte ptr ss:[0ACE],al
    79dd:125e  - mov       dx,word ptr ds:[bp+0A]
    79dd:1262  - mov       cx,word ptr ds:[bp+0C]
    79dd:1266  - mov       ds,word ptr ss:[9A8C]
    79dd:126b  - xor       al,al
    79dd:126d  - jmp       LNUMOUT
             LG_FR:
    79dd:1270  - mov       cx,ds
    79dd:1272  - mov       dx,bp
    79dd:1274  - mov       ds,word ptr ss:[9A8C]
    79dd:1279  - or        byte ptr ss:[0ACE],80
    79dd:127f  - mov       al,01
    79dd:1281  - or        al,al
    79dd:1283  - jmp       LNUMOUT
             LG_NOTSAME:
    79dd:1286  - pop       cx
    79dd:1287  - pop       di
    79dd:1288  - pop       es
    79dd:1289  - mov       ds,dx
    79dd:128b  - jmp       LG_NEXT
             LG_NOTTHERE:
    79dd:128e  - mov       ds,word ptr ss:[9A8C]
    79dd:1293  - mov       si,word ptr ss:[9A8E]
    79dd:1298  - mov       al,byte ptr [0F8B]
    79dd:129c  - push      ax
    79dd:129d  - call      ADDSYMBOL
    79dd:12a0  - pop       ax
    79dd:12a1  - mov       byte ptr [0F8B],al
    79dd:12a5  - push      es
    79dd:12a6  - push      di
    79dd:12a7  - mov       es,word ptr ss:[0F7C]
    79dd:12ac  - mov       di,word ptr ss:[0F7E]
    79dd:12b1  - mov       byte ptr es:[di+04],11
    79dd:12b6  - mov       cx,es
    79dd:12b8  - mov       dx,di
    79dd:12ba  - push      ds
    79dd:12bb  - push      si
    79dd:12bc  - mov       ds,word ptr ss:[9A88]
    79dd:12c1  - mov       si,word ptr ss:[9A8A]
    79dd:12c6  - mov       ax,word ptr [0F72]
    79dd:12ca  - mov       bx,word ptr ss:[0F74]
    79dd:12cf  - mov       word ptr es:[di+06],ax
    79dd:12d3  - mov       word ptr es:[di+08],bx
    79dd:12d7  - mov       es,ax
    79dd:12d9  - mov       di,bx
             FRCOP:
    79dd:12db  - lodsb
    79dd:12dc  - stosb
    79dd:12dd  - or        al,al
    79dd:12df  - jne       FRCOP
    79dd:12e1  - mov       word ptr ss:[0F74],di
    79dd:12e6  - cmp       di,3F80
    79dd:12ea    jb        12EF
    79dd:12ec    call      MORESYMTX
    79dd:12ef  - pop       si
    79dd:12f0  - pop       ds
    79dd:12f1  - pop       di
    79dd:12f2  - pop       es
    79dd:12f3  - mov       byte ptr ss:[0ACE],80
    79dd:12f9  - mov       al,01
    79dd:12fb  - or        al,al
    79dd:12fd  - jmp       LNUMOUT
             NUMLAB:
    79dd:1300  - dec       si
    79dd:1301  - mov       word ptr ss:[9A8C],ds
    79dd:1306  - mov       word ptr ss:[9A8E],si
    79dd:130b  - mov       bx,79A9
    79dd:130e  - xor       ah,ah
    79dd:1310  - xor       cx,cx
    79dd:1312  - lodsb
    79dd:1313  - inc       cx
    79dd:1314  - xlat
    79dd:1316  - mov       dx,ax
    79dd:1318  - add       dx,dx
             G_SYMLOOP:
    79dd:131a  - lodsb
    79dd:131b    xlat
    79dd:131d    or        al,al
    79dd:131f    js        G_ENDSYMHASH
    79dd:1321    add       dx,ax
    79dd:1323    add       dx,dx
    79dd:1325    inc       cx
    79dd:1326    lodsb
    79dd:1327    xlat
    79dd:1329    or        al,al
    79dd:132b    js        G_ENDSYMHASH
    79dd:132d    add       dx,ax
    79dd:132f    add       dx,dx
    79dd:1331    inc       cx
    79dd:1332    lodsb
    79dd:1333    xlat
    79dd:1335    or        al,al
    79dd:1337    js        G_ENDSYMHASH
    79dd:1339    add       dx,ax
    79dd:133b    add       dx,dx
    79dd:133d    inc       cx
    79dd:133e    lodsb
    79dd:133f    xlat
    79dd:1341    or        al,al
    79dd:1343    js        G_ENDSYMHASH
    79dd:1345    add       dx,ax
    79dd:1347    add       dx,dx
    79dd:1349    inc       cx
    79dd:134a    lodsb
    79dd:134b    xlat
    79dd:134d    or        al,al
    79dd:134f    js        G_ENDSYMHASH
    79dd:1351    add       dx,ax
    79dd:1353    add       dx,dx
    79dd:1355    inc       cx
    79dd:1356    lodsb
    79dd:1357    xlat
    79dd:1359    or        al,al
    79dd:135b    js        G_ENDSYMHASH
    79dd:135d    add       dx,ax
    79dd:135f    add       dx,dx
    79dd:1361    inc       cx
    79dd:1362    lodsb
    79dd:1363    xlat
    79dd:1365    or        al,al
    79dd:1367    js        G_ENDSYMHASH
    79dd:1369    add       dx,ax
    79dd:136b    add       dx,dx
    79dd:136d    inc       cx
    79dd:136e    lodsb
    79dd:136f    xlat
    79dd:1371    or        al,al
    79dd:1373    js        G_ENDSYMHASH
    79dd:1375    add       dx,ax
    79dd:1377    add       dx,dx
    79dd:1379    inc       cx
    79dd:137a  - jmp       G_SYMLOOP
             G_ENDSYMHASH:
    79dd:137c  - inc       cx
    79dd:137d  - and       dx,0FFD
    79dd:1381  - mov       ax,ss
    79dd:1383  - mov       ds,ax
    79dd:1385  - mov       bp,1472
    79dd:1388  - add       bp,dx
             _NEXT:
    79dd:138a  - mov       ax,word ptr ds:[bp+00]
    79dd:138e  - or        ax,ax
    79dd:1390  - jne       1395
    79dd:1392    jmp       _NOTTHERE
    79dd:1395  - mov       bp,word ptr ds:[bp+02]
    79dd:1399  - mov       ds,ax
    79dd:139b  - cmp       cl,byte ptr ds:[bp+05]
    79dd:139f  - jne       _NEXT
    79dd:13a1  - test      byte ptr ds:[bp+04],01
    79dd:13a6  - je        _NEXT
    79dd:13a8  - push      es
    79dd:13a9  - push      di
    79dd:13aa  - mov       es,word ptr ds:[bp+06]
    79dd:13ae  - mov       di,word ptr ds:[bp+08]
    79dd:13b2  - mov       dx,ds
    79dd:13b4  - mov       ds,word ptr ss:[9A8C]
    79dd:13b9  - mov       si,word ptr ss:[9A8E]
    79dd:13be  - push      cx
    79dd:13bf  - dec       cx
             _LOOP:
    79dd:13c0  - lodsb
    79dd:13c1  - xlat
    79dd:13c3  - cmp       al,byte ptr es:[di]
    79dd:13c6  - jne       _NOTSAME
    79dd:13c8  - inc       di
    79dd:13c9  - dec       cx
    79dd:13ca  - jne       _LOOP
    79dd:13cc  - pop       cx
    79dd:13cd  - pop       di
    79dd:13ce  - pop       es
    79dd:13cf  - mov       ds,dx
    79dd:13d1  - mov       al,byte ptr ds:[bp+04]
    79dd:13d5  - test      al,10
    79dd:13d7  - jne       _FR
    79dd:13d9  - test      al,40
    79dd:13db  - jne       _EXT
    79dd:13dd  - and       al,7F
    79dd:13df  - or        byte ptr ss:[0ACE],al
    79dd:13e4  - mov       dx,word ptr ds:[bp+0A]
    79dd:13e8  - mov       cx,word ptr ds:[bp+0C]
    79dd:13ec  - mov       ds,word ptr ss:[9A8C]
    79dd:13f1  - xor       al,al
    79dd:13f3  - jmp       LNUMOUT
             _EXT:
    79dd:13f6  - mov       cx,ds
    79dd:13f8  - mov       dx,bp
    79dd:13fa  - mov       ds,word ptr ss:[9A8C]
    79dd:13ff  - or        byte ptr ss:[0ACE],40
    79dd:1405  - mov       al,01
    79dd:1407  - or        al,al
    79dd:1409  - jmp       LNUMOUT
             _FR:
    79dd:140c  - mov       cx,ds
    79dd:140e  - mov       dx,bp
    79dd:1410  - mov       ds,word ptr ss:[9A8C]
    79dd:1415  - or        byte ptr ss:[0ACE],80
    79dd:141b  - mov       al,01
    79dd:141d  - or        al,al
    79dd:141f  - jmp       LNUMOUT
             _NOTSAME:
    79dd:1422  - pop       cx
    79dd:1423  - pop       di
    79dd:1424  - pop       es
    79dd:1425  - mov       ds,dx
    79dd:1427  - jmp       _NEXT
             _NOTTHERE:
    79dd:142a  - or        byte ptr ss:[0ACE],80
    79dd:1430  - mov       ds,word ptr ss:[9A8C]
    79dd:1435  - mov       si,word ptr ss:[9A8E]
    79dd:143a  - mov       al,byte ptr [0F88]
    79dd:143e  - or        al,al
    79dd:1440  - jne       _NOFRBLK
    79dd:1442  - mov       al,byte ptr [0F8B]
    79dd:1446  - push      ax
    79dd:1447  - call      ADDSYMBOL
    79dd:144a  - pop       ax
    79dd:144b  - mov       byte ptr [0F8B],al
    79dd:144f  - push      es
    79dd:1450  - push      di
    79dd:1451  - mov       es,word ptr ss:[0F7C]
    79dd:1456  - mov       di,word ptr ss:[0F7E]
    79dd:145b  - mov       byte ptr es:[di+04],11
    79dd:1460  - mov       cx,es
    79dd:1462  - mov       dx,di
    79dd:1464  - pop       di
    79dd:1465  - pop       es
    79dd:1466  - mov       ax,word ptr [0F84]
    79dd:146a    mov       word ptr [0F80],ax
    79dd:146e    mov       ax,word ptr [0F86]
    79dd:1472    mov       word ptr [0F82],ax
    79dd:1476    mov       ax,word ptr [0F70]
    79dd:147a    mov       word ptr [0F6E],ax
    79dd:147e  - mov       al,01
    79dd:1480  - or        al,al
    79dd:1482  - jmp       LNUMOUT
             _NOFRBLK:
    79dd:1485  - mov       bx,79A9
             _NOFRBLP:
    79dd:1488  - lodsb
    79dd:1489  - xlat
    79dd:148b  - or        al,al
    79dd:148d  - jns       _NOFRBLP
    79dd:148f  - dec       si
    79dd:1490  - mov       al,01
    79dd:1492  - or        al,al
    79dd:1494  - jmp       LNUMOUT
    79dd:1497  - push      dx
    79dd:1498    mov       dx,87D2
    79dd:149b    call      ERROR_ROUT
    79dd:149e    pop       dx
             EVAL_STRLEN:
    79dd:149f    push      bx
    79dd:14a0  - mov       bx,76A7
    79dd:14a3  - lodsb
    79dd:14a4    xlat
    79dd:14a6    or        al,al
    79dd:14a8    js        14A3
    79dd:14aa    dec       si
    79dd:14ab  - pop       bx
    79dd:14ac  - push      es
    79dd:14ad  - push      di
    79dd:14ae  - mov       ax,ss
    79dd:14b0  - mov       es,ax
    79dd:14b2  - mov       di,9778
    79dd:14b5  - call      GETSTR
    79dd:14b8  - pop       di
    79dd:14b9  - pop       es
    79dd:14ba  - push      ds
    79dd:14bb  - push      si
    79dd:14bc  - mov       ax,ss
    79dd:14be  - mov       ds,ax
    79dd:14c0  - mov       si,9778
    79dd:14c3  - xor       cx,cx
             STRLENLP:
    79dd:14c5  - lodsb
    79dd:14c6  - inc       cx
    79dd:14c7  - or        al,al
    79dd:14c9  - jne       STRLENLP
    79dd:14cb  - dec       cx
    79dd:14cc  - pop       si
    79dd:14cd  - pop       ds
    79dd:14ce  - xor       dx,dx
    79dd:14d0  - ret
             EVAL_STRCMP:
    79dd:14d1  - push      bx
    79dd:14d2  - mov       bx,76A7
    79dd:14d5  - lodsb
    79dd:14d6    xlat
    79dd:14d8    or        al,al
    79dd:14da    js        14D5
    79dd:14dc    dec       si
    79dd:14dd  - pop       bx
    79dd:14de  - push      es
    79dd:14df  - push      di
    79dd:14e0  - mov       ax,ss
    79dd:14e2  - mov       es,ax
    79dd:14e4  - mov       di,9778
    79dd:14e7  - call      GETSTR
    79dd:14ea  - lodsb
    79dd:14eb  - cmp       al,2C
    79dd:14ed  - je        14F2
    79dd:14ef    jmp       EAERR
    79dd:14f2  - mov       ax,ss
    79dd:14f4  - mov       es,ax
    79dd:14f6  - mov       di,9878
    79dd:14f9  - call      GETSTR
    79dd:14fc  - call      COMPSTRINGS
    79dd:14ff  - pop       di
    79dd:1500  - pop       es
    79dd:1501  - ret
             GETSTRREAL1:
    79dd:1502  - lodsb
    79dd:1503  - stosb
    79dd:1504  - cmp       al,22
    79dd:1506  - jne       GETSTRREAL1
    79dd:1508  - mov       byte ptr es:[di+FF],00
    79dd:150d  - ret
             GETSTRREAL2:
    79dd:150e  - lodsb
    79dd:150f  - stosb
    79dd:1510  - cmp       al,27
    79dd:1512  - jne       GETSTRREAL2
    79dd:1514  - mov       byte ptr es:[di+FF],00
    79dd:1519  - ret
             GETSTR:
    79dd:151a  - lodsb
    79dd:151b  - cmp       al,22
    79dd:151d  - je        GETSTRREAL1
    79dd:151f  - cmp       al,27
    79dd:1521  - je        GETSTRREAL2
    79dd:1523  - dec       si
    79dd:1524  - call      GETSTRINGADDR
    79dd:1527  - push      ds
    79dd:1528  - push      si
    79dd:1529  - mov       si,cx
    79dd:152b  - mov       ds,dx
             GETSTRLP:
    79dd:152d  - lodsb
    79dd:152e  - stosb
    79dd:152f  - or        al,al
    79dd:1531  - jne       GETSTRLP
    79dd:1533  - pop       si
    79dd:1534  - pop       ds
    79dd:1535  - ret
             COMPSTRINGS:
    79dd:1536  - push      ds
    79dd:1537  - push      si
    79dd:1538  - push      es
    79dd:1539  - push      di
    79dd:153a  - mov       ax,ss
    79dd:153c  - mov       ds,ax
    79dd:153e  - mov       es,ax
    79dd:1540  - mov       si,9778
    79dd:1543  - mov       di,9878
             COMPLP:
    79dd:1546  - lodsb
    79dd:1547  - mov       dl,byte ptr es:[di]
    79dd:154a  - inc       di
    79dd:154b  - or        al,al
    79dd:154d  - je        STRCMPSAME
    79dd:154f  - or        dl,dl
    79dd:1551  - je        STRCMPSAME2
    79dd:1553  - cmp       al,dl
    79dd:1555  - jne       STRCMPDIFF
    79dd:1557  - jmp       COMPLP
             STRCMPSAME2:
    79dd:1559  - or        al,al
    79dd:155b  - jne       STRCMPDIFF
             STRCMPSAME:
    79dd:155d  - or        dl,dl
    79dd:155f  - jne       STRCMPDIFF
    79dd:1561  - pop       di
    79dd:1562  - pop       es
    79dd:1563  - pop       si
    79dd:1564  - pop       ds
    79dd:1565  - mov       cx,FFFF
    79dd:1568  - mov       dx,FFFF
    79dd:156b  - ret
             STRCMPDIFF:
    79dd:156c  - pop       di
    79dd:156d  - pop       es
    79dd:156e  - pop       si
    79dd:156f  - pop       ds
    79dd:1570  - xor       cx,cx
    79dd:1572  - xor       dx,dx
    79dd:1574  - ret
             NORMEXPRESS:
    79dd:1575  - mov       ax,ss
    79dd:1577  - mov       es,ax
    79dd:1579  - mov       di,0BCB
    79dd:157c  - lodsw
    79dd:157d  - mov       word ptr [0BCF],ax
    79dd:1581  - lodsw
    79dd:1582  - mov       word ptr [0BCB],ax
    79dd:1586  - lodsw
    79dd:1587  - mov       word ptr [0BCD],ax
             NEXPLOOP:
    79dd:158b  - lodsw
             NEXPLOOP2:
    79dd:158c  - mov       dx,ax
    79dd:158e  - and       dx,00FF
    79dd:1592  - mov       cx,word ptr es:[di+04]
    79dd:1596  - and       cx,00FF
    79dd:159a  - cmp       dx,cx
    79dd:159c  - ja        HIGHER
    79dd:159e  - push      ax
    79dd:159f  - xor       ah,ah
    79dd:15a1  - mov       al,byte ptr es:[di+05]
    79dd:15a5  - mov       bp,ax
    79dd:15a7  - jmp       word ptr [bp+6CDB]
             HIGHER:
    79dd:15ab  - mov       word ptr es:[di+FE],ax
    79dd:15af  - lodsw
    79dd:15b0  - mov       word ptr es:[di+FA],ax
    79dd:15b4  - lodsw
    79dd:15b5  - mov       word ptr es:[di+FC],ax
    79dd:15b9  - sub       di,06
    79dd:15bc  - jmp       NEXPLOOP
             NCALC:
    79dd:15be  - pop       ax
    79dd:15bf  - jmp       NEXPLOOP2
             CALCEND:
    79dd:15c1  - mov       cx,word ptr es:[di]
    79dd:15c4  - mov       dx,word ptr es:[di+02]
    79dd:15c8  - pop       ax
    79dd:15c9  - ret
             CALCSHIFTR:
    79dd:15ca  - cmp       word ptr es:[di+02],00
    79dd:15cf  - jne       N_TOOBIGSHIFT
    79dd:15d1  - mov       cx,word ptr es:[di]
    79dd:15d4  - cmp       cx,20
    79dd:15d7  - ja        N_TOOBIGSHIFT
    79dd:15d9  - mov       ax,word ptr es:[di+08]
    79dd:15dd  - mov       dx,word ptr es:[di+06]
    79dd:15e1  - cmp       cx,00
    79dd:15e4  - je        EASR2
             EASR1:
    79dd:15e6  - shr       ax,1
    79dd:15e8  - rcr       dx,1
    79dd:15ea  - dec       cx
    79dd:15eb  - jne       EASR1
             EASR2:
    79dd:15ed  - mov       word ptr es:[di+08],ax
    79dd:15f1  - mov       word ptr es:[di+06],dx
    79dd:15f5  - add       di,06
    79dd:15f8  - jmp       NCALC
             N_TOOBIGSHIFT:
    79dd:15fa  - test      byte ptr ss:[0AD0],FF
    79dd:1600  - jne       N_FR
    79dd:1602  - push      dx
    79dd:1603    mov       dx,843A
    79dd:1606    call      ERROR_ROUT
    79dd:1609    pop       dx
             N_FR:
    79dd:160a  - push      dx
    79dd:160b    mov       dx,843A
    79dd:160e    call      INSFRERR1
    79dd:1611    pop       dx
    79dd:1612  - mov       cx,0001
    79dd:1615  - xor       dx,dx
    79dd:1617  - jmp       CALCEND
             CALCSHIFTL:
    79dd:1619  - cmp       word ptr es:[di+02],00
    79dd:161e  - jne       N_TOOBIGSHIFT
    79dd:1620  - mov       cx,word ptr es:[di]
    79dd:1623  - cmp       cx,20
    79dd:1626  - ja        N_TOOBIGSHIFT
    79dd:1628  - mov       ax,word ptr es:[di+08]
    79dd:162c  - mov       dx,word ptr es:[di+06]
    79dd:1630  - cmp       cx,00
    79dd:1633  - je        EASL2
             EASL1:
    79dd:1635  - shl       dx,1
    79dd:1637  - rcl       ax,1
    79dd:1639  - dec       cx
    79dd:163a  - jne       EASL1
             EASL2:
    79dd:163c  - mov       word ptr es:[di+08],ax
    79dd:1640  - mov       word ptr es:[di+06],dx
    79dd:1644  - add       di,06
    79dd:1647  - jmp       NCALC
             CALCEQ:
    79dd:164a  - mov       ax,word ptr es:[di+08]
    79dd:164e  - cmp       ax,word ptr es:[di+02]
    79dd:1652  - jne       CALCEQ_F
    79dd:1654  - mov       ax,word ptr es:[di+06]
    79dd:1658  - cmp       ax,word ptr es:[di]
    79dd:165b  - jne       CALCEQ_F
    79dd:165d  - mov       word ptr es:[di+06],FFFF
    79dd:1663  - mov       word ptr es:[di+08],FFFF
    79dd:1669  - add       di,06
    79dd:166c  - jmp       NCALC
             CALCEQ_F:
    79dd:166f  - mov       word ptr es:[di+06],0000
    79dd:1675  - mov       word ptr es:[di+08],0000
    79dd:167b  - add       di,06
    79dd:167e  - jmp       NCALC
             CALCGT:
    79dd:1681  - mov       ax,word ptr es:[di+08]
    79dd:1685  - cmp       ax,word ptr es:[di+02]
    79dd:1689  - jb        CALCEQ_F
    79dd:168b  - mov       ax,word ptr es:[di+06]
    79dd:168f  - cmp       ax,word ptr es:[di]
    79dd:1692  - jbe       CALCEQ_F
    79dd:1694  - mov       word ptr es:[di+06],FFFF
    79dd:169a  - mov       word ptr es:[di+08],FFFF
    79dd:16a0  - add       di,06
    79dd:16a3  - jmp       NCALC
             CALCLT:
    79dd:16a6  - mov       ax,word ptr es:[di+08]
    79dd:16aa  - cmp       ax,word ptr es:[di+02]
    79dd:16ae  - ja        CALCEQ_F
    79dd:16b0  - mov       ax,word ptr es:[di+06]
    79dd:16b4  - cmp       ax,word ptr es:[di]
    79dd:16b7  - jae       CALCEQ_F
    79dd:16b9  - mov       word ptr es:[di+06],FFFF
    79dd:16bf  - mov       word ptr es:[di+08],FFFF
    79dd:16c5  - add       di,06
    79dd:16c8  - jmp       NCALC
             CALCADD:
    79dd:16cb  - mov       ax,word ptr es:[di+06]
    79dd:16cf  - add       ax,word ptr es:[di]
    79dd:16d2  - mov       word ptr es:[di+06],ax
    79dd:16d6  - mov       ax,word ptr es:[di+08]
    79dd:16da  - adc       ax,word ptr es:[di+02]
    79dd:16de  - mov       word ptr es:[di+08],ax
    79dd:16e2  - add       di,06
    79dd:16e5  - jmp       NCALC
             CALCSUB:
    79dd:16e8  - mov       ax,word ptr es:[di+06]
    79dd:16ec  - sub       ax,word ptr es:[di]
    79dd:16ef  - mov       word ptr es:[di+06],ax
    79dd:16f3  - mov       ax,word ptr es:[di+08]
    79dd:16f7  - sbb       ax,word ptr es:[di+02]
    79dd:16fb  - mov       word ptr es:[di+08],ax
    79dd:16ff  - add       di,06
    79dd:1702  - jmp       NCALC
             CALCMUL:
    79dd:1705  - mov       ax,word ptr es:[di]
    79dd:1708  - mov       dx,word ptr es:[di+02]
    79dd:170c  - mov       cx,word ptr es:[di+08]
    79dd:1710  - mov       bx,word ptr es:[di+06]
    79dd:1714  - push      si
    79dd:1715  - mov       si,dx
    79dd:1717  - xchg      cx,ax
    79dd:1718  - or        ax,ax
    79dd:171a  - je        EM1
    79dd:171c  - mul       cx
             EM1:
    79dd:171e  - xchg      si,ax
    79dd:171f  - or        ax,ax
    79dd:1721  - je        EM2
    79dd:1723  - mul       bx
    79dd:1725  - add       si,ax
             EM2:
    79dd:1727  - mov       ax,cx
    79dd:1729  - mul       bx
    79dd:172b  - add       dx,si
    79dd:172d  - pop       si
    79dd:172e  - mov       word ptr es:[di+08],dx
    79dd:1732  - mov       word ptr es:[di+06],ax
    79dd:1736  - add       di,06
    79dd:1739  - jmp       NCALC
             ULDIV:
    79dd:173c  - or        dx,dx
    79dd:173e  - jne       D3
    79dd:1740  - div       bx
    79dd:1742  - mov       bx,dx
    79dd:1744  - mov       dx,cx
    79dd:1746  - ret
             D3:
    79dd:1747  - mov       cx,ax
    79dd:1749  - mov       ax,dx
    79dd:174b  - xor       dx,dx
    79dd:174d  - div       bx
    79dd:174f  - xchg      cx,ax
    79dd:1750  - div       bx
    79dd:1752  - mov       bx,dx
    79dd:1754  - mov       dx,cx
    79dd:1756  - xor       cx,cx
    79dd:1758  - ret
             _ULDIV:
    79dd:1759  - jcxz      ULDIV
    79dd:175b  - push      di
    79dd:175c  - push      bp
    79dd:175d  - mov       bp,0001
    79dd:1760  - or        ch,ch
    79dd:1762  - js        L1
    79dd:1764  - jne       L2
    79dd:1766  - add       bp,08
    79dd:1769  - mov       ch,cl
    79dd:176b  - mov       cl,bh
    79dd:176d  - mov       bh,bl
    79dd:176f  - xor       bl,bl
    79dd:1771  - or        ch,ch
    79dd:1773  - js        L1
             L2:
    79dd:1775  - inc       bp
    79dd:1776  - shl       bx,1
    79dd:1778  - rcl       cx,1
    79dd:177a  - jno       L2
             L1:
    79dd:177c  - mov       si,cx
    79dd:177e  - mov       di,bx
    79dd:1780  - mov       cx,dx
    79dd:1782  - mov       bx,ax
    79dd:1784  - xor       ax,ax
    79dd:1786  - cwd
             L4:
    79dd:1787  - cmp       si,cx
    79dd:1789  - ja        L3
    79dd:178b  - jb        L5
    79dd:178d  - cmp       di,bx
    79dd:178f  - ja        L3
             L5:
    79dd:1791  - sub       bx,di
    79dd:1793  - sbb       cx,si
    79dd:1795  - stc
             L3:
    79dd:1796  - rcl       ax,1
    79dd:1798  - rcl       dx,1
    79dd:179a  - shr       si,1
    79dd:179c  - rcr       di,1
    79dd:179e  - dec       bp
    79dd:179f  - jne       L4
    79dd:17a1  - pop       bp
    79dd:17a2  - pop       di
    79dd:17a3  - ret
             L10:
    79dd:17a4  - or        cx,cx
    79dd:17a6  - jns       _ULDIV
    79dd:17a8  - neg       cx
    79dd:17aa    neg       bx
    79dd:17ac    sbb       cx,00
    79dd:17af  - call      _ULDIV
             L12:
    79dd:17b2  - neg       dx
    79dd:17b4    neg       ax
    79dd:17b6    sbb       dx,00
    79dd:17b9  - ret
             CALCMOD:
    79dd:17ba  - mov       dx,word ptr ss:[di+02]
    79dd:17be  - mov       ax,word ptr ss:[di]
    79dd:17c1  - mov       cx,word ptr ss:[di+08]
    79dd:17c5  - or        cx,cx
    79dd:17c7  - jne       CLMODER
    79dd:17c9  - mov       cx,word ptr ss:[di+06]
    79dd:17cd  - or        cx,cx
    79dd:17cf  - je        CLMODER
    79dd:17d1  - div       cx
    79dd:17d3  - mov       word ptr ss:[di+06],dx
    79dd:17d7  - xor       dx,dx
    79dd:17d9  - mov       word ptr ss:[di+08],dx
    79dd:17dd  - add       di,06
    79dd:17e0  - jmp       NCALC
             CLMODER:
    79dd:17e3  - push      dx
    79dd:17e4    mov       dx,847A
    79dd:17e7    call      ERROR_ROUT
    79dd:17ea    pop       dx
             CALCDIV:
    79dd:17eb    push      si
    79dd:17ec  - mov       dx,word ptr es:[di+08]
    79dd:17f0  - mov       ax,word ptr es:[di+06]
    79dd:17f4  - mov       cx,word ptr es:[di+02]
    79dd:17f8  - mov       bx,word ptr es:[di]
    79dd:17fb  - or        bx,bx
    79dd:17fd  - je        EDIVZ
             EDIV1:
    79dd:17ff  - call      _LDIV
    79dd:1802  - mov       word ptr es:[di+08],dx
    79dd:1806  - mov       word ptr es:[di+06],ax
    79dd:180a  - pop       si
    79dd:180b  - add       di,06
    79dd:180e  - jmp       NCALC
             EDIVZ:
    79dd:1811  - or        cx,cx
    79dd:1813  - jne       EDIV1
    79dd:1815  - push      dx
    79dd:1816    mov       dx,846A
    79dd:1819    call      ERROR_ROUT
    79dd:181c    pop       dx
             _LDIV:
    79dd:181d    or        dx,dx
    79dd:181f  - jns       L10
    79dd:1821  - neg       dx
    79dd:1823    neg       ax
    79dd:1825    sbb       dx,00
    79dd:1828  - or        cx,cx
    79dd:182a  - jns       L11
    79dd:182c  - neg       cx
    79dd:182e    neg       bx
    79dd:1830    sbb       cx,00
    79dd:1833  - call      _ULDIV
    79dd:1836  - neg       cx
    79dd:1838    neg       bx
    79dd:183a    sbb       cx,00
    79dd:183d  - ret
             L11:
    79dd:183e  - call      _ULDIV
    79dd:1841  - neg       cx
    79dd:1843    neg       bx
    79dd:1845    sbb       cx,00
    79dd:1848  - jmp       L12
             CALCOR:
    79dd:184b  - mov       ax,word ptr es:[di+08]
    79dd:184f  - or        ax,word ptr es:[di+02]
    79dd:1853  - mov       word ptr es:[di+08],ax
    79dd:1857  - mov       ax,word ptr es:[di+06]
    79dd:185b  - or        ax,word ptr es:[di]
    79dd:185e  - mov       word ptr es:[di+06],ax
    79dd:1862  - add       di,06
    79dd:1865  - jmp       NCALC
             CALCAND:
    79dd:1868  - mov       ax,word ptr es:[di+08]
    79dd:186c  - and       ax,word ptr es:[di+02]
    79dd:1870  - mov       word ptr es:[di+08],ax
    79dd:1874  - mov       ax,word ptr es:[di+06]
    79dd:1878  - and       ax,word ptr es:[di]
    79dd:187b  - mov       word ptr es:[di+06],ax
    79dd:187f  - add       di,06
    79dd:1882  - jmp       NCALC
             CALCXOR:
    79dd:1885  - mov       ax,word ptr es:[di+08]
    79dd:1889  - xor       ax,word ptr es:[di+02]
    79dd:188d  - mov       word ptr es:[di+08],ax
    79dd:1891  - mov       ax,word ptr es:[di+06]
    79dd:1895  - xor       ax,word ptr es:[di]
    79dd:1898  - mov       word ptr es:[di+06],ax
    79dd:189c  - add       di,06
    79dd:189f  - jmp       NCALC
             CALCNOT:
    79dd:18a2  - mov       ax,word ptr es:[di]
    79dd:18a5  - not       ax
    79dd:18a7  - mov       word ptr es:[di+06],ax
    79dd:18ab  - mov       ax,word ptr es:[di+02]
    79dd:18af  - not       ax
    79dd:18b1  - mov       word ptr es:[di+08],ax
    79dd:18b5  - add       di,06
    79dd:18b8  - jmp       NCALC
             CALCNEG:
    79dd:18bb  - xor       ax,ax
    79dd:18bd  - sub       ax,word ptr es:[di]
    79dd:18c0  - mov       word ptr es:[di+06],ax
    79dd:18c4  - mov       ax,0000
    79dd:18c7  - sbb       ax,word ptr es:[di+02]
    79dd:18cb  - mov       word ptr es:[di+08],ax
    79dd:18cf  - add       di,06
    79dd:18d2  - jmp       NCALC
             CALCHIBYTE:
    79dd:18d5  - xor       ax,ax
    79dd:18d7  - mov       word ptr es:[di+08],ax
    79dd:18db  - mov       al,byte ptr es:[di+01]
    79dd:18df  - mov       word ptr es:[di+06],ax
    79dd:18e3  - add       di,06
    79dd:18e6  - jmp       NCALC
             CALCLOBYTE:
    79dd:18e9  - xor       ax,ax
    79dd:18eb  - mov       word ptr es:[di+08],ax
    79dd:18ef  - mov       al,byte ptr es:[di]
    79dd:18f2  - mov       word ptr es:[di+06],ax
    79dd:18f6  - add       di,06
    79dd:18f9  - jmp       NCALC
             FREXPRESS:
    79dd:18fc  - mov       byte ptr ss:[0ACE],00
    79dd:1902  - mov       di,0BCB
    79dd:1905  - lodsw
    79dd:1906  - test      al,80
    79dd:1908    je        1926
    79dd:190a    mov       es,word ptr [si]
    79dd:190c    mov       bp,word ptr [si+02]
    79dd:190f    test      byte ptr es:[bp+04],52
    79dd:1914    jne       FEXPERR
    79dd:1916    mov       dx,word ptr es:[bp+0C]
    79dd:191a    mov       word ptr [si],dx
    79dd:191c    mov       dx,word ptr es:[bp+0A]
    79dd:1920    mov       word ptr [si+02],dx
    79dd:1923    and       ax,FF7F
    79dd:1926  - mov       word ptr [0BCF],ax
    79dd:192a  - lodsw
    79dd:192b  - mov       word ptr [0BCB],ax
    79dd:192f  - lodsw
    79dd:1930  - mov       word ptr [0BCD],ax
             FEXPLOOP:
    79dd:1934  - lodsw
    79dd:1935  - test      al,80
    79dd:1937    je        FEXPLOOP2
    79dd:1939    mov       es,word ptr [si]
    79dd:193b    mov       bp,word ptr [si+02]
    79dd:193e    test      byte ptr es:[bp+04],52
    79dd:1943    jne       FEXPERR
    79dd:1945    mov       dx,word ptr es:[bp+0C]
    79dd:1949    mov       word ptr [si],dx
    79dd:194b    mov       dx,word ptr es:[bp+0A]
    79dd:194f    mov       word ptr [si+02],dx
    79dd:1952    and       ax,FF7F
             FEXPLOOP2:
    79dd:1955    mov       dx,ax
    79dd:1957  - and       dx,00FF
    79dd:195b  - mov       cx,word ptr ss:[di+04]
    79dd:195f  - and       cx,00FF
    79dd:1963  - cmp       dx,cx
    79dd:1965  - ja        FHIGHER
    79dd:1967  - push      ax
    79dd:1968  - xor       ah,ah
    79dd:196a  - mov       al,byte ptr ss:[di+05]
    79dd:196e  - mov       bp,ax
    79dd:1970  - jmp       word ptr [bp+6D03]
             FHIGHER:
    79dd:1974  - mov       word ptr ss:[di+FE],ax
    79dd:1978  - lodsw
    79dd:1979  - mov       word ptr ss:[di+FA],ax
    79dd:197d  - lodsw
    79dd:197e  - mov       word ptr ss:[di+FC],ax
    79dd:1982  - sub       di,06
    79dd:1985  - jmp       FEXPLOOP
             FCALC:
    79dd:1987  - pop       ax
    79dd:1988  - jmp       FEXPLOOP2
             FEXPERR:
    79dd:198a  - mov       word ptr ss:[9A8C],es
    79dd:198f  - mov       word ptr ss:[9A8E],bp
    79dd:1994  - xor       cx,cx
    79dd:1996  - xor       dx,dx
    79dd:1998  - mov       al,01
    79dd:199a  - or        al,al
    79dd:199c  - ret
             FCALCEND:
    79dd:199d  - mov       cx,word ptr ss:[di]
    79dd:19a0  - mov       dx,word ptr ss:[di+02]
    79dd:19a4  - pop       ax
    79dd:19a5  - ret
             FCALCSHIFTR:
    79dd:19a6  - cmp       word ptr ss:[di+02],00
    79dd:19ab  - jne       FTOOBIGSHIFT
    79dd:19ad  - mov       cx,word ptr ss:[di]
    79dd:19b0  - cmp       cx,20
    79dd:19b3  - ja        FTOOBIGSHIFT
    79dd:19b5  - mov       ax,word ptr ss:[di+08]
    79dd:19b9  - mov       dx,word ptr ss:[di+06]
    79dd:19bd  - cmp       cx,00
    79dd:19c0  - je        FEASR2
             FEASR1:
    79dd:19c2  - shr       ax,1
    79dd:19c4  - rcr       dx,1
    79dd:19c6  - dec       cx
    79dd:19c7  - jne       FEASR1
             FEASR2:
    79dd:19c9  - mov       word ptr ss:[di+08],ax
    79dd:19cd  - mov       word ptr ss:[di+06],dx
    79dd:19d1  - add       di,06
    79dd:19d4  - jmp       FCALC
             FTOOBIGSHIFT:
    79dd:19d6  - push      dx
    79dd:19d7    mov       dx,843A
    79dd:19da    call      ERROR_ROUT
    79dd:19dd    pop       dx
             FCALCSHIFTL:
    79dd:19de  - cmp       word ptr ss:[di+02],00
    79dd:19e3  - jne       FTOOBIGSHIFT
    79dd:19e5  - mov       cx,word ptr ss:[di]
    79dd:19e8  - cmp       cx,20
    79dd:19eb  - ja        FTOOBIGSHIFT
    79dd:19ed  - mov       ax,word ptr ss:[di+08]
    79dd:19f1  - mov       dx,word ptr ss:[di+06]
    79dd:19f5  - cmp       cx,00
    79dd:19f8  - je        FEASL2
             FEASL1:
    79dd:19fa  - shl       dx,1
    79dd:19fc  - rcl       ax,1
    79dd:19fe  - dec       cx
    79dd:19ff  - jne       FEASL1
             FEASL2:
    79dd:1a01  - mov       word ptr ss:[di+08],ax
    79dd:1a05  - mov       word ptr ss:[di+06],dx
    79dd:1a09  - add       di,06
    79dd:1a0c  - jmp       FCALC
             FCALCEQ:
    79dd:1a0f  - mov       ax,word ptr ss:[di+08]
    79dd:1a13  - cmp       ax,word ptr ss:[di+02]
    79dd:1a17  - jne       FCALCEQ_F
    79dd:1a19  - mov       ax,word ptr ss:[di+06]
    79dd:1a1d  - cmp       ax,word ptr ss:[di]
    79dd:1a20  - jne       FCALCEQ_F
    79dd:1a22  - mov       word ptr ss:[di+06],FFFF
    79dd:1a28  - mov       word ptr ss:[di+08],FFFF
    79dd:1a2e  - add       di,06
    79dd:1a31  - jmp       FCALC
             FCALCEQ_F:
    79dd:1a34  - mov       word ptr ss:[di+06],0000
    79dd:1a3a  - mov       word ptr ss:[di+08],0000
    79dd:1a40  - add       di,06
    79dd:1a43  - jmp       FCALC
             FCALCGT:
    79dd:1a46  - mov       ax,word ptr ss:[di+08]
    79dd:1a4a  - cmp       ax,word ptr ss:[di+02]
    79dd:1a4e  - jb        FCALCEQ_F
    79dd:1a50  - mov       ax,word ptr ss:[di+06]
    79dd:1a54  - cmp       ax,word ptr ss:[di]
    79dd:1a57  - jbe       FCALCEQ_F
    79dd:1a59  - mov       word ptr ss:[di+06],FFFF
    79dd:1a5f  - mov       word ptr ss:[di+08],FFFF
    79dd:1a65  - add       di,06
    79dd:1a68  - jmp       FCALC
             FCALCLT:
    79dd:1a6b  - mov       ax,word ptr ss:[di+08]
    79dd:1a6f  - cmp       ax,word ptr ss:[di+02]
    79dd:1a73  - ja        FCALCEQ_F
    79dd:1a75  - mov       ax,word ptr ss:[di+06]
    79dd:1a79  - cmp       ax,word ptr ss:[di]
    79dd:1a7c  - jae       FCALCEQ_F
    79dd:1a7e  - mov       word ptr ss:[di+06],FFFF
    79dd:1a84  - mov       word ptr ss:[di+08],FFFF
    79dd:1a8a  - add       di,06
    79dd:1a8d  - jmp       FCALC
             FCALCADD:
    79dd:1a90  - mov       ax,word ptr ss:[di+06]
    79dd:1a94  - add       ax,word ptr ss:[di]
    79dd:1a97  - mov       word ptr ss:[di+06],ax
    79dd:1a9b  - mov       ax,word ptr ss:[di+08]
    79dd:1a9f  - adc       ax,word ptr ss:[di+02]
    79dd:1aa3  - mov       word ptr ss:[di+08],ax
    79dd:1aa7  - add       di,06
    79dd:1aaa  - jmp       FCALC
             FCALCSUB:
    79dd:1aad  - mov       ax,word ptr ss:[di+06]
    79dd:1ab1  - sub       ax,word ptr ss:[di]
    79dd:1ab4  - mov       word ptr ss:[di+06],ax
    79dd:1ab8  - mov       ax,word ptr ss:[di+08]
    79dd:1abc  - sbb       ax,word ptr ss:[di+02]
    79dd:1ac0  - mov       word ptr ss:[di+08],ax
    79dd:1ac4  - add       di,06
    79dd:1ac7  - jmp       FCALC
             FCALCMUL:
    79dd:1aca  - mov       ax,word ptr ss:[di]
    79dd:1acd  - mov       dx,word ptr ss:[di+02]
    79dd:1ad1  - mov       cx,word ptr ss:[di+08]
    79dd:1ad5  - mov       bx,word ptr ss:[di+06]
    79dd:1ad9  - push      si
    79dd:1ada  - mov       si,dx
    79dd:1adc  - xchg      cx,ax
    79dd:1add  - or        ax,ax
    79dd:1adf  - je        FEM1
    79dd:1ae1  - mul       cx
             FEM1:
    79dd:1ae3  - xchg      si,ax
    79dd:1ae4  - or        ax,ax
    79dd:1ae6  - je        FEM2
    79dd:1ae8  - mul       bx
    79dd:1aea  - add       si,ax
             FEM2:
    79dd:1aec  - mov       ax,cx
    79dd:1aee  - mul       bx
    79dd:1af0  - add       dx,si
    79dd:1af2  - pop       si
    79dd:1af3  - mov       word ptr ss:[di+08],dx
    79dd:1af7  - mov       word ptr ss:[di+06],ax
    79dd:1afb  - add       di,06
    79dd:1afe  - jmp       FCALC
             FULDIV:
    79dd:1b01  - or        dx,dx
    79dd:1b03  - jne       FD3
    79dd:1b05  - div       bx
    79dd:1b07  - mov       bx,dx
    79dd:1b09  - mov       dx,cx
    79dd:1b0b  - ret
             FD3:
    79dd:1b0c  - mov       cx,ax
    79dd:1b0e  - mov       ax,dx
    79dd:1b10  - xor       dx,dx
    79dd:1b12  - div       bx
    79dd:1b14  - xchg      cx,ax
    79dd:1b15  - div       bx
    79dd:1b17  - mov       bx,dx
    79dd:1b19  - mov       dx,cx
    79dd:1b1b  - xor       cx,cx
    79dd:1b1d  - ret
             F_ULDIV:
    79dd:1b1e  - jcxz      FULDIV
    79dd:1b20  - push      di
    79dd:1b21  - push      bp
    79dd:1b22  - mov       bp,0001
    79dd:1b25  - or        ch,ch
    79dd:1b27  - js        FL1
    79dd:1b29  - jne       FL2
    79dd:1b2b  - add       bp,08
    79dd:1b2e  - mov       ch,cl
    79dd:1b30  - mov       cl,bh
    79dd:1b32  - mov       bh,bl
    79dd:1b34  - xor       bl,bl
    79dd:1b36  - or        ch,ch
    79dd:1b38  - js        FL1
             FL2:
    79dd:1b3a  - inc       bp
    79dd:1b3b  - shl       bx,1
    79dd:1b3d  - rcl       cx,1
    79dd:1b3f  - jno       FL2
             FL1:
    79dd:1b41  - mov       si,cx
    79dd:1b43  - mov       di,bx
    79dd:1b45  - mov       cx,dx
    79dd:1b47  - mov       bx,ax
    79dd:1b49  - xor       ax,ax
    79dd:1b4b  - cwd
             FL4:
    79dd:1b4c  - cmp       si,cx
    79dd:1b4e  - ja        FL3
    79dd:1b50  - jb        FL5
    79dd:1b52  - cmp       di,bx
    79dd:1b54  - ja        FL3
             FL5:
    79dd:1b56  - sub       bx,di
    79dd:1b58  - sbb       cx,si
    79dd:1b5a  - stc
             FL3:
    79dd:1b5b  - rcl       ax,1
    79dd:1b5d  - rcl       dx,1
    79dd:1b5f  - shr       si,1
    79dd:1b61  - rcr       di,1
    79dd:1b63  - dec       bp
    79dd:1b64  - jne       FL4
    79dd:1b66  - pop       bp
    79dd:1b67  - pop       di
    79dd:1b68  - ret
             FL10:
    79dd:1b69  - or        cx,cx
    79dd:1b6b  - jns       F_ULDIV
    79dd:1b6d  - neg       cx
    79dd:1b6f    neg       bx
    79dd:1b71    sbb       cx,00
    79dd:1b74  - call      F_ULDIV
             FL12:
    79dd:1b77  - neg       dx
    79dd:1b79    neg       ax
    79dd:1b7b    sbb       dx,00
    79dd:1b7e  - ret
             FCALCMOD:
    79dd:1b7f  - mov       dx,word ptr ss:[di+02]
    79dd:1b83  - mov       ax,word ptr ss:[di]
    79dd:1b86  - mov       cx,word ptr ss:[di+08]
    79dd:1b8a  - or        cx,cx
    79dd:1b8c  - jne       FCLMODER
    79dd:1b8e  - mov       cx,word ptr ss:[di+06]
    79dd:1b92  - or        cx,cx
    79dd:1b94  - je        FCLMODER
    79dd:1b96  - div       cx
    79dd:1b98  - mov       word ptr ss:[di+06],dx
    79dd:1b9c  - xor       dx,dx
    79dd:1b9e  - mov       word ptr ss:[di+08],dx
    79dd:1ba2  - add       di,06
    79dd:1ba5  - jmp       FCALC
             FCLMODER:
    79dd:1ba8  - push      dx
    79dd:1ba9    mov       dx,847A
    79dd:1bac    call      INSFRERR1
    79dd:1baf    pop       dx
             FCALCDIV:
    79dd:1bb0    push      si
    79dd:1bb1  - mov       dx,word ptr ss:[di+08]
    79dd:1bb5  - mov       ax,word ptr ss:[di+06]
    79dd:1bb9  - mov       cx,word ptr ss:[di+02]
    79dd:1bbd  - mov       bx,word ptr ss:[di]
    79dd:1bc0  - or        bx,bx
    79dd:1bc2  - je        FEDIVZ
             FEDIV1:
    79dd:1bc4  - call      F_LDIV
             FEDIV2:
    79dd:1bc7  - mov       word ptr ss:[di+08],dx
    79dd:1bcb  - mov       word ptr ss:[di+06],ax
    79dd:1bcf  - pop       si
    79dd:1bd0  - add       di,06
    79dd:1bd3  - jmp       FCALC
             FEDIVZ:
    79dd:1bd6  - or        cx,cx
    79dd:1bd8  - jne       FEDIV1
    79dd:1bda  - xor       ax,ax
    79dd:1bdc  - mov       dx,ax
    79dd:1bde  - jmp       FEDIV2
             F_LDIV:
    79dd:1be0  - or        dx,dx
    79dd:1be2  - jns       FL10
    79dd:1be4  - neg       dx
    79dd:1be6    neg       ax
    79dd:1be8    sbb       dx,00
    79dd:1beb  - or        cx,cx
    79dd:1bed  - jns       FL11
    79dd:1bef  - neg       cx
    79dd:1bf1    neg       bx
    79dd:1bf3    sbb       cx,00
    79dd:1bf6  - call      F_ULDIV
    79dd:1bf9  - neg       cx
    79dd:1bfb    neg       bx
    79dd:1bfd    sbb       cx,00
    79dd:1c00  - ret
             FL11:
    79dd:1c01  - call      F_ULDIV
    79dd:1c04  - neg       cx
    79dd:1c06    neg       bx
    79dd:1c08    sbb       cx,00
    79dd:1c0b  - jmp       FL12
             FCALCOR:
    79dd:1c0e  - mov       ax,word ptr ss:[di+08]
    79dd:1c12  - or        ax,word ptr ss:[di+02]
    79dd:1c16  - mov       word ptr ss:[di+08],ax
    79dd:1c1a  - mov       ax,word ptr ss:[di+06]
    79dd:1c1e  - or        ax,word ptr ss:[di]
    79dd:1c21  - mov       word ptr ss:[di+06],ax
    79dd:1c25  - add       di,06
    79dd:1c28  - jmp       FCALC
             FCALCAND:
    79dd:1c2b  - mov       ax,word ptr ss:[di+08]
    79dd:1c2f  - and       ax,word ptr ss:[di+02]
    79dd:1c33  - mov       word ptr ss:[di+08],ax
    79dd:1c37  - mov       ax,word ptr ss:[di+06]
    79dd:1c3b  - and       ax,word ptr ss:[di]
    79dd:1c3e  - mov       word ptr ss:[di+06],ax
    79dd:1c42  - add       di,06
    79dd:1c45  - jmp       FCALC
             FCALCXOR:
    79dd:1c48  - mov       ax,word ptr ss:[di+08]
    79dd:1c4c  - xor       ax,word ptr ss:[di+02]
    79dd:1c50  - mov       word ptr ss:[di+08],ax
    79dd:1c54  - mov       ax,word ptr ss:[di+06]
    79dd:1c58  - xor       ax,word ptr ss:[di]
    79dd:1c5b  - mov       word ptr ss:[di+06],ax
    79dd:1c5f  - add       di,06
    79dd:1c62  - jmp       FCALC
             FCALCNOT:
    79dd:1c65  - mov       ax,word ptr ss:[di]
    79dd:1c68  - not       ax
    79dd:1c6a  - mov       word ptr ss:[di+06],ax
    79dd:1c6e  - mov       ax,word ptr ss:[di+02]
    79dd:1c72  - not       ax
    79dd:1c74  - mov       word ptr ss:[di+08],ax
    79dd:1c78  - add       di,06
    79dd:1c7b  - jmp       FCALC
             FCALCNEG:
    79dd:1c7e  - xor       ax,ax
    79dd:1c80  - sub       ax,word ptr ss:[di]
    79dd:1c83  - mov       word ptr ss:[di+06],ax
    79dd:1c87  - mov       ax,0000
    79dd:1c8a  - sbb       ax,word ptr ss:[di+02]
    79dd:1c8e  - mov       word ptr ss:[di+08],ax
    79dd:1c92  - add       di,06
    79dd:1c95  - jmp       FCALC
             FCALCHIBYTE:
    79dd:1c98  - xor       ax,ax
    79dd:1c9a  - mov       word ptr ss:[di+08],ax
    79dd:1c9e  - mov       al,byte ptr ss:[di+01]
    79dd:1ca2  - mov       word ptr ss:[di+06],ax
    79dd:1ca6  - add       di,06
    79dd:1ca9  - jmp       FCALC
             FCALCLOBYTE:
    79dd:1cac  - xor       ax,ax
    79dd:1cae  - mov       word ptr ss:[di+08],ax
    79dd:1cb2  - mov       al,byte ptr ss:[di]
    79dd:1cb5  - mov       word ptr ss:[di+06],ax
    79dd:1cb9  - add       di,06
    79dd:1cbc  - jmp       FCALC
             ADD_ASSEMVARS:
    79dd:1cbf  - mov       ax,ss
    79dd:1cc1  - mov       ds,ax
    79dd:1cc3  - mov       es,ax
    79dd:1cc5  - mov       si,24A4
             VARSLP:
    79dd:1cc8  - lodsw
    79dd:1cc9  - or        ax,ax
    79dd:1ccb  - je        VARSEND
    79dd:1ccd  - mov       di,ax
    79dd:1ccf  - mov       ax,word ptr [0F76]
    79dd:1cd3  - stosw
    79dd:1cd4  - mov       ax,word ptr [0F78]
    79dd:1cd8  - stosw
    79dd:1cd9  - mov       word ptr ss:[0F92],0000
    79dd:1ce0  - mov       word ptr ss:[0F94],0000
    79dd:1ce7  - call      ADDSYMBOL
    79dd:1cea  - inc       si
    79dd:1ceb  - jmp       VARSLP
             VARSEND:
    79dd:1ced  - call      far ptr _OS2GETDATE
    79dd:1cf2  - push      cx
    79dd:1cf3  - mov       bx,dx
    79dd:1cf5  - and       bx,00FF
    79dd:1cf9  - mov       dl,bl
    79dd:1cfb  - xchg      dh,dl
    79dd:1cfd  - push      dx
    79dd:1cfe  - xor       bx,bx
    79dd:1d00  - mov       ax,07C8
             YEARLP:
    79dd:1d03  - cmp       cx,ax
    79dd:1d05  - je        GOTYEAR
    79dd:1d07  - add       bx,016D
    79dd:1d0b  - test      cx,0003
    79dd:1d0f  - jne       NOTLEAP
    79dd:1d11  - inc       bx
             NOTLEAP:
    79dd:1d12  - inc       ax
    79dd:1d13  - jmp       YEARLP
             GOTYEAR:
    79dd:1d15  - mov       di,8C17
    79dd:1d18  - test      cx,0003
    79dd:1d1c  - jne       NOTLEAP2
    79dd:1d1e  - mov       di,8C31
             NOTLEAP2:
    79dd:1d21  - mov       al,01
             MONTHLP:
    79dd:1d23  - cmp       dl,al
    79dd:1d25  - je        GOTMONTH
    79dd:1d27  - mov       cl,al
    79dd:1d29  - and       cx,00FF
    79dd:1d2d  - add       cx,cx
    79dd:1d2f  - add       cx,di
    79dd:1d31  - mov       si,cx
    79dd:1d33  - add       bx,word ptr ss:[si]
    79dd:1d36  - inc       al
    79dd:1d38  - jmp       MONTHLP
             GOTMONTH:
    79dd:1d3a  - dec       cl
    79dd:1d3c  - mov       cl,dh
    79dd:1d3e  - and       cx,00FF
    79dd:1d42  - add       bx,cx
    79dd:1d44  - mov       cx,bx
    79dd:1d46  - xor       dx,dx
    79dd:1d48  - mov       ax,bx
    79dd:1d4a  - mov       bx,0007
    79dd:1d4d  - div       bx
    79dd:1d4f  - mul       bx
    79dd:1d51  - sub       cx,ax
    79dd:1d53  - mov       bx,cx
    79dd:1d55  - add       bx,bx
    79dd:1d57  - mov       bx,word ptr ss:[bx+8C4B]
    79dd:1d5c  - mov       ax,ss
    79dd:1d5e  - mov       es,ax
    79dd:1d60  - mov       di,9778
    79dd:1d63  - mov       al,09
    79dd:1d65  - stosb
    79dd:1d66  - mov       ax,4144
    79dd:1d69  - stosw
    79dd:1d6a  - mov       ax,4554
    79dd:1d6d  - stosw
    79dd:1d6e  - mov       ax,535F
    79dd:1d71  - stosw
    79dd:1d72  - mov       ax,5254
    79dd:1d75  - stosw
    79dd:1d76  - mov       ax,365B
    79dd:1d79  - stosw
    79dd:1d7a  - mov       ax,5D34
    79dd:1d7d  - stosw
    79dd:1d7e  - mov       ax,223D
    79dd:1d81  - stosw
             DAYLP:
    79dd:1d82  - mov       al,byte ptr ss:[bx]
    79dd:1d85  - inc       bx
    79dd:1d86  - stosb
    79dd:1d87  - or        al,al
    79dd:1d89  - jne       DAYLP
    79dd:1d8b  - dec       di
    79dd:1d8c  - mov       al,20
    79dd:1d8e  - stosb
    79dd:1d8f  - pop       cx
    79dd:1d90  - push      cx
    79dd:1d91  - and       cx,FF00
    79dd:1d95  - xchg      cl,ch
    79dd:1d97  - xor       dx,dx
    79dd:1d99  - call      BIN2DECL
    79dd:1d9c  - mov       di,word ptr ss:[2488]
    79dd:1da1  - dec       di
    79dd:1da2  - mov       ax,6874
    79dd:1da5  - pop       bx
    79dd:1da6  - cmp       bh,01
    79dd:1da9  - jne       NOT1ST
    79dd:1dab  - mov       ax,7473
             NOT1ST:
    79dd:1dae  - cmp       bh,02
    79dd:1db1  - jne       NOT2ND
    79dd:1db3  - mov       ax,646E
             NOT2ND:
    79dd:1db6  - cmp       bh,03
    79dd:1db9  - jne       NOT3RD
    79dd:1dbb  - mov       ax,6472
             NOT3RD:
    79dd:1dbe  - stosw
    79dd:1dbf  - mov       al,20
    79dd:1dc1  - stosb
    79dd:1dc2  - and       bx,00FF
    79dd:1dc6  - add       bx,bx
    79dd:1dc8  - mov       bx,word ptr ss:[bx+8C92]
             MONLP:
    79dd:1dcd  - mov       al,byte ptr ss:[bx]
    79dd:1dd0  - inc       bx
    79dd:1dd1  - stosb
    79dd:1dd2  - or        al,al
    79dd:1dd4  - jne       MONLP
    79dd:1dd6  - dec       di
    79dd:1dd7  - mov       al,20
    79dd:1dd9  - stosb
    79dd:1dda  - pop       cx
    79dd:1ddb  - xor       dx,dx
    79dd:1ddd  - call      BIN2DECL
    79dd:1de0  - mov       di,word ptr ss:[2488]
    79dd:1de5  - dec       di
    79dd:1de6  - mov       al,22
    79dd:1de8  - stosb
    79dd:1de9  - mov       al,0D
    79dd:1deb  - stosb
    79dd:1dec  - mov       al,0A
    79dd:1dee  - stosb
    79dd:1def  - mov       bx,76A7
    79dd:1df2  - mov       ax,ss
    79dd:1df4  - mov       ds,ax
    79dd:1df6  - mov       si,9778
    79dd:1df9  - call      P_STRING
    79dd:1dfc  - ret
             MOREFR:
    79dd:1dfd  - push      ax
    79dd:1dfe  - push      bx
    79dd:1dff  - push      cx
    79dd:1e00  - push      dx
    79dd:1e01  - push      ds
    79dd:1e02  - push      es
    79dd:1e03  - push      si
    79dd:1e04  - push      di
    79dd:1e05  - mov       bx,0801
    79dd:1e08  - call      far ptr _OS2ALLOCSEG
    79dd:1e0d  - jae       1E12
    79dd:1e0f    jmp       _CANTALLOC
    79dd:1e12  - mov       es,word ptr ss:[0AC5]
    79dd:1e17  - xor       di,di
    79dd:1e19  - mov       word ptr es:[di],ax
    79dd:1e1c  - mov       word ptr [0AC5],ax
    79dd:1e20  - mov       word ptr ss:[0AC7],0002
    79dd:1e27  - mov       word ptr ss:[0AC9],0002
    79dd:1e2e  - pop       di
    79dd:1e2f  - pop       si
    79dd:1e30  - pop       es
    79dd:1e31  - pop       ds
    79dd:1e32  - pop       dx
    79dd:1e33  - pop       cx
    79dd:1e34  - pop       bx
    79dd:1e35  - pop       ax
    79dd:1e36  - ret
             MOREEXT:
    79dd:1e37  - push      ax
    79dd:1e38  - push      bx
    79dd:1e39  - push      cx
    79dd:1e3a  - push      dx
    79dd:1e3b  - push      ds
    79dd:1e3c  - push      es
    79dd:1e3d  - push      si
    79dd:1e3e  - push      di
    79dd:1e3f  - mov       bx,0401
    79dd:1e42  - call      far ptr _OS2ALLOCSEG
    79dd:1e47  - jae       1E4C
    79dd:1e49    jmp       _CANTALLOC
    79dd:1e4c  - mov       es,word ptr ss:[13A6]
    79dd:1e51  - xor       di,di
    79dd:1e53  - mov       word ptr es:[di],ax
    79dd:1e56  - mov       word ptr [13A6],ax
    79dd:1e5a  - mov       word ptr ss:[13A8],0002
    79dd:1e61  - pop       di
    79dd:1e62  - pop       si
    79dd:1e63  - pop       es
    79dd:1e64  - pop       ds
    79dd:1e65  - pop       dx
    79dd:1e66  - pop       cx
    79dd:1e67  - pop       bx
    79dd:1e68  - pop       ax
    79dd:1e69  - ret
             MORESYM:
    79dd:1e6a  - push      ax
    79dd:1e6b  - push      bx
    79dd:1e6c  - push      cx
    79dd:1e6d  - push      dx
    79dd:1e6e  - push      ds
    79dd:1e6f  - push      es
    79dd:1e70  - push      si
    79dd:1e71  - push      di
    79dd:1e72  - mov       bx,06D7
    79dd:1e75  - call      far ptr _OS2ALLOCSEG
    79dd:1e7a  - jae       1E7F
    79dd:1e7c    jmp       _CANTALLOC
    79dd:1e7f  - mov       word ptr [0F76],ax
    79dd:1e83  - mov       word ptr ss:[0F78],0000
    79dd:1e8a  - pop       di
    79dd:1e8b  - pop       si
    79dd:1e8c  - pop       es
    79dd:1e8d  - pop       ds
    79dd:1e8e  - pop       dx
    79dd:1e8f  - pop       cx
    79dd:1e90  - pop       bx
    79dd:1e91  - pop       ax
    79dd:1e92  - ret
             MOREHEAP:
    79dd:1e93  - push      ax
    79dd:1e94  - push      bx
    79dd:1e95  - push      cx
    79dd:1e96  - push      dx
    79dd:1e97  - push      ds
    79dd:1e98  - push      es
    79dd:1e99  - push      si
    79dd:1e9a  - push      di
    79dd:1e9b  - mov       bx,0201
    79dd:1e9e  - call      far ptr _OS2ALLOCSEG
    79dd:1ea3  - jae       1EA8
    79dd:1ea5    jmp       _CANTALLOC
    79dd:1ea8  - mov       es,word ptr ss:[0ED9]
    79dd:1ead  - xor       di,di
    79dd:1eaf  - mov       word ptr es:[di],ax
    79dd:1eb2  - mov       word ptr [0ED9],ax
    79dd:1eb6  - mov       word ptr ss:[0EDB],0002
    79dd:1ebd  - pop       di
    79dd:1ebe  - pop       si
    79dd:1ebf  - pop       es
    79dd:1ec0  - pop       ds
    79dd:1ec1  - pop       dx
    79dd:1ec2  - pop       cx
    79dd:1ec3  - pop       bx
    79dd:1ec4  - pop       ax
    79dd:1ec5  - ret
             MORESTRING:
    79dd:1ec6  - push      ax
    79dd:1ec7  - push      bx
    79dd:1ec8  - push      cx
    79dd:1ec9  - push      dx
    79dd:1eca  - push      ds
    79dd:1ecb  - push      es
    79dd:1ecc  - push      si
    79dd:1ecd  - push      di
    79dd:1ece  - mov       bx,0201
    79dd:1ed1  - call      far ptr _OS2ALLOCSEG
    79dd:1ed6  - jae       1EDB
    79dd:1ed8    jmp       _CANTALLOC
    79dd:1edb  - mov       es,word ptr ss:[0ED5]
    79dd:1ee0  - xor       di,di
    79dd:1ee2  - mov       word ptr es:[di],ax
    79dd:1ee5  - mov       word ptr [0ED5],ax
    79dd:1ee9  - mov       word ptr ss:[0ED7],0002
    79dd:1ef0  - pop       di
    79dd:1ef1  - pop       si
    79dd:1ef2  - pop       es
    79dd:1ef3  - pop       ds
    79dd:1ef4  - pop       dx
    79dd:1ef5  - pop       cx
    79dd:1ef6  - pop       bx
    79dd:1ef7  - pop       ax
    79dd:1ef8  - ret
             MORESYMTX:
    79dd:1ef9  - push      ax
    79dd:1efa  - push      bx
    79dd:1efb  - push      cx
    79dd:1efc  - push      dx
    79dd:1efd  - push      ds
    79dd:1efe  - push      es
    79dd:1eff  - push      si
    79dd:1f00  - push      di
    79dd:1f01  - mov       bx,0401
    79dd:1f04  - call      far ptr _OS2ALLOCSEG
    79dd:1f09  - jae       1F0E
    79dd:1f0b    jmp       _CANTALLOC
    79dd:1f0e  - mov       word ptr [0F72],ax
    79dd:1f12  - mov       word ptr ss:[0F74],0000
    79dd:1f19  - pop       di
    79dd:1f1a  - pop       si
    79dd:1f1b  - pop       es
    79dd:1f1c  - pop       ds
    79dd:1f1d  - pop       dx
    79dd:1f1e  - pop       cx
    79dd:1f1f  - pop       bx
    79dd:1f20  - pop       ax
    79dd:1f21  - ret
             GETMEM:
    79dd:1f22  - mov       bx,0401
    79dd:1f25  - call      far ptr _OS2ALLOCSEG
    79dd:1f2a  - jae       1F2F
    79dd:1f2c    jmp       _CANTALLOC
    79dd:1f2f  - mov       word ptr [0F72],ax
    79dd:1f33  - mov       word ptr ss:[0F74],0000
    79dd:1f3a  - mov       bx,0201
    79dd:1f3d  - call      far ptr _OS2ALLOCSEG
    79dd:1f42  - jae       1F47
    79dd:1f44    jmp       _CANTALLOC
    79dd:1f47  - mov       word ptr [0ED9],ax
    79dd:1f4b  - mov       word ptr ss:[0EDB],0002
    79dd:1f52  - mov       bx,0201
    79dd:1f55  - call      far ptr _OS2ALLOCSEG
    79dd:1f5a  - jae       1F5F
    79dd:1f5c    jmp       _CANTALLOC
    79dd:1f5f  - mov       word ptr [0ED3],ax
    79dd:1f63  - mov       word ptr [0ED5],ax
    79dd:1f67  - mov       word ptr ss:[0ED7],0002
    79dd:1f6e  - mov       es,ax
    79dd:1f70  - mov       word ptr es:[0000],0000
    79dd:1f77  - mov       word ptr es:[0002],FFFF
    79dd:1f7e  - mov       bx,06D7
    79dd:1f81  - call      far ptr _OS2ALLOCSEG
    79dd:1f86  - jae       1F8B
    79dd:1f88    jmp       _CANTALLOC
    79dd:1f8b  - mov       word ptr [0F76],ax
    79dd:1f8f  - mov       word ptr ss:[0F78],0000
    79dd:1f96  - mov       bx,0801
    79dd:1f99  - call      far ptr _OS2ALLOCSEG
    79dd:1f9e  - jae       1FA3
    79dd:1fa0    jmp       _CANTALLOC
    79dd:1fa3  - mov       word ptr [0AA2],ax
    79dd:1fa7  - mov       word ptr ss:[0AA4],0000
    79dd:1fae  - mov       bx,0801
    79dd:1fb1  - call      far ptr _OS2ALLOCSEG
    79dd:1fb6  - jb        _CANTALLOC
    79dd:1fb8  - mov       word ptr [13AC],ax
    79dd:1fbc  - mov       word ptr [13B6],ax
    79dd:1fc0  - mov       word ptr [13B0],ax
    79dd:1fc4  - mov       word ptr ss:[13AE],0000
    79dd:1fcb  - mov       word ptr ss:[13B8],0000
    79dd:1fd2  - mov       word ptr ss:[13B2],0000
    79dd:1fd9  - mov       es,ax
    79dd:1fdb  - xor       di,di
    79dd:1fdd  - xor       al,al
    79dd:1fdf  - mov       cx,0013
             CLROBJ:
    79dd:1fe2  - stosb
    79dd:1fe3  - dec       cx
    79dd:1fe4  - jne       CLROBJ
    79dd:1fe6  - mov       word ptr ss:[13B4],di
    79dd:1feb  - mov       bx,0801
    79dd:1fee  - call      far ptr _OS2ALLOCSEG
    79dd:1ff3  - jb        _CANTALLOC
    79dd:1ff5  - mov       word ptr [0ACB],ax
    79dd:1ff9  - mov       word ptr [0AC5],ax
    79dd:1ffd  - mov       word ptr ss:[0AC7],0002
    79dd:2004  - mov       word ptr ss:[0AC9],0002
    79dd:200b  - mov       bx,0401
    79dd:200e  - call      far ptr _OS2ALLOCSEG
    79dd:2013  - jb        _CANTALLOC
    79dd:2015  - mov       word ptr [13A4],ax
    79dd:2019  - mov       word ptr [13A6],ax
    79dd:201d  - mov       word ptr ss:[13A8],0002
    79dd:2024  - ret
             _CANTALLOC:
    79dd:2025  - mov       dx,7C3F
    79dd:2028    call      FATALERR_ROUT
    79dd:202b  - jmp       STOPASSEM
             LISTLINE:
    79dd:202e    push      bx
    79dd:202f  - push      ds
    79dd:2030  - push      si
    79dd:2031  - push      es
    79dd:2032  - push      di
    79dd:2033  - mov       word ptr ss:[9A86],di
    79dd:2038  - mov       al,byte ptr [0EE3]
    79dd:203c  - mov       byte ptr ss:[0EE3],00
    79dd:2042  - or        al,al
    79dd:2044  - jne       _NOTM
    79dd:2046  - cmp       word ptr ss:[0AA6],00
    79dd:204c  - je        _NOTM
    79dd:204e  - cmp       byte ptr ss:[13EB],00
    79dd:2054  - jne       _NOTM
    79dd:2056    jmp       _NOLIST
             MUSTDOL:
             _NOTM:
    79dd:2059  - std
    79dd:205a  - cmp       bp,word ptr ss:[248A]
    79dd:205f  - jne       LLLP2
    79dd:2061  - cld
    79dd:2062  - jmp       _NOLIST
             LLLP2:
    79dd:2065  - lodsb
    79dd:2066  - cmp       al,0A
    79dd:2068  - je        LLGOTCR
    79dd:206a  - cmp       si,FF
    79dd:206d  - jne       LLLP2
    79dd:206f  - dec       si
             LLGOTCR:
    79dd:2070  - cld
    79dd:2071  - inc       si
    79dd:2072  - inc       si
    79dd:2073  - push      si
    79dd:2074  - call      NEEDCR
    79dd:2077  - call      GETLINE
    79dd:207a  - push      ds
    79dd:207b    push      dx
    79dd:207c    mov       dx,8AC9
    79dd:207f    mov       ds,dx
    79dd:2081    mov       dx,8995
    79dd:2084    call      far ptr _OS2PRTSTRING
    79dd:2089    pop       dx
    79dd:208a    pop       ds
    79dd:208b  - mov       ax,word ptr [0F92]
    79dd:208f  - mov       word ptr [9A82],ax
    79dd:2093  - mov       ax,word ptr [0F94]
    79dd:2097  - mov       word ptr [9A84],ax
    79dd:209b  - mov       cx,word ptr ss:[9A86]
    79dd:20a0  - sub       cx,word ptr ss:[0F90]
    79dd:20a5  - sub       word ptr ss:[9A84],cx
    79dd:20aa  - sbb       byte ptr ss:[9A82],00
    79dd:20b0  - push      dx
    79dd:20b1    push      cx
    79dd:20b2    mov       dx,word ptr ss:[9A82]
    79dd:20b7    mov       cx,word ptr ss:[9A84]
    79dd:20bc    call      PRTHEXL
    79dd:20bf    pop       cx
    79dd:20c0    pop       dx
    79dd:20c1  - cmp       word ptr ss:[0AA6],00
    79dd:20c7  - je        NOLMAC
    79dd:20c9  - push      ds
    79dd:20ca    push      dx
    79dd:20cb    mov       dx,8AC9
    79dd:20ce    mov       ds,dx
    79dd:20d0    mov       dx,8997
    79dd:20d3    call      far ptr _OS2PRTSTRING
    79dd:20d8    pop       dx
    79dd:20d9    pop       ds
             NOLMAC:
    79dd:20da    cmp       byte ptr ss:[0F8C],00
    79dd:20e0  - je        NOLIF
    79dd:20e2  - push      ds
    79dd:20e3    push      dx
    79dd:20e4    mov       dx,8AC9
    79dd:20e7    mov       ds,dx
    79dd:20e9    mov       dx,899A
    79dd:20ec    call      far ptr _OS2PRTSTRING
    79dd:20f1    pop       dx
    79dd:20f2    pop       ds
             NOLIF:
    79dd:20f3  - push      ds
    79dd:20f4    push      dx
    79dd:20f5    mov       dx,8AC9
    79dd:20f8    mov       ds,dx
    79dd:20fa    mov       dx,8995
    79dd:20fd    call      far ptr _OS2PRTSTRING
    79dd:2102    pop       dx
    79dd:2103    pop       ds
    79dd:2104  - pop       si
    79dd:2105  - pop       di
    79dd:2106  - pop       es
    79dd:2107  - push      es
    79dd:2108  - push      di
    79dd:2109  - mov       cx,di
    79dd:210b  - sub       cx,word ptr ss:[0F90]
    79dd:2110  - je        NOCODE
    79dd:2112  - and       cx,07
    79dd:2115  - mov       di,word ptr ss:[0F90]
             LLPLP:
    79dd:211a  - mov       al,byte ptr es:[di]
    79dd:211d  - inc       di
    79dd:211e  - call      PRTHEXB
    79dd:2121  - dec       cx
    79dd:2122  - jne       LLPLP
             NOCODE:
    79dd:2124  - push      ds
    79dd:2125    push      dx
    79dd:2126    mov       dx,8AC9
    79dd:2129    mov       ds,dx
    79dd:212b    mov       dx,8995
    79dd:212e    call      far ptr _OS2PRTSTRING
    79dd:2133    pop       dx
    79dd:2134    pop       ds
    79dd:2135  - mov       ax,ss
    79dd:2137  - mov       es,ax
    79dd:2139  - mov       di,8A6E
    79dd:213c  - xor       cx,cx
             LLLP3:
    79dd:213e  - lodsb
    79dd:213f  - stosb
    79dd:2140  - inc       cx
    79dd:2141  - cmp       al,1A
    79dd:2143  - je        LLEOF
    79dd:2145  - cmp       al,0D
    79dd:2147  - jne       LLLP3
    79dd:2149  - jmp       LLLF
             LLEOF:
    79dd:214b  - mov       al,0D
    79dd:214d  - stosb
             LLLF:
    79dd:214e  - mov       al,0A
    79dd:2150  - stosb
    79dd:2151  - inc       cx
    79dd:2152  - mov       ax,ss
    79dd:2154  - mov       ds,ax
    79dd:2156  - mov       ax,4002
    79dd:2159  - mov       bx,0001
    79dd:215c  - mov       dx,8A6E
    79dd:215f  - call      far ptr _OS2WRITEBYTES
             _NOLIST:
    79dd:2164  - pop       di
    79dd:2165  - pop       es
    79dd:2166  - pop       si
    79dd:2167  - pop       ds
    79dd:2168  - pop       bx
    79dd:2169  - ret
    79dd:216a  - pop       di
    79dd:216b  - pop       es
    79dd:216c  - pop       si
    79dd:216d  - pop       ds
    79dd:216e  - pop       bx
    79dd:216f  - ret
             ERROR_ROUT:
    79dd:2170  - and       byte ptr ss:[0F8B],FE
    79dd:2176  - push      word ptr ss:[247D]
    79dd:217b  - mov       byte ptr ss:[247D],00
    79dd:2181  - push      word ptr ss:[2474]
    79dd:2186  - mov       word ptr ss:[2474],0000
    79dd:218d  - mov       word ptr ss:[13E2],ds
    79dd:2192  - mov       word ptr ss:[13E4],si
    79dd:2197  - push      es
    79dd:2198  - push      ax
    79dd:2199  - push      di
    79dd:219a  - push      ds
    79dd:219b  - push      si
    79dd:219c  - call      GETLINE
    79dd:219f  - cmp       ax,word ptr ss:[0EDF]
    79dd:21a4  - je        ERRSUPDO
    79dd:21a6  - mov       word ptr [0EDF],ax
    79dd:21aa  - mov       al,byte ptr [0EE1]
    79dd:21ae  - or        al,al
    79dd:21b0  - je        ERROK2
    79dd:21b2  - mov       dx,7CF5
    79dd:21b5    call      FATALERR_ROUT
    79dd:21b8  - jmp       STOPASSEM
             ERROK2:
    79dd:21bb  - call      NEEDCR
    79dd:21be  - mov       si,dx
    79dd:21c0  - inc       dx
    79dd:21c1  - mov       al,byte ptr ss:[si]
    79dd:21c4  - or        al,al
    79dd:21c6  - je        ERRORT
    79dd:21c8  - mov       cx,8A5A
    79dd:21cb  - inc       word ptr ss:[13C6]
    79dd:21d0  - jmp       DONEEW
             ERRORT:
    79dd:21d2  - mov       cx,8A54
    79dd:21d5  - inc       word ptr ss:[13C4]
             DONEEW:
    79dd:21da  - mov       al,byte ptr [13E9]
    79dd:21de  - or        al,al
    79dd:21e0  - jne       ERRSUPDO
    79dd:21e2  - mov       word ptr ss:[13DE],cx
    79dd:21e7  - mov       word ptr ss:[13E0],dx
    79dd:21ec  - mov       ax,ss
    79dd:21ee  - mov       ds,ax
    79dd:21f0  - mov       si,2557
    79dd:21f3  - mov       byte ptr ss:[0EE1],01
    79dd:21f9  - call      P_PRINTF2
    79dd:21fc  - mov       byte ptr ss:[0EE1],00
    79dd:2202  - mov       byte ptr ss:[0EE3],01
             ERRSUPDO:
    79dd:2208  - mov       word ptr ss:[2472],8A6E
    79dd:220f  - mov       ax,word ptr [13C4]
    79dd:2213  - cmp       ax,word ptr ss:[13FD]
    79dd:2218  - jb        ERRROK
    79dd:221a  - mov       dx,7EB4
    79dd:221d    call      FATALERR_ROUT
    79dd:2220  - jmp       STOPASSEM
             ERRROK:
    79dd:2223  - pop       si
    79dd:2224  - pop       ds
    79dd:2225  - pop       di
    79dd:2226  - pop       ax
    79dd:2227  - pop       es
    79dd:2228  - pop       word ptr ss:[2474]
    79dd:222d  - pop       word ptr ss:[247D]
    79dd:2232  - mov       ss,word ptr ss:[24A0]
    79dd:2237  - mov       sp,word ptr ss:[24A2]
    79dd:223c  - test      byte ptr ss:[0F8B],02
    79dd:2242  - je        NSLL1
    79dd:2244  - and       byte ptr ss:[0F8B],FD
    79dd:224a  - mov       ds,word ptr ss:[13E2]
    79dd:224f  - mov       si,word ptr ss:[13E4]
    79dd:2254  - call      LISTLINE
             NSLL1:
    79dd:2257  - lodsb
    79dd:2258  - cmp       al,0D
    79dd:225a  - jne       NSLL1
    79dd:225c  - inc       si
    79dd:225d  - inc       word ptr ss:[13F0]
    79dd:2262  - mov       al,byte ptr [0F8D]
    79dd:2266  - or        al,al
    79dd:2268  - jne       226D
    79dd:226a    jmp       DO_65816
    79dd:226d  - jmp       DO_MARIO
             NEEDCR:
    79dd:2270  - mov       al,byte ptr [247C]
    79dd:2274  - or        al,al
    79dd:2276  - je        NONEEDCR
    79dd:2278  - push      ds
    79dd:2279    push      dx
    79dd:227a    mov       dx,8AC9
    79dd:227d    mov       ds,dx
    79dd:227f    mov       dx,2552
    79dd:2282    call      far ptr _OS2PRTSTRING
    79dd:2287    pop       dx
    79dd:2288    pop       ds
    79dd:2289  - mov       byte ptr ss:[247C],00
             NONEEDCR:
    79dd:228f  - ret
             FATALERR_ROUT:
    79dd:2290  - push      ds
    79dd:2291  - push      es
    79dd:2292  - push      ax
    79dd:2293  - push      di
    79dd:2294  - push      dx
    79dd:2295  - mov       ax,ss
    79dd:2297  - mov       ds,ax
    79dd:2299  - mov       es,ax
    79dd:229b  - push      ds
    79dd:229c    push      dx
    79dd:229d    mov       dx,8AC9
    79dd:22a0    mov       ds,dx
    79dd:22a2    mov       dx,8A3C
    79dd:22a5    call      far ptr _OS2PRTSTRING
    79dd:22aa    pop       dx
    79dd:22ab    pop       ds
    79dd:22ac  - mov       ds,word ptr ss:[0F98]
    79dd:22b1  - mov       dx,word ptr ss:[0F9A]
    79dd:22b6  - mov       si,dx
    79dd:22b8  - xor       cx,cx
             FERRLP:
    79dd:22ba  - inc       cx
    79dd:22bb  - lodsb
    79dd:22bc  - or        al,al
    79dd:22be  - jne       FERRLP
    79dd:22c0  - mov       bx,0001
    79dd:22c3  - call      far ptr _OS2WRITEBYTES
    79dd:22c8  - mov       ax,es
    79dd:22ca  - mov       ds,ax
    79dd:22cc  - push      ds
    79dd:22cd    push      dx
    79dd:22ce    mov       dx,8AC9
    79dd:22d1    mov       ds,dx
    79dd:22d3    mov       dx,899D
    79dd:22d6    call      far ptr _OS2PRTSTRING
    79dd:22db    pop       dx
    79dd:22dc    pop       ds
    79dd:22dd  - call      GETLINE
    79dd:22e0  - mov       word ptr [9A7C],ax
    79dd:22e4  - push      cx
    79dd:22e5    mov       byte ptr ss:[2480],00
    79dd:22eb    mov       cx,word ptr ss:[9A7C]
    79dd:22f0    call      PRTDECW
    79dd:22f3    pop       cx
    79dd:22f4  - mov       ax,ss
    79dd:22f6  - mov       es,ax
    79dd:22f8  - mov       di,8A6E
    79dd:22fb  - mov       al,2F
    79dd:22fd  - stosb
    79dd:22fe  - call      GETLINE_MACROS
    79dd:2301  - mov       cx,ax
    79dd:2303  - mov       al,24
    79dd:2305  - stosb
    79dd:2306  - dec       di
    79dd:2307  - or        cx,cx
    79dd:2309  - je        FERNOM
    79dd:230b  - mov       cx,0002
    79dd:230e  - call      BIN2DECW
             FERNOM:
    79dd:2311  - push      ds
    79dd:2312    push      dx
    79dd:2313    mov       dx,8AC9
    79dd:2316    mov       ds,dx
    79dd:2318    mov       dx,8A6E
    79dd:231b    call      far ptr _OS2PRTSTRING
    79dd:2320    pop       dx
    79dd:2321    pop       ds
    79dd:2322  - push      ds
    79dd:2323    push      dx
    79dd:2324    mov       dx,8AC9
    79dd:2327    mov       ds,dx
    79dd:2329    mov       dx,899F
    79dd:232c    call      far ptr _OS2PRTSTRING
    79dd:2331    pop       dx
    79dd:2332    pop       ds
    79dd:2333  - push      ds
    79dd:2334    push      dx
    79dd:2335    mov       dx,8AC9
    79dd:2338    mov       ds,dx
    79dd:233a    mov       dx,89A3
    79dd:233d    call      far ptr _OS2PRTSTRING
    79dd:2342    pop       dx
    79dd:2343    pop       ds
    79dd:2344  - pop       dx
    79dd:2345  - inc       dx
    79dd:2346  - call      far ptr _OS2PRTSTRING
    79dd:234b  - inc       word ptr ss:[13C4]
    79dd:2350  - mov       bx,76A7
    79dd:2353  - pop       di
    79dd:2354  - pop       ax
    79dd:2355  - pop       es
    79dd:2356  - pop       ds
    79dd:2357  - ret
             GETLINE_MACROS:
    79dd:2358  - push      bp
    79dd:2359  - mov       bp,word ptr ss:[0F9C]
    79dd:235e  - test      byte ptr [bp+14],05
    79dd:2362  - je        GLESNOTCUR
    79dd:2364  - mov       ax,word ptr [13F0]
    79dd:2368  - pop       bp
    79dd:2369  - ret
             GLESNOTCUR:
    79dd:236a  - sub       bp,1F
    79dd:236d  - test      byte ptr [bp+14],05
    79dd:2371  - je        GLESNOTCUR
    79dd:2373  - add       bp,1F
    79dd:2376  - push      ds
    79dd:2377  - push      si
             GLESLP:
    79dd:2378  - mov       ds,word ptr [bp+1D]
    79dd:237b  - mov       si,word ptr [bp+1F]
             GLESLP2:
    79dd:237e  - lodsb
    79dd:237f  - stosb
    79dd:2380  - inc       dl
    79dd:2382  - or        al,al
    79dd:2384  - jne       GLESLP2
    79dd:2386  - mov       byte ptr es:[di+FF],2F
    79dd:238b  - add       bp,1F
    79dd:238e  - cmp       bp,word ptr ss:[0F9C]
    79dd:2393  - jbe       GLESLP
    79dd:2395  - mov       ax,word ptr [13F0]
    79dd:2399  - pop       si
    79dd:239a  - pop       ds
    79dd:239b  - pop       bp
    79dd:239c  - ret
             GETLINE:
    79dd:239d  - push      bp
    79dd:239e  - mov       bp,word ptr ss:[0F9C]
    79dd:23a3  - test      byte ptr [bp+14],05
    79dd:23a7  - jne       CURSRC
             GLLP:
    79dd:23a9  - sub       bp,1F
    79dd:23ac  - test      byte ptr [bp+14],05
    79dd:23b0  - je        GLLP
    79dd:23b2  - mov       ax,word ptr [bp+15]
    79dd:23b5  - pop       bp
    79dd:23b6  - ret
             CURSRC:
    79dd:23b7  - mov       ax,word ptr [13F0]
    79dd:23bb  - pop       bp
    79dd:23bc  - ret
             PRINTLASTFNAME:
    79dd:23bd  - push      es
    79dd:23be  - push      si
    79dd:23bf  - push      ds
    79dd:23c0  - mov       ax,ss
    79dd:23c2  - mov       ds,ax
    79dd:23c4  - mov       es,ax
    79dd:23c6  - mov       ds,word ptr ss:[0F98]
    79dd:23cb  - mov       dx,word ptr ss:[0F9A]
    79dd:23d0  - mov       si,dx
    79dd:23d2  - xor       cx,cx
             FLP:
    79dd:23d4  - inc       cx
    79dd:23d5  - lodsb
    79dd:23d6  - or        al,al
    79dd:23d8  - jne       FLP
    79dd:23da  - dec       cx
    79dd:23db  - mov       bx,0001
    79dd:23de  - call      far ptr _OS2WRITEBYTES
    79dd:23e3  - pop       ds
    79dd:23e4  - pop       si
    79dd:23e5  - pop       es
    79dd:23e6  - ret
             ASSEMBLE:
    79dd:23e7  - mov       es,word ptr ss:[13AC]
    79dd:23ec  - mov       di,word ptr ss:[13B4]
    79dd:23f1  - mov       ax,ss
    79dd:23f3  - mov       ds,ax
    79dd:23f5  - mov       si,9068
    79dd:23f8  - mov       word ptr ss:[13F0],0001
    79dd:23ff  - mov       bx,76A7
    79dd:2402  - xor       ax,ax
    79dd:2404    mov       word ptr [0AAE],ax
    79dd:2408    mov       word ptr [0AB6],ax
    79dd:240c    mov       word ptr [0AB2],ax
    79dd:2410    mov       word ptr [0AB4],ax
    79dd:2414    mov       word ptr [0AB0],ax
    79dd:2418    mov       word ptr [0AB8],ax
    79dd:241c    mov       word ptr [13FF],ax
    79dd:2420    mov       word ptr [0EDF],ax
    79dd:2424    mov       word ptr [248A],ax
    79dd:2428  - push      ds
    79dd:2429  - push      si
    79dd:242a  - push      es
    79dd:242b  - push      di
    79dd:242c  - mov       ax,ss
    79dd:242e  - mov       ds,ax
    79dd:2430  - mov       si,925C
    79dd:2433  - mov       es,ax
    79dd:2435  - mov       di,9778
    79dd:2438  - mov       al,09
    79dd:243a  - stosb
    79dd:243b  - mov       ax,4E49
    79dd:243e  - stosw
    79dd:243f  - mov       ax,5449
    79dd:2442  - stosw
    79dd:2443  - mov       ax,4946
    79dd:2446  - stosw
    79dd:2447  - mov       ax,454C
    79dd:244a  - stosw
    79dd:244b  - mov       ax,535F
    79dd:244e  - stosw
    79dd:244f  - mov       ax,5254
    79dd:2452  - stosw
    79dd:2453  - mov       ax,365B
    79dd:2456  - stosw
    79dd:2457  - mov       ax,5D34
    79dd:245a  - stosw
    79dd:245b  - mov       ax,223D
    79dd:245e  - stosw
             ASSLP:
    79dd:245f  - lodsb
    79dd:2460  - stosb
    79dd:2461  - xlat
    79dd:2463  - or        al,al
    79dd:2465  - jns       ASSLP
    79dd:2467  - dec       di
    79dd:2468  - mov       al,22
    79dd:246a  - stosb
    79dd:246b  - mov       al,0D
    79dd:246d  - stosb
    79dd:246e  - mov       al,0A
    79dd:2470  - stosb
    79dd:2471  - mov       si,9778
             HASHTABLEEND:
    79dd:2472    js        240B
    79dd:2474  - call      P_STRING
    79dd:2477  - pop       di
    79dd:2478  - pop       es
    79dd:2479  - pop       si
    79dd:247a  - pop       ds
    79dd:247b  - mov       word ptr ss:[24A0],ss
    79dd:2480  - mov       word ptr ss:[24A2],sp
    79dd:2485  - jmp       DO_65816
    79dd:2487  - mov       bx,7827
    79dd:248a    xlat
    79dd:248c    mov       bx,76A7
    79dd:248f    or        al,al
    79dd:2491    je        249E
    79dd:2493    inc       al
    79dd:2495    je        24B2
    79dd:2497    jo        GOTEOLDO_65816
    79dd:2499    js        24E9
    79dd:249b    jmp       25C9
    79dd:249e    dec       si
    79dd:249f    call      ADDSYMBOL
             DO_65816:
    79dd:24a2    test      byte ptr ss:[0F8B],08
             VARSINFO:
    79dd:24a4    push      es
    79dd:24a5    mov       cx,word ptr [bx]
    79dd:24a7    or        byte ptr [si+03],dh
    79dd:24aa    jmp       E_CTRLC_HIT
    79dd:24ad    lodsb
    79dd:24ae    cmp       al,09
    79dd:24b0    jne       2487
    79dd:24b2    mov       word ptr ss:[0F90],di
    79dd:24b7    call      PARSE65816
    79dd:24ba    mov       cx,di
    79dd:24bc    sub       cx,word ptr ss:[0F90]
    79dd:24c1    add       word ptr ss:[0F94],cx
    79dd:24c6    adc       byte ptr ss:[0F92],00
             GOTEOLDO_65816:
    79dd:24cc    cmp       byte ptr ss:[0F8B],00
    79dd:24d2    jne       2523
    79dd:24d4    cmp       byte ptr [si+01],0A
    79dd:24d8    jne       2507
    79dd:24da    inc       si
    79dd:24db    inc       si
    79dd:24dc    inc       word ptr ss:[13F0]
    79dd:24e1    cmp       di,7F00
    79dd:24e5    jb        DO_65816
    79dd:24e7    jmp       254A
    79dd:24e9    cmp       byte ptr ss:[0F8B],00
    79dd:24ef    jne       24FF
    79dd:24f1    inc       si
    79dd:24f2    inc       word ptr ss:[13F0]
    79dd:24f7    cmp       di,7F00
    79dd:24fb    jb        DO_65816
    79dd:24fd    jmp       254A
    79dd:24ff    dec       si
    79dd:2500    mov       word ptr ss:[0F90],di
    79dd:2505    jmp       2523
    79dd:2507    push      es
    79dd:2508    push      ds
    79dd:2509    pop       es
    79dd:250a    xchg      di,si
    79dd:250c    mov       al,0A
    79dd:250e    mov       cx,00FF
    79dd:2511    repne
    79dd:2512    scasb
    79dd:2513    xchg      di,si
    79dd:2515    pop       es
    79dd:2516    inc       word ptr ss:[13F0]
    79dd:251b    cmp       di,7F00
    79dd:251f    jb        DO_65816
    79dd:2521    jmp       254A
    79dd:2523    mov       al,byte ptr [0F8B]
    79dd:2527    test      al,01
    79dd:2529    je        253B
    79dd:252b    and       al,FE
    79dd:252d    push      ax
    79dd:252e    push      dx
    79dd:252f    mov       dx,7FAA
    79dd:2532    call      ERROR_ROUT
    79dd:2535    pop       dx
    79dd:2536    pop       ax
    79dd:2537    or        al,02
    79dd:2539    and       al,FE
    79dd:253b    test      al,04
    79dd:253d    je        2544
    79dd:253f    push      ax
    79dd:2540    call      LISTLINE
    79dd:2543    pop       ax
    79dd:2544    mov       byte ptr [0F8B],al
    79dd:2548    jmp       24D4
    79dd:254a    call      CALCLENLASTBLK
    79dd:254d    mov       bx,0801
    79dd:2550    call      far ptr _OS2ALLOCSEG
    79dd:2555    jae       255A
    79dd:2557    jmp       _CANTALLOC
    79dd:255a    mov       word ptr [13AC],ax
    79dd:255e    mov       word ptr ss:[13AE],0000
    79dd:2565    mov       es,word ptr ss:[13B6]
    79dd:256a    mov       di,word ptr ss:[13B8]
    79dd:256f    mov       word ptr es:[di],ax
    79dd:2572    mov       word ptr es:[di+02],0000
    79dd:2578    mov       ax,word ptr [13C0]
    79dd:257c    mov       cx,word ptr ss:[13C2]
    79dd:2581    mov       word ptr es:[di+04],ax
    79dd:2585    mov       word ptr es:[di+06],cx
    79dd:2589    mov       es,word ptr ss:[13AC]
    79dd:258e    xor       di,di
    79dd:2590    mov       word ptr ss:[13B6],es
    79dd:2595    mov       word ptr ss:[13B8],di
    79dd:259a    mov       byte ptr es:[di+10],01
    79dd:259f    mov       al,byte ptr [13BA]
    79dd:25a3    or        byte ptr es:[di+10],al
    79dd:25a7    call      CALCROMPOS
    79dd:25aa    mov       word ptr [13BC],ax
    79dd:25ae    mov       word ptr ss:[13BE],cx
    79dd:25b3    mov       word ptr es:[di+0C],ax
    79dd:25b7    mov       word ptr es:[di+0E],cx
    79dd:25bb    add       di,13
    79dd:25be    mov       word ptr ss:[13B4],di
    79dd:25c3    mov       bx,76A7
    79dd:25c6    jmp       DO_65816
    79dd:25c9    cmp       al,03
    79dd:25cb    jne       25D8
    79dd:25cd    push      dx
    79dd:25ce    mov       dx,837E
    79dd:25d1    call      ERROR_ROUT
    79dd:25d4    pop       dx
    79dd:25d5    jmp       24B2
    79dd:25d8    mov       bp,word ptr ss:[0F9C]
    79dd:25dd    mov       al,byte ptr [bp+14]
    79dd:25e0    test      al,02
    79dd:25e2    jne       2619
    79dd:25e4    test      al,08
    79dd:25e6    jne       2610
    79dd:25e8    test      al,01
    79dd:25ea    jne       25FC
    79dd:25ec    test      al,04
    79dd:25ee    je        25F6
    79dd:25f0    call      READMORESOURCE
    79dd:25f3    jmp       DO_65816
    79dd:25f6    mov       dx,7EDC
    79dd:25f9    call      FATALERR_ROUT
    79dd:25fc    mov       bx,word ptr [bp+02]
    79dd:25ff    call      far ptr _OS2CLOSEFILE
    79dd:2604    push      es
    79dd:2605    mov       es,word ptr [bp+10]
    79dd:2608    call      far ptr _OS2FREESEG
    79dd:260d    pop       es
    79dd:260e    jmp       261E
    79dd:2610    mov       ax,word ptr [0F96]
    79dd:2614    mov       word ptr [bp+E5],ax
    79dd:2617    jmp       261E
    79dd:2619    dec       word ptr ss:[0AA6]
    79dd:261e    mov       ax,word ptr [13F0]
    79dd:2622    add       word ptr ss:[13D2],ax
    79dd:2627    adc       word ptr ss:[13D0],00
    79dd:262d    sub       bp,1F
    79dd:2630    push      es
    79dd:2631    push      di
    79dd:2632    mov       ds,word ptr [bp+0C]
    79dd:2635    mov       si,word ptr [bp+0E]
    79dd:2638    mov       ax,word ptr [bp+04]
    79dd:263b    cmp       word ptr ss:[0F96],ax
    79dd:2640    je        2645
    79dd:2642    jmp       E_CONDUNBAL
    79dd:2645    mov       word ptr [0F96],ax
    79dd:2649    mov       ax,word ptr [bp+00]
    79dd:264c    cmp       word ptr ss:[1470],ax
    79dd:2651    je        2656
    79dd:2653    jmp       E_REPTUNBAL
    79dd:2656    mov       word ptr [1470],ax
    79dd:265a    mov       ax,word ptr [bp+15]
    79dd:265d    mov       word ptr [13F0],ax
    79dd:2661    mov       ax,word ptr [bp+0A]
    79dd:2664    mov       es,word ptr ss:[0A9E]
    79dd:2669    mov       di,word ptr ss:[0AA0]
    79dd:266e    mov       word ptr es:[di+0C],ax
    79dd:2672    mov       word ptr [0204],ax
    79dd:2676    mov       ax,word ptr [bp+1B]
    79dd:2679    mov       word ptr [0200],ax
    79dd:267d    mov       ax,word ptr [bp+17]
    79dd:2680    mov       word ptr [0F98],ax
    79dd:2684    mov       ax,word ptr [bp+19]
    79dd:2687    mov       word ptr [0F9A],ax
    79dd:268b    mov       word ptr ss:[0F9C],bp
    79dd:2690    pop       di
    79dd:2691    pop       es
    79dd:2692    mov       bx,76A7
    79dd:2695    dec       byte ptr ss:[0F8A]
    79dd:269a    je        269F
    79dd:269c    jmp       2507
    79dd:269f    cmp       byte ptr ss:[9BDD],01
    79dd:26a5    jne       26AA
    79dd:26a7    jmp       2507
    79dd:26aa    call      CALCLENLASTBLK
    79dd:26ad    mov       es,word ptr ss:[13B6]
    79dd:26b2    mov       di,word ptr ss:[13B8]
    79dd:26b7    mov       word ptr es:[di+04],ax
    79dd:26bb    mov       word ptr es:[di+06],dx
    79dd:26bf    xor       ax,ax
    79dd:26c1    mov       word ptr es:[di],ax
    79dd:26c4    mov       word ptr es:[di+02],ax
    79dd:26c8    ret
    79dd:26c9  - mov       bx,7827
    79dd:26cc    xlat
    79dd:26ce    mov       bx,76A7
    79dd:26d1    or        al,al
    79dd:26d3    je        26E0
    79dd:26d5    inc       al
    79dd:26d7    je        26F4
    79dd:26d9    jo        GOTEOLDO_MARIO
    79dd:26db    js        272B
    79dd:26dd    jmp       280B
    79dd:26e0    dec       si
    79dd:26e1    call      ADDSYMBOL
             DO_MARIO:
    79dd:26e4    test      byte ptr ss:[0F8B],08
    79dd:26ea    je        26EF
    79dd:26ec    jmp       E_CTRLC_HIT
    79dd:26ef    lodsb
    79dd:26f0    cmp       al,09
    79dd:26f2    jne       26C9
    79dd:26f4    mov       word ptr ss:[0F90],di
    79dd:26f9    call      PARSEMARIO
    79dd:26fc    mov       cx,di
    79dd:26fe    sub       cx,word ptr ss:[0F90]
    79dd:2703    add       word ptr ss:[0F94],cx
    79dd:2708    adc       byte ptr ss:[0F92],00
             GOTEOLDO_MARIO:
    79dd:270e    cmp       byte ptr ss:[0F8B],00
    79dd:2714    jne       2765
    79dd:2716    cmp       byte ptr [si+01],0A
    79dd:271a    jne       2749
    79dd:271c    inc       si
    79dd:271d    inc       si
    79dd:271e    inc       word ptr ss:[13F0]
    79dd:2723    cmp       di,7F00
    79dd:2727    jb        DO_MARIO
    79dd:2729    jmp       278C
    79dd:272b    cmp       byte ptr ss:[0F8B],00
    79dd:2731    jne       2741
    79dd:2733    inc       si
    79dd:2734    inc       word ptr ss:[13F0]
    79dd:2739    cmp       di,7F00
    79dd:273d    jb        DO_MARIO
    79dd:273f    jmp       278C
    79dd:2741    dec       si
    79dd:2742    mov       word ptr ss:[0F90],di
    79dd:2747    jmp       2765
    79dd:2749    push      es
    79dd:274a    push      ds
    79dd:274b    pop       es
    79dd:274c    xchg      di,si
    79dd:274e    mov       al,0A
    79dd:2750    mov       cx,00FF
    79dd:2753    repne
    79dd:2754    scasb
    79dd:2755    xchg      di,si
    79dd:2757    pop       es
    79dd:2758    inc       word ptr ss:[13F0]
    79dd:275d    cmp       di,7F00
    79dd:2761    jb        DO_MARIO
    79dd:2763    jmp       278C
    79dd:2765    mov       al,byte ptr [0F8B]
    79dd:2769    test      al,01
    79dd:276b    je        277D
    79dd:276d    and       al,FE
    79dd:276f    push      ax
    79dd:2770    push      dx
    79dd:2771    mov       dx,7FAA
    79dd:2774    call      ERROR_ROUT
    79dd:2777    pop       dx
    79dd:2778    pop       ax
    79dd:2779    or        al,02
    79dd:277b    and       al,FE
    79dd:277d    test      al,04
    79dd:277f    je        2786
    79dd:2781    push      ax
    79dd:2782    call      LISTLINE
    79dd:2785    pop       ax
    79dd:2786    mov       byte ptr [0F8B],al
    79dd:278a    jmp       2716
    79dd:278c    call      CALCLENLASTBLK
    79dd:278f    mov       bx,0801
    79dd:2792    call      far ptr _OS2ALLOCSEG
    79dd:2797    jae       279C
    79dd:2799    jmp       _CANTALLOC
    79dd:279c    mov       word ptr [13AC],ax
    79dd:27a0    mov       word ptr ss:[13AE],0000
    79dd:27a7    mov       es,word ptr ss:[13B6]
    79dd:27ac    mov       di,word ptr ss:[13B8]
    79dd:27b1    mov       word ptr es:[di],ax
    79dd:27b4    mov       word ptr es:[di+02],0000
    79dd:27ba    mov       ax,word ptr [13C0]
    79dd:27be    mov       cx,word ptr ss:[13C2]
    79dd:27c3    mov       word ptr es:[di+04],ax
    79dd:27c7    mov       word ptr es:[di+06],cx
    79dd:27cb    mov       es,word ptr ss:[13AC]
    79dd:27d0    xor       di,di
    79dd:27d2    mov       word ptr ss:[13B6],es
    79dd:27d7    mov       word ptr ss:[13B8],di
    79dd:27dc    mov       byte ptr es:[di+10],01
    79dd:27e1    mov       al,byte ptr [13BA]
    79dd:27e5    or        byte ptr es:[di+10],al
    79dd:27e9    call      CALCROMPOS
    79dd:27ec    mov       word ptr [13BC],ax
    79dd:27f0    mov       word ptr ss:[13BE],cx
    79dd:27f5    mov       word ptr es:[di+0C],ax
    79dd:27f9    mov       word ptr es:[di+0E],cx
    79dd:27fd    add       di,13
    79dd:2800    mov       word ptr ss:[13B4],di
    79dd:2805    mov       bx,76A7
    79dd:2808    jmp       DO_MARIO
    79dd:280b    cmp       al,03
    79dd:280d    jne       281A
    79dd:280f    push      dx
    79dd:2810    mov       dx,837E
    79dd:2813    call      ERROR_ROUT
    79dd:2816    pop       dx
    79dd:2817    jmp       26F4
    79dd:281a    mov       bp,word ptr ss:[0F9C]
    79dd:281f    mov       al,byte ptr [bp+14]
    79dd:2822    test      al,02
    79dd:2824    jne       285B
    79dd:2826    test      al,08
    79dd:2828    jne       2852
    79dd:282a    test      al,01
    79dd:282c    jne       283E
    79dd:282e    test      al,04
    79dd:2830    je        2838
    79dd:2832    call      READMORESOURCE
    79dd:2835    jmp       DO_MARIO
    79dd:2838    mov       dx,7EDC
    79dd:283b    call      FATALERR_ROUT
    79dd:283e    mov       bx,word ptr [bp+02]
    79dd:2841    call      far ptr _OS2CLOSEFILE
    79dd:2846    push      es
    79dd:2847    mov       es,word ptr [bp+10]
    79dd:284a    call      far ptr _OS2FREESEG
    79dd:284f    pop       es
    79dd:2850    jmp       2860
    79dd:2852    mov       ax,word ptr [0F96]
    79dd:2856    mov       word ptr [bp+E5],ax
    79dd:2859    jmp       2860
    79dd:285b    dec       word ptr ss:[0AA6]
    79dd:2860    mov       ax,word ptr [13F0]
    79dd:2864    add       word ptr ss:[13D2],ax
    79dd:2869    adc       word ptr ss:[13D0],00
    79dd:286f    sub       bp,1F
    79dd:2872    push      es
    79dd:2873    push      di
    79dd:2874    mov       ds,word ptr [bp+0C]
    79dd:2877    mov       si,word ptr [bp+0E]
    79dd:287a    mov       ax,word ptr [bp+04]
    79dd:287d    cmp       word ptr ss:[0F96],ax
    79dd:2882    je        2887
    79dd:2884    jmp       E_CONDUNBAL
    79dd:2887    mov       word ptr [0F96],ax
    79dd:288b    mov       ax,word ptr [bp+00]
    79dd:288e    cmp       word ptr ss:[1470],ax
    79dd:2893    jne       E_REPTUNBAL
    79dd:2895    mov       word ptr [1470],ax
    79dd:2899    mov       ax,word ptr [bp+15]
    79dd:289c    mov       word ptr [13F0],ax
    79dd:28a0    mov       ax,word ptr [bp+0A]
    79dd:28a3    mov       es,word ptr ss:[0A9E]
    79dd:28a8    mov       di,word ptr ss:[0AA0]
    79dd:28ad    mov       word ptr es:[di+0C],ax
    79dd:28b1    mov       word ptr [0204],ax
    79dd:28b5    mov       ax,word ptr [bp+1B]
    79dd:28b8    mov       word ptr [0200],ax
    79dd:28bc    mov       ax,word ptr [bp+17]
    79dd:28bf    mov       word ptr [0F98],ax
    79dd:28c3    mov       ax,word ptr [bp+19]
    79dd:28c6    mov       word ptr [0F9A],ax
    79dd:28ca    mov       word ptr ss:[0F9C],bp
    79dd:28cf    pop       di
    79dd:28d0    pop       es
    79dd:28d1    mov       bx,76A7
    79dd:28d4    dec       byte ptr ss:[0F8A]
    79dd:28d9    je        28DE
    79dd:28db    jmp       2749
    79dd:28de    cmp       byte ptr ss:[9BDD],01
    79dd:28e4    jne       28E9
    79dd:28e6    jmp       2749
    79dd:28e9    call      CALCLENLASTBLK
    79dd:28ec    mov       es,word ptr ss:[13B6]
    79dd:28f1    mov       di,word ptr ss:[13B8]
    79dd:28f6    mov       word ptr es:[di+04],ax
    79dd:28fa    mov       word ptr es:[di+06],dx
    79dd:28fe    xor       ax,ax
    79dd:2900    mov       word ptr es:[di],ax
    79dd:2903    mov       word ptr es:[di+02],ax
    79dd:2907    ret
             E_REPTUNBAL:
    79dd:2908  - mov       dx,7C60
    79dd:290b    call      FATALERR_ROUT
    79dd:290e  - jmp       STOPASSEM
             E_CONDUNBAL:
    79dd:2911  - jg        E_TOOMANYIFS
    79dd:2913  - mov       dx,7CCA
    79dd:2916    call      FATALERR_ROUT
    79dd:2919  - jmp       STOPASSEM
             E_TOOMANYIFS:
    79dd:291c  - mov       dx,7C82
    79dd:291f    call      FATALERR_ROUT
    79dd:2922  - jmp       STOPASSEM
             E_CTRLC_HIT:
    79dd:2925  - mov       dx,7CAB
    79dd:2928    call      FATALERR_ROUT
    79dd:292b  - jmp       STOPASSEM
             E_EXTRACHARS:
    79dd:292e  - push      dx
    79dd:292f    mov       dx,85FA
    79dd:2932    call      ERROR_ROUT
    79dd:2935    pop       dx
             PM:
    79dd:2936    mov       si,dx
    79dd:2938  - mov       word ptr ss:[13EC],ds
    79dd:293d  - mov       word ptr ss:[13EE],si
    79dd:2942  - mov       word ptr ss:[0AAC],0000
    79dd:2949  - call      GETMACRO
    79dd:294c  - mov       ax,word ptr [13F0]
    79dd:2950  - cmp       ax,word ptr ss:[0AAC]
    79dd:2955  - jne       PMOK
    79dd:2957  - push      dx
    79dd:2958    mov       dx,7F13
    79dd:295b    call      ERROR_ROUT
    79dd:295e    pop       dx
             PMOK:
    79dd:295f  - push      es
    79dd:2960  - push      di
    79dd:2961  - mov       es,dx
    79dd:2963  - mov       dx,word ptr es:[bp+0A]
    79dd:2967  - mov       cx,word ptr es:[bp+0C]
    79dd:296b  - push      dx
    79dd:296c  - push      cx
    79dd:296d  - test      byte ptr ss:[0F8B],06
    79dd:2973  - je        PMOKNOL
    79dd:2975  - call      LISTLINE
             PMOKNOL:
    79dd:2978  - call      PARSE_MACRO_PARAMETERS
    79dd:297b  - mov       bp,word ptr ss:[0F9C]
    79dd:2980  - dec       si
    79dd:2981  - dec       si
    79dd:2982  - mov       word ptr [bp+0C],ds
    79dd:2985  - mov       word ptr [bp+0E],si
    79dd:2988  - mov       ax,word ptr [1470]
    79dd:298c  - mov       word ptr [bp+00],ax
    79dd:298f  - mov       ax,word ptr [0F96]
    79dd:2993  - mov       word ptr [bp+04],ax
    79dd:2996  - mov       ax,word ptr [13F0]
    79dd:299a  - mov       word ptr [bp+15],ax
    79dd:299d  - mov       ax,word ptr [0204]
    79dd:29a1  - mov       word ptr [bp+0A],ax
    79dd:29a4  - mov       ax,word ptr [0200]
    79dd:29a8  - mov       word ptr [bp+1B],ax
    79dd:29ab  - mov       ax,word ptr [bp+17]
    79dd:29ae  - mov       di,word ptr [bp+19]
    79dd:29b1  - add       bp,1F
    79dd:29b4  - mov       byte ptr [bp+14],02
    79dd:29b8  - mov       word ptr [bp+17],ax
    79dd:29bb  - mov       word ptr [bp+19],di
    79dd:29be  - mov       ax,word ptr [020A]
    79dd:29c2  - mov       word ptr [bp+1D],ax
    79dd:29c5  - mov       ax,word ptr [020C]
    79dd:29c9  - mov       word ptr [bp+1F],ax
    79dd:29cc  - mov       word ptr ss:[0F9C],bp
    79dd:29d1  - cmp       byte ptr ss:[0F8A],20
    79dd:29d7  - jl        SRCLOK2
    79dd:29d9  - pop       cx
    79dd:29da  - pop       dx
    79dd:29db  - pop       di
    79dd:29dc  - pop       es
    79dd:29dd  - mov       dx,7D45
    79dd:29e0    call      FATALERR_ROUT
    79dd:29e3  - jmp       STOPASSEM
             SRCLOK2:
    79dd:29e6  - inc       byte ptr ss:[0F8A]
    79dd:29eb  - inc       word ptr ss:[0AA6]
    79dd:29f0  - inc       byte ptr ss:[0209]
    79dd:29f5  - cmp       byte ptr ss:[0209],5A
    79dd:29fb  - jb        _MACNUMOK
    79dd:29fd  - mov       byte ptr ss:[0209],41
    79dd:2a03  - inc       byte ptr ss:[0208]
    79dd:2a08  - cmp       byte ptr ss:[0208],5A
    79dd:2a0e  - jb        _MACNUMOK
    79dd:2a10  - mov       byte ptr ss:[0208],41
    79dd:2a16  - inc       byte ptr ss:[0207]
    79dd:2a1b  - cmp       byte ptr ss:[0207],5A
    79dd:2a21  - jb        _MACNUMOK
    79dd:2a23  - mov       byte ptr ss:[0207],41
    79dd:2a29  - inc       byte ptr ss:[0206]
             _MACNUMOK:
    79dd:2a2e  - mov       al,byte ptr [0203]
    79dd:2a32  - inc       al
    79dd:2a34  - mov       es,word ptr ss:[0A9E]
    79dd:2a39  - mov       di,word ptr ss:[0AA0]
    79dd:2a3e  - and       ax,00FF
    79dd:2a41  - mov       word ptr es:[di+0C],ax
    79dd:2a45  - mov       word ptr [0204],ax
    79dd:2a49  - pop       cx
    79dd:2a4a  - pop       dx
    79dd:2a4b  - call      EXPAND_THE_MACRO
    79dd:2a4e  - pop       di
    79dd:2a4f  - pop       es
    79dd:2a50  - mov       si,ax
    79dd:2a52  - mov       ax,86C9
    79dd:2a55  - mov       ds,ax
    79dd:2a57  - mov       bx,76A7
    79dd:2a5a  - xor       ax,ax
    79dd:2a5c    mov       word ptr [0AAE],ax
    79dd:2a60    mov       word ptr [0AB6],ax
    79dd:2a64    mov       word ptr [0AB2],ax
    79dd:2a68    mov       word ptr [0AB4],ax
    79dd:2a6c    mov       word ptr [0AB0],ax
    79dd:2a70    mov       word ptr [0AB8],ax
    79dd:2a74    mov       word ptr [13FF],ax
    79dd:2a78    mov       word ptr [0EDF],ax
    79dd:2a7c    mov       word ptr [248A],ax
    79dd:2a80  - mov       word ptr ss:[13F0],0000
    79dd:2a87  - ret
             PARSE_MACRO_PARAMETERS:
    79dd:2a88  - cmp       byte ptr [si],2E
    79dd:2a8b  - jne       NOBS
    79dd:2a8d  - mov       al,byte ptr [si+01]
    79dd:2a90  - and       al,DF
    79dd:2a92  - mov       byte ptr [0202],al
    79dd:2a96  - add       si,02
    79dd:2a99  - jmp       BSPRESENT
             NOBS:
    79dd:2a9b  - mov       byte ptr ss:[0202],4E
             BSPRESENT:
    79dd:2aa1  - mov       byte ptr ss:[0203],FF
    79dd:2aa7  - mov       bx,7AA9
             SCANPARS:
    79dd:2aaa  - lodsb
    79dd:2aab  - cmp       al,3B
    79dd:2aad  - je        NOPARS
    79dd:2aaf  - cmp       al,0D
    79dd:2ab1  - je        MACCR
    79dd:2ab3  - cmp       al,2C
    79dd:2ab5  - je        GOTPAR
    79dd:2ab7  - xlat
    79dd:2ab9  - or        al,al
    79dd:2abb  - js        SCANPARS
             GOTPAR:
    79dd:2abd  - mov       ax,ss
    79dd:2abf  - mov       es,ax
    79dd:2ac1  - mov       di,0000
             NEWARG:
    79dd:2ac4  - inc       byte ptr ss:[0203]
    79dd:2ac9  - mov       ax,si
    79dd:2acb  - mov       cx,si
    79dd:2acd  - dec       ax
    79dd:2ace  - stosw
    79dd:2acf  - mov       al,byte ptr [si+FF]
    79dd:2ad2  - cmp       al,3C
    79dd:2ad4  - je        ANGLEBRAC
    79dd:2ad6  - cmp       al,2C
    79dd:2ad8  - je        MACOOPS
    79dd:2ada  - xlat
    79dd:2adc  - or        al,al
    79dd:2ade  - js        MACMISS
             ENDPARLP:
    79dd:2ae0  - lodsb
    79dd:2ae1  - xlat
    79dd:2ae3  - or        al,al
    79dd:2ae5  - jns       ENDPARLP
    79dd:2ae7  - cmp       byte ptr [si+FF],2C
    79dd:2aeb  - jne       CALCLEN
             MACOOPS:
    79dd:2aed  - mov       ax,si
    79dd:2aef  - sub       ax,cx
    79dd:2af1  - stosw
    79dd:2af2  - lodsb
    79dd:2af3  - jmp       NEWARG
             MACMISS:
    79dd:2af5  - dec       si
    79dd:2af6  - dec       cx
    79dd:2af7  - jmp       CALCLEN
             ANGLEERR:
    79dd:2af9  - dec       si
    79dd:2afa  - push      dx
    79dd:2afb    mov       dx,8024
    79dd:2afe    call      ERROR_ROUT
    79dd:2b01    pop       dx
             ANGLEBRAC:
    79dd:2b02    mov       word ptr es:[di+FE],cx
    79dd:2b06  - inc       cx
    79dd:2b07  - mov       ah,3E
             MACSRCH:
    79dd:2b09  - lodsb
    79dd:2b0a  - cmp       al,0D
    79dd:2b0c  - je        ANGLEERR
    79dd:2b0e  - cmp       al,ah
    79dd:2b10  - jne       MACSRCH
    79dd:2b12  - lodsb
    79dd:2b13  - cmp       al,2C
    79dd:2b15  - jne       SPEND1
    79dd:2b17  - mov       ax,si
    79dd:2b19  - sub       ax,cx
    79dd:2b1b  - dec       ax
    79dd:2b1c  - stosw
    79dd:2b1d  - lodsb
    79dd:2b1e  - jmp       NEWARG
             SPEND1:
    79dd:2b20  - inc       cx
             CALCLEN:
    79dd:2b21  - mov       ax,si
    79dd:2b23  - sub       ax,cx
    79dd:2b25  - stosw
             NOPARS:
    79dd:2b26  - dec       si
    79dd:2b27  - mov       ah,0D
             MACSKIPEOL:
    79dd:2b29  - lodsb
    79dd:2b2a  - cmp       al,ah
    79dd:2b2c  - jne       MACSKIPEOL
             MACCR:
    79dd:2b2e  - inc       si
    79dd:2b2f  - ret
             EXPAND_THE_MACRO:
    79dd:2b30  - mov       word ptr ss:[9A82],ds
    79dd:2b35  - mov       ds,dx
    79dd:2b37  - mov       si,cx
    79dd:2b39  - mov       ax,86C9
    79dd:2b3c  - mov       es,ax
    79dd:2b3e  - mov       di,word ptr ss:[0200]
    79dd:2b43  - shl       byte ptr ss:[0203],1
    79dd:2b48  - shl       byte ptr ss:[0203],1
    79dd:2b4d  - mov       ax,0A0D
    79dd:2b50  - stosw
    79dd:2b51  - mov       bx,7B29
             EXPANDMACRO:
    79dd:2b54  - mov       cl,5C
             EXPANDMACRO2:
    79dd:2b56  - lodsw
    79dd:2b57  - stosw
    79dd:2b58  - cmp       al,cl
    79dd:2b5a  - je        EMEX
    79dd:2b5c  - cmp       ah,cl
    79dd:2b5e  - jne       EXPANDMACRO2
    79dd:2b60  - jmp       EMEX2
             EMEX:
    79dd:2b62  - dec       di
    79dd:2b63  - mov       al,ah
    79dd:2b65  - jmp       EMEX3
             EMEX2:
    79dd:2b67  - lodsb
             EMEX3:
    79dd:2b68  - xlat
    79dd:2b6a  - or        al,al
    79dd:2b6c  - js        EMSPECIAL
    79dd:2b6e  - cmp       al,byte ptr ss:[0203]
    79dd:2b73  - jg        PARTOOMUCH
    79dd:2b75  - dec       di
    79dd:2b76  - push      ds
    79dd:2b77  - push      si
    79dd:2b78  - xor       ah,ah
    79dd:2b7a  - mov       bp,ax
    79dd:2b7c  - mov       dl,al
    79dd:2b7e  - mov       cx,word ptr [bp+0002]
    79dd:2b82  - or        cx,cx
    79dd:2b84  - je        COPYPAR1
    79dd:2b86  - mov       si,word ptr [bp+0000]
    79dd:2b8a  - mov       ds,word ptr ss:[9A82]
             COPYPAR:
    79dd:2b8f  - lodsb
    79dd:2b90  - stosb
    79dd:2b91  - dec       cx
    79dd:2b92  - jne       COPYPAR
             COPYPAR1:
    79dd:2b94  - pop       si
    79dd:2b95  - pop       ds
    79dd:2b96  - jmp       EXPANDMACRO
             PARTOOMUCH:
    79dd:2b98  - dec       di
    79dd:2b99  - jmp       EXPANDMACRO
             EMSPECIAL:
    79dd:2b9b  - mov       al,byte ptr [si+FF]
    79dd:2b9e  - cmp       al,40
    79dd:2ba0  - je        EMATSA
    79dd:2ba2  - cmp       al,30
    79dd:2ba4  - je        EMBSCHAR
    79dd:2ba6  - cmp       al,24
    79dd:2ba8  - je        EMSTR
    79dd:2baa  - cmp       al,7F
    79dd:2bac  - je        GETNEXTMACEMS
    79dd:2bae  - cmp       al,5C
    79dd:2bb0  - je        EXPANDMACRO
    79dd:2bb2  - or        al,al
    79dd:2bb4  - je        EMEND
    79dd:2bb6  - push      dx
    79dd:2bb7    mov       dx,8078
    79dd:2bba    call      ERROR_ROUT
    79dd:2bbd    pop       dx
             EMATSA:
    79dd:2bbe    mov       byte ptr es:[di+FF],5F
    79dd:2bc3  - mov       ax,word ptr [0206]
    79dd:2bc7  - stosw
    79dd:2bc8  - mov       ax,word ptr [0208]
    79dd:2bcc  - stosw
    79dd:2bcd  - jmp       EXPANDMACRO
             EMSTR:
    79dd:2bcf  - dec       di
    79dd:2bd0  - call      GETSTRINGADDR
    79dd:2bd3  - push      ds
    79dd:2bd4  - push      si
    79dd:2bd5  - mov       si,cx
    79dd:2bd7  - mov       ds,dx
             EMSTRLP:
    79dd:2bd9  - lodsb
    79dd:2bda  - stosb
    79dd:2bdb  - or        al,al
    79dd:2bdd  - jne       EMSTRLP
    79dd:2bdf  - dec       di
    79dd:2be0  - pop       si
    79dd:2be1  - pop       ds
    79dd:2be2  - mov       bx,7B29
    79dd:2be5  - jmp       EXPANDMACRO
             EMBSCHAR:
    79dd:2be8  - mov       al,byte ptr [0202]
    79dd:2bec  - mov       byte ptr es:[di+FF],al
    79dd:2bf0  - jmp       EXPANDMACRO
             GETNEXTMACEMS:
    79dd:2bf3  - push      bx
    79dd:2bf4  - lodsw
    79dd:2bf5  - mov       ds,ax
    79dd:2bf7  - xor       si,si
    79dd:2bf9  - dec       di
    79dd:2bfa  - pop       bx
    79dd:2bfb  - jmp       EXPANDMACRO
             EMEND:
    79dd:2bfe  - mov       byte ptr es:[di+FF],1A
    79dd:2c03  - mov       ax,word ptr [0200]
    79dd:2c07  - mov       word ptr ss:[0200],di
    79dd:2c0c  - ret
             DOTERR:
    79dd:2c0d  - push      dx
    79dd:2c0e    mov       dx,800A
    79dd:2c11    call      ERROR_ROUT
    79dd:2c14    pop       dx
             PARSE65816:
    79dd:2c15    mov       dx,si
    79dd:2c17  - lodsw
    79dd:2c18  - mov       bp,ax
    79dd:2c1a  - and       bp,00FF
    79dd:2c1e  - add       bp,bp
    79dd:2c20  - jmp       word ptr [bp+672B]
             P_MORE:
    79dd:2c24  - dec       si
    79dd:2c25  - inc       dx
    79dd:2c26  - lodsw
    79dd:2c27  - mov       bp,ax
    79dd:2c29  - and       bp,00FF
    79dd:2c2d  - add       bp,bp
    79dd:2c2f  - jmp       word ptr [bp+672B]
             P_EOL:
    79dd:2c33  - ret
             P_GOTEOL:
    79dd:2c34  - dec       si
    79dd:2c35  - dec       si
    79dd:2c36  - ret
             P_EXPR:
    79dd:2c37  - mov       al,byte ptr [13E6]
    79dd:2c3b  - or        al,al
    79dd:2c3d  - je        P_EOK
    79dd:2c3f  - ret
             P_EOK:
    79dd:2c40  - call      NEEDCR
    79dd:2c43  - dec       si
    79dd:2c44  - push      es
    79dd:2c45  - push      di
    79dd:2c46  - push      si
    79dd:2c47  - mov       ax,ss
    79dd:2c49  - mov       es,ax
    79dd:2c4b  - mov       di,8A6E
             PELP:
    79dd:2c4e  - lodsb
    79dd:2c4f  - stosb
    79dd:2c50  - xlat
    79dd:2c52  - or        al,al
    79dd:2c54  - jns       PELP
    79dd:2c56  - mov       al,24
    79dd:2c58  - mov       byte ptr es:[di+FF],al
    79dd:2c5c  - pop       si
    79dd:2c5d  - pop       di
    79dd:2c5e  - pop       es
    79dd:2c5f  - call      CONVEXPRESS
    79dd:2c62  - test      byte ptr ss:[0ACE],C0
    79dd:2c68  - je        2C6D
    79dd:2c6a    jmp       P_IFERR
    79dd:2c6d  - mov       word ptr ss:[9A7C],dx
    79dd:2c72  - mov       word ptr ss:[9A7E],cx
    79dd:2c77  - push      ds
    79dd:2c78    push      dx
    79dd:2c79    mov       dx,8AC9
    79dd:2c7c    mov       ds,dx
    79dd:2c7e    mov       dx,8A62
    79dd:2c81    call      far ptr _OS2PRTSTRING
    79dd:2c86    pop       dx
    79dd:2c87    pop       ds
    79dd:2c88  - push      ds
    79dd:2c89    push      dx
    79dd:2c8a    mov       dx,8AC9
    79dd:2c8d    mov       ds,dx
    79dd:2c8f    mov       dx,8A6E
    79dd:2c92    call      far ptr _OS2PRTSTRING
    79dd:2c97    pop       dx
    79dd:2c98    pop       ds
    79dd:2c99  - push      ds
    79dd:2c9a    push      dx
    79dd:2c9b    mov       dx,8AC9
    79dd:2c9e    mov       ds,dx
    79dd:2ca0    mov       dx,89A9
    79dd:2ca3    call      far ptr _OS2PRTSTRING
    79dd:2ca8    pop       dx
    79dd:2ca9    pop       ds
    79dd:2caa  - push      cx
    79dd:2cab    mov       byte ptr ss:[2480],00
    79dd:2cb1    mov       cx,word ptr ss:[13F0]
    79dd:2cb6    call      PRTDECW
    79dd:2cb9    pop       cx
    79dd:2cba  - push      ds
    79dd:2cbb    push      dx
    79dd:2cbc    mov       dx,8AC9
    79dd:2cbf    mov       ds,dx
    79dd:2cc1    mov       dx,89B3
    79dd:2cc4    call      far ptr _OS2PRTSTRING
    79dd:2cc9    pop       dx
    79dd:2cca    pop       ds
    79dd:2ccb  - push      dx
    79dd:2ccc    push      cx
    79dd:2ccd    mov       byte ptr ss:[2480],00
    79dd:2cd3    mov       dx,word ptr ss:[9A7C]
    79dd:2cd8    mov       cx,word ptr ss:[9A7E]
    79dd:2cdd    call      PRTDECL
    79dd:2ce0    pop       cx
    79dd:2ce1    pop       dx
    79dd:2ce2  - push      ds
    79dd:2ce3    push      dx
    79dd:2ce4    mov       dx,8AC9
    79dd:2ce7    mov       ds,dx
    79dd:2ce9    mov       dx,899D
    79dd:2cec    call      far ptr _OS2PRTSTRING
    79dd:2cf1    pop       dx
    79dd:2cf2    pop       ds
    79dd:2cf3  - mov       ax,word ptr [9A7D]
    79dd:2cf7  - or        al,al
    79dd:2cf9  - jne       P_EXPR1
    79dd:2cfb  - mov       ax,word ptr [9A7C]
    79dd:2cff  - or        al,al
    79dd:2d01  - jne       P_EXPR2
    79dd:2d03  - mov       ax,word ptr [9A7F]
    79dd:2d07  - or        al,al
    79dd:2d09  - jne       P_EXPR3
    79dd:2d0b  - mov       ax,word ptr [9A7E]
    79dd:2d0f  - call      PRTHEXB
    79dd:2d12  - push      ds
    79dd:2d13    push      dx
    79dd:2d14    mov       dx,8AC9
    79dd:2d17    mov       ds,dx
    79dd:2d19    mov       dx,899F
    79dd:2d1c    call      far ptr _OS2PRTSTRING
    79dd:2d21    pop       dx
    79dd:2d22    pop       ds
    79dd:2d23  - ret
             P_EXPR1:
    79dd:2d24  - call      PRTHEXB
    79dd:2d27  - mov       ax,word ptr [9A7C]
             P_EXPR2:
    79dd:2d2b  - call      PRTHEXB
    79dd:2d2e  - mov       ax,word ptr [9A7F]
             P_EXPR3:
    79dd:2d32  - call      PRTHEXB
    79dd:2d35  - mov       ax,word ptr [9A7E]
    79dd:2d39  - call      PRTHEXB
    79dd:2d3c  - push      ds
    79dd:2d3d    push      dx
    79dd:2d3e    mov       dx,8AC9
    79dd:2d41    mov       ds,dx
    79dd:2d43    mov       dx,899F
    79dd:2d46    call      far ptr _OS2PRTSTRING
    79dd:2d4b    pop       dx
    79dd:2d4c    pop       ds
    79dd:2d4d  - ret
             P_ADC:
    79dd:2d4e  - mov       al,byte ptr [0ABA]
    79dd:2d52    test      al,01
    79dd:2d54    je        2D5E
    79dd:2d56    mov       ax,word ptr [13F0]
    79dd:2d5a    mov       word ptr [0AB2],ax
    79dd:2d5e  - call      GETEA
    79dd:2d61    mov       al,byte ptr [si]
    79dd:2d63    xlat
    79dd:2d65    or        al,al
    79dd:2d67    js        2D6C
    79dd:2d69    jmp       E_EXTRACHARS
    79dd:2d6c    mov       ax,word ptr [bp+6E2D]
    79dd:2d70    or        al,al
    79dd:2d72    je        2D7C
    79dd:2d74    stosb
    79dd:2d75    mov       al,ah
    79dd:2d77    xor       ah,ah
    79dd:2d79    add       di,ax
    79dd:2d7b    ret
    79dd:2d7c    push      dx
    79dd:2d7d    mov       dx,7F7F
    79dd:2d80    call      ERROR_ROUT
    79dd:2d83    pop       dx
    79dd:2d84    ret
             P_AND:
    79dd:2d85  - mov       al,byte ptr [0ABA]
    79dd:2d89    test      al,01
    79dd:2d8b    je        2D95
    79dd:2d8d    mov       ax,word ptr [13F0]
    79dd:2d91    mov       word ptr [0AB2],ax
    79dd:2d95  - call      GETEA
    79dd:2d98    mov       al,byte ptr [si]
    79dd:2d9a    xlat
    79dd:2d9c    or        al,al
    79dd:2d9e    js        2DA3
    79dd:2da0    jmp       E_EXTRACHARS
    79dd:2da3    mov       ax,word ptr [bp+6E5B]
    79dd:2da7    or        al,al
    79dd:2da9    je        2DB3
    79dd:2dab    stosb
    79dd:2dac    mov       al,ah
    79dd:2dae    xor       ah,ah
    79dd:2db0    add       di,ax
    79dd:2db2    ret
    79dd:2db3    push      dx
    79dd:2db4    mov       dx,7F7F
    79dd:2db7    call      ERROR_ROUT
    79dd:2dba    pop       dx
    79dd:2dbb    ret
             P_ASL:
    79dd:2dbc  - call      GETEA
    79dd:2dbf    mov       al,byte ptr [si]
    79dd:2dc1    xlat
    79dd:2dc3    or        al,al
    79dd:2dc5    js        2DCA
    79dd:2dc7    jmp       E_EXTRACHARS
    79dd:2dca    mov       ax,word ptr [bp+6E89]
    79dd:2dce    or        al,al
    79dd:2dd0    je        2DDA
    79dd:2dd2    stosb
    79dd:2dd3    mov       al,ah
    79dd:2dd5    xor       ah,ah
    79dd:2dd7    add       di,ax
    79dd:2dd9    ret
    79dd:2dda    push      dx
    79dd:2ddb    mov       dx,7F7F
    79dd:2dde    call      ERROR_ROUT
    79dd:2de1    pop       dx
    79dd:2de2    ret
             P_BCC:
    79dd:2de3  - mov       al,byte ptr [si]
    79dd:2de5    xlat
    79dd:2de7    or        al,al
    79dd:2de9    js        2DEE
    79dd:2deb    jmp       PM
    79dd:2dee  - lodsb
    79dd:2def    xlat
    79dd:2df1    or        al,al
    79dd:2df3    js        2DEE
    79dd:2df5    dec       si
    79dd:2df6    call      CONVEXPRESS
    79dd:2df9    test      byte ptr ss:[0ACE],C0
    79dd:2dff    je        2E50
    79dd:2e01    test      byte ptr ss:[0ACE],40
    79dd:2e07    jne       2E47
    79dd:2e09    push      es
    79dd:2e0a    push      bp
    79dd:2e0b    mov       es,word ptr ss:[0AC5]
    79dd:2e10    mov       bp,word ptr ss:[0AC9]
    79dd:2e15    mov       word ptr es:[bp+06],di
    79dd:2e19    mov       ax,word ptr [0F92]
    79dd:2e1d    mov       word ptr es:[bp+0A],ax
    79dd:2e21    mov       ax,word ptr [0F94]
    79dd:2e25    mov       word ptr es:[bp+0C],ax
    79dd:2e29    mov       word ptr es:[bp+02],0008
    79dd:2e2f    add       bp,15
    79dd:2e32    mov       word ptr ss:[0AC7],bp
    79dd:2e37    cmp       bp,7F00
    79dd:2e3b    jb        2E40
    79dd:2e3d    call      MOREFR
    79dd:2e40    pop       bp
    79dd:2e41    pop       es
    79dd:2e42    mov       ax,0090
    79dd:2e45    stosw
    79dd:2e46    ret
    79dd:2e47    push      dx
    79dd:2e48    mov       dx,8595
    79dd:2e4b    call      ERROR_ROUT
    79dd:2e4e    pop       dx
    79dd:2e4f    ret
    79dd:2e50    mov       bp,bx
    79dd:2e52    sub       dx,word ptr ss:[0F92]
    79dd:2e57    jne       2E73
    79dd:2e59    sub       cx,word ptr ss:[0F94]
    79dd:2e5e    sub       cx,02
    79dd:2e61    cmp       cx,80
    79dd:2e64    jl        2E73
    79dd:2e66    cmp       cx,7F
    79dd:2e69    jg        2E73
    79dd:2e6b    mov       ah,cl
    79dd:2e6d    mov       al,90
    79dd:2e6f    stosw
    79dd:2e70    mov       bx,bp
    79dd:2e72    ret
    79dd:2e73    push      dx
    79dd:2e74    mov       dx,7F46
    79dd:2e77    call      ERROR_ROUT
    79dd:2e7a    pop       dx
    79dd:2e7b    ret
             P_BCS:
    79dd:2e7c  - mov       al,byte ptr [si]
    79dd:2e7e    xlat
    79dd:2e80    or        al,al
    79dd:2e82    js        2E87
    79dd:2e84    jmp       PM
    79dd:2e87  - lodsb
    79dd:2e88    xlat
    79dd:2e8a    or        al,al
    79dd:2e8c    js        2E87
    79dd:2e8e    dec       si
    79dd:2e8f    call      CONVEXPRESS
    79dd:2e92    test      byte ptr ss:[0ACE],C0
    79dd:2e98    je        2EE9
    79dd:2e9a    test      byte ptr ss:[0ACE],40
    79dd:2ea0    jne       2EE0
    79dd:2ea2    push      es
    79dd:2ea3    push      bp
    79dd:2ea4    mov       es,word ptr ss:[0AC5]
    79dd:2ea9    mov       bp,word ptr ss:[0AC9]
    79dd:2eae    mov       word ptr es:[bp+06],di
    79dd:2eb2    mov       ax,word ptr [0F92]
    79dd:2eb6    mov       word ptr es:[bp+0A],ax
    79dd:2eba    mov       ax,word ptr [0F94]
    79dd:2ebe    mov       word ptr es:[bp+0C],ax
    79dd:2ec2    mov       word ptr es:[bp+02],0008
    79dd:2ec8    add       bp,15
    79dd:2ecb    mov       word ptr ss:[0AC7],bp
    79dd:2ed0    cmp       bp,7F00
    79dd:2ed4    jb        2ED9
    79dd:2ed6    call      MOREFR
    79dd:2ed9    pop       bp
    79dd:2eda    pop       es
    79dd:2edb    mov       ax,00B0
    79dd:2ede    stosw
    79dd:2edf    ret
    79dd:2ee0    push      dx
    79dd:2ee1    mov       dx,8595
    79dd:2ee4    call      ERROR_ROUT
    79dd:2ee7    pop       dx
    79dd:2ee8    ret
    79dd:2ee9    mov       bp,bx
    79dd:2eeb    sub       dx,word ptr ss:[0F92]
    79dd:2ef0    jne       2F0C
    79dd:2ef2    sub       cx,word ptr ss:[0F94]
    79dd:2ef7    sub       cx,02
    79dd:2efa    cmp       cx,80
    79dd:2efd    jl        2F0C
    79dd:2eff    cmp       cx,7F
    79dd:2f02    jg        2F0C
    79dd:2f04    mov       ah,cl
    79dd:2f06    mov       al,B0
    79dd:2f08    stosw
    79dd:2f09    mov       bx,bp
    79dd:2f0b    ret
    79dd:2f0c    push      dx
    79dd:2f0d    mov       dx,7F46
    79dd:2f10    call      ERROR_ROUT
    79dd:2f13    pop       dx
    79dd:2f14    ret
             P_BEQ:
    79dd:2f15  - lodsb
    79dd:2f16    xlat
    79dd:2f18    or        al,al
    79dd:2f1a    js        P_BEQ
    79dd:2f1c    dec       si
    79dd:2f1d    call      CONVEXPRESS
    79dd:2f20    test      byte ptr ss:[0ACE],C0
    79dd:2f26    je        2F77
    79dd:2f28    test      byte ptr ss:[0ACE],40
    79dd:2f2e    jne       2F6E
    79dd:2f30    push      es
    79dd:2f31    push      bp
    79dd:2f32    mov       es,word ptr ss:[0AC5]
    79dd:2f37    mov       bp,word ptr ss:[0AC9]
    79dd:2f3c    mov       word ptr es:[bp+06],di
    79dd:2f40    mov       ax,word ptr [0F92]
    79dd:2f44    mov       word ptr es:[bp+0A],ax
    79dd:2f48    mov       ax,word ptr [0F94]
    79dd:2f4c    mov       word ptr es:[bp+0C],ax
    79dd:2f50    mov       word ptr es:[bp+02],0008
    79dd:2f56    add       bp,15
    79dd:2f59    mov       word ptr ss:[0AC7],bp
    79dd:2f5e    cmp       bp,7F00
    79dd:2f62    jb        2F67
    79dd:2f64    call      MOREFR
    79dd:2f67    pop       bp
    79dd:2f68    pop       es
    79dd:2f69    mov       ax,00F0
    79dd:2f6c    stosw
    79dd:2f6d    ret
    79dd:2f6e    push      dx
    79dd:2f6f    mov       dx,8595
    79dd:2f72    call      ERROR_ROUT
    79dd:2f75    pop       dx
    79dd:2f76    ret
    79dd:2f77    mov       bp,bx
    79dd:2f79    sub       dx,word ptr ss:[0F92]
    79dd:2f7e    jne       2F9A
    79dd:2f80    sub       cx,word ptr ss:[0F94]
    79dd:2f85    sub       cx,02
    79dd:2f88    cmp       cx,80
    79dd:2f8b    jl        2F9A
    79dd:2f8d    cmp       cx,7F
    79dd:2f90    jg        2F9A
    79dd:2f92    mov       ah,cl
    79dd:2f94    mov       al,F0
    79dd:2f96    stosw
    79dd:2f97    mov       bx,bp
    79dd:2f99    ret
    79dd:2f9a    push      dx
    79dd:2f9b    mov       dx,7F46
    79dd:2f9e    call      ERROR_ROUT
    79dd:2fa1    pop       dx
    79dd:2fa2    ret
             P_BIT:
    79dd:2fa3  - mov       al,byte ptr [0ABA]
    79dd:2fa7    test      al,01
    79dd:2fa9    je        2FB3
    79dd:2fab    mov       ax,word ptr [13F0]
    79dd:2faf    mov       word ptr [0AB2],ax
    79dd:2fb3  - call      GETEA
    79dd:2fb6    mov       al,byte ptr [si]
    79dd:2fb8    xlat
    79dd:2fba    or        al,al
    79dd:2fbc    js        2FC1
    79dd:2fbe    jmp       E_EXTRACHARS
    79dd:2fc1    mov       ax,word ptr [bp+6EB7]
    79dd:2fc5    or        al,al
    79dd:2fc7    je        2FD1
    79dd:2fc9    stosb
    79dd:2fca    mov       al,ah
    79dd:2fcc    xor       ah,ah
    79dd:2fce    add       di,ax
    79dd:2fd0    ret
    79dd:2fd1    push      dx
    79dd:2fd2    mov       dx,7F7F
    79dd:2fd5    call      ERROR_ROUT
    79dd:2fd8    pop       dx
    79dd:2fd9    ret
             P_BMI:
    79dd:2fda  - lodsb
    79dd:2fdb    xlat
    79dd:2fdd    or        al,al
    79dd:2fdf    js        P_BMI
    79dd:2fe1    dec       si
    79dd:2fe2    call      CONVEXPRESS
    79dd:2fe5    test      byte ptr ss:[0ACE],C0
    79dd:2feb    je        303C
    79dd:2fed    test      byte ptr ss:[0ACE],40
    79dd:2ff3    jne       3033
    79dd:2ff5    push      es
    79dd:2ff6    push      bp
    79dd:2ff7    mov       es,word ptr ss:[0AC5]
    79dd:2ffc    mov       bp,word ptr ss:[0AC9]
    79dd:3001    mov       word ptr es:[bp+06],di
    79dd:3005    mov       ax,word ptr [0F92]
    79dd:3009    mov       word ptr es:[bp+0A],ax
    79dd:300d    mov       ax,word ptr [0F94]
    79dd:3011    mov       word ptr es:[bp+0C],ax
    79dd:3015    mov       word ptr es:[bp+02],0008
    79dd:301b    add       bp,15
    79dd:301e    mov       word ptr ss:[0AC7],bp
    79dd:3023    cmp       bp,7F00
    79dd:3027    jb        302C
    79dd:3029    call      MOREFR
    79dd:302c    pop       bp
    79dd:302d    pop       es
    79dd:302e    mov       ax,0030
    79dd:3031    stosw
    79dd:3032    ret
    79dd:3033    push      dx
    79dd:3034    mov       dx,8595
    79dd:3037    call      ERROR_ROUT
    79dd:303a    pop       dx
    79dd:303b    ret
    79dd:303c    mov       bp,bx
    79dd:303e    sub       dx,word ptr ss:[0F92]
    79dd:3043    jne       305F
    79dd:3045    sub       cx,word ptr ss:[0F94]
    79dd:304a    sub       cx,02
    79dd:304d    cmp       cx,80
    79dd:3050    jl        305F
    79dd:3052    cmp       cx,7F
    79dd:3055    jg        305F
    79dd:3057    mov       ah,cl
    79dd:3059    mov       al,30
    79dd:305b    stosw
    79dd:305c    mov       bx,bp
    79dd:305e    ret
    79dd:305f    push      dx
    79dd:3060    mov       dx,7F46
    79dd:3063    call      ERROR_ROUT
    79dd:3066    pop       dx
    79dd:3067    ret
             P_BNE:
    79dd:3068  - lodsb
    79dd:3069    xlat
    79dd:306b    or        al,al
    79dd:306d    js        P_BNE
    79dd:306f    dec       si
    79dd:3070    call      CONVEXPRESS
    79dd:3073    test      byte ptr ss:[0ACE],C0
    79dd:3079    je        30CA
    79dd:307b    test      byte ptr ss:[0ACE],40
    79dd:3081    jne       30C1
    79dd:3083    push      es
    79dd:3084    push      bp
    79dd:3085    mov       es,word ptr ss:[0AC5]
    79dd:308a    mov       bp,word ptr ss:[0AC9]
    79dd:308f    mov       word ptr es:[bp+06],di
    79dd:3093    mov       ax,word ptr [0F92]
    79dd:3097    mov       word ptr es:[bp+0A],ax
    79dd:309b    mov       ax,word ptr [0F94]
    79dd:309f    mov       word ptr es:[bp+0C],ax
    79dd:30a3    mov       word ptr es:[bp+02],0008
    79dd:30a9    add       bp,15
    79dd:30ac    mov       word ptr ss:[0AC7],bp
    79dd:30b1    cmp       bp,7F00
    79dd:30b5    jb        30BA
    79dd:30b7    call      MOREFR
    79dd:30ba    pop       bp
    79dd:30bb    pop       es
    79dd:30bc    mov       ax,00D0
    79dd:30bf    stosw
    79dd:30c0    ret
    79dd:30c1    push      dx
    79dd:30c2    mov       dx,8595
    79dd:30c5    call      ERROR_ROUT
    79dd:30c8    pop       dx
    79dd:30c9    ret
    79dd:30ca    mov       bp,bx
    79dd:30cc    sub       dx,word ptr ss:[0F92]
    79dd:30d1    jne       30ED
    79dd:30d3    sub       cx,word ptr ss:[0F94]
    79dd:30d8    sub       cx,02
    79dd:30db    cmp       cx,80
    79dd:30de    jl        30ED
    79dd:30e0    cmp       cx,7F
    79dd:30e3    jg        30ED
    79dd:30e5    mov       ah,cl
    79dd:30e7    mov       al,D0
    79dd:30e9    stosw
    79dd:30ea    mov       bx,bp
    79dd:30ec    ret
    79dd:30ed    push      dx
    79dd:30ee    mov       dx,7F46
    79dd:30f1    call      ERROR_ROUT
    79dd:30f4    pop       dx
    79dd:30f5    ret
             P_BPL:
    79dd:30f6  - lodsb
    79dd:30f7    xlat
    79dd:30f9    or        al,al
    79dd:30fb    js        P_BPL
    79dd:30fd    dec       si
    79dd:30fe    call      CONVEXPRESS
    79dd:3101    test      byte ptr ss:[0ACE],C0
    79dd:3107    je        3158
    79dd:3109    test      byte ptr ss:[0ACE],40
    79dd:310f    jne       314F
    79dd:3111    push      es
    79dd:3112    push      bp
    79dd:3113    mov       es,word ptr ss:[0AC5]
    79dd:3118    mov       bp,word ptr ss:[0AC9]
    79dd:311d    mov       word ptr es:[bp+06],di
    79dd:3121    mov       ax,word ptr [0F92]
    79dd:3125    mov       word ptr es:[bp+0A],ax
    79dd:3129    mov       ax,word ptr [0F94]
    79dd:312d    mov       word ptr es:[bp+0C],ax
    79dd:3131    mov       word ptr es:[bp+02],0008
    79dd:3137    add       bp,15
    79dd:313a    mov       word ptr ss:[0AC7],bp
    79dd:313f    cmp       bp,7F00
    79dd:3143    jb        3148
    79dd:3145    call      MOREFR
    79dd:3148    pop       bp
    79dd:3149    pop       es
    79dd:314a    mov       ax,0010
    79dd:314d    stosw
    79dd:314e    ret
    79dd:314f    push      dx
    79dd:3150    mov       dx,8595
    79dd:3153    call      ERROR_ROUT
    79dd:3156    pop       dx
    79dd:3157    ret
    79dd:3158    mov       bp,bx
    79dd:315a    sub       dx,word ptr ss:[0F92]
    79dd:315f    jne       317B
    79dd:3161    sub       cx,word ptr ss:[0F94]
    79dd:3166    sub       cx,02
    79dd:3169    cmp       cx,80
    79dd:316c    jl        317B
    79dd:316e    cmp       cx,7F
    79dd:3171    jg        317B
    79dd:3173    mov       ah,cl
    79dd:3175    mov       al,10
    79dd:3177    stosw
    79dd:3178    mov       bx,bp
    79dd:317a    ret
    79dd:317b    push      dx
    79dd:317c    mov       dx,7F46
    79dd:317f    call      ERROR_ROUT
    79dd:3182    pop       dx
    79dd:3183    ret
             P_BRA:
    79dd:3184  - mov       al,byte ptr [si]
    79dd:3186    xlat
    79dd:3188    or        al,al
    79dd:318a    js        318F
    79dd:318c    jmp       PM
    79dd:318f  - lodsb
    79dd:3190    xlat
    79dd:3192    or        al,al
    79dd:3194    js        318F
    79dd:3196    dec       si
    79dd:3197    call      CONVEXPRESS
    79dd:319a    test      byte ptr ss:[0ACE],C0
    79dd:31a0    je        31F1
    79dd:31a2    test      byte ptr ss:[0ACE],40
    79dd:31a8    jne       31E8
    79dd:31aa    push      es
    79dd:31ab    push      bp
    79dd:31ac    mov       es,word ptr ss:[0AC5]
    79dd:31b1    mov       bp,word ptr ss:[0AC9]
    79dd:31b6    mov       word ptr es:[bp+06],di
    79dd:31ba    mov       ax,word ptr [0F92]
    79dd:31be    mov       word ptr es:[bp+0A],ax
    79dd:31c2    mov       ax,word ptr [0F94]
    79dd:31c6    mov       word ptr es:[bp+0C],ax
    79dd:31ca    mov       word ptr es:[bp+02],0008
    79dd:31d0    add       bp,15
    79dd:31d3    mov       word ptr ss:[0AC7],bp
    79dd:31d8    cmp       bp,7F00
    79dd:31dc    jb        31E1
    79dd:31de    call      MOREFR
    79dd:31e1    pop       bp
    79dd:31e2    pop       es
    79dd:31e3    mov       ax,0080
    79dd:31e6    stosw
    79dd:31e7    ret
    79dd:31e8    push      dx
    79dd:31e9    mov       dx,8595
    79dd:31ec    call      ERROR_ROUT
    79dd:31ef    pop       dx
    79dd:31f0    ret
    79dd:31f1    mov       bp,bx
    79dd:31f3    sub       dx,word ptr ss:[0F92]
    79dd:31f8    jne       3214
    79dd:31fa    sub       cx,word ptr ss:[0F94]
    79dd:31ff    sub       cx,02
    79dd:3202    cmp       cx,80
    79dd:3205    jl        3214
    79dd:3207    cmp       cx,7F
    79dd:320a    jg        3214
    79dd:320c    mov       ah,cl
    79dd:320e    mov       al,80
    79dd:3210    stosw
    79dd:3211    mov       bx,bp
    79dd:3213    ret
    79dd:3214    push      dx
    79dd:3215    mov       dx,7F46
    79dd:3218    call      ERROR_ROUT
    79dd:321b    pop       dx
    79dd:321c    ret
             BCCERR:
    79dd:321d  - push      dx
    79dd:321e    mov       dx,7F46
    79dd:3221    call      ERROR_ROUT
    79dd:3224    pop       dx
             P_BRK:
    79dd:3225  - mov       al,00
    79dd:3227    stosb
    79dd:3228  - ret
             P_BRL:
    79dd:3229  - mov       al,byte ptr [si]
    79dd:322b    xlat
    79dd:322d    or        al,al
    79dd:322f    js        3234
    79dd:3231    jmp       PM
    79dd:3234  - mov       byte ptr es:[di],82
             P_LCC:
    79dd:3238  - lodsb
    79dd:3239    xlat
    79dd:323b    or        al,al
    79dd:323d    js        P_LCC
    79dd:323f    dec       si
    79dd:3240  - call      CONVEXPRESS
    79dd:3243  - test      byte ptr ss:[0ACE],C0
    79dd:3249  - je        NOTFR
    79dd:324b  - test      byte ptr ss:[0ACE],40
    79dd:3251  - jne       LCCEXTERN
    79dd:3253  - push      es
    79dd:3254  - push      bp
    79dd:3255  - mov       es,word ptr ss:[0AC5]
    79dd:325a  - mov       bp,word ptr ss:[0AC9]
    79dd:325f  - mov       ax,word ptr [0F92]
    79dd:3263  - mov       word ptr es:[bp+0A],ax
    79dd:3267  - mov       ax,word ptr [0F94]
    79dd:326b  - mov       word ptr es:[bp+0C],ax
    79dd:326f  - mov       word ptr es:[bp+06],di
    79dd:3273  - mov       word ptr es:[bp+02],000A
    79dd:3279  - add       bp,15
    79dd:327c  - mov       word ptr ss:[0AC7],bp
    79dd:3281  - cmp       bp,7F00
    79dd:3285    jb        328A
    79dd:3287    call      MOREFR
    79dd:328a  - pop       bp
    79dd:328b  - pop       es
    79dd:328c  - xor       ax,ax
    79dd:328e  - mov       word ptr es:[di+01],ax
    79dd:3292  - add       di,03
    79dd:3295  - ret
             NOTFR:
    79dd:3296  - sub       cx,word ptr ss:[0F94]
    79dd:329b  - sbb       dx,word ptr ss:[0F92]
    79dd:32a0  - sub       cx,03
    79dd:32a3  - sbb       dx,00
    79dd:32a6  - js        BRLMIN
    79dd:32a8  - je        32AD
    79dd:32aa    jmp       BCCERR
    79dd:32ad  - cmp       cx,7FFF
    79dd:32b1  - jle       SETBRL
    79dd:32b3    jmp       BCCERR
             SETBRL:
    79dd:32b6  - inc       di
    79dd:32b7  - mov       ax,cx
    79dd:32b9  - stosw
    79dd:32ba  - ret
             BRLMIN:
    79dd:32bb  - cmp       dx,FF
    79dd:32be  - je        32C3
    79dd:32c0    jmp       BCCERR
    79dd:32c3  - cmp       cx,8000
    79dd:32c7  - jge       32CC
    79dd:32c9    jmp       BCCERR
    79dd:32cc  - jmp       SETBRL
             LCCEXTERN:
    79dd:32ce  - push      dx
    79dd:32cf    mov       dx,8595
    79dd:32d2    call      ERROR_ROUT
    79dd:32d5    pop       dx
             P_BVC:
    79dd:32d6  - mov       al,byte ptr [si]
    79dd:32d8    xlat
    79dd:32da    or        al,al
    79dd:32dc    js        32E1
    79dd:32de    jmp       PM
    79dd:32e1  - lodsb
    79dd:32e2    xlat
    79dd:32e4    or        al,al
    79dd:32e6    js        32E1
    79dd:32e8    dec       si
    79dd:32e9    call      CONVEXPRESS
    79dd:32ec    test      byte ptr ss:[0ACE],C0
    79dd:32f2    je        3343
    79dd:32f4    test      byte ptr ss:[0ACE],40
    79dd:32fa    jne       333A
    79dd:32fc    push      es
    79dd:32fd    push      bp
    79dd:32fe    mov       es,word ptr ss:[0AC5]
    79dd:3303    mov       bp,word ptr ss:[0AC9]
    79dd:3308    mov       word ptr es:[bp+06],di
    79dd:330c    mov       ax,word ptr [0F92]
    79dd:3310    mov       word ptr es:[bp+0A],ax
    79dd:3314    mov       ax,word ptr [0F94]
    79dd:3318    mov       word ptr es:[bp+0C],ax
    79dd:331c    mov       word ptr es:[bp+02],0008
    79dd:3322    add       bp,15
    79dd:3325    mov       word ptr ss:[0AC7],bp
    79dd:332a    cmp       bp,7F00
    79dd:332e    jb        3333
    79dd:3330    call      MOREFR
    79dd:3333    pop       bp
    79dd:3334    pop       es
    79dd:3335    mov       ax,0050
    79dd:3338    stosw
    79dd:3339    ret
    79dd:333a    push      dx
    79dd:333b    mov       dx,8595
    79dd:333e    call      ERROR_ROUT
    79dd:3341    pop       dx
    79dd:3342    ret
    79dd:3343    mov       bp,bx
    79dd:3345    sub       dx,word ptr ss:[0F92]
    79dd:334a    jne       3366
    79dd:334c    sub       cx,word ptr ss:[0F94]
    79dd:3351    sub       cx,02
    79dd:3354    cmp       cx,80
    79dd:3357    jl        3366
    79dd:3359    cmp       cx,7F
    79dd:335c    jg        3366
    79dd:335e    mov       ah,cl
    79dd:3360    mov       al,50
    79dd:3362    stosw
    79dd:3363    mov       bx,bp
    79dd:3365    ret
    79dd:3366    push      dx
    79dd:3367    mov       dx,7F46
    79dd:336a    call      ERROR_ROUT
    79dd:336d    pop       dx
    79dd:336e    ret
    79dd:336f  - ret
             P_BVS:
    79dd:3370  - mov       al,byte ptr [si]
    79dd:3372    xlat
    79dd:3374    or        al,al
    79dd:3376    js        337B
    79dd:3378    jmp       PM
    79dd:337b  - lodsb
    79dd:337c    xlat
    79dd:337e    or        al,al
    79dd:3380    js        337B
    79dd:3382    dec       si
    79dd:3383    call      CONVEXPRESS
    79dd:3386    test      byte ptr ss:[0ACE],C0
    79dd:338c    je        33DD
    79dd:338e    test      byte ptr ss:[0ACE],40
    79dd:3394    jne       33D4
    79dd:3396    push      es
    79dd:3397    push      bp
    79dd:3398    mov       es,word ptr ss:[0AC5]
    79dd:339d    mov       bp,word ptr ss:[0AC9]
    79dd:33a2    mov       word ptr es:[bp+06],di
    79dd:33a6    mov       ax,word ptr [0F92]
    79dd:33aa    mov       word ptr es:[bp+0A],ax
    79dd:33ae    mov       ax,word ptr [0F94]
    79dd:33b2    mov       word ptr es:[bp+0C],ax
    79dd:33b6    mov       word ptr es:[bp+02],0008
    79dd:33bc    add       bp,15
    79dd:33bf    mov       word ptr ss:[0AC7],bp
    79dd:33c4    cmp       bp,7F00
    79dd:33c8    jb        33CD
    79dd:33ca    call      MOREFR
    79dd:33cd    pop       bp
    79dd:33ce    pop       es
    79dd:33cf    mov       ax,0070
    79dd:33d2    stosw
    79dd:33d3    ret
    79dd:33d4    push      dx
    79dd:33d5    mov       dx,8595
    79dd:33d8    call      ERROR_ROUT
    79dd:33db    pop       dx
    79dd:33dc    ret
    79dd:33dd    mov       bp,bx
    79dd:33df    sub       dx,word ptr ss:[0F92]
    79dd:33e4    jne       3400
    79dd:33e6    sub       cx,word ptr ss:[0F94]
    79dd:33eb    sub       cx,02
    79dd:33ee    cmp       cx,80
    79dd:33f1    jl        3400
    79dd:33f3    cmp       cx,7F
    79dd:33f6    jg        3400
    79dd:33f8    mov       ah,cl
    79dd:33fa    mov       al,70
    79dd:33fc    stosw
    79dd:33fd    mov       bx,bp
    79dd:33ff    ret
    79dd:3400    push      dx
    79dd:3401    mov       dx,7F46
    79dd:3404    call      ERROR_ROUT
    79dd:3407    pop       dx
    79dd:3408    ret
    79dd:3409  - ret
             P_CHECKMAC:
    79dd:340a  - mov       al,byte ptr [si]
    79dd:340c    xlat
    79dd:340e    or        al,al
    79dd:3410    js        3415
    79dd:3412    jmp       PM
    79dd:3415  - lodsb
    79dd:3416    xlat
    79dd:3418    or        al,al
    79dd:341a    js        3415
    79dd:341c    dec       si
    79dd:341d  - lodsw
    79dd:341e  - and       ax,DFDF
    79dd:3421  - cmp       ax,4E4F
    79dd:3424  - je        P_CHECKON
    79dd:3426  - cmp       ax,464F
    79dd:3429  - je        P_CHECKOFF
    79dd:342b  - dec       si
    79dd:342c  - push      dx
    79dd:342d    mov       dx,8078
    79dd:3430    call      ERROR_ROUT
    79dd:3433    pop       dx
             P_CHECKON:
    79dd:3434    mov       byte ptr ss:[0AAA],01
    79dd:343a  - ret
             P_CHECKOFF:
    79dd:343b  - mov       byte ptr ss:[0AAA],00
    79dd:3441  - ret
             P_CLC:
    79dd:3442  - mov       al,18
    79dd:3444    stosb
    79dd:3445  - ret
             P_CLD:
    79dd:3446  - mov       al,byte ptr [si]
    79dd:3448    xlat
    79dd:344a    or        al,al
    79dd:344c    js        3451
    79dd:344e    jmp       PM
    79dd:3451  - mov       al,D8
    79dd:3453    stosb
    79dd:3454  - ret
             P_CLI:
    79dd:3455  - mov       al,byte ptr [si]
    79dd:3457    xlat
    79dd:3459    or        al,al
    79dd:345b    js        3460
    79dd:345d    jmp       PM
    79dd:3460  - mov       al,58
    79dd:3462    stosb
    79dd:3463  - ret
             P_CLV:
    79dd:3464  - mov       al,byte ptr [si]
    79dd:3466    xlat
    79dd:3468    or        al,al
    79dd:346a    js        346F
    79dd:346c    jmp       PM
    79dd:346f  - mov       al,B8
    79dd:3471    stosb
    79dd:3472  - ret
             P_CMP:
    79dd:3473  - mov       al,byte ptr [0ABA]
    79dd:3477    test      al,01
    79dd:3479    je        3483
    79dd:347b    mov       ax,word ptr [13F0]
    79dd:347f    mov       word ptr [0AB2],ax
    79dd:3483  - call      GETEA
    79dd:3486    mov       al,byte ptr [si]
    79dd:3488    xlat
    79dd:348a    or        al,al
    79dd:348c    js        3491
    79dd:348e    jmp       E_EXTRACHARS
    79dd:3491    mov       ax,word ptr [bp+6EE5]
    79dd:3495    or        al,al
    79dd:3497    je        34A1
    79dd:3499    stosb
    79dd:349a    mov       al,ah
    79dd:349c    xor       ah,ah
    79dd:349e    add       di,ax
    79dd:34a0    ret
    79dd:34a1    push      dx
    79dd:34a2    mov       dx,7F7F
    79dd:34a5    call      ERROR_ROUT
    79dd:34a8    pop       dx
    79dd:34a9    ret
             P_COP:
    79dd:34aa  - mov       al,02
    79dd:34ac    stosb
    79dd:34ad  - ret
             P_CPX:
    79dd:34ae  - mov       al,byte ptr [0ABA]
    79dd:34b2    test      al,02
    79dd:34b4    je        34BE
    79dd:34b6    mov       ax,word ptr [13F0]
    79dd:34ba    mov       word ptr [0AB2],ax
    79dd:34be  - call      GETEA
    79dd:34c1    mov       al,byte ptr [si]
    79dd:34c3    xlat
    79dd:34c5    or        al,al
    79dd:34c7    js        34CC
    79dd:34c9    jmp       E_EXTRACHARS
    79dd:34cc    mov       ax,word ptr [bp+6F13]
    79dd:34d0    or        al,al
    79dd:34d2    je        34DC
    79dd:34d4    stosb
    79dd:34d5    mov       al,ah
    79dd:34d7    xor       ah,ah
    79dd:34d9    add       di,ax
    79dd:34db    ret
    79dd:34dc    push      dx
    79dd:34dd    mov       dx,7F7F
    79dd:34e0    call      ERROR_ROUT
    79dd:34e3    pop       dx
    79dd:34e4    ret
             P_CPY:
    79dd:34e5  - mov       al,byte ptr [0ABA]
    79dd:34e9    test      al,02
    79dd:34eb    je        34F5
    79dd:34ed    mov       ax,word ptr [13F0]
    79dd:34f1    mov       word ptr [0AB2],ax
    79dd:34f5  - call      GETEA
    79dd:34f8    mov       al,byte ptr [si]
    79dd:34fa    xlat
    79dd:34fc    or        al,al
    79dd:34fe    js        3503
    79dd:3500    jmp       E_EXTRACHARS
    79dd:3503    mov       ax,word ptr [bp+6F41]
    79dd:3507    or        al,al
    79dd:3509    je        3513
    79dd:350b    stosb
    79dd:350c    mov       al,ah
    79dd:350e    xor       ah,ah
    79dd:3510    add       di,ax
    79dd:3512    ret
    79dd:3513    push      dx
    79dd:3514    mov       dx,7F7F
    79dd:3517    call      ERROR_ROUT
    79dd:351a    pop       dx
    79dd:351b    ret
             P_DEC:
    79dd:351c  - call      GETEA
    79dd:351f    mov       al,byte ptr [si]
    79dd:3521    xlat
    79dd:3523    or        al,al
    79dd:3525    js        352A
    79dd:3527    jmp       E_EXTRACHARS
    79dd:352a    mov       ax,word ptr [bp+6F6F]
    79dd:352e    or        al,al
    79dd:3530    je        353A
    79dd:3532    stosb
    79dd:3533    mov       al,ah
    79dd:3535    xor       ah,ah
    79dd:3537    add       di,ax
    79dd:3539    ret
    79dd:353a    push      dx
    79dd:353b    mov       dx,7F7F
    79dd:353e    call      ERROR_ROUT
    79dd:3541    pop       dx
    79dd:3542    ret
             P_DEX:
    79dd:3543  - mov       al,CA
    79dd:3545    stosb
    79dd:3546  - ret
             P_DEY:
    79dd:3547  - mov       al,88
    79dd:3549    stosb
    79dd:354a  - ret
             P_DEFEND:
    79dd:354b  - push      es
    79dd:354c  - push      di
    79dd:354d  - mov       ax,ss
    79dd:354f  - mov       es,ax
    79dd:3551  - mov       di,261F
    79dd:3554  - call      COPYPF
    79dd:3557  - mov       ax,4509
    79dd:355a  - stosw
    79dd:355b  - mov       ax,444E
    79dd:355e  - stosw
    79dd:355f  - mov       al,0D
    79dd:3561  - stosb
    79dd:3562  - pop       di
    79dd:3563  - pop       es
    79dd:3564  - ret
             P_DEFERROR:
    79dd:3565  - push      es
    79dd:3566  - push      di
    79dd:3567  - mov       ax,ss
    79dd:3569  - mov       es,ax
    79dd:356b  - mov       di,2557
    79dd:356e  - call      COPYPF
    79dd:3571  - pop       di
    79dd:3572  - pop       es
    79dd:3573  - ret
             COPYPF:
    79dd:3574  - lodsb
    79dd:3575    xlat
    79dd:3577    or        al,al
    79dd:3579    js        COPYPF
    79dd:357b    dec       si
    79dd:357c  - lodsb
    79dd:357d  - cmp       al,22
    79dd:357f  - jne       MISSOPEN
    79dd:3581  - mov       al,22
             DELP:
    79dd:3583  - stosb
    79dd:3584  - lodsb
    79dd:3585  - cmp       al,0D
    79dd:3587  - jne       DELP
    79dd:3589  - stosb
    79dd:358a  - mov       al,0A
    79dd:358c  - stosb
    79dd:358d  - dec       si
    79dd:358e  - ret
             MISSOPEN:
    79dd:358f  - push      dx
    79dd:3590    mov       dx,829D
    79dd:3593    call      ERROR_ROUT
    79dd:3596    pop       dx
             P_DW:
    79dd:3597  - mov       al,byte ptr [si]
    79dd:3599    xlat
    79dd:359b    or        al,al
    79dd:359d    js        35A2
    79dd:359f    jmp       PM
    79dd:35a2  - lodsb
    79dd:35a3    xlat
    79dd:35a5    or        al,al
    79dd:35a7    js        35A2
    79dd:35a9    dec       si
             P_DW2:
    79dd:35aa    call      CONVEXPRESS
    79dd:35ad  - mov       ax,cx
    79dd:35af  - test      byte ptr ss:[0ACE],C0
    79dd:35b5    je        362D
    79dd:35b7    test      byte ptr ss:[0ACE],40
    79dd:35bd    jne       35EA
    79dd:35bf    push      es
    79dd:35c0    push      bp
    79dd:35c1    mov       es,word ptr ss:[0AC5]
    79dd:35c6    mov       bp,word ptr ss:[0AC9]
    79dd:35cb    mov       word ptr es:[bp+06],di
    79dd:35cf    mov       word ptr es:[bp+02],0010
    79dd:35d5    add       bp,15
    79dd:35d8    mov       word ptr ss:[0AC7],bp
    79dd:35dd    cmp       bp,7F00
    79dd:35e1    jb        35E6
    79dd:35e3    call      MOREFR
    79dd:35e6    pop       bp
    79dd:35e7    pop       es
    79dd:35e8    jmp       362D
    79dd:35ea    push      es
    79dd:35eb    push      bp
    79dd:35ec    push      cx
    79dd:35ed    push      ax
    79dd:35ee    mov       es,word ptr ss:[13A6]
    79dd:35f3    mov       bp,word ptr ss:[13A8]
    79dd:35f8    mov       ax,di
    79dd:35fa    sub       ax,word ptr ss:[13B4]
    79dd:35ff    xor       cx,cx
    79dd:3601    add       ax,word ptr ss:[13BE]
    79dd:3606    adc       cx,word ptr ss:[13BC]
    79dd:360b    mov       word ptr es:[bp+00],ax
    79dd:360f    mov       word ptr es:[bp+02],cx
    79dd:3613    mov       byte ptr es:[bp+04],10
    79dd:3618    add       bp,05
    79dd:361b    mov       word ptr ss:[13A8],bp
    79dd:3620    cmp       bp,3F00
    79dd:3624    jb        3629
    79dd:3626    call      MOREEXT
    79dd:3629    pop       ax
    79dd:362a    pop       cx
    79dd:362b    pop       bp
    79dd:362c    pop       es
    79dd:362d  - stosw
    79dd:362e  - add       word ptr ss:[0F94],02
    79dd:3634  - adc       word ptr ss:[0F92],00
    79dd:363a  - lodsb
    79dd:363b  - cmp       al,2C
    79dd:363d  - jne       3642
    79dd:363f    jmp       P_DW2
    79dd:3642  - xlat
    79dd:3644  - or        al,al
    79dd:3646  - js        364B
    79dd:3648    jmp       P_DBEERR
    79dd:364b  - dec       si
    79dd:364c  - mov       word ptr ss:[0F90],di
    79dd:3651  - ret
             P_DS:
    79dd:3652  - mov       al,byte ptr [si]
    79dd:3654    xlat
    79dd:3656    or        al,al
    79dd:3658    js        365D
    79dd:365a    jmp       PM
    79dd:365d  - lodsb
    79dd:365e    xlat
    79dd:3660    or        al,al
    79dd:3662    js        365D
    79dd:3664    dec       si
    79dd:3665  - call      CONVEXPRESS
    79dd:3668  - test      byte ptr ss:[0ACE],C0
    79dd:366e  - je        3673
    79dd:3670    jmp       P_EQUERR2
    79dd:3673  - mov       word ptr ss:[9A82],cx
    79dd:3678  - mov       word ptr ss:[9A80],dx
    79dd:367d  - call      SPLITOBJBUF
    79dd:3680  - call      CALCROMPOS
    79dd:3683  - mov       word ptr es:[di+0C],ax
    79dd:3687  - mov       word ptr es:[di+0E],cx
    79dd:368b  - mov       byte ptr es:[di+10],08
    79dd:3690  - mov       al,byte ptr [13BA]
    79dd:3694  - or        byte ptr es:[di+10],al
    79dd:3698  - mov       bx,word ptr ss:[9A80]
    79dd:369d  - mov       word ptr es:[di+04],bx
    79dd:36a1  - mov       ax,word ptr [9A82]
    79dd:36a5  - mov       word ptr es:[di+06],ax
    79dd:36a9  - add       word ptr ss:[0F94],ax
    79dd:36ae  - adc       word ptr ss:[0F92],bx
    79dd:36b3  - mov       bp,di
    79dd:36b5  - add       di,13
    79dd:36b8  - jmp       SPLITINC
             P_DB:
    79dd:36bb  - mov       al,byte ptr [si]
    79dd:36bd    xlat
    79dd:36bf    or        al,al
    79dd:36c1    js        36C6
    79dd:36c3    jmp       PM
    79dd:36c6  - lodsb
    79dd:36c7    xlat
    79dd:36c9    or        al,al
    79dd:36cb    js        36C6
    79dd:36cd    dec       si
             P_DBA:
    79dd:36ce    lodsb
    79dd:36cf  - cmp       al,27
    79dd:36d1  - jne       36D6
    79dd:36d3    jmp       P_DBSINGLE
    79dd:36d6  - cmp       al,22
    79dd:36d8  - jne       36DD
    79dd:36da    jmp       P_DBSINGLE
    79dd:36dd  - dec       si
    79dd:36de  - call      CONVEXPRESS
    79dd:36e1  - mov       al,cl
    79dd:36e3  - test      byte ptr ss:[0ACE],C0
    79dd:36e9    je        3761
    79dd:36eb    test      byte ptr ss:[0ACE],40
    79dd:36f1    jne       371E
    79dd:36f3    push      es
    79dd:36f4    push      bp
    79dd:36f5    mov       es,word ptr ss:[0AC5]
    79dd:36fa    mov       bp,word ptr ss:[0AC9]
    79dd:36ff    mov       word ptr es:[bp+06],di
    79dd:3703    mov       word ptr es:[bp+02],000E
    79dd:3709    add       bp,15
    79dd:370c    mov       word ptr ss:[0AC7],bp
    79dd:3711    cmp       bp,7F00
    79dd:3715    jb        371A
    79dd:3717    call      MOREFR
    79dd:371a    pop       bp
    79dd:371b    pop       es
    79dd:371c    jmp       3761
    79dd:371e    push      es
    79dd:371f    push      bp
    79dd:3720    push      cx
    79dd:3721    push      ax
    79dd:3722    mov       es,word ptr ss:[13A6]
    79dd:3727    mov       bp,word ptr ss:[13A8]
    79dd:372c    mov       ax,di
    79dd:372e    sub       ax,word ptr ss:[13B4]
    79dd:3733    xor       cx,cx
    79dd:3735    add       ax,word ptr ss:[13BE]
    79dd:373a    adc       cx,word ptr ss:[13BC]
    79dd:373f    mov       word ptr es:[bp+00],ax
    79dd:3743    mov       word ptr es:[bp+02],cx
    79dd:3747    mov       byte ptr es:[bp+04],0E
    79dd:374c    add       bp,05
    79dd:374f    mov       word ptr ss:[13A8],bp
    79dd:3754    cmp       bp,3F00
    79dd:3758    jb        375D
    79dd:375a    call      MOREEXT
    79dd:375d    pop       ax
    79dd:375e    pop       cx
    79dd:375f    pop       bp
    79dd:3760    pop       es
    79dd:3761  - stosb
    79dd:3762  - add       word ptr ss:[0F94],01
    79dd:3768  - adc       word ptr ss:[0F92],00
             P_DBS:
    79dd:376e  - lodsb
    79dd:376f  - cmp       al,2C
    79dd:3771  - jne       3776
    79dd:3773    jmp       P_DBA
    79dd:3776  - xlat
    79dd:3778  - or        al,al
    79dd:377a  - jns       P_DBEERR
    79dd:377c  - dec       si
    79dd:377d  - mov       word ptr ss:[0F90],di
    79dd:3782  - ret
             P_DBEERR:
    79dd:3783  - push      dx
    79dd:3784    mov       dx,8078
    79dd:3787    call      ERROR_ROUT
    79dd:378a    pop       dx
             P_DBSINGLE:
    79dd:378b    mov       ah,al
    79dd:378d  - mov       cl,0D
             P_DBSING:
    79dd:378f  - lodsb
    79dd:3790  - cmp       al,ah
    79dd:3792  - je        P_DBS
    79dd:3794  - stosb
    79dd:3795  - add       word ptr ss:[0F94],01
    79dd:379b  - adc       word ptr ss:[0F92],00
    79dd:37a1  - cmp       al,cl
    79dd:37a3  - jne       P_DBSING
    79dd:37a5  - push      dx
    79dd:37a6    mov       dx,8136
    79dd:37a9    call      ERROR_ROUT
    79dd:37ac    pop       dx
             P_ELSEIF:
    79dd:37ad    test      byte ptr ss:[0F8B],06
    79dd:37b3  - je        PELSENOL
    79dd:37b5  - call      LISTLINE
             PELSENOL:
    79dd:37b8  - jmp       FINDENDC
             P_EQU:
    79dd:37bb  - lodsb
    79dd:37bc    xlat
    79dd:37be    or        al,al
    79dd:37c0    js        P_EQU
    79dd:37c2    dec       si
    79dd:37c3  - test      byte ptr ss:[0F8B],01
    79dd:37c9    jne       P_EQUSKIP
    79dd:37cb  - mov       bp,word ptr ss:[13F0]
    79dd:37d0    cmp       word ptr ss:[0F7A],bp
    79dd:37d5    jne       P_EQUERR
    79dd:37d7  - mov       ax,word ptr [0F84]
    79dd:37db    mov       word ptr [0F80],ax
    79dd:37df    mov       ax,word ptr [0F86]
    79dd:37e3    mov       word ptr [0F82],ax
    79dd:37e7    mov       ax,word ptr [0F70]
    79dd:37eb    mov       word ptr [0F6E],ax
    79dd:37ef  - call      CONVEXPRESS
    79dd:37f2  - test      byte ptr ss:[0ACE],C0
    79dd:37f8  - jne       P_EQUERR2
    79dd:37fa  - push      es
    79dd:37fb  - mov       es,word ptr ss:[0F7C]
    79dd:3800  - mov       bp,word ptr ss:[0F7E]
    79dd:3805  - mov       word ptr es:[bp+0A],dx
    79dd:3809  - mov       word ptr es:[bp+0C],cx
    79dd:380d  - pop       es
             P_EQUSKIP:
    79dd:380e  - ret
             P_EQUERR:
    79dd:380f  - push      dx
    79dd:3810    mov       dx,81FA
    79dd:3813    call      ERROR_ROUT
    79dd:3816    pop       dx
             P_EQUERR2:
    79dd:3817  - push      dx
    79dd:3818    mov       dx,80D7
    79dd:381b    call      ERROR_ROUT
    79dd:381e    pop       dx
             P_EQUR:
    79dd:381f  - lodsb
    79dd:3820    xlat
    79dd:3822    or        al,al
    79dd:3824    js        P_EQUR
    79dd:3826    dec       si
    79dd:3827  - test      byte ptr ss:[0F8B],01
    79dd:382d    jne       EQURSKIP
    79dd:382f  - mov       bp,word ptr ss:[13F0]
    79dd:3834    cmp       word ptr ss:[0F7A],bp
    79dd:3839    jne       P_EQUERR
    79dd:383b  - call      CONVEXPRESS
    79dd:383e  - test      byte ptr ss:[0ACE],C0
    79dd:3844  - jne       P_EQUERR2
    79dd:3846  - push      es
    79dd:3847  - mov       es,word ptr ss:[0F7C]
    79dd:384c  - mov       bp,word ptr ss:[0F7E]
    79dd:3851  - mov       word ptr es:[bp+0A],dx
    79dd:3855  - mov       word ptr es:[bp+0C],cx
    79dd:3859  - mov       byte ptr es:[bp+04],05
    79dd:385e  - pop       es
    79dd:385f  - mov       ax,word ptr [0F84]
    79dd:3863    mov       word ptr [0F80],ax
    79dd:3867    mov       ax,word ptr [0F86]
    79dd:386b    mov       word ptr [0F82],ax
    79dd:386f    mov       ax,word ptr [0F70]
    79dd:3873    mov       word ptr [0F6E],ax
             EQURSKIP:
    79dd:3877    ret
             P_DEFS:
    79dd:3878  - dec       si
    79dd:3879  - mov       al,byte ptr [si]
    79dd:387b    xlat
    79dd:387d    or        al,al
    79dd:387f    js        M_DEFS
    79dd:3881    jmp       PM
             M_DEFS:
    79dd:3884  - lodsb
    79dd:3885    xlat
    79dd:3887    or        al,al
    79dd:3889    js        M_DEFS
    79dd:388b    dec       si
    79dd:388c  - cmp       byte ptr [si],24
    79dd:388f  - jne       DSND
    79dd:3891  - inc       si
             DSND:
    79dd:3892  - push      si
    79dd:3893  - call      GETSTRINGADDR
    79dd:3896  - pop       ax
    79dd:3897  - cmp       cx,A46D
    79dd:389b  - jne       DSREDEFSTRING
    79dd:389d  - cmp       dx,8AC9
    79dd:38a1  - je        P_BADSTRVAL
             DSREDEFSTRING:
    79dd:38a3  - push      es
    79dd:38a4  - push      di
    79dd:38a5  - mov       di,cx
    79dd:38a7  - mov       es,dx
    79dd:38a9  - xor       ch,ch
    79dd:38ab  - mov       cl,byte ptr es:[di+FF]
    79dd:38af  - push      cx
    79dd:38b0  - lodsb
    79dd:38b1  - cmp       al,2C
    79dd:38b3  - je        38B8
    79dd:38b5    jmp       EAERR
    79dd:38b8  - mov       byte ptr ss:[247D],01
    79dd:38be  - call      P_PRINTF2
    79dd:38c1  - mov       byte ptr ss:[247D],00
    79dd:38c7  - pop       cx
    79dd:38c8  - cmp       cx,word ptr ss:[2486]
    79dd:38cd  - ja        38D2
    79dd:38cf    jmp       E_STR2LONG
    79dd:38d2  - push      ds
    79dd:38d3  - push      si
    79dd:38d4  - mov       ax,ss
    79dd:38d6  - mov       ds,ax
    79dd:38d8  - mov       si,8A6E
    79dd:38db  - mov       cx,word ptr ss:[2486]
             DSCOPYPFLP2:
    79dd:38e0  - lodsb
    79dd:38e1  - stosb
    79dd:38e2  - dec       cx
    79dd:38e3  - jns       DSCOPYPFLP2
    79dd:38e5  - mov       byte ptr es:[di+FF],00
    79dd:38ea  - pop       si
    79dd:38eb  - pop       ds
    79dd:38ec  - pop       di
    79dd:38ed  - pop       es
    79dd:38ee  - ret
             P_BADSTRVAL:
    79dd:38ef  - push      dx
    79dd:38f0    mov       dx,87D2
    79dd:38f3    call      ERROR_ROUT
    79dd:38f6    pop       dx
             P_EOR:
    79dd:38f7  - mov       al,byte ptr [0ABA]
    79dd:38fb    test      al,01
    79dd:38fd    je        3907
    79dd:38ff    mov       ax,word ptr [13F0]
    79dd:3903    mov       word ptr [0AB2],ax
    79dd:3907  - call      GETEA
    79dd:390a    mov       al,byte ptr [si]
    79dd:390c    xlat
    79dd:390e    or        al,al
    79dd:3910    js        3915
    79dd:3912    jmp       E_EXTRACHARS
    79dd:3915    mov       ax,word ptr [bp+6F9D]
    79dd:3919    or        al,al
    79dd:391b    je        3925
    79dd:391d    stosb
    79dd:391e    mov       al,ah
    79dd:3920    xor       ah,ah
    79dd:3922    add       di,ax
    79dd:3924    ret
    79dd:3925    push      dx
    79dd:3926    mov       dx,7F7F
    79dd:3929    call      ERROR_ROUT
    79dd:392c    pop       dx
    79dd:392d    ret
             P_END:
    79dd:392e  - mov       al,byte ptr [si]
    79dd:3930    xlat
    79dd:3932    or        al,al
    79dd:3934    js        3939
    79dd:3936    jmp       PM
    79dd:3939  - mov       bp,word ptr ss:[0F9C]
    79dd:393e  - mov       byte ptr [bp+14],01
    79dd:3942  - mov       ax,ss
    79dd:3944  - mov       ds,ax
    79dd:3946  - mov       si,254F
    79dd:3949  - ret
             P_ENDC:
    79dd:394a  - inc       si
    79dd:394b  - mov       al,byte ptr [si]
    79dd:394d    xlat
    79dd:394f    or        al,al
    79dd:3951    js        3956
    79dd:3953    jmp       PM
    79dd:3956  - dec       word ptr ss:[0F96]
    79dd:395b  - js        P_ENDCERR
    79dd:395d  - ret
             P_ENDCERR:
    79dd:395e  - push      dx
    79dd:395f    mov       dx,8179
    79dd:3962    call      ERROR_ROUT
    79dd:3965    pop       dx
             P_FAIL:
    79dd:3966    call      LISTLINE
    79dd:3969  - mov       dx,7D9C
    79dd:396c    call      FATALERR_ROUT
    79dd:396f  - jmp       STOPASSEM
             ADDFLIST:
    79dd:3972    push      ax
    79dd:3973  - mov       al,byte ptr [13F5]
    79dd:3977  - or        al,al
    79dd:3979  - je        NO
    79dd:397b  - push      bp
    79dd:397c  - push      ds
    79dd:397d  - push      dx
    79dd:397e  - push      si
    79dd:397f  - push      cx
    79dd:3980  - mov       si,dx
    79dd:3982  - xor       cx,cx
             LP:
    79dd:3984  - inc       cx
    79dd:3985  - lodsb
    79dd:3986  - or        al,al
    79dd:3988  - jne       LP
    79dd:398a  - dec       cx
    79dd:398b  - mov       bx,word ptr ss:[13F6]
    79dd:3990  - call      far ptr _OS2WRITEBYTES
    79dd:3995  - mov       ax,ss
    79dd:3997  - mov       ds,ax
    79dd:3999  - mov       dx,2552
    79dd:399c  - mov       cx,0002
    79dd:399f  - mov       bx,word ptr ss:[13F6]
    79dd:39a4  - call      far ptr _OS2WRITEBYTES
    79dd:39a9  - pop       cx
    79dd:39aa  - pop       si
    79dd:39ab  - pop       dx
    79dd:39ac  - pop       ds
    79dd:39ad  - pop       bp
             NO:
    79dd:39ae  - pop       ax
    79dd:39af  - ret
             P_FOPEN:
    79dd:39b0  - mov       al,byte ptr [si]
    79dd:39b2    xlat
    79dd:39b4    or        al,al
    79dd:39b6    js        39BB
    79dd:39b8    jmp       PM
    79dd:39bb  - lodsb
    79dd:39bc    xlat
    79dd:39be    or        al,al
    79dd:39c0    js        39BB
    79dd:39c2    dec       si
    79dd:39c3  - cmp       byte ptr [si],2B
    79dd:39c6  - je        39CB
    79dd:39c8    jmp       F_OPENNEW
    79dd:39cb  - inc       si
    79dd:39cc  - push      ds
    79dd:39cd  - push      si
    79dd:39ce  - push      es
    79dd:39cf  - push      di
    79dd:39d0  - mov       ax,word ptr [2478]
    79dd:39d4  - or        ax,ax
    79dd:39d6  - je        F_APPENDIT
    79dd:39d8  - mov       es,ax
    79dd:39da  - mov       di,word ptr ss:[247A]
    79dd:39df  - xor       al,al
             PFENDLP:
    79dd:39e1  - cmp       al,byte ptr es:[di]
    79dd:39e4  - je        PFENDEND
    79dd:39e6  - inc       di
    79dd:39e7  - jmp       PFENDLP
             PFENDEND:
    79dd:39e9  - dec       di
    79dd:39ea  - mov       al,byte ptr es:[di]
    79dd:39ed  - cmp       al,5C
    79dd:39ef  - je        PFENDEND2
    79dd:39f1  - or        al,al
    79dd:39f3  - jne       PFENDEND
             PFENDEND2:
    79dd:39f5  - inc       di
    79dd:39f6  - mov       bx,76A7
             PFCMPLP:
    79dd:39f9  - lodsb
    79dd:39fa  - and       al,DF
    79dd:39fc  - mov       cl,byte ptr es:[di]
    79dd:39ff  - inc       di
    79dd:3a00  - and       cl,DF
    79dd:3a03  - cmp       al,cl
    79dd:3a05  - je        PFCMPLP
    79dd:3a07  - mov       al,byte ptr [si+FF]
    79dd:3a0a  - xlat
    79dd:3a0c  - or        al,al
    79dd:3a0e  - jns       F_APPENDIT
    79dd:3a10  - mov       al,byte ptr es:[di+FF]
    79dd:3a14  - or        al,al
    79dd:3a16  - jne       F_APPENDIT
    79dd:3a18  - pop       di
    79dd:3a19  - pop       es
    79dd:3a1a  - pop       si
    79dd:3a1b  - pop       ds
    79dd:3a1c  - mov       word ptr ss:[2474],0001
    79dd:3a23  - ret
             F_APPENDIT:
    79dd:3a24  - pop       di
    79dd:3a25  - pop       es
    79dd:3a26  - pop       si
    79dd:3a27  - pop       ds
    79dd:3a28  - push      ds
    79dd:3a29  - push      si
    79dd:3a2a  - call      COPYFNAME
    79dd:3a2d  - mov       ds,word ptr ss:[9A7C]
    79dd:3a32  - mov       dx,word ptr ss:[9A7E]
    79dd:3a37  - mov       word ptr ss:[2478],ds
    79dd:3a3c  - mov       word ptr ss:[247A],dx
    79dd:3a41  - call      ADDFLIST
    79dd:3a44  - mov       bx,word ptr ss:[2476]
    79dd:3a49  - call      far ptr _OS2CLOSEFILE
    79dd:3a4e  - mov       ds,word ptr ss:[2478]
    79dd:3a53  - mov       dx,word ptr ss:[247A]
    79dd:3a58  - xor       bx,bx
    79dd:3a5a  - call      far ptr _OS2OPENAPPENDFILE
    79dd:3a5f  - jae       OK
    79dd:3a61  - pop       si
    79dd:3a62  - pop       ds
    79dd:3a63  - mov       bx,76A7
    79dd:3a66  - mov       word ptr ss:[2474],0000
    79dd:3a6d  - push      dx
    79dd:3a6e    mov       dx,80FF
    79dd:3a71    call      ERROR_ROUT
    79dd:3a74    pop       dx
             OK:
    79dd:3a75  - mov       word ptr ss:[2474],0001
    79dd:3a7c  - mov       word ptr [2476],ax
    79dd:3a80  - xor       cx,cx
    79dd:3a82  - mov       dx,cx
    79dd:3a84  - mov       bx,word ptr ss:[2476]
    79dd:3a89  - call      far ptr _OS2SEEKEND
    79dd:3a8e  - pop       si
    79dd:3a8f  - pop       ds
    79dd:3a90  - mov       bx,76A7
    79dd:3a93  - ret
             F_OPENNEW:
    79dd:3a94  - mov       bx,word ptr ss:[2476]
    79dd:3a99  - call      far ptr _OS2CLOSEFILE
    79dd:3a9e  - push      ds
    79dd:3a9f  - push      si
    79dd:3aa0  - push      ax
    79dd:3aa1  - push      cx
    79dd:3aa2  - call      COPYFNAME
    79dd:3aa5  - mov       ds,word ptr ss:[9A7C]
    79dd:3aaa  - mov       dx,word ptr ss:[9A7E]
    79dd:3aaf  - mov       word ptr ss:[2478],ds
    79dd:3ab4  - mov       word ptr ss:[247A],dx
    79dd:3ab9  - call      ADDFLIST
    79dd:3abc  - pop       cx
    79dd:3abd  - pop       ax
    79dd:3abe  - xor       bx,bx
    79dd:3ac0  - call      far ptr _OS2OPENNEWFILE
    79dd:3ac5  - mov       word ptr ss:[2474],0001
    79dd:3acc  - mov       word ptr [2476],ax
    79dd:3ad0  - pop       si
    79dd:3ad1  - pop       ds
    79dd:3ad2  - jb        PFOPENF
    79dd:3ad4  - mov       bx,76A7
    79dd:3ad7  - ret
             PFOPENF:
    79dd:3ad8  - push      dx
    79dd:3ad9    mov       dx,80FF
    79dd:3adc    call      ERROR_ROUT
    79dd:3adf    pop       dx
             P_FCLOSE:
    79dd:3ae0  - mov       al,byte ptr [si]
    79dd:3ae2    xlat
    79dd:3ae4    or        al,al
    79dd:3ae6    js        FCLOSELP
    79dd:3ae8    jmp       PM
             FCLOSELP:
             M_FCLOSE:
    79dd:3aeb    lodsb
    79dd:3aec  - cmp       al,09
    79dd:3aee  - je        FCLOSELP
    79dd:3af0  - cmp       al,20
    79dd:3af2  - je        FCLOSELP
    79dd:3af4  - cmp       al,3B
    79dd:3af6  - je        FCLOSEEND
    79dd:3af8  - cmp       al,2A
    79dd:3afa  - je        FCLOSEEND
    79dd:3afc  - cmp       al,0D
    79dd:3afe  - je        FCLOSEEND
    79dd:3b00  - cmp       al,21
    79dd:3b02  - jne       FCLOSEEND
    79dd:3b04  - mov       bx,word ptr ss:[2476]
    79dd:3b09  - call      far ptr _OS2CLOSEFILE
    79dd:3b0e  - mov       word ptr ss:[2478],0000
             FCLOSEEND:
    79dd:3b15  - mov       word ptr ss:[2474],0000
    79dd:3b1c  - dec       si
    79dd:3b1d  - ret
             P_IF:
    79dd:3b1e  - mov       al,byte ptr [si]
    79dd:3b20  - xlat
    79dd:3b22  - or        al,al
    79dd:3b24  - jns       3B29
    79dd:3b26    jmp       P_NEWIF
    79dd:3b29  - lodsw
    79dd:3b2a  - and       ah,DF
    79dd:3b2d  - mov       bp,ax
    79dd:3b2f  - and       bp,00FF
    79dd:3b33  - add       bp,bp
    79dd:3b35  - jmp       word ptr [bp+6925]
             P_IFV:
    79dd:3b39  - dec       si
    79dd:3b3a  - mov       al,byte ptr [si]
    79dd:3b3c    xlat
    79dd:3b3e    or        al,al
    79dd:3b40    js        3B45
    79dd:3b42    jmp       PM
    79dd:3b45  - mov       al,00
    79dd:3b47  - jmp       IV0
             P_IFNV:
    79dd:3b49  - mov       al,byte ptr [si]
    79dd:3b4b    xlat
    79dd:3b4d    or        al,al
    79dd:3b4f    js        3B54
    79dd:3b51    jmp       PM
    79dd:3b54  - mov       al,01
             IV0:
    79dd:3b56  - inc       word ptr ss:[0F96]
    79dd:3b5b  - mov       byte ptr [A4A1],al
    79dd:3b5f  - call      GETENVNAME
    79dd:3b62  - call      FINDENVVAR
    79dd:3b65  - mov       al,byte ptr [A4A2]
    79dd:3b69  - xor       al,byte ptr ss:[A4A1]
    79dd:3b6e  - jne       3B73
    79dd:3b70    jmp       FINDENDC
    79dd:3b73  - ret
             GETENVNAME:
    79dd:3b74  - lodsb
    79dd:3b75    xlat
    79dd:3b77    or        al,al
    79dd:3b79    js        GETENVNAME
    79dd:3b7b    dec       si
    79dd:3b7c  - lodsb
    79dd:3b7d  - cmp       al,22
    79dd:3b7f  - jne       GEN_ERR1
    79dd:3b81  - push      di
    79dd:3b82  - push      si
    79dd:3b83  - push      bx
    79dd:3b84  - mov       bx,7727
    79dd:3b87  - mov       di,A4A3
    79dd:3b8a  - xor       cx,cx
             GEN0:
    79dd:3b8c  - lodsb
    79dd:3b8d  - xlat
    79dd:3b8f  - or        al,al
    79dd:3b91  - js        GEN1
    79dd:3b93  - mov       byte ptr ss:[di],al
    79dd:3b96  - inc       di
    79dd:3b97  - inc       cx
    79dd:3b98  - jmp       GEN0
             GEN1:
    79dd:3b9a  - or        cx,cx
    79dd:3b9c  - je        GEN_ERR3
    79dd:3b9e  - cmp       byte ptr [si+FF],22
    79dd:3ba2  - jne       GEN_ERR2
    79dd:3ba4  - inc       cx
    79dd:3ba5  - mov       byte ptr ss:[di],3D
    79dd:3ba9  - mov       word ptr ss:[A5A3],cx
    79dd:3bae  - pop       bx
    79dd:3baf  - pop       ax
    79dd:3bb0  - pop       di
    79dd:3bb1  - ret
             GEN_ERR1:
    79dd:3bb2  - push      dx
    79dd:3bb3    mov       dx,814C
    79dd:3bb6    call      ERROR_ROUT
    79dd:3bb9    pop       dx
             GEN_ERR2:
    79dd:3bba  - pop       bx
    79dd:3bbb  - pop       si
    79dd:3bbc  - pop       di
    79dd:3bbd  - push      dx
    79dd:3bbe    mov       dx,8162
    79dd:3bc1    call      ERROR_ROUT
    79dd:3bc4    pop       dx
             GEN_ERR3:
    79dd:3bc5  - pop       bx
    79dd:3bc6  - pop       si
    79dd:3bc7  - pop       di
    79dd:3bc8  - push      dx
    79dd:3bc9    mov       dx,849F
    79dd:3bcc    call      ERROR_ROUT
    79dd:3bcf    pop       dx
             FINDENVVAR:
    79dd:3bd0  - push      ds
    79dd:3bd1  - push      es
    79dd:3bd2  - push      di
    79dd:3bd3  - push      si
    79dd:3bd4  - push      bp
    79dd:3bd5  - push      dx
    79dd:3bd6  - push      cx
    79dd:3bd7  - push      bx
    79dd:3bd8  - mov       ah,62
    79dd:3bda  - int       21
    79dd:3bdc  - mov       ds,bx
    79dd:3bde  - mov       ax,word ptr [002C]
    79dd:3be1  - mov       ds,ax
    79dd:3be3  - xor       si,si
             FEV0:
    79dd:3be5  - push      si
    79dd:3be6  - cld
    79dd:3be7  - mov       di,A4A3
    79dd:3bea  - mov       ax,8AC9
    79dd:3bed  - mov       es,ax
    79dd:3bef  - mov       cx,word ptr ss:[A5A3]
    79dd:3bf4  - rep
    79dd:3bf5    cmpsb
    79dd:3bf6  - jne       FEV1
    79dd:3bf8  - or        cx,cx
    79dd:3bfa  - jne       FEV1
    79dd:3bfc  - mov       word ptr ss:[A5A5],si
    79dd:3c01  - mov       word ptr ss:[A5A7],ds
    79dd:3c06  - mov       byte ptr ss:[A4A2],01
    79dd:3c0c  - pop       si
    79dd:3c0d  - pop       bx
    79dd:3c0e  - pop       cx
    79dd:3c0f  - pop       dx
    79dd:3c10  - pop       bp
    79dd:3c11  - pop       si
    79dd:3c12  - pop       di
    79dd:3c13  - pop       es
    79dd:3c14  - pop       ds
    79dd:3c15  - ret
             FEV1:
    79dd:3c16  - pop       si
    79dd:3c17  - push      ds
    79dd:3c18  - pop       es
    79dd:3c19  - mov       di,si
    79dd:3c1b  - xor       al,al
    79dd:3c1d  - mov       cx,FFFF
    79dd:3c20  - repne
    79dd:3c21    scasb
    79dd:3c22  - mov       si,di
    79dd:3c24  - cmp       byte ptr [si],00
    79dd:3c27  - jne       FEV0
    79dd:3c29  - mov       byte ptr ss:[A4A2],00
    79dd:3c2f  - pop       bx
    79dd:3c30  - pop       cx
    79dd:3c31  - pop       dx
    79dd:3c32  - pop       bp
    79dd:3c33  - pop       si
    79dd:3c34  - pop       di
    79dd:3c35  - pop       es
    79dd:3c36  - pop       ds
    79dd:3c37  - ret
             P_GETENV:
    79dd:3c38  - lodsb
    79dd:3c39    xlat
    79dd:3c3b    or        al,al
    79dd:3c3d    js        P_GETENV
    79dd:3c3f    dec       si
    79dd:3c40  - push      si
    79dd:3c41  - call      GETSTRINGADDR
    79dd:3c44  - pop       ax
    79dd:3c45  - cmp       cx,A46D
    79dd:3c49  - jne       GE0
    79dd:3c4b  - cmp       dx,8AC9
    79dd:3c4f  - je        GE_ERR1
             GE0:
    79dd:3c51  - lodsb
    79dd:3c52  - cmp       al,3D
    79dd:3c54  - je        3C59
    79dd:3c56    jmp       EAERR
    79dd:3c59  - push      es
    79dd:3c5a  - push      di
    79dd:3c5b  - mov       di,cx
    79dd:3c5d  - mov       es,dx
    79dd:3c5f  - call      GETENVNAME
    79dd:3c62  - call      FINDENVVAR
    79dd:3c65  - cmp       byte ptr ss:[A4A2],01
    79dd:3c6b  - jne       GE_ERR2
    79dd:3c6d  - push      ds
    79dd:3c6e  - push      si
    79dd:3c6f  - lds       si,far ptr ss:[A5A5]
    79dd:3c74  - mov       cl,byte ptr es:[di+FF]
    79dd:3c78  - sub       cl,02
             GE1:
    79dd:3c7b  - lodsb
    79dd:3c7c  - stosb
    79dd:3c7d  - dec       cl
    79dd:3c7f  - je        GE_ERR3
    79dd:3c81  - or        al,al
    79dd:3c83  - jne       GE1
    79dd:3c85  - pop       si
    79dd:3c86  - pop       ds
    79dd:3c87  - pop       di
    79dd:3c88  - pop       es
    79dd:3c89  - ret
             GE_ERR1:
    79dd:3c8a  - push      dx
    79dd:3c8b    mov       dx,8702
    79dd:3c8e    call      ERROR_ROUT
    79dd:3c91    pop       dx
             GE_ERR2:
    79dd:3c92  - pop       di
    79dd:3c93  - pop       es
    79dd:3c94  - push      dx
    79dd:3c95    mov       dx,871E
    79dd:3c98    call      ERROR_ROUT
    79dd:3c9b    pop       dx
             GE_ERR3:
    79dd:3c9c  - mov       byte ptr es:[di+FF],00
    79dd:3ca1  - pop       si
    79dd:3ca2  - pop       ds
    79dd:3ca3  - pop       di
    79dd:3ca4  - pop       es
    79dd:3ca5  - push      dx
    79dd:3ca6    mov       dx,86E7
    79dd:3ca9    call      ERROR_ROUT
    79dd:3cac    pop       dx
             P_IFF:
    79dd:3cad    cmp       ah,45
    79dd:3cb0  - je        P_IFFE
    79dd:3cb2  - cmp       ah,4E
    79dd:3cb5  - je        P_IFFN
    79dd:3cb7  - jmp       PM
             P_IFFE:
    79dd:3cba  - mov       al,byte ptr [si]
    79dd:3cbc    xlat
    79dd:3cbe    or        al,al
    79dd:3cc0    js        3CC5
    79dd:3cc2    jmp       PM
    79dd:3cc5  - mov       al,00
    79dd:3cc7  - jmp       IFE0
             P_IFFN:
    79dd:3cc9  - lodsb
    79dd:3cca  - and       al,DF
    79dd:3ccc  - cmp       al,45
    79dd:3cce  - je        P_IFFNE
    79dd:3cd0  - jmp       PM
             P_IFFNE:
    79dd:3cd3  - mov       al,byte ptr [si]
    79dd:3cd5    xlat
    79dd:3cd7    or        al,al
    79dd:3cd9    js        3CDE
    79dd:3cdb    jmp       PM
    79dd:3cde  - mov       al,01
             IFE0:
    79dd:3ce0  - inc       word ptr ss:[0F96]
    79dd:3ce5  - mov       byte ptr [A5A9],al
    79dd:3ce9  - call      GETFILENAME
    79dd:3cec  - call      CHECKFILEEXISTS
    79dd:3cef  - mov       al,byte ptr [A5AA]
    79dd:3cf3  - xor       al,byte ptr ss:[A5A9]
    79dd:3cf8  - jne       3CFD
    79dd:3cfa    jmp       FINDENDC
    79dd:3cfd  - ret
             GETFILENAME:
    79dd:3cfe  - lodsb
    79dd:3cff    xlat
    79dd:3d01    or        al,al
    79dd:3d03    js        GETFILENAME
    79dd:3d05    dec       si
    79dd:3d06  - lodsb
    79dd:3d07  - cmp       al,22
    79dd:3d09  - jne       GFN_ERR1
    79dd:3d0b  - push      di
    79dd:3d0c  - push      si
    79dd:3d0d  - push      bx
    79dd:3d0e  - mov       di,A5AB
    79dd:3d11  - xor       cx,cx
             GFN0:
    79dd:3d13  - lodsb
    79dd:3d14  - cmp       al,22
    79dd:3d16  - je        GFN1
    79dd:3d18  - cmp       al,2A
    79dd:3d1a  - je        GFN_ERR4
    79dd:3d1c  - cmp       al,3F
    79dd:3d1e  - je        GFN_ERR4
    79dd:3d20  - cmp       al,00
    79dd:3d22  - je        GFN_ERR2
    79dd:3d24  - cmp       al,1A
    79dd:3d26  - je        GFN_ERR2
    79dd:3d28  - cmp       al,0A
    79dd:3d2a  - je        GFN_ERR2
    79dd:3d2c  - cmp       al,0D
    79dd:3d2e  - je        GFN_ERR2
    79dd:3d30  - mov       byte ptr ss:[di],al
    79dd:3d33  - inc       di
    79dd:3d34  - inc       cx
    79dd:3d35  - jmp       GFN0
             GFN1:
    79dd:3d37  - or        cx,cx
    79dd:3d39  - je        GFN_ERR3
    79dd:3d3b  - mov       byte ptr ss:[di],00
    79dd:3d3f  - mov       word ptr ss:[A5A3],cx
    79dd:3d44  - pop       bx
    79dd:3d45  - pop       ax
    79dd:3d46  - pop       di
    79dd:3d47  - ret
             GFN_ERR1:
    79dd:3d48  - push      dx
    79dd:3d49    mov       dx,814C
    79dd:3d4c    call      ERROR_ROUT
    79dd:3d4f    pop       dx
             GFN_ERR2:
    79dd:3d50  - pop       bx
    79dd:3d51  - pop       si
    79dd:3d52  - pop       di
    79dd:3d53  - push      dx
    79dd:3d54    mov       dx,8162
    79dd:3d57    call      ERROR_ROUT
    79dd:3d5a    pop       dx
             GFN_ERR3:
    79dd:3d5b  - pop       bx
    79dd:3d5c  - pop       si
    79dd:3d5d  - pop       di
    79dd:3d5e  - push      dx
    79dd:3d5f    mov       dx,849F
    79dd:3d62    call      ERROR_ROUT
    79dd:3d65    pop       dx
             GFN_ERR4:
    79dd:3d66  - pop       bx
    79dd:3d67  - pop       si
    79dd:3d68  - pop       di
    79dd:3d69  - push      dx
    79dd:3d6a    mov       dx,873E
    79dd:3d6d    call      ERROR_ROUT
    79dd:3d70    pop       dx
             CHECKFILEEXISTS:
    79dd:3d71  - push      ax
    79dd:3d72  - push      bx
    79dd:3d73  - push      dx
    79dd:3d74  - push      ds
    79dd:3d75  - mov       dx,A5AB
    79dd:3d78  - push      ss
    79dd:3d79  - pop       ds
    79dd:3d7a  - mov       ax,3D00
    79dd:3d7d  - int       21
    79dd:3d7f  - jb        CFE0
    79dd:3d81  - mov       bx,ax
    79dd:3d83  - mov       ah,3E
    79dd:3d85  - int       21
    79dd:3d87  - mov       byte ptr ss:[A5AA],01
    79dd:3d8d  - pop       ds
    79dd:3d8e  - pop       dx
    79dd:3d8f  - pop       bx
    79dd:3d90  - pop       ax
    79dd:3d91  - ret
             CFE0:
    79dd:3d92  - mov       byte ptr ss:[A5AA],00
    79dd:3d98  - pop       ds
    79dd:3d99  - pop       dx
    79dd:3d9a  - pop       bx
    79dd:3d9b  - pop       ax
    79dd:3d9c  - ret
             P_IFE:
    79dd:3d9d  - cmp       ah,51
    79dd:3da0  - jne       3DA5
    79dd:3da2    jmp       P_IFEQ
    79dd:3da5  - jmp       PM
             P_IFN:
    79dd:3da8  - cmp       ah,45
    79dd:3dab  - jne       3DB0
    79dd:3dad    jmp       P_IFNE
    79dd:3db0  - cmp       ah,43
    79dd:3db3  - jne       3DB8
    79dd:3db5    jmp       P_IFNC
    79dd:3db8  - cmp       ah,44
    79dd:3dbb  - jne       3DC0
    79dd:3dbd    jmp       P_IFND
    79dd:3dc0  - cmp       ah,53
    79dd:3dc3  - je        P_IFNS
    79dd:3dc5  - cmp       ah,56
    79dd:3dc8  - jne       3DCD
    79dd:3dca    jmp       P_IFNV
    79dd:3dcd  - jmp       PM
             P_IFG:
    79dd:3dd0  - cmp       ah,54
    79dd:3dd3  - jne       3DD8
    79dd:3dd5    jmp       P_IFGT
    79dd:3dd8  - cmp       ah,45
    79dd:3ddb  - jne       3DE0
    79dd:3ddd    jmp       P_IFGE
    79dd:3de0  - jmp       PM
             P_IFL:
    79dd:3de3  - cmp       ah,45
    79dd:3de6  - jne       3DEB
    79dd:3de8    jmp       P_IFLE
    79dd:3deb  - cmp       ah,54
    79dd:3dee  - jne       P_IFDT
    79dd:3df0    jmp       P_IFLT
             P_IFDT:
    79dd:3df3  - mov       al,byte ptr [si+FF]
    79dd:3df6  - xlat
    79dd:3df8  - or        al,al
    79dd:3dfa  - jns       3DFF
    79dd:3dfc    jmp       P_IFD
    79dd:3dff  - jmp       PM
             P_IFCT:
    79dd:3e02  - mov       al,byte ptr [si+FF]
    79dd:3e05  - xlat
    79dd:3e07  - or        al,al
    79dd:3e09  - jns       3E0E
    79dd:3e0b    jmp       P_IFC
    79dd:3e0e  - jmp       PM
             P_IFS:
    79dd:3e11  - call      GETSTRPAR
    79dd:3e14  - je        3E19
    79dd:3e16    jmp       FINDENDC
    79dd:3e19  - ret
             P_IFNS:
    79dd:3e1a  - call      GETSTRPAR
    79dd:3e1d  - jne       3E22
    79dd:3e1f    jmp       FINDENDC
    79dd:3e22  - ret
             GETSTRPAR:
    79dd:3e23  - lodsb
    79dd:3e24    xlat
    79dd:3e26    or        al,al
    79dd:3e28    js        GETSTRPAR
    79dd:3e2a    dec       si
    79dd:3e2b  - inc       word ptr ss:[0F96]
    79dd:3e30  - call      GETSTRINGADDR
    79dd:3e33  - push      dx
    79dd:3e34  - push      cx
    79dd:3e35  - lodsb
    79dd:3e36  - cmp       al,2C
    79dd:3e38  - je        3E3D
    79dd:3e3a    jmp       EAERR
    79dd:3e3d  - call      CONVEXPRESS
    79dd:3e40  - mov       word ptr ss:[9A7C],cx
    79dd:3e45  - lodsb
    79dd:3e46  - cmp       al,2C
    79dd:3e48  - je        3E4D
    79dd:3e4a    jmp       EAERR
    79dd:3e4d  - call      CONVEXPRESS
    79dd:3e50  - mov       byte ptr ss:[9A7E],cl
    79dd:3e55  - pop       cx
    79dd:3e56  - pop       dx
    79dd:3e57  - test      byte ptr ss:[0ACE],C0
    79dd:3e5d  - je        3E62
    79dd:3e5f    jmp       P_EQUERR2
    79dd:3e62  - push      ds
    79dd:3e63  - push      si
    79dd:3e64  - mov       si,cx
    79dd:3e66  - mov       ds,dx
    79dd:3e68  - add       si,word ptr ss:[9A7C]
    79dd:3e6d  - mov       al,byte ptr [si]
    79dd:3e6f  - pop       si
    79dd:3e70  - pop       ds
    79dd:3e71  - cmp       al,byte ptr ss:[9A7E]
    79dd:3e76  - ret
             P_IFND:
    79dd:3e77  - mov       al,byte ptr [si]
    79dd:3e79    xlat
    79dd:3e7b    or        al,al
    79dd:3e7d    js        3E82
    79dd:3e7f    jmp       PM
    79dd:3e82  - lodsb
    79dd:3e83    xlat
    79dd:3e85    or        al,al
    79dd:3e87    js        3E82
    79dd:3e89    dec       si
    79dd:3e8a  - inc       word ptr ss:[0F96]
    79dd:3e8f  - mov       byte ptr ss:[0F88],01
    79dd:3e95  - call      CONVEXPRESS
    79dd:3e98  - mov       byte ptr ss:[0F88],00
    79dd:3e9e  - test      byte ptr ss:[0ACE],80
    79dd:3ea4  - jne       3EA9
    79dd:3ea6    jmp       FINDENDC
    79dd:3ea9  - ret
             P_IFD:
    79dd:3eaa  - lodsb
    79dd:3eab    xlat
    79dd:3ead    or        al,al
    79dd:3eaf    js        P_IFD
    79dd:3eb1    dec       si
    79dd:3eb2  - inc       word ptr ss:[0F96]
    79dd:3eb7  - mov       byte ptr ss:[0F88],01
    79dd:3ebd  - call      CONVEXPRESS
    79dd:3ec0  - mov       byte ptr ss:[0F88],00
    79dd:3ec6  - test      byte ptr ss:[0ACE],80
    79dd:3ecc  - je        3ED1
    79dd:3ece    jmp       FINDENDC
    79dd:3ed1  - ret
             P_IFNC:
    79dd:3ed2  - mov       al,byte ptr [si]
    79dd:3ed4    xlat
    79dd:3ed6    or        al,al
    79dd:3ed8    js        3EDD
    79dd:3eda    jmp       PM
    79dd:3edd  - mov       dh,FF
    79dd:3edf  - jmp       P_IFC1
             P_IFC:
    79dd:3ee1  - dec       si
    79dd:3ee2  - mov       al,byte ptr [si]
    79dd:3ee4    xlat
    79dd:3ee6    or        al,al
    79dd:3ee8    js        3EED
    79dd:3eea    jmp       PM
    79dd:3eed  - xor       dh,dh
             P_IFC1:
    79dd:3eef  - lodsb
    79dd:3ef0    xlat
    79dd:3ef2    or        al,al
    79dd:3ef4    js        P_IFC1
    79dd:3ef6    dec       si
    79dd:3ef7  - inc       word ptr ss:[0F96]
    79dd:3efc  - push      es
    79dd:3efd  - push      di
    79dd:3efe  - mov       es,word ptr ss:[0ED9]
    79dd:3f03  - mov       di,word ptr ss:[0EDB]
    79dd:3f08  - xor       cx,cx
    79dd:3f0a  - lodsb
    79dd:3f0b  - mov       ah,al
    79dd:3f0d  - cmp       ah,27
    79dd:3f10  - je        IFCCOPY
    79dd:3f12  - cmp       ah,22
    79dd:3f15  - jne       P_IFCERR
             IFCCOPY:
    79dd:3f17  - lodsb
    79dd:3f18  - cmp       al,ah
    79dd:3f1a  - je        IFCNEXT
    79dd:3f1c  - cmp       al,0D
    79dd:3f1e  - je        P_IFCERR1
    79dd:3f20  - stosb
    79dd:3f21  - inc       cx
    79dd:3f22  - jmp       IFCCOPY
             IFCNEXT:
    79dd:3f24  - lodsb
    79dd:3f25  - cmp       al,2C
    79dd:3f27  - jne       P_IFCERR2
    79dd:3f29  - mov       es,word ptr ss:[0ED9]
    79dd:3f2e  - mov       di,word ptr ss:[0EDB]
    79dd:3f33  - lodsb
    79dd:3f34  - mov       ah,al
    79dd:3f36  - cmp       ah,27
    79dd:3f39  - je        IFCCOMP
    79dd:3f3b  - cmp       ah,22
    79dd:3f3e  - jne       P_IFCERR
    79dd:3f40  - or        cx,cx
    79dd:3f42  - je        IFCCOMP1
             IFCCOMP:
    79dd:3f44  - lodsb
    79dd:3f45  - cmp       al,0D
    79dd:3f47  - je        P_IFCERR1
    79dd:3f49  - cmp       al,byte ptr es:[di]
    79dd:3f4c  - jne       IFCNOTEQUAL
    79dd:3f4e  - inc       di
    79dd:3f4f  - dec       cx
    79dd:3f50  - jne       IFCCOMP
             IFCCOMP1:
    79dd:3f52  - lodsb
    79dd:3f53  - cmp       al,ah
    79dd:3f55  - jne       IFCNOTEQUAL
    79dd:3f57  - pop       di
    79dd:3f58  - pop       es
    79dd:3f59  - or        dh,dh
    79dd:3f5b  - je        3F60
    79dd:3f5d    jmp       FINDENDC
    79dd:3f60  - ret
             IFCNOTEQUAL:
    79dd:3f61  - cmp       al,0D
    79dd:3f63  - je        P_IFCERR1
    79dd:3f65  - pop       di
    79dd:3f66  - pop       es
    79dd:3f67  - or        dh,dh
    79dd:3f69  - jne       3F6E
    79dd:3f6b    jmp       FINDENDC
    79dd:3f6e  - ret
             P_IFCERR:
    79dd:3f6f  - pop       di
    79dd:3f70  - pop       es
    79dd:3f71  - push      dx
    79dd:3f72    mov       dx,8078
    79dd:3f75    call      ERROR_ROUT
    79dd:3f78    pop       dx
             P_IFCERR1:
    79dd:3f79    dec       si
    79dd:3f7a  - pop       di
    79dd:3f7b  - pop       es
    79dd:3f7c  - cmp       ah,27
    79dd:3f7f  - jne       P_IFCERR1A
    79dd:3f81  - push      dx
    79dd:3f82    mov       dx,8136
    79dd:3f85    call      ERROR_ROUT
    79dd:3f88    pop       dx
             P_IFCERR1A:
    79dd:3f89  - push      dx
    79dd:3f8a    mov       dx,814C
    79dd:3f8d    call      ERROR_ROUT
    79dd:3f90    pop       dx
             P_IFCERR2:
    79dd:3f91    dec       si
    79dd:3f92  - pop       di
    79dd:3f93  - pop       es
    79dd:3f94  - push      dx
    79dd:3f95    mov       dx,8078
    79dd:3f98    call      ERROR_ROUT
    79dd:3f9b    pop       dx
             P_IFGT:
    79dd:3f9c  - lodsb
    79dd:3f9d    xlat
    79dd:3f9f    or        al,al
    79dd:3fa1    js        P_IFGT
    79dd:3fa3    dec       si
    79dd:3fa4  - inc       word ptr ss:[0F96]
    79dd:3fa9  - call      CONVEXPRESS
    79dd:3fac  - test      byte ptr ss:[0ACE],C0
    79dd:3fb2  - je        3FB7
    79dd:3fb4    jmp       P_IFERR
    79dd:3fb7  - or        dx,dx
    79dd:3fb9  - jns       3FBE
    79dd:3fbb    jmp       FINDENDC
    79dd:3fbe  - je        P_IFGT1
    79dd:3fc0  - ret
             P_IFGT1:
    79dd:3fc1  - or        cx,cx
    79dd:3fc3  - jne       3FC8
    79dd:3fc5    jmp       FINDENDC
    79dd:3fc8  - ret
             P_IFGE:
    79dd:3fc9  - lodsb
    79dd:3fca    xlat
    79dd:3fcc    or        al,al
    79dd:3fce    js        P_IFGE
    79dd:3fd0    dec       si
    79dd:3fd1  - inc       word ptr ss:[0F96]
    79dd:3fd6  - call      CONVEXPRESS
    79dd:3fd9  - test      byte ptr ss:[0ACE],C0
    79dd:3fdf  - je        3FE4
    79dd:3fe1    jmp       P_IFERR
    79dd:3fe4  - or        dx,dx
    79dd:3fe6  - jns       3FEB
    79dd:3fe8    jmp       FINDENDC
    79dd:3feb  - ret
             P_IFLT:
    79dd:3fec  - lodsb
    79dd:3fed    xlat
    79dd:3fef    or        al,al
    79dd:3ff1    js        P_IFLT
    79dd:3ff3    dec       si
    79dd:3ff4  - inc       word ptr ss:[0F96]
    79dd:3ff9  - call      CONVEXPRESS
    79dd:3ffc  - test      byte ptr ss:[0ACE],C0
    79dd:4002  - je        4007
    79dd:4004    jmp       P_IFERR
    79dd:4007  - or        dx,dx
    79dd:4009  - js        400E
    79dd:400b    jmp       FINDENDC
    79dd:400e  - ret
             P_IFLE:
    79dd:400f  - lodsb
    79dd:4010    xlat
    79dd:4012    or        al,al
    79dd:4014    js        P_IFLE
    79dd:4016    dec       si
    79dd:4017  - inc       word ptr ss:[0F96]
    79dd:401c  - call      CONVEXPRESS
    79dd:401f  - test      byte ptr ss:[0ACE],C0
    79dd:4025  - je        402A
    79dd:4027    jmp       P_IFERR
    79dd:402a  - or        dx,dx
    79dd:402c  - jns       P_IFLE1
    79dd:402e  - mov       bx,76A7
    79dd:4031  - ret
             P_IFLE1:
    79dd:4032  - je        4037
    79dd:4034    jmp       FINDENDC
    79dd:4037  - or        cx,cx
    79dd:4039  - je        403E
    79dd:403b    jmp       FINDENDC
    79dd:403e  - mov       bx,76A7
    79dd:4041  - ret
             P_IFNE:
    79dd:4042  - lodsb
    79dd:4043    xlat
    79dd:4045    or        al,al
    79dd:4047    js        P_IFNE
    79dd:4049    dec       si
    79dd:404a  - inc       word ptr ss:[0F96]
    79dd:404f  - call      CONVEXPRESS
    79dd:4052  - test      byte ptr ss:[0ACE],C0
    79dd:4058  - je        405D
    79dd:405a    jmp       P_IFERR
    79dd:405d  - or        dx,dx
    79dd:405f  - jne       EXECCOND
    79dd:4061  - or        cx,cx
    79dd:4063  - jne       EXECCOND
    79dd:4065  - jmp       FINDENDC
             P_IFEQ:
    79dd:4068  - lodsb
    79dd:4069    xlat
    79dd:406b    or        al,al
    79dd:406d    js        P_IFEQ
    79dd:406f    dec       si
    79dd:4070  - inc       word ptr ss:[0F96]
    79dd:4075  - call      CONVEXPRESS
    79dd:4078  - test      byte ptr ss:[0ACE],C0
    79dd:407e  - je        4083
    79dd:4080    jmp       P_IFERR
    79dd:4083  - or        dx,dx
    79dd:4085  - je        408A
    79dd:4087    jmp       FINDENDC
    79dd:408a  - or        cx,cx
    79dd:408c  - je        EXECCOND
    79dd:408e    jmp       FINDENDC
             EXECCOND:
    79dd:4091  - ret
             P_NEWIF:
    79dd:4092  - lodsb
    79dd:4093    xlat
    79dd:4095    or        al,al
    79dd:4097    js        P_NEWIF
    79dd:4099    dec       si
    79dd:409a  - call      CONVEXPRESS
    79dd:409d  - test      byte ptr ss:[0ACE],80
    79dd:40a3  - je        40A8
    79dd:40a5    jmp       P_IFERR
    79dd:40a8  - lodsb
    79dd:40a9    xlat
    79dd:40ab    or        al,al
    79dd:40ad    js        40A8
    79dd:40af    dec       si
    79dd:40b0  - lodsw
    79dd:40b1  - cmp       al,3B
    79dd:40b3  - je        P_IFONLY
    79dd:40b5  - cmp       al,0A
    79dd:40b7  - je        P_IFONLY
    79dd:40b9  - cmp       al,3C
    79dd:40bb  - je        P_NIFL
    79dd:40bd  - cmp       al,3E
    79dd:40bf  - je        P_NIFG
    79dd:40c1  - cmp       al,3D
    79dd:40c3  - jne       40C8
    79dd:40c5    jmp       P_NIFEQ
    79dd:40c8  - and       ax,DFDF
    79dd:40cb  - cmp       al,45
    79dd:40cd  - je        P_CIFE
    79dd:40cf  - cmp       al,4E
    79dd:40d1  - je        P_CIFN
    79dd:40d3  - cmp       al,47
    79dd:40d5  - je        P_CIFG
    79dd:40d7  - cmp       al,4C
    79dd:40d9  - je        P_CIFL
    79dd:40db  - jmp       PM
             P_IFONLY:
    79dd:40de  - mov       ax,cx
    79dd:40e0  - mov       bx,dx
    79dd:40e2  - xor       cx,cx
    79dd:40e4  - xor       dx,dx
    79dd:40e6  - sub       si,02
    79dd:40e9  - jmp       P_IFONLY2
             P_NIFL:
    79dd:40ec  - cmp       ah,3D
    79dd:40ef  - jne       40F4
    79dd:40f1    jmp       P_NIFLE
    79dd:40f4  - mov       al,ah
    79dd:40f6  - xlat
    79dd:40f8  - or        al,al
    79dd:40fa  - jns       40FF
    79dd:40fc    jmp       P_NIFLT
    79dd:40ff  - jmp       EAERR
             P_NIFG:
    79dd:4102  - cmp       ah,3D
    79dd:4105  - je        P_NIFGE
    79dd:4107  - mov       al,ah
    79dd:4109  - xlat
    79dd:410b  - or        al,al
    79dd:410d  - js        P_NIFGT
    79dd:410f  - jmp       EAERR
             P_CIFE:
    79dd:4112  - cmp       ah,51
    79dd:4115  - jne       411A
    79dd:4117    jmp       P_NIFEQ
    79dd:411a  - jmp       PM
             P_CIFN:
    79dd:411d  - cmp       ah,45
    79dd:4120  - jne       4125
    79dd:4122    jmp       P_NIFNE
    79dd:4125  - jmp       PM
             P_CIFG:
    79dd:4128  - cmp       ah,54
    79dd:412b  - je        P_NIFGT
    79dd:412d  - cmp       ah,45
    79dd:4130  - je        P_NIFGE
    79dd:4132  - jmp       PM
             P_CIFL:
    79dd:4135  - cmp       ah,54
    79dd:4138  - je        P_NIFLT
    79dd:413a  - cmp       ah,45
    79dd:413d  - jne       4142
    79dd:413f    jmp       P_NIFLE
    79dd:4142  - jmp       PM
             P_IFERR:
    79dd:4145  - push      dx
    79dd:4146    mov       dx,80D7
    79dd:4149    call      ERROR_ROUT
    79dd:414c    pop       dx
             P_NIFGT:
    79dd:414d  - lodsb
    79dd:414e    xlat
    79dd:4150    or        al,al
    79dd:4152    js        P_NIFGT
    79dd:4154    dec       si
    79dd:4155  - push      dx
    79dd:4156  - push      cx
    79dd:4157  - call      CONVEXPRESS
    79dd:415a  - test      byte ptr ss:[0ACE],80
    79dd:4160  - jne       P_IFERR
    79dd:4162  - inc       word ptr ss:[0F96]
    79dd:4167  - pop       ax
    79dd:4168  - pop       bx
    79dd:4169  - cmp       bx,dx
    79dd:416b  - jg        P_IFGTX
    79dd:416d  - je        4172
    79dd:416f    jmp       FINDENDC
    79dd:4172  - cmp       ax,cx
    79dd:4174  - jg        P_IFGTX
    79dd:4176    jmp       FINDENDC
             P_IFGTX:
    79dd:4179  - mov       bx,76A7
    79dd:417c  - ret
             P_NIFGE:
    79dd:417d  - lodsb
    79dd:417e    xlat
    79dd:4180    or        al,al
    79dd:4182    js        P_NIFGE
    79dd:4184    dec       si
    79dd:4185  - push      dx
    79dd:4186  - push      cx
    79dd:4187  - call      CONVEXPRESS
    79dd:418a  - test      byte ptr ss:[0ACE],80
    79dd:4190  - jne       P_IFERR
    79dd:4192  - inc       word ptr ss:[0F96]
    79dd:4197  - pop       ax
    79dd:4198  - pop       bx
    79dd:4199  - cmp       bx,dx
    79dd:419b  - jg        P_IFGEX
    79dd:419d  - cmp       ax,cx
    79dd:419f  - jge       P_IFGEX
    79dd:41a1    jmp       FINDENDC
             P_IFGEX:
    79dd:41a4  - mov       bx,76A7
    79dd:41a7  - ret
             P_NIFLT:
    79dd:41a8  - lodsb
    79dd:41a9    xlat
    79dd:41ab    or        al,al
    79dd:41ad    js        P_NIFLT
    79dd:41af    dec       si
    79dd:41b0  - push      dx
    79dd:41b1  - push      cx
    79dd:41b2  - call      CONVEXPRESS
    79dd:41b5  - test      byte ptr ss:[0ACE],80
    79dd:41bb  - jne       P_IFERR
    79dd:41bd  - inc       word ptr ss:[0F96]
    79dd:41c2  - pop       ax
    79dd:41c3  - pop       bx
    79dd:41c4  - cmp       bx,dx
    79dd:41c6  - jl        P_IFLTX
    79dd:41c8  - je        41CD
    79dd:41ca    jmp       FINDENDC
    79dd:41cd  - cmp       ax,cx
    79dd:41cf  - jl        P_IFLTX
    79dd:41d1    jmp       FINDENDC
             P_IFLTX:
    79dd:41d4  - mov       bx,76A7
    79dd:41d7  - ret
             P_NIFLE:
    79dd:41d8  - lodsb
    79dd:41d9    xlat
    79dd:41db    or        al,al
    79dd:41dd    js        P_NIFLE
    79dd:41df    dec       si
    79dd:41e0  - push      dx
    79dd:41e1  - push      cx
    79dd:41e2  - call      CONVEXPRESS
    79dd:41e5  - test      byte ptr ss:[0ACE],80
    79dd:41eb  - je        41F0
    79dd:41ed    jmp       P_IFERR
    79dd:41f0  - inc       word ptr ss:[0F96]
    79dd:41f5  - pop       ax
    79dd:41f6  - pop       bx
    79dd:41f7  - cmp       bx,dx
    79dd:41f9  - jl        P_IFLEX
    79dd:41fb  - jne       FINDENDC
    79dd:41fd  - cmp       ax,cx
    79dd:41ff  - jg        FINDENDC
             P_IFLEX:
    79dd:4201  - mov       bx,76A7
    79dd:4204  - ret
             P_NIFEQ:
    79dd:4205  - lodsb
    79dd:4206    xlat
    79dd:4208    or        al,al
    79dd:420a    js        P_NIFEQ
    79dd:420c    dec       si
    79dd:420d  - push      dx
    79dd:420e  - push      cx
    79dd:420f  - call      CONVEXPRESS
    79dd:4212  - test      byte ptr ss:[0ACE],80
    79dd:4218  - je        421D
    79dd:421a    jmp       P_IFERR
    79dd:421d  - inc       word ptr ss:[0F96]
    79dd:4222  - pop       ax
    79dd:4223  - pop       bx
    79dd:4224  - cmp       dx,bx
    79dd:4226  - jne       FINDENDC
    79dd:4228  - cmp       cx,ax
    79dd:422a  - jne       FINDENDC
    79dd:422c  - mov       bx,76A7
    79dd:422f  - ret
             P_NIFNE:
    79dd:4230  - lodsb
    79dd:4231    xlat
    79dd:4233    or        al,al
    79dd:4235    js        P_NIFNE
    79dd:4237    dec       si
    79dd:4238  - push      dx
    79dd:4239  - push      cx
    79dd:423a  - call      CONVEXPRESS
    79dd:423d  - test      byte ptr ss:[0ACE],80
    79dd:4243  - je        4248
    79dd:4245    jmp       P_IFERR
    79dd:4248  - pop       ax
    79dd:4249  - pop       bx
             P_IFONLY2:
    79dd:424a  - inc       word ptr ss:[0F96]
    79dd:424f  - cmp       cx,ax
    79dd:4251  - je        P_IFNE2
    79dd:4253  - mov       bx,76A7
    79dd:4256  - ret
             P_IFNE2:
    79dd:4257  - cmp       dx,bx
    79dd:4259  - je        FINDENDC
    79dd:425b  - mov       bx,76A7
    79dd:425e  - ret
             FINDENDC:
    79dd:425f  - mov       bx,76A7
    79dd:4262  - mov       word ptr ss:[9A94],0000
    79dd:4269  - mov       word ptr ss:[9A90],es
    79dd:426e  - mov       word ptr ss:[9A92],di
    79dd:4273  - mov       ax,ds
    79dd:4275  - mov       es,ax
    79dd:4277  - mov       di,si
             FINDENDOFLINE:
    79dd:4279  - mov       cx,FFFF
    79dd:427c  - mov       al,0D
    79dd:427e  - repne
    79dd:427f    scasb
             FEOL:
    79dd:4280  - inc       word ptr ss:[13F0]
    79dd:4285  - inc       di
             FELSKS:
    79dd:4286  - mov       al,byte ptr es:[di]
    79dd:4289  - cmp       al,1A
    79dd:428b  - jne       4290
    79dd:428d    jmp       FEGMS
    79dd:4290  - inc       di
    79dd:4291  - cmp       al,0D
    79dd:4293  - je        FEOL
    79dd:4295  - xlat
    79dd:4297  - or        al,al
    79dd:4299  - jns       FINDENDOFLINE
             FELSKS1:
    79dd:429b  - mov       al,byte ptr es:[di]
    79dd:429e  - inc       di
    79dd:429f  - cmp       al,0D
    79dd:42a1  - je        FEOL
    79dd:42a3  - xlat
    79dd:42a5  - or        al,al
    79dd:42a7  - js        FELSKS1
    79dd:42a9  - and       al,DF
    79dd:42ab  - cmp       al,45
    79dd:42ad  - je        MABENDC
    79dd:42af  - cmp       al,52
    79dd:42b1  - jne       42B6
    79dd:42b3    jmp       MABRUN
    79dd:42b6  - cmp       al,49
    79dd:42b8  - jne       FINDENDOFLINE
    79dd:42ba  - mov       al,byte ptr es:[di]
    79dd:42bd  - and       al,DF
    79dd:42bf  - cmp       al,46
    79dd:42c1  - jne       FINDENDOFLINE
    79dd:42c3  - mov       ax,word ptr es:[di+01]
    79dd:42c7  - xlat
    79dd:42c9  - or        al,al
    79dd:42cb  - js        FOUNDREALIF
    79dd:42cd  - xchg      ah,al
    79dd:42cf  - xlat
    79dd:42d1  - push      es
    79dd:42d2  - push      di
    79dd:42d3  - mov       cx,8AC9
    79dd:42d6  - mov       es,cx
    79dd:42d8  - mov       di,7BAB
    79dd:42db  - mov       cx,0013
    79dd:42de  - repne
    79dd:42df    scasw
    79dd:42e0  - pop       di
    79dd:42e1  - pop       es
    79dd:42e2  - or        cx,cx
    79dd:42e4  - je        FINDENDOFLINE
             FOUNDREALIF:
    79dd:42e6  - or        al,al
    79dd:42e8  - js        FRIF
    79dd:42ea  - mov       al,byte ptr es:[di+03]
    79dd:42ee  - xlat
    79dd:42f0  - cmp       al,45
    79dd:42f2  - jne       JSFIF0
    79dd:42f4  - mov       al,byte ptr es:[di+04]
    79dd:42f8  - xlat
    79dd:42fa  - or        al,al
    79dd:42fc  - js        FRIF
             JSFIF0:
    79dd:42fe  - mov       al,byte ptr es:[di+03]
    79dd:4302  - xlat
    79dd:4304  - or        al,al
    79dd:4306  - js        FRIF
    79dd:4308    jmp       FINDENDOFLINE
             FRIF:
    79dd:430b  - inc       word ptr ss:[9A94]
    79dd:4310  - jmp       FINDENDOFLINE
             MABENDC:
    79dd:4313  - mov       ax,word ptr es:[di]
    79dd:4316  - and       ax,DFDF
    79dd:4319  - cmp       ax,444E
    79dd:431c  - jne       MABELSEIF
    79dd:431e  - mov       ax,word ptr es:[di+02]
    79dd:4322  - and       al,DF
    79dd:4324  - cmp       al,43
    79dd:4326  - jne       MABENDIF
    79dd:4328  - mov       al,ah
    79dd:432a  - xlat
    79dd:432c  - or        al,al
    79dd:432e  - js        ISENDC
    79dd:4330    jmp       FINDENDOFLINE
             ISENDC:
    79dd:4333  - dec       word ptr ss:[9A94]
    79dd:4338  - js        433D
    79dd:433a    jmp       FINDENDOFLINE
    79dd:433d  - add       di,03
    79dd:4340  - mov       si,di
    79dd:4342  - mov       ax,es
    79dd:4344  - mov       ds,ax
    79dd:4346  - mov       es,word ptr ss:[9A90]
    79dd:434b  - mov       di,word ptr ss:[9A92]
    79dd:4350  - dec       word ptr ss:[0F96]
    79dd:4355  - ret
             MABENDIF:
    79dd:4356  - and       ah,DF
    79dd:4359  - cmp       ax,4649
    79dd:435c  - je        4361
    79dd:435e    jmp       FINDENDOFLINE
    79dd:4361  - mov       al,byte ptr es:[di+04]
    79dd:4365  - xlat
    79dd:4367  - or        al,al
    79dd:4369  - js        ISENDC
    79dd:436b  - jmp       FINDENDOFLINE
             MABELSEIF:
    79dd:436e  - cmp       ax,534C
    79dd:4371  - je        4376
    79dd:4373    jmp       FINDENDOFLINE
    79dd:4376  - mov       ax,word ptr es:[di+02]
    79dd:437a  - and       ax,DFDF
    79dd:437d  - cmp       ax,4945
    79dd:4380  - je        4385
    79dd:4382    jmp       FINDENDOFLINE
    79dd:4385  - mov       ax,word ptr es:[di+04]
    79dd:4389  - and       al,DF
    79dd:438b  - cmp       al,46
    79dd:438d  - je        4392
    79dd:438f    jmp       FINDENDOFLINE
    79dd:4392  - mov       al,ah
    79dd:4394  - xlat
    79dd:4396  - or        al,al
    79dd:4398  - js        439D
    79dd:439a    jmp       FINDENDOFLINE
    79dd:439d  - cmp       word ptr ss:[9A94],00
    79dd:43a3  - je        43A8
    79dd:43a5    jmp       FINDENDOFLINE
    79dd:43a8  - mov       si,di
    79dd:43aa  - mov       ax,es
    79dd:43ac  - mov       ds,ax
    79dd:43ae  - mov       es,word ptr ss:[9A90]
    79dd:43b3  - mov       di,word ptr ss:[9A92]
    79dd:43b8  - ret
             MABRUN:
    79dd:43b9  - mov       ax,word ptr es:[di]
    79dd:43bc  - and       ax,DFDF
    79dd:43bf  - cmp       ax,4E55
    79dd:43c2  - je        43C7
    79dd:43c4    jmp       FINDENDOFLINE
    79dd:43c7  - mov       al,byte ptr es:[di+02]
    79dd:43cb  - xlat
    79dd:43cd  - or        al,al
    79dd:43cf  - js        43D4
    79dd:43d1    jmp       FINDENDOFLINE
    79dd:43d4  - add       di,03
    79dd:43d7  - lodsb
    79dd:43d8    xlat
    79dd:43da    or        al,al
    79dd:43dc    js        43D7
    79dd:43de    dec       si
    79dd:43df  - mov       ax,es
    79dd:43e1  - mov       ds,ax
    79dd:43e3  - mov       si,di
    79dd:43e5  - mov       byte ptr ss:[247D],01
    79dd:43eb  - call      P_PRINTF2
    79dd:43ee  - mov       byte ptr ss:[247D],00
    79dd:43f4  - mov       di,si
    79dd:43f6  - push      bx
    79dd:43f7  - mov       bx,word ptr ss:[2486]
    79dd:43fc  - add       bx,8A6E
    79dd:4400  - mov       byte ptr ss:[bx],0D
    79dd:4404  - mov       byte ptr ss:[bx+01],0A
    79dd:4409  - mov       byte ptr ss:[bx+02],1A
    79dd:440e  - pop       bx
    79dd:440f  - push      es
    79dd:4410  - push      di
    79dd:4411  - mov       ax,ss
    79dd:4413  - mov       es,ax
    79dd:4415  - mov       di,8A6E
    79dd:4418  - mov       al,byte ptr es:[di]
    79dd:441b  - xlat
    79dd:441d  - or        al,al
    79dd:441f  - jns       MABRUNX
    79dd:4421  - inc       di
             MABRUNLP:
    79dd:4422  - mov       al,byte ptr es:[di]
    79dd:4425  - inc       di
    79dd:4426  - xlat
    79dd:4428  - or        al,al
    79dd:442a  - js        MABRUNLP
    79dd:442c  - mov       ax,word ptr es:[di+FF]
    79dd:4430  - and       ax,DFDF
    79dd:4433  - cmp       ax,4649
    79dd:4436  - jne       MABRUNX
    79dd:4438  - add       di,01
    79dd:443b  - mov       ax,word ptr es:[di]
    79dd:443e  - xlat
    79dd:4440  - or        al,al
    79dd:4442  - js        RUNIF
    79dd:4444  - xchg      ah,al
    79dd:4446  - xlat
    79dd:4448  - push      es
    79dd:4449  - push      di
    79dd:444a  - mov       cx,8AC9
    79dd:444d  - mov       es,cx
    79dd:444f  - mov       di,7BAB
    79dd:4452  - mov       cx,0013
    79dd:4455  - repne
    79dd:4456    scasw
    79dd:4457  - pop       di
    79dd:4458  - pop       es
    79dd:4459  - or        cx,cx
    79dd:445b  - je        MABRUNX
    79dd:445d  - or        al,al
    79dd:445f  - js        RUNIF
    79dd:4461  - mov       al,byte ptr es:[di+02]
    79dd:4465  - xlat
    79dd:4467  - or        al,al
    79dd:4469  - jns       MABRUNX
             RUNIF:
    79dd:446b  - inc       word ptr ss:[9A94]
             MABRUNX:
    79dd:4470  - pop       di
    79dd:4471  - pop       es
    79dd:4472  - dec       di
    79dd:4473  - jmp       FINDENDOFLINE
             FEGMS:
    79dd:4476  - mov       bp,word ptr ss:[0F9C]
    79dd:447b  - mov       al,byte ptr [bp+14]
    79dd:447e  - test      al,08
    79dd:4480  - jne       FEGMSRUN
    79dd:4482  - call      READMORESOURCE
    79dd:4485  - jne       FEGMSERR
    79dd:4487  - mov       ax,ds
    79dd:4489  - mov       es,ax
    79dd:448b  - mov       di,si
    79dd:448d  - jmp       FELSKS
             FEGMSRUN:
    79dd:4490  - sub       bp,1F
    79dd:4493  - mov       es,word ptr [bp+0C]
    79dd:4496  - mov       di,word ptr [bp+0E]
    79dd:4499  - mov       ax,word ptr [bp+00]
    79dd:449c  - mov       word ptr [1470],ax
    79dd:44a0  - mov       ax,word ptr [bp+15]
    79dd:44a3  - mov       word ptr [13F0],ax
    79dd:44a7  - mov       word ptr ss:[0F9C],bp
    79dd:44ac  - dec       byte ptr ss:[0F8A]
    79dd:44b1  - jmp       FELSKS
             FEGMSERR:
    79dd:44b4  - sub       di,02
    79dd:44b7  - mov       si,di
    79dd:44b9  - mov       ax,es
    79dd:44bb  - mov       ds,ax
    79dd:44bd  - mov       es,word ptr ss:[9A90]
    79dd:44c2  - mov       di,word ptr ss:[9A92]
    79dd:44c7  - mov       byte ptr ss:[0F8C],00
    79dd:44cd  - push      dx
    79dd:44ce    mov       dx,8110
    79dd:44d1    call      ERROR_ROUT
    79dd:44d4    pop       dx
             P_INCDIR:
    79dd:44d5  - lodsb
    79dd:44d6    xlat
    79dd:44d8    or        al,al
    79dd:44da    js        P_INCDIR
    79dd:44dc    dec       si
    79dd:44dd  - mov       ax,word ptr [si]
    79dd:44df  - cmp       ax,2222
    79dd:44e2  - jne       NOTSETI
    79dd:44e4  - mov       byte ptr ss:[0EE6],00
    79dd:44ea  - ret
             NOTSETI:
    79dd:44eb  - push      di
    79dd:44ec  - push      es
    79dd:44ed  - push      bx
    79dd:44ee  - mov       ax,ss
    79dd:44f0  - mov       es,ax
    79dd:44f2  - mov       di,0EE6
    79dd:44f5  - mov       bx,7929
             IDLP:
    79dd:44f8  - lodsb
    79dd:44f9  - stosb
    79dd:44fa  - xlat
    79dd:44fc  - or        al,al
    79dd:44fe  - jns       IDLP
    79dd:4500  - mov       bx,76A7
    79dd:4503  - mov       byte ptr es:[di+FF],00
    79dd:4508  - dec       si
    79dd:4509  - pop       bx
    79dd:450a  - pop       es
    79dd:450b  - pop       di
    79dd:450c  - ret
             P_INCCOL:
    79dd:450d  - lodsb
    79dd:450e    xlat
    79dd:4510    or        al,al
    79dd:4512    js        P_INCCOL
    79dd:4514    dec       si
    79dd:4515  - call      COPYFNAME
    79dd:4518  - push      ds
    79dd:4519  - mov       ds,word ptr ss:[9A7C]
    79dd:451e  - mov       dx,word ptr ss:[9A7E]
    79dd:4523  - call      ADDFLIST
    79dd:4526  - pop       ds
    79dd:4527  - lodsb
    79dd:4528  - cmp       al,2C
    79dd:452a  - je        452F
    79dd:452c    jmp       P_INCCOLINFO
    79dd:452f  - call      CONVEXPRESS
    79dd:4532  - test      byte ptr ss:[0ACE],C0
    79dd:4538  - je        453D
    79dd:453a    jmp       P_EQUERR2
    79dd:453d  - mov       word ptr ss:[9A80],cx
    79dd:4542  - lodsb
    79dd:4543  - cmp       al,2C
    79dd:4545  - je        454A
    79dd:4547    jmp       P_INCCOLINFO
    79dd:454a  - call      CONVEXPRESS
    79dd:454d  - test      byte ptr ss:[0ACE],C0
    79dd:4553  - je        4558
    79dd:4555    jmp       P_EQUERR2
    79dd:4558  - mov       ax,word ptr [9A80]
    79dd:455c  - sub       cx,ax
    79dd:455e  - js        P_INCCOLINFO
    79dd:4560  - je        P_INCCOLINFO
    79dd:4562  - mov       bx,0020
    79dd:4565  - mul       bx
    79dd:4567  - mov       word ptr [9A80],ax
    79dd:456b  - mov       ax,cx
    79dd:456d  - mul       bx
    79dd:456f  - mov       word ptr [9A82],ax
    79dd:4573  - call      SPLITOBJBUF
    79dd:4576  - call      CALCROMPOS
    79dd:4579  - mov       word ptr es:[di+0C],ax
    79dd:457d  - mov       word ptr es:[di+0E],cx
    79dd:4581  - mov       byte ptr es:[di+10],02
    79dd:4586  - mov       al,byte ptr [13BA]
    79dd:458a  - or        byte ptr es:[di+10],al
    79dd:458e  - mov       ax,word ptr [9A80]
    79dd:4592  - mov       word ptr es:[di+11],ax
    79dd:4596  - mov       ax,word ptr [9A7C]
    79dd:459a  - mov       word ptr es:[di+08],ax
    79dd:459e  - mov       ax,word ptr [9A7E]
    79dd:45a2  - mov       word ptr es:[di+0A],ax
    79dd:45a6  - xor       ax,ax
    79dd:45a8  - mov       word ptr es:[di+04],ax
    79dd:45ac  - mov       ax,word ptr [9A82]
    79dd:45b0  - mov       word ptr es:[di+06],ax
    79dd:45b4  - add       word ptr ss:[0F94],ax
    79dd:45b9  - adc       word ptr ss:[0F92],00
    79dd:45bf  - mov       bp,di
    79dd:45c1  - add       di,13
    79dd:45c4  - xor       ax,ax
    79dd:45c6  - mov       word ptr [9A80],ax
    79dd:45ca  - inc       word ptr ss:[13DC]
    79dd:45cf  - jmp       SPLITINC
             P_INCCOLINFO:
    79dd:45d2  - push      dx
    79dd:45d3    mov       dx,82E7
    79dd:45d6    call      ERROR_ROUT
    79dd:45d9    pop       dx
             P_INCBIN:
    79dd:45da  - lodsb
    79dd:45db    xlat
    79dd:45dd    or        al,al
    79dd:45df    js        P_INCBIN
    79dd:45e1    dec       si
    79dd:45e2  - call      COPYFNAME
    79dd:45e5  - push      di
    79dd:45e6  - push      ds
    79dd:45e7  - push      bx
    79dd:45e8  - mov       ax,ss
    79dd:45ea  - mov       ds,word ptr ss:[9A7C]
    79dd:45ef  - mov       dx,word ptr ss:[9A7E]
    79dd:45f4  - call      ADDFLIST
    79dd:45f7  - call      far ptr _OS2OPENFILE
    79dd:45fc  - jae       4601
    79dd:45fe    jmp       P_INCBINERR
    79dd:4601  - xor       cx,cx
    79dd:4603  - mov       dx,cx
    79dd:4605  - mov       bx,ax
    79dd:4607  - call      far ptr _OS2SEEKEND
    79dd:460c  - jae       4611
    79dd:460e    jmp       P_INCBINERR
    79dd:4611  - mov       word ptr ss:[9A80],dx
    79dd:4616  - mov       word ptr [9A82],ax
    79dd:461a  - call      far ptr _OS2CLOSEFILE
    79dd:461f  - pop       bx
    79dd:4620  - pop       ds
    79dd:4621  - pop       di
    79dd:4622  - call      SPLITOBJBUF
    79dd:4625  - call      CALCROMPOS
    79dd:4628  - mov       word ptr es:[di+0C],ax
    79dd:462c  - mov       word ptr es:[di+0E],cx
    79dd:4630  - mov       byte ptr es:[di+10],02
    79dd:4635  - mov       al,byte ptr [13BA]
    79dd:4639  - or        byte ptr es:[di+10],al
    79dd:463d  - xor       ax,ax
    79dd:463f  - mov       word ptr [0011],ax
    79dd:4643  - mov       ax,word ptr [9A7C]
    79dd:4647  - mov       word ptr es:[di+08],ax
    79dd:464b  - mov       ax,word ptr [9A7E]
    79dd:464f  - mov       word ptr es:[di+0A],ax
    79dd:4653  - mov       bx,word ptr ss:[9A80]
    79dd:4658  - mov       word ptr es:[di+04],bx
    79dd:465c  - mov       ax,word ptr [9A82]
    79dd:4660  - mov       word ptr es:[di+06],ax
    79dd:4664  - add       word ptr ss:[0F94],ax
    79dd:4669  - adc       word ptr ss:[0F92],bx
    79dd:466e  - mov       bp,di
    79dd:4670  - add       di,13
    79dd:4673  - inc       word ptr ss:[13DC]
             SPLITINC:
    79dd:4678  - mov       word ptr es:[bp+00],es
    79dd:467c  - mov       word ptr es:[bp+02],di
    79dd:4680  - mov       word ptr ss:[13B6],es
    79dd:4685  - mov       word ptr ss:[13B8],di
    79dd:468a  - xor       ax,ax
    79dd:468c  - push      di
    79dd:468d  - mov       cx,0013
             CLROBJ3:
    79dd:4690  - stosb
    79dd:4691  - dec       cx
    79dd:4692  - jne       CLROBJ3
    79dd:4694  - pop       di
    79dd:4695  - mov       ax,word ptr [13BC]
    79dd:4699  - mov       cx,word ptr ss:[13BE]
    79dd:469e  - add       cx,word ptr ss:[9A82]
    79dd:46a3  - adc       ax,word ptr ss:[9A80]
    79dd:46a8  - mov       word ptr [13BC],ax
    79dd:46ac  - mov       word ptr ss:[13BE],cx
    79dd:46b1  - mov       word ptr es:[di+0C],ax
    79dd:46b5  - mov       word ptr es:[di+0E],cx
    79dd:46b9  - mov       byte ptr es:[di+10],01
    79dd:46be  - mov       al,byte ptr [13BA]
    79dd:46c2  - or        byte ptr es:[di+10],al
    79dd:46c6  - add       di,13
    79dd:46c9  - mov       word ptr ss:[13B4],di
    79dd:46ce  - mov       word ptr ss:[0F90],di
    79dd:46d3  - mov       bx,76A7
    79dd:46d6  - ret
             P_INCBINERR:
    79dd:46d7  - pop       bx
    79dd:46d8  - pop       ds
    79dd:46d9  - pop       di
    79dd:46da  - push      dx
    79dd:46db    mov       dx,80FF
    79dd:46de    call      ERROR_ROUT
    79dd:46e1    pop       dx
             P_INCLUDE:
    79dd:46e2  - lodsb
    79dd:46e3    xlat
    79dd:46e5    or        al,al
    79dd:46e7    js        P_INCLUDE
    79dd:46e9    dec       si
    79dd:46ea  - call      COPYFNAME
    79dd:46ed  - push      ds
    79dd:46ee  - push      si
    79dd:46ef  - push      es
    79dd:46f0  - push      di
    79dd:46f1  - mov       ds,word ptr ss:[9A7C]
    79dd:46f6  - mov       si,word ptr ss:[9A7E]
    79dd:46fb  - mov       ax,ss
    79dd:46fd  - mov       es,ax
    79dd:46ff  - mov       di,9778
    79dd:4702  - mov       al,09
    79dd:4704  - stosb
    79dd:4705  - mov       ax,4946
    79dd:4708  - stosw
    79dd:4709  - mov       ax,454C
    79dd:470c  - stosw
    79dd:470d  - mov       ax,535F
    79dd:4710  - stosw
    79dd:4711  - mov       ax,5254
    79dd:4714  - stosw
    79dd:4715  - mov       al,byte ptr [9BDD]
    79dd:4719  - or        al,al
    79dd:471b  - je        NHEAD
    79dd:471d  - mov       ax,365B
    79dd:4720  - stosw
    79dd:4721  - mov       ax,5D34
    79dd:4724  - stosw
             NHEAD:
    79dd:4725  - mov       ax,223D
    79dd:4728  - stosw
             ASSLP2:
    79dd:4729  - lodsb
    79dd:472a  - stosb
    79dd:472b  - xlat
    79dd:472d  - or        al,al
    79dd:472f  - jns       ASSLP2
    79dd:4731  - dec       di
    79dd:4732  - mov       al,22
    79dd:4734  - stosb
    79dd:4735  - mov       al,0D
    79dd:4737  - stosb
    79dd:4738  - mov       al,0A
    79dd:473a  - stosb
    79dd:473b  - mov       ax,ss
    79dd:473d  - mov       ds,ax
    79dd:473f  - mov       si,9778
    79dd:4742  - call      P_STRING
    79dd:4745  - pop       di
    79dd:4746  - pop       es
    79dd:4747  - pop       si
    79dd:4748  - pop       ds
    79dd:4749  - mov       bx,76A7
    79dd:474c  - call      INCLUDEFILE
    79dd:474f  - pop       ax
    79dd:4750  - mov       byte ptr ss:[9BDD],00
    79dd:4756  - cmp       byte ptr ss:[0F8D],00
    79dd:475c  - jne       4761
    79dd:475e    jmp       DO_65816
    79dd:4761  - jmp       DO_MARIO
             INCLUDEFILE:
    79dd:4764  - inc       word ptr ss:[13DC]
    79dd:4769  - push      es
    79dd:476a  - push      di
    79dd:476b  - mov       bp,word ptr ss:[0F9C]
    79dd:4770  - mov       word ptr [bp+0C],ds
    79dd:4773  - mov       word ptr [bp+0E],si
    79dd:4776  - mov       ax,word ptr [1470]
    79dd:477a  - mov       word ptr [bp+00],ax
    79dd:477d  - mov       ax,word ptr [0F96]
    79dd:4781  - mov       word ptr [bp+04],ax
    79dd:4784  - mov       ax,word ptr [13F0]
    79dd:4788  - mov       word ptr [bp+15],ax
    79dd:478b  - mov       ax,word ptr [0200]
    79dd:478f  - mov       word ptr [bp+1B],ax
    79dd:4792  - mov       ax,word ptr [0204]
    79dd:4796  - mov       word ptr [bp+0A],ax
    79dd:4799  - add       bp,1F
    79dd:479c  - mov       ds,word ptr ss:[9A7C]
    79dd:47a1  - mov       dx,word ptr ss:[9A7E]
    79dd:47a6  - call      ADDFLIST
    79dd:47a9  - mov       word ptr [bp+17],ds
    79dd:47ac  - mov       word ptr [bp+1D],ds
    79dd:47af  - mov       word ptr ss:[0F98],ds
    79dd:47b4  - mov       word ptr [bp+19],dx
    79dd:47b7  - mov       word ptr [bp+1F],dx
    79dd:47ba  - mov       word ptr ss:[0F9A],dx
    79dd:47bf  - call      far ptr _OS2OPENFILE
    79dd:47c4  - jae       47C9
    79dd:47c6    jmp       CANTFINDSOURCEFILE
    79dd:47c9  - mov       word ptr [bp+02],ax
    79dd:47cc  - xor       ax,ax
    79dd:47ce  - mov       word ptr [bp+06],ax
    79dd:47d1  - mov       word ptr [bp+08],ax
    79dd:47d4  - push      bp
    79dd:47d5  - mov       bx,0801
    79dd:47d8  - call      far ptr _OS2ALLOCSEG
    79dd:47dd  - jae       47E2
    79dd:47df    jmp       I_CANTALLOC
    79dd:47e2  - pop       bp
    79dd:47e3  - mov       word ptr [bp+10],ax
    79dd:47e6  - mov       word ptr [bp+12],0000
    79dd:47eb  - call      READMORESOURCE
    79dd:47ee  - mov       word ptr ss:[0F9C],bp
    79dd:47f3  - cmp       byte ptr ss:[0F8A],20
    79dd:47f9  - jl        SRCLOK1
    79dd:47fb  - mov       dx,7D45
    79dd:47fe    call      FATALERR_ROUT
    79dd:4801  - jmp       STOPASSEM
             SRCLOK1:
    79dd:4804    inc       byte ptr ss:[0F8A]
    79dd:4809  - xor       ax,ax
    79dd:480b    mov       word ptr [0AAE],ax
    79dd:480f    mov       word ptr [0AB6],ax
    79dd:4813    mov       word ptr [0AB2],ax
    79dd:4817    mov       word ptr [0AB4],ax
    79dd:481b    mov       word ptr [0AB0],ax
    79dd:481f    mov       word ptr [0AB8],ax
    79dd:4823    mov       word ptr [13FF],ax
    79dd:4827    mov       word ptr [0EDF],ax
    79dd:482b    mov       word ptr [248A],ax
    79dd:482f  - mov       bx,0001
    79dd:4832  - mov       word ptr ss:[13F0],bx
    79dd:4837  - mov       word ptr ss:[248A],bx
    79dd:483c  - mov       word ptr ss:[13EC],ds
    79dd:4841  - mov       word ptr ss:[13EE],si
    79dd:4846  - add       word ptr ss:[13EE],01
    79dd:484c  - mov       bx,76A7
    79dd:484f  - pop       di
    79dd:4850  - pop       es
    79dd:4851  - ret
             CANTFINDSOURCEFILE:
    79dd:4852  - push      word ptr ss:[0F98]
    79dd:4857  - push      word ptr ss:[0F9A]
    79dd:485c  - sub       bp,1F
    79dd:485f  - mov       ax,word ptr [bp+15]
    79dd:4862  - mov       word ptr [13F0],ax
    79dd:4866  - mov       ax,word ptr [bp+17]
    79dd:4869  - mov       word ptr [0F98],ax
    79dd:486d  - mov       ax,word ptr [bp+19]
    79dd:4870  - mov       word ptr [0F9A],ax
    79dd:4874  - mov       dx,7BFB
    79dd:4877    call      FATALERR_ROUT
    79dd:487a  - pop       word ptr ss:[0F9A]
    79dd:487f  - pop       word ptr ss:[0F98]
    79dd:4884  - call      PRINTLASTFNAME
    79dd:4887  - push      ds
    79dd:4888    push      dx
    79dd:4889    mov       dx,8AC9
    79dd:488c    mov       ds,dx
    79dd:488e    mov       dx,89F8
    79dd:4891    call      far ptr _OS2PRTSTRING
    79dd:4896    pop       dx
    79dd:4897    pop       ds
    79dd:4898  - jmp       STOPASSEM
             I_CANTALLOC:
    79dd:489b  - mov       dx,7C3F
    79dd:489e    call      FATALERR_ROUT
    79dd:48a1  - jmp       STOPASSEM
             READMORESOURCE:
    79dd:48a4  - push      bp
    79dd:48a5  - mov       bx,word ptr [bp+02]
    79dd:48a8  - mov       cx,word ptr [bp+06]
    79dd:48ab  - mov       dx,word ptr [bp+08]
    79dd:48ae  - call      far ptr _OS2SEEKFILE
    79dd:48b3  - pop       bp
    79dd:48b4  - push      bp
    79dd:48b5  - mov       bx,word ptr [bp+02]
    79dd:48b8  - mov       cx,8000
    79dd:48bb  - mov       ds,word ptr [bp+10]
    79dd:48be  - mov       dx,word ptr [bp+12]
    79dd:48c1  - call      far ptr _OS2READBYTES
    79dd:48c6  - pop       bp
    79dd:48c7  - mov       word ptr [0EE4],ax
    79dd:48cb  - or        ax,ax
    79dd:48cd  - je        ENDFILE
    79dd:48cf  - cmp       ax,8000
    79dd:48d2  - je        _NOTEND
    79dd:48d4  - mov       byte ptr [bp+14],01
    79dd:48d8  - mov       si,word ptr ss:[0EE4]
    79dd:48dd  - add       si,word ptr [bp+12]
    79dd:48e0  - mov       byte ptr [si],0D
    79dd:48e3  - mov       byte ptr [si+01],0A
    79dd:48e7  - mov       byte ptr [si+02],1A
    79dd:48eb  - mov       si,word ptr ss:[0EE4]
    79dd:48f0  - jmp       _DONEEND
             _NOTEND:
    79dd:48f2  - mov       byte ptr [bp+14],04
    79dd:48f6  - mov       si,word ptr [bp+12]
    79dd:48f9  - add       si,7FFF
    79dd:48fd  - std
             I_LOOP:
    79dd:48fe  - lodsb
    79dd:48ff  - cmp       al,0D
    79dd:4901  - jne       I_LOOP
    79dd:4903  - cld
    79dd:4904  - inc       si
    79dd:4905  - inc       si
    79dd:4906  - mov       byte ptr [si],0A
    79dd:4909  - inc       si
    79dd:490a  - mov       byte ptr [si],1A
    79dd:490d  - sub       si,word ptr [bp+12]
             _DONEEND:
    79dd:4910  - add       word ptr [bp+08],si
    79dd:4913  - adc       word ptr [bp+06],00
    79dd:4917  - mov       ds,word ptr [bp+10]
    79dd:491a  - mov       si,word ptr [bp+12]
    79dd:491d  - mov       bx,76A7
    79dd:4920  - xor       al,al
    79dd:4922  - ret
             ENDFILE:
    79dd:4923  - mov       al,01
    79dd:4925  - or        al,al
    79dd:4927  - ret
             P_INC:
    79dd:4928  - dec       si
    79dd:4929  - call      GETEA
    79dd:492c    mov       al,byte ptr [si]
    79dd:492e    xlat
    79dd:4930    or        al,al
    79dd:4932    js        4937
    79dd:4934    jmp       E_EXTRACHARS
    79dd:4937    mov       ax,word ptr [bp+6FCB]
    79dd:493b    or        al,al
    79dd:493d    je        4947
    79dd:493f    stosb
    79dd:4940    mov       al,ah
    79dd:4942    xor       ah,ah
    79dd:4944    add       di,ax
    79dd:4946    ret
    79dd:4947    push      dx
    79dd:4948    mov       dx,7F7F
    79dd:494b    call      ERROR_ROUT
    79dd:494e    pop       dx
    79dd:494f    ret
             P_INA:
    79dd:4950  - mov       al,byte ptr [si]
    79dd:4952    xlat
    79dd:4954    or        al,al
    79dd:4956    js        495B
    79dd:4958    jmp       PM
    79dd:495b  - mov       al,1A
    79dd:495d    stosb
    79dd:495e  - ret
             P_INX:
    79dd:495f  - mov       al,byte ptr [si]
    79dd:4961    xlat
    79dd:4963    or        al,al
    79dd:4965    js        496A
    79dd:4967    jmp       PM
    79dd:496a  - mov       al,E8
    79dd:496c    stosb
    79dd:496d  - ret
             P_INY:
    79dd:496e  - mov       al,byte ptr [si]
    79dd:4970    xlat
    79dd:4972    or        al,al
    79dd:4974    js        4979
    79dd:4976    jmp       PM
    79dd:4979  - mov       al,C8
    79dd:497b    stosb
    79dd:497c  - ret
             P_JML:
    79dd:497d  - mov       al,byte ptr [si]
    79dd:497f    xlat
    79dd:4981    or        al,al
    79dd:4983    js        4988
    79dd:4985    jmp       PM
    79dd:4988  - lodsb
    79dd:4989    xlat
    79dd:498b    or        al,al
    79dd:498d    js        4988
    79dd:498f    dec       si
    79dd:4990  - mov       al,byte ptr [si]
    79dd:4992  - cmp       al,5B
    79dd:4994  - jne       4999
    79dd:4996    jmp       P_JMLSB
    79dd:4999  - call      CONVEXPRESS
    79dd:499c  - test      byte ptr ss:[0ACE],C0
    79dd:49a2    je        4A1A
    79dd:49a4    test      byte ptr ss:[0ACE],40
    79dd:49aa    jne       49D7
    79dd:49ac    push      es
    79dd:49ad    push      bp
    79dd:49ae    mov       es,word ptr ss:[0AC5]
    79dd:49b3    mov       bp,word ptr ss:[0AC9]
    79dd:49b8    mov       word ptr es:[bp+06],di
    79dd:49bc    mov       word ptr es:[bp+02],0004
    79dd:49c2    add       bp,15
    79dd:49c5    mov       word ptr ss:[0AC7],bp
    79dd:49ca    cmp       bp,7F00
    79dd:49ce    jb        49D3
    79dd:49d0    call      MOREFR
    79dd:49d3    pop       bp
    79dd:49d4    pop       es
    79dd:49d5    jmp       4A1A
    79dd:49d7    push      es
    79dd:49d8    push      bp
    79dd:49d9    push      cx
    79dd:49da    push      ax
    79dd:49db    mov       es,word ptr ss:[13A6]
    79dd:49e0    mov       bp,word ptr ss:[13A8]
    79dd:49e5    mov       ax,di
    79dd:49e7    sub       ax,word ptr ss:[13B4]
    79dd:49ec    xor       cx,cx
    79dd:49ee    add       ax,word ptr ss:[13BE]
    79dd:49f3    adc       cx,word ptr ss:[13BC]
    79dd:49f8    mov       word ptr es:[bp+00],ax
    79dd:49fc    mov       word ptr es:[bp+02],cx
    79dd:4a00    mov       byte ptr es:[bp+04],04
    79dd:4a05    add       bp,05
    79dd:4a08    mov       word ptr ss:[13A8],bp
    79dd:4a0d    cmp       bp,3F00
    79dd:4a11    jb        4A16
    79dd:4a13    call      MOREEXT
    79dd:4a16    pop       ax
    79dd:4a17    pop       cx
    79dd:4a18    pop       bp
    79dd:4a19    pop       es
    79dd:4a1a  - mov       al,5C
    79dd:4a1c  - stosb
    79dd:4a1d  - mov       word ptr es:[di],cx
    79dd:4a20  - mov       byte ptr es:[di+02],dl
    79dd:4a24  - add       di,03
    79dd:4a27  - ret
             P_JMLSB:
    79dd:4a28  - inc       si
    79dd:4a29  - call      CONVEXPRESS
    79dd:4a2c  - lodsb
    79dd:4a2d  - cmp       al,5D
    79dd:4a2f  - je        4A34
    79dd:4a31    jmp       P_JMLERR
    79dd:4a34  - test      byte ptr ss:[0ACE],C0
    79dd:4a3a    je        4AB2
    79dd:4a3c    test      byte ptr ss:[0ACE],40
    79dd:4a42    jne       4A6F
    79dd:4a44    push      es
    79dd:4a45    push      bp
    79dd:4a46    mov       es,word ptr ss:[0AC5]
    79dd:4a4b    mov       bp,word ptr ss:[0AC9]
    79dd:4a50    mov       word ptr es:[bp+06],di
    79dd:4a54    mov       word ptr es:[bp+02],0002
    79dd:4a5a    add       bp,15
    79dd:4a5d    mov       word ptr ss:[0AC7],bp
    79dd:4a62    cmp       bp,7F00
    79dd:4a66    jb        4A6B
    79dd:4a68    call      MOREFR
    79dd:4a6b    pop       bp
    79dd:4a6c    pop       es
    79dd:4a6d    jmp       4AB2
    79dd:4a6f    push      es
    79dd:4a70    push      bp
    79dd:4a71    push      cx
    79dd:4a72    push      ax
    79dd:4a73    mov       es,word ptr ss:[13A6]
    79dd:4a78    mov       bp,word ptr ss:[13A8]
    79dd:4a7d    mov       ax,di
    79dd:4a7f    sub       ax,word ptr ss:[13B4]
    79dd:4a84    xor       cx,cx
    79dd:4a86    add       ax,word ptr ss:[13BE]
    79dd:4a8b    adc       cx,word ptr ss:[13BC]
    79dd:4a90    mov       word ptr es:[bp+00],ax
    79dd:4a94    mov       word ptr es:[bp+02],cx
    79dd:4a98    mov       byte ptr es:[bp+04],02
    79dd:4a9d    add       bp,05
    79dd:4aa0    mov       word ptr ss:[13A8],bp
    79dd:4aa5    cmp       bp,3F00
    79dd:4aa9    jb        4AAE
    79dd:4aab    call      MOREEXT
    79dd:4aae    pop       ax
    79dd:4aaf    pop       cx
    79dd:4ab0    pop       bp
    79dd:4ab1    pop       es
    79dd:4ab2  - mov       al,DC
    79dd:4ab4  - stosb
    79dd:4ab5  - mov       ax,cx
    79dd:4ab7  - stosw
    79dd:4ab8  - ret
             P_JMLERR:
    79dd:4ab9  - push      dx
    79dd:4aba    mov       dx,8291
    79dd:4abd    call      ERROR_ROUT
    79dd:4ac0    pop       dx
             P_JMP:
    79dd:4ac1    cmp       byte ptr [si],2E
    79dd:4ac4  - je        TRYJMPDOTL
    79dd:4ac6  - mov       ax,word ptr [13F0]
    79dd:4aca  - mov       word ptr [0AB8],ax
    79dd:4ace  - call      GETEA
    79dd:4ad1    mov       al,byte ptr [si]
    79dd:4ad3    xlat
    79dd:4ad5    or        al,al
    79dd:4ad7    js        4ADC
    79dd:4ad9    jmp       E_EXTRACHARS
    79dd:4adc    mov       ax,word ptr [bp+7027]
    79dd:4ae0    or        al,al
    79dd:4ae2    je        4AEC
    79dd:4ae4    stosb
    79dd:4ae5    mov       al,ah
    79dd:4ae7    xor       ah,ah
    79dd:4ae9    add       di,ax
    79dd:4aeb    ret
    79dd:4aec    push      dx
    79dd:4aed    mov       dx,7F7F
    79dd:4af0    call      ERROR_ROUT
    79dd:4af3    pop       dx
    79dd:4af4    ret
             TRYJMPDOTL:
    79dd:4af5    inc       si
    79dd:4af6  - lodsb
    79dd:4af7  - and       al,DF
    79dd:4af9  - cmp       al,4C
    79dd:4afb  - jne       4B00
    79dd:4afd    jmp       P_JML
    79dd:4b00  - push      dx
    79dd:4b01    mov       dx,7F7F
    79dd:4b04    call      ERROR_ROUT
    79dd:4b07    pop       dx
             P_JSL:
    79dd:4b08  - mov       al,byte ptr [si]
    79dd:4b0a    xlat
    79dd:4b0c    or        al,al
    79dd:4b0e    js        4B13
    79dd:4b10    jmp       PM
    79dd:4b13  - lodsb
    79dd:4b14    xlat
    79dd:4b16    or        al,al
    79dd:4b18    js        4B13
    79dd:4b1a    dec       si
    79dd:4b1b  - call      CONVEXPRESS
    79dd:4b1e  - test      byte ptr ss:[0ACE],C0
    79dd:4b24    je        4B9C
    79dd:4b26    test      byte ptr ss:[0ACE],40
    79dd:4b2c    jne       4B59
    79dd:4b2e    push      es
    79dd:4b2f    push      bp
    79dd:4b30    mov       es,word ptr ss:[0AC5]
    79dd:4b35    mov       bp,word ptr ss:[0AC9]
    79dd:4b3a    mov       word ptr es:[bp+06],di
    79dd:4b3e    mov       word ptr es:[bp+02],0004
    79dd:4b44    add       bp,15
    79dd:4b47    mov       word ptr ss:[0AC7],bp
    79dd:4b4c    cmp       bp,7F00
    79dd:4b50    jb        4B55
    79dd:4b52    call      MOREFR
    79dd:4b55    pop       bp
    79dd:4b56    pop       es
    79dd:4b57    jmp       4B9C
    79dd:4b59    push      es
    79dd:4b5a    push      bp
    79dd:4b5b    push      cx
    79dd:4b5c    push      ax
    79dd:4b5d    mov       es,word ptr ss:[13A6]
    79dd:4b62    mov       bp,word ptr ss:[13A8]
    79dd:4b67    mov       ax,di
    79dd:4b69    sub       ax,word ptr ss:[13B4]
    79dd:4b6e    xor       cx,cx
    79dd:4b70    add       ax,word ptr ss:[13BE]
    79dd:4b75    adc       cx,word ptr ss:[13BC]
    79dd:4b7a    mov       word ptr es:[bp+00],ax
    79dd:4b7e    mov       word ptr es:[bp+02],cx
    79dd:4b82    mov       byte ptr es:[bp+04],04
    79dd:4b87    add       bp,05
    79dd:4b8a    mov       word ptr ss:[13A8],bp
    79dd:4b8f    cmp       bp,3F00
    79dd:4b93    jb        4B98
    79dd:4b95    call      MOREEXT
    79dd:4b98    pop       ax
    79dd:4b99    pop       cx
    79dd:4b9a    pop       bp
    79dd:4b9b    pop       es
    79dd:4b9c  - mov       al,22
    79dd:4b9e  - stosb
    79dd:4b9f  - mov       word ptr es:[di],cx
    79dd:4ba2  - mov       byte ptr es:[di+02],dl
    79dd:4ba6  - add       di,03
    79dd:4ba9  - ret
             P_JSR:
    79dd:4baa  - mov       ax,word ptr [13F0]
    79dd:4bae  - mov       word ptr [0AB8],ax
    79dd:4bb2  - call      GETEA
    79dd:4bb5    mov       al,byte ptr [si]
    79dd:4bb7    xlat
    79dd:4bb9    or        al,al
    79dd:4bbb    js        4BC0
    79dd:4bbd    jmp       E_EXTRACHARS
    79dd:4bc0    mov       ax,word ptr [bp+7055]
    79dd:4bc4    or        al,al
    79dd:4bc6    je        4BD0
    79dd:4bc8    stosb
    79dd:4bc9    mov       al,ah
    79dd:4bcb    xor       ah,ah
    79dd:4bcd    add       di,ax
    79dd:4bcf    ret
    79dd:4bd0    push      dx
    79dd:4bd1    mov       dx,7F7F
    79dd:4bd4    call      ERROR_ROUT
    79dd:4bd7    pop       dx
    79dd:4bd8    ret
             P_LOWER:
    79dd:4bd9  - lodsb
    79dd:4bda    xlat
    79dd:4bdc    or        al,al
    79dd:4bde    js        P_LOWER
    79dd:4be0    dec       si
    79dd:4be1  - call      GETSTRINGADDR
    79dd:4be4  - push      ds
    79dd:4be5  - push      si
    79dd:4be6  - mov       si,cx
    79dd:4be8  - mov       ds,dx
             LOLP:
    79dd:4bea  - lodsb
    79dd:4beb  - or        al,al
    79dd:4bed  - je        LOEXIT
    79dd:4bef  - cmp       al,41
    79dd:4bf1  - jb        LOLP
    79dd:4bf3  - cmp       al,5A
    79dd:4bf5  - ja        LOLP
    79dd:4bf7  - or        al,20
    79dd:4bf9  - mov       byte ptr [si+FF],al
    79dd:4bfc  - jmp       LOLP
             LOEXIT:
    79dd:4bfe  - pop       si
    79dd:4bff  - pop       ds
    79dd:4c00  - ret
             P_LIST:
    79dd:4c01  - lodsb
    79dd:4c02    xlat
    79dd:4c04    or        al,al
    79dd:4c06    js        P_LIST
    79dd:4c08    dec       si
    79dd:4c09  - cmp       byte ptr [si],0A
    79dd:4c0c  - je        P_LISTEND
    79dd:4c0e  - lodsw
    79dd:4c0f  - and       al,DF
    79dd:4c11  - cmp       ax,2B54
    79dd:4c14  - je        P_LISTTR
    79dd:4c16  - cmp       ax,2D54
    79dd:4c19  - je        P_LISTTROFF
    79dd:4c1b  - and       ah,DF
    79dd:4c1e  - cmp       ax,4E4F
    79dd:4c21  - je        P_LISTON
    79dd:4c23  - cmp       ax,464F
    79dd:4c26  - je        P_LISTOFF
    79dd:4c28  - cmp       ax,414D
    79dd:4c2b  - je        P_LISTMA
    79dd:4c2d  - dec       si
    79dd:4c2e  - push      dx
    79dd:4c2f    mov       dx,8078
    79dd:4c32    call      ERROR_ROUT
    79dd:4c35    pop       dx
             P_LISTEND:
    79dd:4c36    dec       si
    79dd:4c37  - ret
             P_LISTTR:
    79dd:4c38  - mov       byte ptr ss:[9BDC],01
    79dd:4c3e  - jmp       P_LIST
             P_LISTTROFF:
    79dd:4c40  - mov       byte ptr ss:[9BDC],00
    79dd:4c46  - jmp       P_LIST
             P_LISTMA:
    79dd:4c48  - lodsw
    79dd:4c49  - and       ax,DFDF
    79dd:4c4c  - cmp       ax,5243
    79dd:4c4f  - jne       P_UNKOPT
    79dd:4c51  - add       si,02
    79dd:4c54  - mov       byte ptr ss:[13EB],01
    79dd:4c5a  - jmp       P_LIST
             P_LISTON:
    79dd:4c5c  - or        byte ptr ss:[0F8B],04
    79dd:4c62  - jmp       P_LIST
             P_LISTOFF:
    79dd:4c64  - inc       si
    79dd:4c65  - and       byte ptr ss:[0F8B],FB
    79dd:4c6b  - mov       byte ptr ss:[13EB],00
    79dd:4c71  - jmp       P_LIST
             P_UNKOPT:
    79dd:4c73  - push      dx
    79dd:4c74    mov       dx,83C5
    79dd:4c77    call      ERROR_ROUT
    79dd:4c7a    pop       dx
             P_LOCAL:
    79dd:4c7b  - test      byte ptr ss:[0F8B],01
    79dd:4c81    jne       P_LOCSKIP
    79dd:4c83  - mov       bp,word ptr ss:[13F0]
    79dd:4c88    cmp       word ptr ss:[0F7A],bp
    79dd:4c8d    je        4C92
    79dd:4c8f    jmp       P_EQUERR
    79dd:4c92  - push      es
    79dd:4c93  - push      di
    79dd:4c94  - push      ds
    79dd:4c95  - push      si
    79dd:4c96  - mov       ds,word ptr ss:[0F80]
    79dd:4c9b  - mov       si,word ptr ss:[0F82]
    79dd:4ca0  - mov       ax,ss
    79dd:4ca2  - mov       es,ax
    79dd:4ca4  - mov       di,8A6E
             PLOLP:
    79dd:4ca7  - lodsb
    79dd:4ca8  - stosb
    79dd:4ca9  - or        al,al
    79dd:4cab  - jne       PLOLP
    79dd:4cad  - dec       di
    79dd:4cae  - mov       ds,word ptr ss:[9A88]
    79dd:4cb3  - mov       si,word ptr ss:[9A8A]
             PLOLP2:
    79dd:4cb8  - lodsb
    79dd:4cb9  - stosb
    79dd:4cba  - or        al,al
    79dd:4cbc  - jne       PLOLP2
    79dd:4cbe  - mov       al,09
    79dd:4cc0  - stosb
    79dd:4cc1  - mov       ax,ss
    79dd:4cc3  - mov       ds,ax
    79dd:4cc5  - mov       si,8A6E
    79dd:4cc8  - call      ADDSYMBOL
    79dd:4ccb  - mov       ax,word ptr [0F84]
    79dd:4ccf    mov       word ptr [0F80],ax
    79dd:4cd3    mov       ax,word ptr [0F86]
    79dd:4cd7    mov       word ptr [0F82],ax
    79dd:4cdb    mov       ax,word ptr [0F70]
    79dd:4cdf    mov       word ptr [0F6E],ax
    79dd:4ce3  - pop       si
    79dd:4ce4  - pop       ds
    79dd:4ce5  - pop       di
    79dd:4ce6  - pop       es
             P_LOCSKIP:
    79dd:4ce7  - ret
             P_LDA:
    79dd:4ce8  - mov       al,byte ptr [0ABA]
    79dd:4cec    test      al,01
    79dd:4cee    je        4CF8
    79dd:4cf0    mov       ax,word ptr [13F0]
    79dd:4cf4    mov       word ptr [0AB2],ax
    79dd:4cf8  - call      GETEA
    79dd:4cfb    mov       al,byte ptr [si]
    79dd:4cfd    xlat
    79dd:4cff    or        al,al
    79dd:4d01    js        4D06
    79dd:4d03    jmp       E_EXTRACHARS
    79dd:4d06    mov       ax,word ptr [bp+7083]
    79dd:4d0a    or        al,al
    79dd:4d0c    je        4D16
    79dd:4d0e    stosb
    79dd:4d0f    mov       al,ah
    79dd:4d11    xor       ah,ah
    79dd:4d13    add       di,ax
    79dd:4d15    ret
    79dd:4d16    push      dx
    79dd:4d17    mov       dx,7F7F
    79dd:4d1a    call      ERROR_ROUT
    79dd:4d1d    pop       dx
    79dd:4d1e    ret
             P_LDX:
    79dd:4d1f  - mov       al,byte ptr [0ABA]
    79dd:4d23    test      al,02
    79dd:4d25    je        4D2F
    79dd:4d27    mov       ax,word ptr [13F0]
    79dd:4d2b    mov       word ptr [0AB2],ax
    79dd:4d2f  - call      GETEA
    79dd:4d32    mov       al,byte ptr [si]
    79dd:4d34    xlat
    79dd:4d36    or        al,al
    79dd:4d38    js        4D3D
    79dd:4d3a    jmp       E_EXTRACHARS
    79dd:4d3d    mov       ax,word ptr [bp+70B1]
    79dd:4d41    or        al,al
    79dd:4d43    je        4D4D
    79dd:4d45    stosb
    79dd:4d46    mov       al,ah
    79dd:4d48    xor       ah,ah
    79dd:4d4a    add       di,ax
    79dd:4d4c    ret
    79dd:4d4d    push      dx
    79dd:4d4e    mov       dx,7F7F
    79dd:4d51    call      ERROR_ROUT
    79dd:4d54    pop       dx
    79dd:4d55    ret
             P_LDY:
    79dd:4d56  - mov       al,byte ptr [0ABA]
    79dd:4d5a    test      al,02
    79dd:4d5c    je        4D66
    79dd:4d5e    mov       ax,word ptr [13F0]
    79dd:4d62    mov       word ptr [0AB2],ax
    79dd:4d66  - call      GETEA
    79dd:4d69    mov       al,byte ptr [si]
    79dd:4d6b    xlat
    79dd:4d6d    or        al,al
    79dd:4d6f    js        4D74
    79dd:4d71    jmp       E_EXTRACHARS
    79dd:4d74    mov       ax,word ptr [bp+70DF]
    79dd:4d78    or        al,al
    79dd:4d7a    je        4D84
    79dd:4d7c    stosb
    79dd:4d7d    mov       al,ah
    79dd:4d7f    xor       ah,ah
    79dd:4d81    add       di,ax
    79dd:4d83    ret
    79dd:4d84    push      dx
    79dd:4d85    mov       dx,7F7F
    79dd:4d88    call      ERROR_ROUT
    79dd:4d8b    pop       dx
    79dd:4d8c    ret
             P_LONGA:
    79dd:4d8d  - mov       al,byte ptr [si]
    79dd:4d8f    xlat
    79dd:4d91    or        al,al
    79dd:4d93    js        4D98
    79dd:4d95    jmp       PM
    79dd:4d98  - call      MAP_LONGA
    79dd:4d9b  - or        byte ptr ss:[0ABA],01
    79dd:4da1  - push      es
    79dd:4da2  - mov       es,word ptr ss:[0AC1]
    79dd:4da7  - mov       bp,word ptr ss:[0AC3]
    79dd:4dac  - mov       word ptr es:[bp+0A],FFFF
    79dd:4db2  - mov       word ptr es:[bp+0C],FFFF
    79dd:4db8  - pop       es
    79dd:4db9  - ret
             P_LONGI:
    79dd:4dba  - mov       al,byte ptr [si]
    79dd:4dbc    xlat
    79dd:4dbe    or        al,al
    79dd:4dc0    js        4DC5
    79dd:4dc2    jmp       PM
    79dd:4dc5  - call      MAP_LONGI
    79dd:4dc8  - or        byte ptr ss:[0ABA],02
    79dd:4dce  - push      es
    79dd:4dcf  - mov       es,word ptr ss:[0ABD]
    79dd:4dd4  - mov       bp,word ptr ss:[0ABF]
    79dd:4dd9  - mov       word ptr es:[bp+0A],FFFF
    79dd:4ddf  - mov       word ptr es:[bp+0C],FFFF
    79dd:4de5  - pop       es
    79dd:4de6  - ret
             P_LSR:
    79dd:4de7  - call      GETEA
    79dd:4dea    mov       al,byte ptr [si]
    79dd:4dec    xlat
    79dd:4dee    or        al,al
    79dd:4df0    js        4DF5
    79dd:4df2    jmp       E_EXTRACHARS
    79dd:4df5    mov       ax,word ptr [bp+710D]
    79dd:4df9    or        al,al
    79dd:4dfb    je        4E05
    79dd:4dfd    stosb
    79dd:4dfe    mov       al,ah
    79dd:4e00    xor       ah,ah
    79dd:4e02    add       di,ax
    79dd:4e04    ret
    79dd:4e05    push      dx
    79dd:4e06    mov       dx,7F7F
    79dd:4e09    call      ERROR_ROUT
    79dd:4e0c    pop       dx
    79dd:4e0d    ret
             P_MARIO:
    79dd:4e0e  - lodsb
    79dd:4e0f    xlat
    79dd:4e11    or        al,al
    79dd:4e13    js        P_MARIO
    79dd:4e15    dec       si
    79dd:4e16  - lodsw
    79dd:4e17  - and       ax,DFDF
    79dd:4e1a  - cmp       ax,4E4F
    79dd:4e1d  - je        P_MARIOON
    79dd:4e1f  - cmp       ax,464F
    79dd:4e22  - je        P_MARIOOFF
    79dd:4e24  - dec       si
    79dd:4e25  - push      dx
    79dd:4e26    mov       dx,8078
    79dd:4e29    call      ERROR_ROUT
    79dd:4e2c    pop       dx
             P_MARIOON:
    79dd:4e2d    mov       byte ptr ss:[0F8D],01
    79dd:4e33  - pop       ax
    79dd:4e34  - jmp       GOTEOLDO_MARIO
             P_MARIOOFF:
    79dd:4e37  - mov       byte ptr ss:[0F8D],00
    79dd:4e3d  - pop       ax
    79dd:4e3e  - jmp       GOTEOLDO_65816
             P_ENDM:
    79dd:4e41  - push      dx
    79dd:4e42    mov       dx,82D8
    79dd:4e45    call      ERROR_ROUT
    79dd:4e48    pop       dx
             P_MEXIT:
    79dd:4e49    cmp       word ptr ss:[0AA6],00
    79dd:4e4f  - je        P_MEXITERR
    79dd:4e51  - mov       ax,ss
    79dd:4e53  - mov       ds,ax
    79dd:4e55  - mov       si,254F
    79dd:4e58  - mov       bp,word ptr ss:[0F9C]
    79dd:4e5d  - sub       bp,1F
    79dd:4e60  - mov       ax,word ptr [bp+04]
    79dd:4e63  - mov       word ptr [0F96],ax
    79dd:4e67  - mov       ax,word ptr [bp+00]
    79dd:4e6a  - mov       word ptr [1470],ax
    79dd:4e6e  - ret
             P_MEXITERR:
    79dd:4e6f  - push      dx
    79dd:4e70    mov       dx,8241
    79dd:4e73    call      ERROR_ROUT
    79dd:4e76    pop       dx
             P_MACRO:
    79dd:4e77    test      byte ptr ss:[0F8B],06
    79dd:4e7d  - je        PMNOLIST
    79dd:4e7f  - call      LISTLINE
             PMNOLIST:
    79dd:4e82  - mov       ah,0D
             PMPARLP:
    79dd:4e84  - lodsb
    79dd:4e85  - cmp       ah,al
    79dd:4e87  - je        PMGOT1CR
    79dd:4e89  - cmp       al,09
    79dd:4e8b  - je        PMPARLP
    79dd:4e8d  - cmp       al,20
    79dd:4e8f  - je        PMPARLP
    79dd:4e91  - cmp       al,3B
    79dd:4e93  - je        PMCOMM
    79dd:4e95  - cmp       al,2A
    79dd:4e97  - je        PMCOMM
    79dd:4e99  - cmp       al,5B
    79dd:4e9b  - jne       PMCOMM
    79dd:4e9d  - push      es
    79dd:4e9e  - push      di
    79dd:4e9f  - mov       ax,ss
    79dd:4ea1  - mov       es,ax
    79dd:4ea3  - mov       bp,0A0E
    79dd:4ea6  - mov       di,020E
             PMPLP2:
    79dd:4ea9  - mov       word ptr es:[bp+00],di
    79dd:4ead  - xor       cx,cx
             PMPLP:
    79dd:4eaf  - lodsb
    79dd:4eb0  - stosb
    79dd:4eb1  - inc       cx
    79dd:4eb2  - cmp       al,2C
    79dd:4eb4  - je        PMPNEXTPAR
    79dd:4eb6  - cmp       al,5D
    79dd:4eb8  - je        PMPEND
    79dd:4eba  - cmp       al,0D
    79dd:4ebc  - jne       PMPLP
    79dd:4ebe  - pop       di
    79dd:4ebf  - pop       es
    79dd:4ec0  - push      dx
    79dd:4ec1    mov       dx,8291
    79dd:4ec4    call      ERROR_ROUT
    79dd:4ec7    pop       dx
             PMPNEXTPAR:
    79dd:4ec8    dec       cx
    79dd:4ec9  - mov       word ptr es:[bp+02],cx
    79dd:4ecd  - dec       di
    79dd:4ece  - add       bp,04
    79dd:4ed1  - cmp       bp,0090
    79dd:4ed5  - cmp       bp,24
    79dd:4ed8  - jae       PMPLP2
    79dd:4eda  - pop       di
    79dd:4edb  - pop       es
    79dd:4edc  - push      dx
    79dd:4edd    mov       dx,8059
    79dd:4ee0    call      ERROR_ROUT
    79dd:4ee3    pop       dx
             PMPEND:
    79dd:4ee4    dec       cx
    79dd:4ee5  - mov       word ptr es:[bp+02],cx
    79dd:4ee9  - add       bp,08
    79dd:4eec  - mov       word ptr ss:[0AA8],bp
    79dd:4ef1  - pop       di
    79dd:4ef2  - pop       es
    79dd:4ef3  - mov       ah,0D
             PMCOMM:
    79dd:4ef5  - lodsb
    79dd:4ef6  - cmp       ah,al
    79dd:4ef8  - jne       PMCOMM
             PMGOT1CR:
    79dd:4efa  - inc       si
    79dd:4efb  - inc       word ptr ss:[13F0]
    79dd:4f00  - push      si
    79dd:4f01  - mov       bp,word ptr ss:[13F0]
    79dd:4f06  - dec       bp
    79dd:4f07  - cmp       word ptr ss:[0F7A],bp
    79dd:4f0c  - je        4F11
    79dd:4f0e    jmp       PM_ADD
    79dd:4f11  - push      es
    79dd:4f12  - push      di
    79dd:4f13  - mov       es,word ptr ss:[0F7C]
    79dd:4f18  - mov       di,word ptr ss:[0F7E]
    79dd:4f1d  - mov       al,byte ptr [0AAA]
    79dd:4f21  - or        al,al
    79dd:4f23  - je        NONEEDCHK
    79dd:4f25  - push      ds
    79dd:4f26  - push      si
    79dd:4f27  - mov       ax,word ptr es:[di+06]
    79dd:4f2b  - mov       si,word ptr es:[di+08]
    79dd:4f2f  - mov       ds,ax
    79dd:4f31  - call      GETMACRO
    79dd:4f34  - pop       si
    79dd:4f35  - pop       ds
    79dd:4f36  - mov       bp,word ptr ss:[13F0]
    79dd:4f3b  - cmp       bp,word ptr ss:[0AAC]
    79dd:4f40  - je        NONEEDCHK
    79dd:4f42  - sub       si,0A
    79dd:4f45  - push      es
    79dd:4f46  - push      di
    79dd:4f47  - push      ds
    79dd:4f48  - push      si
    79dd:4f49  - push      ds
    79dd:4f4a    push      dx
    79dd:4f4b    mov       dx,8AC9
    79dd:4f4e    mov       ds,dx
    79dd:4f50    mov       dx,7FD5
    79dd:4f53    call      far ptr _OS2PRTSTRING
    79dd:4f58    pop       dx
    79dd:4f59    pop       ds
    79dd:4f5a  - push      ds
    79dd:4f5b    push      dx
    79dd:4f5c    push      si
    79dd:4f5d    push      ax
    79dd:4f5e    mov       bx,word ptr es:[di+06]
    79dd:4f62    mov       dx,word ptr es:[di+08]
    79dd:4f66    mov       ds,bx
    79dd:4f68    mov       si,dx
    79dd:4f6a    lodsb
    79dd:4f6b    or        al,al
    79dd:4f6d    jne       4F6A
    79dd:4f6f    mov       byte ptr [si+FF],24
    79dd:4f73    call      far ptr _OS2PRTSTRING
    79dd:4f78    mov       byte ptr [si+FF],00
    79dd:4f7c    pop       ax
    79dd:4f7d    pop       si
    79dd:4f7e    pop       dx
    79dd:4f7f    pop       ds
    79dd:4f80  - push      ds
    79dd:4f81    push      dx
    79dd:4f82    mov       dx,8AC9
    79dd:4f85    mov       ds,dx
    79dd:4f87    mov       dx,2552
    79dd:4f8a    call      far ptr _OS2PRTSTRING
    79dd:4f8f    pop       dx
    79dd:4f90    pop       ds
    79dd:4f91  - pop       si
    79dd:4f92  - pop       ds
    79dd:4f93  - pop       di
    79dd:4f94  - pop       es
    79dd:4f95  - push      dx
    79dd:4f96    mov       dx,7FC0
    79dd:4f99    call      ERROR_ROUT
    79dd:4f9c    pop       dx
             NONEEDCHK:
    79dd:4f9d  - xor       ax,ax
    79dd:4f9f  - mov       word ptr es:[di],ax
    79dd:4fa2  - mov       word ptr es:[di+02],ax
    79dd:4fa6  - mov       ax,word ptr [0AA2]
    79dd:4faa  - mov       word ptr es:[di+0A],ax
    79dd:4fae  - mov       ax,word ptr [0AA4]
    79dd:4fb2  - mov       word ptr es:[di+0C],ax
    79dd:4fb6  - mov       byte ptr es:[di+04],02
    79dd:4fbb  - pop       di
    79dd:4fbc  - pop       es
    79dd:4fbd  - jmp       PM_ADDED
             PM_ADD:
    79dd:4fbf  - std
             PMADDLP:
    79dd:4fc0  - lodsb
    79dd:4fc1  - cmp       al,0A
    79dd:4fc3  - jne       PMADDLP
             PMADDLP2:
    79dd:4fc5  - lodsb
    79dd:4fc6  - cmp       al,0A
    79dd:4fc8  - jne       PMADDLP2
    79dd:4fca  - inc       si
    79dd:4fcb  - inc       si
    79dd:4fcc  - cld
    79dd:4fcd  - call      ADDMACRO
             PM_ADDED:
    79dd:4fd0  - and       byte ptr ss:[0F8B],FE
    79dd:4fd6  - pop       si
    79dd:4fd7  - push      es
    79dd:4fd8  - push      di
    79dd:4fd9  - mov       es,word ptr ss:[0AA2]
    79dd:4fde  - mov       di,word ptr ss:[0AA4]
    79dd:4fe3  - mov       ax,0A0D
    79dd:4fe6  - stosw
             COPYMAC:
    79dd:4fe7  - lodsb
    79dd:4fe8  - cmp       al,1A
    79dd:4fea  - jne       4FEF
    79dd:4fec    jmp       MAC_MORE
    79dd:4fef  - cmp       al,0D
    79dd:4ff1  - je        MACEOL
    79dd:4ff3  - mov       bx,78A9
    79dd:4ff6  - xlat
    79dd:4ff8  - mov       bx,76A7
    79dd:4ffb  - or        al,al
    79dd:4ffd  - js        MACWHITE
    79dd:4fff  - cmp       al,3B
    79dd:5001  - je        MACGOTOEOL
    79dd:5003  - cmp       al,2A
    79dd:5005  - je        MACGOTOEOL
    79dd:5007  - stosb
    79dd:5008  - cmp       al,7B
    79dd:500a    jne       MACSYM
    79dd:500c    call      P_CHKMACPAR
             MACSYM:
    79dd:500f    lodsb
    79dd:5010  - stosb
    79dd:5011  - cmp       al,7B
    79dd:5013    jne       5018
    79dd:5015    call      P_CHKMACPAR
    79dd:5018  - xlat
    79dd:501a  - or        al,al
    79dd:501c  - jns       MACSYM
    79dd:501e  - dec       di
    79dd:501f  - mov       al,byte ptr [si+FF]
    79dd:5022  - cmp       al,0D
    79dd:5024  - je        MACEOL
    79dd:5026  - cmp       al,3B
    79dd:5028  - je        MACGOTOEOL
    79dd:502a  - cmp       al,2A
    79dd:502c  - je        MACGOTOEOL
             MACWHITE:
    79dd:502e  - lodsb
    79dd:502f  - cmp       al,0D
    79dd:5031  - je        MACEOL
    79dd:5033  - xlat
    79dd:5035  - or        al,al
    79dd:5037  - js        MACWHITE
    79dd:5039  - mov       al,09
    79dd:503b  - stosb
    79dd:503c  - cmp       al,7B
    79dd:503e    jne       5043
    79dd:5040    call      P_CHKMACPAR
    79dd:5043  - dec       si
    79dd:5044  - lodsb
    79dd:5045  - stosb
    79dd:5046  - cmp       al,7B
    79dd:5048    jne       504D
    79dd:504a    call      P_CHKMACPAR
    79dd:504d  - and       al,DF
    79dd:504f  - cmp       al,45
    79dd:5051  - je        TRYENDM
             MAC_STORE:
    79dd:5053  - lodsb
             MACEOL:
    79dd:5054  - stosb
    79dd:5055  - cmp       al,7B
    79dd:5057    jne       505C
    79dd:5059    call      P_CHKMACPAR
    79dd:505c  - cmp       al,0D
    79dd:505e  - jne       MAC_STORE
    79dd:5060  - lodsb
    79dd:5061  - stosb
    79dd:5062  - cmp       al,7B
    79dd:5064    jne       MACEOL2
    79dd:5066    call      P_CHKMACPAR
             MACEOL2:
    79dd:5069    test      byte ptr ss:[0F8B],04
    79dd:506f  - jne       MACLL
             MACLLRET:
    79dd:5071  - cmp       di,7F80
    79dd:5075  - jbe       OUTMACRET
    79dd:5077    jmp       ERR_OUTMACSPACE
             OUTMACRET:
    79dd:507a  - inc       word ptr ss:[13F0]
    79dd:507a  - inc       word ptr ss:[13F0]
    79dd:507f  - jmp       COPYMAC
             MACGOTOEOL:
    79dd:5082  - lodsb
    79dd:5083  - cmp       al,0D
    79dd:5085  - jne       MACGOTOEOL
    79dd:5087  - inc       si
    79dd:5088  - jmp       MACEOL2
             MACLL:
    79dd:508a  - dec       si
    79dd:508b  - dec       si
    79dd:508c  - push      di
    79dd:508d  - mov       di,word ptr ss:[0F90]
    79dd:5092  - call      LISTLINE
    79dd:5095  - pop       di
    79dd:5096  - inc       si
    79dd:5097  - inc       si
    79dd:5098  - jmp       MACLLRET
             TRYENDM:
    79dd:509a  - lodsb
    79dd:509b  - stosb
    79dd:509c  - cmp       al,7B
    79dd:509e    jne       50A3
    79dd:50a0    call      P_CHKMACPAR
    79dd:50a3  - mov       dl,al
    79dd:50a5  - and       dl,DF
    79dd:50a8  - cmp       dl,4E
    79dd:50ab  - jne       MAC_STORE
    79dd:50ad  - lodsb
    79dd:50ae  - stosb
    79dd:50af  - cmp       al,7B
    79dd:50b1    jne       50B6
    79dd:50b3    call      P_CHKMACPAR
    79dd:50b6  - mov       dl,al
    79dd:50b8  - and       dl,DF
    79dd:50bb  - cmp       dl,44
    79dd:50be  - jne       MAC_STORE
    79dd:50c0  - lodsb
    79dd:50c1  - stosb
    79dd:50c2  - cmp       al,7B
    79dd:50c4    jne       50C9
    79dd:50c6    call      P_CHKMACPAR
    79dd:50c9  - mov       dl,al
    79dd:50cb  - and       dl,DF
    79dd:50ce  - cmp       dl,4D
    79dd:50d1  - jne       MAC_STORE
    79dd:50d3  - lodsb
    79dd:50d4  - stosb
    79dd:50d5  - cmp       al,7B
    79dd:50d7    jne       50DC
    79dd:50d9    call      P_CHKMACPAR
    79dd:50dc  - xlat
    79dd:50de  - or        al,al
    79dd:50e0  - js        50E5
    79dd:50e2    jmp       MAC_STORE
    79dd:50e5  - sub       di,06
    79dd:50e8  - mov       al,5C
    79dd:50ea  - stosb
    79dd:50eb  - xor       al,al
    79dd:50ed  - stosb
    79dd:50ee  - dec       si
    79dd:50ef  - mov       word ptr ss:[0AA4],di
    79dd:50f4  - pop       di
    79dd:50f5  - pop       es
    79dd:50f6  - ret
             P_CHKMACPAR:
    79dd:50f7  - cmp       byte ptr [si],7B
    79dd:50fa  - jne       CHKOK
    79dd:50fc  - lodsb
    79dd:50fd  - stosb
    79dd:50fe  - ret
             CHKOK:
    79dd:50ff  - dec       di
    79dd:5100  - push      ax
    79dd:5101  - push      es
    79dd:5102  - push      di
    79dd:5103  - mov       word ptr ss:[9A7C],ds
    79dd:5108  - mov       word ptr ss:[9A7E],si
    79dd:510d  - mov       ax,ss
    79dd:510f  - mov       es,ax
    79dd:5111  - mov       bp,0A0E
    79dd:5114  - mov       dx,0031
             CHKLP:
    79dd:5117  - mov       di,word ptr es:[bp+00]
    79dd:511b  - mov       cx,word ptr es:[bp+02]
    79dd:511f  - add       bp,04
    79dd:5122  - cmp       bp,word ptr ss:[0AA8]
    79dd:5127  - jb        CHKTRY
    79dd:5129  - pop       di
    79dd:512a  - pop       es
    79dd:512b  - pop       ax
    79dd:512c  - push      dx
    79dd:512d    mov       dx,8091
    79dd:5130    call      ERROR_ROUT
    79dd:5133    pop       dx
             CHKTRY:
    79dd:5134    mov       ds,word ptr ss:[9A7C]
    79dd:5139  - mov       si,word ptr ss:[9A7E]
             CHKLP2:
    79dd:513e  - lodsb
    79dd:513f  - cmp       byte ptr es:[di],al
    79dd:5142  - jne       CHKNEXT
    79dd:5144  - inc       di
    79dd:5145  - dec       cx
    79dd:5146  - jne       CHKLP2
    79dd:5148  - mov       al,byte ptr [si]
    79dd:514a  - cmp       al,7D
    79dd:514c  - je        CHKGOT
    79dd:514e  - xlat
    79dd:5150  - or        al,al
    79dd:5152  - js        CHKGOT2
             CHKNEXT:
    79dd:5154  - inc       dx
    79dd:5155  - cmp       dx,3A
    79dd:5158  - jne       CHKLP
    79dd:515a  - mov       dx,0041
    79dd:515d  - jmp       CHKLP
             CHKGOT:
    79dd:515f  - inc       si
             CHKGOT2:
    79dd:5160  - pop       di
    79dd:5161  - pop       es
    79dd:5162  - mov       al,5C
    79dd:5164  - mov       ah,dl
    79dd:5166  - stosw
    79dd:5167  - pop       ax
    79dd:5168  - ret
             ERR_OUTMACSPACE:
    79dd:5169  - mov       ax,7F5C
    79dd:516c  - stosw
    79dd:516d  - mov       bx,0801
    79dd:5170  - call      far ptr _OS2ALLOCSEG
    79dd:5175  - jb        MOREMAC
    79dd:5177  - mov       word ptr es:[di],ax
    79dd:517a  - mov       word ptr [0AA2],ax
    79dd:517e  - mov       es,ax
    79dd:5180  - xor       di,di
    79dd:5182  - mov       bx,76A7
    79dd:5185  - jmp       OUTMACRET
             MOREMAC:
    79dd:5188  - mov       dx,82B5
    79dd:518b    call      FATALERR_ROUT
    79dd:518e  - jmp       STOPASSEM
             MAC_MORE:
    79dd:5191    push      bp
    79dd:5192  - mov       bp,word ptr ss:[0F9C]
    79dd:5197  - call      READMORESOURCE
    79dd:519a  - jne       MAC_NOENDM
    79dd:519c  - pop       bp
    79dd:519d  - jmp       COPYMAC
             MAC_NOENDM:
    79dd:51a0  - mov       dx,804B
    79dd:51a3    call      FATALERR_ROUT
    79dd:51a6  - jmp       STOPASSEM
             P_MVN:
    79dd:51a9  - mov       al,byte ptr [si]
    79dd:51ab    xlat
    79dd:51ad    or        al,al
    79dd:51af    js        51B4
    79dd:51b1    jmp       PM
    79dd:51b4  - mov       byte ptr es:[di],54
    79dd:51b8  - jmp       P_MVM
             P_MVP:
    79dd:51ba  - mov       al,byte ptr [si]
    79dd:51bc    xlat
    79dd:51be    or        al,al
    79dd:51c0    js        51C5
    79dd:51c2    jmp       PM
    79dd:51c5  - mov       byte ptr es:[di],44
             P_MVM:
    79dd:51c9  - call      CONVEXPRESS
    79dd:51cc  - test      byte ptr ss:[0ACE],C0
    79dd:51d2  - je        51D7
    79dd:51d4    jmp       P_EQUERR2
    79dd:51d7  - mov       byte ptr es:[di+01],dl
    79dd:51db  - lodsb
    79dd:51dc  - cmp       al,2C
    79dd:51de  - je        E_BADSEP
    79dd:51e0  - call      CONVEXPRESS
    79dd:51e3  - test      byte ptr ss:[0ACE],C0
    79dd:51e9  - je        51EE
    79dd:51eb    jmp       P_EQUERR2
    79dd:51ee  - mov       byte ptr es:[di+02],dl
    79dd:51f2  - add       di,03
    79dd:51f5  - ret
             E_BADSEP:
    79dd:51f6  - push      dx
    79dd:51f7    mov       dx,8276
    79dd:51fa    call      ERROR_ROUT
    79dd:51fd    pop       dx
             P_NOP:
    79dd:51fe  - mov       al,EA
    79dd:5200    stosb
    79dd:5201  - ret
             P_ORA:
    79dd:5202  - mov       al,byte ptr [0ABA]
    79dd:5206    test      al,01
    79dd:5208    je        5212
    79dd:520a    mov       ax,word ptr [13F0]
    79dd:520e    mov       word ptr [0AB2],ax
    79dd:5212  - call      GETEA
    79dd:5215    mov       al,byte ptr [si]
    79dd:5217    xlat
    79dd:5219    or        al,al
    79dd:521b    js        5220
    79dd:521d    jmp       E_EXTRACHARS
    79dd:5220    mov       ax,word ptr [bp+713B]
    79dd:5224    or        al,al
    79dd:5226    je        5230
    79dd:5228    stosb
    79dd:5229    mov       al,ah
    79dd:522b    xor       ah,ah
    79dd:522d    add       di,ax
    79dd:522f    ret
    79dd:5230    push      dx
    79dd:5231    mov       dx,7F7F
    79dd:5234    call      ERROR_ROUT
    79dd:5237    pop       dx
    79dd:5238    ret
             M_ORG:
    79dd:5239  - mov       al,byte ptr [si]
    79dd:523b    xlat
    79dd:523d    or        al,al
    79dd:523f    js        P_ORG
    79dd:5241    jmp       PM
             P_ORG:
    79dd:5244  - lodsb
    79dd:5245    xlat
    79dd:5247    or        al,al
    79dd:5249    js        P_ORG
    79dd:524b    dec       si
    79dd:524c  - call      SPLITOBJBUF
    79dd:524f  - call      CONVEXPRESS
    79dd:5252  - test      byte ptr ss:[0ACE],C0
    79dd:5258  - je        525D
    79dd:525a    jmp       P_EQUERR2
    79dd:525d  - mov       word ptr ss:[0F92],dx
    79dd:5262  - mov       word ptr ss:[0F94],cx
    79dd:5267  - inc       si
    79dd:5268  - call      CONVEXPRESS
    79dd:526b  - test      byte ptr ss:[0ACE],C0
    79dd:5271  - je        5276
    79dd:5273    jmp       P_EQUERR2
    79dd:5276  - mov       word ptr ss:[13BC],dx
    79dd:527b  - mov       word ptr ss:[13BE],cx
    79dd:5280  - mov       word ptr es:[di+0C],dx
    79dd:5284  - mov       word ptr es:[di+0E],cx
    79dd:5288  - mov       byte ptr es:[di+10],01
    79dd:528d  - mov       al,byte ptr [13BA]
    79dd:5291  - or        byte ptr es:[di+10],al
    79dd:5295  - mov       es,word ptr ss:[13B6]
    79dd:529a  - mov       di,word ptr ss:[13B8]
    79dd:529f  - add       di,13
    79dd:52a2  - mov       word ptr ss:[13B4],di
    79dd:52a7  - mov       word ptr ss:[0F8E],es
    79dd:52ac  - mov       word ptr ss:[0F90],di
    79dd:52b1  - ret
             SPLITOBJBUF:
    79dd:52b2  - cmp       word ptr ss:[13B4],di
    79dd:52b7  - je        NOSPLIT
    79dd:52b9  - call      CALCLENLASTBLK
    79dd:52bc  - mov       es,word ptr ss:[13B6]
    79dd:52c1  - mov       bp,word ptr ss:[13B8]
    79dd:52c6  - mov       word ptr es:[bp+06],dx
    79dd:52ca  - mov       word ptr es:[bp+04],ax
    79dd:52ce  - mov       word ptr es:[bp+00],es
    79dd:52d2  - mov       word ptr es:[bp+02],di
    79dd:52d6  - mov       word ptr ss:[13B6],es
    79dd:52db  - mov       word ptr ss:[13B8],di
    79dd:52e0  - xor       ax,ax
    79dd:52e2  - push      di
    79dd:52e3  - mov       cx,0013
             CLROBJ2:
    79dd:52e6  - stosb
    79dd:52e7  - dec       cx
    79dd:52e8  - jne       CLROBJ2
    79dd:52ea  - pop       di
    79dd:52eb  - ret
             NOSPLIT:
    79dd:52ec  - mov       es,word ptr ss:[13B6]
    79dd:52f1  - mov       di,word ptr ss:[13B8]
    79dd:52f6  - xor       ax,ax
    79dd:52f8  - mov       word ptr [13C0],ax
    79dd:52fc  - mov       word ptr [13C2],ax
    79dd:5300  - ret
             CALCLENLASTBLK:
    79dd:5301  - xor       ax,ax
    79dd:5303  - mov       dx,di
    79dd:5305  - sub       dx,word ptr ss:[13B4]
    79dd:530a  - mov       word ptr ss:[13C2],dx
    79dd:530f  - mov       word ptr [13C0],ax
    79dd:5313  - ret
             CALCROMPOS:
    79dd:5314  - mov       ax,word ptr [13BC]
    79dd:5318  - mov       cx,word ptr ss:[13BE]
    79dd:531d  - add       cx,word ptr ss:[13C2]
    79dd:5322  - adc       ax,word ptr ss:[13C0]
    79dd:5327  - mov       word ptr [13BC],ax
    79dd:532b  - mov       word ptr ss:[13BE],cx
    79dd:5330  - ret
             P_OUTPUT:
    79dd:5331  - lodsb
    79dd:5332    xlat
    79dd:5334    or        al,al
    79dd:5336    js        P_OUTPUT
    79dd:5338    dec       si
    79dd:5339  - mov       ax,word ptr [si]
    79dd:533b  - and       ax,DFDF
    79dd:533e  - cmp       ax,464F
    79dd:5341  - je        OUTPUTOFF
             NOTOFF:
    79dd:5343  - call      COPYNAMENID
    79dd:5346  - mov       ax,word ptr [9A7C]
    79dd:534a  - mov       word ptr [249C],ax
    79dd:534e  - mov       ax,word ptr [9A7E]
    79dd:5352  - mov       word ptr [249E],ax
    79dd:5356  - mov       byte ptr ss:[2498],01
    79dd:535c  - mov       byte ptr ss:[2499],04
    79dd:5362  - ret
             OUTPUTOFF:
    79dd:5363  - mov       al,byte ptr [si+02]
    79dd:5366  - and       al,DF
    79dd:5368  - cmp       al,46
    79dd:536a  - jne       NOTOFF
    79dd:536c  - mov       al,byte ptr [si+03]
    79dd:536f  - xlat
    79dd:5371  - or        al,al
    79dd:5373  - jns       NOTOFF
    79dd:5375  - mov       byte ptr ss:[2499],00
    79dd:537b  - ret
             COPYNAMENID:
    79dd:537c  - push      di
    79dd:537d  - push      es
    79dd:537e  - mov       es,word ptr ss:[0ED9]
    79dd:5383  - mov       di,word ptr ss:[0EDB]
    79dd:5388  - mov       word ptr ss:[9A7C],es
    79dd:538d  - mov       word ptr ss:[9A7E],di
    79dd:5392  - mov       bx,7929
             OULOOP:
    79dd:5395  - lodsb
    79dd:5396  - stosb
    79dd:5397  - xlat
    79dd:5399  - or        al,al
    79dd:539b  - jns       OULOOP
    79dd:539d  - mov       byte ptr es:[di+FF],00
    79dd:53a2  - mov       bx,76A7
    79dd:53a5  - dec       si
    79dd:53a6  - mov       word ptr ss:[0EDB],di
    79dd:53ab  - cmp       di,1F00
    79dd:53af    jb        53B4
    79dd:53b1    call      MOREHEAP
    79dd:53b4  - pop       es
    79dd:53b5  - pop       di
    79dd:53b6  - ret
             COPYFNAME:
    79dd:53b7  - push      di
    79dd:53b8  - push      es
    79dd:53b9  - mov       es,word ptr ss:[0ED9]
    79dd:53be  - mov       di,word ptr ss:[0EDB]
    79dd:53c3  - mov       word ptr ss:[9A7C],es
    79dd:53c8  - mov       word ptr ss:[9A7E],di
    79dd:53cd  - mov       bx,7929
    79dd:53d0  - mov       dx,si
             CFLP1:
    79dd:53d2  - lodsb
    79dd:53d3  - xlat
    79dd:53d5  - or        al,al
    79dd:53d7  - js        CIDIR
    79dd:53d9  - cmp       al,5C
    79dd:53db  - je        CNAME
    79dd:53dd  - cmp       al,2F
    79dd:53df  - je        CNAME
    79dd:53e1  - jmp       CFLP1
             CIDIR:
    79dd:53e3  - mov       si,dx
    79dd:53e5  - push      ds
    79dd:53e6  - push      si
    79dd:53e7  - mov       si,ss
    79dd:53e9  - mov       ds,si
    79dd:53eb  - mov       si,0EE6
             IDLOOP:
    79dd:53ee  - lodsb
    79dd:53ef  - stosb
    79dd:53f0  - or        al,al
    79dd:53f2  - jne       IDLOOP
    79dd:53f4  - dec       di
    79dd:53f5  - pop       si
    79dd:53f6  - pop       ds
             CNAME:
    79dd:53f7  - mov       si,dx
    79dd:53f9  - mov       bx,7929
             OULOOP2:
    79dd:53fc  - lodsb
    79dd:53fd  - stosb
    79dd:53fe  - xlat
    79dd:5400  - or        al,al
    79dd:5402  - jns       OULOOP2
    79dd:5404  - mov       byte ptr es:[di+FF],00
    79dd:5409  - mov       bx,76A7
    79dd:540c  - dec       si
    79dd:540d  - mov       word ptr ss:[0EDB],di
    79dd:5412  - cmp       di,1F00
    79dd:5416    jb        541B
    79dd:5418    call      MOREHEAP
    79dd:541b  - pop       es
    79dd:541c  - pop       di
    79dd:541d  - ret
             P_PRINTF:
    79dd:541e  - mov       al,byte ptr [si]
    79dd:5420    xlat
    79dd:5422    or        al,al
    79dd:5424    js        5429
    79dd:5426    jmp       PM
    79dd:5429  - lodsb
    79dd:542a    xlat
    79dd:542c    or        al,al
    79dd:542e    js        5429
    79dd:5430    dec       si
             P_PRINTF2:
    79dd:5431    mov       word ptr ss:[0ED1],di
    79dd:5436  - mov       al,byte ptr [0EE1]
    79dd:543a  - or        al,al
    79dd:543c  - jne       MUSTDOF
    79dd:543e  - mov       al,byte ptr [13EA]
    79dd:5442  - or        al,al
    79dd:5444  - jne       MUSTDOF
    79dd:5446  - ret
             MUSTDOF:
    79dd:5447  - push      es
    79dd:5448  - push      di
    79dd:5449  - mov       ax,ss
    79dd:544b  - mov       es,ax
    79dd:544d  - mov       di,word ptr ss:[2472]
             PFOUTLP:
    79dd:5452  - lodsb
    79dd:5453  - cmp       al,22
    79dd:5455  - je        PFGOT
    79dd:5457  - cmp       al,27
    79dd:5459  - je        PFGOT
    79dd:545b  - cmp       al,3B
    79dd:545d  - jne       5462
    79dd:545f    jmp       PFEND
    79dd:5462  - mov       bx,76A7
    79dd:5465  - xlat
    79dd:5467  - or        al,al
    79dd:5469  - jns       546E
    79dd:546b    jmp       PFNOVAL
    79dd:546e  - dec       si
    79dd:546f  - call      GETFIELD
    79dd:5472  - push      dx
    79dd:5473  - push      di
    79dd:5474  - mov       di,word ptr ss:[0ED1]
    79dd:5479  - call      CONVEXPRESS
    79dd:547c  - pop       di
    79dd:547d  - test      byte ptr ss:[0ACE],C0
    79dd:5483  - je        PFOK
    79dd:5485  - pop       dx
    79dd:5486  - pop       di
    79dd:5487  - pop       es
    79dd:5488  - push      dx
    79dd:5489    mov       dx,80D7
    79dd:548c    call      ERROR_ROUT
    79dd:548f    pop       dx
             PFOK:
    79dd:5490    call      PFPRTNUM
    79dd:5493  - pop       dx
    79dd:5494  - jmp       PFEND2
             PFGOT:
    79dd:5497  - mov       dh,al
    79dd:5499  - mov       byte ptr ss:[2482],FF
    79dd:549f  - mov       byte ptr ss:[2483],20
    79dd:54a5  - cmp       byte ptr [si],5B
    79dd:54a8  - jne       PFGOTFLD2
    79dd:54aa  - inc       si
    79dd:54ab  - cmp       byte ptr [si],5B
    79dd:54ae  - je        PFGOTFLD2
    79dd:54b0  - mov       bl,0A
    79dd:54b2  - xor       ax,ax
             PFGTLP:
    79dd:54b4  - mov       cl,byte ptr [si]
    79dd:54b6  - inc       si
    79dd:54b7  - sub       cl,30
    79dd:54ba  - cmp       cl,09
    79dd:54bd  - jle       54C2
    79dd:54bf    jmp       PFFLD
    79dd:54c2  - add       al,cl
    79dd:54c4  - cmp       byte ptr [si],5D
    79dd:54c7  - je        PFGOTFLD
    79dd:54c9  - cmp       byte ptr [si],2C
    79dd:54cc  - je        PFGETCOM
    79dd:54ce  - mul       bl
    79dd:54d0  - cmp       ax,00FF
    79dd:54d3  - jle       54D8
    79dd:54d5    jmp       PFFLD
    79dd:54d8  - jmp       PFGTLP
             PFGETCOM:
    79dd:54da  - mov       cl,al
    79dd:54dc  - inc       si
    79dd:54dd  - lodsb
    79dd:54de  - mov       byte ptr [2483],al
    79dd:54e2  - lodsb
    79dd:54e3  - cmp       al,5D
    79dd:54e5  - je        54EA
    79dd:54e7    jmp       PFFLD
    79dd:54ea  - dec       si
    79dd:54eb  - mov       al,cl
             PFGOTFLD:
    79dd:54ed  - mov       byte ptr [2482],al
    79dd:54f1  - inc       si
             PFGOTFLD2:
    79dd:54f2  - xor       dl,dl
             PFLOOP:
    79dd:54f4  - lodsb
    79dd:54f5  - cmp       al,25
    79dd:54f7  - jne       54FC
    79dd:54f9    jmp       PFSPEC
    79dd:54fc  - cmp       al,dh
    79dd:54fe  - je        PFEND
    79dd:5500  - cmp       al,0D
    79dd:5502  - jne       PFPERC
    79dd:5504    jmp       PFNOEND
             PFPERC:
    79dd:5507  - inc       dl
    79dd:5509  - cmp       dl,byte ptr ss:[2482]
    79dd:550e  - ja        PFLOOP
    79dd:5510  - stosb
    79dd:5511  - jmp       PFLOOP
             PFEND:
    79dd:5513  - mov       byte ptr ss:[2485],dl
    79dd:5518  - call      PFDOTFIELD
             PFEND2:
    79dd:551b  - lodsb
    79dd:551c  - cmp       al,2C
    79dd:551e  - jne       5523
    79dd:5520    jmp       PFOUTLP
    79dd:5523  - mov       bx,76A7
    79dd:5526  - xlat
    79dd:5528  - or        al,al
    79dd:552a  - js        552F
    79dd:552c    jmp       PFNOVAL
    79dd:552f  - push      di
    79dd:5530  - sub       di,word ptr ss:[2472]
    79dd:5535  - mov       cx,di
    79dd:5537  - pop       di
    79dd:5538  - mov       word ptr ss:[2486],cx
    79dd:553d  - mov       al,byte ptr [247D]
    79dd:5541  - or        al,al
    79dd:5543  - jne       PFOUT
    79dd:5545  - mov       byte ptr ss:[247C],00
    79dd:554b  - cmp       byte ptr es:[di+FE],0D
    79dd:5550  - je        PFOKCR
    79dd:5552  - mov       byte ptr ss:[247C],01
             PFOKCR:
    79dd:5558  - push      ds
    79dd:5559  - push      si
    79dd:555a  - mov       ax,ss
    79dd:555c  - mov       ds,ax
    79dd:555e  - mov       ax,4002
    79dd:5561  - mov       dx,word ptr ss:[2472]
    79dd:5566  - mov       bx,word ptr ss:[2474]
    79dd:556b  - or        bx,bx
    79dd:556d  - je        PFSCR
    79dd:556f  - mov       bx,word ptr ss:[2476]
    79dd:5574  - call      far ptr _OS2WRITEBYTES
    79dd:5579  - pop       si
    79dd:557a  - pop       ds
    79dd:557b  - jmp       PFOUT
             PFSCR:
    79dd:557d  - mov       bx,0001
    79dd:5580  - call      far ptr _OS2WRITEBYTES
    79dd:5585  - pop       si
    79dd:5586  - pop       ds
             PFOUT:
    79dd:5587  - mov       bx,76A7
    79dd:558a  - pop       di
    79dd:558b  - pop       es
    79dd:558c  - ret
             PFNOEND:
    79dd:558d  - dec       si
    79dd:558e  - dec       si
    79dd:558f  - dec       si
    79dd:5590  - pop       di
    79dd:5591  - pop       es
    79dd:5592  - push      dx
    79dd:5593    mov       dx,8162
    79dd:5596    call      ERROR_ROUT
    79dd:5599    pop       dx
             PFSPEC:
    79dd:559a    call      GETFIELD
    79dd:559d  - lodsb
    79dd:559e  - mov       bp,ax
    79dd:55a0  - and       bp,00FF
    79dd:55a4  - add       bp,bp
    79dd:55a6  - jmp       word ptr [bp+6D2B]
             BADPF:
             PF:
    79dd:55aa  - pop       di
    79dd:55ab  - pop       es
    79dd:55ac  - push      dx
    79dd:55ad    mov       dx,87E2
    79dd:55b0    call      ERROR_ROUT
    79dd:55b3    pop       dx
             EXTPF:
    79dd:55b4    lodsb
    79dd:55b5  - and       al,DF
    79dd:55b7  - cmp       al,42
    79dd:55b9  - jne       55BE
    79dd:55bb    jmp       PFNUMBYTES
    79dd:55be  - cmp       al,57
    79dd:55c0  - jne       55C5
    79dd:55c2    jmp       PFNUMWARNINGS
    79dd:55c5  - cmp       al,45
    79dd:55c7  - jne       55CC
    79dd:55c9    jmp       PFNUMERRORS
    79dd:55cc  - cmp       al,4C
    79dd:55ce  - jne       55D3
    79dd:55d0    jmp       PFNUMLINES
    79dd:55d3  - cmp       al,46
    79dd:55d5  - jne       55DA
    79dd:55d7    jmp       PFNUMFILES
    79dd:55da  - cmp       al,53
    79dd:55dc  - jne       55E1
    79dd:55de    jmp       PFNUMSYMBOLS
    79dd:55e1  - jmp       BADPF
             PFPREXP:
    79dd:55e3  - call      GETFIELD
    79dd:55e6  - push      dx
    79dd:55e7  - push      di
    79dd:55e8  - mov       di,word ptr ss:[0ED1]
    79dd:55ed  - call      CONVEXPRESS
    79dd:55f0  - pop       di
    79dd:55f1  - test      byte ptr ss:[0ACE],C0
    79dd:55f7  - je        PFOK2
    79dd:55f9  - pop       dx
    79dd:55fa  - pop       di
    79dd:55fb  - pop       es
    79dd:55fc  - push      dx
    79dd:55fd    mov       dx,80D7
    79dd:5600    call      ERROR_ROUT
    79dd:5603    pop       dx
             PFOK2:
    79dd:5604    call      PFPRTNUM
    79dd:5607  - inc       si
    79dd:5608  - pop       dx
    79dd:5609  - jmp       PFLOOP
             PFUNK:
    79dd:560c  - mov       al,byte ptr [0ACD]
    79dd:5610  - or        al,al
    79dd:5612  - je        NOUNK
    79dd:5614  - push      ds
    79dd:5615  - push      si
    79dd:5616  - mov       ds,word ptr ss:[9A8C]
    79dd:561b  - mov       si,word ptr ss:[9A8E]
    79dd:5620  - mov       ax,word ptr [si+06]
    79dd:5623  - mov       cx,word ptr [si+08]
    79dd:5626  - mov       ds,ax
    79dd:5628  - mov       si,cx
    79dd:562a  - mov       ax,2220
    79dd:562d  - stosw
    79dd:562e  - inc       dl
    79dd:5630  - inc       dl
    79dd:5632  - mov       bx,76A7
             FRELP:
    79dd:5635  - inc       dl
    79dd:5637  - lodsb
    79dd:5638  - stosb
    79dd:5639  - xlat
    79dd:563b  - or        al,al
    79dd:563d  - jns       FRELP
    79dd:563f  - dec       di
    79dd:5640  - mov       al,22
    79dd:5642  - stosb
    79dd:5643  - inc       dl
    79dd:5645  - pop       si
    79dd:5646  - pop       ds
             NOUNK:
    79dd:5647  - jmp       PFLOOP
             PFHEX:
    79dd:564a  - xor       cx,cx
    79dd:564c  - lodsb
    79dd:564d  - cmp       al,41
    79dd:564f  - jb        PFHEX1
    79dd:5651  - and       al,DF
    79dd:5653  - sub       al,07
             PFHEX1:
    79dd:5655  - sub       al,30
    79dd:5657  - cmp       al,0F
    79dd:5659  - jg        BADPFHEX
    79dd:565b  - and       al,0F
    79dd:565d  - mov       cl,al
    79dd:565f  - add       cl,cl
    79dd:5661  - add       cl,cl
    79dd:5663  - add       cl,cl
    79dd:5665  - add       cl,cl
    79dd:5667  - lodsb
    79dd:5668  - cmp       al,41
    79dd:566a  - jb        PFHEX2
    79dd:566c  - and       al,DF
    79dd:566e  - sub       al,07
             PFHEX2:
    79dd:5670  - sub       al,30
    79dd:5672  - cmp       al,0F
    79dd:5674  - jg        BADPFHEX
    79dd:5676  - and       al,0F
    79dd:5678  - or        al,cl
    79dd:567a  - stosb
    79dd:567b  - jmp       PFLOOP
             BADPFHEX:
    79dd:567e  - push      dx
    79dd:567f    mov       dx,87B1
    79dd:5682    call      ERROR_ROUT
    79dd:5685    pop       dx
             PFC:
    79dd:5686    mov       al,byte ptr [13E8]
    79dd:568a  - or        al,al
    79dd:568c  - je        NOANSI
    79dd:568e  - mov       ax,5B1B
    79dd:5691  - stosw
    79dd:5692  - dec       si
    79dd:5693  - lodsw
    79dd:5693  - lodsw
    79dd:5694  - stosw
    79dd:5695  - mov       al,6D
    79dd:5697  - stosb
    79dd:5698  - jmp       PFLOOP
             NOANSI:
    79dd:569b  - inc       si
    79dd:569c  - jmp       PFLOOP
             PFPARENT:
    79dd:569f  - push      ds
    79dd:56a0  - push      si
    79dd:56a1  - mov       ds,word ptr ss:[0F80]
    79dd:56a6  - mov       si,word ptr ss:[0F82]
             PFPLP:
    79dd:56ab  - lodsb
    79dd:56ac  - stosb
    79dd:56ad  - inc       dl
    79dd:56af  - or        al,al
    79dd:56b1  - jne       PFPLP
    79dd:56b3  - pop       si
    79dd:56b4  - pop       ds
    79dd:56b5  - jmp       PFLOOP
             PFSTR:
    79dd:56b8  - mov       word ptr ss:[9A86],dx
    79dd:56bd  - call      GETSTRINGADDR
    79dd:56c0  - push      ds
    79dd:56c1  - push      si
    79dd:56c2  - mov       si,cx
    79dd:56c4  - mov       ds,dx
    79dd:56c6  - mov       dx,word ptr ss:[9A86]
             PFSTRLP:
    79dd:56cb  - lodsb
    79dd:56cc  - stosb
    79dd:56cd  - inc       dl
    79dd:56cf  - or        al,al
    79dd:56d1  - jne       PFSTRLP
    79dd:56d3  - dec       dl
    79dd:56d5  - dec       di
    79dd:56d6  - pop       si
    79dd:56d7  - pop       ds
    79dd:56d8  - jmp       PFLOOP
             PFBS:
    79dd:56db  - mov       al,08
    79dd:56dd  - stosb
    79dd:56de  - inc       dl
    79dd:56e0  - jmp       PFLOOP
             PFQUOTE:
    79dd:56e3  - mov       al,22
    79dd:56e5  - stosb
    79dd:56e6  - inc       dl
    79dd:56e8  - jmp       PFLOOP
             PFNUMSYMBOLS:
    79dd:56eb  - push      dx
    79dd:56ec  - mov       cx,word ptr ss:[13CA]
    79dd:56f1  - mov       dx,word ptr ss:[13C8]
    79dd:56f6  - call      PFPRTNUM
    79dd:56f9  - pop       dx
    79dd:56fa  - jmp       PFLOOP
             PFNUMBYTES:
    79dd:56fd  - push      dx
    79dd:56fe  - mov       cx,word ptr ss:[13CE]
    79dd:5703  - mov       dx,word ptr ss:[13CC]
    79dd:5708  - call      PFPRTNUM
    79dd:570b  - pop       dx
    79dd:570c  - jmp       PFLOOP
             PFNUMWARNINGS:
    79dd:570f  - push      dx
    79dd:5710  - mov       cx,word ptr ss:[13C6]
    79dd:5715  - xor       dx,dx
    79dd:5717  - call      PFPRTNUM
    79dd:571a  - pop       dx
    79dd:571b  - jmp       PFLOOP
             PFMEM:
    79dd:571e  - push      dx
    79dd:571f  - call      far ptr _OS2AVAILMEM
    79dd:5724  - mov       cx,ax
    79dd:5726  - call      PFPRTNUM
    79dd:5729  - pop       dx
    79dd:572a  - jmp       PFLOOP
             PFNUMERRORS:
    79dd:572d  - push      dx
    79dd:572e  - mov       cx,word ptr ss:[13C4]
    79dd:5733  - xor       dx,dx
    79dd:5735  - call      PFPRTNUM
    79dd:5738  - pop       dx
    79dd:5739  - jmp       PFLOOP
             PFNUMLINES:
    79dd:573c  - push      dx
    79dd:573d  - mov       cx,word ptr ss:[13D2]
    79dd:5742  - mov       dx,word ptr ss:[13D0]
    79dd:5747  - call      PFPRTNUM
    79dd:574a  - pop       dx
    79dd:574b  - jmp       PFLOOP
             PFNUMFILES:
    79dd:574e  - push      dx
    79dd:574f  - mov       cx,word ptr ss:[13DC]
    79dd:5754  - xor       dx,dx
    79dd:5756  - call      PFPRTNUM
    79dd:5759  - pop       dx
    79dd:575a  - jmp       PFLOOP
             PFERRDESC:
    79dd:575d  - push      si
    79dd:575e  - mov       si,word ptr ss:[13DE]
             PFERDLP:
    79dd:5763  - mov       al,byte ptr es:[si]
    79dd:5766  - inc       si
    79dd:5767  - cmp       al,24
    79dd:5769  - je        PFERDEND
    79dd:576b  - stosb
    79dd:576c  - jmp       PFERDLP
             PFERDEND:
    79dd:576e  - pop       si
    79dd:576f  - jmp       PFLOOP
             PFERROR:
    79dd:5772  - push      si
    79dd:5773  - mov       si,word ptr ss:[13E0]
             PFERLP:
    79dd:5778  - mov       al,byte ptr es:[si]
    79dd:577b  - inc       si
    79dd:577c  - cmp       al,24
    79dd:577e  - je        PFEREND
    79dd:5780  - stosb
    79dd:5781  - jmp       PFERLP
             PFEREND:
    79dd:5783  - pop       si
    79dd:5784  - jmp       PFLOOP
             PFSWITCH:
    79dd:5787  - or        byte ptr ss:[0F8B],02
    79dd:578d  - jmp       PFLOOP
             PFFILE:
    79dd:5790  - push      ds
    79dd:5791  - push      si
    79dd:5792  - mov       al,byte ptr [0AD0]
    79dd:5796  - or        al,al
    79dd:5798  - jne       PFFILEFR
    79dd:579a  - mov       bp,word ptr ss:[0F9C]
    79dd:579f  - test      byte ptr [bp+14],05
    79dd:57a3  - jne       PFFCURSRC
             PFFLP:
    79dd:57a5  - sub       bp,1F
    79dd:57a8  - test      byte ptr [bp+14],05
    79dd:57ac  - je        PFFLP
    79dd:57ae  - mov       ds,word ptr [bp+17]
    79dd:57b1  - mov       si,word ptr [bp+19]
    79dd:57b4  - jmp       PFFILELP
             PFFCURSRC:
    79dd:57b6  - mov       ds,word ptr [bp+17]
    79dd:57b9  - mov       si,word ptr [bp+19]
    79dd:57bc  - jmp       PFFILELP
             PFFILEFR:
    79dd:57be  - mov       ds,word ptr ss:[0F98]
    79dd:57c3  - mov       si,word ptr ss:[0F9A]
             PFFILELP:
    79dd:57c8  - lodsb
    79dd:57c9  - stosb
    79dd:57ca  - inc       dl
    79dd:57cc  - or        al,al
    79dd:57ce  - jne       PFFILELP
    79dd:57d0  - dec       di
    79dd:57d1  - pop       si
    79dd:57d2  - pop       ds
    79dd:57d3  - jmp       PFLOOP
             PFCR:
    79dd:57d6  - mov       ax,0A0D
    79dd:57d9  - stosw
    79dd:57da  - mov       dl,00
    79dd:57dc  - jmp       PFLOOP
             PFTAB:
    79dd:57df  - mov       al,09
    79dd:57e1  - stosb
    79dd:57e2  - add       dl,08
    79dd:57e5  - jmp       PFLOOP
             PFMACRO:
    79dd:57e8  - push      ds
    79dd:57e9  - push      si
    79dd:57ea  - mov       bp,word ptr ss:[0F9C]
    79dd:57ef  - mov       ax,word ptr [bp+1D]
    79dd:57f2  - mov       si,word ptr [bp+1F]
    79dd:57f5  - mov       ds,ax
             PFMACLP:
    79dd:57f7  - lodsb
    79dd:57f8  - stosb
    79dd:57f9  - inc       dl
    79dd:57fb  - or        al,al
    79dd:57fd  - jne       PFMACLP
    79dd:57ff  - dec       di
    79dd:5800  - pop       si
    79dd:5801  - pop       ds
    79dd:5802  - jmp       PFLOOP
             PFMACRO2:
    79dd:5805  - push      ds
    79dd:5806  - push      si
    79dd:5807  - mov       bp,word ptr ss:[0F9C]
             NEXTLEVUP:
    79dd:580c  - sub       bp,1F
    79dd:580f  - cmp       bp,0F9E
    79dd:5813  - jbe       LEVOK
    79dd:5815  - test      byte ptr [bp+14],02
    79dd:5819  - je        NEXTLEVUP
             LEVOK:
    79dd:581b  - mov       ax,word ptr [bp+1D]
    79dd:581e  - mov       si,word ptr [bp+1F]
    79dd:5821  - mov       ds,ax
             PFMACLP2:
    79dd:5823  - lodsb
    79dd:5824  - stosb
    79dd:5825  - inc       dl
    79dd:5827  - or        al,al
    79dd:5829  - jne       PFMACLP2
    79dd:582b  - dec       di
    79dd:582c  - pop       si
    79dd:582d  - pop       ds
    79dd:582e  - jmp       PFLOOP
             PFLINE:
    79dd:5831  - mov       al,byte ptr [0AD0]
    79dd:5835  - or        al,al
    79dd:5837  - jne       PF_FRLINE
    79dd:5839  - push      dx
    79dd:583a  - call      GETLINE
    79dd:583d  - mov       cx,ax
    79dd:583f  - xor       dx,dx
    79dd:5841  - call      PFPRTNUM
    79dd:5844  - pop       dx
    79dd:5845  - add       dl,byte ptr ss:[2485]
    79dd:584a  - mov       al,2F
    79dd:584c  - stosb
    79dd:584d  - inc       dl
    79dd:584f  - call      GETLINE_MACROS
    79dd:5852  - dec       di
    79dd:5853  - dec       dl
    79dd:5855  - or        ax,ax
    79dd:5857  - je        PFNOMACL
    79dd:5859  - inc       di
    79dd:585a  - inc       dl
    79dd:585c  - push      dx
    79dd:585d  - mov       cx,ax
    79dd:585f  - xor       dx,dx
    79dd:5861  - call      PFPRTNUM
    79dd:5864  - pop       dx
    79dd:5865  - add       dl,byte ptr ss:[2485]
             PFNOMACL:
    79dd:586a  - jmp       PFLOOP
             PF_FRLINE:
    79dd:586d  - push      dx
    79dd:586e  - mov       cx,word ptr ss:[13F0]
    79dd:5873  - xor       dx,dx
    79dd:5875  - call      PFPRTNUM
    79dd:5878  - pop       dx
    79dd:5879  - add       dl,byte ptr ss:[2485]
    79dd:587e  - jmp       PFLOOP
             GETFIELD:
    79dd:5881  - mov       byte ptr ss:[2480],00
    79dd:5887  - mov       byte ptr ss:[2481],20
    79dd:588d  - mov       byte ptr ss:[2484],00
    79dd:5893  - cmp       byte ptr [si],3A
    79dd:5896  - jne       GETF
    79dd:5898  - cmp       byte ptr [si+01],24
    79dd:589c  - jne       PFBADRADIX
    79dd:589e  - mov       byte ptr ss:[2484],01
    79dd:58a4  - inc       si
    79dd:58a5  - inc       si
             GETF:
    79dd:58a6  - mov       al,byte ptr [si]
    79dd:58a8  - cmp       al,5B
    79dd:58aa  - jne       PFNOF
    79dd:58ac  - inc       si
    79dd:58ad  - lodsb
    79dd:58ae  - sub       al,30
    79dd:58b0  - cmp       al,09
    79dd:58b2  - jg        PFFLD
    79dd:58b4  - mov       cl,al
    79dd:58b6  - lodsb
    79dd:58b7  - cmp       al,5D
    79dd:58b9  - je        PFFOK
    79dd:58bb  - cmp       al,2C
    79dd:58bd  - jne       PFFLD
    79dd:58bf  - lodsb
    79dd:58c0  - mov       byte ptr [2481],al
    79dd:58c4  - lodsb
    79dd:58c5  - cmp       al,5D
    79dd:58c7  - jne       PFFLD
             PFFOK:
    79dd:58c9  - mov       byte ptr ss:[2480],cl
             PFNOF:
    79dd:58ce  - ret
             PFFLD:
    79dd:58cf  - pop       di
    79dd:58d0  - pop       es
    79dd:58d1  - push      dx
    79dd:58d2    mov       dx,8827
    79dd:58d5    call      ERROR_ROUT
    79dd:58d8    pop       dx
             PFNOVAL:
    79dd:58d9    pop       di
    79dd:58da  - pop       es
    79dd:58db  - push      dx
    79dd:58dc    mov       dx,8809
    79dd:58df    call      ERROR_ROUT
    79dd:58e2    pop       dx
             PFBADRADIX:
    79dd:58e3  - push      dx
    79dd:58e4    mov       dx,8787
    79dd:58e7    call      ERROR_ROUT
    79dd:58ea    pop       dx
             PFPRTNUM:
    79dd:58eb    push      di
    79dd:58ec  - mov       al,byte ptr [2484]
    79dd:58f0  - or        al,al
    79dd:58f2  - jne       PFDOPRTHEX
    79dd:58f4  - call      BIN2DECL
    79dd:58f7  - pop       di
    79dd:58f8  - call      PFDOFIELD
    79dd:58fb  - call      BIN2DECL
    79dd:58fe  - mov       di,word ptr ss:[2488]
    79dd:5903  - dec       di
    79dd:5904  - ret
             PFDOPRTHEX:
    79dd:5905  - pop       di
    79dd:5906  - call      BIN2HEXL
    79dd:5909  - ret
             PFDOFIELD:
    79dd:590a  - mov       bl,byte ptr ss:[2480]
    79dd:590f  - or        bl,bl
    79dd:5911  - je        ENDFIELD2
    79dd:5913  - sub       bl,byte ptr ss:[2485]
    79dd:5918  - js        ENDFIELD2
    79dd:591a  - je        ENDFIELD2
    79dd:591c  - mov       al,byte ptr [2481]
             FIELDLP2:
    79dd:5920  - stosb
    79dd:5921  - dec       bl
    79dd:5923  - jne       FIELDLP2
             ENDFIELD2:
    79dd:5925  - ret
             PFDOTFIELD:
    79dd:5926  - mov       bl,byte ptr ss:[2482]
    79dd:592b  - or        bl,bl
    79dd:592d  - je        ENDTFIELD
    79dd:592f  - sub       bl,dl
    79dd:5931  - js        ENDTFIELD
    79dd:5933  - je        ENDTFIELD
    79dd:5935  - mov       al,byte ptr [2483]
             TFIELDLP:
    79dd:5939  - stosb
    79dd:593a  - dec       bl
    79dd:593c  - jne       TFIELDLP
             ENDTFIELD:
    79dd:593e  - ret
             P_EXTERN:
    79dd:593f  - mov       al,byte ptr [si]
    79dd:5941    xlat
    79dd:5943    or        al,al
    79dd:5945    js        M_EXTERN
    79dd:5947    jmp       PM
             M_EXTERN:
    79dd:594a  - lodsb
    79dd:594b    xlat
    79dd:594d    or        al,al
    79dd:594f    js        M_EXTERN
    79dd:5951    dec       si
             P_EXTERNLP:
    79dd:5952    cmp       byte ptr [si],2E
    79dd:5955  - je        E_EXTNOLOCALS
    79dd:5957  - mov       byte ptr ss:[A49C],01
    79dd:595d  - call      ADDSYMBOL
    79dd:5960  - mov       byte ptr ss:[A49C],00
    79dd:5966  - test      byte ptr ss:[0F8B],01
    79dd:596c    jne       EXT2
    79dd:596e  - push      es
    79dd:596f  - mov       es,word ptr ss:[0F7C]
    79dd:5974  - mov       bp,word ptr ss:[0F7E]
    79dd:5979  - mov       byte ptr es:[bp+04],41
    79dd:597e  - pop       es
    79dd:597f  - lodsb
    79dd:5980  - cmp       al,2C
    79dd:5982  - je        P_EXTERNLP
    79dd:5984  - dec       si
    79dd:5985  - ret
             EXT2:
    79dd:5986  - push      es
    79dd:5987  - mov       es,word ptr ss:[0F7C]
    79dd:598c  - mov       bp,word ptr ss:[0F7E]
    79dd:5991  - mov       al,byte ptr es:[bp+04]
    79dd:5995  - pop       es
    79dd:5996  - test      al,80
    79dd:5998  - jne       E_EXTERNISPUB
             E_EXTERNISPUB:
    79dd:599a  - push      dx
    79dd:599b    mov       dx,864D
    79dd:599e    call      ERROR_ROUT
    79dd:59a1    pop       dx
             E_EXTNOLOCALS:
    79dd:59a2  - push      dx
    79dd:59a3    mov       dx,8574
    79dd:59a6    call      ERROR_ROUT
    79dd:59a9    pop       dx
             P_PUBLIC:
    79dd:59aa  - mov       al,byte ptr [si]
    79dd:59ac    xlat
    79dd:59ae    or        al,al
    79dd:59b0    js        59B5
    79dd:59b2    jmp       PM
    79dd:59b5  - lodsb
    79dd:59b6    xlat
    79dd:59b8    or        al,al
    79dd:59ba    js        59B5
    79dd:59bc    dec       si
             P_PUBLICLP:
    79dd:59bd    cmp       byte ptr [si],2E
    79dd:59c0  - je        E_PUBNOLOCALS
    79dd:59c2  - call      ADDSYMBOL
    79dd:59c5  - test      byte ptr ss:[0F8B],01
    79dd:59cb    jne       PUB2
    79dd:59cd  - push      es
    79dd:59ce  - mov       es,word ptr ss:[0F7C]
    79dd:59d3  - mov       bp,word ptr ss:[0F7E]
    79dd:59d8  - mov       byte ptr es:[bp+04],91
    79dd:59dd  - pop       es
             PUB2RET:
    79dd:59de  - lodsb
    79dd:59df  - cmp       al,2C
    79dd:59e1  - je        P_PUBLICLP
    79dd:59e3  - dec       si
    79dd:59e4  - ret
             PUB2:
    79dd:59e5  - push      es
    79dd:59e6  - mov       es,word ptr ss:[0F7C]
    79dd:59eb  - mov       bp,word ptr ss:[0F7E]
    79dd:59f0  - test      byte ptr es:[bp+04],40
    79dd:59f5  - jne       E_PUBISEXTERN
    79dd:59f7  - or        byte ptr es:[bp+04],80
    79dd:59fc  - and       byte ptr ss:[0F8B],FE
    79dd:5a02  - pop       es
    79dd:5a03  - jmp       PUB2RET
             E_PUBISEXTERN:
    79dd:5a05  - pop       es
    79dd:5a06  - push      dx
    79dd:5a07    mov       dx,8630
    79dd:5a0a    call      ERROR_ROUT
    79dd:5a0d    pop       dx
             E_PUBNOLOCALS:
    79dd:5a0e  - push      dx
    79dd:5a0f    mov       dx,8553
    79dd:5a12    call      ERROR_ROUT
    79dd:5a15    pop       dx
             P_PEA:
    79dd:5a16  - mov       al,byte ptr [si]
    79dd:5a18    xlat
    79dd:5a1a    or        al,al
    79dd:5a1c    js        5A21
    79dd:5a1e    jmp       PM
    79dd:5a21  - lodsb
    79dd:5a22    xlat
    79dd:5a24    or        al,al
    79dd:5a26    js        5A21
    79dd:5a28    dec       si
    79dd:5a29  - call      CONVEXPRESS
    79dd:5a2c  - test      byte ptr ss:[0ACE],C0
    79dd:5a32    je        5AAA
    79dd:5a34    test      byte ptr ss:[0ACE],40
    79dd:5a3a    jne       5A67
    79dd:5a3c    push      es
    79dd:5a3d    push      bp
    79dd:5a3e    mov       es,word ptr ss:[0AC5]
    79dd:5a43    mov       bp,word ptr ss:[0AC9]
    79dd:5a48    mov       word ptr es:[bp+06],di
    79dd:5a4c    mov       word ptr es:[bp+02],0002
    79dd:5a52    add       bp,15
    79dd:5a55    mov       word ptr ss:[0AC7],bp
    79dd:5a5a    cmp       bp,7F00
    79dd:5a5e    jb        5A63
    79dd:5a60    call      MOREFR
    79dd:5a63    pop       bp
    79dd:5a64    pop       es
    79dd:5a65    jmp       5AAA
    79dd:5a67    push      es
    79dd:5a68    push      bp
    79dd:5a69    push      cx
    79dd:5a6a    push      ax
    79dd:5a6b    mov       es,word ptr ss:[13A6]
    79dd:5a70    mov       bp,word ptr ss:[13A8]
    79dd:5a75    mov       ax,di
    79dd:5a77    sub       ax,word ptr ss:[13B4]
    79dd:5a7c    xor       cx,cx
    79dd:5a7e    add       ax,word ptr ss:[13BE]
    79dd:5a83    adc       cx,word ptr ss:[13BC]
    79dd:5a88    mov       word ptr es:[bp+00],ax
    79dd:5a8c    mov       word ptr es:[bp+02],cx
    79dd:5a90    mov       byte ptr es:[bp+04],02
    79dd:5a95    add       bp,05
    79dd:5a98    mov       word ptr ss:[13A8],bp
    79dd:5a9d    cmp       bp,3F00
    79dd:5aa1    jb        5AA6
    79dd:5aa3    call      MOREEXT
    79dd:5aa6    pop       ax
    79dd:5aa7    pop       cx
    79dd:5aa8    pop       bp
    79dd:5aa9    pop       es
    79dd:5aaa  - mov       al,F4
    79dd:5aac  - stosb
    79dd:5aad  - mov       ax,cx
    79dd:5aaf  - stosw
    79dd:5ab0  - ret
             P_PEI:
    79dd:5ab1  - mov       al,byte ptr [si]
    79dd:5ab3    xlat
    79dd:5ab5    or        al,al
    79dd:5ab7    js        5ABC
    79dd:5ab9    jmp       PM
    79dd:5abc  - lodsb
    79dd:5abd    xlat
    79dd:5abf    or        al,al
    79dd:5ac1    js        5ABC
    79dd:5ac3    dec       si
    79dd:5ac4  - cmp       byte ptr [si],28
    79dd:5ac7  - je        5ACC
    79dd:5ac9    jmp       P_PEIERR
    79dd:5acc  - call      CONVEXPRESS
    79dd:5acf  - or        dx,dx
    79dd:5ad1  - je        5AD6
    79dd:5ad3    jmp       P_PEIERR1
    79dd:5ad6  - or        ch,ch
    79dd:5ad8  - je        5ADD
    79dd:5ada    jmp       P_PEIERR1
    79dd:5add  - test      byte ptr ss:[0ACE],C0
    79dd:5ae3    je        5B5B
    79dd:5ae5    test      byte ptr ss:[0ACE],40
    79dd:5aeb    jne       5B18
    79dd:5aed    push      es
    79dd:5aee    push      bp
    79dd:5aef    mov       es,word ptr ss:[0AC5]
    79dd:5af4    mov       bp,word ptr ss:[0AC9]
    79dd:5af9    mov       word ptr es:[bp+06],di
    79dd:5afd    mov       word ptr es:[bp+02],0000
    79dd:5b03    add       bp,15
    79dd:5b06    mov       word ptr ss:[0AC7],bp
    79dd:5b0b    cmp       bp,7F00
    79dd:5b0f    jb        5B14
    79dd:5b11    call      MOREFR
    79dd:5b14    pop       bp
    79dd:5b15    pop       es
    79dd:5b16    jmp       5B5B
    79dd:5b18    push      es
    79dd:5b19    push      bp
    79dd:5b1a    push      cx
    79dd:5b1b    push      ax
    79dd:5b1c    mov       es,word ptr ss:[13A6]
    79dd:5b21    mov       bp,word ptr ss:[13A8]
    79dd:5b26    mov       ax,di
    79dd:5b28    sub       ax,word ptr ss:[13B4]
    79dd:5b2d    xor       cx,cx
    79dd:5b2f    add       ax,word ptr ss:[13BE]
    79dd:5b34    adc       cx,word ptr ss:[13BC]
    79dd:5b39    mov       word ptr es:[bp+00],ax
    79dd:5b3d    mov       word ptr es:[bp+02],cx
    79dd:5b41    mov       byte ptr es:[bp+04],00
    79dd:5b46    add       bp,05
    79dd:5b49    mov       word ptr ss:[13A8],bp
    79dd:5b4e    cmp       bp,3F00
    79dd:5b52    jb        5B57
    79dd:5b54    call      MOREEXT
    79dd:5b57    pop       ax
    79dd:5b58    pop       cx
    79dd:5b59    pop       bp
    79dd:5b5a    pop       es
    79dd:5b5b  - mov       al,D4
    79dd:5b5d  - mov       ah,cl
    79dd:5b5f  - stosw
    79dd:5b60  - ret
             P_PEIERR:
    79dd:5b61  - push      dx
    79dd:5b62    mov       dx,7F7F
    79dd:5b65    call      ERROR_ROUT
    79dd:5b68    pop       dx
             P_PEIERR1:
    79dd:5b69  - push      dx
    79dd:5b6a    mov       dx,7F28
    79dd:5b6d    call      ERROR_ROUT
    79dd:5b70    pop       dx
             P_PER:
    79dd:5b71  - mov       al,byte ptr [si]
    79dd:5b73    xlat
    79dd:5b75    or        al,al
    79dd:5b77    js        5B7C
    79dd:5b79    jmp       PM
    79dd:5b7c  - mov       byte ptr es:[di],62
    79dd:5b80  - jmp       P_LCC
             P_PHA:
    79dd:5b83  - mov       al,byte ptr [si]
    79dd:5b85    xlat
    79dd:5b87    or        al,al
    79dd:5b89    js        5B8E
    79dd:5b8b    jmp       PM
    79dd:5b8e  - mov       al,48
    79dd:5b90    stosb
    79dd:5b91  - ret
             P_PHB:
    79dd:5b92  - mov       al,byte ptr [si]
    79dd:5b94    xlat
    79dd:5b96    or        al,al
    79dd:5b98    js        5B9D
    79dd:5b9a    jmp       PM
    79dd:5b9d  - mov       al,8B
    79dd:5b9f    stosb
    79dd:5ba0  - ret
             P_PHD:
    79dd:5ba1  - mov       al,byte ptr [si]
    79dd:5ba3    xlat
    79dd:5ba5    or        al,al
    79dd:5ba7    js        5BAC
    79dd:5ba9    jmp       PM
    79dd:5bac  - mov       al,0B
    79dd:5bae    stosb
    79dd:5baf  - ret
             P_PHK:
    79dd:5bb0  - mov       al,byte ptr [si]
    79dd:5bb2    xlat
    79dd:5bb4    or        al,al
    79dd:5bb6    js        5BBB
    79dd:5bb8    jmp       PM
    79dd:5bbb  - mov       al,4B
    79dd:5bbd    stosb
    79dd:5bbe  - ret
             P_PHP:
    79dd:5bbf  - mov       al,byte ptr [si]
    79dd:5bc1    xlat
    79dd:5bc3    or        al,al
    79dd:5bc5    js        5BCA
    79dd:5bc7    jmp       PM
    79dd:5bca  - mov       al,08
    79dd:5bcc    stosb
    79dd:5bcd  - ret
             P_PHX:
    79dd:5bce  - mov       al,byte ptr [si]
    79dd:5bd0    xlat
    79dd:5bd2    or        al,al
    79dd:5bd4    js        5BD9
    79dd:5bd6    jmp       PM
    79dd:5bd9  - mov       al,DA
    79dd:5bdb    stosb
    79dd:5bdc  - ret
             P_PHY:
    79dd:5bdd  - mov       al,byte ptr [si]
    79dd:5bdf    xlat
    79dd:5be1    or        al,al
    79dd:5be3    js        5BE8
    79dd:5be5    jmp       PM
    79dd:5be8  - mov       al,5A
    79dd:5bea    stosb
    79dd:5beb  - ret
             P_PLA:
    79dd:5bec  - mov       al,byte ptr [si]
    79dd:5bee    xlat
    79dd:5bf0    or        al,al
    79dd:5bf2    js        5BF7
    79dd:5bf4    jmp       PM
    79dd:5bf7  - mov       al,68
    79dd:5bf9    stosb
    79dd:5bfa  - ret
             P_PLB:
    79dd:5bfb  - mov       al,byte ptr [si]
    79dd:5bfd    xlat
    79dd:5bff    or        al,al
    79dd:5c01    js        5C06
    79dd:5c03    jmp       PM
    79dd:5c06  - mov       al,AB
    79dd:5c08    stosb
    79dd:5c09  - ret
             P_PLD:
    79dd:5c0a  - mov       al,byte ptr [si]
    79dd:5c0c    xlat
    79dd:5c0e    or        al,al
    79dd:5c10    js        5C15
    79dd:5c12    jmp       PM
    79dd:5c15  - mov       al,2B
    79dd:5c17    stosb
    79dd:5c18  - ret
             P_PLP:
    79dd:5c19  - mov       al,byte ptr [si]
    79dd:5c1b    xlat
    79dd:5c1d    or        al,al
    79dd:5c1f    js        5C24
    79dd:5c21    jmp       PM
    79dd:5c24  - mov       al,28
    79dd:5c26    stosb
    79dd:5c27  - ret
             P_PLX:
    79dd:5c28  - mov       al,byte ptr [si]
    79dd:5c2a    xlat
    79dd:5c2c    or        al,al
    79dd:5c2e    js        5C33
    79dd:5c30    jmp       PM
    79dd:5c33  - mov       al,FA
    79dd:5c35    stosb
    79dd:5c36  - ret
             P_PLY:
    79dd:5c37  - mov       al,byte ptr [si]
    79dd:5c39    xlat
    79dd:5c3b    or        al,al
    79dd:5c3d    js        5C42
    79dd:5c3f    jmp       PM
    79dd:5c42  - mov       al,7A
    79dd:5c44    stosb
    79dd:5c45  - ret
             M_RUN:
    79dd:5c46  - mov       al,byte ptr [si]
    79dd:5c48    xlat
    79dd:5c4a    or        al,al
    79dd:5c4c    js        P_RUN
    79dd:5c4e    jmp       PM
             P_RUN:
    79dd:5c51  - lodsb
    79dd:5c52    xlat
    79dd:5c54    or        al,al
    79dd:5c56    js        P_RUN
    79dd:5c58    dec       si
    79dd:5c59  - push      word ptr ss:[2472]
    79dd:5c5e  - mov       word ptr ss:[2472],8B36
    79dd:5c65  - mov       byte ptr ss:[247D],01
    79dd:5c6b  - call      P_PRINTF2
    79dd:5c6e  - mov       byte ptr ss:[247D],00
    79dd:5c74  - pop       word ptr ss:[2472]
    79dd:5c79  - push      bx
    79dd:5c7a  - mov       bx,word ptr ss:[2486]
    79dd:5c7f  - add       bx,8B36
    79dd:5c83  - mov       word ptr ss:[bx],0A0D
    79dd:5c88  - mov       byte ptr ss:[bx+02],1A
    79dd:5c8d  - mov       bp,word ptr ss:[0F9C]
    79dd:5c92  - dec       si
    79dd:5c93  - mov       word ptr [bp+0C],ds
    79dd:5c96  - mov       word ptr [bp+0E],si
    79dd:5c99  - mov       ax,word ptr [1470]
    79dd:5c9d  - mov       word ptr [bp+00],ax
    79dd:5ca0  - mov       ax,word ptr [0F96]
    79dd:5ca4  - mov       word ptr [bp+04],ax
    79dd:5ca7  - mov       ax,word ptr [13F0]
    79dd:5cab  - mov       word ptr [bp+15],ax
    79dd:5cae  - mov       ax,word ptr [0204]
    79dd:5cb2  - mov       word ptr [bp+0A],ax
    79dd:5cb5  - mov       ax,word ptr [0200]
    79dd:5cb9  - mov       word ptr [bp+1B],ax
    79dd:5cbc  - mov       ax,word ptr [bp+17]
    79dd:5cbf  - mov       bx,word ptr [bp+19]
    79dd:5cc2  - add       bp,1F
    79dd:5cc5  - mov       byte ptr [bp+14],08
    79dd:5cc9  - mov       word ptr [bp+17],ax
    79dd:5ccc  - mov       word ptr [bp+19],bx
    79dd:5ccf  - mov       ax,8AC9
    79dd:5cd2  - mov       word ptr [bp+1D],ax
    79dd:5cd5  - mov       ax,8BFE
    79dd:5cd8  - mov       word ptr [bp+1F],ax
    79dd:5cdb  - mov       word ptr ss:[0F9C],bp
    79dd:5ce0  - cmp       byte ptr ss:[0F8A],20
    79dd:5ce6  - jl        SRCLOK3
    79dd:5ce8  - mov       dx,7D45
    79dd:5ceb    call      FATALERR_ROUT
    79dd:5cee  - jmp       STOPASSEM
             SRCLOK3:
    79dd:5cf1    inc       byte ptr ss:[0F8A]
    79dd:5cf6  - mov       ax,ss
    79dd:5cf8  - mov       ds,ax
    79dd:5cfa  - mov       si,8B36
    79dd:5cfd  - pop       bx
    79dd:5cfe  - pop       ax
    79dd:5cff  - cmp       byte ptr ss:[0F8D],00
    79dd:5d05  - jne       5D0A
    79dd:5d07    jmp       DO_65816
    79dd:5d0a  - jmp       DO_MARIO
             P_REP:
    79dd:5d0d  - lodsb
    79dd:5d0e    xlat
    79dd:5d10    or        al,al
    79dd:5d12    js        P_REP
    79dd:5d14    dec       si
    79dd:5d15  - lodsb
    79dd:5d16  - cmp       al,23
    79dd:5d18  - je        5D1D
    79dd:5d1a    jmp       P_REPERR
    79dd:5d1d  - call      CONVEXPRESS
    79dd:5d20  - or        dx,dx
    79dd:5d22  - je        5D27
    79dd:5d24    jmp       BADVAL
    79dd:5d27  - or        ch,ch
    79dd:5d29  - je        5D2E
    79dd:5d2b    jmp       BADVAL
    79dd:5d2e  - test      byte ptr ss:[0ACE],C0
    79dd:5d34    je        5DAC
    79dd:5d36    test      byte ptr ss:[0ACE],40
    79dd:5d3c    jne       5D69
    79dd:5d3e    push      es
    79dd:5d3f    push      bp
    79dd:5d40    mov       es,word ptr ss:[0AC5]
    79dd:5d45    mov       bp,word ptr ss:[0AC9]
    79dd:5d4a    mov       word ptr es:[bp+06],di
    79dd:5d4e    mov       word ptr es:[bp+02],0000
    79dd:5d54    add       bp,15
    79dd:5d57    mov       word ptr ss:[0AC7],bp
    79dd:5d5c    cmp       bp,7F00
    79dd:5d60    jb        5D65
    79dd:5d62    call      MOREFR
    79dd:5d65    pop       bp
    79dd:5d66    pop       es
    79dd:5d67    jmp       5DAC
    79dd:5d69    push      es
    79dd:5d6a    push      bp
    79dd:5d6b    push      cx
    79dd:5d6c    push      ax
    79dd:5d6d    mov       es,word ptr ss:[13A6]
    79dd:5d72    mov       bp,word ptr ss:[13A8]
    79dd:5d77    mov       ax,di
    79dd:5d79    sub       ax,word ptr ss:[13B4]
    79dd:5d7e    xor       cx,cx
    79dd:5d80    add       ax,word ptr ss:[13BE]
    79dd:5d85    adc       cx,word ptr ss:[13BC]
    79dd:5d8a    mov       word ptr es:[bp+00],ax
    79dd:5d8e    mov       word ptr es:[bp+02],cx
    79dd:5d92    mov       byte ptr es:[bp+04],00
    79dd:5d97    add       bp,05
    79dd:5d9a    mov       word ptr ss:[13A8],bp
    79dd:5d9f    cmp       bp,3F00
    79dd:5da3    jb        5DA8
    79dd:5da5    call      MOREEXT
    79dd:5da8    pop       ax
    79dd:5da9    pop       cx
    79dd:5daa    pop       bp
    79dd:5dab    pop       es
    79dd:5dac  - mov       al,C2
    79dd:5dae  - mov       ah,cl
    79dd:5db0  - stosw
    79dd:5db1  - ret
             P_REPERR:
    79dd:5db2  - push      dx
    79dd:5db3    mov       dx,80AE
    79dd:5db6    call      ERROR_ROUT
    79dd:5db9    pop       dx
             M_IRP:
             P_IRP:
    79dd:5dba  - mov       al,byte ptr [si]
    79dd:5dbc    xlat
    79dd:5dbe    or        al,al
    79dd:5dc0    js        5DC5
    79dd:5dc2    jmp       PM
    79dd:5dc5  - cmp       word ptr ss:[1470],00
    79dd:5dcb  - jne       5DD0
    79dd:5dcd    jmp       P_NOTINREPT
    79dd:5dd0  - lodsb
    79dd:5dd1    xlat
    79dd:5dd3    or        al,al
    79dd:5dd5    js        5DD0
    79dd:5dd7    dec       si
    79dd:5dd8  - call      ADDSYMBOL
    79dd:5ddb  - mov       bx,76A7
    79dd:5dde  - test      byte ptr ss:[0F8B],01
    79dd:5de4    jne       NOIRP2
    79dd:5de6  - mov       bp,word ptr ss:[13F0]
    79dd:5deb    cmp       word ptr ss:[0F7A],bp
    79dd:5df0    jne       NOIRP
    79dd:5df2  - push      es
    79dd:5df3  - mov       es,word ptr ss:[0F7C]
    79dd:5df8  - mov       bp,word ptr ss:[0F7E]
    79dd:5dfd  - mov       byte ptr es:[bp+04],05
    79dd:5e02  - mov       ax,word ptr [0F84]
    79dd:5e06    mov       word ptr [0F80],ax
    79dd:5e0a    mov       ax,word ptr [0F86]
    79dd:5e0e    mov       word ptr [0F82],ax
    79dd:5e12    mov       ax,word ptr [0F70]
    79dd:5e16    mov       word ptr [0F6E],ax
    79dd:5e1a  - push      bp
    79dd:5e1b  - mov       bp,word ptr ss:[1401]
    79dd:5e20  - inc       si
    79dd:5e21  - mov       cx,word ptr [bp+10]
    79dd:5e24  - sub       cx,word ptr [bp+06]
    79dd:5e27  - je        IRPGOT
             IRPLOOP:
    79dd:5e29  - lodsb
    79dd:5e2a  - cmp       al,2C
    79dd:5e2c  - je        IRPCOMMA
    79dd:5e2e  - xlat
    79dd:5e30  - or        al,al
    79dd:5e32  - jns       IRPLOOP
    79dd:5e34  - pop       bp
    79dd:5e35  - pop       es
    79dd:5e36  - push      dx
    79dd:5e37    mov       dx,84D4
    79dd:5e3a    call      ERROR_ROUT
    79dd:5e3d    pop       dx
             IRPCOMMA:
    79dd:5e3e    dec       cx
    79dd:5e3f  - jne       IRPLOOP
             IRPGOT:
    79dd:5e41  - call      CONVEXPRESS
    79dd:5e44  - pop       bp
    79dd:5e45  - test      byte ptr ss:[0ACE],C0
    79dd:5e4b  - jne       IRPERR
    79dd:5e4d  - mov       word ptr es:[bp+0A],dx
    79dd:5e51  - mov       word ptr es:[bp+0C],cx
    79dd:5e55  - pop       es
    79dd:5e56  - ret
             IRPERR:
    79dd:5e57  - pop       bp
    79dd:5e58  - pop       es
             NOIRP:
    79dd:5e59  - push      dx
    79dd:5e5a    mov       dx,80D7
    79dd:5e5d    call      ERROR_ROUT
    79dd:5e60    pop       dx
             NOIRP2:
    79dd:5e61    ret
             P_NOTINREPT:
    79dd:5e62  - push      dx
    79dd:5e63    mov       dx,84C2
    79dd:5e66    call      ERROR_ROUT
    79dd:5e69    pop       dx
             M_IRS:
             P_IRS:
    79dd:5e6a  - mov       al,byte ptr [si]
    79dd:5e6c    xlat
    79dd:5e6e    or        al,al
    79dd:5e70    js        5E75
    79dd:5e72    jmp       PM
    79dd:5e75  - cmp       word ptr ss:[1470],00
    79dd:5e7b  - je        P_NOTINREPT
    79dd:5e7d  - lodsb
    79dd:5e7e    xlat
    79dd:5e80    or        al,al
    79dd:5e82    js        5E7D
    79dd:5e84    dec       si
    79dd:5e85  - call      GETSTRINGADDR
    79dd:5e88  - push      di
    79dd:5e89  - mov       di,cx
    79dd:5e8b  - mov       word ptr ss:[9A7C],dx
    79dd:5e90  - mov       bp,word ptr ss:[1401]
    79dd:5e95  - inc       si
    79dd:5e96  - mov       cx,word ptr [bp+10]
    79dd:5e99  - sub       cx,word ptr [bp+06]
    79dd:5e9c  - je        IRCGOT2
    79dd:5e9e  - mov       bp,si
             IRCLOOP:
    79dd:5ea0  - lodsb
    79dd:5ea1  - mov       dl,al
    79dd:5ea3  - cmp       dl,27
    79dd:5ea6  - je        IRCL1
    79dd:5ea8  - cmp       dl,22
    79dd:5eab  - je        IRCL1
    79dd:5ead  - pop       di
    79dd:5eae  - push      dx
    79dd:5eaf    mov       dx,85A9
    79dd:5eb2    call      ERROR_ROUT
    79dd:5eb5    pop       dx
             IRCL1:
    79dd:5eb6  - lodsb
    79dd:5eb7  - cmp       al,0D
    79dd:5eb9  - je        IRCEOL
    79dd:5ebb  - cmp       dl,al
    79dd:5ebd  - jne       IRCL1
    79dd:5ebf  - inc       si
    79dd:5ec0  - mov       al,byte ptr [si]
    79dd:5ec2  - cmp       al,0A
    79dd:5ec4  - je        IRCEOL
    79dd:5ec6  - xlat
    79dd:5ec8  - or        al,al
    79dd:5eca  - jns       IRCNEOL
             IRCEOL:
    79dd:5ecc  - mov       si,bp
             IRCNEOL:
    79dd:5ece  - dec       cx
    79dd:5ecf  - jne       IRCLOOP
             IRCGOT2:
    79dd:5ed1  - lodsb
    79dd:5ed2  - mov       dl,al
    79dd:5ed4  - cmp       dl,27
    79dd:5ed7  - je        IRCGOT
    79dd:5ed9  - cmp       dl,22
    79dd:5edc  - je        IRCGOT
    79dd:5ede  - pop       di
    79dd:5edf  - push      dx
    79dd:5ee0    mov       dx,85A9
    79dd:5ee3    call      ERROR_ROUT
    79dd:5ee6    pop       dx
             IRCGOT:
    79dd:5ee7  - push      es
    79dd:5ee8  - mov       es,word ptr ss:[9A7C]
             IRCCOPY:
    79dd:5eed  - lodsb
    79dd:5eee  - stosb
    79dd:5eef  - cmp       al,0D
    79dd:5ef1  - je        IRCEND
    79dd:5ef3  - cmp       al,dl
    79dd:5ef5  - jne       IRCCOPY
             IRCEND:
    79dd:5ef7  - mov       byte ptr es:[di+FF],00
    79dd:5efc  - pop       es
    79dd:5efd  - pop       di
    79dd:5efe  - ret
             P_REPT:
    79dd:5eff  - mov       al,byte ptr [si]
    79dd:5f01    xlat
    79dd:5f03    or        al,al
    79dd:5f05    js        5F0A
    79dd:5f07    jmp       PM
    79dd:5f0a  - lodsb
    79dd:5f0b    xlat
    79dd:5f0d    or        al,al
    79dd:5f0f    js        5F0A
    79dd:5f11    dec       si
    79dd:5f12  - call      CONVEXPRESS
    79dd:5f15  - test      byte ptr ss:[0ACE],C0
    79dd:5f1b  - je        5F20
    79dd:5f1d    jmp       P_IFERR
    79dd:5f20  - or        dx,dx
    79dd:5f22  - js        P_REPTERR1
    79dd:5f24  - jne       DOREPT
    79dd:5f26  - or        cx,cx
    79dd:5f28  - je        P_REPTERR1
             DOREPT:
    79dd:5f2a  - cmp       byte ptr [si],0A
    79dd:5f2d  - je        REPFOUNDLF0
    79dd:5f2f  - mov       ah,0D
             REPFINDLF:
    79dd:5f31  - lodsb
    79dd:5f32  - cmp       ah,al
    79dd:5f34  - jne       REPFINDLF
             REPFOUNDLF0:
    79dd:5f36  - dec       si
    79dd:5f37  - cmp       word ptr ss:[1470],06
    79dd:5f3d  - jge       P_REPTERROR
    79dd:5f3f  - inc       word ptr ss:[1470]
    79dd:5f44  - push      es
    79dd:5f45  - push      di
    79dd:5f46  - add       word ptr ss:[1401],12
    79dd:5f4c  - mov       di,word ptr ss:[1401]
    79dd:5f51  - mov       ax,8AC9
    79dd:5f54  - mov       es,ax
    79dd:5f56  - sub       cx,01
    79dd:5f59  - sbb       dx,00
    79dd:5f5c  - mov       word ptr es:[di],ds
    79dd:5f5f  - mov       word ptr es:[di+02],si
    79dd:5f63  - mov       word ptr es:[di+04],dx
    79dd:5f67  - mov       word ptr es:[di+06],cx
    79dd:5f6b  - mov       word ptr es:[di+0E],dx
    79dd:5f6f  - mov       word ptr es:[di+10],cx
    79dd:5f73  - mov       ax,word ptr [13F0]
    79dd:5f77  - inc       ax
    79dd:5f78  - mov       word ptr es:[di+08],ax
    79dd:5f7c  - mov       bp,word ptr ss:[0F9C]
    79dd:5f81  - mov       ax,word ptr [bp+06]
    79dd:5f84  - mov       word ptr es:[di+0A],ax
    79dd:5f88  - mov       ax,word ptr [bp+08]
    79dd:5f8b  - mov       word ptr es:[di+0C],ax
    79dd:5f8f  - pop       di
    79dd:5f90  - pop       es
    79dd:5f91  - ret
             P_REPTERROR:
    79dd:5f92  - push      dx
    79dd:5f93    mov       dx,819A
    79dd:5f96    call      ERROR_ROUT
    79dd:5f99    pop       dx
             P_REPTERR1:
    79dd:5f9a  - push      dx
    79dd:5f9b    mov       dx,818A
    79dd:5f9e    call      ERROR_ROUT
    79dd:5fa1    pop       dx
             P_ENDR:
    79dd:5fa2    test      word ptr ss:[1470],FFFF
    79dd:5fa9  - jne       5FAE
    79dd:5fab    jmp       P_ENDRERR
    79dd:5fae  - mov       bp,word ptr ss:[0F9C]
    79dd:5fb3  - sub       bp,1F
    79dd:5fb6  - mov       dx,word ptr [bp+00]
    79dd:5fb9  - cmp       dx,word ptr ss:[1470]
    79dd:5fbe  - jl        5FC3
    79dd:5fc0    jmp       P_ENDRERROR
    79dd:5fc3  - mov       bp,word ptr ss:[1401]
    79dd:5fc8  - mov       ax,word ptr [bp+04]
    79dd:5fcb  - mov       cx,word ptr [bp+06]
    79dd:5fce  - sub       cx,01
    79dd:5fd1  - sbb       ax,0000
    79dd:5fd4  - jns       SETREPT
    79dd:5fd6  - sub       word ptr ss:[1401],12
    79dd:5fdc  - dec       word ptr ss:[1470]
    79dd:5fe1  - dec       word ptr ss:[13F0]
    79dd:5fe6  - ret
             SETREPT:
    79dd:5fe7  - mov       word ptr [bp+04],ax
    79dd:5fea  - mov       word ptr [bp+06],cx
    79dd:5fed  - mov       ax,word ptr [bp+0A]
    79dd:5ff0  - mov       cx,word ptr [bp+0C]
    79dd:5ff3  - push      bp
    79dd:5ff4  - mov       bp,word ptr ss:[0F9C]
    79dd:5ff9  - cmp       word ptr [bp+06],ax
    79dd:5ffc  - jne       REPTRELOAD
    79dd:5ffe  - cmp       word ptr [bp+08],cx
    79dd:6001  - jne       REPTRELOAD
    79dd:6003  - pop       bp
             REPTRELOADRET:
    79dd:6004  - mov       ds,word ptr [bp+00]
    79dd:6007  - mov       si,word ptr [bp+02]
    79dd:600a  - mov       ax,word ptr [bp+08]
    79dd:600d  - mov       cx,word ptr ss:[13F0]
    79dd:6012  - mov       word ptr [13F0],ax
    79dd:6016  - sub       cx,ax
    79dd:6018  - dec       cx
    79dd:6019  - add       word ptr ss:[13D2],cx
    79dd:601e  - adc       word ptr ss:[13D0],00
    79dd:6024  - ret
             REPTRELOAD:
    79dd:6025  - pop       bp
    79dd:6026  - push      bp
    79dd:6027  - mov       bp,word ptr ss:[0F9C]
    79dd:602c  - mov       word ptr [bp+06],ax
    79dd:602f  - mov       word ptr [bp+08],cx
    79dd:6032  - mov       byte ptr [bp+14],04
    79dd:6036  - call      READMORESOURCE
    79dd:6039  - pop       bp
    79dd:603a  - jne       P_ENDRERROR2
    79dd:603c  - mov       ax,word ptr [bp+08]
    79dd:603f  - cmp       word ptr ss:[13FF],ax
    79dd:6044  - je        RELOADOK
    79dd:6046  - mov       word ptr [13FF],ax
             RELOADOK:
    79dd:604a  - jmp       REPTRELOADRET
             P_ENDRERROR2:
    79dd:604c  - pop       di
    79dd:604d  - pop       es
    79dd:604e  - push      dx
    79dd:604f    mov       dx,81D7
    79dd:6052    call      ERROR_ROUT
    79dd:6055    pop       dx
             P_ENDRERROR:
    79dd:6056  - push      dx
    79dd:6057    mov       dx,81BA
    79dd:605a    call      ERROR_ROUT
    79dd:605d    pop       dx
             P_ENDRERR:
    79dd:605e  - push      dx
    79dd:605f    mov       dx,81AA
    79dd:6062    call      ERROR_ROUT
    79dd:6065    pop       dx
             P_ROL:
    79dd:6066  - mov       al,byte ptr [si]
    79dd:6068    xlat
    79dd:606a    or        al,al
    79dd:606c    js        6071
    79dd:606e    jmp       PM
    79dd:6071  - call      GETEA
    79dd:6074    mov       al,byte ptr [si]
    79dd:6076    xlat
    79dd:6078    or        al,al
    79dd:607a    js        607F
    79dd:607c    jmp       E_EXTRACHARS
    79dd:607f    mov       ax,word ptr [bp+7169]
    79dd:6083    or        al,al
    79dd:6085    je        608F
    79dd:6087    stosb
    79dd:6088    mov       al,ah
    79dd:608a    xor       ah,ah
    79dd:608c    add       di,ax
    79dd:608e    ret
    79dd:608f    push      dx
    79dd:6090    mov       dx,7F7F
    79dd:6093    call      ERROR_ROUT
    79dd:6096    pop       dx
    79dd:6097    ret
             P_ROR:
    79dd:6098  - call      GETEA
    79dd:609b    mov       al,byte ptr [si]
    79dd:609d    xlat
    79dd:609f    or        al,al
    79dd:60a1    js        60A6
    79dd:60a3    jmp       E_EXTRACHARS
    79dd:60a6    mov       ax,word ptr [bp+7197]
    79dd:60aa    or        al,al
    79dd:60ac    je        60B6
    79dd:60ae    stosb
    79dd:60af    mov       al,ah
    79dd:60b1    xor       ah,ah
    79dd:60b3    add       di,ax
    79dd:60b5    ret
    79dd:60b6    push      dx
    79dd:60b7    mov       dx,7F7F
    79dd:60ba    call      ERROR_ROUT
    79dd:60bd    pop       dx
    79dd:60be    ret
             P_RTI:
    79dd:60bf  - mov       al,byte ptr [si]
    79dd:60c1    xlat
    79dd:60c3    or        al,al
    79dd:60c5    js        60CA
    79dd:60c7    jmp       PM
    79dd:60ca  - mov       al,40
    79dd:60cc    stosb
    79dd:60cd  - ret
             P_RTL:
    79dd:60ce  - mov       al,byte ptr [si]
    79dd:60d0    xlat
    79dd:60d2    or        al,al
    79dd:60d4    js        60D9
    79dd:60d6    jmp       PM
    79dd:60d9  - mov       al,6B
    79dd:60db    stosb
    79dd:60dc  - ret
             P_RTS:
    79dd:60dd  - mov       al,byte ptr [si]
    79dd:60df    xlat
    79dd:60e1    or        al,al
    79dd:60e3    js        60E8
    79dd:60e5    jmp       PM
    79dd:60e8  - mov       al,60
    79dd:60ea    stosb
    79dd:60eb  - ret
             P_SBC:
    79dd:60ec  - mov       al,byte ptr [0ABA]
    79dd:60f0    test      al,01
    79dd:60f2    je        60FC
    79dd:60f4    mov       ax,word ptr [13F0]
    79dd:60f8    mov       word ptr [0AB2],ax
    79dd:60fc  - call      GETEA
    79dd:60ff    mov       al,byte ptr [si]
    79dd:6101    xlat
    79dd:6103    or        al,al
    79dd:6105    js        610A
    79dd:6107    jmp       E_EXTRACHARS
    79dd:610a    mov       ax,word ptr [bp+71C5]
    79dd:610e    or        al,al
    79dd:6110    je        611A
    79dd:6112    stosb
    79dd:6113    mov       al,ah
    79dd:6115    xor       ah,ah
    79dd:6117    add       di,ax
    79dd:6119    ret
    79dd:611a    push      dx
    79dd:611b    mov       dx,7F7F
    79dd:611e    call      ERROR_ROUT
    79dd:6121    pop       dx
    79dd:6122    ret
             P_SEC:
    79dd:6123  - mov       al,byte ptr [si]
    79dd:6125    xlat
    79dd:6127    or        al,al
    79dd:6129    js        612E
    79dd:612b    jmp       PM
    79dd:612e  - mov       al,38
    79dd:6130    stosb
    79dd:6131  - ret
             P_SED:
    79dd:6132  - mov       al,byte ptr [si]
    79dd:6134    xlat
    79dd:6136    or        al,al
    79dd:6138    js        613D
    79dd:613a    jmp       PM
    79dd:613d  - mov       al,F8
    79dd:613f    stosb
    79dd:6140  - ret
             P_SEI:
    79dd:6141  - mov       al,byte ptr [si]
    79dd:6143    xlat
    79dd:6145    or        al,al
    79dd:6147    js        614C
    79dd:6149    jmp       PM
    79dd:614c  - mov       al,78
    79dd:614e    stosb
    79dd:614f  - ret
             P_SEP:
    79dd:6150  - mov       al,byte ptr [si]
    79dd:6152    xlat
    79dd:6154    or        al,al
    79dd:6156    js        615B
    79dd:6158    jmp       PM
    79dd:615b  - lodsb
    79dd:615c    xlat
    79dd:615e    or        al,al
    79dd:6160    js        615B
    79dd:6162    dec       si
    79dd:6163  - lodsb
    79dd:6164  - cmp       al,23
    79dd:6166  - je        616B
    79dd:6168    jmp       P_REPERR
    79dd:616b  - call      CONVEXPRESS
    79dd:616e  - or        dx,dx
    79dd:6170  - je        6175
    79dd:6172    jmp       BADVAL
    79dd:6175  - or        ch,ch
    79dd:6177  - je        617C
    79dd:6179    jmp       BADVAL
    79dd:617c  - test      byte ptr ss:[0ACE],C0
    79dd:6182    je        61FA
    79dd:6184    test      byte ptr ss:[0ACE],40
    79dd:618a    jne       61B7
    79dd:618c    push      es
    79dd:618d    push      bp
    79dd:618e    mov       es,word ptr ss:[0AC5]
    79dd:6193    mov       bp,word ptr ss:[0AC9]
    79dd:6198    mov       word ptr es:[bp+06],di
    79dd:619c    mov       word ptr es:[bp+02],0000
    79dd:61a2    add       bp,15
    79dd:61a5    mov       word ptr ss:[0AC7],bp
    79dd:61aa    cmp       bp,7F00
    79dd:61ae    jb        61B3
    79dd:61b0    call      MOREFR
    79dd:61b3    pop       bp
    79dd:61b4    pop       es
    79dd:61b5    jmp       61FA
    79dd:61b7    push      es
    79dd:61b8    push      bp
    79dd:61b9    push      cx
    79dd:61ba    push      ax
    79dd:61bb    mov       es,word ptr ss:[13A6]
    79dd:61c0    mov       bp,word ptr ss:[13A8]
    79dd:61c5    mov       ax,di
    79dd:61c7    sub       ax,word ptr ss:[13B4]
    79dd:61cc    xor       cx,cx
    79dd:61ce    add       ax,word ptr ss:[13BE]
    79dd:61d3    adc       cx,word ptr ss:[13BC]
    79dd:61d8    mov       word ptr es:[bp+00],ax
    79dd:61dc    mov       word ptr es:[bp+02],cx
    79dd:61e0    mov       byte ptr es:[bp+04],00
    79dd:61e5    add       bp,05
    79dd:61e8    mov       word ptr ss:[13A8],bp
    79dd:61ed    cmp       bp,3F00
    79dd:61f1    jb        61F6
    79dd:61f3    call      MOREEXT
    79dd:61f6    pop       ax
    79dd:61f7    pop       cx
    79dd:61f8    pop       bp
    79dd:61f9    pop       es
    79dd:61fa  - mov       al,E2
    79dd:61fc  - mov       ah,cl
    79dd:61fe  - stosw
    79dd:61ff  - ret
             P_SET:
    79dd:6200  - lodsb
    79dd:6201    xlat
    79dd:6203    or        al,al
    79dd:6205    js        P_SET
    79dd:6207    dec       si
    79dd:6208  - test      byte ptr ss:[0F8B],01
    79dd:620e    jne       SETSKIP
    79dd:6210  - mov       bp,word ptr ss:[13F0]
    79dd:6215    cmp       word ptr ss:[0F7A],bp
    79dd:621a    je        621F
    79dd:621c    jmp       P_EQUERR
    79dd:621f  - mov       ax,word ptr [0F84]
    79dd:6223    mov       word ptr [0F80],ax
    79dd:6227    mov       ax,word ptr [0F86]
    79dd:622b    mov       word ptr [0F82],ax
    79dd:622f    mov       ax,word ptr [0F70]
    79dd:6233    mov       word ptr [0F6E],ax
    79dd:6237  - call      CONVEXPRESS
    79dd:623a  - test      byte ptr ss:[0ACE],C0
    79dd:6240  - je        6245
    79dd:6242    jmp       P_EQUERR2
    79dd:6245  - push      es
    79dd:6246  - mov       es,word ptr ss:[0F7C]
    79dd:624b  - mov       bp,word ptr ss:[0F7E]
    79dd:6250  - mov       word ptr es:[bp+0A],dx
    79dd:6254  - mov       word ptr es:[bp+0C],cx
    79dd:6258  - or        byte ptr es:[bp+04],04
    79dd:625d  - pop       es
             SETSKIP:
    79dd:625e  - ret
             P_SHORTA:
    79dd:625f  - mov       al,byte ptr [si]
    79dd:6261    xlat
    79dd:6263    or        al,al
    79dd:6265    js        626A
    79dd:6267    jmp       PM
    79dd:626a  - call      MAP_SHORTA
    79dd:626d  - and       byte ptr ss:[0ABA],FE
    79dd:6273  - push      es
    79dd:6274  - mov       es,word ptr ss:[0AC1]
    79dd:6279  - mov       bp,word ptr ss:[0AC3]
    79dd:627e  - mov       word ptr es:[bp+0A],0000
    79dd:6284  - mov       word ptr es:[bp+0C],0000
    79dd:628a  - pop       es
    79dd:628b  - ret
             P_SHORTI:
    79dd:628c  - mov       al,byte ptr [si]
    79dd:628e    xlat
    79dd:6290    or        al,al
    79dd:6292    js        6297
    79dd:6294    jmp       PM
    79dd:6297  - call      MAP_SHORTI
    79dd:629a  - and       byte ptr ss:[0ABA],FD
    79dd:62a0  - push      es
    79dd:62a1  - mov       es,word ptr ss:[0ABD]
    79dd:62a6  - mov       bp,word ptr ss:[0ABF]
    79dd:62ab  - mov       word ptr es:[bp+0A],0000
    79dd:62b1  - mov       word ptr es:[bp+0C],0000
    79dd:62b7  - pop       es
    79dd:62b8  - ret
             P_STA:
    79dd:62b9  - call      GETEA
    79dd:62bc    mov       al,byte ptr [si]
    79dd:62be    xlat
    79dd:62c0    or        al,al
    79dd:62c2    js        62C7
    79dd:62c4    jmp       E_EXTRACHARS
    79dd:62c7    mov       ax,word ptr [bp+71F3]
    79dd:62cb    or        al,al
    79dd:62cd    je        62D7
    79dd:62cf    stosb
    79dd:62d0    mov       al,ah
    79dd:62d2    xor       ah,ah
    79dd:62d4    add       di,ax
    79dd:62d6    ret
    79dd:62d7    push      dx
    79dd:62d8    mov       dx,7F7F
    79dd:62db    call      ERROR_ROUT
    79dd:62de    pop       dx
    79dd:62df    ret
             P_STP:
    79dd:62e0  - mov       al,byte ptr [si]
    79dd:62e2    xlat
    79dd:62e4    or        al,al
    79dd:62e6    js        62EB
    79dd:62e8    jmp       PM
    79dd:62eb  - mov       al,DB
    79dd:62ed    stosb
    79dd:62ee  - ret
             P_STX:
    79dd:62ef  - call      GETEA
    79dd:62f2    mov       al,byte ptr [si]
    79dd:62f4    xlat
    79dd:62f6    or        al,al
    79dd:62f8    js        62FD
    79dd:62fa    jmp       E_EXTRACHARS
    79dd:62fd    mov       ax,word ptr [bp+7221]
    79dd:6301    or        al,al
    79dd:6303    je        630D
    79dd:6305    stosb
    79dd:6306    mov       al,ah
    79dd:6308    xor       ah,ah
    79dd:630a    add       di,ax
    79dd:630c    ret
    79dd:630d    push      dx
    79dd:630e    mov       dx,7F7F
    79dd:6311    call      ERROR_ROUT
    79dd:6314    pop       dx
    79dd:6315    ret
             P_SUPPRESS:
             P_SUPPRESS:
    79dd:6316  - mov       al,byte ptr [si]
    79dd:6318    xlat
    79dd:631a    or        al,al
    79dd:631c    js        6321
    79dd:631e    jmp       PM
    79dd:6321  - lodsb
    79dd:6322    xlat
    79dd:6324    or        al,al
    79dd:6326    js        6321
    79dd:6328    dec       si
    79dd:6329  - lodsw
    79dd:632a  - and       ax,DFDF
    79dd:632d  - cmp       ax,4157
    79dd:6330  - je        SUR_WA
    79dd:6332  - cmp       ax,5245
    79dd:6335  - je        SUR_ER
    79dd:6337  - cmp       ax,5845
    79dd:633a  - je        SUR_EX
    79dd:633c  - cmp       ax,4E41
    79dd:633f  - je        SUR_AN
    79dd:6341  - cmp       ax,5250
    79dd:6344  - je        SUR_PR
             SURERR:
    79dd:6346  - push      dx
    79dd:6347    mov       dx,8078
    79dd:634a    call      ERROR_ROUT
    79dd:634d    pop       dx
             SUR_PR:
    79dd:634e    lodsw
    79dd:634f  - and       ax,DFDF
    79dd:6352  - cmp       ax,4654
    79dd:6355  - jne       SURERR
    79dd:6357  - mov       byte ptr ss:[13EA],00
    79dd:635d  - ret
             SUR_AN:
    79dd:635e  - lodsw
    79dd:635f  - and       ax,DFDF
    79dd:6362  - cmp       ax,4953
    79dd:6365  - jne       SURERR
    79dd:6367  - mov       byte ptr ss:[13E8],00
    79dd:636d  - ret
             SUR_EX:
    79dd:636e  - lodsw
    79dd:636f  - and       ax,DFDF
    79dd:6372  - cmp       ax,5250
    79dd:6375  - jne       SURERR
    79dd:6377  - mov       byte ptr ss:[13E6],01
    79dd:637d  - ret
             SUR_WA:
    79dd:637e  - lodsw
    79dd:637f  - and       ax,DFDF
    79dd:6382  - cmp       ax,4E52
    79dd:6385  - jne       SURERR
    79dd:6387  - lodsw
    79dd:6388  - and       ax,DFDF
    79dd:638b  - cmp       ax,4E49
    79dd:638e  - jne       SURERR
    79dd:6390  - lodsw
    79dd:6391  - and       ax,DFDF
    79dd:6394  - cmp       ax,5347
    79dd:6397  - jne       SURERR
    79dd:6399  - mov       byte ptr ss:[13E7],01
    79dd:639f  - ret
             SUR_ER:
    79dd:63a0  - lodsw
    79dd:63a1  - and       ax,DFDF
    79dd:63a4  - cmp       ax,4F52
    79dd:63a7  - jne       SURERR
    79dd:63a9  - lodsw
    79dd:63aa  - and       ax,DFDF
    79dd:63ad  - cmp       ax,5352
    79dd:63b0  - jne       SURERR
    79dd:63b2  - mov       byte ptr ss:[13E9],01
    79dd:63b8  - ret
             P_RELEASE:
    79dd:63b9  - mov       al,byte ptr [si]
    79dd:63bb    xlat
    79dd:63bd    or        al,al
    79dd:63bf    js        63C4
    79dd:63c1    jmp       PM
    79dd:63c4  - lodsb
    79dd:63c5    xlat
    79dd:63c7    or        al,al
    79dd:63c9    js        63C4
    79dd:63cb    dec       si
    79dd:63cc  - lodsw
    79dd:63cd  - and       ax,DFDF
    79dd:63d0  - cmp       ax,4157
    79dd:63d3  - je        REL_WA
    79dd:63d5  - cmp       ax,5245
    79dd:63d8  - je        REL_ER
    79dd:63da  - cmp       ax,5845
    79dd:63dd  - je        REL_EX
    79dd:63df  - cmp       ax,4E41
    79dd:63e2  - je        REL_AN
    79dd:63e4  - cmp       ax,5250
    79dd:63e7  - je        REL_PR
    79dd:63e9  - jmp       SURERR
             REL_PR:
    79dd:63ec  - lodsw
    79dd:63ed  - and       ax,DFDF
    79dd:63f0  - cmp       ax,4654
    79dd:63f3  - je        63F8
    79dd:63f5    jmp       SURERR
    79dd:63f8  - mov       byte ptr ss:[13EA],00
    79dd:63fe  - ret
             REL_AN:
    79dd:63ff  - lodsw
    79dd:6400  - and       ax,DFDF
    79dd:6403  - cmp       ax,4953
    79dd:6406  - je        640B
    79dd:6408    jmp       SURERR
    79dd:640b  - mov       byte ptr ss:[13E8],01
    79dd:6411  - ret
             REL_EX:
    79dd:6412  - lodsw
    79dd:6413  - and       ax,DFDF
    79dd:6416  - cmp       ax,5250
    79dd:6419  - je        641E
    79dd:641b    jmp       SURERR
    79dd:641e  - mov       byte ptr ss:[13E6],00
    79dd:6424  - ret
             REL_WA:
    79dd:6425  - lodsw
    79dd:6426  - and       ax,DFDF
    79dd:6429  - cmp       ax,4E52
    79dd:642c  - je        6431
    79dd:642e    jmp       SURERR
    79dd:6431  - lodsw
    79dd:6432  - and       ax,DFDF
    79dd:6435  - cmp       ax,4E49
    79dd:6438  - je        643D
    79dd:643a    jmp       SURERR
    79dd:643d  - lodsw
    79dd:643e  - and       ax,DFDF
    79dd:6441  - cmp       ax,5347
    79dd:6444  - je        6449
    79dd:6446    jmp       SURERR
    79dd:6449  - mov       byte ptr ss:[13E7],00
    79dd:644f  - ret
             REL_ER:
    79dd:6450  - lodsw
    79dd:6451  - and       ax,DFDF
    79dd:6454  - cmp       ax,4F52
    79dd:6457  - je        645C
    79dd:6459    jmp       SURERR
    79dd:645c  - lodsw
    79dd:645d  - and       ax,DFDF
    79dd:6460  - cmp       ax,5352
    79dd:6463  - je        6468
    79dd:6465    jmp       SURERR
    79dd:6468  - mov       byte ptr ss:[13E9],00
    79dd:646e  - ret
             P_STY:
    79dd:646f  - call      GETEA
    79dd:6472    mov       al,byte ptr [si]
    79dd:6474    xlat
    79dd:6476    or        al,al
    79dd:6478    js        647D
    79dd:647a    jmp       E_EXTRACHARS
    79dd:647d    mov       ax,word ptr [bp+724F]
    79dd:6481    or        al,al
    79dd:6483    je        648D
    79dd:6485    stosb
    79dd:6486    mov       al,ah
    79dd:6488    xor       ah,ah
    79dd:648a    add       di,ax
    79dd:648c    ret
    79dd:648d    push      dx
    79dd:648e    mov       dx,7F7F
    79dd:6491    call      ERROR_ROUT
    79dd:6494    pop       dx
    79dd:6495    ret
             P_STZ:
    79dd:6496  - call      GETEA
    79dd:6499    mov       al,byte ptr [si]
    79dd:649b    xlat
    79dd:649d    or        al,al
    79dd:649f    js        64A4
    79dd:64a1    jmp       E_EXTRACHARS
    79dd:64a4    mov       ax,word ptr [bp+727D]
    79dd:64a8    or        al,al
    79dd:64aa    je        64B4
    79dd:64ac    stosb
    79dd:64ad    mov       al,ah
    79dd:64af    xor       ah,ah
    79dd:64b1    add       di,ax
    79dd:64b3    ret
    79dd:64b4    push      dx
    79dd:64b5    mov       dx,7F7F
    79dd:64b8    call      ERROR_ROUT
    79dd:64bb    pop       dx
    79dd:64bc    ret
    79dd:64bd  - ret
             P_TAX:
    79dd:64be  - mov       al,byte ptr [si]
    79dd:64c0    xlat
    79dd:64c2    or        al,al
    79dd:64c4    js        64C9
    79dd:64c6    jmp       PM
    79dd:64c9  - mov       al,AA
    79dd:64cb    stosb
    79dd:64cc  - ret
             P_TAY:
    79dd:64cd  - mov       al,byte ptr [si]
    79dd:64cf    xlat
    79dd:64d1    or        al,al
    79dd:64d3    js        64D8
    79dd:64d5    jmp       PM
    79dd:64d8  - mov       al,A8
    79dd:64da    stosb
    79dd:64db  - ret
             P_TCD:
    79dd:64dc  - mov       al,byte ptr [si]
    79dd:64de    xlat
    79dd:64e0    or        al,al
    79dd:64e2    js        64E7
    79dd:64e4    jmp       PM
    79dd:64e7  - mov       al,5B
    79dd:64e9    stosb
    79dd:64ea  - ret
             P_TCS:
    79dd:64eb  - mov       al,byte ptr [si]
    79dd:64ed    xlat
    79dd:64ef    or        al,al
    79dd:64f1    js        64F6
    79dd:64f3    jmp       PM
    79dd:64f6  - mov       al,1B
    79dd:64f8    stosb
    79dd:64f9  - ret
             P_TDC:
    79dd:64fa  - mov       al,7B
    79dd:64fc    stosb
    79dd:64fd  - ret
             P_TRB:
    79dd:64fe  - call      GETEA
    79dd:6501    mov       al,byte ptr [si]
    79dd:6503    xlat
    79dd:6505    or        al,al
    79dd:6507    js        650C
    79dd:6509    jmp       E_EXTRACHARS
    79dd:650c    mov       ax,word ptr [bp+72D9]
    79dd:6510    or        al,al
    79dd:6512    je        651C
    79dd:6514    stosb
    79dd:6515    mov       al,ah
    79dd:6517    xor       ah,ah
    79dd:6519    add       di,ax
    79dd:651b    ret
    79dd:651c    push      dx
    79dd:651d    mov       dx,7F7F
    79dd:6520    call      ERROR_ROUT
    79dd:6523    pop       dx
    79dd:6524    ret
             P_TSB:
    79dd:6525  - call      GETEA
    79dd:6528    mov       al,byte ptr [si]
    79dd:652a    xlat
    79dd:652c    or        al,al
    79dd:652e    js        6533
    79dd:6530    jmp       E_EXTRACHARS
    79dd:6533    mov       ax,word ptr [bp+72AB]
    79dd:6537    or        al,al
    79dd:6539    je        6543
    79dd:653b    stosb
    79dd:653c    mov       al,ah
    79dd:653e    xor       ah,ah
    79dd:6540    add       di,ax
    79dd:6542    ret
    79dd:6543    push      dx
    79dd:6544    mov       dx,7F7F
    79dd:6547    call      ERROR_ROUT
    79dd:654a    pop       dx
    79dd:654b    ret
    79dd:654c  - ret
             P_TSC:
    79dd:654d  - mov       al,3B
    79dd:654f    stosb
    79dd:6550  - ret
             P_TSX:
    79dd:6551  - mov       al,byte ptr [si]
    79dd:6553    xlat
    79dd:6555    or        al,al
    79dd:6557    js        655C
    79dd:6559    jmp       PM
    79dd:655c  - mov       al,BA
    79dd:655e    stosb
    79dd:655f  - ret
             P_TXA:
    79dd:6560  - mov       al,byte ptr [si]
    79dd:6562    xlat
    79dd:6564    or        al,al
    79dd:6566    js        656B
    79dd:6568    jmp       PM
    79dd:656b  - mov       al,8A
    79dd:656d    stosb
    79dd:656e  - ret
             P_TXS:
    79dd:656f  - mov       al,byte ptr [si]
    79dd:6571    xlat
    79dd:6573    or        al,al
    79dd:6575    js        657A
    79dd:6577    jmp       PM
    79dd:657a  - mov       al,9A
    79dd:657c    stosb
    79dd:657d  - ret
             P_TXY:
    79dd:657e  - mov       al,byte ptr [si]
    79dd:6580    xlat
    79dd:6582    or        al,al
    79dd:6584    js        6589
    79dd:6586    jmp       PM
    79dd:6589  - mov       al,9B
    79dd:658b    stosb
    79dd:658c  - ret
             P_TYA:
    79dd:658d  - mov       al,byte ptr [si]
    79dd:658f    xlat
    79dd:6591    or        al,al
    79dd:6593    js        6598
    79dd:6595    jmp       PM
    79dd:6598  - mov       al,98
    79dd:659a    stosb
    79dd:659b  - ret
             P_TYX:
    79dd:659c  - mov       al,byte ptr [si]
    79dd:659e    xlat
    79dd:65a0    or        al,al
    79dd:65a2    js        65A7
    79dd:65a4    jmp       PM
    79dd:65a7  - mov       al,BB
    79dd:65a9    stosb
    79dd:65aa  - ret
             P_TYPE:
    79dd:65ab  - lodsb
    79dd:65ac    xlat
    79dd:65ae    or        al,al
    79dd:65b0    js        P_TYPE
    79dd:65b2    dec       si
    79dd:65b3  - call      COPYNAMENID
    79dd:65b6    push      di
    79dd:65b7  - push      es
    79dd:65b8  - push      si
    79dd:65b9  - push      ds
    79dd:65ba  - mov       ds,word ptr ss:[9A7C]
    79dd:65bf  - mov       dx,word ptr ss:[9A7E]
    79dd:65c4  - call      far ptr _OS2OPENFILE
    79dd:65c9  - jb        TYPEFAIL2
    79dd:65cb  - mov       bx,ax
             TYPELP:
    79dd:65cd  - mov       ds,word ptr ss:[0ED9]
    79dd:65d2  - mov       cx,word ptr ss:[0EDB]
    79dd:65d7  - mov       dx,1F00
    79dd:65da  - sub       dx,cx
    79dd:65dc  - xchg      cx,dx
    79dd:65de  - push      bx
    79dd:65df  - push      cx
    79dd:65e0  - call      far ptr _OS2READBYTES
    79dd:65e5  - jb        TYPEFAIL
    79dd:65e7  - push      ax
    79dd:65e8  - mov       cx,ax
    79dd:65ea  - mov       ds,word ptr ss:[0ED9]
    79dd:65ef  - mov       dx,word ptr ss:[0EDB]
    79dd:65f4  - mov       bx,0001
    79dd:65f7  - call      far ptr _OS2WRITEBYTES
    79dd:65fc  - pop       ax
    79dd:65fd  - pop       cx
    79dd:65fe  - pop       bx
    79dd:65ff  - cmp       ax,cx
    79dd:6601  - je        TYPELP
    79dd:6603  - call      far ptr _OS2CLOSEFILE
    79dd:6608  - pop       ds
    79dd:6609  - pop       si
    79dd:660a  - pop       es
    79dd:660b  - pop       di
    79dd:660c  - ret
             TYPEFAIL:
    79dd:660d  - pop       cx
    79dd:660e  - pop       bx
             TYPEFAIL2:
    79dd:660f  - pop       ds
    79dd:6610  - pop       si
    79dd:6611  - pop       es
    79dd:6612  - pop       di
    79dd:6613  - push      dx
    79dd:6614    mov       dx,80FF
    79dd:6617    call      ERROR_ROUT
    79dd:661a    pop       dx
             P_TIME:
    79dd:661b  - lodsb
    79dd:661c    xlat
    79dd:661e    or        al,al
    79dd:6620    js        P_TIME
    79dd:6622    dec       si
    79dd:6623  - call      far ptr _OS2GETTIME
    79dd:6628  - push      dx
    79dd:6629  - push      cx
    79dd:662a  - call      ADDSYMBOL
    79dd:662d  - pop       cx
    79dd:662e  - pop       dx
    79dd:662f  - mov       bx,76A7
    79dd:6632  - test      byte ptr ss:[0F8B],01
    79dd:6638  - jne       NOTIME
    79dd:663a  - push      es
    79dd:663b  - mov       es,word ptr ss:[0F7C]
    79dd:6640  - mov       bp,word ptr ss:[0F7E]
    79dd:6645  - and       byte ptr es:[bp+04],EF
    79dd:664a  - or        byte ptr es:[bp+04],05
    79dd:664f  - mov       word ptr es:[bp+0A],cx
    79dd:6653  - mov       word ptr es:[bp+0C],dx
    79dd:6657  - mov       ax,word ptr [0F84]
    79dd:665b    mov       word ptr [0F80],ax
    79dd:665f    mov       ax,word ptr [0F86]
    79dd:6663    mov       word ptr [0F82],ax
    79dd:6667    mov       ax,word ptr [0F70]
    79dd:666b    mov       word ptr [0F6E],ax
    79dd:666f  - pop       es
             NOTIME:
    79dd:6670  - ret
             P_UPPER:
    79dd:6671  - lodsb
    79dd:6672    xlat
    79dd:6674    or        al,al
    79dd:6676    js        P_UPPER
    79dd:6678    dec       si
    79dd:6679  - call      GETSTRINGADDR
    79dd:667c  - push      ds
    79dd:667d  - push      si
    79dd:667e  - mov       si,cx
    79dd:6680  - mov       ds,dx
             UPLP:
    79dd:6682  - lodsb
    79dd:6683  - or        al,al
    79dd:6685  - je        UPEXIT
    79dd:6687  - cmp       al,61
    79dd:6689  - jb        UPLP
    79dd:668b  - cmp       al,7A
    79dd:668d  - ja        UPLP
    79dd:668f  - and       al,DF
    79dd:6691  - mov       byte ptr [si+FF],al
    79dd:6694  - jmp       UPLP
             UPEXIT:
    79dd:6696  - pop       si
    79dd:6697  - pop       ds
    79dd:6698  - ret
             P_WAI:
    79dd:6699  - inc       si
    79dd:669a  - mov       al,byte ptr [si]
    79dd:669c    xlat
    79dd:669e    or        al,al
    79dd:66a0    js        66A5
    79dd:66a2    jmp       PM
    79dd:66a5  - mov       al,CB
    79dd:66a7    stosb
    79dd:66a8  - ret
             P_WRITE:
    79dd:66a9  - lodsb
    79dd:66aa    xlat
    79dd:66ac    or        al,al
    79dd:66ae    js        P_WRITE
    79dd:66b0    dec       si
    79dd:66b1  - lodsw
    79dd:66b2  - and       ax,DFDF
    79dd:66b5  - cmp       ax,4E4F
    79dd:66b8  - je        P_WRITEON
    79dd:66ba  - cmp       ax,464F
    79dd:66bd  - je        P_WRITEOFF
    79dd:66bf  - dec       si
    79dd:66c0  - push      dx
    79dd:66c1    mov       dx,8078
    79dd:66c4    call      ERROR_ROUT
    79dd:66c7    pop       dx
             P_WRITEON:
    79dd:66c8    or        byte ptr ss:[13BA],04
    79dd:66ce  - ret
             P_WRITEOFF:
    79dd:66cf  - and       byte ptr ss:[13BA],FB
    79dd:66d5  - ret
             P_XBA:
             P_SWA:
    79dd:66d6  - mov       al,EB
    79dd:66d8    stosb
    79dd:66d9  - ret
             P_XCE:
    79dd:66da  - mov       al,FB
    79dd:66dc    stosb
    79dd:66dd  - ret
             P_A:
    79dd:66de  - and       ah,DF
    79dd:66e1  - cmp       ah,44
    79dd:66e4  - je        P_AD
    79dd:66e6  - cmp       ah,53
             LOCALEND:
    79dd:66e7    cld
    79dd:66e8    push      bx
    79dd:66e9  - je        P_AS
    79dd:66eb  - cmp       ah,4E
    79dd:66ee  - je        66F3
    79dd:66f0    jmp       PM
    79dd:66f3  - lodsb
    79dd:66f4  - and       al,DF
    79dd:66f6  - cmp       al,44
    79dd:66f8  - jne       66FD
    79dd:66fa    jmp       P_AND
    79dd:66fd  - jmp       PM
             P_AD:
    79dd:6700  - lodsb
    79dd:6701  - and       al,DF
    79dd:6703  - cmp       al,43
    79dd:6705  - jne       670A
    79dd:6707    jmp       P_ADC
    79dd:670a  - jmp       PM
             P_AS:
    79dd:670d  - lodsb
    79dd:670e  - and       al,DF
    79dd:6710  - cmp       al,4C
    79dd:6712  - jne       6717
    79dd:6714    jmp       P_ASL
    79dd:6717  - jmp       PM
             P_B:
    79dd:671a  - mov       al,ah
    79dd:671c  - xor       ah,ah
    79dd:671e  - xlat
    79dd:6720  - sub       al,41
    79dd:6722  - jge       6727
    79dd:6724    jmp       PM
    79dd:6727  - shl       al,1
    79dd:6729  - mov       bp,ax
    79dd:672b  - jmp       word ptr [bp+66F7]
             P_BC:
    79dd:672f  - lodsb
    79dd:6730  - and       al,DF
    79dd:6732  - cmp       al,53
    79dd:6734  - jne       6739
    79dd:6736    jmp       P_BCS
    79dd:6739  - cmp       al,43
    79dd:673b  - jne       6740
    79dd:673d    jmp       P_BCC
    79dd:6740  - jmp       PM
             P_BE:
    79dd:6743  - lodsb
    79dd:6744    and       al,DF
    79dd:6746    cmp       al,51
    79dd:6748    je        674D
    79dd:674a    jmp       PM
    79dd:674d    mov       al,byte ptr [si]
    79dd:674f    xlat
    79dd:6751    or        al,al
    79dd:6753    jns       P_BI
    79dd:6755    jmp       P_BEQ
             P_BI:
    79dd:6758    lodsb
    79dd:6759  - and       al,DF
    79dd:675b  - cmp       al,54
    79dd:675d  - jne       6762
    79dd:675f    jmp       P_BIT
    79dd:6762  - jmp       PM
             P_BM:
    79dd:6765  - lodsb
    79dd:6766    and       al,DF
    79dd:6768    cmp       al,49
    79dd:676a    je        676F
    79dd:676c    jmp       PM
    79dd:676f    mov       al,byte ptr [si]
    79dd:6771    xlat
    79dd:6773    or        al,al
    79dd:6775    jns       P_BN
    79dd:6777    jmp       P_BMI
             P_BN:
    79dd:677a  - lodsb
    79dd:677b    and       al,DF
    79dd:677d    cmp       al,45
    79dd:677f    je        6784
    79dd:6781    jmp       PM
    79dd:6784    mov       al,byte ptr [si]
    79dd:6786    xlat
    79dd:6788    or        al,al
    79dd:678a    jns       P_BP
    79dd:678c    jmp       P_BNE
             P_BP:
    79dd:678f  - lodsb
    79dd:6790    and       al,DF
    79dd:6792    cmp       al,4C
    79dd:6794    je        6799
    79dd:6796    jmp       PM
    79dd:6799    mov       al,byte ptr [si]
    79dd:679b    xlat
    79dd:679d    or        al,al
    79dd:679f    jns       P_BR
    79dd:67a1    jmp       P_BPL
             P_BR:
    79dd:67a4    lodsb
    79dd:67a5  - and       al,DF
    79dd:67a7  - cmp       al,41
    79dd:67a9  - jne       67AE
    79dd:67ab    jmp       P_BRA
    79dd:67ae  - cmp       al,4B
    79dd:67b0  - jne       67B5
    79dd:67b2    jmp       P_BRK
    79dd:67b5  - cmp       al,4C
    79dd:67b7  - jne       67BC
    79dd:67b9    jmp       P_BRL
    79dd:67bc  - jmp       PM
             P_BV:
    79dd:67bf  - lodsb
    79dd:67c0  - and       al,DF
    79dd:67c2  - cmp       al,53
    79dd:67c4  - jne       67C9
    79dd:67c6    jmp       P_BVS
    79dd:67c9  - cmp       al,43
    79dd:67cb  - jne       67D0
    79dd:67cd    jmp       P_BVC
    79dd:67d0  - jmp       PM
             P_C:
    79dd:67d3  - and       ah,DF
    79dd:67d6  - cmp       ah,4C
    79dd:67d9  - je        P_CL
    79dd:67db  - cmp       ah,4D
    79dd:67de  - je        P_CM
    79dd:67e0  - cmp       ah,4F
    79dd:67e3  - je        P_CO
    79dd:67e5  - cmp       ah,50
    79dd:67e8  - je        P_CP
    79dd:67ea  - cmp       ah,48
    79dd:67ed  - je        P_CH
    79dd:67ef  - jmp       PM
             P_CH:
    79dd:67f2  - lodsw
    79dd:67f3  - and       ax,DFDF
    79dd:67f6  - cmp       ax,4345
    79dd:67f9  - je        67FE
    79dd:67fb    jmp       PM
    79dd:67fe  - lodsw
    79dd:67ff  - and       ax,DFDF
    79dd:6802  - cmp       ax,4D4B
    79dd:6805  - je        680A
    79dd:6807    jmp       PM
    79dd:680a  - lodsw
    79dd:680b  - and       ax,DFDF
    79dd:680e  - cmp       ax,4341
    79dd:6811  - jne       6816
    79dd:6813    jmp       P_CHECKMAC
    79dd:6816  - jmp       PM
             P_CL:
    79dd:6819  - lodsb
    79dd:681a  - and       al,DF
    79dd:681c  - cmp       al,43
    79dd:681e  - jne       6823
    79dd:6820    jmp       P_CLC
    79dd:6823  - cmp       al,44
    79dd:6825  - jne       682A
    79dd:6827    jmp       P_CLD
    79dd:682a  - cmp       al,49
    79dd:682c  - jne       6831
    79dd:682e    jmp       P_CLI
    79dd:6831  - cmp       al,56
    79dd:6833  - jne       6838
    79dd:6835    jmp       P_CLV
    79dd:6838  - jmp       PM
             P_CM:
    79dd:683b  - lodsb
    79dd:683c  - and       al,DF
    79dd:683e  - cmp       al,50
    79dd:6840  - jne       6845
    79dd:6842    jmp       P_CMP
    79dd:6845  - jmp       PM
             P_CO:
    79dd:6848  - lodsb
    79dd:6849    and       al,DF
    79dd:684b    cmp       al,50
    79dd:684d    je        6852
    79dd:684f    jmp       PM
    79dd:6852    mov       al,byte ptr [si]
    79dd:6854    xlat
    79dd:6856    or        al,al
    79dd:6858    jns       P_CP
    79dd:685a    jmp       P_COP
             P_CP:
    79dd:685d    lodsb
    79dd:685e  - and       al,DF
    79dd:6860  - cmp       al,58
    79dd:6862  - jne       6867
    79dd:6864    jmp       P_CPX
    79dd:6867  - cmp       al,59
    79dd:6869  - jne       686E
    79dd:686b    jmp       P_CPY
    79dd:686e  - jmp       PM
             P_D:
    79dd:6871  - and       ah,DF
    79dd:6874  - cmp       ah,45
    79dd:6877  - jne       P_DX
             P_DE:
    79dd:6879  - lodsb
    79dd:687a  - and       al,DF
    79dd:687c  - cmp       al,43
    79dd:687e  - jne       6883
    79dd:6880    jmp       P_DEC
    79dd:6883  - cmp       al,58
    79dd:6885  - jne       688A
    79dd:6887    jmp       P_DEX
    79dd:688a  - cmp       al,59
    79dd:688c  - jne       6891
    79dd:688e    jmp       P_DEY
    79dd:6891  - cmp       al,46
    79dd:6893  - je        P_DEF
    79dd:6895  - jmp       PM
             P_DEF:
    79dd:6898  - lodsw
    79dd:6899  - and       ax,DFDF
    79dd:689c  - cmp       al,53
    79dd:689e  - jne       68A3
    79dd:68a0    jmp       P_DEFS
    79dd:68a3  - cmp       ax,5245
    79dd:68a6  - je        P_DEFER
    79dd:68a8  - cmp       ax,4E45
    79dd:68ab  - je        68B0
    79dd:68ad    jmp       PM
    79dd:68b0  - lodsb
    79dd:68b1    and       al,DF
    79dd:68b3    cmp       al,44
    79dd:68b5    je        68BA
    79dd:68b7    jmp       PM
    79dd:68ba    mov       al,byte ptr [si]
    79dd:68bc    xlat
    79dd:68be    or        al,al
    79dd:68c0    jns       P_DEFER
    79dd:68c2    jmp       P_DEFEND
             P_DEFER:
    79dd:68c5    lodsw
    79dd:68c6  - and       ax,DFDF
    79dd:68c9  - cmp       ax,4F52
    79dd:68cc  - je        68D1
    79dd:68ce    jmp       PM
    79dd:68d1  - lodsb
    79dd:68d2    and       al,DF
    79dd:68d4    cmp       al,52
    79dd:68d6    je        68DB
    79dd:68d8    jmp       PM
    79dd:68db    mov       al,byte ptr [si]
    79dd:68dd    xlat
    79dd:68df    or        al,al
    79dd:68e1    jns       P_DX
    79dd:68e3    jmp       P_DEFERROR
             P_DX:
    79dd:68e6    cmp       ah,42
    79dd:68e9  - jne       68EE
    79dd:68eb    jmp       P_DB
    79dd:68ee  - cmp       ah,57
    79dd:68f1  - jne       68F6
    79dd:68f3    jmp       P_DW
    79dd:68f6  - cmp       ah,53
    79dd:68f9  - jne       68FE
    79dd:68fb    jmp       P_DS
    79dd:68fe  - cmp       ah,41
    79dd:6901  - je        6906
    79dd:6903    jmp       PM
    79dd:6906  - lodsw
    79dd:6907  - and       ax,DFDF
    79dd:690a  - cmp       ax,4554
    79dd:690d  - je        6912
    79dd:690f    jmp       PM
    79dd:6912  - mov       al,byte ptr [si]
    79dd:6914    xlat
    79dd:6916    or        al,al
    79dd:6918    js        691D
    79dd:691a    jmp       PM
    79dd:691d  - lodsb
    79dd:691e    xlat
    79dd:6920    or        al,al
    79dd:6922    js        691D
    79dd:6924    dec       si
    79dd:6925  - call      ADDSYMBOL
    79dd:6928  - mov       bx,76A7
    79dd:692b  - test      byte ptr ss:[0F8B],01
    79dd:6931  - jne       NODATE
    79dd:6933  - push      es
    79dd:6934  - push      di
    79dd:6935  - call      far ptr _OS2GETDATE
    79dd:693a  - mov       es,word ptr ss:[0F7C]
    79dd:693f  - mov       bp,word ptr ss:[0F7E]
    79dd:6944  - mov       byte ptr es:[bp+04],05
    79dd:6949  - mov       word ptr es:[bp+0A],cx
    79dd:694d  - mov       word ptr es:[bp+0C],dx
    79dd:6951  - mov       ax,word ptr [0F84]
    79dd:6955    mov       word ptr [0F80],ax
    79dd:6959    mov       ax,word ptr [0F86]
    79dd:695d    mov       word ptr [0F82],ax
    79dd:6961    mov       ax,word ptr [0F70]
    79dd:6965    mov       word ptr [0F6E],ax
    79dd:6969  - pop       di
    79dd:696a  - pop       es
             NODATE:
    79dd:696b  - ret
             P_E:
    79dd:696c  - and       ah,DF
    79dd:696f  - cmp       ah,4F
    79dd:6972  - jne       6977
    79dd:6974    jmp       P_EO
    79dd:6977  - cmp       ah,4E
    79dd:697a  - jne       697F
    79dd:697c    jmp       P_EN
    79dd:697f  - cmp       ah,51
    79dd:6982  - je        P_EQ
    79dd:6984  - cmp       ah,4C
    79dd:6987  - je        P_EL
    79dd:6989  - cmp       ah,58
    79dd:698c  - jne       6991
    79dd:698e    jmp       P_EX
    79dd:6991  - cmp       ah,52
    79dd:6994  - jne       6999
    79dd:6996    jmp       P_ER
    79dd:6999  - jmp       PM
             P_EL:
    79dd:699c  - lodsb
    79dd:699d  - and       al,DF
    79dd:699f  - cmp       al,53
    79dd:69a1  - je        P_ELS
    79dd:69a3    jmp       PM
             P_ELS:
    79dd:69a6  - lodsb
    79dd:69a7  - and       al,DF
    79dd:69a9  - cmp       al,45
    79dd:69ab  - je        69B0
    79dd:69ad    jmp       PM
    79dd:69b0  - lodsb
    79dd:69b1  - and       al,DF
    79dd:69b3  - cmp       al,49
    79dd:69b5  - je        69BA
    79dd:69b7    jmp       PM
    79dd:69ba  - lodsb
    79dd:69bb    and       al,DF
    79dd:69bd    cmp       al,46
    79dd:69bf    je        69C4
    79dd:69c1    jmp       PM
    79dd:69c4    mov       al,byte ptr [si]
    79dd:69c6    xlat
    79dd:69c8    or        al,al
    79dd:69ca    jns       P_EQ
    79dd:69cc    jmp       P_ELSEIF
             P_EQ:
    79dd:69cf    lodsb
    79dd:69d0  - and       al,DF
    79dd:69d2  - cmp       al,55
    79dd:69d4  - je        M_EQU
    79dd:69d6    jmp       PM
             M_EQU:
    79dd:69d9  - mov       al,byte ptr [si]
    79dd:69db  - xlat
    79dd:69dd  - or        al,al
    79dd:69df  - jns       69E4
    79dd:69e1    jmp       P_EQU
    79dd:69e4  - lodsb
    79dd:69e5    and       al,DF
    79dd:69e7    cmp       al,52
    79dd:69e9    je        69EE
    79dd:69eb    jmp       PM
    79dd:69ee    mov       al,byte ptr [si]
    79dd:69f0    xlat
    79dd:69f2    or        al,al
    79dd:69f4    jns       P_EO
    79dd:69f6    jmp       P_EQUR
             P_EO:
    79dd:69f9    lodsb
    79dd:69fa  - and       al,DF
    79dd:69fc  - cmp       al,52
    79dd:69fe  - jne       6A03
    79dd:6a00    jmp       P_EOR
    79dd:6a03  - jmp       PM
             P_EN:
    79dd:6a06  - lodsb
    79dd:6a07  - and       al,DF
    79dd:6a09  - cmp       al,44
    79dd:6a0b  - je        M_END
    79dd:6a0d    jmp       PM
             M_END:
    79dd:6a10  - mov       al,byte ptr [si]
    79dd:6a12  - and       al,DF
    79dd:6a14  - cmp       al,52
    79dd:6a16  - jne       6A1B
    79dd:6a18    jmp       P_ENDR
    79dd:6a1b  - cmp       al,43
    79dd:6a1d  - jne       6A22
    79dd:6a1f    jmp       P_ENDC
    79dd:6a22  - cmp       al,4D
    79dd:6a24  - jne       6A29
    79dd:6a26    jmp       P_ENDM
    79dd:6a29  - jmp       P_END
             P_EX:
    79dd:6a2c  - lodsw
    79dd:6a2d  - and       ax,DFDF
    79dd:6a30  - cmp       ax,4554
    79dd:6a33  - je        6A38
    79dd:6a35    jmp       PM
    79dd:6a38  - lodsw
    79dd:6a39  - and       ax,DFDF
    79dd:6a3c  - cmp       ax,4E52
    79dd:6a3f  - jne       6A44
    79dd:6a41    jmp       P_EXTERN
    79dd:6a44  - jmp       PM
             P_ER:
    79dd:6a47  - lodsw
    79dd:6a48  - and       ax,DFDF
    79dd:6a4b  - cmp       ax,4F52
    79dd:6a4e  - je        6A53
    79dd:6a50    jmp       PM
    79dd:6a53  - lodsb
    79dd:6a54  - and       al,DF
    79dd:6a56  - cmp       al,52
    79dd:6a58  - je        6A5D
    79dd:6a5a    jmp       PM
    79dd:6a5d  - lodsb
    79dd:6a5e  - cmp       al,2B
    79dd:6a60  - je        6A65
    79dd:6a62    jmp       PM
    79dd:6a65  - mov       al,byte ptr [si]
    79dd:6a67    xlat
    79dd:6a69    or        al,al
    79dd:6a6b    js        6A70
    79dd:6a6d    jmp       PM
    79dd:6a70    inc       word ptr ss:[13C4]
    79dd:6a75  - ret
             P_F:
    79dd:6a76  - dec       si
    79dd:6a77  - lodsw
    79dd:6a78  - and       ax,DFDF
    79dd:6a7b  - cmp       ax,4941
    79dd:6a7e  - je        P_FAI
    79dd:6a80  - cmp       ax,504F
    79dd:6a83  - je        P_FOP
    79dd:6a85  - cmp       ax,4C43
    79dd:6a88  - je        P_FCL
    79dd:6a8a  - jmp       PM
             P_FAI:
    79dd:6a8d  - lodsb
    79dd:6a8e    and       al,DF
    79dd:6a90    cmp       al,4C
    79dd:6a92    je        6A97
    79dd:6a94    jmp       PM
    79dd:6a97    mov       al,byte ptr [si]
    79dd:6a99    xlat
    79dd:6a9b    or        al,al
    79dd:6a9d    jns       P_FOP
    79dd:6a9f    jmp       P_FAIL
             P_FOP:
    79dd:6aa2    lodsw
    79dd:6aa3  - and       ax,DFDF
    79dd:6aa6  - cmp       ax,4E45
    79dd:6aa9  - jne       6AAE
    79dd:6aab    jmp       P_FOPEN
    79dd:6aae  - jmp       PM
             P_FCL:
    79dd:6ab1  - lodsw
    79dd:6ab2  - and       ax,DFDF
    79dd:6ab5  - cmp       ax,534F
    79dd:6ab8  - je        6ABD
    79dd:6aba    jmp       PM
    79dd:6abd  - lodsb
    79dd:6abe    and       al,DF
    79dd:6ac0    cmp       al,45
    79dd:6ac2    je        6AC7
    79dd:6ac4    jmp       PM
    79dd:6ac7    mov       al,byte ptr [si]
    79dd:6ac9    xlat
    79dd:6acb    or        al,al
    79dd:6acd    jns       P_G
    79dd:6acf    jmp       P_FCLOSE
             P_G:
    79dd:6ad2    and       ah,DF
    79dd:6ad5  - cmp       ah,45
    79dd:6ad8  - je        6ADD
    79dd:6ada    jmp       PM
    79dd:6add  - lodsb
    79dd:6ade  - and       al,DF
    79dd:6ae0  - cmp       al,54
    79dd:6ae2  - je        6AE7
    79dd:6ae4    jmp       PM
    79dd:6ae7  - lodsw
    79dd:6ae8  - and       ax,DFDF
    79dd:6aeb  - cmp       ax,4E45
    79dd:6aee  - je        6AF3
    79dd:6af0    jmp       PM
    79dd:6af3  - lodsb
    79dd:6af4  - and       al,DF
    79dd:6af6  - cmp       al,56
    79dd:6af8  - je        6AFD
    79dd:6afa    jmp       PM
    79dd:6afd  - jmp       P_GETENV
             P_I:
    79dd:6b00  - and       ah,DF
    79dd:6b03  - cmp       ah,4E
    79dd:6b06  - je        P_IN
    79dd:6b08  - cmp       ah,46
    79dd:6b0b  - jne       6B10
    79dd:6b0d    jmp       P_IF
    79dd:6b10  - cmp       ah,52
    79dd:6b13  - jne       6B18
    79dd:6b15    jmp       P_IR
    79dd:6b18  - jmp       PM
             P_IN:
    79dd:6b1b  - lodsb
    79dd:6b1c  - and       al,DF
    79dd:6b1e  - cmp       al,43
    79dd:6b20  - je        P_INC2
    79dd:6b22  - cmp       al,58
    79dd:6b24  - jne       6B29
    79dd:6b26    jmp       P_INX
    79dd:6b29  - cmp       al,59
    79dd:6b2b  - jne       6B30
    79dd:6b2d    jmp       P_INY
    79dd:6b30  - cmp       al,41
    79dd:6b32  - jne       6B37
    79dd:6b34    jmp       P_INA
    79dd:6b37  - jmp       PM
             P_INC2:
    79dd:6b3a  - lodsb
    79dd:6b3b  - and       al,DF
    79dd:6b3d  - cmp       al,4C
    79dd:6b3f  - je        P_INCL
    79dd:6b41  - cmp       al,42
    79dd:6b43  - je        P_INCB
    79dd:6b45  - cmp       al,43
    79dd:6b47  - je        P_INCC
    79dd:6b49  - cmp       al,44
    79dd:6b4b  - je        P_INCD
    79dd:6b4d    jmp       P_INC
             P_INCD:
    79dd:6b50  - lodsb
    79dd:6b51  - and       al,DF
    79dd:6b53  - cmp       al,49
    79dd:6b55  - je        6B5A
    79dd:6b57    jmp       PM
    79dd:6b5a  - lodsb
    79dd:6b5b    and       al,DF
    79dd:6b5d    cmp       al,52
    79dd:6b5f    je        6B64
    79dd:6b61    jmp       PM
    79dd:6b64    mov       al,byte ptr [si]
    79dd:6b66    xlat
    79dd:6b68    or        al,al
    79dd:6b6a    jns       6B6F
    79dd:6b6c    jmp       P_INCDIR
    79dd:6b6f  - jmp       PM
             P_INCB:
    79dd:6b72  - lodsb
    79dd:6b73  - and       al,DF
    79dd:6b75  - cmp       al,49
    79dd:6b77  - je        6B7C
    79dd:6b79    jmp       PM
    79dd:6b7c  - lodsb
    79dd:6b7d    and       al,DF
    79dd:6b7f    cmp       al,4E
    79dd:6b81    je        6B86
    79dd:6b83    jmp       PM
    79dd:6b86    mov       al,byte ptr [si]
    79dd:6b88    xlat
    79dd:6b8a    or        al,al
    79dd:6b8c    jns       6B91
    79dd:6b8e    jmp       P_INCBIN
    79dd:6b91  - jmp       PM
             P_INCL:
    79dd:6b94  - lodsb
    79dd:6b95  - and       al,DF
    79dd:6b97  - cmp       al,55
    79dd:6b99  - je        6B9E
    79dd:6b9b    jmp       PM
    79dd:6b9e  - lodsb
    79dd:6b9f  - and       al,DF
    79dd:6ba1  - cmp       al,44
    79dd:6ba3  - je        6BA8
    79dd:6ba5    jmp       PM
    79dd:6ba8  - lodsb
    79dd:6ba9    and       al,DF
    79dd:6bab    cmp       al,45
    79dd:6bad    je        6BB2
    79dd:6baf    jmp       PM
    79dd:6bb2    mov       al,byte ptr [si]
    79dd:6bb4    xlat
    79dd:6bb6    or        al,al
    79dd:6bb8    jns       6BBD
    79dd:6bba    jmp       P_INCLUDE
    79dd:6bbd  - jmp       PM
             P_INCC:
    79dd:6bc0  - lodsb
    79dd:6bc1  - and       al,DF
    79dd:6bc3  - cmp       al,4F
    79dd:6bc5  - je        6BCA
    79dd:6bc7    jmp       PM
    79dd:6bca  - lodsb
    79dd:6bcb  - and       al,DF
    79dd:6bcd  - cmp       al,4C
    79dd:6bcf  - je        6BD4
    79dd:6bd1    jmp       PM
    79dd:6bd4  - lodsb
    79dd:6bd5  - xlat
    79dd:6bd7  - or        al,al
    79dd:6bd9  - jns       6BDE
    79dd:6bdb    jmp       P_INCCOL
    79dd:6bde  - jmp       PM
             P_IR:
    79dd:6be1  - lodsb
    79dd:6be2  - and       al,DF
    79dd:6be4  - cmp       al,50
    79dd:6be6  - jne       6BEB
    79dd:6be8    jmp       M_IRP
    79dd:6beb  - cmp       al,53
    79dd:6bed  - jne       6BF2
    79dd:6bef    jmp       M_IRS
    79dd:6bf2  - jmp       PM
             P_J:
    79dd:6bf5  - and       ah,DF
    79dd:6bf8  - cmp       ah,4D
    79dd:6bfb  - je        P_JM
    79dd:6bfd  - cmp       ah,53
    79dd:6c00  - je        P_JS
    79dd:6c02  - jmp       PM
             P_JM:
    79dd:6c05  - lodsb
    79dd:6c06  - and       al,DF
    79dd:6c08  - cmp       al,4C
    79dd:6c0a  - jne       6C0F
    79dd:6c0c    jmp       P_JML
    79dd:6c0f  - cmp       al,50
    79dd:6c11  - jne       6C16
    79dd:6c13    jmp       P_JMP
    79dd:6c16  - jmp       PM
             P_JS:
    79dd:6c19  - lodsb
    79dd:6c1a  - and       al,DF
    79dd:6c1c  - cmp       al,4C
    79dd:6c1e  - jne       6C23
    79dd:6c20    jmp       P_JSL
    79dd:6c23  - cmp       al,52
    79dd:6c25  - jne       6C2A
    79dd:6c27    jmp       P_JSR
    79dd:6c2a  - jmp       PM
             P_L:
    79dd:6c2d  - and       ah,DF
    79dd:6c30  - cmp       ah,44
    79dd:6c33  - jne       P_LS
    79dd:6c35  - lodsb
    79dd:6c36  - and       al,DF
    79dd:6c38  - cmp       al,41
    79dd:6c3a  - jne       6C3F
    79dd:6c3c    jmp       P_LDA
    79dd:6c3f  - cmp       al,58
    79dd:6c41  - jne       6C46
    79dd:6c43    jmp       P_LDX
    79dd:6c46  - cmp       al,59
    79dd:6c48  - jne       6C4D
    79dd:6c4a    jmp       P_LDY
    79dd:6c4d  - jmp       PM
             P_LS:
    79dd:6c50  - cmp       ah,4F
    79dd:6c53  - je        P_LO
    79dd:6c55  - cmp       ah,49
    79dd:6c58  - je        P_LI
    79dd:6c5a  - cmp       ah,53
    79dd:6c5d  - je        6C62
    79dd:6c5f    jmp       PM
    79dd:6c62  - lodsb
    79dd:6c63  - and       al,DF
    79dd:6c65  - cmp       al,52
    79dd:6c67  - jne       6C6C
    79dd:6c69    jmp       P_LSR
    79dd:6c6c  - jmp       PM
             P_LO:
    79dd:6c6f  - lodsw
    79dd:6c70  - and       ax,DFDF
    79dd:6c73  - cmp       ax,474E
    79dd:6c76  - jne       NO_LO
    79dd:6c78  - lodsb
    79dd:6c79  - and       al,DF
    79dd:6c7b  - cmp       al,41
    79dd:6c7d  - jne       6C82
    79dd:6c7f    jmp       P_LONGA
    79dd:6c82  - cmp       al,49
    79dd:6c84  - jne       6C89
    79dd:6c86    jmp       P_LONGI
    79dd:6c89  - jmp       PM
             NO_LO:
    79dd:6c8c  - cmp       ax,4143
    79dd:6c8f  - jne       NO_LOAC
    79dd:6c91  - lodsb
    79dd:6c92    and       al,DF
    79dd:6c94    cmp       al,4C
    79dd:6c96    je        6C9B
    79dd:6c98    jmp       PM
    79dd:6c9b    mov       al,byte ptr [si]
    79dd:6c9d    xlat
    79dd:6c9f    or        al,al
    79dd:6ca1    jns       NO_LOAC
    79dd:6ca3    jmp       P_LOCAL
             NO_LOAC:
    79dd:6ca6    cmp       ax,4557
    79dd:6ca9  - je        6CAE
    79dd:6cab    jmp       PM
    79dd:6cae  - lodsb
    79dd:6caf    and       al,DF
    79dd:6cb1    cmp       al,52
    79dd:6cb3    je        6CB8
    79dd:6cb5    jmp       PM
    79dd:6cb8    mov       al,byte ptr [si]
    79dd:6cba    xlat
    79dd:6cbc    or        al,al
    79dd:6cbe    jns       P_LI
    79dd:6cc0    jmp       P_LOWER
             P_LI:
    79dd:6cc3    lodsb
    79dd:6cc4  - and       al,DF
    79dd:6cc6  - cmp       al,53
    79dd:6cc8  - je        M_LIS
    79dd:6cca    jmp       PM
             M_LIS:
    79dd:6ccd  - lodsb
    79dd:6cce    and       al,DF
    79dd:6cd0    cmp       al,54
    79dd:6cd2    je        6CD7
    79dd:6cd4    jmp       PM
    79dd:6cd7    mov       al,byte ptr [si]
    79dd:6cd9    xlat
    79dd:6cdb    or        al,al
    79dd:6cdd    jns       P_M
    79dd:6cdf    jmp       P_LIST
             P_M:
    79dd:6ce2    and       ah,DF
    79dd:6ce5  - cmp       ah,41
    79dd:6ce8  - je        P_MA
    79dd:6cea  - cmp       ah,45
    79dd:6ced  - je        P_ME
    79dd:6cef  - cmp       ah,56
    79dd:6cf2  - je        P_MV
    79dd:6cf4  - jmp       PM
             P_ME:
    79dd:6cf7  - lodsb
    79dd:6cf8  - and       al,DF
    79dd:6cfa  - cmp       al,58
    79dd:6cfc  - je        6D01
    79dd:6cfe    jmp       PM
    79dd:6d01  - lodsb
    79dd:6d02  - and       al,DF
    79dd:6d04  - cmp       al,49
    79dd:6d06  - je        6D0B
    79dd:6d08    jmp       PM
    79dd:6d0b  - lodsb
    79dd:6d0c    and       al,DF
    79dd:6d0e    cmp       al,54
    79dd:6d10    je        6D15
    79dd:6d12    jmp       PM
    79dd:6d15    mov       al,byte ptr [si]
    79dd:6d17    xlat
    79dd:6d19    or        al,al
    79dd:6d1b    jns       P_MA
    79dd:6d1d    jmp       P_MEXIT
             P_MA:
    79dd:6d20    lodsb
    79dd:6d21  - and       al,DF
    79dd:6d23  - cmp       al,43
    79dd:6d25  - jne       P_TRYMA
             M_MAC:
    79dd:6d27  - lodsb
    79dd:6d28  - and       al,DF
    79dd:6d2a  - cmp       al,52
    79dd:6d2c  - je        6D31
    79dd:6d2e    jmp       PM
    79dd:6d31  - lodsb
    79dd:6d32    and       al,DF
    79dd:6d34    cmp       al,4F
    79dd:6d36    je        6D3B
    79dd:6d38    jmp       PM
    79dd:6d3b    mov       al,byte ptr [si]
    79dd:6d3d    xlat
    79dd:6d3f    or        al,al
    79dd:6d41    jns       P_TRYMA
    79dd:6d43    jmp       P_MACRO
             P_TRYMA:
    79dd:6d46    cmp       al,52
    79dd:6d48  - je        M_MAR
    79dd:6d4a    jmp       PM
             M_MAR:
    79dd:6d4d  - lodsb
    79dd:6d4e  - and       al,DF
    79dd:6d50  - cmp       al,49
    79dd:6d52  - je        6D57
    79dd:6d54    jmp       PM
    79dd:6d57  - lodsb
    79dd:6d58    and       al,DF
    79dd:6d5a    cmp       al,4F
    79dd:6d5c    je        6D61
    79dd:6d5e    jmp       PM
    79dd:6d61    mov       al,byte ptr [si]
    79dd:6d63    xlat
    79dd:6d65    or        al,al
    79dd:6d67    jns       P_MV
    79dd:6d69    jmp       P_MARIO
             P_MV:
    79dd:6d6c    lodsb
    79dd:6d6d  - and       al,DF
    79dd:6d6f  - cmp       al,4E
    79dd:6d71  - jne       6D76
    79dd:6d73    jmp       P_MVN
    79dd:6d76  - cmp       al,50
    79dd:6d78  - jne       6D7D
    79dd:6d7a    jmp       P_MVP
    79dd:6d7d  - jmp       PM
             P_N:
    79dd:6d80  - and       ah,DF
    79dd:6d83  - cmp       ah,4F
    79dd:6d86  - je        6D8B
    79dd:6d88    jmp       PM
    79dd:6d8b  - lodsb
    79dd:6d8c    and       al,DF
    79dd:6d8e    cmp       al,50
    79dd:6d90    je        6D95
    79dd:6d92    jmp       PM
    79dd:6d95    mov       al,byte ptr [si]
    79dd:6d97    xlat
    79dd:6d99    or        al,al
    79dd:6d9b    jns       P_O
    79dd:6d9d    jmp       P_NOP
             P_O:
    79dd:6da0    and       ah,DF
    79dd:6da3  - cmp       ah,52
    79dd:6da6  - je        P_OR
    79dd:6da8  - cmp       ah,55
    79dd:6dab  - je        P_OU
    79dd:6dad  - jmp       PM
             P_OR:
    79dd:6db0  - lodsb
    79dd:6db1  - and       al,DF
    79dd:6db3  - cmp       al,41
    79dd:6db5  - jne       6DBA
    79dd:6db7    jmp       P_ORA
    79dd:6dba  - cmp       al,47
    79dd:6dbc  - jne       6DC1
    79dd:6dbe    jmp       P_ORG
    79dd:6dc1  - jmp       PM
             P_OU:
    79dd:6dc4  - lodsb
    79dd:6dc5  - and       al,DF
    79dd:6dc7  - cmp       al,54
    79dd:6dc9  - je        6DCE
    79dd:6dcb    jmp       PM
    79dd:6dce  - lodsb
    79dd:6dcf  - and       al,DF
    79dd:6dd1  - cmp       al,50
    79dd:6dd3  - je        6DD8
    79dd:6dd5    jmp       PM
    79dd:6dd8  - lodsb
    79dd:6dd9  - and       al,DF
    79dd:6ddb  - cmp       al,55
    79dd:6ddd  - je        6DE2
    79dd:6ddf    jmp       PM
    79dd:6de2  - lodsb
    79dd:6de3    and       al,DF
    79dd:6de5    cmp       al,54
    79dd:6de7    je        6DEC
    79dd:6de9    jmp       PM
    79dd:6dec    mov       al,byte ptr [si]
    79dd:6dee    xlat
    79dd:6df0    or        al,al
    79dd:6df2    jns       P_P
    79dd:6df4    jmp       P_OUTPUT
             P_P:
    79dd:6df7    and       ah,DF
    79dd:6dfa  - cmp       ah,45
    79dd:6dfd  - je        P_PE
    79dd:6dff  - cmp       ah,48
    79dd:6e02  - je        P_PH
    79dd:6e04  - cmp       ah,4C
    79dd:6e07  - je        P_PL
    79dd:6e09  - cmp       ah,52
    79dd:6e0c  - jne       6E11
    79dd:6e0e    jmp       P_PR
    79dd:6e11  - cmp       ah,55
    79dd:6e14  - jne       6E19
    79dd:6e16    jmp       P_PU
    79dd:6e19  - jmp       PM
             P_PE:
    79dd:6e1c  - lodsb
    79dd:6e1d  - and       al,DF
    79dd:6e1f  - cmp       al,41
    79dd:6e21  - jne       6E26
    79dd:6e23    jmp       P_PEA
    79dd:6e26  - cmp       al,49
    79dd:6e28  - jne       6E2D
    79dd:6e2a    jmp       P_PEI
    79dd:6e2d  - cmp       al,52
    79dd:6e2f  - jne       6E34
    79dd:6e31    jmp       P_PER
    79dd:6e34  - jmp       PM
             P_PH:
    79dd:6e37  - lodsb
    79dd:6e38  - and       al,DF
    79dd:6e3a  - cmp       al,41
    79dd:6e3c  - jne       6E41
    79dd:6e3e    jmp       P_PHA
    79dd:6e41  - cmp       al,58
    79dd:6e43  - jne       6E48
    79dd:6e45    jmp       P_PHX
    79dd:6e48  - cmp       al,59
    79dd:6e4a  - jne       6E4F
    79dd:6e4c    jmp       P_PHY
    79dd:6e4f  - cmp       al,50
    79dd:6e51  - jne       6E56
    79dd:6e53    jmp       P_PHP
    79dd:6e56  - cmp       al,42
    79dd:6e58  - jne       6E5D
    79dd:6e5a    jmp       P_PHB
    79dd:6e5d  - cmp       al,44
    79dd:6e5f  - jne       6E64
    79dd:6e61    jmp       P_PHD
    79dd:6e64  - cmp       al,4B
    79dd:6e66  - jne       6E6B
    79dd:6e68    jmp       P_PHK
    79dd:6e6b  - jmp       PM
             P_PL:
    79dd:6e6e  - lodsb
    79dd:6e6f  - and       al,DF
    79dd:6e71  - cmp       al,41
    79dd:6e73  - jne       6E78
    79dd:6e75    jmp       P_PLA
    79dd:6e78  - cmp       al,58
    79dd:6e7a  - jne       6E7F
    79dd:6e7c    jmp       P_PLX
    79dd:6e7f  - cmp       al,59
    79dd:6e81  - jne       6E86
    79dd:6e83    jmp       P_PLY
    79dd:6e86  - cmp       al,50
    79dd:6e88  - jne       6E8D
    79dd:6e8a    jmp       P_PLP
    79dd:6e8d  - cmp       al,42
    79dd:6e8f  - jne       6E94
    79dd:6e91    jmp       P_PLB
    79dd:6e94  - cmp       al,44
    79dd:6e96  - jne       6E9B
    79dd:6e98    jmp       P_PLD
    79dd:6e9b  - jmp       PM
             P_PR:
    79dd:6e9e  - lodsw
    79dd:6e9f  - and       ax,DFDF
    79dd:6ea2  - cmp       ax,4E49
    79dd:6ea5  - je        6EAA
    79dd:6ea7    jmp       PM
    79dd:6eaa  - lodsw
    79dd:6eab  - and       ax,DFDF
    79dd:6eae  - cmp       ax,4654
    79dd:6eb1  - jne       6EB6
    79dd:6eb3    jmp       P_PRINTF
    79dd:6eb6  - jmp       PM
             P_PU:
    79dd:6eb9  - lodsw
    79dd:6eba  - and       ax,DFDF
    79dd:6ebd  - cmp       ax,4C42
    79dd:6ec0  - je        6EC5
    79dd:6ec2    jmp       PM
    79dd:6ec5  - lodsw
    79dd:6ec6  - and       ax,DFDF
    79dd:6ec9  - cmp       ax,4349
    79dd:6ecc  - jne       6ED1
    79dd:6ece    jmp       P_PUBLIC
    79dd:6ed1  - jmp       PM
             P_R:
    79dd:6ed4  - and       ah,DF
    79dd:6ed7  - cmp       ah,45
    79dd:6eda  - je        P_RE
    79dd:6edc  - cmp       ah,54
    79dd:6edf  - je        P_RT
    79dd:6ee1  - cmp       ah,4F
    79dd:6ee4  - je        P_RO
    79dd:6ee6  - cmp       ah,55
    79dd:6ee9  - je        P_RU
    79dd:6eeb  - jmp       PM
             P_RE:
    79dd:6eee  - lodsb
    79dd:6eef  - and       al,DF
    79dd:6ef1  - cmp       al,50
    79dd:6ef3  - je        M_REP
    79dd:6ef5  - cmp       al,4C
    79dd:6ef7  - jne       P_REL
             P_REL:
    79dd:6ef9  - lodsw
    79dd:6efa  - and       ax,DFDF
    79dd:6efd  - cmp       ax,4145
    79dd:6f00  - je        6F05
    79dd:6f02    jmp       PM
    79dd:6f05  - lodsw
    79dd:6f06  - and       ax,DFDF
    79dd:6f09  - cmp       ax,4553
    79dd:6f0c  - jne       6F11
    79dd:6f0e    jmp       P_RELEASE
    79dd:6f11  - jmp       PM
             M_REP:
    79dd:6f14  - lodsb
    79dd:6f15  - and       al,DF
    79dd:6f17  - cmp       al,54
    79dd:6f19  - jne       6F1E
    79dd:6f1b    jmp       P_REPT
    79dd:6f1e  - dec       si
    79dd:6f1f  - mov       al,byte ptr [si]
    79dd:6f21  - xlat
    79dd:6f23  - or        al,al
    79dd:6f25  - jns       6F2A
    79dd:6f27    jmp       P_REP
    79dd:6f2a  - jmp       PM
             P_RO:
    79dd:6f2d  - lodsb
    79dd:6f2e  - and       al,DF
    79dd:6f30  - cmp       al,4C
    79dd:6f32  - jne       6F37
    79dd:6f34    jmp       P_ROL
    79dd:6f37  - cmp       al,52
    79dd:6f39  - jne       6F3E
    79dd:6f3b    jmp       P_ROR
    79dd:6f3e  - jmp       PM
             P_RT:
    79dd:6f41  - lodsb
    79dd:6f42  - and       al,DF
    79dd:6f44  - cmp       al,4C
    79dd:6f46  - jne       6F4B
    79dd:6f48    jmp       P_RTL
    79dd:6f4b  - cmp       al,53
    79dd:6f4d  - jne       6F52
    79dd:6f4f    jmp       P_RTS
    79dd:6f52  - cmp       al,49
    79dd:6f54  - jne       6F59
    79dd:6f56    jmp       P_RTI
    79dd:6f59  - jmp       PM
             P_RU:
    79dd:6f5c  - lodsb
    79dd:6f5d    and       al,DF
    79dd:6f5f    cmp       al,4E
    79dd:6f61    je        6F66
    79dd:6f63    jmp       PM
    79dd:6f66    mov       al,byte ptr [si]
    79dd:6f68    xlat
    79dd:6f6a    or        al,al
    79dd:6f6c    jns       P_S
    79dd:6f6e    jmp       P_RUN
             P_S:
    79dd:6f71    and       ah,DF
    79dd:6f74  - cmp       ah,42
    79dd:6f77  - jne       6F7C
    79dd:6f79    jmp       P_SB
    79dd:6f7c  - cmp       ah,48
    79dd:6f7f  - jne       6F84
    79dd:6f81    jmp       P_SH
    79dd:6f84  - cmp       ah,45
    79dd:6f87  - jne       6F8C
    79dd:6f89    jmp       P_SE
    79dd:6f8c  - cmp       ah,54
    79dd:6f8f  - jne       6F94
    79dd:6f91    jmp       P_ST
    79dd:6f94  - cmp       ah,57
    79dd:6f97  - jne       6F9C
    79dd:6f99    jmp       P_SW
    79dd:6f9c  - cmp       ah,49
    79dd:6f9f  - jne       6FA4
    79dd:6fa1    jmp       P_SI
    79dd:6fa4  - cmp       ah,55
    79dd:6fa7  - je        P_SU
    79dd:6fa9  - jmp       PM
             P_SU:
    79dd:6fac  - lodsw
    79dd:6fad  - and       ax,DFDF
    79dd:6fb0  - cmp       ax,5342
    79dd:6fb3  - je        P_SUBS
    79dd:6fb5  - cmp       ax,5050
    79dd:6fb8  - je        6FBD
    79dd:6fba    jmp       PM
    79dd:6fbd  - lodsw
    79dd:6fbe  - and       ax,DFDF
    79dd:6fc1  - cmp       ax,4552
    79dd:6fc4  - je        6FC9
    79dd:6fc6    jmp       PM
    79dd:6fc9  - lodsw
    79dd:6fca  - and       ax,DFDF
    79dd:6fcd  - cmp       ax,5353
    79dd:6fd0  - jne       6FD5
    79dd:6fd2    jmp       P_SUPPRESS
    79dd:6fd5  - jmp       PM
             P_SUBS:
    79dd:6fd8  - lodsw
    79dd:6fd9  - and       ax,DFDF
    79dd:6fdc  - cmp       ax,5254
    79dd:6fdf  - je        P_SUBSTR
    79dd:6fe1    jmp       PM
             P_SUBSTR:
    79dd:6fe4  - mov       al,byte ptr [si]
    79dd:6fe6    xlat
    79dd:6fe8    or        al,al
    79dd:6fea    js        6FEF
    79dd:6fec    jmp       PM
    79dd:6fef  - lodsb
    79dd:6ff0    xlat
    79dd:6ff2    or        al,al
    79dd:6ff4    js        6FEF
    79dd:6ff6    dec       si
    79dd:6ff7  - mov       word ptr ss:[9A80],0020
    79dd:6ffe  - call      CONVEXPRESS
    79dd:7001  - test      byte ptr ss:[0ACE],C0
    79dd:7007  - je        700C
    79dd:7009    jmp       P_IFERR
    79dd:700c  - mov       word ptr ss:[9A7C],cx
    79dd:7011  - lodsb
    79dd:7012  - cmp       al,5B
    79dd:7014  - jne       SSNOPAD
    79dd:7016  - lodsb
    79dd:7017  - mov       byte ptr [9A80],al
    79dd:701b  - lodsb
    79dd:701c  - cmp       al,5D
    79dd:701e  - je        7023
    79dd:7020    jmp       EAERR
    79dd:7023  - lodsb
             SSNOPAD:
    79dd:7024  - cmp       al,2C
    79dd:7026  - je        702B
    79dd:7028    jmp       EAERR
    79dd:702b  - mov       word ptr ss:[9A7E],0096
    79dd:7032  - cmp       byte ptr [si],2C
    79dd:7035  - je        SUBSTRDEF
    79dd:7037  - call      CONVEXPRESS
    79dd:703a  - test      byte ptr ss:[0ACE],C0
    79dd:7040  - je        7045
    79dd:7042    jmp       P_IFERR
    79dd:7045  - mov       word ptr ss:[9A7E],cx
             SUBSTRDEF:
    79dd:704a  - lodsb
    79dd:704b  - cmp       al,2C
    79dd:704d  - je        7052
    79dd:704f    jmp       EAERR
    79dd:7052  - call      GETSTRINGADDR
    79dd:7055  - push      ds
    79dd:7056  - push      si
    79dd:7057  - push      es
    79dd:7058  - push      di
    79dd:7059  - mov       si,cx
    79dd:705b  - mov       ds,dx
    79dd:705d  - mov       ax,ss
    79dd:705f  - mov       es,ax
    79dd:7061  - mov       di,9778
    79dd:7064  - mov       ax,word ptr [9A7C]
    79dd:7068  - or        ax,ax
    79dd:706a  - jns       SSOK
    79dd:706c  - neg       ax
    79dd:706e  - mov       cx,ax
    79dd:7070  - mov       al,byte ptr [9A80]
             SSLP1:
    79dd:7074  - stosb
    79dd:7075  - dec       cx
    79dd:7076  - jne       SSLP1
    79dd:7078  - mov       word ptr ss:[9A7C],0000
             SSOK:
    79dd:707f  - push      ds
    79dd:7080  - push      si
    79dd:7081  - add       si,word ptr ss:[9A7C]
    79dd:7086  - mov       cx,word ptr ss:[9A7E]
             SUBSTRLP:
    79dd:708b  - lodsb
    79dd:708c  - stosb
    79dd:708d  - dec       cx
    79dd:708e  - jns       SUBSTRLP
    79dd:7090  - mov       byte ptr es:[di+FF],00
    79dd:7095  - pop       di
    79dd:7096  - pop       es
    79dd:7097  - mov       ax,ss
    79dd:7099  - mov       ds,ax
    79dd:709b  - mov       si,9778
             SUBSTRLP2:
    79dd:709e  - lodsb
    79dd:709f  - stosb
    79dd:70a0  - or        al,al
    79dd:70a2  - jne       SUBSTRLP2
    79dd:70a4  - pop       di
    79dd:70a5  - pop       es
    79dd:70a6  - pop       si
    79dd:70a7  - pop       ds
    79dd:70a8  - ret
             P_SI:
    79dd:70a9  - lodsb
    79dd:70aa  - and       al,DF
    79dd:70ac  - cmp       al,43
    79dd:70ae  - je        P_SIC
    79dd:70b0    jmp       PM
             P_SIC:
    79dd:70b3  - lodsb
    79dd:70b4    and       al,DF
    79dd:70b6    cmp       al,45
    79dd:70b8    je        70BD
    79dd:70ba    jmp       PM
    79dd:70bd    mov       al,byte ptr [si]
    79dd:70bf    xlat
    79dd:70c1    or        al,al
    79dd:70c3    js        P_SICE
             P_SICE:
    79dd:70c5    ????
    79dd:70c7  - ret
             P_SW:
    79dd:70c8  - lodsb
    79dd:70c9    and       al,DF
    79dd:70cb    cmp       al,41
    79dd:70cd    je        70D2
    79dd:70cf    jmp       PM
    79dd:70d2    mov       al,byte ptr [si]
    79dd:70d4    xlat
    79dd:70d6    or        al,al
    79dd:70d8    jns       P_SB
    79dd:70da    jmp       P_XBA
             P_SB:
    79dd:70dd    lodsb
    79dd:70de  - and       al,DF
    79dd:70e0  - cmp       al,43
    79dd:70e2  - jne       70E7
    79dd:70e4    jmp       P_SBC
    79dd:70e7  - jmp       PM
             P_SH:
    79dd:70ea  - lodsb
    79dd:70eb  - and       al,DF
    79dd:70ed  - cmp       al,4F
    79dd:70ef  - je        70F4
    79dd:70f1    jmp       PM
    79dd:70f4  - lodsb
    79dd:70f5  - and       al,DF
    79dd:70f7  - cmp       al,52
    79dd:70f9  - je        70FE
    79dd:70fb    jmp       PM
    79dd:70fe  - lodsb
    79dd:70ff  - and       al,DF
    79dd:7101  - cmp       al,54
    79dd:7103  - je        7108
    79dd:7105    jmp       PM
    79dd:7108  - lodsb
    79dd:7109  - and       al,DF
    79dd:710b  - cmp       al,41
    79dd:710d  - jne       7112
    79dd:710f    jmp       P_SHORTA
    79dd:7112  - cmp       al,49
    79dd:7114  - jne       7119
    79dd:7116    jmp       P_SHORTI
    79dd:7119  - jmp       PM
             P_SE:
    79dd:711c  - lodsb
    79dd:711d  - and       al,DF
    79dd:711f  - cmp       al,43
    79dd:7121  - jne       7126
    79dd:7123    jmp       P_SEC
    79dd:7126  - cmp       al,44
    79dd:7128  - jne       712D
    79dd:712a    jmp       P_SED
    79dd:712d  - cmp       al,49
    79dd:712f  - jne       7134
    79dd:7131    jmp       P_SEI
    79dd:7134  - cmp       al,50
    79dd:7136  - jne       713B
    79dd:7138    jmp       P_SEP
    79dd:713b  - cmp       al,54
    79dd:713d  - je        P_SET2
    79dd:713f  - jmp       PM
             P_SET2:
    79dd:7142  - lodsw
    79dd:7143  - and       ax,DFDF
    79dd:7146  - cmp       ax,4244
    79dd:7149  - je        714E
    79dd:714b    jmp       PM
    79dd:714e  - lodsb
    79dd:714f    and       al,DF
    79dd:7151    cmp       al,52
    79dd:7153    je        7158
    79dd:7155    jmp       PM
    79dd:7158    mov       al,byte ptr [si]
    79dd:715a    xlat
    79dd:715c    or        al,al
    79dd:715e    js        P_SETDBR
             P_SETDBR:
    79dd:7160  - mov       al,byte ptr [si]
    79dd:7162    xlat
    79dd:7164    or        al,al
    79dd:7166    js        716B
    79dd:7168    jmp       PM
    79dd:716b  - lodsb
    79dd:716c    xlat
    79dd:716e    or        al,al
    79dd:7170    js        716B
    79dd:7172    dec       si
    79dd:7173  - call      CONVEXPRESS
    79dd:7176  - test      byte ptr ss:[0ACE],C0
    79dd:717c  - je        7181
    79dd:717e    jmp       P_EQUERR2
    79dd:7181  - or        dx,dx
    79dd:7183  - jne       E_INVDBR
    79dd:7185  - cmp       cx,00FF
    79dd:7189  - ja        E_INVDBR
    79dd:718b  - mov       word ptr ss:[0ABB],cx
    79dd:7190  - ret
             E_INVDBR:
    79dd:7191  - push      dx
    79dd:7192    mov       dx,861B
    79dd:7195    call      ERROR_ROUT
    79dd:7198    pop       dx
             P_ST:
    79dd:7199    lodsb
    79dd:719a  - and       al,DF
    79dd:719c  - cmp       al,41
    79dd:719e  - jne       71A3
    79dd:71a0    jmp       P_STA
    79dd:71a3  - cmp       al,58
    79dd:71a5  - jne       71AA
    79dd:71a7    jmp       P_STX
    79dd:71aa  - cmp       al,59
    79dd:71ac  - jne       71B1
    79dd:71ae    jmp       P_STY
    79dd:71b1  - cmp       al,5A
    79dd:71b3  - jne       71B8
    79dd:71b5    jmp       P_STZ
    79dd:71b8  - cmp       al,50
    79dd:71ba  - jne       71BF
    79dd:71bc    jmp       P_STP
    79dd:71bf  - cmp       al,52
    79dd:71c1  - je        P_STR
    79dd:71c3  - jmp       PM
             P_STR:
    79dd:71c6  - lodsw
    79dd:71c7  - and       ax,DFDF
    79dd:71ca  - cmp       ax,4E49
    79dd:71cd  - je        P_STRIN
    79dd:71cf  - cmp       ax,5043
    79dd:71d2  - je        71D7
    79dd:71d4    jmp       PM
    79dd:71d7  - lodsb
    79dd:71d8    and       al,DF
    79dd:71da    cmp       al,59
    79dd:71dc    je        71E1
    79dd:71de    jmp       PM
    79dd:71e1    mov       al,byte ptr [si]
    79dd:71e3    xlat
    79dd:71e5    or        al,al
    79dd:71e7    jns       P_STRIN
    79dd:71e9    jmp       P_STRCPY
             P_STRIN:
    79dd:71ec  - lodsb
    79dd:71ed    and       al,DF
    79dd:71ef    cmp       al,47
    79dd:71f1    je        71F6
    79dd:71f3    jmp       PM
    79dd:71f6    mov       al,byte ptr [si]
    79dd:71f8    xlat
    79dd:71fa    or        al,al
    79dd:71fc    js        P_STRING
             P_STRING:
    79dd:71fe  - lodsb
    79dd:71ff    xlat
    79dd:7201    or        al,al
    79dd:7203    js        P_STRING
    79dd:7205    dec       si
    79dd:7206  - push      si
    79dd:7207  - call      GETSTRINGADDR
    79dd:720a  - pop       ax
    79dd:720b  - cmp       cx,A46D
    79dd:720f  - jne       REDEFSTRING
    79dd:7211  - cmp       dx,8AC9
    79dd:7215  - je        P_NEWSTRING
             REDEFSTRING:
    79dd:7217  - push      es
    79dd:7218  - push      di
    79dd:7219  - mov       di,cx
    79dd:721b  - mov       es,dx
    79dd:721d  - xor       ch,ch
    79dd:721f  - mov       cl,byte ptr es:[di+FF]
    79dd:7223  - push      cx
    79dd:7224  - lodsb
    79dd:7225  - cmp       al,3D
    79dd:7227  - je        722C
    79dd:7229    jmp       EAERR
    79dd:722c  - mov       byte ptr ss:[247D],01
    79dd:7232  - call      P_PRINTF2
    79dd:7235  - mov       byte ptr ss:[247D],00
    79dd:723b  - pop       cx
    79dd:723c  - cmp       cx,word ptr ss:[2486]
    79dd:7241  - jbe       E_STR2LONG
    79dd:7243  - push      ds
    79dd:7244  - push      si
    79dd:7245  - mov       ax,ss
    79dd:7247  - mov       ds,ax
    79dd:7249  - mov       si,8A6E
    79dd:724c  - mov       cx,word ptr ss:[2486]
             COPYPFLP2:
    79dd:7251  - lodsb
    79dd:7252  - stosb
    79dd:7253  - dec       cx
    79dd:7254  - jns       COPYPFLP2
    79dd:7256  - mov       byte ptr es:[di+FF],00
    79dd:725b  - pop       si
    79dd:725c  - pop       ds
    79dd:725d  - pop       di
    79dd:725e  - pop       es
    79dd:725f  - ret
             E_STR2LONG:
    79dd:7260  - push      dx
    79dd:7261    mov       dx,86E7
    79dd:7264    call      ERROR_ROUT
    79dd:7267    pop       dx
             P_NEWSTRING:
    79dd:7268  - mov       si,ax
    79dd:726a  - push      es
    79dd:726b  - push      di
    79dd:726c  - mov       al,byte ptr [9BDD]
    79dd:7270  - or        al,al
    79dd:7272  - jne       NCN
    79dd:7274  - mov       al,byte ptr [si]
    79dd:7276  - cmp       al,30
    79dd:7278  - jae       727D
    79dd:727a    jmp       P_BADSTRVAL
    79dd:727d  - cmp       al,39
    79dd:727f  - ja        NCN
    79dd:7281    jmp       P_BADSTRVAL
             NCN:
    79dd:7284  - mov       es,word ptr ss:[0ED5]
    79dd:7289  - mov       di,word ptr ss:[0ED7]
    79dd:728e  - mov       bp,di
    79dd:7290  - inc       di
    79dd:7291  - xor       cl,cl
             NSTRNLP:
    79dd:7293  - lodsb
    79dd:7294  - xlat
    79dd:7296  - stosb
    79dd:7297  - add       cl,01
    79dd:729a  - or        al,al
    79dd:729c  - jns       72A1
    79dd:729e    jmp       E_INVARRAY
    79dd:72a1  - cmp       al,5B
    79dd:72a3  - jne       NSTRNLP
    79dd:72a5  - dec       cl
    79dd:72a7  - mov       byte ptr es:[bp+00],cl
    79dd:72ab  - dec       di
    79dd:72ac  - cmp       byte ptr [si],5D
    79dd:72af  - je        DEFLEN
    79dd:72b1  - mov       bx,76A7
    79dd:72b4  - call      CONVEXPRESS
    79dd:72b7  - test      byte ptr ss:[0ACE],C0
    79dd:72bd  - je        72C2
    79dd:72bf    jmp       E_INVSTR
    79dd:72c2  - or        dx,dx
    79dd:72c4  - je        72C9
    79dd:72c6    jmp       E_INVSTR
    79dd:72c9  - cmp       cx,00FF
    79dd:72cd  - jbe       72D2
    79dd:72cf    jmp       E_INVSTR
    79dd:72d2  - mov       word ptr ss:[9BE4],cx
    79dd:72d7  - jmp       GOTLEN
             DEFLEN:
    79dd:72d9  - mov       word ptr ss:[9BE4],0000
             GOTLEN:
    79dd:72e0  - lodsb
    79dd:72e1  - cmp       al,5D
    79dd:72e3  - je        72E8
    79dd:72e5    jmp       EAERR
    79dd:72e8  - lodsb
    79dd:72e9  - cmp       al,3D
    79dd:72eb  - jne       NSTRNODEF
    79dd:72ed  - mov       byte ptr ss:[247D],01
    79dd:72f3  - call      P_PRINTF2
    79dd:72f6  - mov       byte ptr ss:[247D],00
    79dd:72fc  - jmp       STRDEF
             NSTRNODEF:
    79dd:72fe  - mov       byte ptr ss:[8A6E],00
    79dd:7304  - mov       word ptr ss:[2486],0001
             STRDEF:
    79dd:730b  - cmp       word ptr ss:[9BE4],00
    79dd:7311  - jne       GOTLEN2
    79dd:7313  - mov       ax,word ptr [2486]
    79dd:7317  - mov       word ptr [9BE4],ax
             GOTLEN2:
    79dd:731b  - push      di
    79dd:731c  - push      ds
    79dd:731d  - push      si
    79dd:731e  - mov       ax,ss
    79dd:7320  - mov       ds,ax
    79dd:7322  - mov       si,8A6E
    79dd:7325  - mov       cx,word ptr ss:[2486]
    79dd:732a  - cmp       cx,word ptr ss:[9BE4]
    79dd:732f  - ja        E_INVARRAY
    79dd:7331  - mov       ax,word ptr [9BE4]
    79dd:7335  - add       ax,0002
    79dd:7338  - stosb
             COPYPFLP:
    79dd:7339  - lodsb
    79dd:733a  - stosb
    79dd:733b  - dec       cx
    79dd:733c  - jns       COPYPFLP
    79dd:733e  - mov       byte ptr es:[di+FF],00
    79dd:7343  - pop       si
    79dd:7344  - pop       ds
    79dd:7345  - pop       di
    79dd:7346  - add       di,word ptr ss:[9BE4]
    79dd:734b  - add       di,02
    79dd:734e  - mov       word ptr es:[di],FFFF
    79dd:7353  - mov       word ptr ss:[0ED7],di
    79dd:7358  - cmp       di,1F00
    79dd:735c    jb        7361
    79dd:735e    call      MORESTRING
    79dd:7361  - pop       di
    79dd:7362  - pop       es
    79dd:7363  - ret
             E_INVARRAY:
    79dd:7364  - pop       si
    79dd:7365  - pop       ds
    79dd:7366  - pop       di
    79dd:7367  - pop       di
    79dd:7368  - pop       es
    79dd:7369  - push      dx
    79dd:736a    mov       dx,86D8
    79dd:736d    call      ERROR_ROUT
    79dd:7370    pop       dx
             E_INVSTR:
    79dd:7371    pop       di
    79dd:7372  - pop       es
    79dd:7373  - push      dx
    79dd:7374    mov       dx,80D7
    79dd:7377    call      ERROR_ROUT
    79dd:737a    pop       dx
             GETSTRINGADDR:
    79dd:737b    push      es
    79dd:737c  - push      di
    79dd:737d  - push      bx
    79dd:737e  - mov       al,byte ptr [si]
    79dd:7380  - cmp       al,30
    79dd:7382  - jb        GSLET
    79dd:7384  - cmp       al,39
    79dd:7386  - ja        GSLET
    79dd:7388  - mov       bx,77A7
    79dd:738b  - jmp       GSGLET
             GSLET:
    79dd:738d  - mov       bx,7727
             GSGLET:
    79dd:7390  - mov       es,word ptr ss:[0ED3]
    79dd:7395  - mov       di,0002
    79dd:7398  - cmp       word ptr es:[di],FF
    79dd:739c  - je        GSMISSING
    79dd:739e  - mov       word ptr ss:[9BE4],si
             GSALP1:
    79dd:73a3  - mov       cl,byte ptr es:[di]
    79dd:73a6    inc       di
    79dd:73a7  - mov       dx,di
    79dd:73a9  - xor       ch,ch
    79dd:73ab  - add       dx,cx
    79dd:73ad  - mov       si,word ptr ss:[9BE4]
    79dd:73b2  - mov       ch,cl
             GSALP2:
    79dd:73b4  - lodsb
    79dd:73b5  - xlat
    79dd:73b7  - or        al,al
    79dd:73b9  - js        GSEND1
    79dd:73bb  - mov       cl,byte ptr es:[di]
    79dd:73be    inc       di
    79dd:73bf  - or        cl,cl
    79dd:73c1  - je        GSNEXT
    79dd:73c3  - dec       ch
    79dd:73c5  - cmp       al,cl
    79dd:73c7  - je        GSALP2
             GSNEXT:
    79dd:73c9  - mov       di,dx
    79dd:73cb  - mov       cl,byte ptr es:[di]
    79dd:73ce  - xor       ch,ch
    79dd:73d0  - add       di,cx
    79dd:73d2  - cmp       word ptr es:[di],FF
    79dd:73d6  - jne       GSALP1
    79dd:73d8  - mov       ax,word ptr [0000]
    79dd:73dc  - or        ax,ax
    79dd:73de  - je        GSMISSING
    79dd:73e0  - mov       di,0002
    79dd:73e3  - jmp       GSALP1
             GSSAME:
    79dd:73e5  - mov       cx,dx
    79dd:73e7  - inc       cx
    79dd:73e8  - mov       dx,es
    79dd:73ea  - dec       si
    79dd:73eb  - pop       bx
    79dd:73ec  - pop       di
    79dd:73ed  - pop       es
    79dd:73ee  - ret
             GSEND1:
    79dd:73ef  - or        ch,ch
    79dd:73f1  - je        GSSAME
    79dd:73f3  - jmp       GSNEXT
             GSMISSING:
    79dd:73f5  - mov       cx,A46D
    79dd:73f8  - mov       dx,8AC9
             GSMISLP:
    79dd:73fb  - lodsb
    79dd:73fc  - xlat
    79dd:73fe  - or        al,al
    79dd:7400  - jns       GSMISLP
    79dd:7402  - dec       si
    79dd:7403  - pop       bx
    79dd:7404  - pop       di
    79dd:7405  - pop       es
    79dd:7406  - ret
             P_STRCPY:
    79dd:7407  - lodsb
    79dd:7408    xlat
    79dd:740a    or        al,al
    79dd:740c    js        P_STRCPY
    79dd:740e    dec       si
    79dd:740f  - call      GETSTRINGADDR
    79dd:7412  - mov       word ptr ss:[9A7C],dx
    79dd:7417  - mov       word ptr ss:[9A7E],cx
    79dd:741c  - lodsb
    79dd:741d  - cmp       al,2C
    79dd:741f  - je        7424
    79dd:7421    jmp       EAERR
    79dd:7424  - call      GETSTRINGADDR
    79dd:7427  - push      es
    79dd:7428  - push      di
    79dd:7429  - push      ds
    79dd:742a  - push      si
    79dd:742b  - mov       ds,dx
    79dd:742d  - mov       si,cx
    79dd:742f  - mov       es,word ptr ss:[9A7C]
    79dd:7434  - mov       di,word ptr ss:[9A7E]
             STRCPYLP:
    79dd:7439  - lodsb
    79dd:743a  - stosb
    79dd:743b  - or        al,al
    79dd:743d  - jne       STRCPYLP
    79dd:743f  - pop       si
    79dd:7440  - pop       ds
    79dd:7441  - pop       di
    79dd:7442  - pop       es
    79dd:7443  - ret
             P_T:
    79dd:7444  - and       ah,DF
    79dd:7447  - cmp       ah,41
    79dd:744a  - je        P_TA
    79dd:744c  - cmp       ah,43
    79dd:744f  - je        P_TC
    79dd:7451  - cmp       ah,44
    79dd:7454  - je        P_TD
    79dd:7456  - cmp       ah,52
    79dd:7459  - je        P_TR
    79dd:745b  - cmp       ah,53
    79dd:745e  - jne       7463
    79dd:7460    jmp       P_TS
    79dd:7463  - cmp       ah,58
    79dd:7466  - jne       746B
    79dd:7468    jmp       P_TX
    79dd:746b  - cmp       ah,59
    79dd:746e  - jne       7473
    79dd:7470    jmp       P_TY
    79dd:7473  - cmp       ah,49
    79dd:7476  - je        P_TI
    79dd:7478  - jmp       PM
             P_TI:
    79dd:747b  - lodsb
    79dd:747c  - and       al,DF
    79dd:747e  - cmp       al,4D
    79dd:7480  - je        7485
    79dd:7482    jmp       PM
    79dd:7485  - lodsb
    79dd:7486    and       al,DF
    79dd:7488    cmp       al,45
    79dd:748a    je        748F
    79dd:748c    jmp       PM
    79dd:748f    mov       al,byte ptr [si]
    79dd:7491    xlat
    79dd:7493    or        al,al
    79dd:7495    jns       P_TA
    79dd:7497    jmp       P_TIME
             P_TA:
    79dd:749a    lodsb
    79dd:749b  - and       al,DF
    79dd:749d  - cmp       al,58
    79dd:749f  - jne       74A4
    79dd:74a1    jmp       P_TAX
    79dd:74a4  - cmp       al,59
    79dd:74a6  - jne       74AB
    79dd:74a8    jmp       P_TAY
    79dd:74ab  - jmp       PM
             P_TC:
    79dd:74ae  - lodsb
    79dd:74af  - and       al,DF
    79dd:74b1  - cmp       al,44
    79dd:74b3  - jne       74B8
    79dd:74b5    jmp       P_TCD
    79dd:74b8  - cmp       al,53
    79dd:74ba  - jne       74BF
    79dd:74bc    jmp       P_TCS
    79dd:74bf  - jmp       PM
             P_TD:
    79dd:74c2  - lodsb
    79dd:74c3    and       al,DF
    79dd:74c5    cmp       al,43
    79dd:74c7    je        74CC
    79dd:74c9    jmp       PM
    79dd:74cc    mov       al,byte ptr [si]
    79dd:74ce    xlat
    79dd:74d0    or        al,al
    79dd:74d2    jns       P_TR
    79dd:74d4    jmp       P_TDC
             P_TR:
    79dd:74d7  - lodsb
    79dd:74d8    and       al,DF
    79dd:74da    cmp       al,42
    79dd:74dc    je        74E1
    79dd:74de    jmp       PM
    79dd:74e1    mov       al,byte ptr [si]
    79dd:74e3    xlat
    79dd:74e5    or        al,al
    79dd:74e7    jns       P_TS
    79dd:74e9    jmp       P_TRB
             P_TS:
    79dd:74ec    lodsb
    79dd:74ed  - and       al,DF
    79dd:74ef  - cmp       al,42
    79dd:74f1  - jne       74F6
    79dd:74f3    jmp       P_TSB
    79dd:74f6  - cmp       al,43
    79dd:74f8  - jne       74FD
    79dd:74fa    jmp       P_TSC
    79dd:74fd  - cmp       al,58
    79dd:74ff  - jne       7504
    79dd:7501    jmp       P_TSX
    79dd:7504  - jmp       PM
             P_TX:
    79dd:7507  - lodsb
    79dd:7508  - and       al,DF
    79dd:750a  - cmp       al,41
    79dd:750c  - jne       7511
    79dd:750e    jmp       P_TXA
    79dd:7511  - cmp       al,59
    79dd:7513  - jne       7518
    79dd:7515    jmp       P_TXY
    79dd:7518  - cmp       al,53
    79dd:751a  - jne       751F
    79dd:751c    jmp       P_TXS
    79dd:751f  - jmp       PM
             P_TY:
    79dd:7522  - lodsb
    79dd:7523  - and       al,DF
    79dd:7525  - cmp       al,41
    79dd:7527  - jne       752C
    79dd:7529    jmp       P_TYA
    79dd:752c  - cmp       al,58
    79dd:752e  - jne       7533
    79dd:7530    jmp       P_TYX
    79dd:7533  - cmp       al,50
    79dd:7535  - je        P_TYP
    79dd:7537  - jmp       PM
             P_TYP:
    79dd:753a  - lodsb
    79dd:753b    and       al,DF
    79dd:753d    cmp       al,45
    79dd:753f    je        7544
    79dd:7541    jmp       PM
    79dd:7544    mov       al,byte ptr [si]
    79dd:7546    xlat
    79dd:7548    or        al,al
    79dd:754a    jns       P_U
    79dd:754c    jmp       P_TYPE
             P_U:
    79dd:754f    and       ah,DF
    79dd:7552  - cmp       ah,50
    79dd:7555  - je        755A
    79dd:7557    jmp       PM
    79dd:755a  - lodsw
    79dd:755b  - and       ax,DFDF
    79dd:755e  - cmp       ax,4550
    79dd:7561  - je        7566
    79dd:7563    jmp       PM
    79dd:7566  - lodsb
    79dd:7567    and       al,DF
    79dd:7569    cmp       al,52
    79dd:756b    je        7570
    79dd:756d    jmp       PM
    79dd:7570    mov       al,byte ptr [si]
    79dd:7572    xlat
    79dd:7574    or        al,al
    79dd:7576    jns       P_W
    79dd:7578    jmp       P_UPPER
             P_W:
    79dd:757b    and       ah,DF
    79dd:757e  - cmp       ah,41
    79dd:7581  - je        P_WA
    79dd:7583  - cmp       ah,52
    79dd:7586  - je        758B
    79dd:7588    jmp       PM
    79dd:758b  - lodsw
    79dd:758c  - and       ax,DFDF
    79dd:758f  - cmp       ax,5449
    79dd:7592  - je        7597
    79dd:7594    jmp       PM
    79dd:7597  - lodsb
    79dd:7598    and       al,DF
    79dd:759a    cmp       al,45
    79dd:759c    je        75A1
    79dd:759e    jmp       PM
    79dd:75a1    mov       al,byte ptr [si]
    79dd:75a3    xlat
    79dd:75a5    or        al,al
    79dd:75a7    jns       P_WA
    79dd:75a9    jmp       P_WRITE
             P_WA:
    79dd:75ac    mov       al,byte ptr [si]
    79dd:75ae  - and       al,DF
    79dd:75b0  - cmp       al,49
    79dd:75b2  - jne       75B7
    79dd:75b4    jmp       P_WAI
    79dd:75b7  - jmp       PM
             P_X:
    79dd:75ba  - and       ah,DF
    79dd:75bd  - cmp       ah,42
    79dd:75c0  - je        P_XB
    79dd:75c2  - cmp       ah,43
    79dd:75c5  - je        P_XC
    79dd:75c7  - jmp       PM
             P_XB:
    79dd:75ca  - lodsb
    79dd:75cb    and       al,DF
    79dd:75cd    cmp       al,41
    79dd:75cf    je        75D4
    79dd:75d1    jmp       PM
    79dd:75d4    mov       al,byte ptr [si]
    79dd:75d6    xlat
    79dd:75d8    or        al,al
    79dd:75da    jns       P_XC
    79dd:75dc    jmp       P_XBA
             P_XC:
    79dd:75df  - lodsb
    79dd:75e0    and       al,DF
    79dd:75e2    cmp       al,45
    79dd:75e4    je        75E9
    79dd:75e6    jmp       PM
    79dd:75e9    mov       al,byte ptr [si]
    79dd:75eb    xlat
    79dd:75ed    or        al,al
    79dd:75ef    jns       BADVAL
    79dd:75f1    jmp       P_XCE
             BADVAL:
    79dd:75f4  - push      dx
    79dd:75f5    mov       dx,7EFE
    79dd:75f8    call      ERROR_ROUT
    79dd:75fb    pop       dx
             GETEA:
    79dd:75fc    xor       cl,cl
    79dd:75fe  - mov       al,byte ptr [si]
    79dd:7600  - xlat
    79dd:7602  - or        al,al
    79dd:7604  - js        GTAB
    79dd:7606  - cmp       al,2E
    79dd:7608  - je        GOK
    79dd:760a  - pop       ax
    79dd:760b  - jmp       PM
             GOK:
    79dd:760e  - lodsw
    79dd:760f  - mov       bp,word ptr ss:[13F0]
    79dd:7614  - and       ah,DF
    79dd:7617  - cmp       ah,4C
    79dd:761a  - je        GLONG
    79dd:761c  - cmp       ah,57
    79dd:761f  - je        GWORD
    79dd:7621  - cmp       ah,4E
    79dd:7624  - je        GTAB
    79dd:7626  - cmp       ah,44
    79dd:7629  - je        762E
    79dd:762b    jmp       DOTERR
    79dd:762e  - inc       cl
    79dd:7630  - mov       word ptr ss:[0AAE],bp
    79dd:7635  - jmp       GTAB
             GWORD:
    79dd:7637  - inc       cl
    79dd:7639  - mov       word ptr ss:[0AB2],bp
    79dd:763e  - mov       word ptr ss:[0AB4],bp
    79dd:7643  - jmp       GTAB
             GLONG:
    79dd:7645  - inc       cl
    79dd:7647  - mov       word ptr ss:[0AB6],bp
             GTAB:
    79dd:764c  - lodsb
    79dd:764d    xlat
    79dd:764f    or        al,al
    79dd:7651    js        GTAB
    79dd:7653    dec       si
    79dd:7654  - lodsb
    79dd:7655  - xor       ah,ah
    79dd:7657  - mov       bp,ax
    79dd:7659  - add       bp,bp
    79dd:765b  - jmp       word ptr [bp+7307]
             EAACC:
    79dd:765f  - mov       al,byte ptr [si]
    79dd:7661  - xlat
    79dd:7663  - or        al,al
    79dd:7665  - js        766A
    79dd:7667    jmp       EAEXP
    79dd:766a  - mov       bp,0002
    79dd:766d  - ret
             EAIMM:
    79dd:766e  - or        cl,cl
    79dd:7670  - je        7675
    79dd:7672    jmp       A_LA_GILES
    79dd:7675  - call      CONVEXPRESS
    79dd:7678  - mov       bp,word ptr ss:[13F0]
    79dd:767d  - cmp       bp,word ptr ss:[0AB2]
    79dd:7682  - jne       7687
    79dd:7684    jmp       EAIMMW
    79dd:7687  - or        ch,ch
    79dd:7689  - je        EAIMMOK
    79dd:768b  - cmp       ch,FF
    79dd:768e  - je        EAIMMOK
    79dd:7690    jmp       EAIMMERR
             EAIMMOK:
    79dd:7693  - mov       byte ptr es:[di+01],cl
    79dd:7697  - mov       bp,0004
    79dd:769a  - test      byte ptr ss:[0ACE],C0
    79dd:76a0    je        7718
    79dd:76a2    test      byte ptr ss:[0ACE],40
    79dd:76a8    jne       76D5
    79dd:76aa    push      es
    79dd:76ab    push      bp
    79dd:76ac    mov       es,word ptr ss:[0AC5]
    79dd:76b1    mov       bp,word ptr ss:[0AC9]
    79dd:76b6    mov       word ptr es:[bp+06],di
    79dd:76ba    mov       word ptr es:[bp+02],0000
    79dd:76c0    add       bp,15
    79dd:76c3    mov       word ptr ss:[0AC7],bp
    79dd:76c8    cmp       bp,7F00
    79dd:76cc    jb        76D1
    79dd:76ce    call      MOREFR
    79dd:76d1    pop       bp
    79dd:76d2    pop       es
    79dd:76d3    jmp       7718
    79dd:76d5    push      es
    79dd:76d6    push      bp
    79dd:76d7    push      cx
    79dd:76d8    push      ax
    79dd:76d9    mov       es,word ptr ss:[13A6]
    79dd:76de    mov       bp,word ptr ss:[13A8]
    79dd:76e3    mov       ax,di
    79dd:76e5    sub       ax,word ptr ss:[13B4]
    79dd:76ea    xor       cx,cx
    79dd:76ec    add       ax,word ptr ss:[13BE]
    79dd:76f1    adc       cx,word ptr ss:[13BC]
    79dd:76f6    mov       word ptr es:[bp+00],ax
    79dd:76fa    mov       word ptr es:[bp+02],cx
    79dd:76fe    mov       byte ptr es:[bp+04],00
    79dd:7703    add       bp,05
    79dd:7706    mov       word ptr ss:[13A8],bp
    79dd:770b    cmp       bp,3F00
    79dd:770f    jb        7714
    79dd:7711    call      MOREEXT
    79dd:7714    pop       ax
    79dd:7715    pop       cx
    79dd:7716    pop       bp
    79dd:7717    pop       es
    79dd:7718  - ret
             EAIMMW:
    79dd:7719  - cmp       dx,FF
    79dd:771c  - je        EAIMMW2
    79dd:771e  - or        dx,dx
    79dd:7720  - je        EAIMMW2
    79dd:7722    jmp       EAIMMERR1
             EAIMMW2:
    79dd:7725  - mov       word ptr es:[di+01],cx
    79dd:7729  - mov       bp,002C
    79dd:772c  - test      byte ptr ss:[0ACE],C0
    79dd:7732    je        77AA
    79dd:7734    test      byte ptr ss:[0ACE],40
    79dd:773a    jne       7767
    79dd:773c    push      es
    79dd:773d    push      bp
    79dd:773e    mov       es,word ptr ss:[0AC5]
    79dd:7743    mov       bp,word ptr ss:[0AC9]
    79dd:7748    mov       word ptr es:[bp+06],di
    79dd:774c    mov       word ptr es:[bp+02],0002
    79dd:7752    add       bp,15
    79dd:7755    mov       word ptr ss:[0AC7],bp
    79dd:775a    cmp       bp,7F00
    79dd:775e    jb        7763
    79dd:7760    call      MOREFR
    79dd:7763    pop       bp
    79dd:7764    pop       es
    79dd:7765    jmp       77AA
    79dd:7767    push      es
    79dd:7768    push      bp
    79dd:7769    push      cx
    79dd:776a    push      ax
    79dd:776b    mov       es,word ptr ss:[13A6]
    79dd:7770    mov       bp,word ptr ss:[13A8]
    79dd:7775    mov       ax,di
    79dd:7777    sub       ax,word ptr ss:[13B4]
    79dd:777c    xor       cx,cx
    79dd:777e    add       ax,word ptr ss:[13BE]
    79dd:7783    adc       cx,word ptr ss:[13BC]
    79dd:7788    mov       word ptr es:[bp+00],ax
    79dd:778c    mov       word ptr es:[bp+02],cx
    79dd:7790    mov       byte ptr es:[bp+04],02
    79dd:7795    add       bp,05
    79dd:7798    mov       word ptr ss:[13A8],bp
    79dd:779d    cmp       bp,3F00
    79dd:77a1    jb        77A6
    79dd:77a3    call      MOREEXT
    79dd:77a6    pop       ax
    79dd:77a7    pop       cx
    79dd:77a8    pop       bp
    79dd:77a9    pop       es
    79dd:77aa  - ret
             EAEXP:
    79dd:77ab  - dec       si
    79dd:77ac  - call      CONVEXPRESS
    79dd:77af  - or        dx,dx
    79dd:77b1  - jns       77B6
    79dd:77b3    jmp       EAEXPERR
    79dd:77b6  - mov       bp,word ptr ss:[13F0]
    79dd:77bb  - cmp       bp,word ptr ss:[0AB6]
    79dd:77c0  - jne       77C5
    79dd:77c2    jmp       EAEXPL
    79dd:77c5  - cmp       bp,word ptr ss:[0AAE]
    79dd:77ca  - jne       77CF
    79dd:77cc    jmp       EAZP
    79dd:77cf  - test      byte ptr ss:[0ACE],C0
    79dd:77d5  - jne       .FR
    79dd:77d7  - cmp       word ptr ss:[0AB8],bp
    79dd:77dc  - je        EAJMP
    79dd:77de  - cmp       byte ptr [si],2C
    79dd:77e1  - jne       77E6
    79dd:77e3    jmp       IFSUNBAL
    79dd:77e6  - cmp       bp,word ptr ss:[0AB4]
    79dd:77eb  - je        FORCEABSW
    79dd:77ed  - cmp       cx,00FF
    79dd:77f1  - ja        FORCEABSW
    79dd:77f3    jmp       EAZPABS
             FORCEABSW:
    79dd:77f6  - mov       word ptr es:[di+01],cx
    79dd:77fa  - mov       bp,0006
    79dd:77fd  - ret
             EAJMP:
    79dd:77fe  - cmp       dl,byte ptr ss:[0F92]
    79dd:7803  - je        7808
    79dd:7805    jmp       EAJMPERR
    79dd:7808  - cmp       byte ptr [si],2C
    79dd:780b  - jne       7810
    79dd:780d    jmp       IFSUNBAL
    79dd:7810  - cmp       bp,word ptr ss:[0AB4]
    79dd:7815  - jne       781A
    79dd:7817    jmp       EAERR
    79dd:781a  - mov       word ptr es:[di+01],cx
    79dd:781e  - mov       bp,0006
    79dd:7821  - ret
             .FR:
    79dd:7822  - cmp       byte ptr [si],2C
    79dd:7825  - jne       782A
    79dd:7827    jmp       EAINDEXFR
    79dd:782a  - test      byte ptr ss:[0ACE],C0
    79dd:7830    jne       7835
    79dd:7832    jmp       7901
    79dd:7835    test      byte ptr ss:[0ACE],40
    79dd:783b    jne       7883
    79dd:783d    push      es
    79dd:783e    push      bp
    79dd:783f    mov       es,word ptr ss:[0AC5]
    79dd:7844    mov       bp,word ptr ss:[0AC9]
    79dd:7849    mov       word ptr es:[bp+06],di
    79dd:784d    mov       ax,word ptr [13F0]
    79dd:7851    cmp       ax,word ptr ss:[0AB8]
    79dd:7856    je        7860
    79dd:7858    mov       word ptr es:[bp+02],0002
    79dd:785e    jmp       786E
    79dd:7860    mov       word ptr es:[bp+02],0006
    79dd:7866    mov       al,byte ptr [0F92]
    79dd:786a    mov       byte ptr es:[bp+0A],al
    79dd:786e    add       bp,15
    79dd:7871    mov       word ptr ss:[0AC7],bp
    79dd:7876    cmp       bp,7F00
    79dd:787a    jb        787F
    79dd:787c    call      MOREFR
    79dd:787f    pop       bp
    79dd:7880    pop       es
    79dd:7881    jmp       7901
    79dd:7883    mov       ax,word ptr [13F0]
    79dd:7887    cmp       ax,word ptr ss:[0AB8]
    79dd:788c    je        78BE
    79dd:788e    push      es
    79dd:788f    push      bp
    79dd:7890    push      cx
    79dd:7891    push      ax
    79dd:7892    mov       es,word ptr ss:[13A6]
    79dd:7897    mov       bp,word ptr ss:[13A8]
    79dd:789c    mov       ax,di
    79dd:789e    sub       ax,word ptr ss:[13B4]
    79dd:78a3    xor       cx,cx
    79dd:78a5    add       ax,word ptr ss:[13BE]
    79dd:78aa    adc       cx,word ptr ss:[13BC]
    79dd:78af    mov       word ptr es:[bp+00],ax
    79dd:78b3    mov       word ptr es:[bp+02],cx
    79dd:78b7    mov       byte ptr es:[bp+04],02
    79dd:78bc    jmp       78EC
    79dd:78be    push      es
    79dd:78bf    push      bp
    79dd:78c0    push      cx
    79dd:78c1    push      ax
    79dd:78c2    mov       es,word ptr ss:[13A6]
    79dd:78c7    mov       bp,word ptr ss:[13A8]
    79dd:78cc    mov       ax,di
    79dd:78ce    sub       ax,word ptr ss:[13B4]
    79dd:78d3    xor       cx,cx
    79dd:78d5    add       ax,word ptr ss:[13BE]
    79dd:78da    adc       cx,word ptr ss:[13BC]
    79dd:78df    mov       word ptr es:[bp+00],ax
    79dd:78e3    mov       word ptr es:[bp+02],cx
    79dd:78e7    mov       byte ptr es:[bp+04],06
    79dd:78ec    add       bp,05
    79dd:78ef    mov       word ptr ss:[13A8],bp
    79dd:78f4    cmp       bp,3F00
    79dd:78f8    jb        78FD
    79dd:78fa    call      MOREEXT
    79dd:78fd    pop       ax
    79dd:78fe    pop       cx
    79dd:78ff    pop       bp
    79dd:7900    pop       es
    79dd:7901  - xor       ax,ax
    79dd:7903  - mov       word ptr es:[di+01],ax
    79dd:7907  - mov       bp,0006
    79dd:790a  - ret
             EAEXPL:
    79dd:790b  - cmp       byte ptr [si],2C
    79dd:790e  - jne       7913
    79dd:7910    jmp       EAEXPLX
    79dd:7913  - mov       word ptr es:[di+01],cx
    79dd:7917  - mov       byte ptr es:[di+03],dl
    79dd:791b  - test      byte ptr ss:[0ACE],C0
    79dd:7921    je        7999
    79dd:7923    test      byte ptr ss:[0ACE],40
    79dd:7929    jne       7956
    79dd:792b    push      es
    79dd:792c    push      bp
    79dd:792d    mov       es,word ptr ss:[0AC5]
    79dd:7932    mov       bp,word ptr ss:[0AC9]
    79dd:7937    mov       word ptr es:[bp+06],di
    79dd:793b    mov       word ptr es:[bp+02],0004
    79dd:7941    add       bp,15
    79dd:7944    mov       word ptr ss:[0AC7],bp
    79dd:7949    cmp       bp,7F00
    79dd:794d    jb        7952
    79dd:794f    call      MOREFR
    79dd:7952    pop       bp
    79dd:7953    pop       es
    79dd:7954    jmp       7999
    79dd:7956    push      es
    79dd:7957    push      bp
    79dd:7958    push      cx
    79dd:7959    push      ax
    79dd:795a    mov       es,word ptr ss:[13A6]
    79dd:795f    mov       bp,word ptr ss:[13A8]
    79dd:7964    mov       ax,di
    79dd:7966    sub       ax,word ptr ss:[13B4]
    79dd:796b    xor       cx,cx
    79dd:796d    add       ax,word ptr ss:[13BE]
    79dd:7972    adc       cx,word ptr ss:[13BC]
    79dd:7977    mov       word ptr es:[bp+00],ax
    79dd:797b    mov       word ptr es:[bp+02],cx
    79dd:797f    mov       byte ptr es:[bp+04],04
    79dd:7984    add       bp,05
    79dd:7987    mov       word ptr ss:[13A8],bp
    79dd:798c    cmp       bp,3F00
    79dd:7990    jb        7995
    79dd:7992    call      MOREEXT
    79dd:7995    pop       ax
    79dd:7996    pop       cx
    79dd:7997    pop       bp
    79dd:7998    pop       es
    79dd:7999  - mov       bp,0022
    79dd:799c  - ret
             EAEXPLX:
    79dd:799d  - inc       si
    79dd:799e  - lodsb
    79dd:799f  - and       al,DF
    79dd:79a1  - cmp       al,58
    79dd:79a3  - je        79A8
    79dd:79a5    jmp       E_EAEXPLXERR
    79dd:79a8  - mov       word ptr es:[di+01],cx
    79dd:79ac  - mov       byte ptr es:[di+03],dl
    79dd:79b0  - test      byte ptr ss:[0ACE],C0
    79dd:79b6    je        7A2E
    79dd:79b8    test      byte ptr ss:[0ACE],40
    79dd:79be    jne       79EB
    79dd:79c0    push      es
    79dd:79c1    push      bp
    79dd:79c2    mov       es,word ptr ss:[0AC5]
    79dd:79c7    mov       bp,word ptr ss:[0AC9]
    79dd:79cc    mov       word ptr es:[bp+06],di
    79dd:79d0    mov       word ptr es:[bp+02],0004
    79dd:79d6    add       bp,15
    79dd:79d9    mov       word ptr ss:[0AC7],bp
    79dd:79de    cmp       bp,7F00
    79dd:79e2    jb        79E7
    79dd:79e4    call      MOREFR
    79dd:79e7    pop       bp
    79dd:79e8    pop       es
    79dd:79e9    jmp       7A2E
    79dd:79eb    push      es
    79dd:79ec    push      bp
    79dd:79ed    push      cx
    79dd:79ee    push      ax
    79dd:79ef    mov       es,word ptr ss:[13A6]
    79dd:79f4    mov       bp,word ptr ss:[13A8]
    79dd:79f9    mov       ax,di
    79dd:79fb    sub       ax,word ptr ss:[13B4]
    79dd:7a00    xor       cx,cx
    79dd:7a02    add       ax,word ptr ss:[13BE]
    79dd:7a07    adc       cx,word ptr ss:[13BC]
    79dd:7a0c    mov       word ptr es:[bp+00],ax
    79dd:7a10    mov       word ptr es:[bp+02],cx
    79dd:7a14    mov       byte ptr es:[bp+04],04
    79dd:7a19    add       bp,05
    79dd:7a1c    mov       word ptr ss:[13A8],bp
    79dd:7a21    cmp       bp,3F00
    79dd:7a25    jb        7A2A
    79dd:7a27    call      MOREEXT
    79dd:7a2a    pop       ax
    79dd:7a2b    pop       cx
    79dd:7a2c    pop       bp
    79dd:7a2d    pop       es
    79dd:7a2e  - mov       bp,0024
    79dd:7a31  - ret
             E_EAEXPLXERR:
    79dd:7a32  - mov       bp,0000
    79dd:7a35  - ret
             EAZP:
    79dd:7a36  - cmp       byte ptr [si],2C
    79dd:7a39  - jne       EAZPABS
    79dd:7a3b    jmp       EAZPINDEX
             EAZPABS:
    79dd:7a3e  - cmp       cx,00FF
    79dd:7a42  - jbe       7A47
    79dd:7a44    jmp       EAZPTOOBIG
    79dd:7a47  - mov       byte ptr es:[di+01],cl
    79dd:7a4b  - mov       bp,000C
    79dd:7a4e  - test      byte ptr ss:[0ACE],C0
    79dd:7a54    je        7ACC
    79dd:7a56    test      byte ptr ss:[0ACE],40
    79dd:7a5c    jne       7A89
    79dd:7a5e    push      es
    79dd:7a5f    push      bp
    79dd:7a60    mov       es,word ptr ss:[0AC5]
    79dd:7a65    mov       bp,word ptr ss:[0AC9]
    79dd:7a6a    mov       word ptr es:[bp+06],di
    79dd:7a6e    mov       word ptr es:[bp+02],0000
    79dd:7a74    add       bp,15
    79dd:7a77    mov       word ptr ss:[0AC7],bp
    79dd:7a7c    cmp       bp,7F00
    79dd:7a80    jb        7A85
    79dd:7a82    call      MOREFR
    79dd:7a85    pop       bp
    79dd:7a86    pop       es
    79dd:7a87    jmp       7ACC
    79dd:7a89    push      es
    79dd:7a8a    push      bp
    79dd:7a8b    push      cx
    79dd:7a8c    push      ax
    79dd:7a8d    mov       es,word ptr ss:[13A6]
    79dd:7a92    mov       bp,word ptr ss:[13A8]
    79dd:7a97    mov       ax,di
    79dd:7a99    sub       ax,word ptr ss:[13B4]
    79dd:7a9e    xor       cx,cx
    79dd:7aa0    add       ax,word ptr ss:[13BE]
    79dd:7aa5    adc       cx,word ptr ss:[13BC]
    79dd:7aaa    mov       word ptr es:[bp+00],ax
    79dd:7aae    mov       word ptr es:[bp+02],cx
    79dd:7ab2    mov       byte ptr es:[bp+04],00
    79dd:7ab7    add       bp,05
    79dd:7aba    mov       word ptr ss:[13A8],bp
    79dd:7abf    cmp       bp,3F00
    79dd:7ac3    jb        7AC8
    79dd:7ac5    call      MOREEXT
    79dd:7ac8    pop       ax
    79dd:7ac9    pop       cx
    79dd:7aca    pop       bp
    79dd:7acb    pop       es
    79dd:7acc  - ret
             EAZPINDEX:
    79dd:7acd  - inc       si
    79dd:7ace  - lodsb
    79dd:7acf  - and       al,DF
    79dd:7ad1  - cmp       al,58
    79dd:7ad3  - je        EAZPINDEXX
    79dd:7ad5  - cmp       al,59
    79dd:7ad7  - jne       7ADC
    79dd:7ad9    jmp       EAZPINDEXY
    79dd:7adc  - cmp       al,53
    79dd:7ade  - jne       7AE3
    79dd:7ae0    jmp       EAZPINDEXS
    79dd:7ae3  - mov       bp,0000
    79dd:7ae6  - ret
             EAZPINDEXX:
    79dd:7ae7  - mov       byte ptr es:[di+01],cl
    79dd:7aeb  - mov       bp,0012
    79dd:7aee  - test      byte ptr ss:[0ACE],C0
    79dd:7af4    je        7B6C
    79dd:7af6    test      byte ptr ss:[0ACE],40
    79dd:7afc    jne       7B29
    79dd:7afe    push      es
    79dd:7aff    push      bp
    79dd:7b00    mov       es,word ptr ss:[0AC5]
    79dd:7b05    mov       bp,word ptr ss:[0AC9]
    79dd:7b0a    mov       word ptr es:[bp+06],di
    79dd:7b0e    mov       word ptr es:[bp+02],0000
    79dd:7b14    add       bp,15
    79dd:7b17    mov       word ptr ss:[0AC7],bp
    79dd:7b1c    cmp       bp,7F00
    79dd:7b20    jb        7B25
    79dd:7b22    call      MOREFR
    79dd:7b25    pop       bp
    79dd:7b26    pop       es
    79dd:7b27    jmp       7B6C
    79dd:7b29    push      es
    79dd:7b2a    push      bp
    79dd:7b2b    push      cx
    79dd:7b2c    push      ax
    79dd:7b2d    mov       es,word ptr ss:[13A6]
    79dd:7b32    mov       bp,word ptr ss:[13A8]
    79dd:7b37    mov       ax,di
    79dd:7b39    sub       ax,word ptr ss:[13B4]
    79dd:7b3e    xor       cx,cx
    79dd:7b40    add       ax,word ptr ss:[13BE]
    79dd:7b45    adc       cx,word ptr ss:[13BC]
    79dd:7b4a    mov       word ptr es:[bp+00],ax
    79dd:7b4e    mov       word ptr es:[bp+02],cx
    79dd:7b52    mov       byte ptr es:[bp+04],00
    79dd:7b57    add       bp,05
    79dd:7b5a    mov       word ptr ss:[13A8],bp
    79dd:7b5f    cmp       bp,3F00
    79dd:7b63    jb        7B68
    79dd:7b65    call      MOREEXT
    79dd:7b68    pop       ax
    79dd:7b69    pop       cx
    79dd:7b6a    pop       bp
    79dd:7b6b    pop       es
    79dd:7b6c  - ret
             EAZPINDEXY:
    79dd:7b6d  - mov       byte ptr es:[di+01],cl
    79dd:7b71  - mov       bp,0014
    79dd:7b74  - test      byte ptr ss:[0ACE],C0
    79dd:7b7a    je        7BF2
    79dd:7b7c    test      byte ptr ss:[0ACE],40
    79dd:7b82    jne       7BAF
    79dd:7b84    push      es
    79dd:7b85    push      bp
    79dd:7b86    mov       es,word ptr ss:[0AC5]
    79dd:7b8b    mov       bp,word ptr ss:[0AC9]
    79dd:7b90    mov       word ptr es:[bp+06],di
    79dd:7b94    mov       word ptr es:[bp+02],0000
    79dd:7b9a    add       bp,15
    79dd:7b9d    mov       word ptr ss:[0AC7],bp
    79dd:7ba2    cmp       bp,7F00
    79dd:7ba6    jb        7BAB
    79dd:7ba8    call      MOREFR
    79dd:7bab    pop       bp
    79dd:7bac    pop       es
    79dd:7bad    jmp       7BF2
    79dd:7baf    push      es
    79dd:7bb0    push      bp
    79dd:7bb1    push      cx
    79dd:7bb2    push      ax
    79dd:7bb3    mov       es,word ptr ss:[13A6]
    79dd:7bb8    mov       bp,word ptr ss:[13A8]
    79dd:7bbd    mov       ax,di
    79dd:7bbf    sub       ax,word ptr ss:[13B4]
    79dd:7bc4    xor       cx,cx
    79dd:7bc6    add       ax,word ptr ss:[13BE]
    79dd:7bcb    adc       cx,word ptr ss:[13BC]
    79dd:7bd0    mov       word ptr es:[bp+00],ax
    79dd:7bd4    mov       word ptr es:[bp+02],cx
    79dd:7bd8    mov       byte ptr es:[bp+04],00
    79dd:7bdd    add       bp,05
    79dd:7be0    mov       word ptr ss:[13A8],bp
    79dd:7be5    cmp       bp,3F00
    79dd:7be9    jb        7BEE
    79dd:7beb    call      MOREEXT
    79dd:7bee    pop       ax
    79dd:7bef    pop       cx
    79dd:7bf0    pop       bp
    79dd:7bf1    pop       es
    79dd:7bf2  - ret
             EAZPINDEXS:
    79dd:7bf3  - cmp       cx,00FF
    79dd:7bf7  - jle       7BFC
    79dd:7bf9    jmp       EATOOBIGB
             INVSRCNAMETXT:
    79dd:7bfb    pop       es
    79dd:7bfc  - mov       byte ptr es:[di+01],cl
    79dd:7c00  - mov       bp,001E
    79dd:7c03  - test      byte ptr ss:[0ACE],C0
    79dd:7c09    je        7C81
    79dd:7c0b    test      byte ptr ss:[0ACE],40
    79dd:7c11    jne       7C3E
    79dd:7c13    push      es
    79dd:7c14    push      bp
    79dd:7c15    mov       es,word ptr ss:[0AC5]
    79dd:7c1a    mov       bp,word ptr ss:[0AC9]
    79dd:7c1f    mov       word ptr es:[bp+06],di
    79dd:7c23    mov       word ptr es:[bp+02],0000
    79dd:7c29    add       bp,15
    79dd:7c2c    mov       word ptr ss:[0AC7],bp
    79dd:7c31    cmp       bp,7F00
    79dd:7c35    jb        7C3A
    79dd:7c37    call      MOREFR
    79dd:7c3a    pop       bp
    79dd:7c3b    pop       es
    79dd:7c3c    jmp       7C81
    79dd:7c3e    push      es
             CANTALLOC:
    79dd:7c3f    push      bp
    79dd:7c40    push      cx
    79dd:7c41    push      ax
    79dd:7c42    mov       es,word ptr ss:[13A6]
    79dd:7c47    mov       bp,word ptr ss:[13A8]
    79dd:7c4c    mov       ax,di
    79dd:7c4e    sub       ax,word ptr ss:[13B4]
    79dd:7c53    xor       cx,cx
    79dd:7c55    add       ax,word ptr ss:[13BE]
    79dd:7c5a    adc       cx,word ptr ss:[13BC]
    79dd:7c5f    mov       word ptr es:[bp+00],ax
             REPTUNBAL:
    79dd:7c60    mov       word ptr [bp+00],ax
    79dd:7c63    mov       word ptr es:[bp+02],cx
    79dd:7c67    mov       byte ptr es:[bp+04],00
    79dd:7c6c    add       bp,05
    79dd:7c6f    mov       word ptr ss:[13A8],bp
    79dd:7c74    cmp       bp,3F00
    79dd:7c78    jb        7C7D
    79dd:7c7a    call      MOREEXT
    79dd:7c7d    pop       ax
    79dd:7c7e    pop       cx
    79dd:7c7f    pop       bp
    79dd:7c80    pop       es
    79dd:7c81  - ret
             EAINDEX:
             IFSUNBAL:
    79dd:7c82  - inc       si
    79dd:7c83  - lodsb
    79dd:7c84  - and       al,DF
    79dd:7c86  - cmp       al,58
    79dd:7c88  - je        EAINDEXX
    79dd:7c8a  - cmp       al,59
    79dd:7c8c  - je        EAINDEXY
    79dd:7c8e  - cmp       al,53
    79dd:7c90  - jne       7C95
    79dd:7c92    jmp       EAZPINDEXS
    79dd:7c95  - mov       bp,0000
    79dd:7c98  - ret
             EAINDEXX:
    79dd:7c99  - mov       bp,word ptr ss:[13F0]
    79dd:7c9e  - cmp       bp,word ptr ss:[0AB4]
    79dd:7ca3  - je        FORCEABSX
    79dd:7ca5  - cmp       cx,00FF
    79dd:7ca9  - ja        FORCEABSX
             CTRLC_HIT:
    79dd:7cab    jmp       EAZPINDEXX
             FORCEABSX:
    79dd:7cae  - mov       word ptr es:[di+01],cx
    79dd:7cb2  - mov       bp,000E
    79dd:7cb5  - ret
             EAINDEXY:
    79dd:7cb6  - mov       bp,word ptr ss:[13F0]
    79dd:7cbb  - cmp       bp,word ptr ss:[0AB4]
    79dd:7cc0  - je        FORCEABSY
    79dd:7cc2  - cmp       cx,00FF
    79dd:7cc6  - ja        FORCEABSY
    79dd:7cc8    jmp       EAZPINDEXY
             ENDCSUNBAL:
    79dd:7cca    ????
             FORCEABSY:
    79dd:7ccb  - mov       word ptr es:[di+01],cx
    79dd:7ccf  - mov       bp,0010
    79dd:7cd2  - ret
             EAINDEXFR:
    79dd:7cd3  - inc       si
    79dd:7cd4  - lodsb
    79dd:7cd5  - and       al,DF
    79dd:7cd7  - cmp       al,58
    79dd:7cd9  - je        EAINDEXXFR
    79dd:7cdb  - cmp       al,59
    79dd:7cdd  - jne       7CE2
    79dd:7cdf    jmp       EAINDEXYFR
    79dd:7ce2  - cmp       al,53
    79dd:7ce4  - jne       7CE9
    79dd:7ce6    jmp       EAZPINDEXS
    79dd:7ce9  - mov       bp,0000
    79dd:7cec  - ret
             EAINDEXXFR:
    79dd:7ced  - test      byte ptr ss:[0ACE],C0
    79dd:7cf3    jne       7CF8
             NESTEDERR:
    79dd:7cf5    jmp       7DC4
    79dd:7cf8    test      byte ptr ss:[0ACE],40
    79dd:7cfe    jne       7D46
    79dd:7d00    push      es
    79dd:7d01    push      bp
    79dd:7d02    mov       es,word ptr ss:[0AC5]
    79dd:7d07    mov       bp,word ptr ss:[0AC9]
    79dd:7d0c    mov       word ptr es:[bp+06],di
    79dd:7d10    mov       ax,word ptr [13F0]
    79dd:7d14    cmp       ax,word ptr ss:[0AB8]
    79dd:7d19    je        7D23
    79dd:7d1b    mov       word ptr es:[bp+02],0002
    79dd:7d21    jmp       7D31
    79dd:7d23    mov       word ptr es:[bp+02],0006
    79dd:7d29    mov       al,byte ptr [0F92]
    79dd:7d2d    mov       byte ptr es:[bp+0A],al
    79dd:7d31    add       bp,15
    79dd:7d34    mov       word ptr ss:[0AC7],bp
    79dd:7d39    cmp       bp,7F00
    79dd:7d3d    jb        7D42
    79dd:7d3f    call      MOREFR
    79dd:7d42    pop       bp
    79dd:7d43    pop       es
    79dd:7d44    jmp       7DC4
             NOSRCLEV:
    79dd:7d45    jle       7D7D
    79dd:7d47    mov       ax,word ptr [13F0]
    79dd:7d4a    cmp       ax,word ptr ss:[0AB8]
    79dd:7d4f    je        7D81
    79dd:7d51    push      es
    79dd:7d52    push      bp
    79dd:7d53    push      cx
    79dd:7d54    push      ax
    79dd:7d55    mov       es,word ptr ss:[13A6]
    79dd:7d5a    mov       bp,word ptr ss:[13A8]
    79dd:7d5f    mov       ax,di
    79dd:7d61    sub       ax,word ptr ss:[13B4]
    79dd:7d66    xor       cx,cx
    79dd:7d68    add       ax,word ptr ss:[13BE]
             MORELOCMEM:
    79dd:7d69    add       ax,word ptr [13BE]
    79dd:7d6d    adc       cx,word ptr ss:[13BC]
    79dd:7d72    mov       word ptr es:[bp+00],ax
    79dd:7d76    mov       word ptr es:[bp+02],cx
    79dd:7d7a    mov       byte ptr es:[bp+04],02
    79dd:7d7f    jmp       7DAF
    79dd:7d81    push      es
    79dd:7d82    push      bp
    79dd:7d83    push      cx
    79dd:7d84    push      ax
    79dd:7d85    mov       es,word ptr ss:[13A6]
    79dd:7d8a    mov       bp,word ptr ss:[13A8]
    79dd:7d8f    mov       ax,di
    79dd:7d91    sub       ax,word ptr ss:[13B4]
    79dd:7d96    xor       cx,cx
    79dd:7d98    add       ax,word ptr ss:[13BE]
             FAIL:
    79dd:7d9c    adc       si,word ptr [0E13]
    79dd:7da0    mov       sp,2613
    79dd:7da3    mov       word ptr [bp+00],ax
    79dd:7da6    mov       word ptr es:[bp+02],cx
    79dd:7daa    mov       byte ptr es:[bp+04],06
    79dd:7daf    add       bp,05
    79dd:7db2    mov       word ptr ss:[13A8],bp
    79dd:7db7    cmp       bp,3F00
    79dd:7dbb    jb        7DC0
    79dd:7dbd    call      MOREEXT
    79dd:7dc0    pop       ax
    79dd:7dc1    pop       cx
    79dd:7dc2    pop       bp
    79dd:7dc3    pop       es
    79dd:7dc4  - xor       ax,ax
    79dd:7dc6  - mov       word ptr es:[di+01],ax
    79dd:7dca  - mov       bp,000E
    79dd:7dcd  - ret
             EAINDEXYFR:
    79dd:7dce  - test      byte ptr ss:[0ACE],C0
    79dd:7dd4    jne       7DD9
    79dd:7dd6    jmp       7EA5
    79dd:7dd9    test      byte ptr ss:[0ACE],40
    79dd:7ddf    jne       7E27
    79dd:7de1    push      es
    79dd:7de2    push      bp
    79dd:7de3    mov       es,word ptr ss:[0AC5]
    79dd:7de8    mov       bp,word ptr ss:[0AC9]
    79dd:7ded    mov       word ptr es:[bp+06],di
    79dd:7df1    mov       ax,word ptr [13F0]
    79dd:7df5    cmp       ax,word ptr ss:[0AB8]
    79dd:7dfa    je        7E04
    79dd:7dfc    mov       word ptr es:[bp+02],0002
    79dd:7e02    jmp       7E12
    79dd:7e04    mov       word ptr es:[bp+02],0006
    79dd:7e0a    mov       al,byte ptr [0F92]
    79dd:7e0e    mov       byte ptr es:[bp+0A],al
    79dd:7e12    add       bp,15
    79dd:7e15    mov       word ptr ss:[0AC7],bp
    79dd:7e1a    cmp       bp,7F00
    79dd:7e1e    jb        7E23
    79dd:7e20    call      MOREFR
    79dd:7e23    pop       bp
    79dd:7e24    pop       es
    79dd:7e25    jmp       7EA5
    79dd:7e27    mov       ax,word ptr [13F0]
    79dd:7e2b    cmp       ax,word ptr ss:[0AB8]
    79dd:7e30    je        7E62
    79dd:7e32    push      es
    79dd:7e33    push      bp
    79dd:7e34    push      cx
    79dd:7e35    push      ax
    79dd:7e36    mov       es,word ptr ss:[13A6]
    79dd:7e3b    mov       bp,word ptr ss:[13A8]
    79dd:7e40    mov       ax,di
    79dd:7e42    sub       ax,word ptr ss:[13B4]
    79dd:7e47    xor       cx,cx
    79dd:7e49    add       ax,word ptr ss:[13BE]
    79dd:7e4e    adc       cx,word ptr ss:[13BC]
    79dd:7e53    mov       word ptr es:[bp+00],ax
    79dd:7e57    mov       word ptr es:[bp+02],cx
    79dd:7e5b    mov       byte ptr es:[bp+04],02
    79dd:7e60    jmp       7E90
    79dd:7e62    push      es
    79dd:7e63    push      bp
    79dd:7e64    push      cx
    79dd:7e65    push      ax
    79dd:7e66    mov       es,word ptr ss:[13A6]
    79dd:7e6b    mov       bp,word ptr ss:[13A8]
    79dd:7e70    mov       ax,di
    79dd:7e72    sub       ax,word ptr ss:[13B4]
    79dd:7e77    xor       cx,cx
    79dd:7e79    add       ax,word ptr ss:[13BE]
    79dd:7e7e    adc       cx,word ptr ss:[13BC]
    79dd:7e83    mov       word ptr es:[bp+00],ax
    79dd:7e87    mov       word ptr es:[bp+02],cx
    79dd:7e8b    mov       byte ptr es:[bp+04],06
             UNKBLK:
    79dd:7e8d    inc       si
    79dd:7e8e    add       al,06
    79dd:7e90    add       bp,05
    79dd:7e93    mov       word ptr ss:[13A8],bp
    79dd:7e98    cmp       bp,3F00
    79dd:7e9c    jb        7EA1
    79dd:7e9e    call      MOREEXT
    79dd:7ea1    pop       ax
    79dd:7ea2    pop       cx
    79dd:7ea3    pop       bp
    79dd:7ea4    pop       es
    79dd:7ea5  - xor       ax,ax
    79dd:7ea7  - mov       word ptr es:[di+01],ax
    79dd:7eab  - mov       bp,0010
    79dd:7eae  - ret
             EAIND:
    79dd:7eaf  - dec       si
    79dd:7eb0  - call      CONVEXPRESS
    79dd:7eb3  - mov       al,byte ptr [si]
             MAXERRORSTXT:
    79dd:7eb4    add       al,3C
    79dd:7eb6    sub       al,75
    79dd:7eb8    add       bp,cx
    79dd:7eba    pop       word ptr [bx+si]
    79dd:7ebc    xlat
    79dd:7ebe    or        al,al
    79dd:7ec0    js        7EC5
    79dd:7ec2    jmp       EAERR
    79dd:7ec5    mov       word ptr es:[di+01],cx
             MAPFILE_ERROR:
    79dd:7ec6    mov       word ptr [di+01],cx
    79dd:7ec9    mov       bp,0016
    79dd:7ecc    test      byte ptr ss:[0ACE],C0
    79dd:7ed2    je        7F4A
    79dd:7ed4    test      byte ptr ss:[0ACE],40
    79dd:7eda    jne       7F07
             INVTYPE:
    79dd:7edc    push      es
    79dd:7edd    push      bp
    79dd:7ede    mov       es,word ptr ss:[0AC5]
    79dd:7ee3    mov       bp,word ptr ss:[0AC9]
    79dd:7ee8    mov       word ptr es:[bp+06],di
    79dd:7eec    mov       word ptr es:[bp+02],0002
    79dd:7ef2    add       bp,15
    79dd:7ef5    mov       word ptr ss:[0AC7],bp
    79dd:7efa    cmp       bp,7F00
             BADVALUE:
    79dd:7efe    jb        7F03
    79dd:7f00    call      MOREFR
    79dd:7f03    pop       bp
    79dd:7f04    pop       es
    79dd:7f05    jmp       7F4A
    79dd:7f07    push      es
    79dd:7f08    push      bp
    79dd:7f09    push      cx
    79dd:7f0a    push      ax
    79dd:7f0b    mov       es,word ptr ss:[13A6]
    79dd:7f10    mov       bp,word ptr ss:[13A8]
             UNKNOWNINST:
    79dd:7f13    test      al,13
    79dd:7f15    mov       ax,di
    79dd:7f17    sub       ax,word ptr ss:[13B4]
    79dd:7f1c    xor       cx,cx
    79dd:7f1e    add       ax,word ptr ss:[13BE]
    79dd:7f23    adc       cx,word ptr ss:[13BC]
             BADSIZEB:
    79dd:7f28    mov       word ptr es:[bp+00],ax
    79dd:7f2c    mov       word ptr es:[bp+02],cx
    79dd:7f30    mov       byte ptr es:[bp+04],02
    79dd:7f35    add       bp,05
             BADSIZEW:
    79dd:7f37    add       ax,8936
    79dd:7f3a    test      al,13
    79dd:7f3d    cmp       bp,3F00
    79dd:7f41    jb        PCTOOBIG
    79dd:7f43    call      MOREEXT
             PCTOOBIG:
    79dd:7f46    pop       ax
    79dd:7f47    pop       cx
    79dd:7f48    pop       bp
    79dd:7f49    pop       es
    79dd:7f4a    ret
             INDCOMMA:
    79dd:7f4b    cmp       cx,00FF
    79dd:7f4f    jle       NEGADDR
    79dd:7f51    jmp       EAINDABSX
             NEGADDR:
    79dd:7f54    mov       al,byte ptr [si+01]
    79dd:7f57    and       al,DF
    79dd:7f59    cmp       al,58
    79dd:7f5b    jne       7F60
    79dd:7f5d    jmp       EAINDINDEX
    79dd:7f60    inc       si
    79dd:7f61    lodsb
    79dd:7f62    xlat
    79dd:7f64    or        al,al
             TOOBIGFORD:
    79dd:7f66    jns       7F6B
    79dd:7f68    jmp       EAERR
    79dd:7f6b    cmp       al,53
    79dd:7f6d    jne       7F72
    79dd:7f6f    jmp       EAINDSY
    79dd:7f72    cmp       al,59
    79dd:7f74    je        7F79
    79dd:7f76    jmp       EAERR
    79dd:7f79    mov       word ptr es:[di+01],cx
    79dd:7f7d    mov       bp,0018
             NOSUCHEA:
    79dd:7f7f    add       byte ptr [06F6],dh
    79dd:7f83    into
    79dd:7f84    or        al,al
    79dd:7f86    je        7FFE
    79dd:7f88    test      byte ptr ss:[0ACE],40
    79dd:7f8e    jne       7FBB
    79dd:7f90    push      es
    79dd:7f91    push      bp
    79dd:7f92    mov       es,word ptr ss:[0AC5]
    79dd:7f97    mov       bp,word ptr ss:[0AC9]
    79dd:7f9c    mov       word ptr es:[bp+06],di
    79dd:7fa0    mov       word ptr es:[bp+02],0000
    79dd:7fa6    add       bp,15
    79dd:7fa9    mov       word ptr ss:[0AC7],bp
             SYMBOLTWICE:
    79dd:7faa    mov       word ptr [0AC7],bp
    79dd:7fae    cmp       bp,7F00
    79dd:7fb2    jb        7FB7
    79dd:7fb4    call      MOREFR
    79dd:7fb7    pop       bp
    79dd:7fb8    pop       es
    79dd:7fb9    jmp       7FFE
    79dd:7fbb    push      es
    79dd:7fbc    push      bp
    79dd:7fbd    push      cx
    79dd:7fbe    push      ax
    79dd:7fbf    mov       es,word ptr ss:[13A6]
             MACTWICE:
    79dd:7fc0    mov       es,word ptr [13A6]
    79dd:7fc4    mov       bp,word ptr ss:[13A8]
    79dd:7fc9    mov       ax,di
    79dd:7fcb    sub       ax,word ptr ss:[13B4]
    79dd:7fd0    xor       cx,cx
    79dd:7fd2    add       ax,word ptr ss:[13BE]
             MACDEFEDTWICE:
    79dd:7fd5    mov       si,3613
    79dd:7fd8    adc       cx,word ptr [13BC]
    79dd:7fdc    mov       word ptr es:[bp+00],ax
    79dd:7fe0    mov       word ptr es:[bp+02],cx
    79dd:7fe4    mov       byte ptr es:[bp+04],00
    79dd:7fe9    add       bp,05
    79dd:7fec    mov       word ptr ss:[13A8],bp
    79dd:7ff1    cmp       bp,3F00
    79dd:7ff5    jb        7FFA
    79dd:7ff7    call      MOREEXT
    79dd:7ffa    pop       ax
    79dd:7ffb    pop       cx
    79dd:7ffc    pop       bp
    79dd:7ffd    pop       es
    79dd:7ffe    ret
             EAINDABSX:
    79dd:7fff    inc       si
    79dd:8000    lodsb
    79dd:8001    and       al,DF
    79dd:8003    cmp       al,58
    79dd:8005    je        BADSIZELWDN
    79dd:8007    jmp       EATOOBIGB
             BADSIZELWDN:
    79dd:800a    lodsb
    79dd:800b    cmp       al,29
    79dd:800d    je        8012
    79dd:800f    jmp       EATOOBIGB
    79dd:8012    mov       bp,word ptr ss:[13F0]
    79dd:8017    cmp       word ptr ss:[0AB8],bp
    79dd:801c    je        8021
    79dd:801e    jmp       EAERR
    79dd:8021    mov       word ptr es:[di+01],cx
             ABMISSING:
    79dd:8024    add       word ptr [di+001C],di
    79dd:8028    ret
             EAINDINDEX:
    79dd:8029    cmp       byte ptr [si+02],29
    79dd:802d    je        8032
    79dd:802f    jmp       EAERR
    79dd:8032    add       si,03
    79dd:8035    mov       bp,word ptr ss:[13F0]
    79dd:803a    cmp       bp,word ptr ss:[0AB8]
    79dd:803f    jne       8044
    79dd:8041    jmp       EAINDIDXJ
    79dd:8044    mov       byte ptr es:[di+01],cl
    79dd:8048    mov       bp,001A
             NOENDM:
    79dd:804b    test      byte ptr ss:[0ACE],C0
    79dd:8051    je        80C9
    79dd:8053    test      byte ptr ss:[0ACE],40
             TOOMANYPARS:
    79dd:8059    jne       8086
    79dd:805b    push      es
    79dd:805c    push      bp
    79dd:805d    mov       es,word ptr ss:[0AC5]
    79dd:8062    mov       bp,word ptr ss:[0AC9]
    79dd:8067    mov       word ptr es:[bp+06],di
    79dd:806b    mov       word ptr es:[bp+02],0000
    79dd:8071    add       bp,15
    79dd:8074    mov       word ptr ss:[0AC7],bp
             BADPARM:
    79dd:8078    or        al,byte ptr [bx+di+00FD]
    79dd:807c    jg        80F0
    79dd:807e    add       bp,ax
    79dd:8080    jnp       801F
    79dd:8082    pop       bp
    79dd:8083    pop       es
    79dd:8084    jmp       80C9
    79dd:8086    push      es
    79dd:8087    push      bp
    79dd:8088    push      cx
    79dd:8089    push      ax
    79dd:808a    mov       es,word ptr ss:[13A6]
    79dd:808f    mov       bp,word ptr ss:[13A8]
             PARNOTHERE:
    79dd:8091    test      al,13
    79dd:8094    mov       ax,di
    79dd:8096    sub       ax,word ptr ss:[13B4]
    79dd:809b    xor       cx,cx
    79dd:809d    add       ax,word ptr ss:[13BE]
    79dd:80a2    adc       cx,word ptr ss:[13BC]
    79dd:80a7    mov       word ptr es:[bp+00],ax
    79dd:80ab    mov       word ptr es:[bp+02],cx
             REPIMM:
    79dd:80ae    add       ah,byte ptr [46C6]
    79dd:80b2    add       al,00
    79dd:80b4    add       bp,05
    79dd:80b7    mov       word ptr ss:[13A8],bp
    79dd:80bc    cmp       bp,3F00
    79dd:80c0    jb        80C5
    79dd:80c2    call      MOREEXT
    79dd:80c5    pop       ax
    79dd:80c6    pop       cx
    79dd:80c7    pop       bp
    79dd:80c8    pop       es
    79dd:80c9    ret
             EAINDIDXJ:
    79dd:80ca    mov       word ptr es:[di+01],cx
    79dd:80ce    mov       bp,001C
    79dd:80d1    test      byte ptr ss:[0ACE],C0
             MUSTEVAL:
    79dd:80d7    je        814F
    79dd:80d9    test      byte ptr ss:[0ACE],40
    79dd:80df    jne       810C
    79dd:80e1    push      es
    79dd:80e2    push      bp
    79dd:80e3    mov       es,word ptr ss:[0AC5]
    79dd:80e8    mov       bp,word ptr ss:[0AC9]
    79dd:80ed    mov       word ptr es:[bp+06],di
    79dd:80f1    mov       word ptr es:[bp+02],0014
    79dd:80f7    add       bp,15
    79dd:80fa    mov       word ptr ss:[0AC7],bp
             CANTOPENFILE:
    79dd:80ff    cmp       bp,7F00
    79dd:8103    jb        8108
    79dd:8105    call      MOREFR
    79dd:8108    pop       bp
    79dd:8109    pop       es
    79dd:810a    jmp       814F
    79dd:810c    push      es
    79dd:810d    push      bp
    79dd:810e    push      cx
    79dd:810f    push      ax
             PREMEOF:
    79dd:8110    mov       es,word ptr ss:[13A6]
    79dd:8115    mov       bp,word ptr ss:[13A8]
    79dd:811a    mov       ax,di
    79dd:811c    sub       ax,word ptr ss:[13B4]
    79dd:8121    xor       cx,cx
    79dd:8123    add       ax,word ptr ss:[13BE]
    79dd:8128    adc       cx,word ptr ss:[13BC]
    79dd:812d    mov       word ptr es:[bp+00],ax
    79dd:8131    mov       word ptr es:[bp+02],cx
    79dd:8135    mov       byte ptr es:[bp+04],06
             MISSINGSINGLE:
    79dd:8136    mov       byte ptr [bp+04],06
    79dd:813a    add       bp,05
    79dd:813d    mov       word ptr ss:[13A8],bp
    79dd:8142    cmp       bp,3F00
    79dd:8146    jb        814B
    79dd:8148    call      MOREEXT
    79dd:814b    pop       ax
             MISSINGDOUBLE:
    79dd:814c    pop       cx
    79dd:814d    pop       bp
    79dd:814e    pop       es
    79dd:814f    ret
             EAINDSY:
    79dd:8150    lodsw
    79dd:8151    cmp       ax,2C29
    79dd:8154    je        8159
    79dd:8156    jmp       EAERR
    79dd:8159  - lodsb
    79dd:815a  - and       al,DF
    79dd:815c  - cmp       al,59
    79dd:815e  - je        8163
    79dd:8160    jmp       EAERR
             MISSINGBOTH:
    79dd:8162    add       ah,byte ptr [4D88]
    79dd:8166    add       word ptr [06F6],si
    79dd:816a    into
    79dd:816b    or        al,al
    79dd:816d    je        81E5
    79dd:816f    test      byte ptr ss:[0ACE],40
    79dd:8175    jne       81A2
    79dd:8177    push      es
    79dd:8178    push      bp
             TOOMANYENDCS:
    79dd:8179    mov       es,word ptr ss:[0AC5]
    79dd:817e    mov       bp,word ptr ss:[0AC9]
    79dd:8183    mov       word ptr es:[bp+06],di
    79dd:8187    mov       word ptr es:[bp+02],0000
             BADREPTCOUNT:
    79dd:818a    add       al,byte ptr [bx+si]
    79dd:818c    add       byte ptr [bp+di+15C5],al
    79dd:8190    mov       word ptr ss:[0AC7],bp
    79dd:8195    cmp       bp,7F00
    79dd:8199    jb        819E
             TMREPTS:
    79dd:819a    add       bp,ax
    79dd:819c    pop       di
    79dd:819d    pushf
    79dd:819e    pop       bp
    79dd:819f    pop       es
    79dd:81a0    jmp       81E5
    79dd:81a2    push      es
    79dd:81a3    push      bp
    79dd:81a4    push      cx
    79dd:81a5    push      ax
    79dd:81a6    mov       es,word ptr ss:[13A6]
             TOOMANYENDRS:
    79dd:81aa    adc       si,word ptr [2E8B]
    79dd:81ae    test      al,13
    79dd:81b0    mov       ax,di
    79dd:81b2    sub       ax,word ptr ss:[13B4]
    79dd:81b7    xor       cx,cx
    79dd:81b9    add       ax,word ptr ss:[13BE]
             TOOOLDREPT:
    79dd:81ba    add       ax,word ptr [13BE]
    79dd:81be    adc       cx,word ptr ss:[13BC]
    79dd:81c3    mov       word ptr es:[bp+00],ax
    79dd:81c7    mov       word ptr es:[bp+02],cx
    79dd:81cb    mov       byte ptr es:[bp+04],00
    79dd:81d0    add       bp,05
    79dd:81d3    mov       word ptr ss:[13A8],bp
             REPTFILEERR:
    79dd:81d7    adc       ax,word ptr [bx+di+00FD]
    79dd:81db    aas
    79dd:81dc    jb        81E1
    79dd:81de    call      MOREEXT
    79dd:81e1    pop       ax
    79dd:81e2    pop       cx
    79dd:81e3    pop       bp
    79dd:81e4    pop       es
    79dd:81e5    mov       bp,0020
    79dd:81e8    ret
             EADPIND:
    79dd:81e9    call      CONVEXPRESS
    79dd:81ec    or        dx,dx
    79dd:81ee    jns       81F3
    79dd:81f0    jmp       EAERR
    79dd:81f3    cmp       byte ptr [si],2E
    79dd:81f6    jne       EADPIND1
    79dd:81f8    inc       si
    79dd:81f9    lodsb
             MUSTHAVELAB:
    79dd:81fa    and       al,DF
    79dd:81fc    cmp       al,57
    79dd:81fe    je        EADPINDW
             EADPIND1:
    79dd:8200    cmp       cx,00FF
    79dd:8204    ja        8209
    79dd:8206    jmp       EADPINDDP
    79dd:8209    or        dx,dx
    79dd:820b    je        EADPINDW
    79dd:820d    jmp       EADPINDERR
             EADPINDW:
    79dd:8210    lodsb
    79dd:8211    cmp       al,5D
    79dd:8213    je        8218
    79dd:8215    jmp       EAERR
    79dd:8218    mov       word ptr es:[di+01],cx
    79dd:821c    test      byte ptr ss:[0ACE],C0
    79dd:8222    je        829A
    79dd:8224    test      byte ptr ss:[0ACE],40
    79dd:822a    jne       8257
    79dd:822c    push      es
    79dd:822d    push      bp
    79dd:822e    mov       es,word ptr ss:[0AC5]
    79dd:8233    mov       bp,word ptr ss:[0AC9]
    79dd:8238    mov       word ptr es:[bp+06],di
    79dd:823c    mov       word ptr es:[bp+02],0002
             NOTINMAC:
    79dd:8241    add       byte ptr [bp+di+15C5],al
    79dd:8245    mov       word ptr ss:[0AC7],bp
    79dd:824a    cmp       bp,7F00
    79dd:824e    jb        8253
    79dd:8250    call      MOREFR
             BADMVAL:
    79dd:8251    stosb
    79dd:8252    fwait
    79dd:8253    pop       bp
    79dd:8254    pop       es
    79dd:8255    jmp       829A
    79dd:8257    push      es
    79dd:8258    push      bp
    79dd:8259    push      cx
    79dd:825a    push      ax
    79dd:825b    mov       es,word ptr ss:[13A6]
    79dd:8260    mov       bp,word ptr ss:[13A8]
             BADMREG:
    79dd:8262    test      al,13
    79dd:8265    mov       ax,di
    79dd:8267    sub       ax,word ptr ss:[13B4]
    79dd:826c    xor       cx,cx
    79dd:826e    add       ax,word ptr ss:[13BE]
    79dd:8273    adc       cx,word ptr ss:[13BC]
             BADSEP:
    79dd:8276    mov       sp,2613
    79dd:8279    mov       word ptr [bp+00],ax
    79dd:827c    mov       word ptr es:[bp+02],cx
    79dd:8280    mov       byte ptr es:[bp+04],02
             OSBRACKET:
    79dd:8285    add       bp,05
    79dd:8288    mov       word ptr ss:[13A8],bp
    79dd:828d    cmp       bp,3F00
             CSBRACKET:
    79dd:8291    jb        8296
    79dd:8293    call      MOREEXT
    79dd:8296    pop       ax
    79dd:8297    pop       cx
    79dd:8298    pop       bp
    79dd:8299    pop       es
    79dd:829a    mov       bp,002A
             MISSINGQUOTES:
    79dd:829d    ret
             EADPINDDP:
    79dd:829e    lodsb
    79dd:829f    cmp       al,5D
    79dd:82a1    je        82A6
    79dd:82a3    jmp       EAERR
    79dd:82a6    mov       al,byte ptr [si]
    79dd:82a8    cmp       al,2C
    79dd:82aa    jne       82AF
    79dd:82ac    jmp       EADPINDY
    79dd:82af    test      byte ptr ss:[0ACE],C0
             OUTMACSPACE:
    79dd:82b5    je        832D
    79dd:82b7    test      byte ptr ss:[0ACE],40
    79dd:82bd    jne       82EA
    79dd:82bf    push      es
    79dd:82c0    push      bp
    79dd:82c1    mov       es,word ptr ss:[0AC5]
    79dd:82c6    mov       bp,word ptr ss:[0AC9]
    79dd:82cb    mov       word ptr es:[bp+06],di
    79dd:82cf    mov       word ptr es:[bp+02],0000
    79dd:82d5    add       bp,15
             SPURENDM:
    79dd:82d8    mov       word ptr ss:[0AC7],bp
    79dd:82dd    cmp       bp,7F00
    79dd:82e1    jb        82E6
    79dd:82e3    call      MOREFR
    79dd:82e6    pop       bp
             INCCOLINFO:
    79dd:82e7    pop       es
    79dd:82e8    jmp       832D
    79dd:82ea    push      es
    79dd:82eb    push      bp
    79dd:82ec    push      cx
    79dd:82ed    push      ax
    79dd:82ee    mov       es,word ptr ss:[13A6]
    79dd:82f3    mov       bp,word ptr ss:[13A8]
    79dd:82f8    mov       ax,di
    79dd:82fa    sub       ax,word ptr ss:[13B4]
    79dd:82ff    xor       cx,cx
    79dd:8301    add       ax,word ptr ss:[13BE]
    79dd:8306    adc       cx,word ptr ss:[13BC]
    79dd:830b    mov       word ptr es:[bp+00],ax
    79dd:830f    mov       word ptr es:[bp+02],cx
    79dd:8313    mov       byte ptr es:[bp+04],00
    79dd:8318    add       bp,05
    79dd:831b    mov       word ptr ss:[13A8],bp
    79dd:8320    cmp       bp,3F00
    79dd:8324    jb        8329
    79dd:8326    call      MOREEXT
    79dd:8329    pop       ax
    79dd:832a    pop       cx
    79dd:832b    pop       bp
    79dd:832c    pop       es
    79dd:832d  - mov       byte ptr es:[di+01],cl
    79dd:8331  - mov       bp,0026
    79dd:8334  - ret
             EADPINDY:
    79dd:8335  - inc       si
    79dd:8336  - lodsb
    79dd:8337  - and       al,DF
    79dd:8339  - cmp       al,59
    79dd:833b  - je        8340
    79dd:833d    jmp       EAERR
    79dd:8340  - test      byte ptr ss:[0ACE],C0
    79dd:8346    je        83BE
    79dd:8348    test      byte ptr ss:[0ACE],40
    79dd:834e    jne       837B
    79dd:8350    push      es
    79dd:8351    push      bp
    79dd:8352    mov       es,word ptr ss:[0AC5]
    79dd:8357    mov       bp,word ptr ss:[0AC9]
    79dd:835c    mov       word ptr es:[bp+06],di
    79dd:8360    mov       word ptr es:[bp+02],0000
    79dd:8366    add       bp,15
    79dd:8369    mov       word ptr ss:[0AC7],bp
    79dd:836e    cmp       bp,7F00
    79dd:8372    jb        8377
    79dd:8374    call      MOREFR
    79dd:8377    pop       bp
    79dd:8378    pop       es
    79dd:8379    jmp       83BE
    79dd:837b    push      es
    79dd:837c    push      bp
    79dd:837d    push      cx
             ILLFIRST:
    79dd:837e    push      ax
    79dd:837f    mov       es,word ptr ss:[13A6]
    79dd:8384    mov       bp,word ptr ss:[13A8]
    79dd:8389    mov       ax,di
    79dd:838b    sub       ax,word ptr ss:[13B4]
    79dd:8390    xor       cx,cx
    79dd:8392    add       ax,word ptr ss:[13BE]
    79dd:8397    adc       cx,word ptr ss:[13BC]
             GILESSPEC:
    79dd:839b    adc       sp,word ptr [4689]
    79dd:839f    add       byte ptr [4E89],ah
    79dd:83a3    add       ah,byte ptr [46C6]
    79dd:83a7    add       al,00
    79dd:83a9    add       bp,05
    79dd:83ac    mov       word ptr ss:[13A8],bp
    79dd:83b1    cmp       bp,3F00
    79dd:83b5    jb        83BA
    79dd:83b7    call      MOREEXT
    79dd:83ba    pop       ax
    79dd:83bb    pop       cx
    79dd:83bc    pop       bp
    79dd:83bd    pop       es
    79dd:83be  - mov       byte ptr es:[di+01],cl
    79dd:83c2  - mov       bp,0028
             UNKOPT:
    79dd:83c5  - ret
             EAJMPERR:
    79dd:83c6  - push      dx
    79dd:83c7    mov       dx,85DD
    79dd:83ca    call      ERROR_ROUT
    79dd:83cd    pop       dx
    79dd:83ce  - xor       bp,bp
    79dd:83d0  - ret
             EATOOBIGB:
    79dd:83d1  - xor       bp,bp
    79dd:83d3  - push      dx
    79dd:83d4    mov       dx,7F28
             MISSINGEXP:
    79dd:83d5    sub       byte ptr [bx+E8],bh
    79dd:83d8    xchg      si,ax
    79dd:83d9    popf
    79dd:83da    pop       dx
             EAERR:
    79dd:83db    xor       bp,bp
    79dd:83dd  - push      dx
    79dd:83de    mov       dx,7F7F
    79dd:83e1    call      ERROR_ROUT
    79dd:83e4    pop       dx
             EAMISSEXP:
    79dd:83e5    xor       bp,bp
    79dd:83e7  - push      dx
    79dd:83e8    mov       dx,83D5
             ILLEGALBASE:
    79dd:83e9    aad
    79dd:83eb    call      ERROR_ROUT
    79dd:83ee    pop       dx
             EADPINDERR:
    79dd:83ef    xor       bp,bp
    79dd:83f1  - push      dx
    79dd:83f2    mov       dx,7F37
    79dd:83f5    call      ERROR_ROUT
    79dd:83f8    pop       dx
             EAZPTOOBIG:
    79dd:83f9    xor       bp,bp
    79dd:83fb  - push      dx
    79dd:83fc    mov       dx,7F66
    79dd:83ff    call      ERROR_ROUT
    79dd:8402    pop       dx
             EAIMMERR1:
    79dd:8403    xor       bp,bp
             ILLEGALOP:
    79dd:8405  - push      dx
    79dd:8406    mov       dx,7F37
    79dd:8409    call      ERROR_ROUT
    79dd:840c    pop       dx
             EAIMMERR:
    79dd:840d    xor       bp,bp
    79dd:840f  - push      dx
    79dd:8410    mov       dx,7F28
    79dd:8413    call      ERROR_ROUT
    79dd:8416    pop       dx
             EAEXPERR:
    79dd:8417    xor       bp,bp
    79dd:8419  - push      dx
    79dd:841a    mov       dx,7F54
    79dd:841d    call      ERROR_ROUT
    79dd:8420    pop       dx
             A_LA_GILES:
    79dd:8421    xor       bp,bp
    79dd:8423  - push      dx
    79dd:8424    mov       dx,839B
             UNBALBRAC:
    79dd:8425    fwait
    79dd:8426    sub       ax,46
    79dd:8429    popf
    79dd:842a    pop       dx
             ADDSYMBOL:
    79dd:842b    cmp       byte ptr [si],2E
    79dd:842e  - je        8433
    79dd:8430    jmp       ADDPARENT
    79dd:8433  - push      bx
    79dd:8434  - push      es
    79dd:8435  - push      di
    79dd:8436  - push      ds
    79dd:8437  - mov       es,word ptr ss:[0F6C]
             TOOBIGSHIFT:
    79dd:843a    insb
    79dd:843b    ????
    79dd:843d    mov       di,word ptr [0F6E]
    79dd:8441    mov       word ptr ss:[9A88],es
    79dd:8446    mov       word ptr ss:[9A8A],di
    79dd:844b    mov       bx,79A9
             NUMTOOBIG:
    79dd:844e    xor       ah,ah
    79dd:8450    mov       cx,si
    79dd:8452    lodsb
    79dd:8453    xlat
    79dd:8455    stosb
    79dd:8456    mov       dx,ax
    79dd:8458    add       dx,dx
             L_SYMLOOP:
    79dd:845a    lodsb
    79dd:845b    xlat
    79dd:845d    or        al,al
    79dd:845f    js        L_ENDSYMHASH
    79dd:8461    stosb
    79dd:8462    add       dx,ax
    79dd:8464    add       dx,dx
    79dd:8466    lodsb
    79dd:8467    xlat
    79dd:8469    or        al,al
             DIVZERO:
    79dd:846a    sar       byte ptr [bx+si+4F],AA
    79dd:846e    add       dx,ax
    79dd:8470    add       dx,dx
    79dd:8472    lodsb
    79dd:8473    xlat
    79dd:8475    or        al,al
    79dd:8477    js        L_ENDSYMHASH
    79dd:8479    stosb
             MODLOW:
    79dd:847a    add       dx,ax
    79dd:847c    add       dx,dx
    79dd:847e    lodsb
    79dd:847f    xlat
    79dd:8481    or        al,al
    79dd:8483    js        L_ENDSYMHASH
    79dd:8485    stosb
    79dd:8486    add       dx,ax
    79dd:8488    add       dx,dx
    79dd:848a    lodsb
    79dd:848b    xlat
    79dd:848d    or        al,al
    79dd:848f    js        L_ENDSYMHASH
    79dd:8491    stosb
    79dd:8492    add       dx,ax
    79dd:8494    add       dx,dx
    79dd:8496    lodsb
    79dd:8497    xlat
    79dd:8499    or        al,al
    79dd:849b    js        L_ENDSYMHASH
    79dd:849d    stosb
    79dd:849e    add       dx,ax
             NULLSTR:
    79dd:849f    rol       byte ptr [bp+di],1
    79dd:84a1    shr       byte ptr [si+D736],cl
    79dd:84a5    or        al,al
    79dd:84a7    js        L_ENDSYMHASH
    79dd:84a9    stosb
    79dd:84aa    add       dx,ax
    79dd:84ac    add       dx,dx
    79dd:84ae    lodsb
    79dd:84af    xlat
    79dd:84b1    or        al,al
    79dd:84b3    js        L_ENDSYMHASH
    79dd:84b5    stosb
    79dd:84b6    add       dx,ax
    79dd:84b8    add       dx,dx
    79dd:84ba  - jmp       L_SYMLOOP
             L_ENDSYMHASH:
    79dd:84bc  - xor       al,al
    79dd:84be  - stosb
    79dd:84bf  - and       dx,0FFD
             NOTINREPT:
    79dd:84c2    ????
    79dd:84c4    mov       word ptr [0F6E],di
    79dd:84c8    push      si
    79dd:84c9    sub       si,cx
    79dd:84cb    mov       cx,si
    79dd:84cd    pop       si
    79dd:84ce    dec       si
    79dd:84cf    mov       ax,ss
    79dd:84d1    mov       ds,ax
    79dd:84d3    mov       bp,1472
             ENDOFIRP:
    79dd:84d4    jb        84EA
    79dd:84d6    add       bp,dx
             L_FIND:
    79dd:84d8    mov       ax,word ptr ds:[bp+00]
    79dd:84dc    or        ax,ax
    79dd:84de    je        L_HASHOK
    79dd:84e0    mov       bp,word ptr ds:[bp+02]
    79dd:84e4    mov       ds,ax
    79dd:84e6    cmp       cl,byte ptr ds:[bp+05]
    79dd:84ea    jne       L_FIND
    79dd:84ec    mov       dx,word ptr ss:[0F82]
    79dd:84f1    cmp       dx,word ptr ds:[bp+10]
    79dd:84f5    jne       L_FIND
    79dd:84f7    mov       dx,word ptr ss:[0F80]
    79dd:84fc    cmp       dx,word ptr ds:[bp+0E]
    79dd:8500    jne       L_FIND
    79dd:8502    push      ds
    79dd:8503    push      si
    79dd:8504    mov       dl,cl
    79dd:8506    mov       es,word ptr ds:[bp+06]
    79dd:850a    mov       di,word ptr ds:[bp+08]
    79dd:850e    mov       ds,word ptr ss:[9A88]
    79dd:8513    mov       si,word ptr ss:[9A8A]
             L_TEST:
    79dd:8518    lodsb
    79dd:8519    cmp       al,byte ptr es:[di]
    79dd:851c    jne       L_SYMBOLSNOTSAME
    79dd:851e    inc       di
    79dd:851f    dec       dl
    79dd:8521    jne       L_TEST
    79dd:8523    pop       si
    79dd:8524    pop       ds
    79dd:8525    jmp       L_SYM2
             L_SYMBOLSNOTSAME:
    79dd:8528    pop       si
    79dd:8529    pop       ds
    79dd:852a    jmp       L_FIND
             L_HASHOK:
    79dd:852c    mov       es,word ptr ss:[0F76]
    79dd:8531    mov       di,word ptr ss:[0F78]
             NOINCMEM:
    79dd:8535    ????
    79dd:8537    mov       word ptr [bp+00],es
    79dd:853a    mov       word ptr ds:[bp+02],di
    79dd:853e    pop       ds
    79dd:853f    xor       ax,ax
    79dd:8541    mov       word ptr es:[di],ax
    79dd:8544    mov       word ptr es:[di+02],ax
    79dd:8548    mov       byte ptr es:[di+05],cl
    79dd:854c    mov       ax,word ptr [9A88]
    79dd:8550    mov       word ptr es:[di+06],ax
             PUBNOLOCALS:
    79dd:8553    push      es
    79dd:8554    mov       ax,word ptr [9A8A]
    79dd:8558    mov       word ptr es:[di+08],ax
    79dd:855c    mov       byte ptr es:[di+04],09
    79dd:8561    mov       ax,word ptr [0F92]
    79dd:8565    mov       word ptr es:[di+0A],ax
    79dd:8569    mov       ax,word ptr [0F94]
    79dd:856d    mov       word ptr es:[di+0C],ax
    79dd:8571    mov       ax,word ptr [0F80]
             EXTNOLOCALS:
    79dd:8574    mov       tr1,ecx
    79dd:8577    inc       bp
    79dd:8578    push      cs
    79dd:8579    mov       ax,word ptr [0F82]
    79dd:857d    mov       word ptr es:[di+10],ax
    79dd:8581    mov       word ptr ss:[0F7C],es
    79dd:8586    mov       word ptr ss:[0F7E],di
    79dd:858b    add       di,12
    79dd:858e    mov       word ptr ss:[0F78],di
    79dd:8593    cmp       di,6D52
             ILLEGALEXTUSE:
    79dd:8595    push      dx
    79dd:8596    insw
    79dd:8597    jb        859C
    79dd:8599    call      MORESYM
    79dd:859c    mov       di,word ptr ss:[0F6E]
    79dd:85a1    cmp       di,66E7
    79dd:85a5    jb        85B0
    79dd:85a7    mov       dx,7D69
             INVALIDIRS:
    79dd:85a9    jge       8593
    79dd:85ab    jcxz      8549
    79dd:85ad    jmp       STOPASSEM
    79dd:85b0    mov       bp,word ptr ss:[13F0]
    79dd:85b5    mov       word ptr ss:[0F7A],bp
    79dd:85ba    add       word ptr ss:[13CA],01
    79dd:85c0    adc       word ptr ss:[13C8],00
             LMSODD:
    79dd:85c4    adc       ax,word ptr [bx+si]
    79dd:85c6    pop       di
    79dd:85c7    pop       es
    79dd:85c8    pop       bx
    79dd:85c9    ret
             L_SYM2:
    79dd:85ca    mov       bx,word ptr ss:[9A8A]
    79dd:85cf    mov       word ptr ss:[0F6E],bx
    79dd:85d4    mov       al,byte ptr ds:[bp+04]
    79dd:85d8    test      al,04
    79dd:85da    je        L_NOTSET
    79dd:85dc    mov       bx,word ptr ss:[13F0]
             DIFFBANK:
    79dd:85dd    mov       bx,word ptr [13F0]
    79dd:85e1    mov       word ptr ss:[0F7A],bx
    79dd:85e6    mov       word ptr ss:[0F7C],ds
    79dd:85eb    mov       word ptr ss:[0F7E],bp
    79dd:85f0    pop       ds
    79dd:85f1    pop       di
    79dd:85f2    pop       es
    79dd:85f3    pop       bx
    79dd:85f4    ret
             L_NOTSET:
    79dd:85f5    test      al,10
    79dd:85f7    je        L_NOTFR
    79dd:85f9  - mov       bx,word ptr ss:[13F0]
             EXTRACHARS:
    79dd:85fa    mov       bx,word ptr [13F0]
    79dd:85fe  - mov       word ptr ss:[0F7A],bx
    79dd:8603  - mov       byte ptr ds:[bp+04],09
    79dd:8608  - mov       ax,word ptr [0F92]
    79dd:860c  - mov       word ptr ds:[bp+0A],ax
    79dd:8610  - mov       ax,word ptr [0F94]
    79dd:8614  - mov       word ptr ds:[bp+0C],ax
    79dd:8618  - mov       word ptr ss:[0F7C],ds
             INVALIDDBR:
    79dd:861b    jl        862C
    79dd:861d  - mov       word ptr ss:[0F7E],bp
    79dd:8622  - add       word ptr ss:[13CA],01
    79dd:8628  - adc       word ptr ss:[13C8],00
    79dd:862e  - pop       ds
    79dd:862f  - pop       di
             PUBISEXTERN:
    79dd:8630  - pop       es
    79dd:8631  - pop       bx
    79dd:8632  - ret
             L_NOTFR:
    79dd:8633  - or        byte ptr ss:[0F8B],01
    79dd:8639  - pop       ds
    79dd:863a  - pop       di
    79dd:863b  - pop       es
    79dd:863c  - pop       bx
    79dd:863d  - ret
             ADDPARENT:
    79dd:863e  - push      bx
    79dd:863f  - push      es
    79dd:8640  - push      di
    79dd:8641  - push      ds
    79dd:8642  - mov       ax,word ptr [0F80]
    79dd:8646    mov       word ptr [0F84],ax
    79dd:864a    mov       ax,word ptr [0F82]
             EXTERNISPUB:
    79dd:864d    ????
    79dd:864f    mov       word ptr [0F86],ax
    79dd:8652    mov       ax,word ptr [0F6E]
    79dd:8656    mov       word ptr [0F70],ax
    79dd:865a  - mov       es,word ptr ss:[0F72]
    79dd:865f  - mov       di,word ptr ss:[0F74]
    79dd:8664  - mov       word ptr ss:[0F80],es
    79dd:8669  - mov       word ptr ss:[0F82],di
    79dd:866e  - mov       bx,79A9
    79dd:8671  - xor       ah,ah
    79dd:8673  - mov       cx,si
    79dd:8675  - lodsb
    79dd:8676  - xlat
    79dd:8678  - stosb
    79dd:8679  - mov       dx,ax
    79dd:867b  - add       dx,dx
             _SYMLOOP:
    79dd:867d  - lodsb
    79dd:867e    xlat
    79dd:8680    or        al,al
    79dd:8682    js        _ENDSYMHASH
    79dd:8684    stosb
    79dd:8685    add       dx,ax
    79dd:8687    add       dx,dx
    79dd:8689    lodsb
    79dd:868a    xlat
    79dd:868c    or        al,al
    79dd:868e    js        _ENDSYMHASH
    79dd:8690    stosb
    79dd:8691    add       dx,ax
    79dd:8693    add       dx,dx
    79dd:8695    lodsb
    79dd:8696    xlat
    79dd:8698    or        al,al
    79dd:869a    js        _ENDSYMHASH
    79dd:869c    stosb
    79dd:869d    add       dx,ax
    79dd:869f    add       dx,dx
    79dd:86a1    lodsb
    79dd:86a2    xlat
    79dd:86a4    or        al,al
    79dd:86a6    js        _ENDSYMHASH
    79dd:86a8    stosb
    79dd:86a9    add       dx,ax
    79dd:86ab    add       dx,dx
    79dd:86ad    lodsb
    79dd:86ae    xlat
    79dd:86b0    or        al,al
    79dd:86b2    js        _ENDSYMHASH
    79dd:86b4    stosb
    79dd:86b5    add       dx,ax
    79dd:86b7    add       dx,dx
    79dd:86b9    lodsb
    79dd:86ba    xlat
    79dd:86bc    or        al,al
    79dd:86be    js        _ENDSYMHASH
    79dd:86c0    stosb
    79dd:86c1    add       dx,ax
    79dd:86c3    add       dx,dx
    79dd:86c5    lodsb
    79dd:86c6    xlat
    79dd:86c8    or        al,al
    79dd:86ca    js        _ENDSYMHASH
    79dd:86cc    stosb
    79dd:86cd    add       dx,ax
    79dd:86cf    add       dx,dx
    79dd:86d1    lodsb
    79dd:86d2    xlat
    79dd:86d4    or        al,al
    79dd:86d6    js        _ENDSYMHASH
             INVARRAY:
    79dd:86d8    stosb
    79dd:86d9    add       dx,ax
    79dd:86db    add       dx,dx
    79dd:86dd  - jmp       _SYMLOOP
             _ENDSYMHASH:
    79dd:86df  - xor       al,al
    79dd:86e1  - stosb
    79dd:86e2  - and       dx,0FFD
    79dd:86e6  - mov       word ptr ss:[0F74],di
             STR2LONG:
    79dd:86e7    mov       word ptr [0F74],di
    79dd:86eb  - push      si
    79dd:86ec  - sub       si,cx
    79dd:86ee  - mov       cx,si
    79dd:86f0  - pop       si
    79dd:86f1  - dec       si
    79dd:86f2  - mov       ax,ss
    79dd:86f4  - mov       ds,ax
    79dd:86f6  - mov       bp,1472
    79dd:86f9  - add       bp,dx
             _FIND:
    79dd:86fb  - mov       ax,word ptr ds:[bp+00]
    79dd:86ff  - or        ax,ax
    79dd:8701  - je        _HASHOK
             NOSTRINGDEF:
    79dd:8702    cmp       ax,8B3E
    79dd:8705    outsb
    79dd:8706    add       cl,byte ptr [bp+3ED8]
    79dd:870a    cmp       cl,byte ptr [bp+05]
    79dd:870d    jne       _FIND
    79dd:870f    test      byte ptr ds:[bp+04],01
    79dd:8714    je        _FIND
    79dd:8716    push      ds
    79dd:8717    push      si
    79dd:8718    mov       dl,cl
    79dd:871a    mov       es,word ptr ds:[bp+06]
             NOSUCHENV:
    79dd:871e    mov       di,word ptr ds:[bp+08]
    79dd:8722    mov       ds,word ptr ss:[0F80]
    79dd:8727    mov       si,word ptr ss:[0F82]
             _TEST:
    79dd:872c    lodsb
    79dd:872d    cmp       al,byte ptr es:[di]
    79dd:8730    jne       _SYMBOLSNOTSAME
    79dd:8732    inc       di
    79dd:8733    dec       dl
    79dd:8735    jne       _TEST
    79dd:8737    pop       si
    79dd:8738    pop       ds
    79dd:8739    jmp       _SYM2
             _SYMBOLSNOTSAME:
    79dd:873c    pop       si
    79dd:873d    pop       ds
             BADFILENAME:
    79dd:873e    jmp       _FIND
             _HASHOK:
    79dd:8740    mov       es,word ptr ss:[0F76]
    79dd:8745    mov       di,word ptr ss:[0F78]
    79dd:874a    mov       word ptr ds:[bp+00],es
    79dd:874e    mov       word ptr ds:[bp+02],di
    79dd:8752    pop       ds
    79dd:8753    xor       ax,ax
    79dd:8755    mov       word ptr es:[di],ax
    79dd:8758    mov       word ptr es:[di+02],ax
    79dd:875c    mov       byte ptr es:[di+05],cl
    79dd:8760    mov       ax,word ptr [0F80]
    79dd:8764    mov       word ptr es:[di+06],ax
    79dd:8768    mov       ax,word ptr [0F82]
    79dd:876c    mov       word ptr es:[di+08],ax
    79dd:8770    mov       byte ptr es:[di+04],01
    79dd:8775    mov       ax,word ptr [0F92]
    79dd:8779    mov       word ptr es:[di+0A],ax
    79dd:877d  - mov       ax,word ptr [0F94]
    79dd:8781  - mov       word ptr es:[di+0C],ax
    79dd:8785  - mov       word ptr ss:[0F7C],es
             BADRADIX:
    79dd:8787    push      es
    79dd:8788    jl        8799
    79dd:878a  - mov       word ptr ss:[0F7E],di
    79dd:878f  - add       di,0E
    79dd:8792  - mov       word ptr ss:[0F78],di
    79dd:8797  - cmp       di,6D52
    79dd:879b    jb        87A0
    79dd:879d    call      MORESYM
    79dd:87a0  - mov       di,word ptr ss:[0F74]
    79dd:87a5  - cmp       di,3F80
    79dd:87a9    jb        87AE
    79dd:87ab    call      MORESYMTX
    79dd:87ae  - mov       bp,word ptr ss:[13F0]
             BADHEX:
    79dd:87b1    lock
    79dd:87b2    adc       si,word ptr [2E89]
    79dd:87b6    jp        87C7
    79dd:87b8    mov       ax,word ptr [0F6E]
    79dd:87bc    mov       word ptr [0F70],ax
    79dd:87c0    mov       word ptr ss:[0F6E],26E7
    79dd:87c7    add       word ptr ss:[13CA],01
    79dd:87cd    adc       word ptr ss:[13C8],00
             BADSTRVAL:
    79dd:87d2    add       byte ptr [bx+07],bl
    79dd:87d5    pop       bx
    79dd:87d6    ret
             _SYM2:
    79dd:87d7    mov       bx,word ptr ss:[0F82]
    79dd:87dc    mov       word ptr ss:[0F74],bx
    79dd:87e1    mov       al,byte ptr ds:[bp+04]
             BADPFSPEC:
    79dd:87e2    mov       al,byte ptr [bp+04]
    79dd:87e5    test      al,04
    79dd:87e7    je        _NOTSET
    79dd:87e9    mov       bx,word ptr ss:[13F0]
    79dd:87ee    mov       word ptr ss:[0F7A],bx
    79dd:87f3    mov       word ptr ss:[0F7C],ds
    79dd:87f8    mov       word ptr ss:[0F7E],bp
    79dd:87fd    mov       ax,word ptr [0F84]
    79dd:8801    mov       word ptr [0F80],ax
    79dd:8805    mov       ax,word ptr [0F86]
             PRINTFNOVAL:
    79dd:8809    mov       word ptr [0F82],ax
    79dd:880d    mov       ax,word ptr [0F70]
    79dd:8811    mov       word ptr [0F6E],ax
    79dd:8815    pop       ds
    79dd:8816    pop       di
    79dd:8817    pop       es
    79dd:8818    pop       bx
    79dd:8819    ret
             _NOTSET:
    79dd:881a    test      al,10
    79dd:881c    je        CANTFINDFR
    79dd:881e    test      byte ptr ss:[A49C],01
    79dd:8824    je        _NOT_FREF2EXT
    79dd:8826    mov       word ptr ss:[0F7C],ds
             BADFIELD:
    79dd:8827    mov       word ptr [0F7C],ds
    79dd:882b    mov       word ptr ss:[0F7E],bp
    79dd:8830    pop       ds
    79dd:8831    pop       di
    79dd:8832    pop       es
    79dd:8833    pop       bx
    79dd:8834    ret
             _NOT_FREF2EXT:
    79dd:8835    mov       bx,word ptr ss:[13F0]
    79dd:883a    mov       word ptr ss:[0F7A],bx
    79dd:883f    mov       al,byte ptr ds:[bp+04]
    79dd:8843    and       al,80
    79dd:8845    or        al,01
    79dd:8847    mov       byte ptr ds:[bp+04],al
    79dd:884b    mov       ax,word ptr [0F92]
    79dd:884f    mov       word ptr ds:[bp+0A],ax
    79dd:8853    mov       ax,word ptr [0F94]
    79dd:8857    mov       word ptr ds:[bp+0C],ax
    79dd:885b    mov       ax,word ptr ds:[bp+06]
    79dd:885f    mov       word ptr [0F80],ax
    79dd:8863    mov       ax,word ptr ds:[bp+08]
    79dd:8867    mov       word ptr [0F82],ax
    79dd:886b    mov       word ptr ss:[0F7C],ds
    79dd:8870    mov       word ptr ss:[0F7E],bp
    79dd:8875    add       word ptr ss:[13CA],01
    79dd:887b    adc       word ptr ss:[13C8],00
    79dd:8881    pop       ds
    79dd:8882    pop       di
    79dd:8883    pop       es
    79dd:8884    pop       bx
    79dd:8885    ret
             _NOTFR:
             CANTFINDFR:
    79dd:8886    mov       ax,word ptr [0F84]
    79dd:888a    mov       word ptr [0F80],ax
    79dd:888e    mov       ax,word ptr [0F86]
    79dd:8892    mov       word ptr [0F82],ax
    79dd:8896    mov       ax,word ptr [0F70]
             PUBLICNOTDEF:
    79dd:8899    ????
    79dd:889b    mov       word ptr [0F6E],ax
    79dd:889e    or        byte ptr ss:[0F8B],01
    79dd:88a4    pop       ds
    79dd:88a5    pop       di
    79dd:88a6    pop       es
    79dd:88a7    pop       bx
    79dd:88a8    ret
             GETMACRO:
    79dd:88a9    push      ds
    79dd:88aa    push      bx
    79dd:88ab    push      di
    79dd:88ac    push      es
    79dd:88ad    push      si
    79dd:88ae    push      ds
    79dd:88af    mov       bx,7A29
    79dd:88b2    xor       ah,ah
    79dd:88b4    xor       cx,cx
    79dd:88b6    lodsb
    79dd:88b7    inc       cx
    79dd:88b8    xlat
    79dd:88ba    mov       dx,ax
    79dd:88bc    add       dx,dx
             MG_SYMLOOP:
    79dd:88be    lodsb
    79dd:88bf    xlat
    79dd:88c1    or        al,al
    79dd:88c3    js        MG_ENDSYMHASH
             EXTNOTDEF:
    79dd:88c4    pop       bx
    79dd:88c5    add       dx,ax
    79dd:88c7    add       dx,dx
    79dd:88c9    inc       cx
    79dd:88ca    lodsb
    79dd:88cb    xlat
    79dd:88cd    or        al,al
    79dd:88cf    js        MG_ENDSYMHASH
    79dd:88d1    add       dx,ax
    79dd:88d3    add       dx,dx
    79dd:88d5    inc       cx
    79dd:88d6    lodsb
    79dd:88d7    xlat
    79dd:88d9    or        al,al
    79dd:88db    js        MG_ENDSYMHASH
    79dd:88dd    add       dx,ax
    79dd:88df    add       dx,dx
    79dd:88e1    inc       cx
    79dd:88e2    lodsb
    79dd:88e3    xlat
    79dd:88e5    or        al,al
    79dd:88e7    js        MG_ENDSYMHASH
    79dd:88e9    add       dx,ax
    79dd:88eb    add       dx,dx
    79dd:88ed    inc       cx
    79dd:88ee    lodsb
    79dd:88ef    xlat
    79dd:88f1    or        al,al
    79dd:88f3    js        MG_ENDSYMHASH
    79dd:88f5    add       dx,ax
    79dd:88f7    add       dx,dx
    79dd:88f9    inc       cx
    79dd:88fa    lodsb
    79dd:88fb    xlat
    79dd:88fd    or        al,al
    79dd:88ff    js        MG_ENDSYMHASH
    79dd:8901    add       dx,ax
    79dd:8903    add       dx,dx
    79dd:8905    inc       cx
    79dd:8906    lodsb
    79dd:8907    xlat
    79dd:8909    or        al,al
    79dd:890b    js        MG_ENDSYMHASH
    79dd:890d    add       dx,ax
    79dd:890f    add       dx,dx
    79dd:8911    inc       cx
    79dd:8912    lodsb
    79dd:8913    xlat
    79dd:8915    or        al,al
    79dd:8917    js        MG_ENDSYMHASH
    79dd:8919    add       dx,ax
    79dd:891b    add       dx,dx
    79dd:891d    inc       cx
    79dd:891e  - jmp       MG_SYMLOOP
             MG_ENDSYMHASH:
    79dd:8920  - inc       cx
    79dd:8921  - and       dx,0FFD
    79dd:8925  - mov       ax,ss
    79dd:8927  - mov       ds,ax
    79dd:8929  - mov       bp,1472
    79dd:892c  - add       bp,dx
             MG_NEXT:
    79dd:892e  - mov       ax,word ptr ds:[bp+00]
    79dd:8932  - or        ax,ax
    79dd:8934  - je        MG_NOTTHERE
    79dd:8936  - mov       bp,word ptr ds:[bp+02]
    79dd:893a  - mov       ds,ax
    79dd:893c  - cmp       cl,byte ptr ds:[bp+05]
    79dd:8940  - jne       MG_NEXT
    79dd:8942  - test      byte ptr ds:[bp+04],02
    79dd:8947  - je        MG_NEXT
    79dd:8949  - mov       es,word ptr ds:[bp+06]
    79dd:894d  - mov       di,word ptr ds:[bp+08]
    79dd:8951  - mov       word ptr ss:[020A],es
    79dd:8956  - mov       word ptr ss:[020C],di
    79dd:895b  - mov       dx,ds
    79dd:895d  - pop       ds
    79dd:895e  - pop       si
    79dd:895f  - mov       word ptr ss:[9A80],cx
    79dd:8964  - dec       cx
    79dd:8965  - push      si
             MG_LOOP:
    79dd:8966  - lodsb
    79dd:8967  - xlat
    79dd:8969  - cmp       al,byte ptr es:[di]
    79dd:896c  - jne       MG_NOTSAME
    79dd:896e  - inc       di
    79dd:896f  - dec       cx
    79dd:8970  - jne       MG_LOOP
    79dd:8972  - mov       cx,word ptr ss:[9A80]
    79dd:8977  - pop       ax
    79dd:8978  - pop       es
    79dd:8979  - pop       di
    79dd:897a  - pop       bx
    79dd:897b  - pop       ds
    79dd:897c  - ret
             MG_NOTSAME:
    79dd:897d  - push      ds
    79dd:897e  - mov       ds,dx
    79dd:8980  - mov       cx,word ptr ss:[9A80]
    79dd:8985  - jmp       MG_NEXT
             MG_NOTTHERE:
    79dd:8987  - mov       si,word ptr ss:[13F0]
    79dd:898c  - mov       word ptr ss:[0AAC],si
    79dd:8991  - pop       ds
    79dd:8992  - pop       si
    79dd:8993  - pop       es
    79dd:8994  - pop       di
    79dd:8995  - pop       bx
    79dd:8996  - pop       ds
    79dd:8997  - ret
             ADDMACRO:
    79dd:8998  - push      bx
    79dd:8999  - push      es
    79dd:899a  - push      di
    79dd:899b  - push      ds
    79dd:899c  - mov       es,word ptr ss:[0F72]
    79dd:89a1  - mov       di,word ptr ss:[0F74]
    79dd:89a6  - mov       word ptr ss:[9A7C],es
    79dd:89ab  - mov       word ptr ss:[9A7E],di
    79dd:89b0  - mov       bx,79A9
    79dd:89b3  - xor       ah,ah
    79dd:89b5  - mov       cx,si
    79dd:89b7  - lodsb
    79dd:89b8  - xlat
    79dd:89ba  - stosb
    79dd:89bb  - mov       dx,ax
    79dd:89bd  - add       dx,dx
             M_SYMLOOP:
    79dd:89bf  - lodsb
    79dd:89c0    xlat
    79dd:89c2    or        al,al
    79dd:89c4    js        M_ENDSYMHASH
    79dd:89c6    stosb
    79dd:89c7    add       dx,ax
    79dd:89c9    add       dx,dx
    79dd:89cb    lodsb
    79dd:89cc    xlat
    79dd:89ce    or        al,al
    79dd:89d0    js        M_ENDSYMHASH
    79dd:89d2    stosb
    79dd:89d3    add       dx,ax
    79dd:89d5    add       dx,dx
    79dd:89d7    lodsb
    79dd:89d8    xlat
    79dd:89da    or        al,al
    79dd:89dc    js        M_ENDSYMHASH
    79dd:89de    stosb
    79dd:89df    add       dx,ax
    79dd:89e1    add       dx,dx
    79dd:89e3    lodsb
    79dd:89e4    xlat
    79dd:89e6    or        al,al
    79dd:89e8    js        M_ENDSYMHASH
    79dd:89ea    stosb
    79dd:89eb    add       dx,ax
    79dd:89ed    add       dx,dx
    79dd:89ef    lodsb
    79dd:89f0    xlat
    79dd:89f2    or        al,al
    79dd:89f4    js        M_ENDSYMHASH
    79dd:89f6    stosb
    79dd:89f7    add       dx,ax
             QUOTETXT:
    79dd:89f8    rol       byte ptr [bp+di],1
    79dd:89fa    shr       byte ptr [si+D736],cl
             LINKSTRTMES:
    79dd:89fc    xlat
    79dd:89fe    or        al,al
    79dd:8a00    js        M_ENDSYMHASH
    79dd:8a02    stosb
    79dd:8a03    add       dx,ax
    79dd:8a05    add       dx,dx
    79dd:8a07    lodsb
    79dd:8a08    xlat
    79dd:8a0a    or        al,al
    79dd:8a0c    js        M_ENDSYMHASH
    79dd:8a0e    stosb
    79dd:8a0f    add       dx,ax
    79dd:8a11    add       dx,dx
    79dd:8a13    lodsb
    79dd:8a14    xlat
    79dd:8a16    or        al,al
    79dd:8a18    js        M_ENDSYMHASH
    79dd:8a1a    stosb
    79dd:8a1b    add       dx,ax
    79dd:8a1d    add       dx,dx
    79dd:8a1f  - jmp       M_SYMLOOP
             M_ENDSYMHASH:
    79dd:8a21  - xor       al,al
    79dd:8a23  - stosb
    79dd:8a24  - and       dx,0FFD
    79dd:8a28  - mov       word ptr ss:[0F74],di
    79dd:8a2d  - cmp       di,3F80
    79dd:8a31    jb        8A36
    79dd:8a33    call      MORESYMTX
    79dd:8a36  - push      si
    79dd:8a37  - sub       si,cx
    79dd:8a39  - mov       cx,si
    79dd:8a3b  - pop       si
    79dd:8a3c  - dec       si
    79dd:8a3d  - mov       ax,ss
    79dd:8a3f  - mov       ds,ax
    79dd:8a41  - mov       bp,1472
    79dd:8a44  - add       bp,dx
             M_FIND:
    79dd:8a46  - mov       ax,word ptr ds:[bp+00]
    79dd:8a4a  - or        ax,ax
    79dd:8a4c  - je        M_SYMOK
    79dd:8a4e  - mov       bp,word ptr ds:[bp+02]
    79dd:8a52  - mov       ds,ax
    79dd:8a54  - cmp       cl,byte ptr ds:[bp+05]
    79dd:8a58  - jne       M_FIND
    79dd:8a5a  - test      byte ptr ds:[bp+04],02
    79dd:8a5f  - je        M_FIND
    79dd:8a61  - push      ds
    79dd:8a62  - push      si
    79dd:8a63  - push      cx
    79dd:8a64  - mov       es,word ptr ds:[bp+06]
    79dd:8a68  - mov       di,word ptr ds:[bp+08]
    79dd:8a6c  - mov       ds,word ptr ss:[9A7C]
    79dd:8a71  - mov       si,word ptr ss:[9A7E]
             M_TEST:
    79dd:8a76  - lodsb
    79dd:8a77  - cmp       al,byte ptr es:[di]
    79dd:8a7a  - jne       M_SYMBOLSNOTSAME
    79dd:8a7c  - inc       di
    79dd:8a7d  - dec       cx
    79dd:8a7e  - jne       M_TEST
    79dd:8a80  - pop       cx
    79dd:8a81  - pop       si
    79dd:8a82  - pop       ds
    79dd:8a83  - pop       ds
    79dd:8a84  - pop       di
    79dd:8a85  - pop       es
    79dd:8a86  - pop       bx
    79dd:8a87  - push      dx
    79dd:8a88    mov       dx,7FC0
    79dd:8a8b    call      ERROR_ROUT
    79dd:8a8e    pop       dx
             M_SYMBOLSNOTSAME:
    79dd:8a8f  - pop       cx
    79dd:8a90  - pop       si
    79dd:8a91  - pop       ds
    79dd:8a92  - jmp       M_FIND
             M_SYMOK:
    79dd:8a94  - mov       es,word ptr ss:[0F76]
    79dd:8a99  - mov       di,word ptr ss:[0F78]
    79dd:8a9e  - mov       word ptr ds:[bp+00],es
    79dd:8aa2  - mov       word ptr ds:[bp+02],di
    79dd:8aa6  - pop       ds
    79dd:8aa7  - mov       bp,di
    79dd:8aa9  - xor       ax,ax
    79dd:8aab  - mov       word ptr es:[bp+00],ax
    79dd:8aaf  - mov       word ptr es:[bp+02],ax
    79dd:8ab3  - mov       byte ptr es:[bp+04],02
    79dd:8ab8  - mov       byte ptr es:[bp+05],cl
    79dd:8abc  - mov       ax,word ptr [9A7C]
    79dd:8ac0  - mov       word ptr es:[bp+06],ax
    79dd:8ac4  - mov       ax,word ptr [9A7E]
    79dd:8ac8  - mov       word ptr es:[bp+08],ax
    79dd:8acc  - mov       ax,word ptr [0AA2]
    79dd:8ad0  - mov       word ptr es:[bp+0A],ax
    79dd:8ad4  - mov       ax,word ptr [0AA4]
    79dd:8ad8  - mov       word ptr es:[bp+0C],ax
    79dd:8adc  - add       di,0E
    79dd:8adf  - mov       word ptr ss:[0F78],di
    79dd:8ae4  - cmp       di,6D52
    79dd:8ae8    jb        8AED
    79dd:8aea    call      MORESYM
    79dd:8aed  - pop       di
    79dd:8aee  - pop       es
    79dd:8aef  - pop       bx
    79dd:8af0  - ret
             CALCFIELD:
    79dd:8af1  - mov       cl,byte ptr ss:[2480]
    79dd:8af6  - or        cl,cl
    79dd:8af8  - je        ENDFIELD
    79dd:8afa  - sub       cl,byte ptr ss:[2485]
    79dd:8aff  - js        ENDFIELD
             FIELDLP:
    79dd:8b01  - mov       dx,2555
    79dd:8b04  - call      far ptr _OS2PRTSTRING
    79dd:8b09  - dec       cl
    79dd:8b0b  - jne       FIELDLP
             ENDFIELD:
    79dd:8b0d  - ret
             PRTDECW:
    79dd:8b0e  - push      di
    79dd:8b0f  - push      es
    79dd:8b10  - push      ds
    79dd:8b11  - push      ss
    79dd:8b12  - pop       es
    79dd:8b13  - push      cx
    79dd:8b14  - push      dx
    79dd:8b15  - mov       di,8A6E
    79dd:8b18  - call      BIN2DECW
    79dd:8b1b  - push      ss
    79dd:8b1c  - pop       ds
    79dd:8b1d  - call      CALCFIELD
    79dd:8b20  - push      bx
    79dd:8b21  - push      ds
    79dd:8b22    push      dx
    79dd:8b23    mov       dx,8AC9
    79dd:8b26    mov       ds,dx
    79dd:8b28    mov       dx,8A6E
    79dd:8b2b    call      far ptr _OS2PRTSTRING
    79dd:8b30    pop       dx
    79dd:8b31    pop       ds
    79dd:8b32  - pop       bx
    79dd:8b33  - pop       dx
    79dd:8b34  - pop       cx
    79dd:8b35  - pop       ds
    79dd:8b36  - pop       es
    79dd:8b37  - pop       di
    79dd:8b38  - ret
             BIN2DECW:
    79dd:8b39  - push      ax
    79dd:8b3a  - push      bx
    79dd:8b3b  - push      cx
    79dd:8b3c  - push      di
    79dd:8b3d  - mov       byte ptr ss:[2485],00
    79dd:8b43  - cmp       cx,270F
    79dd:8b47  - ja        BIN10000
    79dd:8b49  - cmp       cx,03E7
    79dd:8b4d  - ja        BIN1000
    79dd:8b4f  - cmp       cx,63
    79dd:8b52  - ja        BIN100
    79dd:8b54  - cmp       cx,09
    79dd:8b57  - ja        BIN10
    79dd:8b59  - jmp       BIN1
             BIN10000:
    79dd:8b5b  - mov       al,FF
    79dd:8b5d  - mov       bx,2710
             BINDIGIT1:
    79dd:8b60  - inc       al
    79dd:8b62  - sub       cx,bx
    79dd:8b64  - jae       BINDIGIT1
    79dd:8b66  - add       al,30
    79dd:8b68  - stosb
    79dd:8b69  - inc       byte ptr ss:[2485]
    79dd:8b6e  - add       cx,bx
             BIN1000:
    79dd:8b70  - mov       al,FF
    79dd:8b72  - mov       bx,03E8
             BINDIGIT2:
    79dd:8b75  - inc       al
    79dd:8b77  - sub       cx,bx
    79dd:8b79  - jae       BINDIGIT2
    79dd:8b7b  - add       al,30
    79dd:8b7d  - stosb
    79dd:8b7e  - inc       byte ptr ss:[2485]
    79dd:8b83  - add       cx,bx
             BIN100:
    79dd:8b85  - mov       al,FF
    79dd:8b87  - mov       bx,0064
             BINDIGIT3:
    79dd:8b8a  - inc       al
    79dd:8b8c  - sub       cx,bx
    79dd:8b8e  - jae       BINDIGIT3
    79dd:8b90  - add       al,30
    79dd:8b92  - stosb
    79dd:8b93  - inc       byte ptr ss:[2485]
    79dd:8b98  - add       cx,bx
             BIN10:
    79dd:8b9a  - mov       al,FF
    79dd:8b9c  - mov       bl,0A
             BINDIGIT4:
    79dd:8b9e  - inc       al
    79dd:8ba0  - sub       cl,bl
    79dd:8ba2  - jae       BINDIGIT4
    79dd:8ba4  - add       al,30
    79dd:8ba6  - stosb
    79dd:8ba7  - inc       byte ptr ss:[2485]
    79dd:8bac  - add       cl,bl
             BIN1:
    79dd:8bae  - mov       al,cl
    79dd:8bb0  - add       al,30
    79dd:8bb2  - stosb
    79dd:8bb3  - inc       byte ptr ss:[2485]
    79dd:8bb8  - mov       al,24
    79dd:8bba  - stosb
    79dd:8bbb  - mov       word ptr ss:[2488],di
    79dd:8bc0  - pop       di
    79dd:8bc1  - pop       cx
    79dd:8bc2  - pop       bx
    79dd:8bc3  - pop       ax
    79dd:8bc4  - ret
             BIN2HEXL:
    79dd:8bc5  - push      dx
    79dd:8bc6  - push      cx
    79dd:8bc7  - push      ax
    79dd:8bc8  - mov       word ptr ss:[9A78],dx
    79dd:8bcd  - mov       word ptr ss:[9A7A],cx
    79dd:8bd2  - mov       al,byte ptr [9A79]
    79dd:8bd6  - call      BIN2HEXB
    79dd:8bd9  - mov       al,byte ptr [9A78]
    79dd:8bdd  - call      BIN2HEXB
    79dd:8be0  - mov       al,byte ptr [9A7B]
    79dd:8be4  - call      BIN2HEXB
    79dd:8be7  - mov       al,byte ptr [9A7A]
    79dd:8beb  - call      BIN2HEXB
    79dd:8bee  - pop       ax
    79dd:8bef  - pop       cx
    79dd:8bf0  - pop       dx
    79dd:8bf1  - ret
             BIN2HEXB:
    79dd:8bf2  - push      ax
    79dd:8bf3  - shr       al,1
    79dd:8bf5  - shr       al,1
    79dd:8bf7  - shr       al,1
    79dd:8bf9  - shr       al,1
    79dd:8bfb  - add       al,30
    79dd:8bfd  - cmp       al,39
    79dd:8bff  - jle       BHOK2
    79dd:8c01  - add       al,07
             BHOK2:
    79dd:8c03  - stosb
    79dd:8c04  - pop       ax
    79dd:8c05  - and       al,0F
    79dd:8c07  - add       al,30
    79dd:8c09  - cmp       al,39
    79dd:8c0b  - jle       BHOK1
    79dd:8c0d  - add       al,07
             BHOK1:
    79dd:8c0f  - stosb
    79dd:8c10  - ret
             PRTDECL:
    79dd:8c11  - push      di
    79dd:8c12  - push      es
    79dd:8c13  - push      ds
    79dd:8c14  - push      ss
    79dd:8c15  - pop       es
    79dd:8c16  - push      cx
    79dd:8c17  - push      dx
    79dd:8c18  - mov       di,8A6E
    79dd:8c1b  - call      BIN2DECL
    79dd:8c1e  - push      ss
    79dd:8c1f  - pop       ds
    79dd:8c20  - call      CALCFIELD
    79dd:8c23  - push      bx
    79dd:8c24  - push      ds
    79dd:8c25    push      dx
    79dd:8c26    mov       dx,8AC9
    79dd:8c29    mov       ds,dx
    79dd:8c2b    mov       dx,8A6E
    79dd:8c2e    call      far ptr _OS2PRTSTRING
    79dd:8c33    pop       dx
    79dd:8c34    pop       ds
    79dd:8c35  - pop       bx
    79dd:8c36  - pop       dx
    79dd:8c37  - pop       cx
    79dd:8c38  - pop       ds
    79dd:8c39  - pop       es
    79dd:8c3a  - pop       di
    79dd:8c3b  - ret
             BIN2DECL:
    79dd:8c3c  - push      ax
    79dd:8c3d  - push      bx
    79dd:8c3e  - push      cx
    79dd:8c3f  - push      dx
    79dd:8c40  - push      di
    79dd:8c41  - push      bp
    79dd:8c42  - mov       byte ptr ss:[2485],00
    79dd:8c48  - cmp       dx,00
    79dd:8c4b  - js        B2DLBS
             B2DLBS1:
    79dd:8c4d  - cmp       dx,3B9A
    79dd:8c51  - jbe       8C56
    79dd:8c53    jmp       BINL1000000000
    79dd:8c56  - je        BINL1000000000A
    79dd:8c58  - cmp       dx,05F5
    79dd:8c5c  - jbe       8C61
    79dd:8c5e    jmp       BINL100000000
    79dd:8c61  - je        BINL100000000A
    79dd:8c63  - cmp       dx,0098
    79dd:8c67  - jbe       8C6C
    79dd:8c69    jmp       BINL10000000
    79dd:8c6c  - je        BINL10000000A
    79dd:8c6e  - cmp       dx,0F
    79dd:8c71  - jbe       8C76
    79dd:8c73    jmp       BINL1000000
    79dd:8c76  - je        BINL1000000A
    79dd:8c78  - cmp       dx,01
    79dd:8c7b  - jbe       8C80
    79dd:8c7d    jmp       BINL100000
    79dd:8c80  - je        BINL100000A
    79dd:8c82  - cmp       cx,270F
    79dd:8c86  - jbe       8C8B
    79dd:8c88    jmp       BINL10000
    79dd:8c8b  - cmp       cx,03E7
    79dd:8c8f  - jbe       8C94
    79dd:8c91    jmp       BINL1000
    79dd:8c94  - cmp       cx,63
    79dd:8c97  - jbe       8C9C
    79dd:8c99    jmp       BINL100
    79dd:8c9c  - cmp       cx,09
    79dd:8c9f  - jbe       8CA4
    79dd:8ca1    jmp       BINL10
    79dd:8ca4  - jmp       BINL1
             B2DLBS:
    79dd:8ca7  - not       cx
    79dd:8ca9  - not       dx
    79dd:8cab  - add       cx,01
    79dd:8cae  - adc       dx,00
    79dd:8cb1  - mov       al,2D
    79dd:8cb3  - stosb
    79dd:8cb4  - inc       byte ptr ss:[2485]
    79dd:8cb9  - jmp       B2DLBS1
             BINL1000000000A:
    79dd:8cbb  - cmp       cx,CA00
    79dd:8cbf  - jb        BINL100000000
    79dd:8cc1  - jmp       BINL1000000000
             BINL100000000A:
    79dd:8cc3  - cmp       cx,E100
    79dd:8cc7  - jb        BINL10000000
    79dd:8cc9  - jmp       BINL100000000
             BINL10000000A:
    79dd:8ccb  - cmp       cx,9680
    79dd:8ccf  - jb        BINL1000000
    79dd:8cd1  - jmp       BINL10000000
             BINL1000000A:
    79dd:8cd3  - cmp       cx,4240
    79dd:8cd7  - jb        BINL100000
    79dd:8cd9  - jmp       BINL1000000
             BINL100000A:
    79dd:8cdb  - cmp       cx,86A0
    79dd:8cdf  - jae       8CE4
    79dd:8ce1    jmp       BINL10000
    79dd:8ce4  - jmp       BINL100000
             BINL1000000000:
    79dd:8ce6  - mov       al,FF
    79dd:8ce8  - mov       bx,CA00
    79dd:8ceb  - mov       bp,3B9A
             BINLDIGIT1:
    79dd:8cee  - inc       al
    79dd:8cf0  - sub       cx,bx
    79dd:8cf2  - sbb       dx,bp
    79dd:8cf4  - jae       BINLDIGIT1
    79dd:8cf6  - add       al,30
    79dd:8cf8  - stosb
    79dd:8cf9  - inc       byte ptr ss:[2485]
    79dd:8cfe  - add       cx,bx
    79dd:8d00  - adc       dx,bp
             BINL100000000:
             HELPTXT:
    79dd:8d02  - mov       al,FF
    79dd:8d04  - mov       bx,E100
    79dd:8d07  - mov       bp,05F5
             BINLDIGIT2:
    79dd:8d0a  - inc       al
    79dd:8d0c  - sub       cx,bx
    79dd:8d0e  - sbb       dx,bp
    79dd:8d10  - jae       BINLDIGIT2
    79dd:8d12  - add       al,30
    79dd:8d14  - stosb
    79dd:8d15  - inc       byte ptr ss:[2485]
    79dd:8d1a  - add       cx,bx
    79dd:8d1c  - adc       dx,bp
             BINL10000000:
    79dd:8d1e  - mov       al,FF
    79dd:8d20  - mov       bx,9680
    79dd:8d23  - mov       bp,0098
             BINLDIGIT3:
    79dd:8d26  - inc       al
    79dd:8d28  - sub       cx,bx
    79dd:8d2a  - sbb       dx,bp
    79dd:8d2c  - jae       BINLDIGIT3
    79dd:8d2e  - add       al,30
    79dd:8d30  - stosb
    79dd:8d31  - inc       byte ptr ss:[2485]
    79dd:8d36  - add       cx,bx
    79dd:8d38  - adc       dx,bp
             BINL1000000:
    79dd:8d3a  - mov       al,FF
    79dd:8d3c  - mov       bx,4240
    79dd:8d3f  - mov       bp,000F
             BINLDIGIT4:
    79dd:8d42  - inc       al
    79dd:8d44  - sub       cx,bx
    79dd:8d46  - sbb       dx,bp
    79dd:8d48  - jae       BINLDIGIT4
    79dd:8d4a  - add       al,30
    79dd:8d4c  - stosb
    79dd:8d4d  - inc       byte ptr ss:[2485]
    79dd:8d52  - add       cx,bx
    79dd:8d54  - adc       dx,bp
             BINL100000:
    79dd:8d56  - mov       al,FF
    79dd:8d58  - mov       bx,86A0
    79dd:8d5b  - mov       bp,0001
             BINLDIGIT5:
    79dd:8d5e  - inc       al
    79dd:8d60  - sub       cx,bx
    79dd:8d62  - sbb       dx,bp
    79dd:8d64  - jae       BINLDIGIT5
    79dd:8d66  - add       al,30
    79dd:8d68  - stosb
    79dd:8d69  - inc       byte ptr ss:[2485]
    79dd:8d6e  - add       cx,bx
    79dd:8d70  - adc       dx,bp
             BINL10000:
    79dd:8d72  - mov       al,FF
    79dd:8d74  - mov       bx,2710
             BINDIGIT1B:
    79dd:8d77  - inc       al
    79dd:8d79  - sub       cx,bx
    79dd:8d7b  - sbb       dx,00
    79dd:8d7e  - jae       BINDIGIT1B
    79dd:8d80  - add       al,30
    79dd:8d82  - stosb
    79dd:8d83  - inc       byte ptr ss:[2485]
    79dd:8d88  - add       cx,bx
             BINL1000:
    79dd:8d8a  - mov       al,FF
    79dd:8d8c  - mov       bx,03E8
             BINDIGIT2B:
    79dd:8d8f  - inc       al
    79dd:8d91  - sub       cx,bx
    79dd:8d93  - jae       BINDIGIT2B
    79dd:8d95  - add       al,30
    79dd:8d97  - stosb
    79dd:8d98  - inc       byte ptr ss:[2485]
    79dd:8d9d  - add       cx,bx
             BINL100:
    79dd:8d9f  - mov       al,FF
    79dd:8da1  - mov       bx,0064
             BINDIGIT3B:
    79dd:8da4  - inc       al
    79dd:8da6  - sub       cx,bx
    79dd:8da8  - jae       BINDIGIT3B
    79dd:8daa  - add       al,30
    79dd:8dac  - stosb
    79dd:8dad  - inc       byte ptr ss:[2485]
    79dd:8db2  - add       cx,bx
             BINL10:
    79dd:8db4  - mov       al,FF
    79dd:8db6  - mov       bl,0A
             BINDIGIT4B:
    79dd:8db8  - inc       al
    79dd:8dba  - sub       cl,bl
    79dd:8dbc  - jae       BINDIGIT4B
    79dd:8dbe  - add       al,30
    79dd:8dc0  - stosb
    79dd:8dc1  - inc       byte ptr ss:[2485]
    79dd:8dc6  - add       cl,bl
             BINL1:
    79dd:8dc8  - mov       al,cl
    79dd:8dca  - add       al,30
    79dd:8dcc  - stosb
    79dd:8dcd  - inc       byte ptr ss:[2485]
    79dd:8dd2  - mov       al,24
    79dd:8dd4  - stosb
    79dd:8dd5  - mov       word ptr ss:[2488],di
    79dd:8dda  - pop       bp
    79dd:8ddb  - pop       di
    79dd:8ddc  - pop       dx
    79dd:8ddd  - pop       cx
    79dd:8dde  - pop       bx
    79dd:8ddf  - pop       ax
    79dd:8de0  - ret
             PRTHEXB:
    79dd:8de1  - push      ax
    79dd:8de2  - and       al,0F
    79dd:8de4  - add       al,30
    79dd:8de6  - cmp       al,39
    79dd:8de8  - jle       OK1
    79dd:8dea  - add       al,07
             OK1:
    79dd:8dec  - mov       byte ptr [8A6F],al
    79dd:8df0  - pop       ax
    79dd:8df1  - shr       al,1
    79dd:8df3  - shr       al,1
    79dd:8df5  - shr       al,1
    79dd:8df7  - shr       al,1
    79dd:8df9  - add       al,30
    79dd:8dfb  - cmp       al,39
    79dd:8dfd  - jle       OK2
    79dd:8dff  - add       al,07
             OK2:
    79dd:8e01  - mov       byte ptr [8A6E],al
    79dd:8e05  - mov       byte ptr ss:[8A70],24
    79dd:8e0b  - push      ds
    79dd:8e0c    push      dx
    79dd:8e0d    mov       dx,8AC9
    79dd:8e10    mov       ds,dx
    79dd:8e12    mov       dx,8A6E
    79dd:8e15    call      far ptr _OS2PRTSTRING
    79dd:8e1a    pop       dx
    79dd:8e1b    pop       ds
    79dd:8e1c  - ret
             PRTHEXL:
    79dd:8e1d  - push      di
    79dd:8e1e  - push      es
    79dd:8e1f  - push      ds
    79dd:8e20  - push      si
    79dd:8e21  - mov       word ptr ss:[9A78],dx
    79dd:8e26  - mov       word ptr ss:[9A7A],cx
    79dd:8e2b  - mov       al,byte ptr [9A79]
    79dd:8e2f  - call      PRTHEXB
    79dd:8e32  - mov       al,byte ptr [9A78]
    79dd:8e36  - call      PRTHEXB
    79dd:8e39  - mov       al,byte ptr [9A7B]
    79dd:8e3d  - call      PRTHEXB
    79dd:8e40  - mov       al,byte ptr [9A7A]
    79dd:8e44  - call      PRTHEXB
    79dd:8e47  - pop       si
    79dd:8e48  - pop       ds
    79dd:8e49  - pop       es
    79dd:8e4a  - pop       di
    79dd:8e4b  - ret
             PARSECLI:
    79dd:8e4c  - mov       ds,word ptr ss:[9BDE]
    79dd:8e51  - mov       si,word ptr ss:[9BE0]
    79dd:8e56  - lodsb
    79dd:8e57  - or        al,al
    79dd:8e59  - jne       OP_LP
    79dd:8e5b    jmp       OP_ERROR
             OP_LP:
    79dd:8e5e    lodsb
    79dd:8e5f  - cmp       al,20
    79dd:8e61  - je        OP_LP
    79dd:8e63  - cmp       al,09
    79dd:8e65  - je        OP_LP
    79dd:8e67  - cmp       al,2D
    79dd:8e69  - je        OPTION
    79dd:8e6b  - cmp       al,2F
    79dd:8e6d  - je        OPTION
    79dd:8e6f  - cmp       al,00
    79dd:8e71  - je        OP_RET
    79dd:8e73  - cmp       al,0D
    79dd:8e75  - je        OP_RET
    79dd:8e77  - mov       ax,ss
    79dd:8e79  - mov       es,ax
    79dd:8e7b  - mov       di,925C
    79dd:8e7e  - mov       word ptr ss:[9A90],es
    79dd:8e83  - mov       word ptr ss:[9A92],di
    79dd:8e88  - call      COPYNAME
    79dd:8e8b  - mov       byte ptr es:[di+FF],0D
    79dd:8e90  - mov       byte ptr es:[di],0A
    79dd:8e94  - mov       byte ptr ss:[0EE6],00
    79dd:8e9a  - jmp       OP_LP
             OP_RET:
    79dd:8e9c  - cmp       byte ptr ss:[925C],00
    79dd:8ea2  - je        OP_ERROR
    79dd:8ea4  - ret
             OPTION:
    79dd:8ea5  - lodsb
    79dd:8ea6  - and       al,DF
    79dd:8ea8  - cmp       al,46
    79dd:8eaa  - jne       8EAF
    79dd:8eac    jmp       OP_FILELIST
    79dd:8eaf  - cmp       al,4F
    79dd:8eb1  - jne       8EB6
    79dd:8eb3    jmp       OP_OBJECT
    79dd:8eb6  - cmp       al,45
    79dd:8eb8  - jne       8EBD
    79dd:8eba    jmp       OP_EQUATE
    79dd:8ebd  - cmp       al,53
    79dd:8ebf  - jne       8EC4
    79dd:8ec1    jmp       OP_SET
    79dd:8ec4  - cmp       al,44
    79dd:8ec6  - jne       8ECB
    79dd:8ec8    jmp       OP_DEFS
    79dd:8ecb  - cmp       al,58
    79dd:8ecd  - je        OP_SYMBOLS
    79dd:8ecf  - cmp       al,4C
    79dd:8ed1  - je        OP_LIST
    79dd:8ed3  - cmp       al,49
    79dd:8ed5  - je        OP_INCDIR
    79dd:8ed7  - cmp       al,56
    79dd:8ed9  - jne       8EDE
    79dd:8edb    jmp       OP_LINK
    79dd:8ede  - cmp       al,4D
    79dd:8ee0  - je        OP_ERRORS
    79dd:8ee2  - cmp       al,5A
    79dd:8ee4  - jne       8EE9
    79dd:8ee6    jmp       OP_MAPFILE
    79dd:8ee9  - cmp       al,50
    79dd:8eeb  - jne       OP_ERROR
    79dd:8eed    jmp       OP_PUT
             OP_ERROR:
    79dd:8ef0  - push      ds
    79dd:8ef1    push      dx
    79dd:8ef2    mov       dx,8AC9
    79dd:8ef5    mov       ds,dx
    79dd:8ef7    mov       dx,8D02
    79dd:8efa    call      far ptr _OS2PRTSTRING
    79dd:8eff    pop       dx
    79dd:8f00    pop       ds
    79dd:8f01  - jmp       OVERRET
             OP_INCDIR:
    79dd:8f04  - inc       si
    79dd:8f05  - mov       ax,ss
    79dd:8f07  - mov       es,ax
    79dd:8f09  - mov       di,0EE6
    79dd:8f0c  - call      COPYNAME
    79dd:8f0f  - jmp       OP_LP
             OP_ERRORS:
    79dd:8f12  - call      CONVEXPRESS
    79dd:8f15  - mov       word ptr ss:[13FD],cx
    79dd:8f1a  - jmp       OP_LP
             OP_LIST:
    79dd:8f1d  - or        byte ptr ss:[0F8B],04
    79dd:8f23  - jmp       OP_LP
             OP_SYMBOLS:
    79dd:8f26  - lodsb
    79dd:8f27  - cmp       al,20
    79dd:8f29  - je        OP_ERROR
    79dd:8f2b  - cmp       al,09
    79dd:8f2d  - je        OP_ERROR
    79dd:8f2f  - mov       ax,ss
    79dd:8f31  - mov       es,ax
    79dd:8f33  - mov       di,9B5C
    79dd:8f36  - mov       word ptr ss:[13F9],es
    79dd:8f3b  - mov       word ptr ss:[13FB],di
    79dd:8f40  - call      COPYNAME
    79dd:8f43  - mov       byte ptr ss:[13F8],01
    79dd:8f49  - jmp       OP_LP
             OP_FILELIST:
    79dd:8f4c  - lodsb
    79dd:8f4d  - cmp       al,20
    79dd:8f4f  - je        OP_ERROR
    79dd:8f51  - cmp       al,09
    79dd:8f53  - je        OP_ERROR
    79dd:8f55  - mov       byte ptr ss:[13F5],01
    79dd:8f5b  - mov       ax,ss
    79dd:8f5d  - mov       es,ax
    79dd:8f5f  - mov       di,9A9C
    79dd:8f62  - call      COPYNAME
    79dd:8f65  - push      ds
    79dd:8f66  - mov       ax,ss
    79dd:8f68  - mov       ds,ax
    79dd:8f6a  - mov       dx,9A9C
    79dd:8f6d  - xor       cx,cx
    79dd:8f6f  - call      far ptr _OS2OPENNEWFILE
    79dd:8f74  - pop       ds
    79dd:8f75  - jae       8F7A
    79dd:8f77    jmp       OP_OPER
    79dd:8f7a  - mov       word ptr [13F6],ax
    79dd:8f7e  - jmp       OP_LP
             OP_EQUATE:
    79dd:8f81  - mov       bx,76A7
    79dd:8f84  - call      ADDSYMBOL
    79dd:8f87  - cmp       byte ptr [si],3D
    79dd:8f8a  - je        8F8F
    79dd:8f8c    jmp       OP_LP
    79dd:8f8f  - inc       si
    79dd:8f90  - call      CONVEXPRESS
    79dd:8f93  - mov       es,word ptr ss:[0F7C]
    79dd:8f98  - mov       di,word ptr ss:[0F7E]
    79dd:8f9d  - mov       word ptr es:[di+0A],dx
    79dd:8fa1  - mov       word ptr es:[di+0C],cx
    79dd:8fa5  - jmp       OP_LP
             OP_SET:
    79dd:8fa8  - mov       bx,76A7
    79dd:8fab  - call      ADDSYMBOL
    79dd:8fae  - cmp       byte ptr [si],3D
    79dd:8fb1  - je        8FB6
    79dd:8fb3    jmp       OP_LP
    79dd:8fb6  - inc       si
    79dd:8fb7  - call      CONVEXPRESS
    79dd:8fba  - mov       es,word ptr ss:[0F7C]
    79dd:8fbf  - mov       di,word ptr ss:[0F7E]
    79dd:8fc4  - mov       word ptr es:[di+0A],dx
    79dd:8fc8  - mov       word ptr es:[di+0C],cx
    79dd:8fcc  - mov       byte ptr es:[di+04],05
    79dd:8fd1  - jmp       OP_LP
             OP_DEFS:
    79dd:8fd4  - jmp       OP_LP
             OP_PUT:
    79dd:8fd7  - lodsb
    79dd:8fd8  - cmp       al,20
    79dd:8fda  - jne       8FDF
    79dd:8fdc    jmp       OP_ERROR
    79dd:8fdf  - cmp       al,09
    79dd:8fe1  - jne       8FE6
    79dd:8fe3    jmp       OP_ERROR
    79dd:8fe6  - mov       byte ptr ss:[13F2],01
    79dd:8fec  - mov       ax,ss
    79dd:8fee  - mov       es,ax
    79dd:8ff0  - mov       di,9B9C
    79dd:8ff3  - call      COPYNAME
    79dd:8ff6  - push      ds
    79dd:8ff7  - mov       ax,ss
    79dd:8ff9  - mov       ds,ax
    79dd:8ffb  - mov       dx,9B9C
    79dd:8ffe  - xor       cx,cx
    79dd:9000  - call      far ptr _OS2OPENNEWFILE
    79dd:9005  - pop       ds
    79dd:9006  - jb        OP_OPER
    79dd:9008  - mov       word ptr [13F3],ax
    79dd:900c  - jmp       OP_LP
             OP_OBJECT:
    79dd:900f  - lodsb
    79dd:9010  - cmp       al,20
    79dd:9012  - jne       9017
    79dd:9014    jmp       OP_ERROR
    79dd:9017  - cmp       al,09
    79dd:9019  - jne       901E
    79dd:901b    jmp       OP_ERROR
    79dd:901e  - mov       ax,ss
    79dd:9020  - mov       es,ax
    79dd:9022  - mov       di,9ADC
    79dd:9025  - mov       word ptr ss:[249C],es
    79dd:902a  - mov       word ptr ss:[249E],di
    79dd:902f  - call      COPYNAME
    79dd:9032  - mov       byte ptr ss:[2498],01
    79dd:9038  - jmp       OP_LP
             OP_LINK:
    79dd:903b  - lodsb
    79dd:903c  - cmp       al,20
    79dd:903e  - jne       9043
    79dd:9040    jmp       OP_ERROR
    79dd:9043  - cmp       al,09
    79dd:9045  - jne       904A
    79dd:9047    jmp       OP_ERROR
    79dd:904a  - mov       ax,ss
    79dd:904c  - mov       es,ax
    79dd:904e  - mov       di,9B1C
    79dd:9051  - call      COPYNAME
    79dd:9054  - mov       byte ptr ss:[13A0],01
    79dd:905a  - jmp       OP_LP
             OP_MAPFILE:
    79dd:905d  - mov       byte ptr ss:[9BE8],01
    79dd:9063  - jmp       OP_LP
             OP_OPER:
    79dd:9066  - push      ds
    79dd:9067    push      dx
             DEFAULTSRC:
    79dd:9068    mov       dx,8AC9
    79dd:906b    mov       ds,dx
    79dd:906d    mov       dx,89C4
    79dd:9070    call      far ptr _OS2PRTSTRING
    79dd:9075    pop       dx
    79dd:9076    pop       ds
    79dd:9077  - jmp       OVERRET
             COPYNAME:
    79dd:907a  - dec       si
    79dd:907b  - mov       bx,7929
             CNLOOP:
    79dd:907e  - lodsb
    79dd:907f  - stosb
    79dd:9080  - xlat
    79dd:9082  - or        al,al
    79dd:9084  - jns       CNLOOP
    79dd:9086  - mov       byte ptr es:[di+FF],00
    79dd:908b  - dec       si
    79dd:908c  - ret
             REGNERR1:
    79dd:908d    pop       ax
             REGNERR:
    79dd:908e    push      dx
    79dd:908f    mov       dx,8251
    79dd:9092    call      ERROR_ROUT
    79dd:9095    pop       dx
    79dd:9096    ret
             GREGERR:
    79dd:9097    push      dx
    79dd:9098    mov       dx,8262
    79dd:909b    call      ERROR_ROUT
    79dd:909e    pop       dx
    79dd:909f    ret
             PARSEMARIO:
    79dd:90a0    mov       dx,si
    79dd:90a2    lodsb
    79dd:90a3    mov       bp,ax
    79dd:90a5    and       bp,00FF
    79dd:90a9    add       bp,bp
    79dd:90ab    jmp       word ptr [bp+6821]
             M_MORE:
    79dd:90af    mov       dx,si
    79dd:90b1    lodsb
    79dd:90b2    mov       bp,ax
    79dd:90b4    and       bp,00FF
    79dd:90b8    add       bp,bp
    79dd:90ba    jmp       word ptr [bp+6821]
    79dd:90be    ret
             M_GOTEOL:
    79dd:90bf    dec       si
    79dd:90c0    ret
             M_A:
    79dd:90c1    lodsw
    79dd:90c2    and       ax,DFDF
    79dd:90c5    cmp       ax,4444
    79dd:90c8    jne       90CD
    79dd:90ca    jmp       M_ADD
    79dd:90cd    cmp       ax,4344
    79dd:90d0    jne       90D5
    79dd:90d2    jmp       M_ADC
    79dd:90d5    cmp       ax,444E
    79dd:90d8    jne       90DD
    79dd:90da    jmp       M_AND
    79dd:90dd    cmp       ax,5253
    79dd:90e0    jne       90E5
    79dd:90e2    jmp       M_ASR
    79dd:90e5    jmp       PM
             M_B:
    79dd:90e8    lodsw
    79dd:90e9    and       ax,DFDF
    79dd:90ec    cmp       ax,4152
    79dd:90ef    jne       90F4
    79dd:90f1    jmp       M_BRA
    79dd:90f4    cmp       ax,4547
    79dd:90f7    jne       90FC
    79dd:90f9    jmp       M_BGE
    79dd:90fc    cmp       ax,544C
    79dd:90ff    jne       9104
    79dd:9101    jmp       M_BLT
    79dd:9104    cmp       ax,454E
    79dd:9107    jne       910C
    79dd:9109    jmp       M_BNE
    79dd:910c    cmp       ax,5145
    79dd:910f    jne       9114
    79dd:9111    jmp       M_BEQ
    79dd:9114    cmp       ax,4C50
    79dd:9117    jne       911C
    79dd:9119    jmp       M_BPL
    79dd:911c    cmp       ax,494D
    79dd:911f    jne       9124
    79dd:9121    jmp       M_BMI
    79dd:9124    cmp       ax,4343
    79dd:9127    jne       912C
    79dd:9129    jmp       M_BCC
    79dd:912c    cmp       ax,5343
    79dd:912f    jne       9134
    79dd:9131    jmp       M_BCS
    79dd:9134    cmp       ax,4356
    79dd:9137    jne       913C
    79dd:9139    jmp       M_BVC
    79dd:913c    cmp       ax,5356
    79dd:913f    jne       9144
    79dd:9141    jmp       M_BVS
    79dd:9144    cmp       ax,4349
    79dd:9147    jne       914C
    79dd:9149    jmp       M_BIC
    79dd:914c    jmp       PM
             M_C:
    79dd:914f    lodsw
    79dd:9150    and       ax,DFDF
    79dd:9153    cmp       ax,4341
    79dd:9156    jne       915B
    79dd:9158    jmp       M_CAC
    79dd:915b    cmp       ax,4C4F
    79dd:915e    jne       9163
    79dd:9160    jmp       M_COL
    79dd:9163    cmp       ax,4F4D
    79dd:9166    jne       916B
    79dd:9168    jmp       M_CMO
    79dd:916b    cmp       ax,504D
    79dd:916e    jne       9173
    79dd:9170    jmp       M_CMP
    79dd:9173    cmp       ax,4F4C
    79dd:9176    je        M_CLO
    79dd:9178    dec       si
    79dd:9179    cmp       al,48
    79dd:917b    jne       9180
    79dd:917d    jmp       P_CH
    79dd:9180    jmp       PM
             M_CLO:
    79dd:9183    lodsb
    79dd:9184    and       al,DF
    79dd:9186    cmp       al,53
    79dd:9188    je        918D
    79dd:918a    jmp       PM
    79dd:918d    lodsb
    79dd:918e    and       al,DF
    79dd:9190    cmp       al,45
    79dd:9192    je        9197
    79dd:9194    jmp       PM
    79dd:9197    mov       al,byte ptr [si]
    79dd:9199    xlat
    79dd:919b    or        al,al
    79dd:919d    jns       M_D
    79dd:919f    jmp       P_FCLOSE
             M_D:
    79dd:91a2    lodsw
    79dd:91a3    and       ax,DFDF
    79dd:91a6    cmp       ax,5649
    79dd:91a9    jne       91AE
    79dd:91ab    jmp       M_DIV
    79dd:91ae    cmp       ax,4345
    79dd:91b1    jne       91B6
    79dd:91b3    jmp       M_DEC
    79dd:91b6    cmp       ax,4645
    79dd:91b9    je        M_DEF
    79dd:91bb    dec       si
    79dd:91bc    cmp       al,42
    79dd:91be    jne       91C3
    79dd:91c0    jmp       P_DB
    79dd:91c3    cmp       al,57
    79dd:91c5    jne       91CA
    79dd:91c7    jmp       P_DW
    79dd:91ca    cmp       al,53
    79dd:91cc    jne       91D1
    79dd:91ce    jmp       P_DS
    79dd:91d1    cmp       al,45
    79dd:91d3    jne       91D8
    79dd:91d5    jmp       P_DE
    79dd:91d8    jmp       PM
             M_DEF:
    79dd:91db    lodsb
    79dd:91dc    and       al,DF
    79dd:91de    cmp       al,53
    79dd:91e0    je        91E5
    79dd:91e2    jmp       PM
    79dd:91e5    mov       al,byte ptr [si]
    79dd:91e7    xlat
    79dd:91e9    or        al,al
    79dd:91eb    jns       M_E
    79dd:91ed    jmp       M_DEFS
             M_E:
    79dd:91f0    lodsw
    79dd:91f1    and       ax,DFDF
    79dd:91f4    cmp       ax,5551
    79dd:91f7    jne       91FC
    79dd:91f9    jmp       M_EQU
    79dd:91fc    cmp       ax,444E
    79dd:91ff    jne       9204
    79dd:9201    jmp       M_END
    79dd:9204    cmp       ax,534C
    79dd:9207    jne       920C
    79dd:9209    jmp       P_ELS
    79dd:920c    cmp       ax,5458
    79dd:920f    je        M_EXT
    79dd:9211    jmp       PM
             M_EXT:
    79dd:9214    lodsw
    79dd:9215    and       ax,DFDF
    79dd:9218    cmp       ax,5245
    79dd:921b    je        M_EXTER
    79dd:921d    jmp       PM
             M_EXTER:
    79dd:9220    lodsb
    79dd:9221    and       al,DF
    79dd:9223    cmp       al,4E
    79dd:9225    je        922A
    79dd:9227    jmp       PM
    79dd:922a    mov       al,byte ptr [si]
    79dd:922c    xlat
    79dd:922e    or        al,al
    79dd:9230    jns       M_F
    79dd:9232    jmp       M_EXTERN
             M_F:
    79dd:9235    lodsw
    79dd:9236    and       ax,DFDF
    79dd:9239    cmp       ax,554D
    79dd:923c    jne       9241
    79dd:923e    jmp       M_FMU
    79dd:9241    cmp       ax,4F52
    79dd:9244    jne       9249
    79dd:9246    jmp       M_FRO
    79dd:9249    cmp       ax,504F
    79dd:924c    je        M_FOP
    79dd:924e    cmp       ax,4C43
    79dd:9251    je        M_FCL
    79dd:9253    jmp       PM
             M_FOP:
    79dd:9256    lodsw
    79dd:9257    and       ax,DFDF
    79dd:925a    cmp       ax,4E45
             DEFNAME:
    79dd:925c    dec       si
    79dd:925d    jne       9262
    79dd:925f    jmp       P_FOPEN
    79dd:9262    jmp       PM
             M_FCL:
    79dd:9265    lodsw
    79dd:9266    and       ax,DFDF
    79dd:9269    cmp       ax,534F
    79dd:926c    je        M_FCLOS
    79dd:926e    jmp       PM
             M_FCLOS:
    79dd:9271    lodsb
    79dd:9272    and       al,DF
    79dd:9274    cmp       al,45
    79dd:9276    je        927B
    79dd:9278    jmp       PM
    79dd:927b    mov       al,byte ptr [si]
    79dd:927d    xlat
    79dd:927f    or        al,al
    79dd:9281    jns       M_G
    79dd:9283    jmp       FCLOSELP
             M_G:
    79dd:9286    lodsw
    79dd:9287    and       ax,DFDF
    79dd:928a    cmp       ax,5445
    79dd:928d    jne       9292
    79dd:928f    jmp       M_GET
    79dd:9292    jmp       PM
             M_H:
    79dd:9295    lodsw
    79dd:9296    and       ax,DFDF
    79dd:9299    cmp       ax,4249
    79dd:929c    jne       92A1
    79dd:929e    jmp       M_HIB
    79dd:92a1    jmp       PM
             M_I:
    79dd:92a4    lodsw
    79dd:92a5    and       ax,DFDF
    79dd:92a8    cmp       ax,5442
    79dd:92ab    jne       92B0
    79dd:92ad    jmp       M_IBT
    79dd:92b0    cmp       ax,434E
    79dd:92b3    je        M_INC2
    79dd:92b5    cmp       ax,5457
    79dd:92b8    jne       92BD
    79dd:92ba    jmp       M_IWT
    79dd:92bd    cmp       ax,5352
    79dd:92c0    jne       92C5
    79dd:92c2    jmp       M_IRS
    79dd:92c5    cmp       ax,5052
    79dd:92c8    jne       92CD
    79dd:92ca    jmp       M_IRP
    79dd:92cd    cmp       al,46
    79dd:92cf    je        92D4
    79dd:92d1    jmp       PM
    79dd:92d4    dec       si
    79dd:92d5    jmp       P_IF
             M_INC2:
    79dd:92d8    lodsb
    79dd:92d9    and       al,DF
    79dd:92db    cmp       al,4C
    79dd:92dd    jne       92E2
    79dd:92df    jmp       P_INCL
    79dd:92e2    cmp       al,42
    79dd:92e4    jne       92E9
    79dd:92e6    jmp       P_INCB
    79dd:92e9    cmp       al,43
    79dd:92eb    jne       92F0
    79dd:92ed    jmp       P_INCC
    79dd:92f0    cmp       al,44
    79dd:92f2    jne       92F7
    79dd:92f4    jmp       P_INCD
    79dd:92f7    dec       si
    79dd:92f8    jmp       M_INC
             M_J:
    79dd:92fb    lodsw
    79dd:92fc    and       ax,DFDF
    79dd:92ff    cmp       ax,504D
    79dd:9302    jne       9307
    79dd:9304    jmp       M_JMP
    79dd:9307    jmp       PM
             M_L:
    79dd:930a    lodsw
    79dd:930b    and       ax,DFDF
    79dd:930e    cmp       ax,5253
    79dd:9311    jne       9316
    79dd:9313    jmp       M_LSR
    79dd:9316    cmp       ax,4E49
    79dd:9319    jne       931E
    79dd:931b    jmp       M_LINK
    79dd:931e    cmp       ax,424F
    79dd:9321    jne       9326
    79dd:9323    jmp       M_LOB
    79dd:9326    cmp       ax,554D
    79dd:9329    jne       932E
    79dd:932b    jmp       M_LMU
    79dd:932e    cmp       ax,4244
    79dd:9331    jne       9336
    79dd:9333    jmp       M_LDB
    79dd:9336    cmp       ax,5744
    79dd:9339    jne       933E
    79dd:933b    jmp       M_LDW
    79dd:933e    cmp       ax,4D4A
    79dd:9341    jne       9346
    79dd:9343    jmp       M_LJM
    79dd:9346    cmp       ax,534D
    79dd:9349    jne       934E
    79dd:934b    jmp       M_LMS
    79dd:934e    cmp       ax,4F4F
    79dd:9351    jne       9356
    79dd:9353    jmp       M_LOO
    79dd:9356    cmp       ax,4145
    79dd:9359    jne       935E
    79dd:935b    jmp       M_LEA
    79dd:935e    cmp       ax,434F
    79dd:9361    je        M_LOC
    79dd:9363    cmp       ax,5349
    79dd:9366    jne       936B
    79dd:9368    jmp       M_LIS
    79dd:936b    cmp       al,4D
    79dd:936d    jne       9372
    79dd:936f    jmp       M_LM
    79dd:9372    jmp       PM
             M_LOC:
    79dd:9375    lodsb
    79dd:9376    and       al,DF
    79dd:9378    cmp       al,41
    79dd:937a    je        937F
    79dd:937c    jmp       PM
    79dd:937f    lodsb
    79dd:9380    and       al,DF
    79dd:9382    cmp       al,4C
    79dd:9384    je        9389
    79dd:9386    jmp       PM
    79dd:9389    mov       al,byte ptr [si]
    79dd:938b    xlat
    79dd:938d    or        al,al
    79dd:938f    jns       M_M
    79dd:9391    jmp       P_LOCAL
             M_M:
    79dd:9394    lodsw
    79dd:9395    and       ax,DFDF
    79dd:9398    cmp       ax,564F
    79dd:939b    jne       93A0
    79dd:939d    jmp       M_MOV
    79dd:93a0    cmp       ax,5245
    79dd:93a3    jne       93A8
    79dd:93a5    jmp       M_MER
    79dd:93a8    cmp       ax,4C55
    79dd:93ab    jne       93B0
    79dd:93ad    jmp       M_MUL
    79dd:93b0    cmp       ax,5241
    79dd:93b3    jne       93B8
    79dd:93b5    jmp       M_MAR
    79dd:93b8    cmp       ax,4341
    79dd:93bb    jne       93C0
    79dd:93bd    jmp       M_MAC
    79dd:93c0    jmp       PM
             M_N:
    79dd:93c3    lodsw
    79dd:93c4    and       ax,DFDF
    79dd:93c7    cmp       ax,504F
    79dd:93ca    jne       93CF
    79dd:93cc    jmp       M_NOP
    79dd:93cf    cmp       ax,544F
    79dd:93d2    jne       93D7
    79dd:93d4    jmp       M_NOT
    79dd:93d7    jmp       PM
             M_O:
    79dd:93da    lodsb
    79dd:93db    and       al,DF
    79dd:93dd    cmp       al,52
    79dd:93df    jne       93E4
    79dd:93e1    jmp       M_OR
    79dd:93e4    jmp       PM
             M_P:
    79dd:93e7    lodsw
    79dd:93e8    and       ax,DFDF
    79dd:93eb    cmp       ax,4F4C
    79dd:93ee    jne       93F3
    79dd:93f0    jmp       M_PLO
    79dd:93f3    cmp       ax,4952
    79dd:93f6    je        M_PRI
    79dd:93f8    jmp       PM
             M_PRI:
    79dd:93fb    lodsw
    79dd:93fc    and       ax,DFDF
    79dd:93ff    cmp       ax,544E
    79dd:9402    je        M_PRINT
    79dd:9404    jmp       PM
             M_PRINT:
    79dd:9407    lodsb
    79dd:9408    and       al,DF
    79dd:940a    cmp       al,46
    79dd:940c    jne       9411
    79dd:940e    jmp       P_PRINTF
    79dd:9411    jmp       PM
             M_R:
    79dd:9414    lodsw
    79dd:9415    and       ax,DFDF
    79dd:9418    cmp       ax,4C4F
    79dd:941b    jne       9420
    79dd:941d    jmp       M_ROL
    79dd:9420    cmp       ax,4950
    79dd:9423    jne       9428
    79dd:9425    jmp       M_RPI
    79dd:9428    cmp       ax,524F
    79dd:942b    jne       9430
    79dd:942d    jmp       M_ROR
    79dd:9430    cmp       ax,4D41
    79dd:9433    jne       9438
    79dd:9435    jmp       M_RAM
    79dd:9438    cmp       ax,4D4F
    79dd:943b    jne       9440
    79dd:943d    jmp       M_ROM
    79dd:9440    cmp       ax,5045
    79dd:9443    jne       9448
    79dd:9445    jmp       M_REP
    79dd:9448    cmp       ax,4E55
    79dd:944b    jne       9450
    79dd:944d    jmp       M_RUN
    79dd:9450    jmp       PM
             M_S:
    79dd:9453    lodsw
    79dd:9454    and       ax,DFDF
    79dd:9457    cmp       ax,4F54
    79dd:945a    jne       945F
    79dd:945c    jmp       M_STO
    79dd:945f    cmp       ax,4157
    79dd:9462    jne       9467
    79dd:9464    jmp       M_SWA
    79dd:9467    cmp       ax,4B42
    79dd:946a    jne       946F
    79dd:946c    jmp       M_SBK
    79dd:946f    cmp       ax,5845
    79dd:9472    jne       9477
    79dd:9474    jmp       M_SEX
    79dd:9477    cmp       ax,5754
    79dd:947a    jne       947F
    79dd:947c    jmp       M_STW
    79dd:947f    cmp       ax,4254
    79dd:9482    jne       9487
    79dd:9484    jmp       M_STB
    79dd:9487    cmp       ax,4255
    79dd:948a    jne       948F
    79dd:948c    jmp       M_SUB
    79dd:948f    cmp       ax,4342
    79dd:9492    jne       9497
    79dd:9494    jmp       M_SBC
    79dd:9497    cmp       ax,534D
    79dd:949a    jne       949F
    79dd:949c    jmp       M_SMS
    79dd:949f    cmp       ax,4349
    79dd:94a2    jne       94A7
    79dd:94a4    jmp       P_SIC
    79dd:94a7    cmp       al,4D
    79dd:94a9    jne       94AE
    79dd:94ab    jmp       M_SM
    79dd:94ae    jmp       PM
             M_T:
    79dd:94b1    lodsb
    79dd:94b2    and       al,DF
    79dd:94b4    cmp       al,4F
    79dd:94b6    jne       94BB
    79dd:94b8    jmp       M_TO
    79dd:94bb    cmp       al,49
    79dd:94bd    jne       94C2
    79dd:94bf    jmp       P_TI
    79dd:94c2    jmp       PM
             M_U:
    79dd:94c5    lodsw
    79dd:94c6    and       ax,DFDF
    79dd:94c9    cmp       ax,554D
    79dd:94cc    jne       94D1
    79dd:94ce    jmp       M_UMU
    79dd:94d1    jmp       PM
             M_W:
    79dd:94d4    lodsw
    79dd:94d5    and       ax,DFDF
    79dd:94d8    cmp       ax,5449
    79dd:94db    jne       94E0
    79dd:94dd    jmp       M_WIT
    79dd:94e0    jmp       PM
             M_X:
    79dd:94e3    lodsw
    79dd:94e4    and       ax,DFDF
    79dd:94e7    cmp       ax,524F
    79dd:94ea    jne       94EF
    79dd:94ec    jmp       M_XOR
    79dd:94ef    jmp       PM
             M_ADC:
    79dd:94f2    mov       al,byte ptr [si]
    79dd:94f4    xlat
    79dd:94f6    or        al,al
    79dd:94f8    js        94FD
    79dd:94fa    jmp       PM
    79dd:94fd    lodsb
    79dd:94fe    xlat
    79dd:9500    or        al,al
    79dd:9502    js        94FD
    79dd:9504    dec       si
    79dd:9505    mov       bp,si
    79dd:9507    xor       cl,cl
    79dd:9509    lodsb
    79dd:950a    cmp       al,2C
    79dd:950c    jne       9512
    79dd:950e    inc       cl
    79dd:9510    jmp       9509
    79dd:9512    xlat
    79dd:9514    or        al,al
    79dd:9516    jns       9509
    79dd:9518    mov       si,bp
    79dd:951a    cmp       cl,02
    79dd:951d    jne       M_ADCCONT
    79dd:951f    jmp       M_ADC3
             M_ADCCONT:
    79dd:9522    lodsb
    79dd:9523    xlat
    79dd:9525    or        al,al
    79dd:9527    js        M_ADCCONT
    79dd:9529    dec       si
    79dd:952a    mov       al,byte ptr [si]
    79dd:952c    cmp       al,23
    79dd:952e    je        9594
    79dd:9530    lodsb
    79dd:9531    and       al,DF
    79dd:9533    cmp       al,52
    79dd:9535    jne       954A
    79dd:9537    lodsb
    79dd:9538    sub       al,30
    79dd:953a    js        9549
    79dd:953c    cmp       al,09
    79dd:953e    jg        9549
    79dd:9540    cmp       al,01
    79dd:9542    je        9567
    79dd:9544    mov       cl,al
    79dd:9546    jmp       9580
    79dd:9548    dec       si
    79dd:9549    dec       si
    79dd:954a    dec       si
    79dd:954b    push      dx
    79dd:954c    call      CONVEXPRESS
    79dd:954f    pop       dx
    79dd:9550    test      byte ptr ss:[0ACE],04
    79dd:9556    jne       9580
    79dd:9558    jmp       GREGERR
    79dd:955b    cmp       ah,05
    79dd:955e    jg        9548
    79dd:9560    add       ah,0A
    79dd:9563    mov       cl,ah
    79dd:9565    jmp       9580
    79dd:9567    lodsb
    79dd:9568    cmp       al,5D
    79dd:956a    je        957D
    79dd:956c    cmp       al,2C
    79dd:956e    je        957D
    79dd:9570    mov       ah,al
    79dd:9572    sub       ah,30
    79dd:9575    jns       955B
    79dd:9577    xlat
    79dd:9579    or        al,al
    79dd:957b    jns       9548
    79dd:957d    mov       cl,01
    79dd:957f    dec       si
    79dd:9580    add       cl,50
    79dd:9583    mov       al,byte ptr [si]
    79dd:9585    xlat
    79dd:9587    or        al,al
    79dd:9589    js        958E
    79dd:958b    jmp       PM
    79dd:958e    mov       al,3D
    79dd:9590    mov       ah,cl
    79dd:9592    stosw
    79dd:9593    ret
    79dd:9594    inc       si
    79dd:9595    call      CONVEXPRESS
    79dd:9598    cmp       dx,00
    79dd:959b    je        95A0
    79dd:959d    jmp       REGNERR
    79dd:95a0    cmp       cx,0F
    79dd:95a3    jle       95A8
    79dd:95a5    jmp       REGNERR
    79dd:95a8    add       cl,50
    79dd:95ab    test      byte ptr ss:[0ACE],C0
    79dd:95b1    je        9629
    79dd:95b3    test      byte ptr ss:[0ACE],40
    79dd:95b9    jne       95E6
    79dd:95bb    push      es
    79dd:95bc    push      bp
    79dd:95bd    mov       es,word ptr ss:[0AC5]
    79dd:95c2    mov       bp,word ptr ss:[0AC9]
    79dd:95c7    mov       word ptr es:[bp+06],di
    79dd:95cb    mov       word ptr es:[bp+02],000C
    79dd:95d1    add       bp,15
    79dd:95d4    mov       word ptr ss:[0AC7],bp
    79dd:95d9    cmp       bp,7F00
    79dd:95dd    jb        95E2
    79dd:95df    call      MOREFR
    79dd:95e2    pop       bp
    79dd:95e3    pop       es
    79dd:95e4    jmp       9629
    79dd:95e6    push      es
    79dd:95e7    push      bp
    79dd:95e8    push      cx
    79dd:95e9    push      ax
    79dd:95ea    mov       es,word ptr ss:[13A6]
    79dd:95ef    mov       bp,word ptr ss:[13A8]
    79dd:95f4    mov       ax,di
    79dd:95f6    sub       ax,word ptr ss:[13B4]
    79dd:95fb    xor       cx,cx
    79dd:95fd    add       ax,word ptr ss:[13BE]
    79dd:9602    adc       cx,word ptr ss:[13BC]
    79dd:9607    mov       word ptr es:[bp+00],ax
    79dd:960b    mov       word ptr es:[bp+02],cx
    79dd:960f    mov       byte ptr es:[bp+04],0C
    79dd:9614    add       bp,05
    79dd:9617    mov       word ptr ss:[13A8],bp
    79dd:961c    cmp       bp,3F00
    79dd:9620    jb        9625
    79dd:9622    call      MOREEXT
    79dd:9625    pop       ax
    79dd:9626    pop       cx
    79dd:9627    pop       bp
    79dd:9628    pop       es
    79dd:9629    mov       al,byte ptr [si]
    79dd:962b    xlat
    79dd:962d    or        al,al
    79dd:962f    js        9634
    79dd:9631    jmp       PM
    79dd:9634    mov       al,3F
    79dd:9636    mov       ah,cl
    79dd:9638    stosw
    79dd:9639    ret
             M_ADC3:
    79dd:963a    lodsb
    79dd:963b    and       al,DF
    79dd:963d    cmp       al,52
    79dd:963f    jne       9654
    79dd:9641    lodsb
    79dd:9642    sub       al,30
    79dd:9644    js        9653
    79dd:9646    cmp       al,09
    79dd:9648    jg        9653
    79dd:964a    cmp       al,01
    79dd:964c    je        9671
    79dd:964e    mov       cl,al
    79dd:9650    jmp       9686
    79dd:9652    dec       si
    79dd:9653    dec       si
    79dd:9654    dec       si
    79dd:9655    push      dx
    79dd:9656    call      CONVEXPRESS
    79dd:9659    pop       dx
    79dd:965a    test      byte ptr ss:[0ACE],04
    79dd:9660    jne       9686
    79dd:9662    jmp       GREGERR
    79dd:9665    cmp       ah,05
    79dd:9668    jg        9652
    79dd:966a    add       ah,0A
    79dd:966d    mov       cl,ah
    79dd:966f    jmp       9686
    79dd:9671    lodsb
    79dd:9672    cmp       al,2C
    79dd:9674    je        9683
    79dd:9676    mov       ah,al
    79dd:9678    sub       ah,30
    79dd:967b    jns       9665
    79dd:967d    xlat
    79dd:967f    or        al,al
    79dd:9681    jns       9652
    79dd:9683    mov       cl,01
    79dd:9685    dec       si
    79dd:9686    mov       byte ptr ss:[248D],cl
    79dd:968b    lodsb
    79dd:968c    cmp       al,2C
    79dd:968e    je        9693
    79dd:9690    jmp       EAERR
    79dd:9693    lodsb
    79dd:9694    and       al,DF
    79dd:9696    cmp       al,52
    79dd:9698    jne       96AD
    79dd:969a    lodsb
    79dd:969b    sub       al,30
    79dd:969d    js        96AC
    79dd:969f    cmp       al,09
    79dd:96a1    jg        96AC
    79dd:96a3    cmp       al,01
    79dd:96a5    je        96CA
    79dd:96a7    mov       cl,al
    79dd:96a9    jmp       96DF
    79dd:96ab    dec       si
    79dd:96ac    dec       si
    79dd:96ad    dec       si
    79dd:96ae    push      dx
    79dd:96af    call      CONVEXPRESS
    79dd:96b2    pop       dx
    79dd:96b3    test      byte ptr ss:[0ACE],04
    79dd:96b9    jne       96DF
    79dd:96bb    jmp       GREGERR
    79dd:96be    cmp       ah,05
    79dd:96c1    jg        96AB
    79dd:96c3    add       ah,0A
    79dd:96c6    mov       cl,ah
    79dd:96c8    jmp       96DF
    79dd:96ca    lodsb
    79dd:96cb    cmp       al,2C
    79dd:96cd    je        96DC
    79dd:96cf    mov       ah,al
    79dd:96d1    sub       ah,30
    79dd:96d4    jns       96BE
    79dd:96d6    xlat
    79dd:96d8    or        al,al
    79dd:96da    jns       96AB
    79dd:96dc    mov       cl,01
    79dd:96de    dec       si
    79dd:96df    mov       byte ptr ss:[248C],cl
    79dd:96e4    lodsb
    79dd:96e5    cmp       al,2C
    79dd:96e7    je        96EC
    79dd:96e9    jmp       EAERR
    79dd:96ec    call      CODEDREGSREG_ROU
    79dd:96ef    call      M_ADCCONT
    79dd:96f2    mov       ds,word ptr ss:[2494]
    79dd:96f7    mov       si,word ptr ss:[2496]
    79dd:96fc    ret
             M_ADD:
    79dd:96fd    mov       al,byte ptr [si]
    79dd:96ff    xlat
    79dd:9701    or        al,al
    79dd:9703    js        9708
    79dd:9705    jmp       PM
    79dd:9708    lodsb
    79dd:9709    xlat
    79dd:970b    or        al,al
    79dd:970d    js        9708
    79dd:970f    dec       si
    79dd:9710    mov       bp,si
    79dd:9712    xor       cl,cl
    79dd:9714    lodsb
    79dd:9715    cmp       al,2C
    79dd:9717    jne       971D
    79dd:9719    inc       cl
    79dd:971b    jmp       9714
    79dd:971d    xlat
    79dd:971f    or        al,al
    79dd:9721    jns       9714
    79dd:9723    mov       si,bp
    79dd:9725    cmp       cl,02
    79dd:9728    jne       M_ADDCONT
    79dd:972a    jmp       M_ADD3
             M_ADDCONT:
    79dd:972d    lodsb
    79dd:972e    xlat
    79dd:9730    or        al,al
    79dd:9732    js        M_ADDCONT
    79dd:9734    dec       si
    79dd:9735    mov       al,byte ptr [si]
    79dd:9737    cmp       al,23
    79dd:9739    je        979D
    79dd:973b    lodsb
    79dd:973c    and       al,DF
    79dd:973e    cmp       al,52
    79dd:9740    jne       9755
    79dd:9742    lodsb
    79dd:9743    sub       al,30
    79dd:9745    js        9754
    79dd:9747    cmp       al,09
    79dd:9749    jg        9754
    79dd:974b    cmp       al,01
    79dd:974d    je        9772
    79dd:974f    mov       cl,al
    79dd:9751    jmp       978B
    79dd:9753    dec       si
    79dd:9754    dec       si
    79dd:9755    dec       si
    79dd:9756    push      dx
    79dd:9757    call      CONVEXPRESS
    79dd:975a    pop       dx
    79dd:975b    test      byte ptr ss:[0ACE],04
    79dd:9761    jne       978B
    79dd:9763    jmp       GREGERR
    79dd:9766    cmp       ah,05
    79dd:9769    jg        9753
    79dd:976b    add       ah,0A
    79dd:976e    mov       cl,ah
    79dd:9770    jmp       978B
    79dd:9772    lodsb
    79dd:9773    cmp       al,5D
    79dd:9775    je        9788
    79dd:9777    cmp       al,2C
    79dd:9779    je        9788
    79dd:977b    mov       ah,al
    79dd:977d    sub       ah,30
    79dd:9780    jns       9766
    79dd:9782    xlat
    79dd:9784    or        al,al
    79dd:9786    jns       9753
    79dd:9788    mov       cl,01
    79dd:978a    dec       si
    79dd:978b    add       cl,50
    79dd:978e    mov       al,byte ptr [si]
    79dd:9790    xlat
    79dd:9792    or        al,al
    79dd:9794    js        9799
    79dd:9796    jmp       PM
    79dd:9799    mov       al,cl
    79dd:979b    stosb
    79dd:979c    ret
    79dd:979d    inc       si
    79dd:979e    call      CONVEXPRESS
    79dd:97a1    cmp       dx,00
    79dd:97a4    je        97A9
    79dd:97a6    jmp       REGNERR
    79dd:97a9    cmp       cx,0F
    79dd:97ac    jle       97B1
    79dd:97ae    jmp       REGNERR
    79dd:97b1    add       cl,50
    79dd:97b4    test      byte ptr ss:[0ACE],C0
    79dd:97ba    je        9832
    79dd:97bc    test      byte ptr ss:[0ACE],40
    79dd:97c2    jne       97EF
    79dd:97c4    push      es
    79dd:97c5    push      bp
    79dd:97c6    mov       es,word ptr ss:[0AC5]
    79dd:97cb    mov       bp,word ptr ss:[0AC9]
    79dd:97d0    mov       word ptr es:[bp+06],di
    79dd:97d4    mov       word ptr es:[bp+02],000C
    79dd:97da    add       bp,15
    79dd:97dd    mov       word ptr ss:[0AC7],bp
    79dd:97e2    cmp       bp,7F00
    79dd:97e6    jb        97EB
    79dd:97e8    call      MOREFR
    79dd:97eb    pop       bp
    79dd:97ec    pop       es
    79dd:97ed    jmp       9832
    79dd:97ef    push      es
    79dd:97f0    push      bp
    79dd:97f1    push      cx
    79dd:97f2    push      ax
    79dd:97f3    mov       es,word ptr ss:[13A6]
    79dd:97f8    mov       bp,word ptr ss:[13A8]
    79dd:97fd    mov       ax,di
    79dd:97ff    sub       ax,word ptr ss:[13B4]
    79dd:9804    xor       cx,cx
    79dd:9806    add       ax,word ptr ss:[13BE]
    79dd:980b    adc       cx,word ptr ss:[13BC]
    79dd:9810    mov       word ptr es:[bp+00],ax
    79dd:9814    mov       word ptr es:[bp+02],cx
    79dd:9818    mov       byte ptr es:[bp+04],0C
    79dd:981d    add       bp,05
    79dd:9820    mov       word ptr ss:[13A8],bp
    79dd:9825    cmp       bp,3F00
    79dd:9829    jb        982E
    79dd:982b    call      MOREEXT
    79dd:982e    pop       ax
    79dd:982f    pop       cx
    79dd:9830    pop       bp
    79dd:9831    pop       es
    79dd:9832    mov       al,byte ptr [si]
    79dd:9834    xlat
    79dd:9836    or        al,al
    79dd:9838    js        983D
    79dd:983a    jmp       PM
    79dd:983d    mov       al,3E
    79dd:983f    mov       ah,cl
    79dd:9841    stosw
    79dd:9842    ret
             M_ADD3:
    79dd:9843    lodsb
    79dd:9844    and       al,DF
    79dd:9846    cmp       al,52
    79dd:9848    jne       985D
    79dd:984a    lodsb
    79dd:984b    sub       al,30
    79dd:984d    js        985C
    79dd:984f    cmp       al,09
    79dd:9851    jg        985C
    79dd:9853    cmp       al,01
    79dd:9855    je        987A
    79dd:9857    mov       cl,al
    79dd:9859    jmp       988F
    79dd:985b    dec       si
    79dd:985c    dec       si
    79dd:985d    dec       si
    79dd:985e    push      dx
    79dd:985f    call      CONVEXPRESS
    79dd:9862    pop       dx
    79dd:9863    test      byte ptr ss:[0ACE],04
    79dd:9869    jne       988F
    79dd:986b    jmp       GREGERR
    79dd:986e    cmp       ah,05
    79dd:9871    jg        985B
    79dd:9873    add       ah,0A
    79dd:9876    mov       cl,ah
    79dd:9878    jmp       988F
    79dd:987a    lodsb
    79dd:987b    cmp       al,2C
    79dd:987d    je        988C
    79dd:987f    mov       ah,al
    79dd:9881    sub       ah,30
    79dd:9884    jns       986E
    79dd:9886    xlat
    79dd:9888    or        al,al
    79dd:988a    jns       985B
    79dd:988c    mov       cl,01
    79dd:988e    dec       si
    79dd:988f    mov       byte ptr ss:[248D],cl
    79dd:9894    lodsb
    79dd:9895    cmp       al,2C
    79dd:9897    je        989C
    79dd:9899    jmp       EAERR
    79dd:989c    lodsb
    79dd:989d    and       al,DF
    79dd:989f    cmp       al,52
    79dd:98a1    jne       98B6
    79dd:98a3    lodsb
    79dd:98a4    sub       al,30
    79dd:98a6    js        98B5
    79dd:98a8    cmp       al,09
    79dd:98aa    jg        98B5
    79dd:98ac    cmp       al,01
    79dd:98ae    je        98D3
    79dd:98b0    mov       cl,al
    79dd:98b2    jmp       98E8
    79dd:98b4    dec       si
    79dd:98b5    dec       si
    79dd:98b6    dec       si
    79dd:98b7    push      dx
    79dd:98b8    call      CONVEXPRESS
    79dd:98bb    pop       dx
    79dd:98bc    test      byte ptr ss:[0ACE],04
    79dd:98c2    jne       98E8
    79dd:98c4    jmp       GREGERR
    79dd:98c7    cmp       ah,05
    79dd:98ca    jg        98B4
    79dd:98cc    add       ah,0A
    79dd:98cf    mov       cl,ah
    79dd:98d1    jmp       98E8
    79dd:98d3    lodsb
    79dd:98d4    cmp       al,2C
    79dd:98d6    je        98E5
    79dd:98d8    mov       ah,al
    79dd:98da    sub       ah,30
    79dd:98dd    jns       98C7
    79dd:98df    xlat
    79dd:98e1    or        al,al
    79dd:98e3    jns       98B4
    79dd:98e5    mov       cl,01
    79dd:98e7    dec       si
    79dd:98e8    mov       byte ptr ss:[248C],cl
    79dd:98ed    lodsb
    79dd:98ee    cmp       al,2C
    79dd:98f0    je        98F5
    79dd:98f2    jmp       EAERR
    79dd:98f5    call      CODEDREGSREG_ROU
    79dd:98f8    call      M_ADDCONT
    79dd:98fb    mov       ds,word ptr ss:[2494]
    79dd:9900    mov       si,word ptr ss:[2496]
    79dd:9905    ret
             M_AND:
    79dd:9906    mov       al,byte ptr [si]
    79dd:9908    xlat
    79dd:990a    or        al,al
    79dd:990c    js        9911
    79dd:990e    jmp       PM
    79dd:9911    lodsb
    79dd:9912    xlat
    79dd:9914    or        al,al
    79dd:9916    js        9911
    79dd:9918    dec       si
    79dd:9919    mov       bp,si
    79dd:991b    xor       cl,cl
    79dd:991d    lodsb
    79dd:991e    cmp       al,2C
    79dd:9920    jne       9926
    79dd:9922    inc       cl
    79dd:9924    jmp       991D
    79dd:9926    xlat
    79dd:9928    or        al,al
    79dd:992a    jns       991D
    79dd:992c    mov       si,bp
    79dd:992e    cmp       cl,02
    79dd:9931    jne       M_ANDCONT
    79dd:9933    jmp       M_AND3
             M_ANDCONT:
    79dd:9936    lodsb
    79dd:9937    xlat
    79dd:9939    or        al,al
    79dd:993b    js        M_ANDCONT
    79dd:993d    dec       si
    79dd:993e    mov       al,byte ptr [si]
    79dd:9940    cmp       al,23
    79dd:9942    je        99AE
    79dd:9944    lodsb
    79dd:9945    and       al,DF
    79dd:9947    cmp       al,52
    79dd:9949    jne       995E
    79dd:994b    lodsb
    79dd:994c    sub       al,30
    79dd:994e    js        995D
    79dd:9950    cmp       al,09
    79dd:9952    jg        995D
    79dd:9954    cmp       al,01
    79dd:9956    je        997B
    79dd:9958    mov       cl,al
    79dd:995a    jmp       9994
    79dd:995c    dec       si
    79dd:995d    dec       si
    79dd:995e    dec       si
    79dd:995f    push      dx
    79dd:9960    call      CONVEXPRESS
    79dd:9963    pop       dx
    79dd:9964    test      byte ptr ss:[0ACE],04
    79dd:996a    jne       9994
    79dd:996c    jmp       GREGERR
    79dd:996f    cmp       ah,05
    79dd:9972    jg        995C
    79dd:9974    add       ah,0A
    79dd:9977    mov       cl,ah
    79dd:9979    jmp       9994
    79dd:997b    lodsb
    79dd:997c    cmp       al,5D
    79dd:997e    je        9991
    79dd:9980    cmp       al,2C
    79dd:9982    je        9991
    79dd:9984    mov       ah,al
    79dd:9986    sub       ah,30
    79dd:9989    jns       996F
    79dd:998b    xlat
    79dd:998d    or        al,al
    79dd:998f    jns       995C
    79dd:9991    mov       cl,01
    79dd:9993    dec       si
    79dd:9994    cmp       cl,00
    79dd:9997    jne       999C
    79dd:9999    jmp       GREGERR
    79dd:999c    add       cl,70
    79dd:999f    mov       al,byte ptr [si]
    79dd:99a1    xlat
    79dd:99a3    or        al,al
    79dd:99a5    js        99AA
    79dd:99a7    jmp       PM
    79dd:99aa    mov       al,cl
    79dd:99ac    stosb
    79dd:99ad    ret
    79dd:99ae    inc       si
    79dd:99af    call      CONVEXPRESS
    79dd:99b2    cmp       dx,00
    79dd:99b5    je        99BA
    79dd:99b7    jmp       REGNERR
    79dd:99ba    cmp       cx,0F
    79dd:99bd    jle       99C2
    79dd:99bf    jmp       REGNERR
    79dd:99c2    cmp       cl,00
    79dd:99c5    jne       99CA
    79dd:99c7    jmp       REGNERR
    79dd:99ca    add       cl,70
    79dd:99cd    test      byte ptr ss:[0ACE],C0
    79dd:99d3    je        9A4B
    79dd:99d5    test      byte ptr ss:[0ACE],40
    79dd:99db    jne       9A08
    79dd:99dd    push      es
    79dd:99de    push      bp
    79dd:99df    mov       es,word ptr ss:[0AC5]
    79dd:99e4    mov       bp,word ptr ss:[0AC9]
    79dd:99e9    mov       word ptr es:[bp+06],di
    79dd:99ed    mov       word ptr es:[bp+02],000C
    79dd:99f3    add       bp,15
    79dd:99f6    mov       word ptr ss:[0AC7],bp
    79dd:99fb    cmp       bp,7F00
    79dd:99ff    jb        9A04
    79dd:9a01    call      MOREFR
    79dd:9a04    pop       bp
    79dd:9a05    pop       es
    79dd:9a06    jmp       9A4B
    79dd:9a08    push      es
    79dd:9a09    push      bp
    79dd:9a0a    push      cx
    79dd:9a0b    push      ax
    79dd:9a0c    mov       es,word ptr ss:[13A6]
    79dd:9a11    mov       bp,word ptr ss:[13A8]
    79dd:9a16    mov       ax,di
    79dd:9a18    sub       ax,word ptr ss:[13B4]
    79dd:9a1d    xor       cx,cx
    79dd:9a1f    add       ax,word ptr ss:[13BE]
    79dd:9a24    adc       cx,word ptr ss:[13BC]
    79dd:9a29    mov       word ptr es:[bp+00],ax
    79dd:9a2d    mov       word ptr es:[bp+02],cx
    79dd:9a31    mov       byte ptr es:[bp+04],0C
    79dd:9a36    add       bp,05
    79dd:9a39    mov       word ptr ss:[13A8],bp
    79dd:9a3e    cmp       bp,3F00
    79dd:9a42    jb        9A47
    79dd:9a44    call      MOREEXT
    79dd:9a47    pop       ax
    79dd:9a48    pop       cx
    79dd:9a49    pop       bp
    79dd:9a4a    pop       es
    79dd:9a4b    mov       al,byte ptr [si]
    79dd:9a4d    xlat
    79dd:9a4f    or        al,al
    79dd:9a51    js        9A56
    79dd:9a53    jmp       PM
    79dd:9a56    mov       al,3E
    79dd:9a58    mov       ah,cl
    79dd:9a5a    stosw
    79dd:9a5b    ret
             M_AND3:
    79dd:9a5c    lodsb
    79dd:9a5d    and       al,DF
    79dd:9a5f    cmp       al,52
    79dd:9a61    jne       9A76
    79dd:9a63    lodsb
    79dd:9a64    sub       al,30
    79dd:9a66    js        9A75
    79dd:9a68    cmp       al,09
    79dd:9a6a    jg        9A75
    79dd:9a6c    cmp       al,01
    79dd:9a6e    je        9A93
    79dd:9a70    mov       cl,al
    79dd:9a72    jmp       9AA8
    79dd:9a74    dec       si
    79dd:9a75    dec       si
    79dd:9a76    dec       si
    79dd:9a77    push      dx
    79dd:9a78    call      CONVEXPRESS
    79dd:9a7b    pop       dx
    79dd:9a7c    test      byte ptr ss:[0ACE],04
    79dd:9a82    jne       9AA8
    79dd:9a84    jmp       GREGERR
    79dd:9a87    cmp       ah,05
    79dd:9a8a    jg        9A74
    79dd:9a8c    add       ah,0A
    79dd:9a8f    mov       cl,ah
    79dd:9a91    jmp       9AA8
    79dd:9a93    lodsb
    79dd:9a94    cmp       al,2C
    79dd:9a96    je        9AA5
    79dd:9a98    mov       ah,al
    79dd:9a9a    sub       ah,30
    79dd:9a9d    jns       9A87
    79dd:9a9f    xlat
    79dd:9aa1    or        al,al
    79dd:9aa3    jns       9A74
    79dd:9aa5    mov       cl,01
    79dd:9aa7    dec       si
    79dd:9aa8    mov       byte ptr ss:[248D],cl
    79dd:9aad    lodsb
    79dd:9aae    cmp       al,2C
    79dd:9ab0    je        9AB5
    79dd:9ab2    jmp       EAERR
    79dd:9ab5    lodsb
    79dd:9ab6    and       al,DF
    79dd:9ab8    cmp       al,52
    79dd:9aba    jne       9ACF
    79dd:9abc    lodsb
    79dd:9abd    sub       al,30
    79dd:9abf    js        9ACE
    79dd:9ac1    cmp       al,09
    79dd:9ac3    jg        9ACE
    79dd:9ac5    cmp       al,01
    79dd:9ac7    je        9AEC
    79dd:9ac9    mov       cl,al
    79dd:9acb    jmp       9B01
    79dd:9acd    dec       si
    79dd:9ace    dec       si
    79dd:9acf    dec       si
    79dd:9ad0    push      dx
    79dd:9ad1    call      CONVEXPRESS
    79dd:9ad4    pop       dx
    79dd:9ad5    test      byte ptr ss:[0ACE],04
    79dd:9adb    jne       9B01
    79dd:9add    jmp       GREGERR
    79dd:9ae0    cmp       ah,05
    79dd:9ae3    jg        9ACD
    79dd:9ae5    add       ah,0A
    79dd:9ae8    mov       cl,ah
    79dd:9aea    jmp       9B01
    79dd:9aec    lodsb
    79dd:9aed    cmp       al,2C
    79dd:9aef    je        9AFE
    79dd:9af1    mov       ah,al
    79dd:9af3    sub       ah,30
    79dd:9af6    jns       9AE0
    79dd:9af8    xlat
    79dd:9afa    or        al,al
    79dd:9afc    jns       9ACD
    79dd:9afe    mov       cl,01
    79dd:9b00    dec       si
    79dd:9b01    mov       byte ptr ss:[248C],cl
    79dd:9b06    lodsb
    79dd:9b07    cmp       al,2C
    79dd:9b09    je        9B0E
    79dd:9b0b    jmp       EAERR
    79dd:9b0e    call      CODEDREGSREG_ROU
    79dd:9b11    call      M_ANDCONT
    79dd:9b14    mov       ds,word ptr ss:[2494]
    79dd:9b19    mov       si,word ptr ss:[2496]
    79dd:9b1e    ret
             M_ASR:
    79dd:9b1f    mov       al,byte ptr [si]
    79dd:9b21    xlat
    79dd:9b23    or        al,al
    79dd:9b25    js        9B2A
    79dd:9b27    jmp       PM
    79dd:9b2a    mov       al,byte ptr [si]
    79dd:9b2c    xlat
    79dd:9b2e    or        al,al
    79dd:9b30    js        9B35
    79dd:9b32    jmp       PM
    79dd:9b35    mov       al,96
    79dd:9b37    stosb
    79dd:9b38    ret
             M_BIC:
    79dd:9b39    mov       al,byte ptr [si]
    79dd:9b3b    xlat
    79dd:9b3d    or        al,al
    79dd:9b3f    js        9B44
    79dd:9b41    jmp       PM
    79dd:9b44    lodsb
    79dd:9b45    xlat
    79dd:9b47    or        al,al
    79dd:9b49    js        9B44
    79dd:9b4b    dec       si
    79dd:9b4c    mov       al,byte ptr [si]
    79dd:9b4e    cmp       al,23
    79dd:9b50    je        9BBE
    79dd:9b52    lodsb
    79dd:9b53    and       al,DF
    79dd:9b55    cmp       al,52
    79dd:9b57    jne       9B6C
    79dd:9b59    lodsb
    79dd:9b5a    sub       al,30
    79dd:9b5c    js        9B6B
    79dd:9b5e    cmp       al,09
    79dd:9b60    jg        9B6B
    79dd:9b62    cmp       al,01
    79dd:9b64    je        9B89
    79dd:9b66    mov       cl,al
    79dd:9b68    jmp       9BA2
    79dd:9b6a    dec       si
    79dd:9b6b    dec       si
    79dd:9b6c    dec       si
    79dd:9b6d    push      dx
    79dd:9b6e    call      CONVEXPRESS
    79dd:9b71    pop       dx
    79dd:9b72    test      byte ptr ss:[0ACE],04
    79dd:9b78    jne       9BA2
    79dd:9b7a    jmp       GREGERR
    79dd:9b7d    cmp       ah,05
    79dd:9b80    jg        9B6A
    79dd:9b82    add       ah,0A
    79dd:9b85    mov       cl,ah
    79dd:9b87    jmp       9BA2
    79dd:9b89    lodsb
    79dd:9b8a    cmp       al,5D
    79dd:9b8c    je        9B9F
    79dd:9b8e    cmp       al,2C
    79dd:9b90    je        9B9F
    79dd:9b92    mov       ah,al
    79dd:9b94    sub       ah,30
    79dd:9b97    jns       9B7D
    79dd:9b99    xlat
    79dd:9b9b    or        al,al
    79dd:9b9d    jns       9B6A
    79dd:9b9f    mov       cl,01
    79dd:9ba1    dec       si
    79dd:9ba2    cmp       cl,00
    79dd:9ba5    jne       9BAA
    79dd:9ba7    jmp       GREGERR
    79dd:9baa    add       cl,70
    79dd:9bad    mov       al,byte ptr [si]
    79dd:9baf    xlat
    79dd:9bb1    or        al,al
    79dd:9bb3    js        9BB8
    79dd:9bb5    jmp       PM
    79dd:9bb8    mov       al,3D
    79dd:9bba    mov       ah,cl
    79dd:9bbc    stosw
    79dd:9bbd    ret
    79dd:9bbe    inc       si
    79dd:9bbf    call      CONVEXPRESS
    79dd:9bc2    cmp       dx,00
    79dd:9bc5    je        9BCA
    79dd:9bc7    jmp       REGNERR
    79dd:9bca    cmp       cx,0F
    79dd:9bcd    jle       9BD2
    79dd:9bcf    jmp       REGNERR
    79dd:9bd2    cmp       cl,00
    79dd:9bd5    jne       9BDA
    79dd:9bd7    jmp       REGNERR
    79dd:9bda    add       cl,70
    79dd:9bdd    test      byte ptr ss:[0ACE],C0
    79dd:9be3    je        9C5B
    79dd:9be5    test      byte ptr ss:[0ACE],40
    79dd:9beb    jne       9C18
    79dd:9bed    push      es
    79dd:9bee    push      bp
    79dd:9bef    mov       es,word ptr ss:[0AC5]
    79dd:9bf4    mov       bp,word ptr ss:[0AC9]
    79dd:9bf9    mov       word ptr es:[bp+06],di
    79dd:9bfd    mov       word ptr es:[bp+02],000C
    79dd:9c03    add       bp,15
    79dd:9c06    mov       word ptr ss:[0AC7],bp
    79dd:9c0b    cmp       bp,7F00
    79dd:9c0f    jb        9C14
    79dd:9c11    call      MOREFR
    79dd:9c14    pop       bp
    79dd:9c15    pop       es
    79dd:9c16    jmp       9C5B
    79dd:9c18    push      es
    79dd:9c19    push      bp
    79dd:9c1a    push      cx
    79dd:9c1b    push      ax
    79dd:9c1c    mov       es,word ptr ss:[13A6]
    79dd:9c21    mov       bp,word ptr ss:[13A8]
    79dd:9c26    mov       ax,di
    79dd:9c28    sub       ax,word ptr ss:[13B4]
    79dd:9c2d    xor       cx,cx
    79dd:9c2f    add       ax,word ptr ss:[13BE]
    79dd:9c34    adc       cx,word ptr ss:[13BC]
    79dd:9c39    mov       word ptr es:[bp+00],ax
    79dd:9c3d    mov       word ptr es:[bp+02],cx
    79dd:9c41    mov       byte ptr es:[bp+04],0C
    79dd:9c46    add       bp,05
    79dd:9c49    mov       word ptr ss:[13A8],bp
    79dd:9c4e    cmp       bp,3F00
    79dd:9c52    jb        9C57
    79dd:9c54    call      MOREEXT
    79dd:9c57    pop       ax
    79dd:9c58    pop       cx
    79dd:9c59    pop       bp
    79dd:9c5a    pop       es
    79dd:9c5b    mov       al,byte ptr [si]
    79dd:9c5d    xlat
    79dd:9c5f    or        al,al
    79dd:9c61    js        9C66
    79dd:9c63    jmp       PM
    79dd:9c66    mov       al,3F
    79dd:9c68    mov       ah,cl
    79dd:9c6a    stosw
    79dd:9c6b    ret
             M_BRA:
    79dd:9c6c    lodsb
    79dd:9c6d    xlat
    79dd:9c6f    or        al,al
    79dd:9c71    js        M_BRA
    79dd:9c73    dec       si
    79dd:9c74    call      CONVEXPRESS
    79dd:9c77    test      byte ptr ss:[0ACE],C0
    79dd:9c7d    je        9CC6
    79dd:9c7f    test      byte ptr ss:[0ACE],40
    79dd:9c85    jne       9CF2
    79dd:9c87    push      es
    79dd:9c88    push      bp
    79dd:9c89    mov       es,word ptr ss:[0AC5]
    79dd:9c8e    mov       bp,word ptr ss:[0AC9]
    79dd:9c93    mov       word ptr es:[bp+06],di
    79dd:9c97    mov       ax,word ptr [0F92]
    79dd:9c9b    mov       word ptr es:[bp+0A],ax
    79dd:9c9f    mov       ax,word ptr [0F94]
    79dd:9ca3    mov       word ptr es:[bp+0C],ax
    79dd:9ca7    mov       word ptr es:[bp+02],0008
    79dd:9cad    add       bp,15
    79dd:9cb0    mov       word ptr ss:[0AC7],bp
    79dd:9cb5    cmp       bp,7F00
    79dd:9cb9    jb        9CBE
    79dd:9cbb    call      MOREFR
    79dd:9cbe    pop       bp
    79dd:9cbf    pop       es
    79dd:9cc0    mov       al,05
    79dd:9cc2    xor       ah,ah
    79dd:9cc4    stosw
    79dd:9cc5    ret
    79dd:9cc6    mov       bp,bx
    79dd:9cc8    sub       dx,word ptr ss:[0F92]
    79dd:9ccd    je        9CD2
    79dd:9ccf    jmp       BCCERR
    79dd:9cd2    sub       cx,word ptr ss:[0F94]
    79dd:9cd7    sub       cx,02
    79dd:9cda    cmp       cx,80
    79dd:9cdd    jge       9CE2
    79dd:9cdf    jmp       BCCERR
    79dd:9ce2    cmp       cx,7F
    79dd:9ce5    jle       9CEA
    79dd:9ce7    jmp       BCCERR
    79dd:9cea    mov       ah,cl
    79dd:9cec    mov       al,05
    79dd:9cee    stosw
    79dd:9cef    mov       bx,bp
    79dd:9cf1    ret
    79dd:9cf2    push      dx
    79dd:9cf3    mov       dx,8595
    79dd:9cf6    call      ERROR_ROUT
    79dd:9cf9    pop       dx
    79dd:9cfa    ret
             M_BGE:
    79dd:9cfb    lodsb
    79dd:9cfc    xlat
    79dd:9cfe    or        al,al
    79dd:9d00    js        M_BGE
    79dd:9d02    dec       si
    79dd:9d03    call      CONVEXPRESS
    79dd:9d06    test      byte ptr ss:[0ACE],C0
    79dd:9d0c    je        9D55
    79dd:9d0e    test      byte ptr ss:[0ACE],40
    79dd:9d14    jne       9D81
    79dd:9d16    push      es
    79dd:9d17    push      bp
    79dd:9d18    mov       es,word ptr ss:[0AC5]
    79dd:9d1d    mov       bp,word ptr ss:[0AC9]
    79dd:9d22    mov       word ptr es:[bp+06],di
    79dd:9d26    mov       ax,word ptr [0F92]
    79dd:9d2a    mov       word ptr es:[bp+0A],ax
    79dd:9d2e    mov       ax,word ptr [0F94]
    79dd:9d32    mov       word ptr es:[bp+0C],ax
    79dd:9d36    mov       word ptr es:[bp+02],0008
    79dd:9d3c    add       bp,15
    79dd:9d3f    mov       word ptr ss:[0AC7],bp
    79dd:9d44    cmp       bp,7F00
    79dd:9d48    jb        9D4D
    79dd:9d4a    call      MOREFR
    79dd:9d4d    pop       bp
    79dd:9d4e    pop       es
    79dd:9d4f    mov       al,06
    79dd:9d51    xor       ah,ah
    79dd:9d53    stosw
    79dd:9d54    ret
    79dd:9d55    mov       bp,bx
    79dd:9d57    sub       dx,word ptr ss:[0F92]
    79dd:9d5c    je        9D61
    79dd:9d5e    jmp       BCCERR
    79dd:9d61    sub       cx,word ptr ss:[0F94]
    79dd:9d66    sub       cx,02
    79dd:9d69    cmp       cx,80
    79dd:9d6c    jge       9D71
    79dd:9d6e    jmp       BCCERR
    79dd:9d71    cmp       cx,7F
    79dd:9d74    jle       9D79
    79dd:9d76    jmp       BCCERR
    79dd:9d79    mov       ah,cl
    79dd:9d7b    mov       al,06
    79dd:9d7d    stosw
    79dd:9d7e    mov       bx,bp
    79dd:9d80    ret
    79dd:9d81    push      dx
    79dd:9d82    mov       dx,8595
    79dd:9d85    call      ERROR_ROUT
    79dd:9d88    pop       dx
    79dd:9d89    ret
             M_BLT:
    79dd:9d8a    lodsb
    79dd:9d8b    xlat
    79dd:9d8d    or        al,al
    79dd:9d8f    js        M_BLT
    79dd:9d91    dec       si
    79dd:9d92    call      CONVEXPRESS
    79dd:9d95    test      byte ptr ss:[0ACE],C0
    79dd:9d9b    je        9DE4
    79dd:9d9d    test      byte ptr ss:[0ACE],40
    79dd:9da3    jne       9E10
    79dd:9da5    push      es
    79dd:9da6    push      bp
    79dd:9da7    mov       es,word ptr ss:[0AC5]
    79dd:9dac    mov       bp,word ptr ss:[0AC9]
    79dd:9db1    mov       word ptr es:[bp+06],di
    79dd:9db5    mov       ax,word ptr [0F92]
    79dd:9db9    mov       word ptr es:[bp+0A],ax
    79dd:9dbd    mov       ax,word ptr [0F94]
    79dd:9dc1    mov       word ptr es:[bp+0C],ax
    79dd:9dc5    mov       word ptr es:[bp+02],0008
    79dd:9dcb    add       bp,15
    79dd:9dce    mov       word ptr ss:[0AC7],bp
    79dd:9dd3    cmp       bp,7F00
    79dd:9dd7    jb        9DDC
    79dd:9dd9    call      MOREFR
    79dd:9ddc    pop       bp
    79dd:9ddd    pop       es
    79dd:9dde    mov       al,07
    79dd:9de0    xor       ah,ah
    79dd:9de2    stosw
    79dd:9de3    ret
    79dd:9de4    mov       bp,bx
    79dd:9de6    sub       dx,word ptr ss:[0F92]
    79dd:9deb    je        9DF0
    79dd:9ded    jmp       BCCERR
    79dd:9df0    sub       cx,word ptr ss:[0F94]
    79dd:9df5    sub       cx,02
    79dd:9df8    cmp       cx,80
    79dd:9dfb    jge       9E00
    79dd:9dfd    jmp       BCCERR
    79dd:9e00    cmp       cx,7F
    79dd:9e03    jle       9E08
    79dd:9e05    jmp       BCCERR
    79dd:9e08    mov       ah,cl
    79dd:9e0a    mov       al,07
    79dd:9e0c    stosw
    79dd:9e0d    mov       bx,bp
    79dd:9e0f    ret
    79dd:9e10    push      dx
    79dd:9e11    mov       dx,8595
    79dd:9e14    call      ERROR_ROUT
    79dd:9e17    pop       dx
    79dd:9e18    ret
             M_BNE:
    79dd:9e19    lodsb
    79dd:9e1a    xlat
    79dd:9e1c    or        al,al
    79dd:9e1e    js        M_BNE
    79dd:9e20    dec       si
    79dd:9e21    call      CONVEXPRESS
    79dd:9e24    test      byte ptr ss:[0ACE],C0
    79dd:9e2a    je        9E73
    79dd:9e2c    test      byte ptr ss:[0ACE],40
    79dd:9e32    jne       9E9F
    79dd:9e34    push      es
    79dd:9e35    push      bp
    79dd:9e36    mov       es,word ptr ss:[0AC5]
    79dd:9e3b    mov       bp,word ptr ss:[0AC9]
    79dd:9e40    mov       word ptr es:[bp+06],di
    79dd:9e44    mov       ax,word ptr [0F92]
    79dd:9e48    mov       word ptr es:[bp+0A],ax
    79dd:9e4c    mov       ax,word ptr [0F94]
    79dd:9e50    mov       word ptr es:[bp+0C],ax
    79dd:9e54    mov       word ptr es:[bp+02],0008
    79dd:9e5a    add       bp,15
    79dd:9e5d    mov       word ptr ss:[0AC7],bp
    79dd:9e62    cmp       bp,7F00
    79dd:9e66    jb        9E6B
    79dd:9e68    call      MOREFR
    79dd:9e6b    pop       bp
    79dd:9e6c    pop       es
    79dd:9e6d    mov       al,08
    79dd:9e6f    xor       ah,ah
    79dd:9e71    stosw
    79dd:9e72    ret
    79dd:9e73    mov       bp,bx
    79dd:9e75    sub       dx,word ptr ss:[0F92]
    79dd:9e7a    je        9E7F
    79dd:9e7c    jmp       BCCERR
    79dd:9e7f    sub       cx,word ptr ss:[0F94]
    79dd:9e84    sub       cx,02
    79dd:9e87    cmp       cx,80
    79dd:9e8a    jge       9E8F
    79dd:9e8c    jmp       BCCERR
    79dd:9e8f    cmp       cx,7F
    79dd:9e92    jle       9E97
    79dd:9e94    jmp       BCCERR
    79dd:9e97    mov       ah,cl
    79dd:9e99    mov       al,08
    79dd:9e9b    stosw
    79dd:9e9c    mov       bx,bp
    79dd:9e9e    ret
    79dd:9e9f    push      dx
    79dd:9ea0    mov       dx,8595
    79dd:9ea3    call      ERROR_ROUT
    79dd:9ea6    pop       dx
    79dd:9ea7    ret
             M_BEQ:
    79dd:9ea8    lodsb
    79dd:9ea9    xlat
    79dd:9eab    or        al,al
    79dd:9ead    js        M_BEQ
    79dd:9eaf    dec       si
    79dd:9eb0    call      CONVEXPRESS
    79dd:9eb3    test      byte ptr ss:[0ACE],C0
    79dd:9eb9    je        9F02
    79dd:9ebb    test      byte ptr ss:[0ACE],40
    79dd:9ec1    jne       9F2E
    79dd:9ec3    push      es
    79dd:9ec4    push      bp
    79dd:9ec5    mov       es,word ptr ss:[0AC5]
    79dd:9eca    mov       bp,word ptr ss:[0AC9]
    79dd:9ecf    mov       word ptr es:[bp+06],di
    79dd:9ed3    mov       ax,word ptr [0F92]
    79dd:9ed7    mov       word ptr es:[bp+0A],ax
    79dd:9edb    mov       ax,word ptr [0F94]
    79dd:9edf    mov       word ptr es:[bp+0C],ax
    79dd:9ee3    mov       word ptr es:[bp+02],0008
    79dd:9ee9    add       bp,15
    79dd:9eec    mov       word ptr ss:[0AC7],bp
    79dd:9ef1    cmp       bp,7F00
    79dd:9ef5    jb        9EFA
    79dd:9ef7    call      MOREFR
    79dd:9efa    pop       bp
    79dd:9efb    pop       es
    79dd:9efc    mov       al,09
    79dd:9efe    xor       ah,ah
    79dd:9f00    stosw
    79dd:9f01    ret
    79dd:9f02    mov       bp,bx
    79dd:9f04    sub       dx,word ptr ss:[0F92]
    79dd:9f09    je        9F0E
    79dd:9f0b    jmp       BCCERR
    79dd:9f0e    sub       cx,word ptr ss:[0F94]
    79dd:9f13    sub       cx,02
    79dd:9f16    cmp       cx,80
    79dd:9f19    jge       9F1E
    79dd:9f1b    jmp       BCCERR
    79dd:9f1e    cmp       cx,7F
    79dd:9f21    jle       9F26
    79dd:9f23    jmp       BCCERR
    79dd:9f26    mov       ah,cl
    79dd:9f28    mov       al,09
    79dd:9f2a    stosw
    79dd:9f2b    mov       bx,bp
    79dd:9f2d    ret
    79dd:9f2e    push      dx
    79dd:9f2f    mov       dx,8595
    79dd:9f32    call      ERROR_ROUT
    79dd:9f35    pop       dx
    79dd:9f36    ret
             M_BPL:
    79dd:9f37    lodsb
    79dd:9f38    xlat
    79dd:9f3a    or        al,al
    79dd:9f3c    js        M_BPL
    79dd:9f3e    dec       si
    79dd:9f3f    call      CONVEXPRESS
    79dd:9f42    test      byte ptr ss:[0ACE],C0
    79dd:9f48    je        9F91
    79dd:9f4a    test      byte ptr ss:[0ACE],40
    79dd:9f50    jne       9FBD
    79dd:9f52    push      es
    79dd:9f53    push      bp
    79dd:9f54    mov       es,word ptr ss:[0AC5]
    79dd:9f59    mov       bp,word ptr ss:[0AC9]
    79dd:9f5e    mov       word ptr es:[bp+06],di
    79dd:9f62    mov       ax,word ptr [0F92]
    79dd:9f66    mov       word ptr es:[bp+0A],ax
    79dd:9f6a    mov       ax,word ptr [0F94]
    79dd:9f6e    mov       word ptr es:[bp+0C],ax
    79dd:9f72    mov       word ptr es:[bp+02],0008
    79dd:9f78    add       bp,15
    79dd:9f7b    mov       word ptr ss:[0AC7],bp
    79dd:9f80    cmp       bp,7F00
    79dd:9f84    jb        9F89
    79dd:9f86    call      MOREFR
    79dd:9f89    pop       bp
    79dd:9f8a    pop       es
    79dd:9f8b    mov       al,0A
    79dd:9f8d    xor       ah,ah
    79dd:9f8f    stosw
    79dd:9f90    ret
    79dd:9f91    mov       bp,bx
    79dd:9f93    sub       dx,word ptr ss:[0F92]
    79dd:9f98    je        9F9D
    79dd:9f9a    jmp       BCCERR
    79dd:9f9d    sub       cx,word ptr ss:[0F94]
    79dd:9fa2    sub       cx,02
    79dd:9fa5    cmp       cx,80
    79dd:9fa8    jge       9FAD
    79dd:9faa    jmp       BCCERR
    79dd:9fad    cmp       cx,7F
    79dd:9fb0    jle       9FB5
    79dd:9fb2    jmp       BCCERR
    79dd:9fb5    mov       ah,cl
    79dd:9fb7    mov       al,0A
    79dd:9fb9    stosw
    79dd:9fba    mov       bx,bp
    79dd:9fbc    ret
    79dd:9fbd    push      dx
    79dd:9fbe    mov       dx,8595
    79dd:9fc1    call      ERROR_ROUT
    79dd:9fc4    pop       dx
    79dd:9fc5    ret
             M_BMI:
    79dd:9fc6    lodsb
    79dd:9fc7    xlat
    79dd:9fc9    or        al,al
    79dd:9fcb    js        M_BMI
    79dd:9fcd    dec       si
    79dd:9fce    call      CONVEXPRESS
    79dd:9fd1    test      byte ptr ss:[0ACE],C0
    79dd:9fd7    je        A020
    79dd:9fd9    test      byte ptr ss:[0ACE],40
    79dd:9fdf    jne       A04C
    79dd:9fe1    push      es
    79dd:9fe2    push      bp
    79dd:9fe3    mov       es,word ptr ss:[0AC5]
    79dd:9fe8    mov       bp,word ptr ss:[0AC9]
    79dd:9fed    mov       word ptr es:[bp+06],di
    79dd:9ff1    mov       ax,word ptr [0F92]
    79dd:9ff5    mov       word ptr es:[bp+0A],ax
    79dd:9ff9    mov       ax,word ptr [0F94]
    79dd:9ffd    mov       word ptr es:[bp+0C],ax
    79dd:a001    mov       word ptr es:[bp+02],0008
    79dd:a007    add       bp,15
    79dd:a00a    mov       word ptr ss:[0AC7],bp
    79dd:a00f    cmp       bp,7F00
    79dd:a013    jb        A018
    79dd:a015    call      MOREFR
    79dd:a018    pop       bp
    79dd:a019    pop       es
    79dd:a01a    mov       al,0B
    79dd:a01c    xor       ah,ah
    79dd:a01e    stosw
    79dd:a01f    ret
    79dd:a020    mov       bp,bx
    79dd:a022    sub       dx,word ptr ss:[0F92]
    79dd:a027    je        A02C
    79dd:a029    jmp       BCCERR
    79dd:a02c    sub       cx,word ptr ss:[0F94]
    79dd:a031    sub       cx,02
    79dd:a034    cmp       cx,80
    79dd:a037    jge       A03C
    79dd:a039    jmp       BCCERR
    79dd:a03c    cmp       cx,7F
    79dd:a03f    jle       A044
    79dd:a041    jmp       BCCERR
    79dd:a044    mov       ah,cl
    79dd:a046    mov       al,0B
    79dd:a048    stosw
    79dd:a049    mov       bx,bp
    79dd:a04b    ret
    79dd:a04c    push      dx
    79dd:a04d    mov       dx,8595
    79dd:a050    call      ERROR_ROUT
    79dd:a053    pop       dx
    79dd:a054    ret
             M_BCC:
    79dd:a055    lodsb
    79dd:a056    xlat
    79dd:a058    or        al,al
    79dd:a05a    js        M_BCC
    79dd:a05c    dec       si
    79dd:a05d    call      CONVEXPRESS
    79dd:a060    test      byte ptr ss:[0ACE],C0
    79dd:a066    je        A0AF
    79dd:a068    test      byte ptr ss:[0ACE],40
    79dd:a06e    jne       A0DB
    79dd:a070    push      es
    79dd:a071    push      bp
    79dd:a072    mov       es,word ptr ss:[0AC5]
    79dd:a077    mov       bp,word ptr ss:[0AC9]
    79dd:a07c    mov       word ptr es:[bp+06],di
    79dd:a080    mov       ax,word ptr [0F92]
    79dd:a084    mov       word ptr es:[bp+0A],ax
    79dd:a088    mov       ax,word ptr [0F94]
    79dd:a08c    mov       word ptr es:[bp+0C],ax
    79dd:a090    mov       word ptr es:[bp+02],0008
    79dd:a096    add       bp,15
    79dd:a099    mov       word ptr ss:[0AC7],bp
    79dd:a09e    cmp       bp,7F00
    79dd:a0a2    jb        A0A7
    79dd:a0a4    call      MOREFR
    79dd:a0a7    pop       bp
    79dd:a0a8    pop       es
    79dd:a0a9    mov       al,0C
    79dd:a0ab    xor       ah,ah
    79dd:a0ad    stosw
    79dd:a0ae    ret
    79dd:a0af    mov       bp,bx
    79dd:a0b1    sub       dx,word ptr ss:[0F92]
    79dd:a0b6    je        A0BB
    79dd:a0b8    jmp       BCCERR
    79dd:a0bb    sub       cx,word ptr ss:[0F94]
    79dd:a0c0    sub       cx,02
    79dd:a0c3    cmp       cx,80
    79dd:a0c6    jge       A0CB
    79dd:a0c8    jmp       BCCERR
    79dd:a0cb    cmp       cx,7F
    79dd:a0ce    jle       A0D3
    79dd:a0d0    jmp       BCCERR
    79dd:a0d3    mov       ah,cl
    79dd:a0d5    mov       al,0C
    79dd:a0d7    stosw
    79dd:a0d8    mov       bx,bp
    79dd:a0da    ret
    79dd:a0db    push      dx
    79dd:a0dc    mov       dx,8595
    79dd:a0df    call      ERROR_ROUT
    79dd:a0e2    pop       dx
    79dd:a0e3    ret
             M_BCS:
    79dd:a0e4    lodsb
    79dd:a0e5    xlat
    79dd:a0e7    or        al,al
    79dd:a0e9    js        M_BCS
    79dd:a0eb    dec       si
    79dd:a0ec    call      CONVEXPRESS
    79dd:a0ef    test      byte ptr ss:[0ACE],C0
    79dd:a0f5    je        A13E
    79dd:a0f7    test      byte ptr ss:[0ACE],40
    79dd:a0fd    jne       A16A
    79dd:a0ff    push      es
    79dd:a100    push      bp
    79dd:a101    mov       es,word ptr ss:[0AC5]
    79dd:a106    mov       bp,word ptr ss:[0AC9]
    79dd:a10b    mov       word ptr es:[bp+06],di
    79dd:a10f    mov       ax,word ptr [0F92]
    79dd:a113    mov       word ptr es:[bp+0A],ax
    79dd:a117    mov       ax,word ptr [0F94]
    79dd:a11b    mov       word ptr es:[bp+0C],ax
    79dd:a11f    mov       word ptr es:[bp+02],0008
    79dd:a125    add       bp,15
    79dd:a128    mov       word ptr ss:[0AC7],bp
    79dd:a12d    cmp       bp,7F00
    79dd:a131    jb        A136
    79dd:a133    call      MOREFR
    79dd:a136    pop       bp
    79dd:a137    pop       es
    79dd:a138    mov       al,0D
    79dd:a13a    xor       ah,ah
    79dd:a13c    stosw
    79dd:a13d    ret
    79dd:a13e    mov       bp,bx
    79dd:a140    sub       dx,word ptr ss:[0F92]
    79dd:a145    je        A14A
    79dd:a147    jmp       BCCERR
    79dd:a14a    sub       cx,word ptr ss:[0F94]
    79dd:a14f    sub       cx,02
    79dd:a152    cmp       cx,80
    79dd:a155    jge       A15A
    79dd:a157    jmp       BCCERR
    79dd:a15a    cmp       cx,7F
    79dd:a15d    jle       A162
    79dd:a15f    jmp       BCCERR
    79dd:a162    mov       ah,cl
    79dd:a164    mov       al,0D
    79dd:a166    stosw
    79dd:a167    mov       bx,bp
    79dd:a169    ret
    79dd:a16a    push      dx
    79dd:a16b    mov       dx,8595
    79dd:a16e    call      ERROR_ROUT
    79dd:a171    pop       dx
    79dd:a172    ret
             M_BVC:
    79dd:a173    lodsb
    79dd:a174    xlat
    79dd:a176    or        al,al
    79dd:a178    js        M_BVC
    79dd:a17a    dec       si
    79dd:a17b    call      CONVEXPRESS
    79dd:a17e    test      byte ptr ss:[0ACE],C0
    79dd:a184    je        A1CD
    79dd:a186    test      byte ptr ss:[0ACE],40
    79dd:a18c    jne       A1F9
    79dd:a18e    push      es
    79dd:a18f    push      bp
    79dd:a190    mov       es,word ptr ss:[0AC5]
    79dd:a195    mov       bp,word ptr ss:[0AC9]
    79dd:a19a    mov       word ptr es:[bp+06],di
    79dd:a19e    mov       ax,word ptr [0F92]
    79dd:a1a2    mov       word ptr es:[bp+0A],ax
    79dd:a1a6    mov       ax,word ptr [0F94]
    79dd:a1aa    mov       word ptr es:[bp+0C],ax
    79dd:a1ae    mov       word ptr es:[bp+02],0008
    79dd:a1b4    add       bp,15
    79dd:a1b7    mov       word ptr ss:[0AC7],bp
    79dd:a1bc    cmp       bp,7F00
    79dd:a1c0    jb        A1C5
    79dd:a1c2    call      MOREFR
    79dd:a1c5    pop       bp
    79dd:a1c6    pop       es
    79dd:a1c7    mov       al,0E
    79dd:a1c9    xor       ah,ah
    79dd:a1cb    stosw
    79dd:a1cc    ret
    79dd:a1cd    mov       bp,bx
    79dd:a1cf    sub       dx,word ptr ss:[0F92]
    79dd:a1d4    je        A1D9
    79dd:a1d6    jmp       BCCERR
    79dd:a1d9    sub       cx,word ptr ss:[0F94]
    79dd:a1de    sub       cx,02
    79dd:a1e1    cmp       cx,80
    79dd:a1e4    jge       A1E9
    79dd:a1e6    jmp       BCCERR
    79dd:a1e9    cmp       cx,7F
    79dd:a1ec    jle       A1F1
    79dd:a1ee    jmp       BCCERR
    79dd:a1f1    mov       ah,cl
    79dd:a1f3    mov       al,0E
    79dd:a1f5    stosw
    79dd:a1f6    mov       bx,bp
    79dd:a1f8    ret
    79dd:a1f9    push      dx
    79dd:a1fa    mov       dx,8595
    79dd:a1fd    call      ERROR_ROUT
    79dd:a200    pop       dx
    79dd:a201    ret
             M_BVS:
    79dd:a202    lodsb
    79dd:a203    xlat
    79dd:a205    or        al,al
    79dd:a207    js        M_BVS
    79dd:a209    dec       si
    79dd:a20a    call      CONVEXPRESS
    79dd:a20d    test      byte ptr ss:[0ACE],C0
    79dd:a213    je        A25C
    79dd:a215    test      byte ptr ss:[0ACE],40
    79dd:a21b    jne       A288
    79dd:a21d    push      es
    79dd:a21e    push      bp
    79dd:a21f    mov       es,word ptr ss:[0AC5]
    79dd:a224    mov       bp,word ptr ss:[0AC9]
    79dd:a229    mov       word ptr es:[bp+06],di
    79dd:a22d    mov       ax,word ptr [0F92]
    79dd:a231    mov       word ptr es:[bp+0A],ax
    79dd:a235    mov       ax,word ptr [0F94]
    79dd:a239    mov       word ptr es:[bp+0C],ax
    79dd:a23d    mov       word ptr es:[bp+02],0008
    79dd:a243    add       bp,15
    79dd:a246    mov       word ptr ss:[0AC7],bp
    79dd:a24b    cmp       bp,7F00
    79dd:a24f    jb        A254
    79dd:a251    call      MOREFR
    79dd:a254    pop       bp
    79dd:a255    pop       es
    79dd:a256    mov       al,0F
    79dd:a258    xor       ah,ah
    79dd:a25a    stosw
    79dd:a25b    ret
    79dd:a25c    mov       bp,bx
    79dd:a25e    sub       dx,word ptr ss:[0F92]
    79dd:a263    je        A268
    79dd:a265    jmp       BCCERR
    79dd:a268    sub       cx,word ptr ss:[0F94]
    79dd:a26d    sub       cx,02
    79dd:a270    cmp       cx,80
    79dd:a273    jge       A278
    79dd:a275    jmp       BCCERR
    79dd:a278    cmp       cx,7F
    79dd:a27b    jle       A280
    79dd:a27d    jmp       BCCERR
    79dd:a280    mov       ah,cl
    79dd:a282    mov       al,0F
    79dd:a284    stosw
    79dd:a285    mov       bx,bp
    79dd:a287    ret
    79dd:a288    push      dx
    79dd:a289    mov       dx,8595
    79dd:a28c    call      ERROR_ROUT
    79dd:a28f    pop       dx
    79dd:a290    ret
             M_CAC:
    79dd:a291    lodsw
    79dd:a292    and       ax,DFDF
    79dd:a295    cmp       ax,4548
    79dd:a298    je        A29D
    79dd:a29a    jmp       PM
    79dd:a29d    mov       al,byte ptr [si]
    79dd:a29f    xlat
    79dd:a2a1    or        al,al
    79dd:a2a3    js        A2A8
    79dd:a2a5    jmp       PM
    79dd:a2a8    mov       al,byte ptr [si]
    79dd:a2aa    xlat
    79dd:a2ac    or        al,al
    79dd:a2ae    js        A2B3
    79dd:a2b0    jmp       PM
    79dd:a2b3    mov       al,02
    79dd:a2b5    stosb
    79dd:a2b6    ret
             M_COL:
    79dd:a2b7    lodsw
    79dd:a2b8    and       ax,DFDF
    79dd:a2bb    cmp       ax,554F
    79dd:a2be    je        A2C3
    79dd:a2c0    jmp       PM
    79dd:a2c3    lodsb
    79dd:a2c4    and       al,DF
    79dd:a2c6    cmp       al,52
    79dd:a2c8    je        A2CD
    79dd:a2ca    jmp       PM
    79dd:a2cd    mov       al,byte ptr [si]
    79dd:a2cf    xlat
    79dd:a2d1    or        al,al
    79dd:a2d3    js        A2D8
    79dd:a2d5    jmp       PM
    79dd:a2d8    mov       al,byte ptr [si]
    79dd:a2da    xlat
    79dd:a2dc    or        al,al
    79dd:a2de    js        A2E3
    79dd:a2e0    jmp       PM
    79dd:a2e3    mov       al,4E
    79dd:a2e5    stosb
    79dd:a2e6    ret
             M_CMO:
    79dd:a2e7    lodsw
    79dd:a2e8    and       ax,DFDF
    79dd:a2eb    cmp       ax,4544
    79dd:a2ee    je        A2F3
    79dd:a2f0    jmp       PM
    79dd:a2f3    mov       al,byte ptr [si]
    79dd:a2f5    xlat
    79dd:a2f7    or        al,al
    79dd:a2f9    js        A2FE
    79dd:a2fb    jmp       PM
    79dd:a2fe    mov       al,byte ptr [si]
    79dd:a300    xlat
    79dd:a302    or        al,al
    79dd:a304    js        A309
    79dd:a306    jmp       PM
    79dd:a309    mov       al,3D
    79dd:a30b    mov       ah,4E
    79dd:a30d    stosw
    79dd:a30e    ret
             M_CMP:
    79dd:a30f    mov       al,byte ptr [si]
    79dd:a311    xlat
    79dd:a313    or        al,al
    79dd:a315    js        A31A
    79dd:a317    jmp       PM
    79dd:a31a    lodsb
    79dd:a31b    xlat
    79dd:a31d    or        al,al
    79dd:a31f    js        A31A
    79dd:a321    dec       si
    79dd:a322    lodsb
    79dd:a323    and       al,DF
    79dd:a325    cmp       al,52
    79dd:a327    jne       A33C
    79dd:a329    lodsb
    79dd:a32a    sub       al,30
    79dd:a32c    js        A33B
    79dd:a32e    cmp       al,09
    79dd:a330    jg        A33B
    79dd:a332    cmp       al,01
    79dd:a334    je        A359
    79dd:a336    mov       cl,al
    79dd:a338    jmp       A372
    79dd:a33a    dec       si
    79dd:a33b    dec       si
    79dd:a33c    dec       si
    79dd:a33d    push      dx
    79dd:a33e    call      CONVEXPRESS
    79dd:a341    pop       dx
    79dd:a342    test      byte ptr ss:[0ACE],04
    79dd:a348    jne       A372
    79dd:a34a    jmp       GREGERR
    79dd:a34d    cmp       ah,05
    79dd:a350    jg        A33A
    79dd:a352    add       ah,0A
    79dd:a355    mov       cl,ah
    79dd:a357    jmp       A372
    79dd:a359    lodsb
    79dd:a35a    cmp       al,5D
    79dd:a35c    je        A370
    79dd:a35e    cmp       al,2C
    79dd:a360    je        A36F
    79dd:a362    mov       ah,al
    79dd:a364    sub       ah,30
    79dd:a367    jns       A34D
    79dd:a369    xlat
    79dd:a36b    or        al,al
    79dd:a36d    jns       A33A
    79dd:a36f    dec       si
    79dd:a370    mov       cl,01
    79dd:a372    add       cl,60
    79dd:a375    mov       al,byte ptr [si]
    79dd:a377    xlat
    79dd:a379    or        al,al
    79dd:a37b    js        A380
    79dd:a37d    jmp       PM
    79dd:a380    mov       al,3F
    79dd:a382    mov       ah,cl
    79dd:a384    stosw
    79dd:a385    ret
             M_DEC:
    79dd:a386    lodsb
    79dd:a387    xlat
    79dd:a389    or        al,al
    79dd:a38b    js        M_DEC
    79dd:a38d    dec       si
    79dd:a38e    lodsb
    79dd:a38f    and       al,DF
    79dd:a391    cmp       al,52
    79dd:a393    jne       A3A8
    79dd:a395    lodsb
    79dd:a396    sub       al,30
    79dd:a398    js        A3A7
    79dd:a39a    cmp       al,09
    79dd:a39c    jg        A3A7
    79dd:a39e    cmp       al,01
    79dd:a3a0    je        A3C5
    79dd:a3a2    mov       cl,al
    79dd:a3a4    jmp       A3DE
    79dd:a3a6    dec       si
    79dd:a3a7    dec       si
    79dd:a3a8    dec       si
    79dd:a3a9    push      dx
    79dd:a3aa    call      CONVEXPRESS
    79dd:a3ad    pop       dx
    79dd:a3ae    test      byte ptr ss:[0ACE],04
    79dd:a3b4    jne       A3DE
    79dd:a3b6    jmp       GREGERR
    79dd:a3b9    cmp       ah,04
    79dd:a3bc    jg        A3A6
    79dd:a3be    add       ah,0A
    79dd:a3c1    mov       cl,ah
    79dd:a3c3    jmp       A3DE
    79dd:a3c5    lodsb
    79dd:a3c6    cmp       al,5D
    79dd:a3c8    je        A3DB
    79dd:a3ca    cmp       al,2C
    79dd:a3cc    je        A3DB
    79dd:a3ce    mov       ah,al
    79dd:a3d0    sub       ah,30
    79dd:a3d3    jns       A3B9
    79dd:a3d5    xlat
    79dd:a3d7    or        al,al
    79dd:a3d9    jns       A3A6
    79dd:a3db    mov       cl,01
    79dd:a3dd    dec       si
    79dd:a3de    add       cl,E0
    79dd:a3e1    mov       al,byte ptr [si]
    79dd:a3e3    xlat
    79dd:a3e5    or        al,al
    79dd:a3e7    js        A3EC
    79dd:a3e9    jmp       PM
    79dd:a3ec    mov       al,cl
    79dd:a3ee    stosb
    79dd:a3ef    ret
             M_DIV:
    79dd:a3f0    lodsb
    79dd:a3f1    cmp       al,32
    79dd:a3f3    je        A3F8
    79dd:a3f5    jmp       PM
    79dd:a3f8    mov       al,byte ptr [si]
    79dd:a3fa    xlat
    79dd:a3fc    or        al,al
    79dd:a3fe    js        A403
    79dd:a400    jmp       PM
    79dd:a403    mov       al,byte ptr [si]
    79dd:a405    xlat
    79dd:a407    or        al,al
    79dd:a409    js        A40E
    79dd:a40b    jmp       PM
    79dd:a40e    mov       al,3D
    79dd:a410    mov       ah,96
    79dd:a412    stosw
    79dd:a413    ret
             M_FMU:
    79dd:a414    lodsw
    79dd:a415    and       ax,DFDF
    79dd:a418    cmp       ax,544C
    79dd:a41b    je        A420
    79dd:a41d    jmp       PM
    79dd:a420    mov       al,byte ptr [si]
    79dd:a422    xlat
    79dd:a424    or        al,al
    79dd:a426    js        A42B
    79dd:a428    jmp       PM
    79dd:a42b    mov       al,byte ptr [si]
    79dd:a42d    xlat
    79dd:a42f    or        al,al
    79dd:a431    js        A436
    79dd:a433    jmp       PM
    79dd:a436    mov       al,9F
    79dd:a438    stosb
    79dd:a439    ret
             M_FRO:
    79dd:a43a    lodsb
    79dd:a43b    and       al,DF
    79dd:a43d    cmp       al,4D
    79dd:a43f    je        A444
    79dd:a441    jmp       PM
    79dd:a444    mov       al,byte ptr [si]
    79dd:a446    xlat
    79dd:a448    or        al,al
    79dd:a44a    js        A44F
    79dd:a44c    jmp       PM
    79dd:a44f    lodsb
    79dd:a450    xlat
    79dd:a452    or        al,al
    79dd:a454    js        A44F
    79dd:a456    dec       si
    79dd:a457    lodsb
    79dd:a458    and       al,DF
    79dd:a45a    cmp       al,52
    79dd:a45c    jne       A471
    79dd:a45e    lodsb
    79dd:a45f    sub       al,30
    79dd:a461    js        A470
    79dd:a463    cmp       al,09
    79dd:a465    jg        A470
    79dd:a467    cmp       al,01
    79dd:a469    je        A48E
    79dd:a46b    mov       cl,al
    79dd:a46d    jmp       A4A7
    79dd:a46f    dec       si
    79dd:a470    dec       si
    79dd:a471    dec       si
    79dd:a472    push      dx
    79dd:a473    call      CONVEXPRESS
    79dd:a476    pop       dx
    79dd:a477    test      byte ptr ss:[0ACE],04
    79dd:a47d    jne       A4A7
    79dd:a47f    jmp       GREGERR
    79dd:a482    cmp       ah,05
    79dd:a485    jg        A46F
    79dd:a487    add       ah,0A
    79dd:a48a    mov       cl,ah
    79dd:a48c    jmp       A4A7
    79dd:a48e    lodsb
    79dd:a48f    cmp       al,5D
    79dd:a491    je        A4A5
    79dd:a493    cmp       al,2C
    79dd:a495    je        A4A4
    79dd:a497    mov       ah,al
    79dd:a499    sub       ah,30
    79dd:a49c    jns       A482
    79dd:a49e    xlat
    79dd:a4a0    or        al,al
    79dd:a4a2    jns       A46F
    79dd:a4a4    dec       si
    79dd:a4a5    mov       cl,01
    79dd:a4a7    add       cl,B0
    79dd:a4aa    mov       al,byte ptr [si]
    79dd:a4ac    xlat
    79dd:a4ae    or        al,al
    79dd:a4b0    js        A4B5
    79dd:a4b2    jmp       PM
    79dd:a4b5    mov       al,cl
    79dd:a4b7    stosb
    79dd:a4b8    ret
             M_GET:
    79dd:a4b9    lodsb
    79dd:a4ba    and       al,DF
    79dd:a4bc    cmp       al,43
    79dd:a4be    je        M_GETC
    79dd:a4c0    cmp       al,42
    79dd:a4c2    je        M_GETB
    79dd:a4c4    jmp       PM
             M_GETC:
    79dd:a4c7    mov       al,byte ptr [si]
    79dd:a4c9    xlat
    79dd:a4cb    or        al,al
    79dd:a4cd    js        A4D2
    79dd:a4cf    jmp       PM
    79dd:a4d2    mov       al,byte ptr [si]
    79dd:a4d4    xlat
    79dd:a4d6    or        al,al
    79dd:a4d8    js        A4DD
    79dd:a4da    jmp       PM
    79dd:a4dd    mov       al,DF
    79dd:a4df    stosb
    79dd:a4e0    ret
             M_GETB:
    79dd:a4e1    lodsb
    79dd:a4e2    xlat
    79dd:a4e4    or        al,al
    79dd:a4e6    js        M_GETBWS
    79dd:a4e8    cmp       al,48
    79dd:a4ea    je        M_GETBH
    79dd:a4ec    cmp       al,4C
    79dd:a4ee    je        M_GETBL
    79dd:a4f0    cmp       al,53
    79dd:a4f2    je        M_GETBS
    79dd:a4f4    jmp       PM
             M_GETBWS:
    79dd:a4f7    dec       si
    79dd:a4f8    mov       al,byte ptr [si]
    79dd:a4fa    xlat
    79dd:a4fc    or        al,al
    79dd:a4fe    js        A503
    79dd:a500    jmp       PM
    79dd:a503    mov       al,EF
    79dd:a505    stosb
    79dd:a506    ret
             M_GETBH:
    79dd:a507    mov       al,byte ptr [si]
    79dd:a509    xlat
    79dd:a50b    or        al,al
    79dd:a50d    js        A512
    79dd:a50f    jmp       PM
    79dd:a512    mov       al,byte ptr [si]
    79dd:a514    xlat
    79dd:a516    or        al,al
    79dd:a518    js        A51D
    79dd:a51a    jmp       PM
    79dd:a51d    mov       al,3D
    79dd:a51f    mov       ah,EF
    79dd:a521    stosw
    79dd:a522    ret
             M_GETBL:
    79dd:a523    mov       al,byte ptr [si]
    79dd:a525    xlat
    79dd:a527    or        al,al
    79dd:a529    js        A52E
    79dd:a52b    jmp       PM
    79dd:a52e    mov       al,byte ptr [si]
    79dd:a530    xlat
    79dd:a532    or        al,al
    79dd:a534    js        A539
    79dd:a536    jmp       PM
    79dd:a539    mov       al,3E
    79dd:a53b    mov       ah,EF
    79dd:a53d    stosw
    79dd:a53e    ret
             M_GETBS:
    79dd:a53f    mov       al,byte ptr [si]
    79dd:a541    xlat
    79dd:a543    or        al,al
    79dd:a545    js        A54A
    79dd:a547    jmp       PM
    79dd:a54a    mov       al,byte ptr [si]
    79dd:a54c    xlat
    79dd:a54e    or        al,al
    79dd:a550    js        A555
    79dd:a552    jmp       PM
    79dd:a555    mov       al,3F
    79dd:a557    mov       ah,EF
    79dd:a559    stosw
    79dd:a55a    ret
             M_HIB:
    79dd:a55b    mov       al,byte ptr [si]
    79dd:a55d    xlat
    79dd:a55f    or        al,al
    79dd:a561    js        A566
    79dd:a563    jmp       PM
    79dd:a566    mov       al,byte ptr [si]
    79dd:a568    xlat
    79dd:a56a    or        al,al
    79dd:a56c    js        A571
    79dd:a56e    jmp       PM
    79dd:a571    mov       al,C0
    79dd:a573    stosb
    79dd:a574    ret
             M_IBT:
    79dd:a575    mov       al,byte ptr [si]
    79dd:a577    xlat
    79dd:a579    or        al,al
    79dd:a57b    js        A580
    79dd:a57d    jmp       PM
    79dd:a580    lodsb
    79dd:a581    xlat
    79dd:a583    or        al,al
    79dd:a585    js        A580
    79dd:a587    dec       si
    79dd:a588    lodsb
    79dd:a589    and       al,DF
    79dd:a58b    cmp       al,52
    79dd:a58d    jne       A5A2
    79dd:a58f    lodsb
    79dd:a590    sub       al,30
    79dd:a592    js        A5A1
    79dd:a594    cmp       al,09
    79dd:a596    jg        A5A1
    79dd:a598    cmp       al,01
    79dd:a59a    je        A5BF
    79dd:a59c    mov       cl,al
    79dd:a59e    jmp       A5D8
    79dd:a5a0    dec       si
    79dd:a5a1    dec       si
    79dd:a5a2    dec       si
    79dd:a5a3    push      dx
    79dd:a5a4    call      CONVEXPRESS
    79dd:a5a7    pop       dx
    79dd:a5a8    test      byte ptr ss:[0ACE],04
    79dd:a5ae    jne       A5D8
    79dd:a5b0    jmp       GREGERR
    79dd:a5b3    cmp       ah,05
    79dd:a5b6    jg        A5A0
    79dd:a5b8    add       ah,0A
    79dd:a5bb    mov       cl,ah
    79dd:a5bd    jmp       A5D8
    79dd:a5bf    lodsb
    79dd:a5c0    cmp       al,5D
    79dd:a5c2    je        A5D6
    79dd:a5c4    cmp       al,2C
    79dd:a5c6    je        A5D5
    79dd:a5c8    mov       ah,al
    79dd:a5ca    sub       ah,30
    79dd:a5cd    jns       A5B3
    79dd:a5cf    xlat
    79dd:a5d1    or        al,al
    79dd:a5d3    jns       A5A0
    79dd:a5d5    dec       si
    79dd:a5d6    mov       cl,01
    79dd:a5d8    add       cl,A0
    79dd:a5db    push      cx
    79dd:a5dc    lodsw
    79dd:a5dd    cmp       al,2C
    79dd:a5df    je        A5E4
    79dd:a5e1    jmp       IBTERR
    79dd:a5e4    cmp       ah,23
    79dd:a5e7    je        A5EC
    79dd:a5e9    jmp       REGNERR1
    79dd:a5ec    call      CONVEXPRESS
    79dd:a5ef    pop       dx
    79dd:a5f0    cmp       cx,80
    79dd:a5f3    jge       A5F8
    79dd:a5f5    jmp       REGNERR
    79dd:a5f8    cmp       cx,7F
    79dd:a5fb    jle       A600
    79dd:a5fd    jmp       REGNERR
    79dd:a600    test      byte ptr ss:[0ACE],C0
    79dd:a606    je        A67E
    79dd:a608    test      byte ptr ss:[0ACE],40
    79dd:a60e    jne       A63B
    79dd:a610    push      es
    79dd:a611    push      bp
    79dd:a612    mov       es,word ptr ss:[0AC5]
    79dd:a617    mov       bp,word ptr ss:[0AC9]
    79dd:a61c    mov       word ptr es:[bp+06],di
    79dd:a620    mov       word ptr es:[bp+02],0000
    79dd:a626    add       bp,15
    79dd:a629    mov       word ptr ss:[0AC7],bp
    79dd:a62e    cmp       bp,7F00
    79dd:a632    jb        A637
    79dd:a634    call      MOREFR
    79dd:a637    pop       bp
    79dd:a638    pop       es
    79dd:a639    jmp       A67E
    79dd:a63b    push      es
    79dd:a63c    push      bp
    79dd:a63d    push      cx
    79dd:a63e    push      ax
    79dd:a63f    mov       es,word ptr ss:[13A6]
    79dd:a644    mov       bp,word ptr ss:[13A8]
    79dd:a649    mov       ax,di
    79dd:a64b    sub       ax,word ptr ss:[13B4]
    79dd:a650    xor       cx,cx
    79dd:a652    add       ax,word ptr ss:[13BE]
    79dd:a657    adc       cx,word ptr ss:[13BC]
    79dd:a65c    mov       word ptr es:[bp+00],ax
    79dd:a660    mov       word ptr es:[bp+02],cx
    79dd:a664    mov       byte ptr es:[bp+04],00
    79dd:a669    add       bp,05
    79dd:a66c    mov       word ptr ss:[13A8],bp
    79dd:a671    cmp       bp,3F00
    79dd:a675    jb        A67A
    79dd:a677    call      MOREEXT
    79dd:a67a    pop       ax
    79dd:a67b    pop       cx
    79dd:a67c    pop       bp
    79dd:a67d    pop       es
    79dd:a67e    mov       al,byte ptr [si]
    79dd:a680    xlat
    79dd:a682    or        al,al
    79dd:a684    js        A689
    79dd:a686    jmp       PM
    79dd:a689    mov       al,dl
    79dd:a68b    mov       ah,cl
    79dd:a68d    stosw
    79dd:a68e    ret
             IBTERR:
    79dd:a68f    dec       si
    79dd:a690    pop       cx
    79dd:a691    push      dx
    79dd:a692    mov       dx,8276
    79dd:a695    call      ERROR_ROUT
    79dd:a698    pop       dx
    79dd:a699    ret
             M_IWT:
    79dd:a69a    lodsb
    79dd:a69b    xlat
    79dd:a69d    or        al,al
    79dd:a69f    js        M_IWT
    79dd:a6a1    dec       si
    79dd:a6a2    lodsb
    79dd:a6a3    and       al,DF
    79dd:a6a5    cmp       al,52
    79dd:a6a7    jne       A6BC
    79dd:a6a9    lodsb
    79dd:a6aa    sub       al,30
    79dd:a6ac    js        A6BB
    79dd:a6ae    cmp       al,09
    79dd:a6b0    jg        A6BB
    79dd:a6b2    cmp       al,01
    79dd:a6b4    je        A6D9
    79dd:a6b6    mov       cl,al
    79dd:a6b8    jmp       A6F2
    79dd:a6ba    dec       si
    79dd:a6bb    dec       si
    79dd:a6bc    dec       si
    79dd:a6bd    push      dx
    79dd:a6be    call      CONVEXPRESS
    79dd:a6c1    pop       dx
    79dd:a6c2    test      byte ptr ss:[0ACE],04
    79dd:a6c8    jne       A6F2
    79dd:a6ca    jmp       GREGERR
    79dd:a6cd    cmp       ah,05
    79dd:a6d0    jg        A6BA
    79dd:a6d2    add       ah,0A
    79dd:a6d5    mov       cl,ah
    79dd:a6d7    jmp       A6F2
    79dd:a6d9    lodsb
    79dd:a6da    cmp       al,5D
    79dd:a6dc    je        A6F0
    79dd:a6de    cmp       al,2C
    79dd:a6e0    je        A6EF
    79dd:a6e2    mov       ah,al
    79dd:a6e4    sub       ah,30
    79dd:a6e7    jns       A6CD
    79dd:a6e9    xlat
    79dd:a6eb    or        al,al
    79dd:a6ed    jns       A6BA
    79dd:a6ef    dec       si
    79dd:a6f0    mov       cl,01
    79dd:a6f2    add       cl,F0
    79dd:a6f5    push      cx
    79dd:a6f6    lodsw
    79dd:a6f7    cmp       al,2C
    79dd:a6f9    jne       IBTERR
    79dd:a6fb    cmp       ah,23
    79dd:a6fe    je        A703
    79dd:a700    jmp       REGNERR1
    79dd:a703    call      CONVEXPRESS
    79dd:a706    or        dx,dx
    79dd:a708    je        A70D
    79dd:a70a    jmp       M_IWT2
    79dd:a70d    pop       dx
    79dd:a70e    test      byte ptr ss:[0ACE],C0
    79dd:a714    je        A78C
    79dd:a716    test      byte ptr ss:[0ACE],40
    79dd:a71c    jne       A749
    79dd:a71e    push      es
    79dd:a71f    push      bp
    79dd:a720    mov       es,word ptr ss:[0AC5]
    79dd:a725    mov       bp,word ptr ss:[0AC9]
    79dd:a72a    mov       word ptr es:[bp+06],di
    79dd:a72e    mov       word ptr es:[bp+02],0002
    79dd:a734    add       bp,15
    79dd:a737    mov       word ptr ss:[0AC7],bp
    79dd:a73c    cmp       bp,7F00
    79dd:a740    jb        A745
    79dd:a742    call      MOREFR
    79dd:a745    pop       bp
    79dd:a746    pop       es
    79dd:a747    jmp       A78C
    79dd:a749    push      es
    79dd:a74a    push      bp
    79dd:a74b    push      cx
    79dd:a74c    push      ax
    79dd:a74d    mov       es,word ptr ss:[13A6]
    79dd:a752    mov       bp,word ptr ss:[13A8]
    79dd:a757    mov       ax,di
    79dd:a759    sub       ax,word ptr ss:[13B4]
    79dd:a75e    xor       cx,cx
    79dd:a760    add       ax,word ptr ss:[13BE]
    79dd:a765    adc       cx,word ptr ss:[13BC]
    79dd:a76a    mov       word ptr es:[bp+00],ax
    79dd:a76e    mov       word ptr es:[bp+02],cx
    79dd:a772    mov       byte ptr es:[bp+04],02
    79dd:a777    add       bp,05
    79dd:a77a    mov       word ptr ss:[13A8],bp
    79dd:a77f    cmp       bp,3F00
    79dd:a783    jb        A788
    79dd:a785    call      MOREEXT
    79dd:a788    pop       ax
    79dd:a789    pop       cx
    79dd:a78a    pop       bp
    79dd:a78b    pop       es
    79dd:a78c    mov       al,byte ptr [si]
    79dd:a78e    xlat
    79dd:a790    or        al,al
    79dd:a792    js        A797
    79dd:a794    jmp       PM
    79dd:a797    mov       al,dl
    79dd:a799    stosb
    79dd:a79a    mov       ax,cx
    79dd:a79c    stosw
    79dd:a79d    ret
             M_IWT2:
    79dd:a79e    cmp       dx,FF
    79dd:a7a1    pop       dx
    79dd:a7a2    je        A7A7
    79dd:a7a4    jmp       REGNERR
    79dd:a7a7    mov       al,byte ptr [si]
    79dd:a7a9    xlat
    79dd:a7ab    or        al,al
    79dd:a7ad    js        A7B2
    79dd:a7af    jmp       PM
    79dd:a7b2    mov       al,dl
    79dd:a7b4    stosb
    79dd:a7b5    mov       ax,cx
    79dd:a7b7    stosw
    79dd:a7b8    ret
             M_INC:
    79dd:a7b9    mov       al,byte ptr [si]
    79dd:a7bb    xlat
    79dd:a7bd    or        al,al
    79dd:a7bf    js        A7C4
    79dd:a7c1    jmp       PM
    79dd:a7c4    lodsb
    79dd:a7c5    xlat
    79dd:a7c7    or        al,al
    79dd:a7c9    js        A7C4
    79dd:a7cb    dec       si
    79dd:a7cc    lodsb
    79dd:a7cd    and       al,DF
    79dd:a7cf    cmp       al,52
    79dd:a7d1    jne       A7E6
    79dd:a7d3    lodsb
    79dd:a7d4    sub       al,30
    79dd:a7d6    js        A7E5
    79dd:a7d8    cmp       al,09
    79dd:a7da    jg        A7E5
    79dd:a7dc    cmp       al,01
    79dd:a7de    je        A803
    79dd:a7e0    mov       cl,al
    79dd:a7e2    jmp       A81C
    79dd:a7e4    dec       si
    79dd:a7e5    dec       si
    79dd:a7e6    dec       si
    79dd:a7e7    push      dx
    79dd:a7e8    call      CONVEXPRESS
    79dd:a7eb    pop       dx
    79dd:a7ec    test      byte ptr ss:[0ACE],04
    79dd:a7f2    jne       A81C
    79dd:a7f4    jmp       GREGERR
    79dd:a7f7    cmp       ah,04
    79dd:a7fa    jg        A7E4
    79dd:a7fc    add       ah,0A
    79dd:a7ff    mov       cl,ah
    79dd:a801    jmp       A81C
    79dd:a803    lodsb
    79dd:a804    cmp       al,5D
    79dd:a806    je        A819
    79dd:a808    cmp       al,2C
    79dd:a80a    je        A819
    79dd:a80c    mov       ah,al
    79dd:a80e    sub       ah,30
    79dd:a811    jns       A7F7
    79dd:a813    xlat
    79dd:a815    or        al,al
    79dd:a817    jns       A7E4
    79dd:a819    mov       cl,01
    79dd:a81b    dec       si
    79dd:a81c    add       cl,D0
    79dd:a81f    mov       al,byte ptr [si]
    79dd:a821    xlat
    79dd:a823    or        al,al
    79dd:a825    js        A82A
    79dd:a827    jmp       PM
    79dd:a82a    mov       al,cl
    79dd:a82c    stosb
    79dd:a82d    ret
             M_JMP:
    79dd:a82e    mov       al,byte ptr [si]
    79dd:a830    xlat
    79dd:a832    or        al,al
    79dd:a834    js        A839
    79dd:a836    jmp       PM
    79dd:a839    lodsb
    79dd:a83a    xlat
    79dd:a83c    or        al,al
    79dd:a83e    js        A839
    79dd:a840    dec       si
    79dd:a841    lodsb
    79dd:a842    and       al,DF
    79dd:a844    cmp       al,52
    79dd:a846    jne       A85B
    79dd:a848    lodsb
    79dd:a849    sub       al,30
    79dd:a84b    js        A85A
    79dd:a84d    cmp       al,09
    79dd:a84f    jg        A85A
    79dd:a851    cmp       al,01
    79dd:a853    je        A878
    79dd:a855    mov       cl,al
    79dd:a857    jmp       A891
    79dd:a859    dec       si
    79dd:a85a    dec       si
    79dd:a85b    dec       si
    79dd:a85c    push      dx
    79dd:a85d    call      CONVEXPRESS
    79dd:a860    pop       dx
    79dd:a861    test      byte ptr ss:[0ACE],04
    79dd:a867    jne       A891
    79dd:a869    jmp       GREGERR
    79dd:a86c    cmp       ah,03
    79dd:a86f    jg        A859
    79dd:a871    add       ah,0A
    79dd:a874    mov       cl,ah
    79dd:a876    jmp       A891
    79dd:a878    lodsb
    79dd:a879    cmp       al,5D
    79dd:a87b    je        A88E
    79dd:a87d    cmp       al,2C
    79dd:a87f    je        A88E
    79dd:a881    mov       ah,al
    79dd:a883    sub       ah,30
    79dd:a886    jns       A86C
    79dd:a888    xlat
    79dd:a88a    or        al,al
    79dd:a88c    jns       A859
    79dd:a88e    mov       cl,01
    79dd:a890    dec       si
    79dd:a891    cmp       cl,08
    79dd:a894    jge       A899
    79dd:a896    jmp       GREGERR
    79dd:a899    add       cl,90
    79dd:a89c    mov       al,byte ptr [si]
    79dd:a89e    xlat
    79dd:a8a0    or        al,al
    79dd:a8a2    js        A8A7
    79dd:a8a4    jmp       PM
    79dd:a8a7    mov       al,cl
    79dd:a8a9    stosb
    79dd:a8aa    ret
             M_LDB:
    79dd:a8ab    mov       al,byte ptr [si]
    79dd:a8ad    xlat
    79dd:a8af    or        al,al
    79dd:a8b1    js        A8B6
    79dd:a8b3    jmp       PM
    79dd:a8b6    lodsb
    79dd:a8b7    xlat
    79dd:a8b9    or        al,al
    79dd:a8bb    js        A8B6
    79dd:a8bd    dec       si
    79dd:a8be    lodsb
    79dd:a8bf    cmp       al,5B
    79dd:a8c1    je        A8C6
    79dd:a8c3    jmp       M_SMERR
    79dd:a8c6    lodsb
    79dd:a8c7    and       al,DF
    79dd:a8c9    cmp       al,52
    79dd:a8cb    jne       A8E0
    79dd:a8cd    lodsb
    79dd:a8ce    sub       al,30
    79dd:a8d0    js        A8DF
    79dd:a8d2    cmp       al,09
    79dd:a8d4    jg        A8DF
    79dd:a8d6    cmp       al,01
    79dd:a8d8    je        A8FD
    79dd:a8da    mov       cl,al
    79dd:a8dc    jmp       A916
    79dd:a8de    dec       si
    79dd:a8df    dec       si
    79dd:a8e0    dec       si
    79dd:a8e1    push      dx
    79dd:a8e2    call      CONVEXPRESS
    79dd:a8e5    pop       dx
    79dd:a8e6    test      byte ptr ss:[0ACE],04
    79dd:a8ec    jne       A916
    79dd:a8ee    jmp       GREGERR
    79dd:a8f1    cmp       ah,01
    79dd:a8f4    jg        A8DE
    79dd:a8f6    add       ah,0A
    79dd:a8f9    mov       cl,ah
    79dd:a8fb    jmp       A916
    79dd:a8fd    lodsb
    79dd:a8fe    cmp       al,5D
    79dd:a900    je        A913
    79dd:a902    cmp       al,2C
    79dd:a904    je        A913
    79dd:a906    mov       ah,al
    79dd:a908    sub       ah,30
    79dd:a90b    jns       A8F1
    79dd:a90d    xlat
    79dd:a90f    or        al,al
    79dd:a911    jns       A8DE
    79dd:a913    mov       cl,01
    79dd:a915    dec       si
    79dd:a916    lodsb
    79dd:a917    cmp       al,5D
    79dd:a919    je        A91E
    79dd:a91b    jmp       M_SMERR1
    79dd:a91e    add       cl,40
    79dd:a921    mov       al,byte ptr [si]
    79dd:a923    xlat
    79dd:a925    or        al,al
    79dd:a927    js        A92C
    79dd:a929    jmp       PM
    79dd:a92c    mov       al,3D
    79dd:a92e    mov       ah,cl
    79dd:a930    stosw
    79dd:a931    ret
             M_LDW:
    79dd:a932    mov       al,byte ptr [si]
    79dd:a934    xlat
    79dd:a936    or        al,al
    79dd:a938    js        A93D
    79dd:a93a    jmp       PM
    79dd:a93d    lodsb
    79dd:a93e    xlat
    79dd:a940    or        al,al
    79dd:a942    js        A93D
    79dd:a944    dec       si
    79dd:a945    lodsb
    79dd:a946    cmp       al,5B
    79dd:a948    je        A94D
    79dd:a94a    jmp       M_SMERR
    79dd:a94d    lodsb
    79dd:a94e    and       al,DF
    79dd:a950    cmp       al,52
    79dd:a952    jne       A967
    79dd:a954    lodsb
    79dd:a955    sub       al,30
    79dd:a957    js        A966
    79dd:a959    cmp       al,09
    79dd:a95b    jg        A966
    79dd:a95d    cmp       al,01
    79dd:a95f    je        A984
    79dd:a961    mov       cl,al
    79dd:a963    jmp       A99D
    79dd:a965    dec       si
    79dd:a966    dec       si
    79dd:a967    dec       si
    79dd:a968    push      dx
    79dd:a969    call      CONVEXPRESS
    79dd:a96c    pop       dx
    79dd:a96d    test      byte ptr ss:[0ACE],04
    79dd:a973    jne       A99D
    79dd:a975    jmp       GREGERR
    79dd:a978    cmp       ah,01
    79dd:a97b    jg        A965
    79dd:a97d    add       ah,0A
    79dd:a980    mov       cl,ah
    79dd:a982    jmp       A99D
    79dd:a984    lodsb
    79dd:a985    cmp       al,5D
    79dd:a987    je        A99A
    79dd:a989    cmp       al,2C
    79dd:a98b    je        A99A
    79dd:a98d    mov       ah,al
    79dd:a98f    sub       ah,30
    79dd:a992    jns       A978
    79dd:a994    xlat
    79dd:a996    or        al,al
    79dd:a998    jns       A965
    79dd:a99a    mov       cl,01
    79dd:a99c    dec       si
    79dd:a99d    lodsb
    79dd:a99e    cmp       al,5D
    79dd:a9a0    je        A9A5
    79dd:a9a2    jmp       M_SMERR1
    79dd:a9a5    add       cl,40
    79dd:a9a8    mov       al,byte ptr [si]
    79dd:a9aa    xlat
    79dd:a9ac    or        al,al
    79dd:a9ae    js        A9B3
    79dd:a9b0    jmp       PM
    79dd:a9b3    mov       al,cl
    79dd:a9b5    stosb
    79dd:a9b6    ret
             M_LEA:
    79dd:a9b7    mov       al,byte ptr [si]
    79dd:a9b9    xlat
    79dd:a9bb    or        al,al
    79dd:a9bd    js        A9C2
    79dd:a9bf    jmp       PM
    79dd:a9c2    lodsb
    79dd:a9c3    xlat
    79dd:a9c5    or        al,al
    79dd:a9c7    js        A9C2
    79dd:a9c9    dec       si
    79dd:a9ca    lodsb
    79dd:a9cb    and       al,DF
    79dd:a9cd    cmp       al,52
    79dd:a9cf    jne       A9E4
    79dd:a9d1    lodsb
    79dd:a9d2    sub       al,30
    79dd:a9d4    js        A9E3
    79dd:a9d6    cmp       al,09
    79dd:a9d8    jg        A9E3
    79dd:a9da    cmp       al,01
    79dd:a9dc    je        AA01
    79dd:a9de    mov       cl,al
    79dd:a9e0    jmp       AA1A
    79dd:a9e2    dec       si
    79dd:a9e3    dec       si
    79dd:a9e4    dec       si
    79dd:a9e5    push      dx
    79dd:a9e6    call      CONVEXPRESS
    79dd:a9e9    pop       dx
    79dd:a9ea    test      byte ptr ss:[0ACE],04
    79dd:a9f0    jne       AA1A
    79dd:a9f2    jmp       GREGERR
    79dd:a9f5    cmp       ah,05
    79dd:a9f8    jg        A9E2
    79dd:a9fa    add       ah,0A
    79dd:a9fd    mov       cl,ah
    79dd:a9ff    jmp       AA1A
    79dd:aa01    lodsb
    79dd:aa02    cmp       al,5D
    79dd:aa04    je        AA18
    79dd:aa06    cmp       al,2C
    79dd:aa08    je        AA17
    79dd:aa0a    mov       ah,al
    79dd:aa0c    sub       ah,30
    79dd:aa0f    jns       A9F5
    79dd:aa11    xlat
    79dd:aa13    or        al,al
    79dd:aa15    jns       A9E2
    79dd:aa17    dec       si
    79dd:aa18    mov       cl,01
    79dd:aa1a    add       cl,F0
    79dd:aa1d    push      cx
    79dd:aa1e    lodsb
    79dd:aa1f    cmp       al,2C
    79dd:aa21    je        AA26
    79dd:aa23    jmp       IBTERR
    79dd:aa26    call      CONVEXPRESS
    79dd:aa29    and       cx,FF
    79dd:aa2c    or        dx,dx
    79dd:aa2e    je        AA33
    79dd:aa30    jmp       M_IWT2
    79dd:aa33    pop       dx
    79dd:aa34    test      byte ptr ss:[0ACE],C0
    79dd:aa3a    je        AAB2
    79dd:aa3c    test      byte ptr ss:[0ACE],40
    79dd:aa42    jne       AA6F
    79dd:aa44    push      es
    79dd:aa45    push      bp
    79dd:aa46    mov       es,word ptr ss:[0AC5]
    79dd:aa4b    mov       bp,word ptr ss:[0AC9]
    79dd:aa50    mov       word ptr es:[bp+06],di
    79dd:aa54    mov       word ptr es:[bp+02],0002
    79dd:aa5a    add       bp,15
    79dd:aa5d    mov       word ptr ss:[0AC7],bp
    79dd:aa62    cmp       bp,7F00
    79dd:aa66    jb        AA6B
    79dd:aa68    call      MOREFR
    79dd:aa6b    pop       bp
    79dd:aa6c    pop       es
    79dd:aa6d    jmp       AAB2
    79dd:aa6f    push      es
    79dd:aa70    push      bp
    79dd:aa71    push      cx
    79dd:aa72    push      ax
    79dd:aa73    mov       es,word ptr ss:[13A6]
    79dd:aa78    mov       bp,word ptr ss:[13A8]
    79dd:aa7d    mov       ax,di
    79dd:aa7f    sub       ax,word ptr ss:[13B4]
    79dd:aa84    xor       cx,cx
    79dd:aa86    add       ax,word ptr ss:[13BE]
    79dd:aa8b    adc       cx,word ptr ss:[13BC]
    79dd:aa90    mov       word ptr es:[bp+00],ax
    79dd:aa94    mov       word ptr es:[bp+02],cx
    79dd:aa98    mov       byte ptr es:[bp+04],02
    79dd:aa9d    add       bp,05
    79dd:aaa0    mov       word ptr ss:[13A8],bp
    79dd:aaa5    cmp       bp,3F00
    79dd:aaa9    jb        AAAE
    79dd:aaab    call      MOREEXT
    79dd:aaae    pop       ax
    79dd:aaaf    pop       cx
    79dd:aab0    pop       bp
    79dd:aab1    pop       es
    79dd:aab2    mov       al,byte ptr [si]
    79dd:aab4    xlat
    79dd:aab6    or        al,al
    79dd:aab8    js        AABD
    79dd:aaba    jmp       PM
    79dd:aabd    mov       al,dl
    79dd:aabf    stosb
    79dd:aac0    mov       ax,cx
    79dd:aac2    stosw
    79dd:aac3    ret
             M_LJM:
    79dd:aac4    lodsb
    79dd:aac5    and       al,DF
    79dd:aac7    cmp       al,50
    79dd:aac9    je        AACE
    79dd:aacb    jmp       PM
    79dd:aace    mov       al,byte ptr [si]
    79dd:aad0    xlat
    79dd:aad2    or        al,al
    79dd:aad4    js        AAD9
    79dd:aad6    jmp       PM
    79dd:aad9    lodsb
    79dd:aada    xlat
    79dd:aadc    or        al,al
    79dd:aade    js        AAD9
    79dd:aae0    dec       si
    79dd:aae1    lodsb
    79dd:aae2    and       al,DF
    79dd:aae4    cmp       al,52
    79dd:aae6    jne       AAFB
    79dd:aae8    lodsb
    79dd:aae9    sub       al,30
    79dd:aaeb    js        AAFA
    79dd:aaed    cmp       al,09
    79dd:aaef    jg        AAFA
    79dd:aaf1    cmp       al,01
    79dd:aaf3    je        AB18
    79dd:aaf5    mov       cl,al
    79dd:aaf7    jmp       AB31
    79dd:aaf9    dec       si
    79dd:aafa    dec       si
    79dd:aafb    dec       si
    79dd:aafc    push      dx
    79dd:aafd    call      CONVEXPRESS
    79dd:ab00    pop       dx
    79dd:ab01    test      byte ptr ss:[0ACE],04
    79dd:ab07    jne       AB31
    79dd:ab09    jmp       GREGERR
    79dd:ab0c    cmp       ah,03
    79dd:ab0f    jg        AAF9
    79dd:ab11    add       ah,0A
    79dd:ab14    mov       cl,ah
    79dd:ab16    jmp       AB31
    79dd:ab18    lodsb
    79dd:ab19    cmp       al,5D
    79dd:ab1b    je        AB2E
    79dd:ab1d    cmp       al,2C
    79dd:ab1f    je        AB2E
    79dd:ab21    mov       ah,al
    79dd:ab23    sub       ah,30
    79dd:ab26    jns       AB0C
    79dd:ab28    xlat
    79dd:ab2a    or        al,al
    79dd:ab2c    jns       AAF9
    79dd:ab2e    mov       cl,01
    79dd:ab30    dec       si
    79dd:ab31    cmp       cl,07
    79dd:ab34    ja        AB39
    79dd:ab36    jmp       GREGERR
    79dd:ab39    add       cl,90
    79dd:ab3c    mov       al,byte ptr [si]
    79dd:ab3e    xlat
    79dd:ab40    or        al,al
    79dd:ab42    js        AB47
    79dd:ab44    jmp       PM
    79dd:ab47    mov       al,3D
    79dd:ab49    mov       ah,cl
    79dd:ab4b    stosw
    79dd:ab4c    ret
             M_LM:
    79dd:ab4d    dec       si
    79dd:ab4e    mov       al,byte ptr [si]
    79dd:ab50    xlat
    79dd:ab52    or        al,al
    79dd:ab54    js        AB59
    79dd:ab56    jmp       PM
    79dd:ab59    lodsb
    79dd:ab5a    xlat
    79dd:ab5c    or        al,al
    79dd:ab5e    js        AB59
    79dd:ab60    dec       si
    79dd:ab61    lodsb
    79dd:ab62    and       al,DF
    79dd:ab64    cmp       al,52
    79dd:ab66    jne       AB7B
    79dd:ab68    lodsb
    79dd:ab69    sub       al,30
    79dd:ab6b    js        AB7A
    79dd:ab6d    cmp       al,09
    79dd:ab6f    jg        AB7A
    79dd:ab71    cmp       al,01
    79dd:ab73    je        AB98
    79dd:ab75    mov       cl,al
    79dd:ab77    jmp       ABB1
    79dd:ab79    dec       si
    79dd:ab7a    dec       si
    79dd:ab7b    dec       si
    79dd:ab7c    push      dx
    79dd:ab7d    call      CONVEXPRESS
    79dd:ab80    pop       dx
    79dd:ab81    test      byte ptr ss:[0ACE],04
    79dd:ab87    jne       ABB1
    79dd:ab89    jmp       GREGERR
    79dd:ab8c    cmp       ah,05
    79dd:ab8f    jg        AB79
    79dd:ab91    add       ah,0A
    79dd:ab94    mov       cl,ah
    79dd:ab96    jmp       ABB1
    79dd:ab98    lodsb
    79dd:ab99    cmp       al,5D
    79dd:ab9b    je        ABAF
    79dd:ab9d    cmp       al,2C
    79dd:ab9f    je        ABAE
    79dd:aba1    mov       ah,al
    79dd:aba3    sub       ah,30
    79dd:aba6    jns       AB8C
    79dd:aba8    xlat
    79dd:abaa    or        al,al
    79dd:abac    jns       AB79
    79dd:abae    dec       si
    79dd:abaf    mov       cl,01
    79dd:abb1    add       cl,F0
    79dd:abb4    mov       ch,3D
    79dd:abb6    xchg      ch,cl
    79dd:abb8    push      cx
    79dd:abb9    lodsw
    79dd:abba    cmp       al,2C
    79dd:abbc    je        ABC1
    79dd:abbe    jmp       IBTERR
    79dd:abc1    cmp       ah,5B
    79dd:abc4    je        ABC9
    79dd:abc6    jmp       M_LMERR
    79dd:abc9    call      CONVEXPRESS
    79dd:abcc    lodsb
    79dd:abcd    cmp       al,5D
    79dd:abcf    je        ABD4
    79dd:abd1    jmp       M_LMERR1
    79dd:abd4    pop       dx
    79dd:abd5    test      byte ptr ss:[0ACE],C0
    79dd:abdb    jne       ABE0
    79dd:abdd    jmp       AC64
    79dd:abe0    test      byte ptr ss:[0ACE],40
    79dd:abe6    jne       AC17
    79dd:abe8    push      es
    79dd:abe9    push      bp
    79dd:abea    mov       es,word ptr ss:[0AC5]
    79dd:abef    mov       bp,word ptr ss:[0AC9]
    79dd:abf4    mov       word ptr es:[bp+06],di
    79dd:abf8    inc       word ptr es:[bp+06]
    79dd:abfc    mov       word ptr es:[bp+02],0002
    79dd:ac02    add       bp,15
    79dd:ac05    mov       word ptr ss:[0AC7],bp
    79dd:ac0a    cmp       bp,7F00
    79dd:ac0e    jb        AC13
    79dd:ac10    call      MOREFR
    79dd:ac13    pop       bp
    79dd:ac14    pop       es
    79dd:ac15    jmp       AC64
    79dd:ac17    push      es
    79dd:ac18    push      bp
    79dd:ac19    push      cx
    79dd:ac1a    push      ax
    79dd:ac1b    mov       es,word ptr ss:[13A6]
    79dd:ac20    mov       bp,word ptr ss:[13A8]
    79dd:ac25    mov       ax,di
    79dd:ac27    sub       ax,word ptr ss:[13B4]
    79dd:ac2c    xor       cx,cx
    79dd:ac2e    add       ax,word ptr ss:[13BE]
    79dd:ac33    adc       cx,word ptr ss:[13BC]
    79dd:ac38    mov       word ptr es:[bp+00],ax
    79dd:ac3c    mov       word ptr es:[bp+02],cx
    79dd:ac40    mov       byte ptr es:[bp+04],02
    79dd:ac45    add       word ptr es:[bp+00],01
    79dd:ac4a    adc       word ptr es:[bp+02],00
    79dd:ac4f    add       bp,05
    79dd:ac52    mov       word ptr ss:[13A8],bp
    79dd:ac57    cmp       bp,3F00
    79dd:ac5b    jb        AC60
    79dd:ac5d    call      MOREEXT
    79dd:ac60    pop       ax
    79dd:ac61    pop       cx
    79dd:ac62    pop       bp
    79dd:ac63    pop       es
    79dd:ac64    mov       al,byte ptr [si]
    79dd:ac66    xlat
    79dd:ac68    or        al,al
    79dd:ac6a    js        AC6F
    79dd:ac6c    jmp       PM
    79dd:ac6f    mov       ax,dx
    79dd:ac71    stosw
    79dd:ac72    mov       ax,cx
    79dd:ac74    stosw
    79dd:ac75    ret
             M_LMERR:
    79dd:ac76    pop       cx
    79dd:ac77    push      dx
    79dd:ac78    mov       dx,8285
    79dd:ac7b    call      ERROR_ROUT
    79dd:ac7e    pop       dx
    79dd:ac7f    ret
             M_LMERR1:
    79dd:ac80    pop       cx
    79dd:ac81    dec       si
    79dd:ac82    push      dx
    79dd:ac83    mov       dx,8291
    79dd:ac86    call      ERROR_ROUT
    79dd:ac89    pop       dx
    79dd:ac8a    ret
             M_LINK:
    79dd:ac8b    lodsw
    79dd:ac8c    and       al,DF
    79dd:ac8e    cmp       al,4B
    79dd:ac90    je        AC95
    79dd:ac92    jmp       PM
    79dd:ac95    mov       al,ah
    79dd:ac97    xlat
    79dd:ac99    or        al,al
    79dd:ac9b    js        ACA0
    79dd:ac9d    jmp       PM
    79dd:aca0    lodsb
    79dd:aca1    xlat
    79dd:aca3    or        al,al
    79dd:aca5    js        ACA0
    79dd:aca7    dec       si
    79dd:aca8    lodsb
    79dd:aca9    cmp       al,23
    79dd:acab    je        ACB0
    79dd:acad    jmp       REGNERR
    79dd:acb0    lodsb
    79dd:acb1    cmp       al,31
    79dd:acb3    je        M_LNK1
    79dd:acb5    cmp       al,32
    79dd:acb7    je        M_LNK2
    79dd:acb9    cmp       al,33
    79dd:acbb    je        M_LNK3
    79dd:acbd    cmp       al,34
    79dd:acbf    je        ACC4
    79dd:acc1    jmp       PM
    79dd:acc4    mov       al,byte ptr [si]
    79dd:acc6    xlat
    79dd:acc8    or        al,al
    79dd:acca    js        ACCF
    79dd:accc    jmp       PM
    79dd:accf    mov       al,94
    79dd:acd1    stosb
    79dd:acd2    ret
             M_LNK1:
    79dd:acd3    mov       al,byte ptr [si]
    79dd:acd5    xlat
    79dd:acd7    or        al,al
    79dd:acd9    js        ACDE
    79dd:acdb    jmp       PM
    79dd:acde    mov       al,91
    79dd:ace0    stosb
    79dd:ace1    ret
             M_LNK2:
    79dd:ace2    mov       al,byte ptr [si]
    79dd:ace4    xlat
    79dd:ace6    or        al,al
    79dd:ace8    js        ACED
    79dd:acea    jmp       PM
    79dd:aced    mov       al,92
    79dd:acef    stosb
    79dd:acf0    ret
             M_LNK3:
    79dd:acf1    mov       al,byte ptr [si]
    79dd:acf3    xlat
    79dd:acf5    or        al,al
    79dd:acf7    js        ACFC
    79dd:acf9    jmp       PM
    79dd:acfc    mov       al,93
    79dd:acfe    stosb
    79dd:acff    ret
             M_LMU:
    79dd:ad00    lodsw
    79dd:ad01    and       ax,DFDF
    79dd:ad04    cmp       ax,544C
    79dd:ad07    je        AD0C
    79dd:ad09    jmp       PM
    79dd:ad0c    mov       al,byte ptr [si]
    79dd:ad0e    xlat
    79dd:ad10    or        al,al
    79dd:ad12    js        AD17
    79dd:ad14    jmp       PM
    79dd:ad17    mov       al,byte ptr [si]
    79dd:ad19    xlat
    79dd:ad1b    or        al,al
    79dd:ad1d    js        AD22
    79dd:ad1f    jmp       PM
    79dd:ad22    mov       al,3D
    79dd:ad24    mov       ah,9F
    79dd:ad26    stosw
    79dd:ad27    ret
             M_LMS:
    79dd:ad28    mov       al,byte ptr [si]
    79dd:ad2a    xlat
    79dd:ad2c    or        al,al
    79dd:ad2e    js        AD33
    79dd:ad30    jmp       PM
    79dd:ad33    lodsb
    79dd:ad34    xlat
    79dd:ad36    or        al,al
    79dd:ad38    js        AD33
    79dd:ad3a    dec       si
    79dd:ad3b    lodsb
    79dd:ad3c    and       al,DF
    79dd:ad3e    cmp       al,52
    79dd:ad40    jne       AD55
    79dd:ad42    lodsb
    79dd:ad43    sub       al,30
    79dd:ad45    js        AD54
    79dd:ad47    cmp       al,09
    79dd:ad49    jg        AD54
    79dd:ad4b    cmp       al,01
    79dd:ad4d    je        AD72
    79dd:ad4f    mov       cl,al
    79dd:ad51    jmp       AD8B
    79dd:ad53    dec       si
    79dd:ad54    dec       si
    79dd:ad55    dec       si
    79dd:ad56    push      dx
    79dd:ad57    call      CONVEXPRESS
    79dd:ad5a    pop       dx
    79dd:ad5b    test      byte ptr ss:[0ACE],04
    79dd:ad61    jne       AD8B
    79dd:ad63    jmp       GREGERR
    79dd:ad66    cmp       ah,05
    79dd:ad69    jg        AD53
    79dd:ad6b    add       ah,0A
    79dd:ad6e    mov       cl,ah
    79dd:ad70    jmp       AD8B
    79dd:ad72    lodsb
    79dd:ad73    cmp       al,5D
    79dd:ad75    je        AD89
    79dd:ad77    cmp       al,2C
    79dd:ad79    je        AD88
    79dd:ad7b    mov       ah,al
    79dd:ad7d    sub       ah,30
    79dd:ad80    jns       AD66
    79dd:ad82    xlat
    79dd:ad84    or        al,al
    79dd:ad86    jns       AD53
    79dd:ad88    dec       si
    79dd:ad89    mov       cl,01
    79dd:ad8b    add       cl,A0
    79dd:ad8e    mov       ch,3D
    79dd:ad90    xchg      ch,cl
    79dd:ad92    push      cx
    79dd:ad93    lodsw
    79dd:ad94    cmp       al,2C
    79dd:ad96    je        AD9B
    79dd:ad98    jmp       IBTERR
    79dd:ad9b    cmp       ah,5B
    79dd:ad9e    je        ADA3
    79dd:ada0    jmp       M_LMERR
    79dd:ada3    call      CONVEXPRESS
    79dd:ada6    lodsb
    79dd:ada7    cmp       al,5D
    79dd:ada9    je        ADAE
    79dd:adab    jmp       M_LMERR1
    79dd:adae    cmp       cx,00
    79dd:adb1    jns       ADB6
    79dd:adb3    jmp       REGNERR1
    79dd:adb6    cmp       cx,01FF
    79dd:adba    jle       ADBF
    79dd:adbc    jmp       REGNERR1
    79dd:adbf    test      cx,0001
    79dd:adc3    je        ADC8
    79dd:adc5    jmp       E_LMSODD
    79dd:adc8    shr       cx,1
    79dd:adca    pop       ax
    79dd:adcb    test      byte ptr ss:[0ACE],C0
    79dd:add1    jne       ADD6
    79dd:add3    jmp       AE5A
    79dd:add6    test      byte ptr ss:[0ACE],40
    79dd:addc    jne       AE0D
    79dd:adde    push      es
    79dd:addf    push      bp
    79dd:ade0    mov       es,word ptr ss:[0AC5]
    79dd:ade5    mov       bp,word ptr ss:[0AC9]
    79dd:adea    mov       word ptr es:[bp+06],di
    79dd:adee    inc       word ptr es:[bp+06]
    79dd:adf2    mov       word ptr es:[bp+02],0012
    79dd:adf8    add       bp,15
    79dd:adfb    mov       word ptr ss:[0AC7],bp
    79dd:ae00    cmp       bp,7F00
    79dd:ae04    jb        AE09
    79dd:ae06    call      MOREFR
    79dd:ae09    pop       bp
    79dd:ae0a    pop       es
    79dd:ae0b    jmp       AE5A
    79dd:ae0d    push      es
    79dd:ae0e    push      bp
    79dd:ae0f    push      cx
    79dd:ae10    push      ax
    79dd:ae11    mov       es,word ptr ss:[13A6]
    79dd:ae16    mov       bp,word ptr ss:[13A8]
    79dd:ae1b    mov       ax,di
    79dd:ae1d    sub       ax,word ptr ss:[13B4]
    79dd:ae22    xor       cx,cx
    79dd:ae24    add       ax,word ptr ss:[13BE]
    79dd:ae29    adc       cx,word ptr ss:[13BC]
    79dd:ae2e    mov       word ptr es:[bp+00],ax
    79dd:ae32    mov       word ptr es:[bp+02],cx
    79dd:ae36    mov       byte ptr es:[bp+04],12
    79dd:ae3b    add       word ptr es:[bp+00],01
    79dd:ae40    adc       word ptr es:[bp+02],00
    79dd:ae45    add       bp,05
    79dd:ae48    mov       word ptr ss:[13A8],bp
    79dd:ae4d    cmp       bp,3F00
    79dd:ae51    jb        AE56
    79dd:ae53    call      MOREEXT
    79dd:ae56    pop       ax
    79dd:ae57    pop       cx
    79dd:ae58    pop       bp
    79dd:ae59    pop       es
    79dd:ae5a    stosw
    79dd:ae5b    mov       al,byte ptr [si]
    79dd:ae5d    xlat
    79dd:ae5f    or        al,al
    79dd:ae61    js        AE66
    79dd:ae63    jmp       PM
    79dd:ae66    mov       al,cl
    79dd:ae68    stosb
    79dd:ae69    ret
             E_LMSODD:
    79dd:ae6a    push      dx
    79dd:ae6b    mov       dx,85C4
    79dd:ae6e    call      ERROR_ROUT
    79dd:ae71    pop       dx
    79dd:ae72    ret
             M_LOB:
    79dd:ae73    mov       al,byte ptr [si]
    79dd:ae75    xlat
    79dd:ae77    or        al,al
    79dd:ae79    js        AE7E
    79dd:ae7b    jmp       PM
    79dd:ae7e    mov       al,byte ptr [si]
    79dd:ae80    xlat
    79dd:ae82    or        al,al
    79dd:ae84    js        AE89
    79dd:ae86    jmp       PM
    79dd:ae89    mov       al,9E
    79dd:ae8b    stosb
    79dd:ae8c    ret
             M_LOO:
    79dd:ae8d    lodsb
    79dd:ae8e    and       al,DF
    79dd:ae90    cmp       al,50
    79dd:ae92    je        AE97
    79dd:ae94    jmp       PM
    79dd:ae97    mov       al,byte ptr [si]
    79dd:ae99    xlat
    79dd:ae9b    or        al,al
    79dd:ae9d    js        AEA2
    79dd:ae9f    jmp       PM
    79dd:aea2    mov       al,byte ptr [si]
    79dd:aea4    xlat
    79dd:aea6    or        al,al
    79dd:aea8    js        AEAD
    79dd:aeaa    jmp       PM
    79dd:aead    mov       al,3C
    79dd:aeaf    stosb
    79dd:aeb0    ret
             M_LSR:
    79dd:aeb1    mov       al,byte ptr [si]
    79dd:aeb3    xlat
    79dd:aeb5    or        al,al
    79dd:aeb7    js        AEBC
    79dd:aeb9    jmp       PM
    79dd:aebc    mov       al,byte ptr [si]
    79dd:aebe    xlat
    79dd:aec0    or        al,al
    79dd:aec2    js        AEC7
    79dd:aec4    jmp       PM
    79dd:aec7    mov       al,03
    79dd:aec9    stosb
    79dd:aeca    ret
             M_MER:
    79dd:aecb    lodsw
    79dd:aecc    and       ax,DFDF
    79dd:aecf    cmp       ax,4547
    79dd:aed2    je        AED7
    79dd:aed4    jmp       PM
    79dd:aed7    mov       al,byte ptr [si]
    79dd:aed9    xlat
    79dd:aedb    or        al,al
    79dd:aedd    js        AEE2
    79dd:aedf    jmp       PM
    79dd:aee2    mov       al,byte ptr [si]
    79dd:aee4    xlat
    79dd:aee6    or        al,al
    79dd:aee8    js        AEED
    79dd:aeea    jmp       PM
    79dd:aeed    mov       al,70
    79dd:aeef    stosb
    79dd:aef0    ret
             M_MOV:
    79dd:aef1    lodsb
    79dd:aef2    and       al,DF
    79dd:aef4    cmp       al,45
    79dd:aef6    je        AEFB
    79dd:aef8    jmp       PM
    79dd:aefb    mov       al,byte ptr [si]
    79dd:aefd    xlat
    79dd:aeff    or        al,al
    79dd:af01    js        M_MOVE
    79dd:af03    cmp       al,53
    79dd:af05    jne       AF0A
    79dd:af07    jmp       M_MOVES
    79dd:af0a    cmp       al,57
    79dd:af0c    jne       AF11
    79dd:af0e    jmp       M_MOVEW
    79dd:af11    cmp       al,42
    79dd:af13    jne       M_MOVE
    79dd:af15    jmp       M_MOVEB
             M_MOVE:
    79dd:af18    lodsb
    79dd:af19    xlat
    79dd:af1b    or        al,al
    79dd:af1d    js        M_MOVE
    79dd:af1f    dec       si
    79dd:af20    mov       al,byte ptr [si]
    79dd:af22    cmp       al,5B
    79dd:af24    jne       AF29
    79dd:af26    jmp       M_MVSQ
    79dd:af29    lodsb
    79dd:af2a    and       al,DF
    79dd:af2c    cmp       al,52
    79dd:af2e    jne       AF43
    79dd:af30    lodsb
    79dd:af31    sub       al,30
    79dd:af33    js        AF42
    79dd:af35    cmp       al,09
    79dd:af37    jg        AF42
    79dd:af39    cmp       al,01
    79dd:af3b    je        AF60
    79dd:af3d    mov       cl,al
    79dd:af3f    jmp       AF79
    79dd:af41    dec       si
    79dd:af42    dec       si
    79dd:af43    dec       si
    79dd:af44    push      dx
    79dd:af45    call      CONVEXPRESS
    79dd:af48    pop       dx
    79dd:af49    test      byte ptr ss:[0ACE],04
    79dd:af4f    jne       AF79
    79dd:af51    jmp       GREGERR
    79dd:af54    cmp       ah,05
    79dd:af57    jg        AF41
    79dd:af59    add       ah,0A
    79dd:af5c    mov       cl,ah
    79dd:af5e    jmp       AF79
    79dd:af60    lodsb
    79dd:af61    cmp       al,5D
    79dd:af63    je        AF77
    79dd:af65    cmp       al,2C
    79dd:af67    je        AF76
    79dd:af69    mov       ah,al
    79dd:af6b    sub       ah,30
    79dd:af6e    jns       AF54
    79dd:af70    xlat
    79dd:af72    or        al,al
    79dd:af74    jns       AF41
    79dd:af76    dec       si
    79dd:af77    mov       cl,01
    79dd:af79    push      cx
    79dd:af7a    lodsb
    79dd:af7b    cmp       al,2C
    79dd:af7d    je        AF82
    79dd:af7f    jmp       M_MOVESERR
    79dd:af82    lodsb
    79dd:af83    cmp       al,23
    79dd:af85    je        M_MVHA
    79dd:af87    cmp       al,5B
    79dd:af89    jne       AF8E
    79dd:af8b    jmp       M_MVSB
    79dd:af8e    dec       si
    79dd:af8f    pop       dx
    79dd:af90    lodsb
    79dd:af91    and       al,DF
    79dd:af93    cmp       al,52
    79dd:af95    jne       AFAA
    79dd:af97    lodsb
    79dd:af98    sub       al,30
    79dd:af9a    js        AFA9
    79dd:af9c    cmp       al,09
    79dd:af9e    jg        AFA9
    79dd:afa0    cmp       al,01
    79dd:afa2    je        AFC7
    79dd:afa4    mov       cl,al
    79dd:afa6    jmp       AFE0
    79dd:afa8    dec       si
    79dd:afa9    dec       si
    79dd:afaa    dec       si
    79dd:afab    push      dx
    79dd:afac    call      CONVEXPRESS
    79dd:afaf    pop       dx
    79dd:afb0    test      byte ptr ss:[0ACE],04
    79dd:afb6    jne       AFE0
    79dd:afb8    jmp       GREGERR
    79dd:afbb    cmp       ah,05
    79dd:afbe    jg        AFA8
    79dd:afc0    add       ah,0A
    79dd:afc3    mov       cl,ah
    79dd:afc5    jmp       AFE0
    79dd:afc7    lodsb
    79dd:afc8    cmp       al,5D
    79dd:afca    je        AFDE
    79dd:afcc    cmp       al,2C
    79dd:afce    je        AFDD
    79dd:afd0    mov       ah,al
    79dd:afd2    sub       ah,30
    79dd:afd5    jns       AFBB
    79dd:afd7    xlat
    79dd:afd9    or        al,al
    79dd:afdb    jns       AFA8
    79dd:afdd    dec       si
    79dd:afde    mov       cl,01
    79dd:afe0    add       cl,20
    79dd:afe3    add       dl,10
    79dd:afe6    mov       al,byte ptr [si]
    79dd:afe8    xlat
    79dd:afea    or        al,al
    79dd:afec    js        AFF1
    79dd:afee    jmp       PM
    79dd:aff1    mov       al,cl
    79dd:aff3    mov       ah,dl
    79dd:aff5    stosw
    79dd:aff6    ret
             M_MVHA:
    79dd:aff7    call      CONVEXPRESS
    79dd:affa    or        dx,dx
    79dd:affc    je        M_MVHA1
    79dd:affe    cmp       dx,FF
    79dd:b001    je        M_MVHA1
    79dd:b003    jmp       M_MOVERR2
             M_MVHA1:
    79dd:b006    pop       dx
    79dd:b007    cmp       cx,7F
    79dd:b00a    jle       B00F
    79dd:b00c    jmp       M_MVIWT
    79dd:b00f    cmp       cx,80
    79dd:b012    jge       B017
    79dd:b014    jmp       M_MVIWT
    79dd:b017    add       dl,A0
    79dd:b01a    test      byte ptr ss:[0ACE],C0
    79dd:b020    je        B098
    79dd:b022    test      byte ptr ss:[0ACE],40
    79dd:b028    jne       B055
    79dd:b02a    push      es
    79dd:b02b    push      bp
    79dd:b02c    mov       es,word ptr ss:[0AC5]
    79dd:b031    mov       bp,word ptr ss:[0AC9]
    79dd:b036    mov       word ptr es:[bp+06],di
    79dd:b03a    mov       word ptr es:[bp+02],0000
    79dd:b040    add       bp,15
    79dd:b043    mov       word ptr ss:[0AC7],bp
    79dd:b048    cmp       bp,7F00
    79dd:b04c    jb        B051
    79dd:b04e    call      MOREFR
    79dd:b051    pop       bp
    79dd:b052    pop       es
    79dd:b053    jmp       B098
    79dd:b055    push      es
    79dd:b056    push      bp
    79dd:b057    push      cx
    79dd:b058    push      ax
    79dd:b059    mov       es,word ptr ss:[13A6]
    79dd:b05e    mov       bp,word ptr ss:[13A8]
    79dd:b063    mov       ax,di
    79dd:b065    sub       ax,word ptr ss:[13B4]
    79dd:b06a    xor       cx,cx
    79dd:b06c    add       ax,word ptr ss:[13BE]
    79dd:b071    adc       cx,word ptr ss:[13BC]
    79dd:b076    mov       word ptr es:[bp+00],ax
    79dd:b07a    mov       word ptr es:[bp+02],cx
    79dd:b07e    mov       byte ptr es:[bp+04],00
    79dd:b083    add       bp,05
    79dd:b086    mov       word ptr ss:[13A8],bp
    79dd:b08b    cmp       bp,3F00
    79dd:b08f    jb        B094
    79dd:b091    call      MOREEXT
    79dd:b094    pop       ax
    79dd:b095    pop       cx
    79dd:b096    pop       bp
    79dd:b097    pop       es
    79dd:b098    mov       al,byte ptr [si]
    79dd:b09a    xlat
    79dd:b09c    or        al,al
    79dd:b09e    js        B0A3
    79dd:b0a0    jmp       PM
    79dd:b0a3    mov       al,dl
    79dd:b0a5    mov       ah,cl
    79dd:b0a7    stosw
    79dd:b0a8    ret
             M_MVIWT:
    79dd:b0a9    add       dl,F0
    79dd:b0ac    test      byte ptr ss:[0ACE],C0
    79dd:b0b2    je        B12A
    79dd:b0b4    test      byte ptr ss:[0ACE],40
    79dd:b0ba    jne       B0E7
    79dd:b0bc    push      es
    79dd:b0bd    push      bp
    79dd:b0be    mov       es,word ptr ss:[0AC5]
    79dd:b0c3    mov       bp,word ptr ss:[0AC9]
    79dd:b0c8    mov       word ptr es:[bp+06],di
    79dd:b0cc    mov       word ptr es:[bp+02],0002
    79dd:b0d2    add       bp,15
    79dd:b0d5    mov       word ptr ss:[0AC7],bp
    79dd:b0da    cmp       bp,7F00
    79dd:b0de    jb        B0E3
    79dd:b0e0    call      MOREFR
    79dd:b0e3    pop       bp
    79dd:b0e4    pop       es
    79dd:b0e5    jmp       B12A
    79dd:b0e7    push      es
    79dd:b0e8    push      bp
    79dd:b0e9    push      cx
    79dd:b0ea    push      ax
    79dd:b0eb    mov       es,word ptr ss:[13A6]
    79dd:b0f0    mov       bp,word ptr ss:[13A8]
    79dd:b0f5    mov       ax,di
    79dd:b0f7    sub       ax,word ptr ss:[13B4]
    79dd:b0fc    xor       cx,cx
    79dd:b0fe    add       ax,word ptr ss:[13BE]
    79dd:b103    adc       cx,word ptr ss:[13BC]
    79dd:b108    mov       word ptr es:[bp+00],ax
    79dd:b10c    mov       word ptr es:[bp+02],cx
    79dd:b110    mov       byte ptr es:[bp+04],02
    79dd:b115    add       bp,05
    79dd:b118    mov       word ptr ss:[13A8],bp
    79dd:b11d    cmp       bp,3F00
    79dd:b121    jb        B126
    79dd:b123    call      MOREEXT
    79dd:b126    pop       ax
    79dd:b127    pop       cx
    79dd:b128    pop       bp
    79dd:b129    pop       es
    79dd:b12a    mov       al,byte ptr [si]
    79dd:b12c    xlat
    79dd:b12e    or        al,al
    79dd:b130    js        B135
    79dd:b132    jmp       PM
    79dd:b135    mov       al,dl
    79dd:b137    stosb
    79dd:b138    mov       ax,cx
    79dd:b13a    stosw
    79dd:b13b    ret
             M_MVSB:
    79dd:b13c    call      CONVEXPRESS
    79dd:b13f    lodsb
    79dd:b140    cmp       al,5D
    79dd:b142    je        B147
    79dd:b144    jmp       MVSBERR
    79dd:b147    mov       dx,cx
    79dd:b149    pop       cx
    79dd:b14a    test      byte ptr ss:[0ACE],80
    79dd:b150    jne       M_MVLM
    79dd:b152    cmp       dx,0200
    79dd:b156    jge       M_MVLM
    79dd:b158    jmp       M_MVLMS
             M_MVLM:
    79dd:b15b    add       cl,F0
    79dd:b15e    mov       ch,3D
    79dd:b160    xchg      cl,ch
    79dd:b162    test      byte ptr ss:[0ACE],C0
    79dd:b168    jne       B16D
    79dd:b16a    jmp       B1F1
    79dd:b16d    test      byte ptr ss:[0ACE],40
    79dd:b173    jne       B1A4
    79dd:b175    push      es
    79dd:b176    push      bp
    79dd:b177    mov       es,word ptr ss:[0AC5]
    79dd:b17c    mov       bp,word ptr ss:[0AC9]
    79dd:b181    mov       word ptr es:[bp+06],di
    79dd:b185    inc       word ptr es:[bp+06]
    79dd:b189    mov       word ptr es:[bp+02],0002
    79dd:b18f    add       bp,15
    79dd:b192    mov       word ptr ss:[0AC7],bp
    79dd:b197    cmp       bp,7F00
    79dd:b19b    jb        B1A0
    79dd:b19d    call      MOREFR
    79dd:b1a0    pop       bp
    79dd:b1a1    pop       es
    79dd:b1a2    jmp       B1F1
    79dd:b1a4    push      es
    79dd:b1a5    push      bp
    79dd:b1a6    push      cx
    79dd:b1a7    push      ax
    79dd:b1a8    mov       es,word ptr ss:[13A6]
    79dd:b1ad    mov       bp,word ptr ss:[13A8]
    79dd:b1b2    mov       ax,di
    79dd:b1b4    sub       ax,word ptr ss:[13B4]
    79dd:b1b9    xor       cx,cx
    79dd:b1bb    add       ax,word ptr ss:[13BE]
    79dd:b1c0    adc       cx,word ptr ss:[13BC]
    79dd:b1c5    mov       word ptr es:[bp+00],ax
    79dd:b1c9    mov       word ptr es:[bp+02],cx
    79dd:b1cd    mov       byte ptr es:[bp+04],02
    79dd:b1d2    add       word ptr es:[bp+00],01
    79dd:b1d7    adc       word ptr es:[bp+02],00
    79dd:b1dc    add       bp,05
    79dd:b1df    mov       word ptr ss:[13A8],bp
    79dd:b1e4    cmp       bp,3F00
    79dd:b1e8    jb        B1ED
    79dd:b1ea    call      MOREEXT
    79dd:b1ed    pop       ax
    79dd:b1ee    pop       cx
    79dd:b1ef    pop       bp
    79dd:b1f0    pop       es
    79dd:b1f1    mov       al,byte ptr [si]
    79dd:b1f3    xlat
    79dd:b1f5    or        al,al
    79dd:b1f7    js        B1FC
    79dd:b1f9    jmp       PM
    79dd:b1fc    mov       ax,cx
    79dd:b1fe    stosw
    79dd:b1ff    mov       ax,dx
    79dd:b201    stosw
    79dd:b202    ret
             MVSBERR:
    79dd:b203    pop       cx
    79dd:b204    push      dx
    79dd:b205    mov       dx,8291
    79dd:b208    call      ERROR_ROUT
    79dd:b20b    pop       dx
    79dd:b20c    ret
             M_MVLMS:
    79dd:b20d    shr       dx,1
    79dd:b20f    add       cl,A0
    79dd:b212    mov       dh,cl
    79dd:b214    xchg      dl,dh
    79dd:b216    mov       cl,3D
    79dd:b218    test      byte ptr ss:[0ACE],C0
    79dd:b21e    jne       B223
    79dd:b220    jmp       B2A7
    79dd:b223    test      byte ptr ss:[0ACE],40
    79dd:b229    jne       B25A
    79dd:b22b    push      es
    79dd:b22c    push      bp
    79dd:b22d    mov       es,word ptr ss:[0AC5]
    79dd:b232    mov       bp,word ptr ss:[0AC9]
    79dd:b237    mov       word ptr es:[bp+06],di
    79dd:b23b    inc       word ptr es:[bp+06]
    79dd:b23f    mov       word ptr es:[bp+02],0012
    79dd:b245    add       bp,15
    79dd:b248    mov       word ptr ss:[0AC7],bp
    79dd:b24d    cmp       bp,7F00
    79dd:b251    jb        B256
    79dd:b253    call      MOREFR
    79dd:b256    pop       bp
    79dd:b257    pop       es
    79dd:b258    jmp       B2A7
    79dd:b25a    push      es
    79dd:b25b    push      bp
    79dd:b25c    push      cx
    79dd:b25d    push      ax
    79dd:b25e    mov       es,word ptr ss:[13A6]
    79dd:b263    mov       bp,word ptr ss:[13A8]
    79dd:b268    mov       ax,di
    79dd:b26a    sub       ax,word ptr ss:[13B4]
    79dd:b26f    xor       cx,cx
    79dd:b271    add       ax,word ptr ss:[13BE]
    79dd:b276    adc       cx,word ptr ss:[13BC]
    79dd:b27b    mov       word ptr es:[bp+00],ax
    79dd:b27f    mov       word ptr es:[bp+02],cx
    79dd:b283    mov       byte ptr es:[bp+04],12
    79dd:b288    add       word ptr es:[bp+00],01
    79dd:b28d    adc       word ptr es:[bp+02],00
    79dd:b292    add       bp,05
    79dd:b295    mov       word ptr ss:[13A8],bp
    79dd:b29a    cmp       bp,3F00
    79dd:b29e    jb        B2A3
    79dd:b2a0    call      MOREEXT
    79dd:b2a3    pop       ax
    79dd:b2a4    pop       cx
    79dd:b2a5    pop       bp
    79dd:b2a6    pop       es
    79dd:b2a7    mov       al,byte ptr [si]
    79dd:b2a9    xlat
    79dd:b2ab    or        al,al
    79dd:b2ad    js        B2B2
    79dd:b2af    jmp       PM
    79dd:b2b2    mov       al,cl
    79dd:b2b4    stosb
    79dd:b2b5    mov       ax,dx
    79dd:b2b7    stosw
    79dd:b2b8    ret
             M_MVSQ:
    79dd:b2b9    inc       si
    79dd:b2ba    call      CONVEXPRESS
    79dd:b2bd    lodsw
    79dd:b2be    cmp       ax,2C5D
    79dd:b2c1    je        B2C6
    79dd:b2c3    jmp       M_MOVERR
    79dd:b2c6    mov       dx,cx
    79dd:b2c8    lodsb
    79dd:b2c9    and       al,DF
    79dd:b2cb    cmp       al,52
    79dd:b2cd    jne       B2E2
    79dd:b2cf    lodsb
    79dd:b2d0    sub       al,30
    79dd:b2d2    js        B2E1
    79dd:b2d4    cmp       al,09
    79dd:b2d6    jg        B2E1
    79dd:b2d8    cmp       al,01
    79dd:b2da    je        B2FF
    79dd:b2dc    mov       cl,al
    79dd:b2de    jmp       B318
    79dd:b2e0    dec       si
    79dd:b2e1    dec       si
    79dd:b2e2    dec       si
    79dd:b2e3    push      dx
    79dd:b2e4    call      CONVEXPRESS
    79dd:b2e7    pop       dx
    79dd:b2e8    test      byte ptr ss:[0ACE],04
    79dd:b2ee    jne       B318
    79dd:b2f0    jmp       GREGERR
    79dd:b2f3    cmp       ah,05
    79dd:b2f6    jg        B2E0
    79dd:b2f8    add       ah,0A
    79dd:b2fb    mov       cl,ah
    79dd:b2fd    jmp       B318
    79dd:b2ff    lodsb
    79dd:b300    cmp       al,5D
    79dd:b302    je        B316
    79dd:b304    cmp       al,2C
    79dd:b306    je        B315
    79dd:b308    mov       ah,al
    79dd:b30a    sub       ah,30
    79dd:b30d    jns       B2F3
    79dd:b30f    xlat
    79dd:b311    or        al,al
    79dd:b313    jns       B2E0
    79dd:b315    dec       si
    79dd:b316    mov       cl,01
    79dd:b318    test      byte ptr ss:[0ACE],80
    79dd:b31e    je        B323
    79dd:b320    jmp       M_MVSM
    79dd:b323    cmp       dx,0200
    79dd:b327    jl        B32C
    79dd:b329    jmp       M_MVSM
    79dd:b32c    shr       dx,1
    79dd:b32e    add       cl,A0
    79dd:b331    mov       dh,cl
    79dd:b333    xchg      dl,dh
    79dd:b335    mov       cl,3E
    79dd:b337    test      byte ptr ss:[0ACE],C0
    79dd:b33d    jne       B342
    79dd:b33f    jmp       B3C6
    79dd:b342    test      byte ptr ss:[0ACE],40
    79dd:b348    jne       B379
    79dd:b34a    push      es
    79dd:b34b    push      bp
    79dd:b34c    mov       es,word ptr ss:[0AC5]
    79dd:b351    mov       bp,word ptr ss:[0AC9]
    79dd:b356    mov       word ptr es:[bp+06],di
    79dd:b35a    inc       word ptr es:[bp+06]
    79dd:b35e    mov       word ptr es:[bp+02],0012
    79dd:b364    add       bp,15
    79dd:b367    mov       word ptr ss:[0AC7],bp
    79dd:b36c    cmp       bp,7F00
    79dd:b370    jb        B375
    79dd:b372    call      MOREFR
    79dd:b375    pop       bp
    79dd:b376    pop       es
    79dd:b377    jmp       B3C6
    79dd:b379    push      es
    79dd:b37a    push      bp
    79dd:b37b    push      cx
    79dd:b37c    push      ax
    79dd:b37d    mov       es,word ptr ss:[13A6]
    79dd:b382    mov       bp,word ptr ss:[13A8]
    79dd:b387    mov       ax,di
    79dd:b389    sub       ax,word ptr ss:[13B4]
    79dd:b38e    xor       cx,cx
    79dd:b390    add       ax,word ptr ss:[13BE]
    79dd:b395    adc       cx,word ptr ss:[13BC]
    79dd:b39a    mov       word ptr es:[bp+00],ax
    79dd:b39e    mov       word ptr es:[bp+02],cx
    79dd:b3a2    mov       byte ptr es:[bp+04],12
    79dd:b3a7    add       word ptr es:[bp+00],01
    79dd:b3ac    adc       word ptr es:[bp+02],00
    79dd:b3b1    add       bp,05
    79dd:b3b4    mov       word ptr ss:[13A8],bp
    79dd:b3b9    cmp       bp,3F00
    79dd:b3bd    jb        B3C2
    79dd:b3bf    call      MOREEXT
    79dd:b3c2    pop       ax
    79dd:b3c3    pop       cx
    79dd:b3c4    pop       bp
    79dd:b3c5    pop       es
    79dd:b3c6    mov       al,byte ptr [si]
    79dd:b3c8    xlat
    79dd:b3ca    or        al,al
    79dd:b3cc    js        B3D1
    79dd:b3ce    jmp       PM
    79dd:b3d1    mov       al,cl
    79dd:b3d3    stosb
    79dd:b3d4    mov       ax,dx
    79dd:b3d6    stosw
    79dd:b3d7    ret
             M_MVSM:
    79dd:b3d8    add       cl,F0
    79dd:b3db    mov       ch,3E
    79dd:b3dd    xchg      ch,cl
    79dd:b3df    test      byte ptr ss:[0ACE],C0
    79dd:b3e5    jne       B3EA
    79dd:b3e7    jmp       B46E
    79dd:b3ea    test      byte ptr ss:[0ACE],40
    79dd:b3f0    jne       B421
    79dd:b3f2    push      es
    79dd:b3f3    push      bp
    79dd:b3f4    mov       es,word ptr ss:[0AC5]
    79dd:b3f9    mov       bp,word ptr ss:[0AC9]
    79dd:b3fe    mov       word ptr es:[bp+06],di
    79dd:b402    inc       word ptr es:[bp+06]
    79dd:b406    mov       word ptr es:[bp+02],0002
    79dd:b40c    add       bp,15
    79dd:b40f    mov       word ptr ss:[0AC7],bp
    79dd:b414    cmp       bp,7F00
    79dd:b418    jb        B41D
    79dd:b41a    call      MOREFR
    79dd:b41d    pop       bp
    79dd:b41e    pop       es
    79dd:b41f    jmp       B46E
    79dd:b421    push      es
    79dd:b422    push      bp
    79dd:b423    push      cx
    79dd:b424    push      ax
    79dd:b425    mov       es,word ptr ss:[13A6]
    79dd:b42a    mov       bp,word ptr ss:[13A8]
    79dd:b42f    mov       ax,di
    79dd:b431    sub       ax,word ptr ss:[13B4]
    79dd:b436    xor       cx,cx
    79dd:b438    add       ax,word ptr ss:[13BE]
    79dd:b43d    adc       cx,word ptr ss:[13BC]
    79dd:b442    mov       word ptr es:[bp+00],ax
    79dd:b446    mov       word ptr es:[bp+02],cx
    79dd:b44a    mov       byte ptr es:[bp+04],02
    79dd:b44f    add       word ptr es:[bp+00],01
    79dd:b454    adc       word ptr es:[bp+02],00
    79dd:b459    add       bp,05
    79dd:b45c    mov       word ptr ss:[13A8],bp
    79dd:b461    cmp       bp,3F00
    79dd:b465    jb        B46A
    79dd:b467    call      MOREEXT
    79dd:b46a    pop       ax
    79dd:b46b    pop       cx
    79dd:b46c    pop       bp
    79dd:b46d    pop       es
    79dd:b46e    mov       al,byte ptr [si]
    79dd:b470    xlat
    79dd:b472    or        al,al
    79dd:b474    js        B479
    79dd:b476    jmp       PM
    79dd:b479    mov       ax,cx
    79dd:b47b    stosw
    79dd:b47c    mov       ax,dx
    79dd:b47e    stosw
    79dd:b47f    ret
             M_MOVERR2:
    79dd:b480    pop       cx
    79dd:b481    push      dx
    79dd:b482    mov       dx,8251
    79dd:b485    call      ERROR_ROUT
    79dd:b488    pop       dx
    79dd:b489    ret
             M_MOVESERR:
    79dd:b48a    pop       cx
             M_MOVERR:
    79dd:b48b    push      dx
    79dd:b48c    mov       dx,8276
    79dd:b48f    call      ERROR_ROUT
    79dd:b492    pop       dx
    79dd:b493    ret
             M_MOVES:
    79dd:b494    inc       si
    79dd:b495    mov       al,byte ptr [si]
    79dd:b497    xlat
    79dd:b499    or        al,al
    79dd:b49b    js        B4A0
    79dd:b49d    jmp       PM
    79dd:b4a0    lodsb
    79dd:b4a1    xlat
    79dd:b4a3    or        al,al
    79dd:b4a5    js        B4A0
    79dd:b4a7    dec       si
    79dd:b4a8    lodsb
    79dd:b4a9    and       al,DF
    79dd:b4ab    cmp       al,52
    79dd:b4ad    jne       B4C2
    79dd:b4af    lodsb
    79dd:b4b0    sub       al,30
    79dd:b4b2    js        B4C1
    79dd:b4b4    cmp       al,09
    79dd:b4b6    jg        B4C1
    79dd:b4b8    cmp       al,01
    79dd:b4ba    je        B4DF
    79dd:b4bc    mov       cl,al
    79dd:b4be    jmp       B4F8
    79dd:b4c0    dec       si
    79dd:b4c1    dec       si
    79dd:b4c2    dec       si
    79dd:b4c3    push      dx
    79dd:b4c4    call      CONVEXPRESS
    79dd:b4c7    pop       dx
    79dd:b4c8    test      byte ptr ss:[0ACE],04
    79dd:b4ce    jne       B4F8
    79dd:b4d0    jmp       GREGERR
    79dd:b4d3    cmp       ah,05
    79dd:b4d6    jg        B4C0
    79dd:b4d8    add       ah,0A
    79dd:b4db    mov       cl,ah
    79dd:b4dd    jmp       B4F8
    79dd:b4df    lodsb
    79dd:b4e0    cmp       al,5D
    79dd:b4e2    je        B4F6
    79dd:b4e4    cmp       al,2C
    79dd:b4e6    je        B4F5
    79dd:b4e8    mov       ah,al
    79dd:b4ea    sub       ah,30
    79dd:b4ed    jns       B4D3
    79dd:b4ef    xlat
    79dd:b4f1    or        al,al
    79dd:b4f3    jns       B4C0
    79dd:b4f5    dec       si
    79dd:b4f6    mov       cl,01
    79dd:b4f8    mov       dx,cx
    79dd:b4fa    lodsb
    79dd:b4fb    cmp       al,2C
    79dd:b4fd    jne       M_MOVESERR
    79dd:b4ff    lodsb
    79dd:b500    and       al,DF
    79dd:b502    cmp       al,52
    79dd:b504    jne       B519
    79dd:b506    lodsb
    79dd:b507    sub       al,30
    79dd:b509    js        B518
    79dd:b50b    cmp       al,09
    79dd:b50d    jg        B518
    79dd:b50f    cmp       al,01
    79dd:b511    je        B536
    79dd:b513    mov       cl,al
    79dd:b515    jmp       B54F
    79dd:b517    dec       si
    79dd:b518    dec       si
    79dd:b519    dec       si
    79dd:b51a    push      dx
    79dd:b51b    call      CONVEXPRESS
    79dd:b51e    pop       dx
    79dd:b51f    test      byte ptr ss:[0ACE],04
    79dd:b525    jne       B54F
    79dd:b527    jmp       GREGERR
    79dd:b52a    cmp       ah,05
    79dd:b52d    jg        B517
    79dd:b52f    add       ah,0A
    79dd:b532    mov       cl,ah
    79dd:b534    jmp       B54F
    79dd:b536    lodsb
    79dd:b537    cmp       al,5D
    79dd:b539    je        B54D
    79dd:b53b    cmp       al,2C
    79dd:b53d    je        B54C
    79dd:b53f    mov       ah,al
    79dd:b541    sub       ah,30
    79dd:b544    jns       B52A
    79dd:b546    xlat
    79dd:b548    or        al,al
    79dd:b54a    jns       B517
    79dd:b54c    dec       si
    79dd:b54d    mov       cl,01
    79dd:b54f    add       dl,20
    79dd:b552    add       cl,B0
    79dd:b555    mov       al,byte ptr [si]
    79dd:b557    xlat
    79dd:b559    or        al,al
    79dd:b55b    js        B560
    79dd:b55d    jmp       PM
    79dd:b560    mov       al,dl
    79dd:b562    mov       ah,cl
    79dd:b564    stosw
    79dd:b565    ret
             M_MOVEW:
    79dd:b566    inc       si
    79dd:b567    mov       al,byte ptr [si]
    79dd:b569    xlat
    79dd:b56b    or        al,al
    79dd:b56d    js        B572
    79dd:b56f    jmp       PM
    79dd:b572    lodsb
    79dd:b573    xlat
    79dd:b575    or        al,al
    79dd:b577    js        B572
    79dd:b579    dec       si
    79dd:b57a    cmp       byte ptr [si],5B
    79dd:b57d    jne       B582
    79dd:b57f    jmp       M_MOVEWTOMEM
    79dd:b582    lodsb
    79dd:b583    and       al,DF
    79dd:b585    cmp       al,52
    79dd:b587    jne       B59C
    79dd:b589    lodsb
    79dd:b58a    sub       al,30
    79dd:b58c    js        B59B
    79dd:b58e    cmp       al,09
    79dd:b590    jg        B59B
    79dd:b592    cmp       al,01
    79dd:b594    je        B5B9
    79dd:b596    mov       cl,al
    79dd:b598    jmp       B5D2
    79dd:b59a    dec       si
    79dd:b59b    dec       si
    79dd:b59c    dec       si
    79dd:b59d    push      dx
    79dd:b59e    call      CONVEXPRESS
    79dd:b5a1    pop       dx
    79dd:b5a2    test      byte ptr ss:[0ACE],04
    79dd:b5a8    jne       B5D2
    79dd:b5aa    jmp       GREGERR
    79dd:b5ad    cmp       ah,05
    79dd:b5b0    jg        B59A
    79dd:b5b2    add       ah,0A
    79dd:b5b5    mov       cl,ah
    79dd:b5b7    jmp       B5D2
    79dd:b5b9    lodsb
    79dd:b5ba    cmp       al,5D
    79dd:b5bc    je        B5D0
    79dd:b5be    cmp       al,2C
    79dd:b5c0    je        B5CF
    79dd:b5c2    mov       ah,al
    79dd:b5c4    sub       ah,30
    79dd:b5c7    jns       B5AD
    79dd:b5c9    xlat
    79dd:b5cb    or        al,al
    79dd:b5cd    jns       B59A
    79dd:b5cf    dec       si
    79dd:b5d0    mov       cl,01
    79dd:b5d2    mov       dx,cx
    79dd:b5d4    lodsw
    79dd:b5d5    cmp       al,2C
    79dd:b5d7    je        B5DC
    79dd:b5d9    jmp       M_MOVERR
    79dd:b5dc    cmp       ah,5B
    79dd:b5df    je        B5E4
    79dd:b5e1    jmp       M_MNOSB
    79dd:b5e4    lodsb
    79dd:b5e5    and       al,DF
    79dd:b5e7    cmp       al,52
    79dd:b5e9    jne       B5FE
    79dd:b5eb    lodsb
    79dd:b5ec    sub       al,30
    79dd:b5ee    js        B5FD
    79dd:b5f0    cmp       al,09
    79dd:b5f2    jg        B5FD
    79dd:b5f4    cmp       al,01
    79dd:b5f6    je        B61B
    79dd:b5f8    mov       cl,al
    79dd:b5fa    jmp       B634
    79dd:b5fc    dec       si
    79dd:b5fd    dec       si
    79dd:b5fe    dec       si
    79dd:b5ff    push      dx
    79dd:b600    call      CONVEXPRESS
    79dd:b603    pop       dx
    79dd:b604    test      byte ptr ss:[0ACE],04
    79dd:b60a    jne       B634
    79dd:b60c    jmp       GREGERR
    79dd:b60f    cmp       ah,05
    79dd:b612    jg        B5FC
    79dd:b614    add       ah,0A
    79dd:b617    mov       cl,ah
    79dd:b619    jmp       B634
    79dd:b61b    lodsb
    79dd:b61c    cmp       al,5D
    79dd:b61e    je        B632
    79dd:b620    cmp       al,2C
    79dd:b622    je        B631
    79dd:b624    mov       ah,al
    79dd:b626    sub       ah,30
    79dd:b629    jns       B60F
    79dd:b62b    xlat
    79dd:b62d    or        al,al
    79dd:b62f    jns       B5FC
    79dd:b631    dec       si
    79dd:b632    mov       cl,01
    79dd:b634    lodsb
    79dd:b635    cmp       al,5D
    79dd:b637    je        B63C
    79dd:b639    jmp       M_MNOSB
    79dd:b63c    cmp       dl,00
    79dd:b63f    je        M_MOVEW0
    79dd:b641    add       dl,10
    79dd:b644    add       cl,40
    79dd:b647    mov       al,byte ptr [si]
    79dd:b649    xlat
    79dd:b64b    or        al,al
    79dd:b64d    js        B652
    79dd:b64f    jmp       PM
    79dd:b652    mov       al,dl
    79dd:b654    mov       ah,cl
    79dd:b656    stosw
    79dd:b657    ret
             M_MOVEW0:
    79dd:b658    add       cl,40
    79dd:b65b    mov       al,byte ptr [si]
    79dd:b65d    xlat
    79dd:b65f    or        al,al
    79dd:b661    js        B666
    79dd:b663    jmp       PM
    79dd:b666    mov       al,cl
    79dd:b668    stosb
    79dd:b669    ret
             M_MOVEWTOMEM:
    79dd:b66a    inc       si
    79dd:b66b    lodsb
    79dd:b66c    and       al,DF
    79dd:b66e    cmp       al,52
    79dd:b670    jne       B685
    79dd:b672    lodsb
    79dd:b673    sub       al,30
    79dd:b675    js        B684
    79dd:b677    cmp       al,09
    79dd:b679    jg        B684
    79dd:b67b    cmp       al,01
    79dd:b67d    je        B6A2
    79dd:b67f    mov       cl,al
    79dd:b681    jmp       B6BB
    79dd:b683    dec       si
    79dd:b684    dec       si
    79dd:b685    dec       si
    79dd:b686    push      dx
    79dd:b687    call      CONVEXPRESS
    79dd:b68a    pop       dx
    79dd:b68b    test      byte ptr ss:[0ACE],04
    79dd:b691    jne       B6BB
    79dd:b693    jmp       GREGERR
    79dd:b696    cmp       ah,05
    79dd:b699    jg        B683
    79dd:b69b    add       ah,0A
    79dd:b69e    mov       cl,ah
    79dd:b6a0    jmp       B6BB
    79dd:b6a2    lodsb
    79dd:b6a3    cmp       al,5D
    79dd:b6a5    je        B6B9
    79dd:b6a7    cmp       al,2C
    79dd:b6a9    je        B6B8
    79dd:b6ab    mov       ah,al
    79dd:b6ad    sub       ah,30
    79dd:b6b0    jns       B696
    79dd:b6b2    xlat
    79dd:b6b4    or        al,al
    79dd:b6b6    jns       B683
    79dd:b6b8    dec       si
    79dd:b6b9    mov       cl,01
    79dd:b6bb    lodsb
    79dd:b6bc    cmp       al,5D
    79dd:b6be    je        B6C3
    79dd:b6c0    jmp       M_MNCSB
    79dd:b6c3    lodsb
    79dd:b6c4    cmp       al,2C
    79dd:b6c6    je        B6CB
    79dd:b6c8    jmp       M_MOVERR
    79dd:b6cb    mov       dl,cl
    79dd:b6cd    lodsb
    79dd:b6ce    and       al,DF
    79dd:b6d0    cmp       al,52
    79dd:b6d2    jne       B6E7
    79dd:b6d4    lodsb
    79dd:b6d5    sub       al,30
    79dd:b6d7    js        B6E6
    79dd:b6d9    cmp       al,09
    79dd:b6db    jg        B6E6
    79dd:b6dd    cmp       al,01
    79dd:b6df    je        B704
    79dd:b6e1    mov       cl,al
    79dd:b6e3    jmp       B71D
    79dd:b6e5    dec       si
    79dd:b6e6    dec       si
    79dd:b6e7    dec       si
    79dd:b6e8    push      dx
    79dd:b6e9    call      CONVEXPRESS
    79dd:b6ec    pop       dx
    79dd:b6ed    test      byte ptr ss:[0ACE],04
    79dd:b6f3    jne       B71D
    79dd:b6f5    jmp       GREGERR
    79dd:b6f8    cmp       ah,05
    79dd:b6fb    jg        B6E5
    79dd:b6fd    add       ah,0A
    79dd:b700    mov       cl,ah
    79dd:b702    jmp       B71D
    79dd:b704    lodsb
    79dd:b705    cmp       al,5D
    79dd:b707    je        B71B
    79dd:b709    cmp       al,2C
    79dd:b70b    je        B71A
    79dd:b70d    mov       ah,al
    79dd:b70f    sub       ah,30
    79dd:b712    jns       B6F8
    79dd:b714    xlat
    79dd:b716    or        al,al
    79dd:b718    jns       B6E5
    79dd:b71a    dec       si
    79dd:b71b    mov       cl,01
    79dd:b71d    or        cl,cl
    79dd:b71f    je        M_MOVEW0MEM
    79dd:b721    xchg      dl,cl
    79dd:b723    add       dl,B0
    79dd:b726    add       cl,30
    79dd:b729    mov       al,byte ptr [si]
    79dd:b72b    xlat
    79dd:b72d    or        al,al
    79dd:b72f    js        B734
    79dd:b731    jmp       PM
    79dd:b734    mov       al,dl
    79dd:b736    mov       ah,cl
    79dd:b738    stosw
    79dd:b739    ret
             M_MOVEW0MEM:
    79dd:b73a    add       cl,30
    79dd:b73d    mov       al,byte ptr [si]
    79dd:b73f    xlat
    79dd:b741    or        al,al
    79dd:b743    js        B748
    79dd:b745    jmp       PM
    79dd:b748    mov       al,cl
    79dd:b74a    stosb
    79dd:b74b    ret
             M_MOVEB:
    79dd:b74c    inc       si
    79dd:b74d    mov       al,byte ptr [si]
    79dd:b74f    xlat
    79dd:b751    or        al,al
    79dd:b753    js        B758
    79dd:b755    jmp       PM
    79dd:b758    lodsb
    79dd:b759    xlat
    79dd:b75b    or        al,al
    79dd:b75d    js        B758
    79dd:b75f    dec       si
    79dd:b760    cmp       byte ptr [si],5B
    79dd:b763    jne       B768
    79dd:b765    jmp       M_MOVEBTOMEM
    79dd:b768    lodsb
    79dd:b769    and       al,DF
    79dd:b76b    cmp       al,52
    79dd:b76d    jne       B782
    79dd:b76f    lodsb
    79dd:b770    sub       al,30
    79dd:b772    js        B781
    79dd:b774    cmp       al,09
    79dd:b776    jg        B781
    79dd:b778    cmp       al,01
    79dd:b77a    je        B79F
    79dd:b77c    mov       cl,al
    79dd:b77e    jmp       B7B8
    79dd:b780    dec       si
    79dd:b781    dec       si
    79dd:b782    dec       si
    79dd:b783    push      dx
    79dd:b784    call      CONVEXPRESS
    79dd:b787    pop       dx
    79dd:b788    test      byte ptr ss:[0ACE],04
    79dd:b78e    jne       B7B8
    79dd:b790    jmp       GREGERR
    79dd:b793    cmp       ah,05
    79dd:b796    jg        B780
    79dd:b798    add       ah,0A
    79dd:b79b    mov       cl,ah
    79dd:b79d    jmp       B7B8
    79dd:b79f    lodsb
    79dd:b7a0    cmp       al,5D
    79dd:b7a2    je        B7B6
    79dd:b7a4    cmp       al,2C
    79dd:b7a6    je        B7B5
    79dd:b7a8    mov       ah,al
    79dd:b7aa    sub       ah,30
    79dd:b7ad    jns       B793
    79dd:b7af    xlat
    79dd:b7b1    or        al,al
    79dd:b7b3    jns       B780
    79dd:b7b5    dec       si
    79dd:b7b6    mov       cl,01
    79dd:b7b8    mov       dx,cx
    79dd:b7ba    lodsw
    79dd:b7bb    cmp       al,2C
    79dd:b7bd    je        B7C2
    79dd:b7bf    jmp       M_MOVERR
    79dd:b7c2    cmp       ah,5B
    79dd:b7c5    je        B7CA
    79dd:b7c7    jmp       M_MNOSB
    79dd:b7ca    lodsb
    79dd:b7cb    and       al,DF
    79dd:b7cd    cmp       al,52
    79dd:b7cf    jne       B7E4
    79dd:b7d1    lodsb
    79dd:b7d2    sub       al,30
    79dd:b7d4    js        B7E3
    79dd:b7d6    cmp       al,09
    79dd:b7d8    jg        B7E3
    79dd:b7da    cmp       al,01
    79dd:b7dc    je        B801
    79dd:b7de    mov       cl,al
    79dd:b7e0    jmp       B81A
    79dd:b7e2    dec       si
    79dd:b7e3    dec       si
    79dd:b7e4    dec       si
    79dd:b7e5    push      dx
    79dd:b7e6    call      CONVEXPRESS
    79dd:b7e9    pop       dx
    79dd:b7ea    test      byte ptr ss:[0ACE],04
    79dd:b7f0    jne       B81A
    79dd:b7f2    jmp       GREGERR
    79dd:b7f5    cmp       ah,05
    79dd:b7f8    jg        B7E2
    79dd:b7fa    add       ah,0A
    79dd:b7fd    mov       cl,ah
    79dd:b7ff    jmp       B81A
    79dd:b801    lodsb
    79dd:b802    cmp       al,5D
    79dd:b804    je        B818
    79dd:b806    cmp       al,2C
    79dd:b808    je        B817
    79dd:b80a    mov       ah,al
    79dd:b80c    sub       ah,30
    79dd:b80f    jns       B7F5
    79dd:b811    xlat
    79dd:b813    or        al,al
    79dd:b815    jns       B7E2
    79dd:b817    dec       si
    79dd:b818    mov       cl,01
    79dd:b81a    lodsb
    79dd:b81b    cmp       al,5D
    79dd:b81d    je        B822
    79dd:b81f    jmp       M_MNCSB
    79dd:b822    or        dl,dl
    79dd:b824    je        M_MOVEB0
    79dd:b826    add       dl,10
    79dd:b829    add       cl,40
    79dd:b82c    mov       ch,3D
    79dd:b82e    xchg      cl,ch
    79dd:b830    mov       al,byte ptr [si]
    79dd:b832    xlat
    79dd:b834    or        al,al
    79dd:b836    js        B83B
    79dd:b838    jmp       PM
    79dd:b83b    mov       al,dl
    79dd:b83d    stosb
    79dd:b83e    mov       ax,cx
    79dd:b840    stosw
    79dd:b841    ret
             M_MOVEB0:
    79dd:b842    add       cl,40
    79dd:b845    mov       al,byte ptr [si]
    79dd:b847    xlat
    79dd:b849    or        al,al
    79dd:b84b    js        B850
    79dd:b84d    jmp       PM
    79dd:b850    mov       al,3D
    79dd:b852    mov       ah,cl
    79dd:b854    stosw
    79dd:b855    ret
             M_MOVEBTOMEM:
    79dd:b856    inc       si
    79dd:b857    lodsb
    79dd:b858    and       al,DF
    79dd:b85a    cmp       al,52
    79dd:b85c    jne       B871
    79dd:b85e    lodsb
    79dd:b85f    sub       al,30
    79dd:b861    js        B870
    79dd:b863    cmp       al,09
    79dd:b865    jg        B870
    79dd:b867    cmp       al,01
    79dd:b869    je        B88E
    79dd:b86b    mov       cl,al
    79dd:b86d    jmp       B8A7
    79dd:b86f    dec       si
    79dd:b870    dec       si
    79dd:b871    dec       si
    79dd:b872    push      dx
    79dd:b873    call      CONVEXPRESS
    79dd:b876    pop       dx
    79dd:b877    test      byte ptr ss:[0ACE],04
    79dd:b87d    jne       B8A7
    79dd:b87f    jmp       GREGERR
    79dd:b882    cmp       ah,05
    79dd:b885    jg        B86F
    79dd:b887    add       ah,0A
    79dd:b88a    mov       cl,ah
    79dd:b88c    jmp       B8A7
    79dd:b88e    lodsb
    79dd:b88f    cmp       al,5D
    79dd:b891    je        B8A5
    79dd:b893    cmp       al,2C
    79dd:b895    je        B8A4
    79dd:b897    mov       ah,al
    79dd:b899    sub       ah,30
    79dd:b89c    jns       B882
    79dd:b89e    xlat
    79dd:b8a0    or        al,al
    79dd:b8a2    jns       B86F
    79dd:b8a4    dec       si
    79dd:b8a5    mov       cl,01
    79dd:b8a7    lodsb
    79dd:b8a8    cmp       al,5D
    79dd:b8aa    je        B8AF
    79dd:b8ac    jmp       M_MNCSB
    79dd:b8af    lodsb
    79dd:b8b0    cmp       al,2C
    79dd:b8b2    je        B8B7
    79dd:b8b4    jmp       M_MOVERR
    79dd:b8b7    mov       dl,cl
    79dd:b8b9    lodsb
    79dd:b8ba    and       al,DF
    79dd:b8bc    cmp       al,52
    79dd:b8be    jne       B8D3
    79dd:b8c0    lodsb
    79dd:b8c1    sub       al,30
    79dd:b8c3    js        B8D2
    79dd:b8c5    cmp       al,09
    79dd:b8c7    jg        B8D2
    79dd:b8c9    cmp       al,01
    79dd:b8cb    je        B8F0
    79dd:b8cd    mov       cl,al
    79dd:b8cf    jmp       B909
    79dd:b8d1    dec       si
    79dd:b8d2    dec       si
    79dd:b8d3    dec       si
    79dd:b8d4    push      dx
    79dd:b8d5    call      CONVEXPRESS
    79dd:b8d8    pop       dx
    79dd:b8d9    test      byte ptr ss:[0ACE],04
    79dd:b8df    jne       B909
    79dd:b8e1    jmp       GREGERR
    79dd:b8e4    cmp       ah,05
    79dd:b8e7    jg        B8D1
    79dd:b8e9    add       ah,0A
    79dd:b8ec    mov       cl,ah
    79dd:b8ee    jmp       B909
    79dd:b8f0    lodsb
    79dd:b8f1    cmp       al,5D
    79dd:b8f3    je        B907
    79dd:b8f5    cmp       al,2C
    79dd:b8f7    je        B906
    79dd:b8f9    mov       ah,al
    79dd:b8fb    sub       ah,30
    79dd:b8fe    jns       B8E4
    79dd:b900    xlat
    79dd:b902    or        al,al
    79dd:b904    jns       B8D1
    79dd:b906    dec       si
    79dd:b907    mov       cl,01
    79dd:b909    or        cl,cl
    79dd:b90b    je        M_MOVEB0MEM
    79dd:b90d    xchg      dl,cl
    79dd:b90f    add       dl,B0
    79dd:b912    mov       ch,cl
    79dd:b914    add       ch,30
    79dd:b917    mov       cl,3D
    79dd:b919    mov       al,byte ptr [si]
    79dd:b91b    xlat
    79dd:b91d    or        al,al
    79dd:b91f    js        B924
    79dd:b921    jmp       PM
    79dd:b924    mov       al,dl
    79dd:b926    stosb
    79dd:b927    mov       ax,cx
    79dd:b929    stosw
    79dd:b92a    ret
             M_MOVEB0MEM:
    79dd:b92b    add       dl,30
    79dd:b92e    mov       al,byte ptr [si]
    79dd:b930    xlat
    79dd:b932    or        al,al
    79dd:b934    js        B939
    79dd:b936    jmp       PM
    79dd:b939    mov       al,3D
    79dd:b93b    mov       ah,cl
    79dd:b93d    stosw
    79dd:b93e    ret
             M_MNOSB:
    79dd:b93f    push      dx
    79dd:b940    mov       dx,8285
    79dd:b943    call      ERROR_ROUT
    79dd:b946    pop       dx
    79dd:b947    ret
             M_MNCSB:
    79dd:b948    dec       si
    79dd:b949    push      dx
    79dd:b94a    mov       dx,8291
    79dd:b94d    call      ERROR_ROUT
    79dd:b950    pop       dx
    79dd:b951    ret
             M_MUL:
    79dd:b952    lodsb
    79dd:b953    and       al,DF
    79dd:b955    cmp       al,54
    79dd:b957    je        B95C
    79dd:b959    jmp       PM
    79dd:b95c    mov       al,byte ptr [si]
    79dd:b95e    xlat
    79dd:b960    or        al,al
    79dd:b962    js        B967
    79dd:b964    jmp       PM
    79dd:b967    lodsb
    79dd:b968    xlat
    79dd:b96a    or        al,al
    79dd:b96c    js        B967
    79dd:b96e    dec       si
    79dd:b96f    mov       al,byte ptr [si]
    79dd:b971    cmp       al,23
    79dd:b973    je        B9D7
    79dd:b975    lodsb
    79dd:b976    and       al,DF
    79dd:b978    cmp       al,52
    79dd:b97a    jne       B98F
    79dd:b97c    lodsb
    79dd:b97d    sub       al,30
    79dd:b97f    js        B98E
    79dd:b981    cmp       al,09
    79dd:b983    jg        B98E
    79dd:b985    cmp       al,01
    79dd:b987    je        B9AC
    79dd:b989    mov       cl,al
    79dd:b98b    jmp       B9C5
    79dd:b98d    dec       si
    79dd:b98e    dec       si
    79dd:b98f    dec       si
    79dd:b990    push      dx
    79dd:b991    call      CONVEXPRESS
    79dd:b994    pop       dx
    79dd:b995    test      byte ptr ss:[0ACE],04
    79dd:b99b    jne       B9C5
    79dd:b99d    jmp       GREGERR
    79dd:b9a0    cmp       ah,05
    79dd:b9a3    jg        B98D
    79dd:b9a5    add       ah,0A
    79dd:b9a8    mov       cl,ah
    79dd:b9aa    jmp       B9C5
    79dd:b9ac    lodsb
    79dd:b9ad    cmp       al,5D
    79dd:b9af    je        B9C2
    79dd:b9b1    cmp       al,2C
    79dd:b9b3    je        B9C2
    79dd:b9b5    mov       ah,al
    79dd:b9b7    sub       ah,30
    79dd:b9ba    jns       B9A0
    79dd:b9bc    xlat
    79dd:b9be    or        al,al
    79dd:b9c0    jns       B98D
    79dd:b9c2    mov       cl,01
    79dd:b9c4    dec       si
    79dd:b9c5    add       cl,80
    79dd:b9c8    mov       al,byte ptr [si]
    79dd:b9ca    xlat
    79dd:b9cc    or        al,al
    79dd:b9ce    js        B9D3
    79dd:b9d0    jmp       PM
    79dd:b9d3    mov       al,cl
    79dd:b9d5    stosb
    79dd:b9d6    ret
    79dd:b9d7    inc       si
    79dd:b9d8    call      CONVEXPRESS
    79dd:b9db    cmp       dx,00
    79dd:b9de    je        B9E3
    79dd:b9e0    jmp       REGNERR
    79dd:b9e3    cmp       cx,0F
    79dd:b9e6    jle       B9EB
    79dd:b9e8    jmp       REGNERR
    79dd:b9eb    add       cl,80
    79dd:b9ee    test      byte ptr ss:[0ACE],C0
    79dd:b9f4    je        BA6C
    79dd:b9f6    test      byte ptr ss:[0ACE],40
    79dd:b9fc    jne       BA29
    79dd:b9fe    push      es
    79dd:b9ff    push      bp
    79dd:ba00    mov       es,word ptr ss:[0AC5]
    79dd:ba05    mov       bp,word ptr ss:[0AC9]
    79dd:ba0a    mov       word ptr es:[bp+06],di
    79dd:ba0e    mov       word ptr es:[bp+02],000C
    79dd:ba14    add       bp,15
    79dd:ba17    mov       word ptr ss:[0AC7],bp
    79dd:ba1c    cmp       bp,7F00
    79dd:ba20    jb        BA25
    79dd:ba22    call      MOREFR
    79dd:ba25    pop       bp
    79dd:ba26    pop       es
    79dd:ba27    jmp       BA6C
    79dd:ba29    push      es
    79dd:ba2a    push      bp
    79dd:ba2b    push      cx
    79dd:ba2c    push      ax
    79dd:ba2d    mov       es,word ptr ss:[13A6]
    79dd:ba32    mov       bp,word ptr ss:[13A8]
    79dd:ba37    mov       ax,di
    79dd:ba39    sub       ax,word ptr ss:[13B4]
    79dd:ba3e    xor       cx,cx
    79dd:ba40    add       ax,word ptr ss:[13BE]
    79dd:ba45    adc       cx,word ptr ss:[13BC]
    79dd:ba4a    mov       word ptr es:[bp+00],ax
    79dd:ba4e    mov       word ptr es:[bp+02],cx
    79dd:ba52    mov       byte ptr es:[bp+04],0C
    79dd:ba57    add       bp,05
    79dd:ba5a    mov       word ptr ss:[13A8],bp
    79dd:ba5f    cmp       bp,3F00
    79dd:ba63    jb        BA68
    79dd:ba65    call      MOREEXT
    79dd:ba68    pop       ax
    79dd:ba69    pop       cx
    79dd:ba6a    pop       bp
    79dd:ba6b    pop       es
    79dd:ba6c    mov       al,byte ptr [si]
    79dd:ba6e    xlat
    79dd:ba70    or        al,al
    79dd:ba72    js        BA77
    79dd:ba74    jmp       PM
    79dd:ba77    mov       al,3E
    79dd:ba79    mov       ah,cl
    79dd:ba7b    stosw
    79dd:ba7c    ret
             M_NOP:
    79dd:ba7d    mov       al,byte ptr [si]
    79dd:ba7f    xlat
    79dd:ba81    or        al,al
    79dd:ba83    js        BA88
    79dd:ba85    jmp       PM
    79dd:ba88    mov       al,byte ptr [si]
    79dd:ba8a    xlat
    79dd:ba8c    or        al,al
    79dd:ba8e    js        BA93
    79dd:ba90    jmp       PM
    79dd:ba93    mov       al,01
    79dd:ba95    stosb
    79dd:ba96    ret
             M_NOT:
    79dd:ba97    mov       al,byte ptr [si]
    79dd:ba99    xlat
    79dd:ba9b    or        al,al
    79dd:ba9d    js        BAA2
    79dd:ba9f    jmp       PM
    79dd:baa2    mov       al,byte ptr [si]
    79dd:baa4    xlat
    79dd:baa6    or        al,al
    79dd:baa8    js        BAAD
    79dd:baaa    jmp       PM
    79dd:baad    mov       al,4F
    79dd:baaf    stosb
    79dd:bab0    ret
             M_OR:
    79dd:bab1    lodsb
    79dd:bab2    xlat
    79dd:bab4    or        al,al
    79dd:bab6    js        M_OR2
    79dd:bab8    cmp       al,47
    79dd:baba    jne       BABF
    79dd:babc    jmp       M_ORG
    79dd:babf    jmp       PM
             M_OR2:
    79dd:bac2    lodsb
    79dd:bac3    xlat
    79dd:bac5    or        al,al
    79dd:bac7    js        M_OR2
    79dd:bac9    dec       si
    79dd:baca    lodsb
    79dd:bacb    xlat
    79dd:bacd    or        al,al
    79dd:bacf    js        BACA
    79dd:bad1    dec       si
    79dd:bad2    mov       bp,si
    79dd:bad4    xor       cl,cl
    79dd:bad6    lodsb
    79dd:bad7    cmp       al,2C
    79dd:bad9    jne       BADF
    79dd:badb    inc       cl
    79dd:badd    jmp       BAD6
    79dd:badf    xlat
    79dd:bae1    or        al,al
    79dd:bae3    jns       BAD6
    79dd:bae5    mov       si,bp
    79dd:bae7    cmp       cl,02
    79dd:baea    jne       M_ORCONT
    79dd:baec    jmp       M_OR3
             M_ORCONT:
    79dd:baef    mov       al,byte ptr [si]
    79dd:baf1    cmp       al,23
    79dd:baf3    je        ORISHASH
    79dd:baf5    lodsb
    79dd:baf6    and       al,DF
    79dd:baf8    cmp       al,52
    79dd:bafa    jne       BB0F
    79dd:bafc    lodsb
    79dd:bafd    sub       al,30
    79dd:baff    js        BB0E
    79dd:bb01    cmp       al,09
    79dd:bb03    jg        BB0E
    79dd:bb05    cmp       al,01
    79dd:bb07    je        BB2C
    79dd:bb09    mov       cl,al
    79dd:bb0b    jmp       BB45
    79dd:bb0d    dec       si
    79dd:bb0e    dec       si
    79dd:bb0f    dec       si
    79dd:bb10    push      dx
    79dd:bb11    call      CONVEXPRESS
    79dd:bb14    pop       dx
    79dd:bb15    test      byte ptr ss:[0ACE],04
    79dd:bb1b    jne       BB45
    79dd:bb1d    jmp       GREGERR
    79dd:bb20    cmp       ah,05
    79dd:bb23    jg        BB0D
    79dd:bb25    add       ah,0A
    79dd:bb28    mov       cl,ah
    79dd:bb2a    jmp       BB45
    79dd:bb2c    lodsb
    79dd:bb2d    cmp       al,5D
    79dd:bb2f    je        BB43
    79dd:bb31    cmp       al,2C
    79dd:bb33    je        BB42
    79dd:bb35    mov       ah,al
    79dd:bb37    sub       ah,30
    79dd:bb3a    jns       BB20
    79dd:bb3c    xlat
    79dd:bb3e    or        al,al
    79dd:bb40    jns       BB0D
    79dd:bb42    dec       si
    79dd:bb43    mov       cl,01
    79dd:bb45    cmp       cl,01
    79dd:bb48    jge       BB4D
    79dd:bb4a    jmp       GREGERR
    79dd:bb4d    add       cl,C0
    79dd:bb50    mov       al,byte ptr [si]
    79dd:bb52    xlat
    79dd:bb54    or        al,al
    79dd:bb56    js        BB5B
    79dd:bb58    jmp       PM
    79dd:bb5b    mov       al,cl
    79dd:bb5d    stosb
    79dd:bb5e    ret
             ORISHASH:
    79dd:bb5f    inc       si
    79dd:bb60    call      CONVEXPRESS
    79dd:bb63    cmp       dx,00
    79dd:bb66    je        BB6B
    79dd:bb68    jmp       REGNERR
    79dd:bb6b    or        cx,cx
    79dd:bb6d    ja        BB72
    79dd:bb6f    jmp       REGNERR
    79dd:bb72    cmp       cx,0F
    79dd:bb75    jle       BB7A
    79dd:bb77    jmp       REGNERR
    79dd:bb7a    add       cl,C0
    79dd:bb7d    test      byte ptr ss:[0ACE],C0
    79dd:bb83    je        BBFB
    79dd:bb85    test      byte ptr ss:[0ACE],40
    79dd:bb8b    jne       BBB8
    79dd:bb8d    push      es
    79dd:bb8e    push      bp
    79dd:bb8f    mov       es,word ptr ss:[0AC5]
    79dd:bb94    mov       bp,word ptr ss:[0AC9]
    79dd:bb99    mov       word ptr es:[bp+06],di
    79dd:bb9d    mov       word ptr es:[bp+02],000C
    79dd:bba3    add       bp,15
    79dd:bba6    mov       word ptr ss:[0AC7],bp
    79dd:bbab    cmp       bp,7F00
    79dd:bbaf    jb        BBB4
    79dd:bbb1    call      MOREFR
    79dd:bbb4    pop       bp
    79dd:bbb5    pop       es
    79dd:bbb6    jmp       BBFB
    79dd:bbb8    push      es
    79dd:bbb9    push      bp
    79dd:bbba    push      cx
    79dd:bbbb    push      ax
    79dd:bbbc    mov       es,word ptr ss:[13A6]
    79dd:bbc1    mov       bp,word ptr ss:[13A8]
    79dd:bbc6    mov       ax,di
    79dd:bbc8    sub       ax,word ptr ss:[13B4]
    79dd:bbcd    xor       cx,cx
    79dd:bbcf    add       ax,word ptr ss:[13BE]
    79dd:bbd4    adc       cx,word ptr ss:[13BC]
    79dd:bbd9    mov       word ptr es:[bp+00],ax
    79dd:bbdd    mov       word ptr es:[bp+02],cx
    79dd:bbe1    mov       byte ptr es:[bp+04],0C
    79dd:bbe6    add       bp,05
    79dd:bbe9    mov       word ptr ss:[13A8],bp
    79dd:bbee    cmp       bp,3F00
    79dd:bbf2    jb        BBF7
    79dd:bbf4    call      MOREEXT
    79dd:bbf7    pop       ax
    79dd:bbf8    pop       cx
    79dd:bbf9    pop       bp
    79dd:bbfa    pop       es
    79dd:bbfb    mov       al,byte ptr [si]
    79dd:bbfd    xlat
    79dd:bbff    or        al,al
    79dd:bc01    js        BC06
    79dd:bc03    jmp       PM
    79dd:bc06    mov       al,3E
    79dd:bc08    mov       ah,cl
    79dd:bc0a    stosw
    79dd:bc0b    ret
             M_OR3:
    79dd:bc0c    lodsb
    79dd:bc0d    and       al,DF
    79dd:bc0f    cmp       al,52
    79dd:bc11    jne       BC26
    79dd:bc13    lodsb
    79dd:bc14    sub       al,30
    79dd:bc16    js        BC25
    79dd:bc18    cmp       al,09
    79dd:bc1a    jg        BC25
    79dd:bc1c    cmp       al,01
    79dd:bc1e    je        BC43
    79dd:bc20    mov       cl,al
    79dd:bc22    jmp       BC58
    79dd:bc24    dec       si
    79dd:bc25    dec       si
    79dd:bc26    dec       si
    79dd:bc27    push      dx
    79dd:bc28    call      CONVEXPRESS
    79dd:bc2b    pop       dx
    79dd:bc2c    test      byte ptr ss:[0ACE],04
    79dd:bc32    jne       BC58
    79dd:bc34    jmp       GREGERR
    79dd:bc37    cmp       ah,05
    79dd:bc3a    jg        BC24
    79dd:bc3c    add       ah,0A
    79dd:bc3f    mov       cl,ah
    79dd:bc41    jmp       BC58
    79dd:bc43    lodsb
    79dd:bc44    cmp       al,2C
    79dd:bc46    je        BC55
    79dd:bc48    mov       ah,al
    79dd:bc4a    sub       ah,30
    79dd:bc4d    jns       BC37
    79dd:bc4f    xlat
    79dd:bc51    or        al,al
    79dd:bc53    jns       BC24
    79dd:bc55    mov       cl,01
    79dd:bc57    dec       si
    79dd:bc58    mov       byte ptr ss:[248D],cl
    79dd:bc5d    lodsb
    79dd:bc5e    cmp       al,2C
    79dd:bc60    je        BC65
    79dd:bc62    jmp       EAERR
    79dd:bc65    lodsb
    79dd:bc66    and       al,DF
    79dd:bc68    cmp       al,52
    79dd:bc6a    jne       BC7F
    79dd:bc6c    lodsb
    79dd:bc6d    sub       al,30
    79dd:bc6f    js        BC7E
    79dd:bc71    cmp       al,09
    79dd:bc73    jg        BC7E
    79dd:bc75    cmp       al,01
    79dd:bc77    je        BC9C
    79dd:bc79    mov       cl,al
    79dd:bc7b    jmp       BCB1
    79dd:bc7d    dec       si
    79dd:bc7e    dec       si
    79dd:bc7f    dec       si
    79dd:bc80    push      dx
    79dd:bc81    call      CONVEXPRESS
    79dd:bc84    pop       dx
    79dd:bc85    test      byte ptr ss:[0ACE],04
    79dd:bc8b    jne       BCB1
    79dd:bc8d    jmp       GREGERR
    79dd:bc90    cmp       ah,05
    79dd:bc93    jg        BC7D
    79dd:bc95    add       ah,0A
    79dd:bc98    mov       cl,ah
    79dd:bc9a    jmp       BCB1
    79dd:bc9c    lodsb
    79dd:bc9d    cmp       al,2C
    79dd:bc9f    je        BCAE
    79dd:bca1    mov       ah,al
    79dd:bca3    sub       ah,30
    79dd:bca6    jns       BC90
    79dd:bca8    xlat
    79dd:bcaa    or        al,al
    79dd:bcac    jns       BC7D
    79dd:bcae    mov       cl,01
    79dd:bcb0    dec       si
    79dd:bcb1    mov       byte ptr ss:[248C],cl
    79dd:bcb6    lodsb
    79dd:bcb7    cmp       al,2C
    79dd:bcb9    je        BCBE
    79dd:bcbb    jmp       EAERR
    79dd:bcbe    call      CODEDREGSREG_ROU
    79dd:bcc1    call      M_ORCONT
    79dd:bcc4    mov       ds,word ptr ss:[2494]
    79dd:bcc9    mov       si,word ptr ss:[2496]
    79dd:bcce    ret
             M_RPI:
    79dd:bccf    lodsb
    79dd:bcd0    and       al,DF
    79dd:bcd2    cmp       al,58
    79dd:bcd4    je        BCD9
    79dd:bcd6    jmp       PM
    79dd:bcd9    mov       al,byte ptr [si]
    79dd:bcdb    xlat
    79dd:bcdd    or        al,al
    79dd:bcdf    js        BCE4
    79dd:bce1    jmp       PM
    79dd:bce4    mov       al,byte ptr [si]
    79dd:bce6    xlat
    79dd:bce8    or        al,al
    79dd:bcea    js        BCEF
    79dd:bcec    jmp       PM
    79dd:bcef    mov       al,3D
    79dd:bcf1    mov       ah,4C
    79dd:bcf3    stosw
    79dd:bcf4    ret
             M_PLO:
    79dd:bcf5    lodsb
    79dd:bcf6    and       al,DF
    79dd:bcf8    cmp       al,54
    79dd:bcfa    je        BCFF
    79dd:bcfc    jmp       PM
    79dd:bcff    mov       al,byte ptr [si]
    79dd:bd01    xlat
    79dd:bd03    or        al,al
    79dd:bd05    js        BD0A
    79dd:bd07    jmp       PM
    79dd:bd0a    mov       al,byte ptr [si]
    79dd:bd0c    xlat
    79dd:bd0e    or        al,al
    79dd:bd10    js        BD15
    79dd:bd12    jmp       PM
    79dd:bd15    mov       al,4C
    79dd:bd17    stosb
    79dd:bd18    ret
             M_RAM:
    79dd:bd19    lodsb
    79dd:bd1a    and       al,DF
    79dd:bd1c    cmp       al,42
    79dd:bd1e    je        BD23
    79dd:bd20    jmp       PM
    79dd:bd23    mov       al,byte ptr [si]
    79dd:bd25    xlat
    79dd:bd27    or        al,al
    79dd:bd29    js        BD2E
    79dd:bd2b    jmp       PM
    79dd:bd2e    mov       al,byte ptr [si]
    79dd:bd30    xlat
    79dd:bd32    or        al,al
    79dd:bd34    js        BD39
    79dd:bd36    jmp       PM
    79dd:bd39    mov       al,3E
    79dd:bd3b    mov       ah,DF
    79dd:bd3d    stosw
    79dd:bd3e    ret
             M_ROL:
    79dd:bd3f    mov       al,byte ptr [si]
    79dd:bd41    xlat
    79dd:bd43    or        al,al
    79dd:bd45    js        BD4A
    79dd:bd47    jmp       PM
    79dd:bd4a    mov       al,byte ptr [si]
    79dd:bd4c    xlat
    79dd:bd4e    or        al,al
    79dd:bd50    js        BD55
    79dd:bd52    jmp       PM
    79dd:bd55    mov       al,04
    79dd:bd57    stosb
    79dd:bd58    ret
             M_ROM:
    79dd:bd59    lodsb
    79dd:bd5a    and       al,DF
    79dd:bd5c    cmp       al,42
    79dd:bd5e    je        BD63
    79dd:bd60    jmp       PM
    79dd:bd63    mov       al,byte ptr [si]
    79dd:bd65    xlat
    79dd:bd67    or        al,al
    79dd:bd69    js        BD6E
    79dd:bd6b    jmp       PM
    79dd:bd6e    mov       al,byte ptr [si]
    79dd:bd70    xlat
    79dd:bd72    or        al,al
    79dd:bd74    js        BD79
    79dd:bd76    jmp       PM
    79dd:bd79    mov       al,3F
    79dd:bd7b    mov       ah,DF
    79dd:bd7d    stosw
    79dd:bd7e    ret
             M_ROR:
    79dd:bd7f    mov       al,byte ptr [si]
    79dd:bd81    xlat
    79dd:bd83    or        al,al
    79dd:bd85    js        BD8A
    79dd:bd87    jmp       PM
    79dd:bd8a    mov       al,byte ptr [si]
    79dd:bd8c    xlat
    79dd:bd8e    or        al,al
    79dd:bd90    js        BD95
    79dd:bd92    jmp       PM
    79dd:bd95    mov       al,97
    79dd:bd97    stosb
    79dd:bd98    ret
             M_SEX:
    79dd:bd99    mov       al,byte ptr [si]
    79dd:bd9b    xlat
    79dd:bd9d    or        al,al
    79dd:bd9f    js        BDA4
    79dd:bda1    jmp       PM
    79dd:bda4    mov       al,byte ptr [si]
    79dd:bda6    xlat
    79dd:bda8    or        al,al
    79dd:bdaa    js        BDAF
    79dd:bdac    jmp       PM
    79dd:bdaf    mov       al,95
    79dd:bdb1    stosb
    79dd:bdb2    ret
             M_SBK:
    79dd:bdb3    mov       al,byte ptr [si]
    79dd:bdb5    xlat
    79dd:bdb7    or        al,al
    79dd:bdb9    js        BDBE
    79dd:bdbb    jmp       PM
    79dd:bdbe    mov       al,byte ptr [si]
    79dd:bdc0    xlat
    79dd:bdc2    or        al,al
    79dd:bdc4    js        BDC9
    79dd:bdc6    jmp       PM
    79dd:bdc9    mov       al,90
    79dd:bdcb    stosb
    79dd:bdcc    ret
             M_STO:
    79dd:bdcd    lodsb
    79dd:bdce    and       al,DF
    79dd:bdd0    cmp       al,50
    79dd:bdd2    je        BDD7
    79dd:bdd4    jmp       PM
    79dd:bdd7    mov       al,byte ptr [si]
    79dd:bdd9    xlat
    79dd:bddb    or        al,al
    79dd:bddd    js        BDE2
    79dd:bddf    jmp       PM
    79dd:bde2    mov       al,byte ptr [si]
    79dd:bde4    xlat
    79dd:bde6    or        al,al
    79dd:bde8    js        BDED
    79dd:bdea    jmp       PM
    79dd:bded    mov       al,00
    79dd:bdef    stosb
    79dd:bdf0    ret
             M_STB:
    79dd:bdf1    mov       al,byte ptr [si]
    79dd:bdf3    xlat
    79dd:bdf5    or        al,al
    79dd:bdf7    js        BDFC
    79dd:bdf9    jmp       PM
    79dd:bdfc    lodsb
    79dd:bdfd    xlat
    79dd:bdff    or        al,al
    79dd:be01    js        BDFC
    79dd:be03    dec       si
    79dd:be04    lodsb
    79dd:be05    cmp       al,5B
    79dd:be07    je        BE0C
    79dd:be09    jmp       M_SMERR
    79dd:be0c    lodsb
    79dd:be0d    and       al,DF
    79dd:be0f    cmp       al,52
    79dd:be11    jne       BE26
    79dd:be13    lodsb
    79dd:be14    sub       al,30
    79dd:be16    js        BE25
    79dd:be18    cmp       al,09
    79dd:be1a    jg        BE25
    79dd:be1c    cmp       al,01
    79dd:be1e    je        BE43
    79dd:be20    mov       cl,al
    79dd:be22    jmp       BE5C
    79dd:be24    dec       si
    79dd:be25    dec       si
    79dd:be26    dec       si
    79dd:be27    push      dx
    79dd:be28    call      CONVEXPRESS
    79dd:be2b    pop       dx
    79dd:be2c    test      byte ptr ss:[0ACE],04
    79dd:be32    jne       BE5C
    79dd:be34    jmp       GREGERR
    79dd:be37    cmp       ah,01
    79dd:be3a    jg        BE24
    79dd:be3c    add       ah,0A
    79dd:be3f    mov       cl,ah
    79dd:be41    jmp       BE5C
    79dd:be43    lodsb
    79dd:be44    cmp       al,5D
    79dd:be46    je        BE59
    79dd:be48    cmp       al,2C
    79dd:be4a    je        BE59
    79dd:be4c    mov       ah,al
    79dd:be4e    sub       ah,30
    79dd:be51    jns       BE37
    79dd:be53    xlat
    79dd:be55    or        al,al
    79dd:be57    jns       BE24
    79dd:be59    mov       cl,01
    79dd:be5b    dec       si
    79dd:be5c    lodsb
    79dd:be5d    cmp       al,5D
    79dd:be5f    je        BE64
    79dd:be61    jmp       M_SMERR1
    79dd:be64    add       cl,30
    79dd:be67    mov       al,byte ptr [si]
    79dd:be69    xlat
    79dd:be6b    or        al,al
    79dd:be6d    js        BE72
    79dd:be6f    jmp       PM
    79dd:be72    mov       al,3D
    79dd:be74    mov       ah,cl
    79dd:be76    stosw
    79dd:be77    ret
             M_STW:
    79dd:be78    mov       al,byte ptr [si]
    79dd:be7a    xlat
    79dd:be7c    or        al,al
    79dd:be7e    js        BE83
    79dd:be80    jmp       PM
    79dd:be83    lodsb
    79dd:be84    xlat
    79dd:be86    or        al,al
    79dd:be88    js        BE83
    79dd:be8a    dec       si
    79dd:be8b    lodsb
    79dd:be8c    cmp       al,5B
    79dd:be8e    je        BE93
    79dd:be90    jmp       M_SMERR
    79dd:be93    lodsb
    79dd:be94    and       al,DF
    79dd:be96    cmp       al,52
    79dd:be98    jne       BEAD
    79dd:be9a    lodsb
    79dd:be9b    sub       al,30
    79dd:be9d    js        BEAC
    79dd:be9f    cmp       al,09
    79dd:bea1    jg        BEAC
    79dd:bea3    cmp       al,01
    79dd:bea5    je        BECA
    79dd:bea7    mov       cl,al
    79dd:bea9    jmp       BEE3
    79dd:beab    dec       si
    79dd:beac    dec       si
    79dd:bead    dec       si
    79dd:beae    push      dx
    79dd:beaf    call      CONVEXPRESS
    79dd:beb2    pop       dx
    79dd:beb3    test      byte ptr ss:[0ACE],04
    79dd:beb9    jne       BEE3
    79dd:bebb    jmp       GREGERR
    79dd:bebe    cmp       ah,01
    79dd:bec1    jg        BEAB
    79dd:bec3    add       ah,0A
    79dd:bec6    mov       cl,ah
    79dd:bec8    jmp       BEE3
    79dd:beca    lodsb
    79dd:becb    cmp       al,5D
    79dd:becd    je        BEE0
    79dd:becf    cmp       al,2C
    79dd:bed1    je        BEE0
    79dd:bed3    mov       ah,al
    79dd:bed5    sub       ah,30
    79dd:bed8    jns       BEBE
    79dd:beda    xlat
    79dd:bedc    or        al,al
    79dd:bede    jns       BEAB
    79dd:bee0    mov       cl,01
    79dd:bee2    dec       si
    79dd:bee3    lodsb
    79dd:bee4    cmp       al,5D
    79dd:bee6    je        BEEB
    79dd:bee8    jmp       M_SMERR1
    79dd:beeb    add       cl,30
    79dd:beee    mov       al,byte ptr [si]
    79dd:bef0    xlat
    79dd:bef2    or        al,al
    79dd:bef4    js        BEF9
    79dd:bef6    jmp       PM
    79dd:bef9    mov       al,cl
    79dd:befb    stosb
    79dd:befc    ret
             M_SUB:
    79dd:befd    mov       al,byte ptr [si]
    79dd:beff    xlat
    79dd:bf01    or        al,al
    79dd:bf03    js        BF08
    79dd:bf05    jmp       PM
    79dd:bf08    lodsb
    79dd:bf09    xlat
    79dd:bf0b    or        al,al
    79dd:bf0d    js        BF08
    79dd:bf0f    dec       si
    79dd:bf10    mov       bp,si
    79dd:bf12    xor       cl,cl
    79dd:bf14    lodsb
    79dd:bf15    cmp       al,2C
    79dd:bf17    jne       BF1D
    79dd:bf19    inc       cl
    79dd:bf1b    jmp       BF14
    79dd:bf1d    xlat
    79dd:bf1f    or        al,al
    79dd:bf21    jns       BF14
    79dd:bf23    mov       si,bp
    79dd:bf25    cmp       cl,02
    79dd:bf28    jne       M_SUBCONT
    79dd:bf2a    jmp       M_SUB3
             M_SUBCONT:
    79dd:bf2d    lodsb
    79dd:bf2e    xlat
    79dd:bf30    or        al,al
    79dd:bf32    js        M_SUBCONT
    79dd:bf34    dec       si
    79dd:bf35    mov       al,byte ptr [si]
    79dd:bf37    cmp       al,23
    79dd:bf39    je        BF9D
    79dd:bf3b    lodsb
    79dd:bf3c    and       al,DF
    79dd:bf3e    cmp       al,52
    79dd:bf40    jne       BF55
    79dd:bf42    lodsb
    79dd:bf43    sub       al,30
    79dd:bf45    js        BF54
    79dd:bf47    cmp       al,09
    79dd:bf49    jg        BF54
    79dd:bf4b    cmp       al,01
    79dd:bf4d    je        BF72
    79dd:bf4f    mov       cl,al
    79dd:bf51    jmp       BF8B
    79dd:bf53    dec       si
    79dd:bf54    dec       si
    79dd:bf55    dec       si
    79dd:bf56    push      dx
    79dd:bf57    call      CONVEXPRESS
    79dd:bf5a    pop       dx
    79dd:bf5b    test      byte ptr ss:[0ACE],04
    79dd:bf61    jne       BF8B
    79dd:bf63    jmp       GREGERR
    79dd:bf66    cmp       ah,05
    79dd:bf69    jg        BF53
    79dd:bf6b    add       ah,0A
    79dd:bf6e    mov       cl,ah
    79dd:bf70    jmp       BF8B
    79dd:bf72    lodsb
    79dd:bf73    cmp       al,5D
    79dd:bf75    je        BF88
    79dd:bf77    cmp       al,2C
    79dd:bf79    je        BF88
    79dd:bf7b    mov       ah,al
    79dd:bf7d    sub       ah,30
    79dd:bf80    jns       BF66
    79dd:bf82    xlat
    79dd:bf84    or        al,al
    79dd:bf86    jns       BF53
    79dd:bf88    mov       cl,01
    79dd:bf8a    dec       si
    79dd:bf8b    add       cl,60
    79dd:bf8e    mov       al,byte ptr [si]
    79dd:bf90    xlat
    79dd:bf92    or        al,al
    79dd:bf94    js        BF99
    79dd:bf96    jmp       PM
    79dd:bf99    mov       al,cl
    79dd:bf9b    stosb
    79dd:bf9c    ret
    79dd:bf9d    inc       si
    79dd:bf9e    call      CONVEXPRESS
    79dd:bfa1    cmp       dx,00
    79dd:bfa4    je        BFA9
    79dd:bfa6    jmp       REGNERR
    79dd:bfa9    cmp       cx,0F
    79dd:bfac    jle       BFB1
    79dd:bfae    jmp       REGNERR
    79dd:bfb1    add       cl,60
    79dd:bfb4    test      byte ptr ss:[0ACE],C0
    79dd:bfba    je        C032
    79dd:bfbc    test      byte ptr ss:[0ACE],40
    79dd:bfc2    jne       BFEF
    79dd:bfc4    push      es
    79dd:bfc5    push      bp
    79dd:bfc6    mov       es,word ptr ss:[0AC5]
    79dd:bfcb    mov       bp,word ptr ss:[0AC9]
    79dd:bfd0    mov       word ptr es:[bp+06],di
    79dd:bfd4    mov       word ptr es:[bp+02],000C
    79dd:bfda    add       bp,15
    79dd:bfdd    mov       word ptr ss:[0AC7],bp
    79dd:bfe2    cmp       bp,7F00
    79dd:bfe6    jb        BFEB
    79dd:bfe8    call      MOREFR
    79dd:bfeb    pop       bp
    79dd:bfec    pop       es
    79dd:bfed    jmp       C032
    79dd:bfef    push      es
    79dd:bff0    push      bp
    79dd:bff1    push      cx
    79dd:bff2    push      ax
    79dd:bff3    mov       es,word ptr ss:[13A6]
    79dd:bff8    mov       bp,word ptr ss:[13A8]
    79dd:bffd    mov       ax,di
    79dd:bfff    sub       ax,word ptr ss:[13B4]
    79dd:c004    xor       cx,cx
    79dd:c006    add       ax,word ptr ss:[13BE]
    79dd:c00b    adc       cx,word ptr ss:[13BC]
    79dd:c010    mov       word ptr es:[bp+00],ax
    79dd:c014    mov       word ptr es:[bp+02],cx
    79dd:c018    mov       byte ptr es:[bp+04],0C
    79dd:c01d    add       bp,05
    79dd:c020    mov       word ptr ss:[13A8],bp
    79dd:c025    cmp       bp,3F00
    79dd:c029    jb        C02E
    79dd:c02b    call      MOREEXT
    79dd:c02e    pop       ax
    79dd:c02f    pop       cx
    79dd:c030    pop       bp
    79dd:c031    pop       es
    79dd:c032    mov       al,byte ptr [si]
    79dd:c034    xlat
    79dd:c036    or        al,al
    79dd:c038    js        C03D
    79dd:c03a    jmp       PM
    79dd:c03d    mov       al,3E
    79dd:c03f    mov       ah,cl
    79dd:c041    stosw
    79dd:c042    ret
             M_SUB3:
    79dd:c043    lodsb
    79dd:c044    and       al,DF
    79dd:c046    cmp       al,52
    79dd:c048    jne       C05D
    79dd:c04a    lodsb
    79dd:c04b    sub       al,30
    79dd:c04d    js        C05C
    79dd:c04f    cmp       al,09
    79dd:c051    jg        C05C
    79dd:c053    cmp       al,01
    79dd:c055    je        C07A
    79dd:c057    mov       cl,al
    79dd:c059    jmp       C08F
    79dd:c05b    dec       si
    79dd:c05c    dec       si
    79dd:c05d    dec       si
    79dd:c05e    push      dx
    79dd:c05f    call      CONVEXPRESS
    79dd:c062    pop       dx
    79dd:c063    test      byte ptr ss:[0ACE],04
    79dd:c069    jne       C08F
    79dd:c06b    jmp       GREGERR
    79dd:c06e    cmp       ah,05
    79dd:c071    jg        C05B
    79dd:c073    add       ah,0A
    79dd:c076    mov       cl,ah
    79dd:c078    jmp       C08F
    79dd:c07a    lodsb
    79dd:c07b    cmp       al,2C
    79dd:c07d    je        C08C
    79dd:c07f    mov       ah,al
    79dd:c081    sub       ah,30
    79dd:c084    jns       C06E
    79dd:c086    xlat
    79dd:c088    or        al,al
    79dd:c08a    jns       C05B
    79dd:c08c    mov       cl,01
    79dd:c08e    dec       si
    79dd:c08f    mov       byte ptr ss:[248D],cl
    79dd:c094    lodsb
    79dd:c095    cmp       al,2C
    79dd:c097    je        C09C
    79dd:c099    jmp       EAERR
    79dd:c09c    lodsb
    79dd:c09d    and       al,DF
    79dd:c09f    cmp       al,52
    79dd:c0a1    jne       C0B6
    79dd:c0a3    lodsb
    79dd:c0a4    sub       al,30
    79dd:c0a6    js        C0B5
    79dd:c0a8    cmp       al,09
    79dd:c0aa    jg        C0B5
    79dd:c0ac    cmp       al,01
    79dd:c0ae    je        C0D3
    79dd:c0b0    mov       cl,al
    79dd:c0b2    jmp       C0E8
    79dd:c0b4    dec       si
    79dd:c0b5    dec       si
    79dd:c0b6    dec       si
    79dd:c0b7    push      dx
    79dd:c0b8    call      CONVEXPRESS
    79dd:c0bb    pop       dx
    79dd:c0bc    test      byte ptr ss:[0ACE],04
    79dd:c0c2    jne       C0E8
    79dd:c0c4    jmp       GREGERR
    79dd:c0c7    cmp       ah,05
    79dd:c0ca    jg        C0B4
    79dd:c0cc    add       ah,0A
    79dd:c0cf    mov       cl,ah
    79dd:c0d1    jmp       C0E8
    79dd:c0d3    lodsb
    79dd:c0d4    cmp       al,2C
    79dd:c0d6    je        C0E5
    79dd:c0d8    mov       ah,al
    79dd:c0da    sub       ah,30
    79dd:c0dd    jns       C0C7
    79dd:c0df    xlat
    79dd:c0e1    or        al,al
    79dd:c0e3    jns       C0B4
    79dd:c0e5    mov       cl,01
    79dd:c0e7    dec       si
    79dd:c0e8    mov       byte ptr ss:[248C],cl
    79dd:c0ed    lodsb
    79dd:c0ee    cmp       al,2C
    79dd:c0f0    je        C0F5
    79dd:c0f2    jmp       EAERR
    79dd:c0f5    call      CODEDREGSREG_ROU
    79dd:c0f8    call      M_SUBCONT
    79dd:c0fb    mov       ds,word ptr ss:[2494]
    79dd:c100    mov       si,word ptr ss:[2496]
    79dd:c105    ret
             M_SBC:
    79dd:c106    mov       al,byte ptr [si]
    79dd:c108    xlat
    79dd:c10a    or        al,al
    79dd:c10c    js        C111
    79dd:c10e    jmp       PM
    79dd:c111    lodsb
    79dd:c112    xlat
    79dd:c114    or        al,al
    79dd:c116    js        C111
    79dd:c118    dec       si
    79dd:c119    mov       bp,si
    79dd:c11b    xor       cl,cl
    79dd:c11d    lodsb
    79dd:c11e    cmp       al,2C
    79dd:c120    jne       C126
    79dd:c122    inc       cl
    79dd:c124    jmp       C11D
    79dd:c126    xlat
    79dd:c128    or        al,al
    79dd:c12a    jns       C11D
    79dd:c12c    mov       si,bp
    79dd:c12e    cmp       cl,02
    79dd:c131    je        M_SBC3
             M_SBCCONT:
    79dd:c133    lodsb
    79dd:c134    xlat
    79dd:c136    or        al,al
    79dd:c138    js        M_SBCCONT
    79dd:c13a    dec       si
    79dd:c13b    lodsb
    79dd:c13c    and       al,DF
    79dd:c13e    cmp       al,52
    79dd:c140    jne       C155
    79dd:c142    lodsb
    79dd:c143    sub       al,30
    79dd:c145    js        C154
    79dd:c147    cmp       al,09
    79dd:c149    jg        C154
    79dd:c14b    cmp       al,01
    79dd:c14d    je        C172
    79dd:c14f    mov       cl,al
    79dd:c151    jmp       C18B
    79dd:c153    dec       si
    79dd:c154    dec       si
    79dd:c155    dec       si
    79dd:c156    push      dx
    79dd:c157    call      CONVEXPRESS
    79dd:c15a    pop       dx
    79dd:c15b    test      byte ptr ss:[0ACE],04
    79dd:c161    jne       C18B
    79dd:c163    jmp       GREGERR
    79dd:c166    cmp       ah,05
    79dd:c169    jg        C153
    79dd:c16b    add       ah,0A
    79dd:c16e    mov       cl,ah
    79dd:c170    jmp       C18B
    79dd:c172    lodsb
    79dd:c173    cmp       al,5D
    79dd:c175    je        C188
    79dd:c177    cmp       al,2C
    79dd:c179    je        C188
    79dd:c17b    mov       ah,al
    79dd:c17d    sub       ah,30
    79dd:c180    jns       C166
    79dd:c182    xlat
    79dd:c184    or        al,al
    79dd:c186    jns       C153
    79dd:c188    mov       cl,01
    79dd:c18a    dec       si
    79dd:c18b    add       cl,60
    79dd:c18e    mov       al,byte ptr [si]
    79dd:c190    xlat
    79dd:c192    or        al,al
    79dd:c194    js        C199
    79dd:c196    jmp       PM
    79dd:c199    mov       al,3D
    79dd:c19b    mov       ah,cl
    79dd:c19d    stosw
    79dd:c19e    ret
             M_SBC3:
    79dd:c19f    lodsb
    79dd:c1a0    and       al,DF
    79dd:c1a2    cmp       al,52
    79dd:c1a4    jne       C1B9
    79dd:c1a6    lodsb
    79dd:c1a7    sub       al,30
    79dd:c1a9    js        C1B8
    79dd:c1ab    cmp       al,09
    79dd:c1ad    jg        C1B8
    79dd:c1af    cmp       al,01
    79dd:c1b1    je        C1D6
    79dd:c1b3    mov       cl,al
    79dd:c1b5    jmp       C1EB
    79dd:c1b7    dec       si
    79dd:c1b8    dec       si
    79dd:c1b9    dec       si
    79dd:c1ba    push      dx
    79dd:c1bb    call      CONVEXPRESS
    79dd:c1be    pop       dx
    79dd:c1bf    test      byte ptr ss:[0ACE],04
    79dd:c1c5    jne       C1EB
    79dd:c1c7    jmp       GREGERR
    79dd:c1ca    cmp       ah,05
    79dd:c1cd    jg        C1B7
    79dd:c1cf    add       ah,0A
    79dd:c1d2    mov       cl,ah
    79dd:c1d4    jmp       C1EB
    79dd:c1d6    lodsb
    79dd:c1d7    cmp       al,2C
    79dd:c1d9    je        C1E8
    79dd:c1db    mov       ah,al
    79dd:c1dd    sub       ah,30
    79dd:c1e0    jns       C1CA
    79dd:c1e2    xlat
    79dd:c1e4    or        al,al
    79dd:c1e6    jns       C1B7
    79dd:c1e8    mov       cl,01
    79dd:c1ea    dec       si
    79dd:c1eb    mov       byte ptr ss:[248D],cl
    79dd:c1f0    lodsb
    79dd:c1f1    cmp       al,2C
    79dd:c1f3    je        C1F8
    79dd:c1f5    jmp       EAERR
    79dd:c1f8    lodsb
    79dd:c1f9    and       al,DF
    79dd:c1fb    cmp       al,52
    79dd:c1fd    jne       C212
    79dd:c1ff    lodsb
    79dd:c200    sub       al,30
    79dd:c202    js        C211
    79dd:c204    cmp       al,09
    79dd:c206    jg        C211
    79dd:c208    cmp       al,01
    79dd:c20a    je        C22F
    79dd:c20c    mov       cl,al
    79dd:c20e    jmp       C244
    79dd:c210    dec       si
    79dd:c211    dec       si
    79dd:c212    dec       si
    79dd:c213    push      dx
    79dd:c214    call      CONVEXPRESS
    79dd:c217    pop       dx
    79dd:c218    test      byte ptr ss:[0ACE],04
    79dd:c21e    jne       C244
    79dd:c220    jmp       GREGERR
    79dd:c223    cmp       ah,05
    79dd:c226    jg        C210
    79dd:c228    add       ah,0A
    79dd:c22b    mov       cl,ah
    79dd:c22d    jmp       C244
    79dd:c22f    lodsb
    79dd:c230    cmp       al,2C
    79dd:c232    je        C241
    79dd:c234    mov       ah,al
    79dd:c236    sub       ah,30
    79dd:c239    jns       C223
    79dd:c23b    xlat
    79dd:c23d    or        al,al
    79dd:c23f    jns       C210
    79dd:c241    mov       cl,01
    79dd:c243    dec       si
    79dd:c244    mov       byte ptr ss:[248C],cl
    79dd:c249    lodsb
    79dd:c24a    cmp       al,2C
    79dd:c24c    je        C251
    79dd:c24e    jmp       EAERR
    79dd:c251    call      CODEDREGSREG_ROU
    79dd:c254    call      M_SBCCONT
    79dd:c257    mov       ds,word ptr ss:[2494]
    79dd:c25c    mov       si,word ptr ss:[2496]
    79dd:c261    ret
             M_SM:
    79dd:c262    dec       si
    79dd:c263    mov       al,byte ptr [si]
    79dd:c265    xlat
    79dd:c267    or        al,al
    79dd:c269    js        C26E
    79dd:c26b    jmp       PM
    79dd:c26e    lodsb
    79dd:c26f    xlat
    79dd:c271    or        al,al
    79dd:c273    js        C26E
    79dd:c275    dec       si
    79dd:c276    lodsb
    79dd:c277    cmp       al,5B
    79dd:c279    je        C27E
    79dd:c27b    jmp       M_SMERR
    79dd:c27e    call      CONVEXPRESS
    79dd:c281    lodsw
    79dd:c282    cmp       al,5D
    79dd:c284    je        C289
    79dd:c286    jmp       M_SMERR1
    79dd:c289    cmp       ah,2C
    79dd:c28c    je        C291
    79dd:c28e    jmp       M_SMERR2
    79dd:c291    push      cx
    79dd:c292    lodsb
    79dd:c293    and       al,DF
    79dd:c295    cmp       al,52
    79dd:c297    jne       C2AC
    79dd:c299    lodsb
    79dd:c29a    sub       al,30
    79dd:c29c    js        C2AB
    79dd:c29e    cmp       al,09
    79dd:c2a0    jg        C2AB
    79dd:c2a2    cmp       al,01
    79dd:c2a4    je        C2C9
    79dd:c2a6    mov       cl,al
    79dd:c2a8    jmp       C2E2
    79dd:c2aa    dec       si
    79dd:c2ab    dec       si
    79dd:c2ac    dec       si
    79dd:c2ad    push      dx
    79dd:c2ae    call      CONVEXPRESS
    79dd:c2b1    pop       dx
    79dd:c2b2    test      byte ptr ss:[0ACE],04
    79dd:c2b8    jne       C2E2
    79dd:c2ba    jmp       GREGERR
    79dd:c2bd    cmp       ah,05
    79dd:c2c0    jg        C2AA
    79dd:c2c2    add       ah,0A
    79dd:c2c5    mov       cl,ah
    79dd:c2c7    jmp       C2E2
    79dd:c2c9    lodsb
    79dd:c2ca    cmp       al,5D
    79dd:c2cc    je        C2E0
    79dd:c2ce    cmp       al,2C
    79dd:c2d0    je        C2DF
    79dd:c2d2    mov       ah,al
    79dd:c2d4    sub       ah,30
    79dd:c2d7    jns       C2BD
    79dd:c2d9    xlat
    79dd:c2db    or        al,al
    79dd:c2dd    jns       C2AA
    79dd:c2df    dec       si
    79dd:c2e0    mov       cl,01
    79dd:c2e2    add       cl,F0
    79dd:c2e5    mov       ch,3E
    79dd:c2e7    xchg      ch,cl
    79dd:c2e9    pop       dx
    79dd:c2ea    test      byte ptr ss:[0ACE],C0
    79dd:c2f0    jne       C2F5
    79dd:c2f2    jmp       C379
    79dd:c2f5    test      byte ptr ss:[0ACE],40
    79dd:c2fb    jne       C32C
    79dd:c2fd    push      es
    79dd:c2fe    push      bp
    79dd:c2ff    mov       es,word ptr ss:[0AC5]
    79dd:c304    mov       bp,word ptr ss:[0AC9]
    79dd:c309    mov       word ptr es:[bp+06],di
    79dd:c30d    inc       word ptr es:[bp+06]
    79dd:c311    mov       word ptr es:[bp+02],0002
    79dd:c317    add       bp,15
    79dd:c31a    mov       word ptr ss:[0AC7],bp
    79dd:c31f    cmp       bp,7F00
    79dd:c323    jb        C328
    79dd:c325    call      MOREFR
    79dd:c328    pop       bp
    79dd:c329    pop       es
    79dd:c32a    jmp       C379
    79dd:c32c    push      es
    79dd:c32d    push      bp
    79dd:c32e    push      cx
    79dd:c32f    push      ax
    79dd:c330    mov       es,word ptr ss:[13A6]
    79dd:c335    mov       bp,word ptr ss:[13A8]
    79dd:c33a    mov       ax,di
    79dd:c33c    sub       ax,word ptr ss:[13B4]
    79dd:c341    xor       cx,cx
    79dd:c343    add       ax,word ptr ss:[13BE]
    79dd:c348    adc       cx,word ptr ss:[13BC]
    79dd:c34d    mov       word ptr es:[bp+00],ax
    79dd:c351    mov       word ptr es:[bp+02],cx
    79dd:c355    mov       byte ptr es:[bp+04],02
    79dd:c35a    add       word ptr es:[bp+00],01
    79dd:c35f    adc       word ptr es:[bp+02],00
    79dd:c364    add       bp,05
    79dd:c367    mov       word ptr ss:[13A8],bp
    79dd:c36c    cmp       bp,3F00
    79dd:c370    jb        C375
    79dd:c372    call      MOREEXT
    79dd:c375    pop       ax
    79dd:c376    pop       cx
    79dd:c377    pop       bp
    79dd:c378    pop       es
    79dd:c379    mov       al,byte ptr [si]
    79dd:c37b    xlat
    79dd:c37d    or        al,al
    79dd:c37f    js        C384
    79dd:c381    jmp       PM
    79dd:c384    mov       ax,cx
    79dd:c386    stosw
    79dd:c387    mov       ax,dx
    79dd:c389    stosw
    79dd:c38a    ret
             M_SMERR:
    79dd:c38b    push      dx
    79dd:c38c    mov       dx,8285
    79dd:c38f    call      ERROR_ROUT
    79dd:c392    pop       dx
    79dd:c393    ret
             M_SMERR1:
    79dd:c394    push      dx
    79dd:c395    mov       dx,8291
    79dd:c398    call      ERROR_ROUT
    79dd:c39b    pop       dx
    79dd:c39c    ret
             M_SMERR2:
    79dd:c39d    push      dx
    79dd:c39e    mov       dx,8276
    79dd:c3a1    call      ERROR_ROUT
    79dd:c3a4    pop       dx
    79dd:c3a5    ret
             M_SMS:
    79dd:c3a6    mov       al,byte ptr [si]
    79dd:c3a8    xlat
    79dd:c3aa    or        al,al
    79dd:c3ac    js        C3B1
    79dd:c3ae    jmp       PM
    79dd:c3b1    lodsb
    79dd:c3b2    xlat
    79dd:c3b4    or        al,al
    79dd:c3b6    js        C3B1
    79dd:c3b8    dec       si
    79dd:c3b9    lodsb
    79dd:c3ba    cmp       al,5B
    79dd:c3bc    jne       M_SMERR
    79dd:c3be    call      CONVEXPRESS
    79dd:c3c1    cmp       cx,00
    79dd:c3c4    jns       C3C9
    79dd:c3c6    jmp       REGNERR
    79dd:c3c9    cmp       cx,01FF
    79dd:c3cd    jle       C3D2
    79dd:c3cf    jmp       REGNERR
    79dd:c3d2    test      cx,0001
    79dd:c3d6    je        C3DB
    79dd:c3d8    jmp       E_LMSODD
    79dd:c3db    shr       cx,1
    79dd:c3dd    lodsw
    79dd:c3de    cmp       al,5D
    79dd:c3e0    jne       M_SMERR1
    79dd:c3e2    cmp       ah,2C
    79dd:c3e5    jne       M_SMERR2
    79dd:c3e7    push      cx
    79dd:c3e8    lodsb
    79dd:c3e9    and       al,DF
    79dd:c3eb    cmp       al,52
    79dd:c3ed    jne       C402
    79dd:c3ef    lodsb
    79dd:c3f0    sub       al,30
    79dd:c3f2    js        C401
    79dd:c3f4    cmp       al,09
    79dd:c3f6    jg        C401
    79dd:c3f8    cmp       al,01
    79dd:c3fa    je        C41F
    79dd:c3fc    mov       cl,al
    79dd:c3fe    jmp       C438
    79dd:c400    dec       si
    79dd:c401    dec       si
    79dd:c402    dec       si
    79dd:c403    push      dx
    79dd:c404    call      CONVEXPRESS
    79dd:c407    pop       dx
    79dd:c408    test      byte ptr ss:[0ACE],04
    79dd:c40e    jne       C438
    79dd:c410    jmp       GREGERR
    79dd:c413    cmp       ah,05
    79dd:c416    jg        C400
    79dd:c418    add       ah,0A
    79dd:c41b    mov       cl,ah
    79dd:c41d    jmp       C438
    79dd:c41f    lodsb
    79dd:c420    cmp       al,5D
    79dd:c422    je        C436
    79dd:c424    cmp       al,2C
    79dd:c426    je        C435
    79dd:c428    mov       ah,al
    79dd:c42a    sub       ah,30
    79dd:c42d    jns       C413
    79dd:c42f    xlat
    79dd:c431    or        al,al
    79dd:c433    jns       C400
    79dd:c435    dec       si
    79dd:c436    mov       cl,01
    79dd:c438    add       cl,A0
    79dd:c43b    mov       ch,3E
    79dd:c43d    xchg      ch,cl
    79dd:c43f    pop       dx
    79dd:c440    test      byte ptr ss:[0ACE],C0
    79dd:c446    jne       C44B
    79dd:c448    jmp       C4CF
    79dd:c44b    test      byte ptr ss:[0ACE],40
    79dd:c451    jne       C482
    79dd:c453    push      es
    79dd:c454    push      bp
    79dd:c455    mov       es,word ptr ss:[0AC5]
    79dd:c45a    mov       bp,word ptr ss:[0AC9]
    79dd:c45f    mov       word ptr es:[bp+06],di
    79dd:c463    inc       word ptr es:[bp+06]
    79dd:c467    mov       word ptr es:[bp+02],0012
    79dd:c46d    add       bp,15
    79dd:c470    mov       word ptr ss:[0AC7],bp
    79dd:c475    cmp       bp,7F00
    79dd:c479    jb        C47E
    79dd:c47b    call      MOREFR
    79dd:c47e    pop       bp
    79dd:c47f    pop       es
    79dd:c480    jmp       C4CF
    79dd:c482    push      es
    79dd:c483    push      bp
    79dd:c484    push      cx
    79dd:c485    push      ax
    79dd:c486    mov       es,word ptr ss:[13A6]
    79dd:c48b    mov       bp,word ptr ss:[13A8]
    79dd:c490    mov       ax,di
    79dd:c492    sub       ax,word ptr ss:[13B4]
    79dd:c497    xor       cx,cx
    79dd:c499    add       ax,word ptr ss:[13BE]
    79dd:c49e    adc       cx,word ptr ss:[13BC]
    79dd:c4a3    mov       word ptr es:[bp+00],ax
    79dd:c4a7    mov       word ptr es:[bp+02],cx
    79dd:c4ab    mov       byte ptr es:[bp+04],12
    79dd:c4b0    add       word ptr es:[bp+00],01
    79dd:c4b5    adc       word ptr es:[bp+02],00
    79dd:c4ba    add       bp,05
    79dd:c4bd    mov       word ptr ss:[13A8],bp
    79dd:c4c2    cmp       bp,3F00
    79dd:c4c6    jb        C4CB
    79dd:c4c8    call      MOREEXT
    79dd:c4cb    pop       ax
    79dd:c4cc    pop       cx
    79dd:c4cd    pop       bp
    79dd:c4ce    pop       es
    79dd:c4cf    mov       ax,cx
    79dd:c4d1    stosw
    79dd:c4d2    mov       al,byte ptr [si]
    79dd:c4d4    xlat
    79dd:c4d6    or        al,al
    79dd:c4d8    js        C4DD
    79dd:c4da    jmp       PM
    79dd:c4dd    mov       al,dl
    79dd:c4df    stosb
    79dd:c4e0    ret
             M_SWA:
    79dd:c4e1    lodsb
    79dd:c4e2    and       al,DF
    79dd:c4e4    cmp       al,50
    79dd:c4e6    je        C4EB
    79dd:c4e8    jmp       PM
    79dd:c4eb    mov       al,byte ptr [si]
    79dd:c4ed    xlat
    79dd:c4ef    or        al,al
    79dd:c4f1    js        C4F6
    79dd:c4f3    jmp       PM
    79dd:c4f6    mov       al,byte ptr [si]
    79dd:c4f8    xlat
    79dd:c4fa    or        al,al
    79dd:c4fc    js        C501
    79dd:c4fe    jmp       PM
    79dd:c501    mov       al,4D
    79dd:c503    stosb
    79dd:c504    ret
             M_TO:
    79dd:c505    mov       al,byte ptr [si]
    79dd:c507    xlat
    79dd:c509    or        al,al
    79dd:c50b    js        C510
    79dd:c50d    jmp       PM
    79dd:c510    lodsb
    79dd:c511    xlat
    79dd:c513    or        al,al
    79dd:c515    js        C510
    79dd:c517    dec       si
    79dd:c518    lodsb
    79dd:c519    and       al,DF
    79dd:c51b    cmp       al,52
    79dd:c51d    jne       C532
    79dd:c51f    lodsb
    79dd:c520    sub       al,30
    79dd:c522    js        C531
    79dd:c524    cmp       al,09
    79dd:c526    jg        C531
    79dd:c528    cmp       al,01
    79dd:c52a    je        C54F
    79dd:c52c    mov       cl,al
    79dd:c52e    jmp       C568
    79dd:c530    dec       si
    79dd:c531    dec       si
    79dd:c532    dec       si
    79dd:c533    push      dx
    79dd:c534    call      CONVEXPRESS
    79dd:c537    pop       dx
    79dd:c538    test      byte ptr ss:[0ACE],04
    79dd:c53e    jne       C568
    79dd:c540    jmp       GREGERR
    79dd:c543    cmp       ah,05
    79dd:c546    jg        C530
    79dd:c548    add       ah,0A
    79dd:c54b    mov       cl,ah
    79dd:c54d    jmp       C568
    79dd:c54f    lodsb
    79dd:c550    cmp       al,5D
    79dd:c552    je        C565
    79dd:c554    cmp       al,2C
    79dd:c556    je        C565
    79dd:c558    mov       ah,al
    79dd:c55a    sub       ah,30
    79dd:c55d    jns       C543
    79dd:c55f    xlat
    79dd:c561    or        al,al
    79dd:c563    jns       C530
    79dd:c565    mov       cl,01
    79dd:c567    dec       si
    79dd:c568    add       cl,10
    79dd:c56b    mov       al,byte ptr [si]
    79dd:c56d    xlat
    79dd:c56f    or        al,al
    79dd:c571    js        C576
    79dd:c573    jmp       PM
    79dd:c576    mov       al,cl
    79dd:c578    stosb
    79dd:c579    ret
             M_UMU:
    79dd:c57a    lodsw
    79dd:c57b    and       ax,DFDF
    79dd:c57e    cmp       ax,544C
    79dd:c581    je        C586
    79dd:c583    jmp       PM
    79dd:c586    mov       al,byte ptr [si]
    79dd:c588    xlat
    79dd:c58a    or        al,al
    79dd:c58c    js        C591
    79dd:c58e    jmp       PM
    79dd:c591    lodsb
    79dd:c592    xlat
    79dd:c594    or        al,al
    79dd:c596    js        C591
    79dd:c598    dec       si
    79dd:c599    mov       al,byte ptr [si]
    79dd:c59b    cmp       al,23
    79dd:c59d    je        C603
    79dd:c59f    lodsb
    79dd:c5a0    and       al,DF
    79dd:c5a2    cmp       al,52
    79dd:c5a4    jne       C5B9
    79dd:c5a6    lodsb
    79dd:c5a7    sub       al,30
    79dd:c5a9    js        C5B8
    79dd:c5ab    cmp       al,09
    79dd:c5ad    jg        C5B8
    79dd:c5af    cmp       al,01
    79dd:c5b1    je        C5D6
    79dd:c5b3    mov       cl,al
    79dd:c5b5    jmp       C5EF
    79dd:c5b7    dec       si
    79dd:c5b8    dec       si
    79dd:c5b9    dec       si
    79dd:c5ba    push      dx
    79dd:c5bb    call      CONVEXPRESS
    79dd:c5be    pop       dx
    79dd:c5bf    test      byte ptr ss:[0ACE],04
    79dd:c5c5    jne       C5EF
    79dd:c5c7    jmp       GREGERR
    79dd:c5ca    cmp       ah,05
    79dd:c5cd    jg        C5B7
    79dd:c5cf    add       ah,0A
    79dd:c5d2    mov       cl,ah
    79dd:c5d4    jmp       C5EF
    79dd:c5d6    lodsb
    79dd:c5d7    cmp       al,5D
    79dd:c5d9    je        C5EC
    79dd:c5db    cmp       al,2C
    79dd:c5dd    je        C5EC
    79dd:c5df    mov       ah,al
    79dd:c5e1    sub       ah,30
    79dd:c5e4    jns       C5CA
    79dd:c5e6    xlat
    79dd:c5e8    or        al,al
    79dd:c5ea    jns       C5B7
    79dd:c5ec    mov       cl,01
    79dd:c5ee    dec       si
    79dd:c5ef    add       cl,80
    79dd:c5f2    mov       al,byte ptr [si]
    79dd:c5f4    xlat
    79dd:c5f6    or        al,al
    79dd:c5f8    js        C5FD
    79dd:c5fa    jmp       PM
    79dd:c5fd    mov       al,3D
    79dd:c5ff    mov       ah,cl
    79dd:c601    stosw
    79dd:c602    ret
    79dd:c603    inc       si
    79dd:c604    call      CONVEXPRESS
    79dd:c607    cmp       dx,00
    79dd:c60a    je        C60F
    79dd:c60c    jmp       REGNERR
    79dd:c60f    cmp       cx,0F
    79dd:c612    jle       C617
    79dd:c614    jmp       REGNERR
    79dd:c617    add       cl,80
    79dd:c61a    test      byte ptr ss:[0ACE],C0
    79dd:c620    je        C698
    79dd:c622    test      byte ptr ss:[0ACE],40
    79dd:c628    jne       C655
    79dd:c62a    push      es
    79dd:c62b    push      bp
    79dd:c62c    mov       es,word ptr ss:[0AC5]
    79dd:c631    mov       bp,word ptr ss:[0AC9]
    79dd:c636    mov       word ptr es:[bp+06],di
    79dd:c63a    mov       word ptr es:[bp+02],000C
    79dd:c640    add       bp,15
    79dd:c643    mov       word ptr ss:[0AC7],bp
    79dd:c648    cmp       bp,7F00
    79dd:c64c    jb        C651
    79dd:c64e    call      MOREFR
    79dd:c651    pop       bp
    79dd:c652    pop       es
    79dd:c653    jmp       C698
    79dd:c655    push      es
    79dd:c656    push      bp
    79dd:c657    push      cx
    79dd:c658    push      ax
    79dd:c659    mov       es,word ptr ss:[13A6]
    79dd:c65e    mov       bp,word ptr ss:[13A8]
    79dd:c663    mov       ax,di
    79dd:c665    sub       ax,word ptr ss:[13B4]
    79dd:c66a    xor       cx,cx
    79dd:c66c    add       ax,word ptr ss:[13BE]
    79dd:c671    adc       cx,word ptr ss:[13BC]
    79dd:c676    mov       word ptr es:[bp+00],ax
    79dd:c67a    mov       word ptr es:[bp+02],cx
    79dd:c67e    mov       byte ptr es:[bp+04],0C
    79dd:c683    add       bp,05
    79dd:c686    mov       word ptr ss:[13A8],bp
    79dd:c68b    cmp       bp,3F00
    79dd:c68f    jb        C694
    79dd:c691    call      MOREEXT
    79dd:c694    pop       ax
    79dd:c695    pop       cx
    79dd:c696    pop       bp
    79dd:c697    pop       es
    79dd:c698    mov       al,byte ptr [si]
    79dd:c69a    xlat
    79dd:c69c    or        al,al
    79dd:c69e    js        C6A3
    79dd:c6a0    jmp       PM
    79dd:c6a3    mov       al,3F
    79dd:c6a5    mov       ah,cl
    79dd:c6a7    stosw
    79dd:c6a8    ret
             M_WIT:
    79dd:c6a9    lodsb
    79dd:c6aa    and       al,DF
    79dd:c6ac    cmp       al,48
    79dd:c6ae    je        C6B3
    79dd:c6b0    jmp       PM
    79dd:c6b3    mov       al,byte ptr [si]
    79dd:c6b5    xlat
    79dd:c6b7    or        al,al
    79dd:c6b9    js        C6BE
    79dd:c6bb    jmp       PM
    79dd:c6be    lodsb
    79dd:c6bf    xlat
    79dd:c6c1    or        al,al
    79dd:c6c3    js        C6BE
    79dd:c6c5    dec       si
    79dd:c6c6    lodsb
    79dd:c6c7    and       al,DF
    79dd:c6c9    cmp       al,52
    79dd:c6cb    jne       C6E0
    79dd:c6cd    lodsb
    79dd:c6ce    sub       al,30
    79dd:c6d0    js        C6DF
    79dd:c6d2    cmp       al,09
    79dd:c6d4    jg        C6DF
    79dd:c6d6    cmp       al,01
    79dd:c6d8    je        C6FD
    79dd:c6da    mov       cl,al
    79dd:c6dc    jmp       C716
    79dd:c6de    dec       si
    79dd:c6df    dec       si
    79dd:c6e0    dec       si
    79dd:c6e1    push      dx
    79dd:c6e2    call      CONVEXPRESS
    79dd:c6e5    pop       dx
    79dd:c6e6    test      byte ptr ss:[0ACE],04
    79dd:c6ec    jne       C716
    79dd:c6ee    jmp       GREGERR
    79dd:c6f1    cmp       ah,05
    79dd:c6f4    jg        C6DE
    79dd:c6f6    add       ah,0A
    79dd:c6f9    mov       cl,ah
    79dd:c6fb    jmp       C716
    79dd:c6fd    lodsb
    79dd:c6fe    cmp       al,5D
    79dd:c700    je        C713
    79dd:c702    cmp       al,2C
    79dd:c704    je        C713
    79dd:c706    mov       ah,al
    79dd:c708    sub       ah,30
    79dd:c70b    jns       C6F1
    79dd:c70d    xlat
    79dd:c70f    or        al,al
    79dd:c711    jns       C6DE
    79dd:c713    mov       cl,01
    79dd:c715    dec       si
    79dd:c716    add       cl,20
    79dd:c719    mov       al,byte ptr [si]
    79dd:c71b    xlat
    79dd:c71d    or        al,al
    79dd:c71f    js        C724
    79dd:c721    jmp       PM
    79dd:c724    mov       al,cl
    79dd:c726    stosb
    79dd:c727    ret
             M_XOR:
    79dd:c728    mov       al,byte ptr [si]
    79dd:c72a    xlat
    79dd:c72c    or        al,al
    79dd:c72e    js        C733
    79dd:c730    jmp       PM
    79dd:c733    lodsb
    79dd:c734    xlat
    79dd:c736    or        al,al
    79dd:c738    js        C733
    79dd:c73a    dec       si
    79dd:c73b    mov       bp,si
    79dd:c73d    xor       cl,cl
    79dd:c73f    lodsb
    79dd:c740    cmp       al,2C
    79dd:c742    jne       C748
    79dd:c744    inc       cl
    79dd:c746    jmp       C73F
    79dd:c748    xlat
    79dd:c74a    or        al,al
    79dd:c74c    jns       C73F
    79dd:c74e    mov       si,bp
    79dd:c750    cmp       cl,02
    79dd:c753    jne       M_XORCONT
    79dd:c755    jmp       M_XOR3
             M_XORCONT:
    79dd:c758    lodsb
    79dd:c759    xlat
    79dd:c75b    or        al,al
    79dd:c75d    js        M_XORCONT
    79dd:c75f    dec       si
    79dd:c760    mov       al,byte ptr [si]
    79dd:c762    cmp       al,23
    79dd:c764    je        C7D2
    79dd:c766    lodsb
    79dd:c767    and       al,DF
    79dd:c769    cmp       al,52
    79dd:c76b    jne       C780
    79dd:c76d    lodsb
    79dd:c76e    sub       al,30
    79dd:c770    js        C77F
    79dd:c772    cmp       al,09
    79dd:c774    jg        C77F
    79dd:c776    cmp       al,01
    79dd:c778    je        C79D
    79dd:c77a    mov       cl,al
    79dd:c77c    jmp       C7B6
    79dd:c77e    dec       si
    79dd:c77f    dec       si
    79dd:c780    dec       si
    79dd:c781    push      dx
    79dd:c782    call      CONVEXPRESS
    79dd:c785    pop       dx
    79dd:c786    test      byte ptr ss:[0ACE],04
    79dd:c78c    jne       C7B6
    79dd:c78e    jmp       GREGERR
    79dd:c791    cmp       ah,05
    79dd:c794    jg        C77E
    79dd:c796    add       ah,0A
    79dd:c799    mov       cl,ah
    79dd:c79b    jmp       C7B6
    79dd:c79d    lodsb
    79dd:c79e    cmp       al,5D
    79dd:c7a0    je        C7B3
    79dd:c7a2    cmp       al,2C
    79dd:c7a4    je        C7B3
    79dd:c7a6    mov       ah,al
    79dd:c7a8    sub       ah,30
    79dd:c7ab    jns       C791
    79dd:c7ad    xlat
    79dd:c7af    or        al,al
    79dd:c7b1    jns       C77E
    79dd:c7b3    mov       cl,01
    79dd:c7b5    dec       si
    79dd:c7b6    cmp       cl,00
    79dd:c7b9    jne       C7BE
    79dd:c7bb    jmp       GREGERR
    79dd:c7be    add       cl,C0
    79dd:c7c1    mov       al,byte ptr [si]
    79dd:c7c3    xlat
    79dd:c7c5    or        al,al
    79dd:c7c7    js        C7CC
    79dd:c7c9    jmp       PM
    79dd:c7cc    mov       al,3D
    79dd:c7ce    mov       ah,cl
    79dd:c7d0    stosw
    79dd:c7d1    ret
    79dd:c7d2    inc       si
    79dd:c7d3    call      CONVEXPRESS
    79dd:c7d6    cmp       dx,00
    79dd:c7d9    je        C7DE
    79dd:c7db    jmp       REGNERR
    79dd:c7de    cmp       cx,0F
    79dd:c7e1    jle       C7E6
    79dd:c7e3    jmp       REGNERR
    79dd:c7e6    cmp       cl,00
    79dd:c7e9    jne       C7EE
    79dd:c7eb    jmp       REGNERR
    79dd:c7ee    add       cl,C0
    79dd:c7f1    test      byte ptr ss:[0ACE],C0
    79dd:c7f7    je        C86F
    79dd:c7f9    test      byte ptr ss:[0ACE],40
    79dd:c7ff    jne       C82C
    79dd:c801    push      es
    79dd:c802    push      bp
    79dd:c803    mov       es,word ptr ss:[0AC5]
    79dd:c808    mov       bp,word ptr ss:[0AC9]
    79dd:c80d    mov       word ptr es:[bp+06],di
    79dd:c811    mov       word ptr es:[bp+02],000C
    79dd:c817    add       bp,15
    79dd:c81a    mov       word ptr ss:[0AC7],bp
    79dd:c81f    cmp       bp,7F00
    79dd:c823    jb        C828
    79dd:c825    call      MOREFR
    79dd:c828    pop       bp
    79dd:c829    pop       es
    79dd:c82a    jmp       C86F
    79dd:c82c    push      es
    79dd:c82d    push      bp
    79dd:c82e    push      cx
    79dd:c82f    push      ax
    79dd:c830    mov       es,word ptr ss:[13A6]
    79dd:c835    mov       bp,word ptr ss:[13A8]
    79dd:c83a    mov       ax,di
    79dd:c83c    sub       ax,word ptr ss:[13B4]
    79dd:c841    xor       cx,cx
    79dd:c843    add       ax,word ptr ss:[13BE]
    79dd:c848    adc       cx,word ptr ss:[13BC]
    79dd:c84d    mov       word ptr es:[bp+00],ax
    79dd:c851    mov       word ptr es:[bp+02],cx
    79dd:c855    mov       byte ptr es:[bp+04],0C
    79dd:c85a    add       bp,05
    79dd:c85d    mov       word ptr ss:[13A8],bp
    79dd:c862    cmp       bp,3F00
    79dd:c866    jb        C86B
    79dd:c868    call      MOREEXT
    79dd:c86b    pop       ax
    79dd:c86c    pop       cx
    79dd:c86d    pop       bp
    79dd:c86e    pop       es
    79dd:c86f    mov       al,byte ptr [si]
    79dd:c871    xlat
    79dd:c873    or        al,al
    79dd:c875    js        C87A
    79dd:c877    jmp       PM
    79dd:c87a    mov       al,3F
    79dd:c87c    mov       ah,cl
    79dd:c87e    stosw
    79dd:c87f    ret
             M_XOR3:
    79dd:c880    lodsb
    79dd:c881    and       al,DF
    79dd:c883    cmp       al,52
    79dd:c885    jne       C89A
    79dd:c887    lodsb
    79dd:c888    sub       al,30
    79dd:c88a    js        C899
    79dd:c88c    cmp       al,09
    79dd:c88e    jg        C899
    79dd:c890    cmp       al,01
    79dd:c892    je        C8B7
    79dd:c894    mov       cl,al
    79dd:c896    jmp       C8CC
    79dd:c898    dec       si
    79dd:c899    dec       si
    79dd:c89a    dec       si
    79dd:c89b    push      dx
    79dd:c89c    call      CONVEXPRESS
    79dd:c89f    pop       dx
    79dd:c8a0    test      byte ptr ss:[0ACE],04
    79dd:c8a6    jne       C8CC
    79dd:c8a8    jmp       GREGERR
    79dd:c8ab    cmp       ah,05
    79dd:c8ae    jg        C898
    79dd:c8b0    add       ah,0A
    79dd:c8b3    mov       cl,ah
    79dd:c8b5    jmp       C8CC
    79dd:c8b7    lodsb
    79dd:c8b8    cmp       al,2C
    79dd:c8ba    je        C8C9
    79dd:c8bc    mov       ah,al
    79dd:c8be    sub       ah,30
    79dd:c8c1    jns       C8AB
    79dd:c8c3    xlat
    79dd:c8c5    or        al,al
    79dd:c8c7    jns       C898
    79dd:c8c9    mov       cl,01
    79dd:c8cb    dec       si
    79dd:c8cc    mov       byte ptr ss:[248D],cl
    79dd:c8d1    lodsb
    79dd:c8d2    cmp       al,2C
    79dd:c8d4    je        C8D9
    79dd:c8d6    jmp       EAERR
    79dd:c8d9    lodsb
    79dd:c8da    and       al,DF
    79dd:c8dc    cmp       al,52
    79dd:c8de    jne       C8F3
    79dd:c8e0    lodsb
    79dd:c8e1    sub       al,30
    79dd:c8e3    js        C8F2
    79dd:c8e5    cmp       al,09
    79dd:c8e7    jg        C8F2
    79dd:c8e9    cmp       al,01
    79dd:c8eb    je        C910
    79dd:c8ed    mov       cl,al
    79dd:c8ef    jmp       C925
    79dd:c8f1    dec       si
    79dd:c8f2    dec       si
    79dd:c8f3    dec       si
    79dd:c8f4    push      dx
    79dd:c8f5    call      CONVEXPRESS
    79dd:c8f8    pop       dx
    79dd:c8f9    test      byte ptr ss:[0ACE],04
    79dd:c8ff    jne       C925
    79dd:c901    jmp       GREGERR
    79dd:c904    cmp       ah,05
    79dd:c907    jg        C8F1
    79dd:c909    add       ah,0A
    79dd:c90c    mov       cl,ah
    79dd:c90e    jmp       C925
    79dd:c910    lodsb
    79dd:c911    cmp       al,2C
    79dd:c913    je        C922
    79dd:c915    mov       ah,al
    79dd:c917    sub       ah,30
    79dd:c91a    jns       C904
    79dd:c91c    xlat
    79dd:c91e    or        al,al
    79dd:c920    jns       C8F1
    79dd:c922    mov       cl,01
    79dd:c924    dec       si
    79dd:c925    mov       byte ptr ss:[248C],cl
    79dd:c92a    lodsb
    79dd:c92b    cmp       al,2C
    79dd:c92d    je        C932
    79dd:c92f    jmp       EAERR
    79dd:c932    call      CODEDREGSREG_ROU
    79dd:c935    call      M_XORCONT
    79dd:c938    mov       ds,word ptr ss:[2494]
    79dd:c93d    mov       si,word ptr ss:[2496]
    79dd:c942    ret
             CODEDREGSREG_ROU:
    79dd:c943    cmp       byte ptr [si],5B
    79dd:c946    je        C94B
    79dd:c948    jmp       REG2REG
    79dd:c94b    inc       si
    79dd:c94c    mov       byte ptr ss:[248E],00
    79dd:c952    call      CONVEXPRESS
    79dd:c955    lodsb
    79dd:c956    cmp       al,3A
    79dd:c958    jne       REGSPECONT
    79dd:c95a    jmp       REGSPEC
             REGSPECONT:
    79dd:c95d    cmp       al,5D
    79dd:c95f    je        C964
    79dd:c961    jmp       M_LMERR1
    79dd:c964    cmp       cx,00
    79dd:c967    jns       C96C
    79dd:c969    jmp       REGNERR1
    79dd:c96c    cmp       cx,01FF
    79dd:c970    jle       C975
    79dd:c972    jmp       REGNERR1
    79dd:c975    test      cx,0001
    79dd:c979    je        C97E
    79dd:c97b    jmp       E_LMSODD
    79dd:c97e    shr       cx,1
    79dd:c980    mov       al,byte ptr [248E]
    79dd:c984    add       al,A0
    79dd:c986    mov       ah,3D
    79dd:c988    xchg      ah,al
    79dd:c98a    test      byte ptr ss:[0ACE],C0
    79dd:c990    jne       C995
    79dd:c992    jmp       CA19
    79dd:c995    test      byte ptr ss:[0ACE],40
    79dd:c99b    jne       C9CC
    79dd:c99d    push      es
    79dd:c99e    push      bp
    79dd:c99f    mov       es,word ptr ss:[0AC5]
    79dd:c9a4    mov       bp,word ptr ss:[0AC9]
    79dd:c9a9    mov       word ptr es:[bp+06],di
    79dd:c9ad    inc       word ptr es:[bp+06]
    79dd:c9b1    mov       word ptr es:[bp+02],0012
    79dd:c9b7    add       bp,15
    79dd:c9ba    mov       word ptr ss:[0AC7],bp
    79dd:c9bf    cmp       bp,7F00
    79dd:c9c3    jb        C9C8
    79dd:c9c5    call      MOREFR
    79dd:c9c8    pop       bp
    79dd:c9c9    pop       es
    79dd:c9ca    jmp       CA19
    79dd:c9cc    push      es
    79dd:c9cd    push      bp
    79dd:c9ce    push      cx
    79dd:c9cf    push      ax
    79dd:c9d0    mov       es,word ptr ss:[13A6]
    79dd:c9d5    mov       bp,word ptr ss:[13A8]
    79dd:c9da    mov       ax,di
    79dd:c9dc    sub       ax,word ptr ss:[13B4]
    79dd:c9e1    xor       cx,cx
    79dd:c9e3    add       ax,word ptr ss:[13BE]
    79dd:c9e8    adc       cx,word ptr ss:[13BC]
    79dd:c9ed    mov       word ptr es:[bp+00],ax
    79dd:c9f1    mov       word ptr es:[bp+02],cx
    79dd:c9f5    mov       byte ptr es:[bp+04],12
    79dd:c9fa    add       word ptr es:[bp+00],01
    79dd:c9ff    adc       word ptr es:[bp+02],00
    79dd:ca04    add       bp,05
    79dd:ca07    mov       word ptr ss:[13A8],bp
    79dd:ca0c    cmp       bp,3F00
    79dd:ca10    jb        CA15
    79dd:ca12    call      MOREEXT
    79dd:ca15    pop       ax
    79dd:ca16    pop       cx
    79dd:ca17    pop       bp
    79dd:ca18    pop       es
    79dd:ca19    stosw
    79dd:ca1a    mov       al,cl
    79dd:ca1c    stosb
    79dd:ca1d    mov       al,byte ptr [248C]
    79dd:ca21    cmp       al,byte ptr ss:[248D]
    79dd:ca26    je        WITH2
    79dd:ca28    or        al,al
    79dd:ca2a    je        CHKDREG2
    79dd:ca2c    add       al,B0
    79dd:ca2e    stosb
             CHKDREG2:
    79dd:ca2f    mov       al,byte ptr [248D]
    79dd:ca33    or        al,al
    79dd:ca35    je        EXIT2
    79dd:ca37    add       al,10
    79dd:ca39    stosb
    79dd:ca3a    jmp       EXIT2
             WITH2:
    79dd:ca3c    or        al,al
    79dd:ca3e    je        EXIT2
    79dd:ca40    add       al,20
    79dd:ca42    stosb
             EXIT2:
    79dd:ca43    mov       al,52
    79dd:ca45    mov       byte ptr [248F],al
    79dd:ca49    mov       al,byte ptr [248E]
    79dd:ca4d    cmp       al,0A
    79dd:ca4f    jb        DIG1
    79dd:ca51    mov       al,31
    79dd:ca53    mov       byte ptr [2490],al
    79dd:ca57    mov       al,byte ptr [248E]
    79dd:ca5b    sub       al,0A
    79dd:ca5d    add       al,30
    79dd:ca5f    mov       byte ptr [2491],al
    79dd:ca63    mov       byte ptr ss:[2492],0D
    79dd:ca69    mov       byte ptr ss:[2493],0A
    79dd:ca6f    mov       word ptr ss:[2494],ds
    79dd:ca74    mov       word ptr ss:[2496],si
    79dd:ca79    mov       ax,ss
    79dd:ca7b    mov       ds,ax
    79dd:ca7d    mov       si,248F
    79dd:ca80    ret
             DIG1:
    79dd:ca81    add       al,30
    79dd:ca83    mov       byte ptr [2490],al
    79dd:ca87    mov       byte ptr ss:[2491],0D
    79dd:ca8d    mov       byte ptr ss:[2492],0A
    79dd:ca93    mov       word ptr ss:[2494],ds
    79dd:ca98    mov       word ptr ss:[2496],si
    79dd:ca9d    mov       ax,ss
    79dd:ca9f    mov       ds,ax
    79dd:caa1    mov       si,248F
    79dd:caa4    ret
             REGSPEC:
    79dd:caa5    push      cx
    79dd:caa6    lodsb
    79dd:caa7    and       al,DF
    79dd:caa9    cmp       al,52
    79dd:caab    jne       CAC0
    79dd:caad    lodsb
    79dd:caae    sub       al,30
    79dd:cab0    js        CABF
    79dd:cab2    cmp       al,09
    79dd:cab4    jg        CABF
    79dd:cab6    cmp       al,01
    79dd:cab8    je        CADD
    79dd:caba    mov       cl,al
    79dd:cabc    jmp       CAF2
    79dd:cabe    dec       si
    79dd:cabf    dec       si
    79dd:cac0    dec       si
    79dd:cac1    push      dx
    79dd:cac2    call      CONVEXPRESS
    79dd:cac5    pop       dx
    79dd:cac6    test      byte ptr ss:[0ACE],04
    79dd:cacc    jne       CAF2
    79dd:cace    jmp       GREGERR
    79dd:cad1    cmp       ah,05
    79dd:cad4    jg        CABE
    79dd:cad6    add       ah,0A
    79dd:cad9    mov       cl,ah
    79dd:cadb    jmp       CAF2
    79dd:cadd    lodsb
    79dd:cade    cmp       al,2C
    79dd:cae0    je        CAEF
    79dd:cae2    mov       ah,al
    79dd:cae4    sub       ah,30
    79dd:cae7    jns       CAD1
    79dd:cae9    xlat
    79dd:caeb    or        al,al
    79dd:caed    jns       CABE
    79dd:caef    mov       cl,01
    79dd:caf1    dec       si
    79dd:caf2    mov       byte ptr ss:[248E],cl
    79dd:caf7    pop       cx
    79dd:caf8    lodsb
    79dd:caf9    jmp       REGSPECONT
             REG2REG:
    79dd:cafc    mov       al,byte ptr [248C]
    79dd:cb00    cmp       al,byte ptr ss:[248D]
    79dd:cb05    je        WITH
    79dd:cb07    or        al,al
    79dd:cb09    je        CHKDREG
    79dd:cb0b    add       al,B0
    79dd:cb0d    stosb
             CHKDREG:
    79dd:cb0e    mov       al,byte ptr [248D]
    79dd:cb12    or        al,al
    79dd:cb14    je        EXIT
    79dd:cb16    add       al,10
    79dd:cb18    stosb
    79dd:cb19    jmp       EXIT
             WITH:
    79dd:cb1b    or        al,al
    79dd:cb1d    je        EXIT
    79dd:cb1f    add       al,20
    79dd:cb21    stosb
             EXIT:
    79dd:cb22    mov       word ptr ss:[2494],ds
    79dd:cb27    mov       word ptr ss:[2496],si
    79dd:cb2c    ret
             OPEN_MAP_FILE:
    79dd:cb2d    test      byte ptr ss:[9BE8],FF
    79dd:cb33    je        OMFEND
    79dd:cb35    mov       dx,A43D
    79dd:cb38    mov       ax,8AC9
    79dd:cb3b    mov       ds,ax
    79dd:cb3d    mov       cx,0000
    79dd:cb40    call      far ptr _OS2OPENNEWFILE
    79dd:cb45    jae       OMF1
    79dd:cb47    mov       byte ptr ss:[9BE8],00
    79dd:cb4d    push      dx
    79dd:cb4e    mov       dx,7EC6
    79dd:cb51    call      ERROR_ROUT
    79dd:cb54    pop       dx
             OMF1:
    79dd:cb55    mov       word ptr [9BE9],ax
    79dd:cb59    mov       di,9BED
    79dd:cb5c    mov       ax,8AC9
    79dd:cb5f    mov       es,ax
    79dd:cb61    mov       ax,4953
    79dd:cb64    stosw
    79dd:cb65    mov       ax,455A
    79dd:cb68    stosw
    79dd:cb69    mov       word ptr ss:[9BEB],0004
             OMFEND:
    79dd:cb70    ret
             GEN_MAP_SYMBOLS:
    79dd:cb71    test      byte ptr ss:[9BE8],FF
    79dd:cb77    je        OMFEND
    79dd:cb79    mov       al,byte ptr [2498]
    79dd:cb7d    or        al,byte ptr ss:[13A0]
    79dd:cb82    jne       CB87
    79dd:cb84    jmp       GMFDELETE
    79dd:cb87    push      ds
    79dd:cb88    push      dx
    79dd:cb89    mov       dx,8AC9
    79dd:cb8c    mov       ds,dx
    79dd:cb8e    mov       dx,A44E
    79dd:cb91    call      far ptr _OS2PRTSTRING
    79dd:cb96    pop       dx
    79dd:cb97    pop       ds
    79dd:cb98    call      COUNT_SYMBOLS
    79dd:cb9b    push      ax
    79dd:cb9c    mov       cx,word ptr ss:[9BEB]
    79dd:cba1    mov       di,9BED
    79dd:cba4    add       di,cx
    79dd:cba6    mov       ax,8AC9
    79dd:cba9    mov       es,ax
    79dd:cbab    mov       ax,4D53
    79dd:cbae    stosw
    79dd:cbaf    mov       ax,3233
    79dd:cbb2    stosw
    79dd:cbb3    pop       ax
    79dd:cbb4    stosw
    79dd:cbb5    add       cx,06
    79dd:cbb8    mov       si,1472
             GMF2:
    79dd:cbbb    cmp       word ptr ss:[si],00
    79dd:cbbf    jne       GMF3
    79dd:cbc1    add       si,04
    79dd:cbc4    cmp       si,2472
    79dd:cbc8    jl        GMF2
    79dd:cbca    jmp       GMF9
             GMF3:
    79dd:cbcc    push      si
    79dd:cbcd    push      ds
    79dd:cbce    mov       ax,word ptr ss:[si]
    79dd:cbd1    mov       si,word ptr ss:[si+02]
    79dd:cbd5    mov       ds,ax
             GMF4:
    79dd:cbd7    test      byte ptr [si+04],5E
    79dd:cbdb    jne       GMF5
    79dd:cbdd    push      si
    79dd:cbde    push      ds
    79dd:cbdf    mov       ax,word ptr [si+0C]
    79dd:cbe2    stosw
    79dd:cbe3    mov       ax,word ptr [si+0A]
    79dd:cbe6    stosw
    79dd:cbe7    xor       ah,ah
    79dd:cbe9    mov       al,byte ptr [si+05]
    79dd:cbec    dec       al
    79dd:cbee    stosb
    79dd:cbef    add       cx,05
    79dd:cbf2    add       cx,ax
    79dd:cbf4    push      cx
    79dd:cbf5    mov       cx,ax
    79dd:cbf7    mov       ax,word ptr [si+06]
    79dd:cbfa    mov       si,word ptr [si+08]
    79dd:cbfd    mov       ds,ax
    79dd:cbff    rep
    79dd:cc00    movsb
    79dd:cc01    pop       cx
    79dd:cc02    cmp       cx,079C
    79dd:cc06    jl        GMF7
    79dd:cc08    mov       dx,9BED
    79dd:cc0b    mov       ax,8AC9
    79dd:cc0e    mov       ds,ax
    79dd:cc10    mov       bx,word ptr ss:[9BE9]
    79dd:cc15    call      far ptr _OS2WRITEBYTES
    79dd:cc1a    mov       di,9BED
    79dd:cc1d    mov       ax,8AC9
    79dd:cc20    mov       es,ax
    79dd:cc22    xor       cx,cx
             GMF7:
    79dd:cc24    pop       ds
    79dd:cc25    pop       si
             GMF5:
    79dd:cc26    mov       ax,word ptr [si]
    79dd:cc28    or        ax,ax
    79dd:cc2a    je        GMF6
    79dd:cc2c    mov       si,word ptr [si+02]
    79dd:cc2f    mov       ds,ax
    79dd:cc31    jmp       GMF4
             GMF6:
    79dd:cc33    pop       ds
    79dd:cc34    pop       si
    79dd:cc35    add       si,04
    79dd:cc38    cmp       si,2472
    79dd:cc3c    jge       GMF9
    79dd:cc3e    jmp       GMF2
             GMF9:
    79dd:cc41    or        cx,cx
    79dd:cc43    je        GMFDONE
    79dd:cc45    mov       dx,9BED
    79dd:cc48    mov       ax,8AC9
    79dd:cc4b    mov       ds,ax
    79dd:cc4d    mov       bx,word ptr ss:[9BE9]
    79dd:cc52    call      far ptr _OS2WRITEBYTES
             GMFDONE:
    79dd:cc57    mov       bx,word ptr ss:[9BE9]
    79dd:cc5c    call      far ptr _OS2CLOSEFILE
    79dd:cc61    mov       si,9ADC
    79dd:cc64    mov       ax,8AC9
    79dd:cc67    mov       ds,ax
    79dd:cc69    test      byte ptr ss:[13A0],FF
    79dd:cc6f    je        GMF10
    79dd:cc71    mov       si,9B1C
    79dd:cc74    mov       ax,8AC9
    79dd:cc77    mov       ds,ax
             GMF10:
    79dd:cc79    mov       di,A3ED
    79dd:cc7c    mov       ax,8AC9
    79dd:cc7f    mov       es,ax
    79dd:cc81    call      STRCPY
    79dd:cc84    mov       si,A3ED
    79dd:cc87    mov       ax,8AC9
    79dd:cc8a    mov       ds,ax
    79dd:cc8c    mov       al,2E
    79dd:cc8e    call      STRRCHR
    79dd:cc91    mov       bp,si
    79dd:cc93    mov       si,A3ED
    79dd:cc96    mov       ax,8AC9
    79dd:cc99    mov       ds,ax
    79dd:cc9b    mov       al,5C
    79dd:cc9d    call      STRRCHR
    79dd:cca0    cmp       si,bp
    79dd:cca2    jae       GMF0
    79dd:cca4    mov       byte ptr ds:[bp+00],00
             GMF0:
    79dd:cca9    mov       si,A3ED
    79dd:ccac    mov       ax,8AC9
    79dd:ccaf    mov       ds,ax
    79dd:ccb1    mov       di,A449
    79dd:ccb4    mov       ax,8AC9
    79dd:ccb7    mov       es,ax
    79dd:ccb9    call      STRCAT
    79dd:ccbc    mov       dx,A3ED
    79dd:ccbf    mov       ax,8AC9
    79dd:ccc2    mov       ds,ax
    79dd:ccc4    call      far ptr _OS2DELETEFILE
    79dd:ccc9    mov       dx,A43D
    79dd:cccc    mov       ax,8AC9
    79dd:cccf    mov       ds,ax
    79dd:ccd1    mov       di,A3ED
    79dd:ccd4    mov       ax,8AC9
    79dd:ccd7    mov       es,ax
    79dd:ccd9    call      far ptr _OS2RENAMEFILE
    79dd:ccde    push      ds
    79dd:ccdf    push      dx
    79dd:cce0    mov       dx,8AC9
    79dd:cce3    mov       ds,dx
    79dd:cce5    mov       dx,A464
    79dd:cce8    call      far ptr _OS2PRTSTRING
    79dd:cced    pop       dx
    79dd:ccee    pop       ds
    79dd:ccef    ret
             GMFDELETE:
    79dd:ccf0    mov       bx,word ptr ss:[9BE9]
    79dd:ccf5    call      far ptr _OS2CLOSEFILE
    79dd:ccfa    mov       dx,A43D
    79dd:ccfd    mov       ax,8AC9
    79dd:cd00    mov       ds,ax
    79dd:cd02    call      far ptr _OS2DELETEFILE
    79dd:cd07    ret
             MAP_SHORTA:
    79dd:cd08    mov       al,01
    79dd:cd0a    jmp       GMS0
             MAP_SHORTI:
    79dd:cd0c    mov       al,02
    79dd:cd0e    jmp       GMS0
             MAP_LONGA:
    79dd:cd10    mov       al,03
    79dd:cd12    jmp       GMS0
             MAP_LONGI:
    79dd:cd14    mov       al,04
             GMS0:
    79dd:cd16    test      byte ptr ss:[9BE8],FF
    79dd:cd1c    je        GMSEND
    79dd:cd1e    push      cx
    79dd:cd1f    push      di
    79dd:cd20    push      si
    79dd:cd21    push      es
    79dd:cd22    push      ds
    79dd:cd23    push      bx
    79dd:cd24    mov       cx,word ptr ss:[9BEB]
    79dd:cd29    mov       si,9BED
    79dd:cd2c    add       si,cx
    79dd:cd2e    mov       bx,8AC9
    79dd:cd31    mov       es,bx
    79dd:cd33    mov       byte ptr es:[si+03],al
    79dd:cd37    mov       ax,word ptr [0F94]
    79dd:cd3b    mov       word ptr es:[si],ax
    79dd:cd3e    mov       al,byte ptr [0F92]
    79dd:cd42    mov       byte ptr es:[si+02],al
    79dd:cd46    add       cx,04
    79dd:cd49    cmp       cx,079C
    79dd:cd4d    jl        GMS1
    79dd:cd4f    mov       dx,9BED
    79dd:cd52    mov       ax,8AC9
    79dd:cd55    mov       ds,ax
    79dd:cd57    mov       bx,word ptr ss:[9BE9]
    79dd:cd5c    call      far ptr _OS2WRITEBYTES
    79dd:cd61    xor       cx,cx
             GMS1:
    79dd:cd63    mov       word ptr ss:[9BEB],cx
    79dd:cd68    pop       bx
    79dd:cd69    pop       ds
    79dd:cd6a    pop       es
    79dd:cd6b    pop       si
    79dd:cd6c    pop       di
    79dd:cd6d    pop       cx
             GMSEND:
    79dd:cd6e    ret
             STRRCHR:
    79dd:cd6f    xor       cx,cx
    79dd:cd71    mov       ah,al
             STRR0:
    79dd:cd73    lodsb
    79dd:cd74    or        al,al
    79dd:cd76    je        STRR1
    79dd:cd78    cmp       ah,al
    79dd:cd7a    jne       STRR0
    79dd:cd7c    mov       cx,si
    79dd:cd7e    dec       cx
    79dd:cd7f    jmp       STRR0
             STRR1:
    79dd:cd81    mov       si,cx
    79dd:cd83    ret
             STRCAT:
    79dd:cd84    push      ds
    79dd:cd85    push      si
             STRC0:
    79dd:cd86    lodsb
    79dd:cd87    or        al,al
    79dd:cd89    jne       STRC0
    79dd:cd8b    dec       si
             STRC1:
    79dd:cd8c    mov       al,byte ptr es:[di]
    79dd:cd8f    mov       byte ptr [si],al
    79dd:cd91    inc       si
    79dd:cd92    inc       di
    79dd:cd93    or        al,al
    79dd:cd95    jne       STRC1
    79dd:cd97    pop       si
    79dd:cd98    pop       ds
    79dd:cd99    ret
             STRCPY:
    79dd:cd9a    push      es
    79dd:cd9b    push      di
             STRY0:
    79dd:cd9c    lodsb
    79dd:cd9d    stosb
    79dd:cd9e    or        al,al
    79dd:cda0    jne       STRY0
    79dd:cda2    pop       di
    79dd:cda3    pop       es
    79dd:cda4    ret
             COUNT_SYMBOLS:
    79dd:cda5    xor       cx,cx
    79dd:cda7    mov       si,1472
             CSY2:
    79dd:cdaa    cmp       word ptr ss:[si],00
    79dd:cdae    jne       CSY3
    79dd:cdb0    add       si,04
    79dd:cdb3    cmp       si,2472
    79dd:cdb7    jl        CSY2
    79dd:cdb9    mov       ax,cx
    79dd:cdbb    ret
             CSY3:
    79dd:cdbc    push      si
    79dd:cdbd    mov       es,word ptr ss:[si]
    79dd:cdc0    mov       si,word ptr ss:[si+02]
             CSY4:
    79dd:cdc4    test      byte ptr es:[si+04],5E
    79dd:cdc9    jne       CSY5
    79dd:cdcb    inc       cx
             CSY5:
    79dd:cdcc    mov       ax,word ptr es:[si]
    79dd:cdcf    or        ax,ax
    79dd:cdd1    je        CSY6
    79dd:cdd3    mov       si,word ptr es:[si+02]
    79dd:cdd7    mov       es,ax
    79dd:cdd9    jmp       CSY4
             CSY6:
    79dd:cddb    pop       si
    79dd:cddc    add       si,04
    79dd:cddf    cmp       si,2472
    79dd:cde3    jl        CSY2
    79dd:cde5    mov       ax,cx
    79dd:cde7    ret
    79dd:cde8    add       byte ptr [bx+si],al
    79dd:cdea    add       byte ptr [bx+si],al
    79dd:cdec    add       byte ptr [bx+si],al
    79dd:cdee    add       byte ptr [bx+si],al
    79dd:cdf0    add       byte ptr [bx+si],al
    79dd:cdf2    add       byte ptr [bx+si],al
    79dd:cdf4    add       byte ptr [bx+si],al
    79dd:cdf6    add       byte ptr [bx+si],al
    79dd:cdf8    add       byte ptr [bx+si],al
    79dd:cdfa    add       byte ptr [bx+si],al
    79dd:cdfc    add       byte ptr [bx+si],al
    79dd:cdfe    add       byte ptr [bx+si],al
    79dd:ce00    or        ax,ax
    79dd:ce02    jne       CE06
    79dd:ce04    clc
    79dd:ce05    ret
    79dd:ce06    stc
    79dd:ce07    ret
             _OS2EXIT:
    79dd:ce08    mov       ax,4C00
    79dd:ce0b    int       21
             _OS2EXITERR:
    79dd:ce0d    mov       ax,4C01
    79dd:ce10    int       21
             _OS2OPENFILE:
    79dd:ce12    mov       ax,3D00
    79dd:ce15    int       21
    79dd:ce17    retf
             _OS2OPENNEWFILE:
    79dd:ce18    mov       ax,3C00
    79dd:ce1b    int       21
    79dd:ce1d    retf
             _OS2OPENAPPENDFILE:
    79dd:ce1e    push      ds
    79dd:ce1f    push      dx
    79dd:ce20    mov       ax,3D01
    79dd:ce23    int       21
    79dd:ce25    pop       dx
    79dd:ce26    pop       ds
    79dd:ce27    jae       CE33
    79dd:ce29    xor       bx,bx
    79dd:ce2b    mov       ax,3C00
    79dd:ce2e    mov       cx,0000
    79dd:ce31    int       21
    79dd:ce33    retf
             _OS2CLOSEFILE:
    79dd:ce34    mov       ah,3E
    79dd:ce36    int       21
    79dd:ce38    retf
             _OS2READBYTES:
    79dd:ce39    mov       ah,3F
    79dd:ce3b    int       21
    79dd:ce3d    retf
             _OS2WRITEBYTES:
    79dd:ce3e    mov       al,byte ptr [13F2]
    79dd:ce41    or        al,al
    79dd:ce43    je        CE5A
    79dd:ce45    cmp       bx,01
    79dd:ce48    jne       CE5A
    79dd:ce4a    push      bx
    79dd:ce4b    push      ds
    79dd:ce4c    push      dx
    79dd:ce4d    push      cx
    79dd:ce4e    mov       bx,word ptr [13F3]
    79dd:ce52    mov       ah,40
    79dd:ce54    int       21
    79dd:ce56    pop       cx
    79dd:ce57    pop       dx
    79dd:ce58    pop       ds
    79dd:ce59    pop       bx
    79dd:ce5a    mov       ah,40
    79dd:ce5c    int       21
    79dd:ce5e    retf
             _OS2SEEKFILE:
    79dd:ce5f    mov       ax,4200
    79dd:ce62    int       21
    79dd:ce64    retf
             _OS2SEEKEND:
    79dd:ce65    mov       ax,4202
    79dd:ce68    int       21
    79dd:ce6a    retf
             _OS2ALLOCSEG:
    79dd:ce6b    mov       ah,48
    79dd:ce6d    int       21
    79dd:ce6f    retf
             _OS2FREESEG:
    79dd:ce70    mov       ah,49
    79dd:ce72    int       21
    79dd:ce74    retf
             _OS2AVAILMEM:
    79dd:ce75    mov       bx,FFFF
    79dd:ce78    mov       ah,48
    79dd:ce7a    int       21
    79dd:ce7c    shr       bx,06
    79dd:ce7f    mov       ax,bx
    79dd:ce81    xor       dx,dx
    79dd:ce83    retf
             _OS2GETDATE:
    79dd:ce84    mov       ah,2A
    79dd:ce86    int       21
    79dd:ce88    retf
    79dd:ce89    mov       ah,2C
    79dd:ce8b    int       21
    79dd:ce8d    retf
             _OS2PRTSTRING:
    79dd:ce8e    push      cx
    79dd:ce8f    xor       cx,cx
    79dd:ce91    push      si
    79dd:ce92    mov       si,dx
    79dd:ce94    lodsb
    79dd:ce95    inc       cx
    79dd:ce96    cmp       al,24
    79dd:ce98    jne       CE94
    79dd:ce9a    dec       cx
    79dd:ce9b    pop       si
    79dd:ce9c    mov       ah,40
    79dd:ce9e    mov       bx,0001
    79dd:cea1    call      far ptr _OS2WRITEBYTES
    79dd:cea6    pop       cx
    79dd:cea7    retf
             _OS2INITTERM:
    79dd:cea8    retf
             _OS2RENAMEFILE:
    79dd:cea9    mov       ah,56
    79dd:ceab    int       21
    79dd:cead    retf
             _OS2DELETEFILE:
    79dd:ceae    mov       ah,41
    79dd:ceb0    int       21
    79dd:ceb2    retf

