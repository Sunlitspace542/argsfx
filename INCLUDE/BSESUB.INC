;
; Module Name: BSESUB.INC
;
; OS/2 Base Include File
;
; Copyright (c) 1987-1990, Microsoft Corporation.  All rights reserved.
;
; *********************************************************************
;
; Subcomponents marked with "+" are partially included by default
;   #define:          To include:
;
;   INCL_KBD          KBD
;   INCL_VIO          VIO
;   INCL_MOU          MOU

IFDEF  INCL_SUB
INCL_KBD        EQU     1
INCL_VIO        EQU     1
INCL_MOU        EQU     1
ENDIF ; INCL_SUB

IF DEFINED( INCL_KBD ) AND DEFINED( INCL_VIO ) AND DEFINED( INCL_MOU )
BSESUB_INCLUDED EQU     1
ENDIF

IFDEF INCL_KBD
HKBD		TYPEDEF		WORD
PHKBD           TYPEDEF         FAR PTR HKBD

KbdRegister     PROTO FAR PASCAL \
                pszModName:PSZ, pszEntryPt:PSZ, FunMask:DWORD

KR_KBDCHARIN            EQU     0001h
KR_KBDPEEK              EQU     0002h
KR_KBDFLUSHBUFFER       EQU     0004h
KR_KBDGETSTATUS         EQU     0008h
KR_KBDSETSTATUS         EQU     0010h
KR_KBDSTRINGIN          EQU     0020h
KR_KBDOPEN              EQU     0040h
KR_KBDCLOSE             EQU     0080h
KR_KBDGETFOCUS          EQU     0100h
KR_KBDFREEFOCUS         EQU     0200h
KR_KBDGETCP             EQU     0400h
KR_KBDSETCP             EQU     0800h
KR_KBDXLATE             EQU     1000h
KR_KBDSETCUSTXT         EQU     2000h

IO_WAIT                 EQU     0
IO_NOWAIT               EQU     1

KbdDeRegister   PROTO FAR PASCAL

; KBDKEYINFO structure, for KbdCharIn and KbdPeek

IFNDEF  KBDKEYINFO
KBDKEYINFO      STRUCT  2 ; kbci
chChar_         BYTE    0
chScan_         BYTE    0
fbStatus_       BYTE    0
bNlsShift_      BYTE    0
fsState_        WORD    0
time_           DWORD   0
KBDKEYINFO      ENDS
PKBDKEYINFO     TYPEDEF FAR PTR KBDKEYINFO
ENDIF

KbdCharIn       PROTO FAR PASCAL \
                pkbci:PKBDKEYINFO, fWaitFor:WORD, hk:HKBD

KbdPeek         PROTO FAR PASCAL \
                pkbci:PKBDKEYINFO, hk:HKBD

; structure for KbdStringIn
IFNDEF STRINGINBUF
STRINGINBUF     STRUCT  2 ; kbsi
cb_             WORD    0
cchIn_          WORD    0
STRINGINBUF     ENDS
PSTRINGINBUF    TYPEDEF FAR PTR STRINGINBUF
ENDIF

KbdStringIn     PROTO FAR PASCAL \
                pch:PCHAR, pchIn:PSTRINGINBUF, fsWait:WORD, hk:HKBD

KbdFlushBuffer  PROTO FAR PASCAL \
                hk:HKBD

; KBDINFO.fsMask

KEYBOARD_ECHO_ON                EQU     0001h
KEYBOARD_ECHO_OFF               EQU     0002h
KEYBOARD_BINARY_MODE            EQU     0004h
KEYBOARD_ASCII_MODE             EQU     0008h
KEYBOARD_MODIFY_STATE           EQU     0010h
KEYBOARD_MODIFY_INTERIM         EQU     0020h
KEYBOARD_MODIFY_TURNAROUND      EQU     0040h
KEYBOARD_2B_TURNAROUND          EQU     0080h
KEYBOARD_SHIFT_REPORT           EQU     0100h

IFNDEF INCL_DOSDEVIOCTL         ; following constants defined in bsedev.h

; KBDINFO.fsState/KBDKEYINFO.fsState/KBDTRANS.fsState

