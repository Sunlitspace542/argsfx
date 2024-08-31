; ArgAsm-Super FX (ArgSfx)
; Filename: HELPTEXT.ASM
; Purpose: Help text displayed when no CLI parameters specified.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

DB	"ArgSfx v1.50 (DBR=OFF) Copyright (c) Argonaut Software Ltd. 1992", 0Dh,0Ah
DB	"Usage: ARGSFX [options] sourcefile", 0Dh,0Ah
DB	" Options are:", 0Dh,0Ah
DB	"   -d<value>,"<str>" - Defines a string.", 0Dh,0Ah
DB	"   -e<label>(=value) - Equate label with the optional value.", 0Dh,0Ah
DB	"   -f<name>          - Write file listing to file name.", 0Dh,0Ah
DB	"   -h                - This text.", 0Dh,0Ah
DB	"   -i<name>          - Specifies an incdir name.", 0Dh,0Ah
DB	"   -l                - Turns on listing.", 0Dh,0Ah
DB	"   -m<value>         - Specifies maximum errors before stopping.", 0Dh,0Ah
DB	"   -o<name>          - Write object code to file <name>.", 0Dh,0Ah
DB	"   -p<name>          - Write stdout to file <name>.", 0Dh,0Ah
DB	"   -r                - Display rom listing on screen.", 0Dh,0Ah
DB	"   -s<label>(=value) - Set the label with the optional value.", 0Dh,0Ah
DB	"   -v<filename.SOB>  - Write linkable file <filename.SOB>.", 0Dh,0Ah
DB	"   -x<name>          - Writes symbol listing to file.", 0Dh,0Ah
DB	"   -z                - Generate a .MAP debug file.", 0Dh,0Ah
DB	0Dh,0Ah
DB	"$"
DB	0Dh,0Ah
DB	0Dh,0Ah