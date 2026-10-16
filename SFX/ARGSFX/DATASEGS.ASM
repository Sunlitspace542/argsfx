; ArgAsm-Super FX (ArgSfx)
; Filename: DATASEGS.ASM
; Purpose: Temporary(?) location for data segments 2 and 3.
; Source code reconstructed by Sunlitspace542 and contributors.
; Original program copyright (C) 1992-1994 Argonaut Software Ltd.

.DATA

; Segment type:	Regular
seg002 segment byte public 'DATA' use16
assume cs:seg002
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing

; dummy stuff for now
db 'seg2 placeholder data'
db 000h

seg002 ends

; Segment type:	Regular
seg003 segment byte public 'DATA' use16
assume cs:seg003
assume es:nothing, ss:nothing, ds:nothing, fs:nothing, gs:nothing
.STACK

; dummy stuff for now
db 'seg3 placeholder data'
db 000h

seg003 ends