RIGHTSHIFT      EQU     0001h
LEFTSHIFT       EQU     0002h
CONTROL         EQU     0004h
ALT             EQU     0008h
SCROLLLOCK_ON   EQU     0010h
NUMLOCK_ON      EQU     0020h
CAPSLOCK_ON     EQU     0040h
INSERT_ON       EQU     0080h
LEFTCONTROL     EQU     0100h
LEFTALT         EQU     0200h
RIGHTCONTROL    EQU     0400h
RIGHTALT        EQU     0800h
SCROLLLOCK      EQU     1000h
NUMLOCK         EQU     2000h
CAPSLOCK        EQU     4000h
SYSREQ          EQU     8000h

ENDIF ; INCL_DOSDEVIOCTL

; KBDINFO structure, for KbdSet/GetStatus
IFNDEF KBDINFO
KBDINFO         STRUCT  2 ; kbst
cb_             WORD    0
fsMask_         WORD    0
chTurnAround_   WORD    0
fsInterim_      WORD    0
fsState_        WORD    0
KBDINFO         ENDS
PKBDINFO        TYPEDEF FAR PTR KBDINFO
ENDIF

KbdSetStatus    PROTO FAR PASCAL \
                pkbdinfo:PKBDINFO, hk:HKBD

KbdGetStatus    PROTO FAR PASCAL \
                pkbdinfo:PKBDINFO, hdbd:WORD

KbdSetCp        PROTO FAR PASCAL \
                usReserved:WORD, pidCP:WORD, hk:HKBD

KbdGetCp        PROTO FAR PASCAL \
                ulReserved:DWORD, pidCP:PWORD, hk:HKBD

KbdOpen         PROTO FAR PASCAL \
                phk:PHKBD

KbdClose        PROTO FAR PASCAL \
                hk:HKBD

KbdGetFocus     PROTO FAR PASCAL \
                fWaitFor:WORD, hk:HKBD

KbdFreeFocus    PROTO FAR PASCAL \
                hk:HKBD

KbdSynch        PROTO FAR PASCAL \
                fsWait:WORD

KbdSetFgnd      PROTO FAR PASCAL

; KBDTRANS.fbStatus

SHIFT_KEY_IN            EQU     0001h
CONVERSION_REQUEST      EQU     0020h
FINAL_CHAR_IN           EQU     0040h
INTERIM_CHAR_IN         EQU     0080h

KEYBOARD_AT_COMPATABLE  EQU     00001h
KEYBOARD_ENHANCED_101   EQU     0AB41h
KEYBOARD_ENHANCED_102   EQU     0AB41h
KEYBOARD_ENHANCED_122   EQU     0AB85h
KEYBOARD_SPACESAVER     EQU     0AB54h

; structure for KbdGetHWID
IFNDEF KBDHWID
KBDHWID         STRUCT  2 ; kbhw
cb_             WORD    0
idKbd_          WORD    0
usReserved1_    WORD    0
usReserved2_    WORD    0
KBDHWID         ENDS
PKBDHWID        TYPEDEF FAR PTR KBDHWID
ENDIF

KbdGetHWID      PROTO FAR PASCAL \
                pkbdhwid:PKBDHWID, hk:HKBD

; structure for KbdXlate
IFNDEF  KBDTRANS
KBDTRANS        STRUCT  2 ; kbxl
chChar_         BYTE    0
chScan_         BYTE    0
fbStatus_       BYTE    0
bNlsShift_      BYTE    0
fsState_        WORD    0
time_           DWORD   0
fsDD_           WORD    0
fsXlate_        WORD    0
fsShift_        WORD    0
sZero_          WORD    0
KBDTRANS        ENDS
PKBDTRANS       TYPEDEF FAR PTR KBDTRANS
ENDIF

KbdXlate        PROTO FAR PASCAL \
                pkbdtrans:PKBDTRANS, hk:HKBD

KbdSetCustXt    PROTO FAR PASCAL \
                pusCodePage:FAR PTR WORD, hk:HKBD

ENDIF ; INCL_KBD

IFDEF INCL_VIO

HVIO            TYPEDEF         WORD
PHVIO           TYPEDEF         FAR PTR HVIO

VioRegister     PROTO FAR PASCAL \
                pszModName:PSZ, pszEntryName:PSZ, flFun1:DWORD, flFun2:DWORD

