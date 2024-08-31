; ArgAsm-Super FX (ArgSfx)
; Filename: INTSRC.ASM
; Purpose: Internal source file processed at startup.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

DB	" deferror ""%d:%f (%l), %e%u.%s%n""", 0Dh,0Ah
DB	" defend ""%n%[7]ie Error(s).%t%[7]iw Warning(s).%n%[7]is Symbols.%t%[7]ib Bytes.%t%t%[7]il Lines.%n""", 0Dh,0Ah
DB	" IFND __notitle", 0Dh,0Ah
DB	" printf ""ArgSfx v1.50 (DBR=OFF)  Copyright (c) Argonaut Software Ltd. 1992%n""", 0Dh,0Ah
DB	" printf ""%kK Free,  %$date_str%n""", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	"_SASM", 0Dh,0Ah
DB	"_ARGSFX", 0Dh,0Ah
DB	" DATE _DATE", 0Dh,0Ah
DB	"_DAY = _DATE&$ff", 0Dh,0Ah
DB	"_MONTH = _DATE>>8&$ff", 0Dh,0Ah
DB	"_YEAR = _DATE>>16", 0Dh,0Ah
DB	" IFD __mario", 0Dh,0Ah
DB	" MARIO ON", 0Dh,0Ah
DB	" ENDC", 0Dh,0Ah
DB	" STRING 1[150]", 0Dh,0Ah
DB	" STRING 2[150]", 0Dh,0Ah
DB	" STRING 3[150]", 0Dh,0Ah
DB	" STRING 4[150]", 0Dh,0Ah
DB	" STRING 5[150]", 0Dh,0Ah
DB	" STRING 6[150]", 0Dh,0Ah
DB	" include "