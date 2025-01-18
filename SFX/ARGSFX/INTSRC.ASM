; ArgAsm-Super FX (ArgSfx)
; Filename: INTSRC.ASM
; Purpose: Internal source file processed at startup.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

DB	" deferror ""%d:%f (%l), %e%u.%s%n""",__CR,__LF
DB	" defend ""%n%[7]ie Error(s).%t%[7]iw Warning(s).%n%[7]is Symbols.%t%[7]ib Bytes.%t%t%[7]il Lines.%n""",__CR,__LF
DB	" IFND __notitle",__CR,__LF
DB	" printf ""ArgSfx v1.50 (DBR=OFF)  Copyright (c) Argonaut Software Ltd. 1992%n""",__CR,__LF
DB	" printf ""%kK Free,  %$date_str%n""",__CR,__LF
DB	" ENDC",__CR,__LF
DB	"_SASM",__CR,__LF
DB	"_ARGSFX",__CR,__LF
DB	" DATE _DATE",__CR,__LF
DB	"_DAY = _DATE&$ff",__CR,__LF
DB	"_MONTH = _DATE>>8&$ff",__CR,__LF
DB	"_YEAR = _DATE>>16",__CR,__LF
DB	" IFD __mario",__CR,__LF
DB	" MARIO ON",__CR,__LF
DB	" ENDC",__CR,__LF
DB	" STRING 1[150]",__CR,__LF
DB	" STRING 2[150]",__CR,__LF
DB	" STRING 3[150]",__CR,__LF
DB	" STRING 4[150]",__CR,__LF
DB	" STRING 5[150]",__CR,__LF
DB	" STRING 6[150]",__CR,__LF
DB	" include "