; first parameter registration constants
VR_VIOGETCURPOS         EQU     000000001h
VR_VIOGETCURTYPE        EQU     000000002h
VR_VIOGETMODE           EQU     000000004h
VR_VIOGETBUF            EQU     000000008h
VR_VIOGETPHYSBUF        EQU     000000010h
VR_VIOSETCURPOS         EQU     000000020h
VR_VIOSETCURTYPE        EQU     000000040h
VR_VIOSETMODE           EQU     000000080h
VR_VIOSHOWBUF           EQU     000000100h
VR_VIOREADCHARSTR       EQU     000000200h
VR_VIOREADCELLSTR       EQU     000000400h
VR_VIOWRTNCHAR          EQU     000000800h
VR_VIOWRTNATTR          EQU     000001000h
VR_VIOWRTNCELL          EQU     000002000h
VR_VIOWRTTTY            EQU     000004000h
VR_VIOWRTCHARSTR        EQU     000008000h

VR_VIOWRTCHARSTRATT     EQU     000010000h
VR_VIOWRTCELLSTR        EQU     000020000h
VR_VIOSCROLLUP          EQU     000040000h
VR_VIOSCROLLDN          EQU     000080000h
VR_VIOSCROLLLF          EQU     000100000h
VR_VIOSCROLLRT          EQU     000200000h
VR_VIOSETANSI           EQU     000400000h
VR_VIOGETANSI           EQU     000800000h
VR_VIOPRTSC             EQU     001000000h
VR_VIOSCRLOCK           EQU     002000000h
VR_VIOSCRUNLOCK         EQU     004000000h
VR_VIOSAVREDRAWWAIT     EQU     008000000h
VR_VIOSAVREDRAWUNDO     EQU     010000000h
VR_VIOPOPUP             EQU     020000000h
VR_VIOENDPOPUP          EQU     040000000h
VR_VIOPRTSCTOGGLE       EQU     080000000h

; second parameter registration constants
VR_VIOMODEWAIT          EQU     000000001h
VR_VIOMODEUNDO          EQU     000000002h
VR_VIOGETFONT           EQU     000000004h
VR_VIOGETCONFIG         EQU     000000008h
VR_VIOSETCP             EQU     000000010h
VR_VIOGETCP             EQU     000000020h
VR_VIOSETFONT           EQU     000000040h
VR_VIOGETSTATE          EQU     000000080h
VR_VIOSETSTATE          EQU     000000100h

VioDeRegister   PROTO FAR PASCAL

VioGetBuf       PROTO FAR PASCAL \
                pLVB:PDWORD, pcbLVB:PWORD, hv:HVIO

VioGetCurPos    PROTO FAR PASCAL \
                pusRow:PWORD, pusColumn:PWORD, hv:HVIO

VioSetCurPos    PROTO FAR PASCAL \
                usRow:WORD, usColumn:WORD, hv:HVIO

; Structure for VioSet/GetCurType
IFNDEF VIOCURSORINFO
VIOCURSORINFO   STRUCT  2 ; vioci
yStart_         WORD    0
cEnd_           WORD    0
cx_             WORD    0
attr_           WORD    0
VIOCURSORINFO   ENDS
PVIOCURSORINFO  TYPEDEF FAR PTR VIOCURSORINFO
ENDIF

VioGetCurType   PROTO FAR PASCAL \
                pvioCursorInfo:PVIOCURSORINFO, hv:HVIO

VioSetCurType   PROTO FAR PASCAL \
                pvioCursorInfo:PVIOCURSORINFO, hv:HVIO

; VIOMODEINFO.color constants

COLORS_2        EQU     0001h
COLORS_4        EQU     0002h
COLORS_16       EQU     0004h

; structure for VioSet/GetMode
IFNDEF VIOMODEINFO
VIOMODEINFO     STRUCT  2 ; viomi
cb_             WORD    0
fbType_         BYTE    0
color_          BYTE    0
col_            WORD    0
row_            WORD    0
hres_           WORD    0
vres_           WORD    0
fmt_ID_         BYTE    0
attrib_         BYTE    0
buf_addr_       DWORD   0
buf_length_     DWORD   0
full_length_    DWORD   0
partial_length_ DWORD   0
ext_data_addr_  PCH     0
VIOMODEINFO     ENDS
PVIOMODEINFO    TYPEDEF FAR PTR VIOMODEINFO
ENDIF

VGMT_OTHER              EQU     01h
VGMT_GRAPHICS           EQU     02h
VGMT_DISABLEBURST       EQU     04h

VioGetMode      PROTO FAR PASCAL \
                pvioModeInfo:PVIOMODEINFO, hv:HVIO

VioSetMode      PROTO FAR PASCAL \
                pvioModeInfo:PVIOMODEINFO, hv:HVIO

