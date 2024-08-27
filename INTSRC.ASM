 deferror "%d:%f (%l), %e%u.%s%n"
 defend "%n%[7]ie Error(s).%t%[7]iw Warning(s).%n%[7]is Symbols.%t%[7]ib Bytes.%t%t%[7]il Lines.%n"
 IFND __notitle
 printf "ArgSfx v1.50 (DBR=OFF)  Copyright (c) Argonaut Software Ltd. 1992%n"
 printf "%kK Free,  %$date_str%n"
 ENDC
_SASM
_ARGSFX
 DATE _DATE
_DAY = _DATE&$ff
_MONTH = _DATE>>8&$ff
_YEAR = _DATE>>16
 IFD __mario
 MARIO ON
 ENDC
 STRING 1[150]
 STRING 2[150]
 STRING 3[150]
 STRING 4[150]
 STRING 5[150]
 STRING 6[150]
 include 