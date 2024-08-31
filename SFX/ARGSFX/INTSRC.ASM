; ArgAsm-Super FX (ArgSfx)
; Filename: INTSRC.ASM
; Purpose: Internal source file processed at startup.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

	IF VERSION_SASM NE 0
DB	" IFD __heap", 0Dh,0Ah
DB	" getheap __heap", 0Dh,0Ah
DB	" ELSEIF", 0Dh,0Ah
DB	" IFNV sasmheap", 0Dh,0Ah
DB	" getheap 2*1024", 0Dh,0Ah
DB	" ELSEIF", 0Dh,0Ah
DB	" getenv 5,sasmheap", 0Dh,0Ah
DB	" run "" getheap %$5""", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
	ENDIF

DB	" deferror ""%d:%f (%l), %e%u.%s%n""", 0Dh,0Ah
DB	" defend ""%n%[7]ie Error(s).%t%[7]iw Warning(s).%n%[7]is Symbols.%t%[7]ib Bytes.%t%t%[7]il Lines.%n""", 0Dh,0Ah
DB	" IFND __notitle", 0Dh,0Ah

	IF VERSION_SASM NE 0
DB	" printf ""SASMX v2.02  Copyright (c) Argonaut Software Ltd 1992%n""", 0Dh,0Ah
	ELSEIF
DB	" printf ""ArgSfx v1.50 (DBR=OFF)  Copyright (c) Argonaut Software Ltd. 1992%n""", 0Dh,0Ah
	ENDIF

	IF	VERSION_SASM NE	0
DB	" printf ""%kK Free,  %$7%n""", 0Dh,0Ah
	ELSEIF
DB	" printf ""%kK Free,  %$date_str%n""", 0Dh,0Ah
	ENDIF

DB	" ENDC", 0Dh,0Ah

	IF	VERSION_SASM NE	0
DB	"_SASM", 0Dh,0Ah
	ELSEIF
DB	"_SASM", 0Dh,0Ah
DB	"_ARGSFX", 0Dh,0Ah
	ENDIF

DB	" DATE _DATE", 0Dh,0Ah
DB	"_DAY = _DATE&$ff", 0Dh,0Ah
DB	"_MONTH = _DATE>>8&$ff", 0Dh,0Ah
DB	"_YEAR = _DATE>>16", 0Dh,0Ah

	IF	VERSION_SASM NE	0
DB	" IFEQ _MONTH-8", 0Dh,0Ah
DB	" IFEQ _DAY-6", 0Dh,0Ah
DB	" PRINTF ""Happy birthday Krister!%n""", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" IFEQ _MONTH-3", 0Dh,0Ah
DB	" IFEQ _DAY-30", 0Dh,0Ah
DB	" PRINTF ""Happy birthday Giles!%n""", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" IFEQ _MONTH-2", 0Dh,0Ah
DB	" IFEQ _DAY-18", 0Dh,0Ah
DB	" PRINTF ""Happy birthday Dylan!%n""", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
	ENDIF

DB	" IFD __mario", 0Dh,0Ah
DB	" MARIO ON", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah

	IF	VERSION_SASM
DB	" STRING 1[150]", 0Dh,0Ah
DB	" STRING 2[150]", 0Dh,0Ah
DB	" STRING 3[150]", 0Dh,0Ah
DB	" STRING 4[150]", 0Dh,0Ah
DB	" STRING 5[150]", 0Dh,0Ah
DB	" STRING 6[150]", 0Dh,0Ah
	ENDIF

DB	" include ", 0Dh,0Ah