; structure for VioGetPhysBuf
IFNDEF VIOPHYSBUF
VIOPHYSBUF      STRUCT  2 ; viopb
pBuf_           PBYTE   0
cb_             DWORD   0
asel_           WORD    1 DUP (0)
VIOPHYSBUF      ENDS
PVIOPHYSBUF     TYPEDEF FAR PTR VIOPHYSBUF
ENDIF

VioGetPhysBuf   PROTO FAR PASCAL \
                vioPhysBuf:PVIOPHYSBUF, usReserved:WORD

VioReadCellStr  PROTO FAR PASCAL \
                pchCellStr:PBYTE, pcb:PWORD,
                usRow:WORD, usColumn:WORD, hv:HVIO

VioReadCharStr  PROTO FAR PASCAL \
                pchCellStr:PBYTE, pcb:PWORD,
                usRow:WORD, usColumn:WORD, hv:HVIO

VioWrtCellStr   PROTO FAR PASCAL \
                pchCellStr:PBYTE, cb:WORD,
                usRow:WORD, usColumn:WORD, hv:HVIO

VioWrtCharStr   PROTO FAR PASCAL \
                pchStr:FAR PTR BYTE, cb:WORD,
                usRow:WORD, usColumn:WORD, hv:HVIO

VioScrollDn     PROTO FAR PASCAL \
                usTopRow:WORD, usLeftCol:WORD,
                usBotRow:WORD, usRightCol:WORD,
                cbLines:WORD, pCell:PBYTE, hv:HVIO

VioScrollUp     PROTO FAR PASCAL \
                usTopRow:WORD, usLeftCol:WORD,
                usBotRow:WORD, usRightCol:WORD,
                cbLines:WORD, pCell:PBYTE, hv:HVIO

VioScrollLf     PROTO FAR PASCAL \
                usTopRow:WORD, usLeftCol:WORD,
                usBotRow:WORD, usRightCol:WORD,
                cbCol:WORD, pCell:PBYTE, hv:HVIO

VioScrollRt     PROTO FAR PASCAL \
                usTopRow:WORD, usLeftCol:WORD,
                usBotRow:WORD, usRightCol:WORD,
                cbCol:WORD, pCell:PBYTE, hv:HVIO

VioWrtNAttr     PROTO FAR PASCAL \
                pAttr:PBYTE, cb:WORD,
                usRow:WORD, usColumn:WORD, hv:HVIO

VioWrtNCell     PROTO FAR PASCAL \
                pCell:PBYTE, cb:WORD, usRow:WORD, usColumn:WORD, hv:HVIO

VioWrtNChar     PROTO FAR PASCAL \
                pchChar:PBYTE, cb:WORD, usRow:WORD, usColumn:WORD, hv:HVIO

VioWrtTTY       PROTO FAR PASCAL \
                pch:PBYTE, cb:WORD, hv:HVIO

VioWrtCharStrAtt PROTO FAR PASCAL \
                pch:PBYTE, cb:WORD, usRow:WORD, usColumn:WORD,
                pAttr:PBYTE, hv:HVIO

VioShowBuf      PROTO FAR PASCAL \
                offLVB:WORD, cb:WORD, hv:HVIO

ANSI_ON         EQU     1
ANSI_OFF        EQU     0

VioSetAnsi      PROTO FAR PASCAL \
                fAnsi:WORD, hv:HVIO

VioGetAnsi      PROTO FAR PASCAL \
                pfAnsi:PWORD, hv:HVIO

VioPrtSc        PROTO FAR PASCAL \
                hv:HVIO

VioPrtScToggle  PROTO FAR PASCAL \
                hv:HVIO

VSRWI_SAVEANDREDRAW     EQU     0
VSRWI_REDRAW            EQU     1

VSRWN_SAVE              EQU     0
VSRWN_REDRAW            EQU     1

UNDOI_GETOWNER          EQU     0
UNDOI_RELEASEOWNER      EQU     1

UNDOK_ERRORCODE         EQU     0
UNDOK_TERMINATE         EQU     1

VioRedrawSize   PROTO FAR PASCAL \
                pcbRedraw:PDWORD

VioSavRedrawWait PROTO FAR PASCAL \
                usRedrawInd:WORD, pNotifyType:PWORD, usReserved:WORD

VioSavRedrawUndo PROTO FAR PASCAL \
                usOwnerInd:WORD, usKillInd:WORD, usReserved:WORD

VMWR_POPUP      EQU     0
VMWN_POPUP      EQU     0

VioModeWait     PROTO FAR PASCAL \
                usReqType:WORD, pNotifyType:PWORD, usReserved:WORD

VioModeUndo     PROTO FAR PASCAL \
                usOwnerInd:WORD, usKillInd:WORD, usReserved:WORD

LOCKIO_NOWAIT   EQU     0
LOCKIO_WAIT     EQU     1

LOCK_SUCCESS    EQU     0
LOCK_FAIL       EQU     1

VioScrLock      PROTO FAR PASCAL \
                fWaitFor:WORD, pfNotLocked:PBYTE, hv:HVIO

VioScrUnLock    PROTO FAR PASCAL \
                hv:HVIO

VP_NOWAIT       EQU     0000h
VP_WAIT         EQU     0001h
VP_OPAQUE       EQU     0000h
VP_TRANSPARENT  EQU     0002h

VioPopUp        PROTO FAR PASCAL \
                pfWaitFor:PWORD, hv:HVIO

VioEndPopUp     PROTO FAR PASCAL \
                hv:HVIO

; structure for VioGetConfig

; VIOCONFIGINFO.adapter constants

DISPLAY_MONOCHROME      EQU             0
DISPLAY_CGA		EQU		1
DISPLAY_EGA		EQU		2
DISPLAY_VGA		EQU		3
DISPLAY_8514A		EQU		7

; VIOCONFIGINFO.display constants
MONITOR_MONOCHROME      EQU             0
MONITOR_COLOR		EQU		1
MONITOR_ENHANCED        EQU             2
MONITOR_8503		EQU		3
MONITOR_851X_COLOR      EQU             4
MONITOR_8514		EQU		9


IFNDEF VIOCONFIGINFO
VIOCONFIGINFO   STRUCT  2 ; vioin
cb_             WORD    0
adapter_        WORD    0
display_        WORD    0
cbMemory_       DWORD   0
Configuration_  WORD    0
VDHVersion_     WORD    0
Flags_          WORD    0
HWBufferSize_   DWORD   0
FullSaveSize_   DWORD   0
PartSaveSize_   DWORD   0
EMAdaptersOFF_  WORD    0
EMDisplaysOFF_  WORD    0
VIOCONFIGINFO   ENDS
PVIOCONFIGINFO  TYPEDEF FAR PTR VIOCONFIGINFO
ENDIF

VioGetConfig    PROTO FAR PASCAL \
                usConfigId:WORD, pvioin:PVIOCONFIGINFO, hv:HVIO

; structure for VioGet/SetFont
IFNDEF VIOFONTINFO
VIOFONTINFO     STRUCT  2 ; viofi
cb_             WORD    0
type_           WORD    0
cxCell_         WORD    0
cyCell_         WORD    0
pbData_         PVOID   0
cbData_         WORD    0
VIOFONTINFO     ENDS
PVIOFONTINFO    TYPEDEF FAR PTR VIOFONTINFO
ENDIF

VGFI_GETCURFONT EQU     0
VGFI_GETROMFONT EQU     1

VioGetFont      PROTO FAR PASCAL \
                pviofi:PVIOFONTINFO, hv:HVIO

VioSetFont      PROTO FAR PASCAL \
                pviofi:PVIOFONTINFO, hv:HVIO

VioGetCp        PROTO FAR PASCAL \
                usReserved:WORD, pIdCodePage:PWORD, hv:HVIO

VioSetCp        PROTO FAR PASCAL \
                usReserved:WORD, idCodePage:WORD, hv:HVIO


IFNDEF VIOPALSTATE
VIOPALSTATE     STRUCT  2 ; viopal
cb_             WORD    0
type_           WORD    0
iFirst_         WORD    0
acolor_         PWORD   0
VIOPALSTATE     ENDS
PVIOPALSTATE    TYPEDEF FAR PTR VIOPALSTATE
ENDIF

IFNDEF VIOOVERSCAN
VIOOVERSCAN     STRUCT  2 ; vioos
cb_             WORD    0
type_           WORD    0
color_          WORD    0
VIOOVERSCAN     ENDS
PVIOOVERSCAN    TYPEDEF FAR PTR VIOOVERSCAN
ENDIF

IFNDEF VIOINTENSITY
VIOINTENSITY    STRUCT  2 ; vioint
cb_             WORD    0
type_           WORD    0
fs_             WORD    0
VIOINTENSITY    ENDS
PVIOINTENSITY   TYPEDEF FAR PTR VIOINTENSITY
ENDIF

IFNDEF VIOCOLORREG
VIOCOLORREG     STRUCT  2 ; viocreg
cb_             WORD    0
type_           WORD    0
firstcolorreg_  WORD    0
numcolorregs_   WORD    0
colorregaddr_   PCH     0
VIOCOLORREG     ENDS
PVIOCOLORREG    TYPEDEF FAR PTR VIOCOLORREG
ENDIF

IFNDEF VIOSETULINELOC
VIOSETULINELOC  STRUCT  2 ; viouline
cb_             WORD    0
type_           WORD    0
scanline_       WORD    0
VIOSETULINELOC  ENDS
PVIOSETULINELOC TYPEDEF FAR PTR VIOSETULINELOC
ENDIF

IFNDEF VIOSETTARGET
VIOSETTARGET    STRUCT  2 ; viosett
cb_             WORD    0
type_           WORD    0
defaultalgorithm_       WORD   0
VIOSETTARGET    ENDS
PVIOSETTARGET   TYPEDEF FAR PTR VIOSETTARGET
ENDIF

VioGetState     PROTO FAR PASCAL \
                pState:PVOID, hv:HVIO

VioSetState     PROTO FAR PASCAL \
                pState:PVOID, hv:HVIO

ENDIF ; INCL_VIO

IFDEF INCL_MOU

HMOU		TYPEDEF		WORD
PHMOU           TYPEDEF         FAR PTR HMOU

MouRegister     PROTO FAR PASCAL \
                pszModName:PSZ, pszEntryName:PSZ, flFuns:DWORD

MR_MOUGETNUMBUTTONS     EQU     00000001h
MR_MOUGETNUMMICKEYS     EQU     00000002h
MR_MOUGETDEVSTATUS      EQU     00000004h
MR_MOUGETNUMQUEEL       EQU     00000008h
MR_MOUREADEVENTQUE      EQU     00000010h
MR_MOUGETSCALEFACT      EQU     00000020h
MR_MOUGETEVENTMASK      EQU     00000040h
MR_MOUSETSCALEFACT      EQU     00000080h
MR_MOUSETEVENTMASK      EQU     00000100h
MR_MOUOPEN              EQU     00000800h
MR_MOUCLOSE             EQU     00001000h
MR_MOUGETPTRSHAPE       EQU     00002000h
MR_MOUSETPTRSHAPE       EQU     00004000h
MR_MOUDRAWPTR           EQU     00008000h
MR_MOUREMOVEPTR         EQU     00010000h
MR_MOUGETPTRPOS         EQU     00020000h
MR_MOUSETPTRPOS         EQU     00040000h
MR_MOUINITREAL          EQU     00080000h
MR_MOUSETDEVSTATUS      EQU     00100000h

MouDeRegister   PROTO FAR PASCAL

MouFlushQue     PROTO FAR PASCAL \
                hm:HMOU

MHK_BUTTON1             EQU     0001h
MHK_BUTTON2             EQU     0002h
MHK_BUTTON3             EQU     0004h

; structure for MouGet/SetPtrPos
IFNDEF PTRLOC
PTRLOC          STRUCT  2 ; moupl
row_            WORD    0
col_            WORD    0
PTRLOC          ENDS
PPTRLOC         TYPEDEF FAR PTR PTRLOC
ENDIF

MouGetPtrPos    PROTO FAR PASCAL \
                pmouLoc:PPTRLOC, hm:HMOU

MouSetPtrPos    PROTO FAR PASCAL \
                pmouLoc:PPTRLOC, hm:HMOU

; structure for MouGet/SetPtrShape
IFNDEF PTRSHAPE
PTRSHAPE        STRUCT  2 ; moups
cb_             WORD    0
col_            WORD    0
row_            WORD    0
colHot_         WORD    0
rowHot_         WORD    0
PTRSHAPE        ENDS
PPTRSHAPE       TYPEDEF FAR PTR PTRSHAPE
ENDIF

MouSetPtrShape  PROTO FAR PASCAL \
                pBuf:PBYTE, pmoupsInfo:PPTRSHAPE, hm:HMOU

MouGetPtrShape  PROTO FAR PASCAL \
                pBuf:PBYTE, pmoupsInfo:PPTRSHAPE, hm:HMOU

; MouGetDevStatus/MouSetDevStatus device status constants
MOUSE_QUEUEBUSY         EQU     0001h
MOUSE_BLOCKREAD         EQU     0002h
MOUSE_FLUSH             EQU     0004h
MOUSE_UNSUPPORTED_MODE  EQU     0008h
MOUSE_DISABLED          EQU     0100h
MOUSE_MICKEYS           EQU     0200h

MouGetDevStatus PROTO FAR PASCAL \
                pfsDevStatus:PWORD, hm:HMOU

MouGetNumButtons PROTO FAR PASCAL \
                pcButtons:PWORD, hm:HMOU

MouGetNumMickeys PROTO FAR PASCAL \
                pcMickeys:PWORD, hm:HMOU

; MouReadEventQue

MOU_NOWAIT      EQU     0000h
MOU_WAIT        EQU     0001h

; Structure for MouReadEventQue
IFNDEF MOUEVENTINFO
MOUEVENTINFO    STRUCT  2 ; mouev
fs_             WORD    0
time_           DWORD   0
row_            WORD    0
col_            WORD    0
MOUEVENTINFO    ENDS
PMOUEVENTINFO   TYPEDEF FAR PTR MOUEVENTINFO
ENDIF

MouReadEventQue PROTO FAR PASCAL \
                pmouevEvent:PMOUEVENTINFO, pfWaitFor:PWORD, hm:HMOU

; structure for MouGetNumQueEl
IFNDEF MOUQUEINFO
MOUQUEINFO      STRUCT  2 ; mouqi
cEvents_        WORD    0
cmaxEvents_     WORD    0
MOUQUEINFO      ENDS
PMOUQUEINFO     TYPEDEF FAR PTR MOUQUEINFO
ENDIF

MouGetNumQueEl  PROTO FAR PASCAL \
                qmouqi:PMOUQUEINFO, hm:HMOU

; MouGetEventMask/MouSetEventMask events

MOUSE_MOTION                    EQU     0001h
MOUSE_MOTION_WITH_BN1_DOWN      EQU     0002h
MOUSE_BN1_DOWN                  EQU     0004h
MOUSE_MOTION_WITH_BN2_DOWN      EQU     0008h
MOUSE_BN2_DOWN                  EQU     0010h
MOUSE_MOTION_WITH_BN3_DOWN      EQU     0020h
MOUSE_BN3_DOWN                  EQU     0040h

MouGetEventMask PROTO FAR PASCAL \
                pfsEvents:PWORD, hm:HMOU

MouSetEventMask PROTO FAR PASCAL \
                pfsEvents:PWORD, hm:HMOU

; Structure for MouGet/SetScaleFact
IFNDEF SCALEFACT
SCALEFACT       STRUCT  2 ; mousc
rowScale_       WORD    0
colScale_       WORD    0
SCALEFACT       ENDS
PSCALEFACT      TYPEDEF FAR PTR SCALEFACT
ENDIF

MouGetScaleFact PROTO FAR PASCAL \
                pmouscFactors:PSCALEFACT, hm:HMOU

MouSetScaleFact PROTO FAR PASCAL \
                pmouscFactors:PSCALEFACT, hm:HMOU

MouOpen         PROTO FAR PASCAL \
                pszDvrName:PSZ, phm:PHMOU

MouClose        PROTO FAR PASCAL \
                hm:HMOU

; structure for MouRemovePtr
IFNDEF NOPTRRECT
NOPTRRECT       STRUCT  2 ; mourt
row_            WORD    0
col_            WORD    0
cRow_           WORD    0
cCol_           WORD    0
NOPTRRECT       ENDS
PNOPTRRECT      TYPEDEF FAR PTR NOPTRRECT
ENDIF

MouRemovePtr    PROTO FAR PASCAL \
                pmourtRect:PNOPTRRECT, hm:HMOU

MouDrawPtr      PROTO FAR PASCAL \
                hm:HMOU

MOU_NODRAW      EQU     0001h
MOU_DRAW        EQU     0000h
MOU_MICKEYS     EQU     0002h
MOU_PELS        EQU     0000h

MouSetDevStatus PROTO FAR PASCAL \
                pfsDevStatus:PWORD, hm:HMOU

MouInitReal     PROTO FAR PASCAL \
                pszDvrName:PSZ

MouSynch        PROTO FAR PASCAL \
                fWaitFor:WORD

ENDIF ; INCL_MOU
