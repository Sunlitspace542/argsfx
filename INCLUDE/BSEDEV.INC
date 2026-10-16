;
; Module Name: BSEDEV.INC
;
; OS/2 Structures and constants for use with DosDevIOCtl
;
; Copyright (c) 1989-1990, Microsoft Corporation.  All rights reserved.
;

BSEDEV_INCLUDED EQU     1

;  Input and Output Control Categories
IOCTL_ASYNC             EQU     0001h
IOCTL_SCR_AND_PTRDRAW   EQU     0003h
IOCTL_KEYBOARD          EQU     0004h
IOCTL_PRINTER           EQU     0005h
IOCTL_LIGHTPEN          EQU     0006h
IOCTL_POINTINGDEVICE    EQU     0007h
IOCTL_DISK              EQU     0008h
IOCTL_PHYSICALDISK      EQU     0009h
IOCTL_MONITOR           EQU     000ah
IOCTL_GENERAL           EQU     000bh

;  Serial-Device Control
ASYNC_SETBAUDRATE       EQU     0041h
ASYNC_SETLINECTRL       EQU     0042h
ASYNC_TRANSMITIMM       EQU     0044h
ASYNC_SETBREAKOFF       EQU     0045h
ASYNC_SETMODEMCTRL      EQU     0046h
ASYNC_SETBREAKON        EQU     004bh
ASYNC_STOPTRANSMIT      EQU     0047h
ASYNC_STARTTRANSMIT     EQU     0048h
ASYNC_SETDCBINFO        EQU     0053h
ASYNC_GETBAUDRATE       EQU     0061h
ASYNC_GETLINECTRL       EQU     0062h
ASYNC_GETCOMMSTATUS     EQU     0064h
ASYNC_GETLINESTATUS     EQU     0065h
ASYNC_GETMODEMOUTPUT    EQU     0066h
ASYNC_GETMODEMINPUT     EQU     0067h
ASYNC_GETINQUECOUNT     EQU     0068h
ASYNC_GETOUTQUECOUNT    EQU     0069h
ASYNC_GETCOMMERROR      EQU     006dh
ASYNC_GETCOMMEVENT      EQU     0072h
ASYNC_GETDCBINFO        EQU     0073h

;  Screen/Pointer-Draw Control
SCR_ALLOCLDT            EQU     0070h
SCR_DEALLOCLDT          EQU     0071h
PTR_GETPTRDRAWADDRESS   EQU     0072h
SCR_ALLOCLDTOFF         EQU     0075h

;  Keyboard Control
KBD_SETTRANSTABLE       EQU     0050h
KBD_SETINPUTMODE        EQU     0051h
KBD_SETINTERIMFLAG      EQU     0052h
KBD_SETSHIFTSTATE       EQU     0053h
KBD_SETTYPAMATICRATE    EQU     0054h
KBD_SETFGNDSCREENGRP    EQU     0055h
KBD_SETSESMGRHOTKEY     EQU     0056h
KBD_SETFOCUS            EQU     0057h
KBD_SETKCB              EQU     0058h
KBD_SETNLS              EQU     005ch
KBD_CREATE              EQU     005dh
KBD_DESTROY             EQU     005eh
KBD_GETINPUTMODE        EQU     0071h
KBD_GETINTERIMFLAG      EQU     0072h
KBD_GETSHIFTSTATE       EQU     0073h
KBD_READCHAR            EQU     0074h
KBD_PEEKCHAR            EQU     0075h
KBD_GETSESMGRHOTKEY     EQU     0076h
KBD_GETKEYBDTYPE        EQU     0077h
KBD_GETCODEPAGEID       EQU     0078h
KBD_XLATESCAN           EQU     0079h

;  Printer Control
PRT_SETFRAMECTL         EQU     0042h
PRT_SETINFINITERETRY    EQU     0044h
PRT_INITPRINTER         EQU     0046h
PRT_ACTIVATEFONT        EQU     0048h
PRT_GETFRAMECTL         EQU     0062h
PRT_GETINFINITERETRY    EQU     0064h
PRT_GETPRINTERSTATUS    EQU     0066h
PRT_QUERYACTIVEFONT     EQU     0069h
PRT_VERIFYFONT          EQU     006ah

;  Pointing-Device (Mouse) Control
MOU_ALLOWPTRDRAW        EQU     0050h
MOU_UPDATEDISPLAYMODE   EQU     0051h
MOU_SCREENSWITCH        EQU     0052h
MOU_SETSCALEFACTORS     EQU     0053h
MOU_SETEVENTMASK        EQU     0054h
MOU_SETHOTKEYBUTTON     EQU     0055h
MOU_SETPTRSHAPE         EQU     0056h
MOU_DRAWPTR             EQU     0057h
MOU_REMOVEPTR           EQU     0058h
MOU_SETPTRPOS           EQU     0059h
MOU_SETPROTDRAWADDRESS  EQU     005ah
MOU_SETREALDRAWADDRESS  EQU     005bh
MOU_SETMOUSTATUS        EQU     005ch
MOU_DISPLAYMODECHANGE   EQU     005dh
MOU_GETBUTTONCOUNT      EQU     0060h
MOU_GETMICKEYCOUNT      EQU     0061h
MOU_GETMOUSTATUS        EQU     0062h
MOU_READEVENTQUE        EQU     0063h
MOU_GETQUESTATUS        EQU     0064h
MOU_GETEVENTMASK        EQU     0065h
MOU_GETSCALEFACTORS     EQU     0066h
MOU_GETPTRPOS           EQU     0067h
MOU_GETPTRSHAPE         EQU     0068h
MOU_GETHOTKEYBUTTON     EQU     0069h
MOU_VER                 EQU     006ah

;  Disk/Diskette Control
DSK_LOCKDRIVE           EQU     0000h
DSK_UNLOCKDRIVE         EQU     0001h
DSK_REDETERMINEMEDIA    EQU     0002h
DSK_SETLOGICALMAP       EQU     0003h
DSK_BLOCKREMOVABLE      EQU     0020h
DSK_GETLOGICALMAP       EQU     0021h
DSK_SETDEVICEPARAMS     EQU     0043h
DSK_WRITETRACK          EQU     0044h
DSK_FORMATVERIFY        EQU     0045h
DSK_GETDEVICEPARAMS     EQU     0063h
DSK_READTRACK           EQU     0064h
DSK_VERIFYTRACK         EQU     0065h

;  Physical-Disk Control
PDSK_LOCKPHYSDRIVE      EQU     0000h
PDSK_UNLOCKPHYSDRIVE    EQU     0001h
PDSK_WRITEPHYSTRACK     EQU     0044h
PDSK_GETPHYSDEVICEPARAMS EQU    0063h
PDSK_READPHYSTRACK      EQU     0064h
PDSK_VERIFYPHYSTRACK    EQU     0065h

;  Character-Monitor Control
MON_REGISTERMONITOR     EQU     0040h

;  General Device Control
DEV_FLUSHINPUT          EQU     0001h
DEV_FLUSHOUTPUT         EQU     0002h
DEV_QUERYMONSUPPORT     EQU     0060h

;  ASYNC_GETCOMMERROR, ASYNC_SETBREAKOFF, ASYNC_SETBREAKON,
;  ASYNC_SETMODEMCTRL
RX_QUE_OVERRUN          EQU     0001h
RX_HARDWARE_OVERRUN     EQU     0002h
PARITY_ERROR            EQU     0004h
FRAMING_ERROR           EQU     0008h

;  ASYNC_GETCOMMEVENT
CHAR_RECEIVED           EQU     0001h
LAST_CHAR_SENT          EQU     0004h
CTS_CHANGED             EQU     0008h
DSR_CHANGED             EQU     0010h
DCD_CHANGED             EQU     0020h
BREAK_DETECTED          EQU     0040h
ERROR_OCCURRED          EQU     0080h
RI_DETECTED             EQU     0100h

;  ASYNC_GETCOMMSTATUS
TX_WAITING_FOR_CTS      EQU     0001h
TX_WAITING_FOR_DSR      EQU     0002h
TX_WAITING_FOR_DCD      EQU     0004h
TX_WAITING_FOR_XON      EQU     0008h
TX_WAITING_TO_SEND_XON  EQU     0010h
TX_WAITING_WHILE_BREAK_ON EQU   0020h
TX_WAITING_TO_SEND_IMM  EQU     0040h
RX_WAITING_FOR_DSR      EQU     0080h

;  ASYNC_GETLINESTATUS
WRITE_REQUEST_QUEUED    EQU     0001h
DATA_IN_TX_QUE          EQU     0002h
HARDWARE_TRANSMITTING   EQU     0004h
CHAR_READY_TO_SEND_IMM  EQU     0008h
WAITING_TO_SEND_XON     EQU     0010h
WAITING_TO_SEND_XOFF    EQU     0020h

;  ASYNC_GETMODEMINPUT
CTS_ON                  EQU     0010h
DSR_ON                  EQU     0020h
RI_ON                   EQU     0040h
DCD_ON                  EQU     0080h

;  DSK_SETDEVICEPARAMS
BUILD_BPB_FROM_MEDIUM   EQU     0000h
REPLACE_BPB_FOR_DEVICE  EQU     0001h
REPLACE_BPB_FOR_MEDIUM  EQU     0002h

;  KBD_GETINPUTMODE, KBD_PEEKCHAR, KBD_SETINPUTMODE
ASCII_MODE              EQU     0000h
BINARY_MODE             EQU     0080h

;  KBD_GETINTERIMFLAG
CONVERSION_REQUEST      EQU     0020h
INTERIM_CHAR            EQU     0080h

;  KBD_GETSESMGRHOTKEY
HOTKEY_MAX_COUNT        EQU     0000h
HOTKEY_CURRENT_COUNT    EQU     0001h

;  KBD_PEEKCHAR
KBD_DATA_RECEIVED       EQU     0001h
KBD_DATA_BINARY         EQU     8000h

;  KBD_READCHAR
KBD_READ_WAIT           EQU     0000h
KBD_READ_NOWAIT         EQU     8000h

;  KBD_SETINPUTMODE
SHIFT_REPORT_MODE       EQU     0001h

IFNDEF INCL_MOU

MOUSE_MOTION            EQU     0001h
MOUSE_MOTION_WITH_BN1_DOWN EQU  0002h
MOUSE_BN1_DOWN          EQU     0004h
MOUSE_MOTION_WITH_BN2_DOWN EQU  0008h
MOUSE_BN2_DOWN          EQU     0010h
MOUSE_MOTION_WITH_BN3_DOWN EQU  0020h
MOUSE_BN3_DOWN          EQU     0040h

MHK_BUTTON1             EQU     0001h
MHK_BUTTON2             EQU     0002h
MHK_BUTTON3             EQU     0004h

MOU_NOWAIT              EQU     0000h
MOU_WAIT                EQU     0001h

ENDIF ; INCL_MOU

;  MOU_GETHOTKEYBUTTON, MOU_SETHOTKEYBUTTON
MHK_NO_HOTKEY           EQU     0000h

;  MOU_GETMOUSTATUS
MOUSE_QUEUEBUSY         EQU     0001h
MOUSE_BLOCKREAD         EQU     0002h
MOUSE_FLUSH             EQU     0004h
MOUSE_UNSUPPORTED_MODE  EQU     0008h
MOUSE_DISABLED          EQU     0100h
MOUSE_MICKEYS           EQU     0200h

;  PRT_GETPRINTERSTATUS
PRINTER_TIMEOUT         EQU     0001h
PRINTER_IO_ERROR        EQU     0008h
PRINTER_SELECTED        EQU     0010h
PRINTER_OUT_OF_PAPER    EQU     0020h
PRINTER_ACKNOWLEDGED    EQU     0040h
PRINTER_NOT_BUSY        EQU     0080h

;  fbCtlHndShake
MODE_DTR_CONTROL        EQU     0001h
MODE_DTR_HANDSHAKE      EQU     0002h
MODE_CTS_HANDSHAKE      EQU     0008h
MODE_DSR_HANDSHAKE      EQU     0010h
MODE_DCD_HANDSHAKE      EQU     0020h
MODE_DSR_SENSITIVITY    EQU     0040h

;  fbFlowReplace
MODE_AUTO_TRANSMIT      EQU     0001h
MODE_AUTO_RECEIVE       EQU     0002h
MODE_ERROR_CHAR         EQU     0004h
MODE_NULL_STRIPPING     EQU     0008h
MODE_BREAK_CHAR         EQU     0010h
MODE_RTS_CONTROL        EQU     0040h
MODE_RTS_HANDSHAKE      EQU     0080h
MODE_TRANSMIT_TOGGLE    EQU     00c0h

;  fbTimeout
MODE_NO_WRITE_TIMEOUT   EQU     0001h
MODE_READ_TIMEOUT       EQU     0002h
MODE_WAIT_READ_TIMEOUT  EQU     0004h
MODE_NOWAIT_READ_TIMEOUT EQU    0006h

DCBINFO         STRUCT 2        ; dcbinf
usWriteTimeout_ WORD            0
usReadTimeout_  WORD            0
fbCtlHndShake_  BYTE            0
fbFlowReplace_  BYTE            0
fbTimeout_      BYTE            0
bErrorReplacementChar_  BYTE    0
bBreakReplacementChar_  BYTE    0
bXONChar_       BYTE            0
bXOFFChar_      BYTE            0
DCBINFO         ENDS
PDCBINFO        TYPEDEF FAR PTR DCBINFO

;  trckl
TRACKTYPE       STRUCT 2
usSectorNumber_ WORD    0
usSectorSize_   WORD    0
TRACKTYPE       ENDS
PTRACKTYPE      TYPEDEF FAR PTR TRACKTYPE


TRACKLAYOUT     STRUCT 2
bCommand_       BYTE            0
usHead_         WORD            0
usCylinder_     WORD            0
usFirstSector_  WORD            0
cSectors_       WORD            0
TrackTable_     PTRACKTYPE      0
TRACKLAYOUT     ENDS
PTRACKLAYOUT    TYPEDEF FAR PTR TRACKLAYOUT

DEVTYPE_48TPI   EQU     0000h
DEVTYPE_96TPI   EQU     0001h
DEVTYPE_35      EQU     0002h
DEVTYPE_8SD     EQU     0003h
DEVTYPE_8DD     EQU     0004h
DEVTYPE_FIXED   EQU     0005h
DEVTYPE_TAPE    EQU     0006h
DEVTYPE_UNKNOWN EQU     0007h


BIOSPARAMETERBLOCK      STRUCT 2        ; bspblk
usBytesPerSector_       WORD    0
bSectorsPerCluster_     BYTE    0
usReservedSectors_      WORD    0
cFATs_                  BYTE    0
cRootEntries_           WORD    0
cSectors_               WORD    0
bMedia_                 BYTE    0
usSectorsPerFAT_        WORD    0
usSectorsPerTrack_      WORD    0
cHeads_                 WORD    0
cHiddenSectors_         DWORD   0
cLargeSectors_          DWORD   0
cCylinders_             WORD    0
bDeviceType_            BYTE    0
fsDeviceAttr_           WORD    0
BIOSPARAMETERBLOCK      ENDS
PBIOSPARAMETERBLOCK     TYPEDEF FAR PTR BIOSPARAMETERBLOCK


SCREENGROUP     STRUCT 2        ; scrgrp
idScreenGrp_    WORD    0
fTerminate_     WORD    0
SCREENGROUP     ENDS
PSCREENGROUP    TYPEDEF FAR PTR SCREENGROUP


FRAME           STRUCT 2        ; frm
bCharsPerLine_  BYTE    0
bLinesPerInch_  BYTE    0
FRAME           ENDS
PFRAME          TYPEDEF FAR PTR FRAME

KBDTYPE         STRUCT 2        ;  kbdtyp
usType_         WORD    0
reserved1_      WORD    0
reserved2_      WORD    0
KBDTYPE         ENDS
PKBDTYPE        TYPEDEF FAR PTR KBDTYPE

LINECONTROL     STRUCT 2        ; lnctl
bDataBits_      BYTE    0
bParity_        BYTE    0
bStopBits_      BYTE    0
fTransBreak_    BYTE    0
LINECONTROL     ENDS
PLINECONTROL    TYPEDEF FAR PTR LINECONTROL

;  MODEMSTATUS.fbModemOn, ASYNC_GETMODEMOUTPUT
DTR_ON          EQU     0001h
RTS_ON          EQU     0002h

;  MODEMSTATUS.fbModemOff
DTR_OFF         EQU     00feh
RTS_OFF         EQU     00fdh

;  mdmst
MODEMSTATUS     STRUCT 2
fbModemOn_      BYTE    0
fbModemOff_     BYTE    0
MODEMSTATUS     ENDS
PMODEMSTATUS    TYPEDEF FAR PTR MODEMSTATUS

;  trckfmt
TRACKFMT        STRUCT 2
bCylinder_      BYTE    0
bHead_          BYTE    0
idSector_       BYTE    0
bBytesSector_   BYTE    0
TRACKFMT        ENDS
PTRACKFMT       TYPEDEF FAR PTR TRACKFMT

TRACKFORMAT     STRUCT 2
bCommand_       BYTE    0
usHead_         WORD    0
usCylinder_     WORD    0
usReserved_     WORD    0
cSectors_       WORD    0
FormatTable_    PTRACKFMT 0
TRACKFORMAT     ENDS
PTRACKFORMAT    TYPEDEF FAR PTR TRACKFORMAT

RXQUEUE         STRUCT 2        ;  rxq
cch_            WORD    0
cb_             WORD    0
RXQUEUE         ENDS
PRXQUEUE        TYPEDEF FAR PTR RXQUEUE

DEVICEPARAMETERBLOCK    STRUCT 2        ;  dvpblck
reserved1_              WORD    0
cCylinders_             WORD    0
cHeads_                 WORD    0
cSectorsPerTrack_       WORD    0
reserved2_              WORD    0
reserved3_              WORD    0
reserved4_              WORD    0
reserved5_              WORD    0
DEVICEPARAMETERBLOCK    ENDS
PDEVICEPARAMETERBLOCK   TYPEDEF FAR PTR DEVICEPARAMETERBLOCK

PTRDRAWFUNCTION         STRUCT 2        ;  ptrdfnc
usReturnCode_           WORD    0
pfnDraw_                PFN     0
pchDataSeg_             PCH     0
PTRDRAWFUNCTION         ENDS
PPTRDRAWFUNCTION        TYPEDEF FAR PTR PTRDRAWFUNCTION

PTRDRAWADDRESS  STRUCT 2        ;  ptrdaddr
reserved_       WORD            0
ptrdfnc_        PTRDRAWFUNCTION <>
PTRDRAWADDRESS  ENDS
PPTRDRAWADDRESS TYPEDEF FAR PTR PTRDRAWADDRESS

SHIFTSTATE      STRUCT 2        ; shftst
fsState_        WORD    0
fNLS_           BYTE    0
SHIFTSTATE      ENDS
PSHIFTSTATE     TYPEDEF FAR PTR SHIFTSTATE

;  HOTKEY.fsHotKey/SHIFTSTATE.fsState
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


HOTKEY                  STRUCT 2        ; htky
fsHotKey_               WORD    0
uchScancodeMake_        BYTE    0
uchScancodeBreak_       BYTE    0
idHotKey_               WORD    0
HOTKEY                  ENDS
PHOTKEY                 TYPEDEF FAR PTR HOTKEY

MONITORPOSITION STRUCT 2        ; mnpos
fPosition_      WORD    0
index_          WORD    0
pbInBuf_        DWORD   0
offOutBuf_      WORD    0
MONITORPOSITION ENDS
PMONITORPOSITION        TYPEDEF FAR PTR MONITORPOSITION

RATEDELAY       STRUCT 2        ;  rtdly
usDelay_        WORD    0
usRate_         WORD    0
RATEDELAY       ENDS
PRATEDELAY      TYPEDEF         FAR PTR RATEDELAY

CODEPAGEINFO    STRUCT 2        ; cpi
pbTransTable_   PBYTE   0
idCodePage_     WORD    0
idTable_        WORD    0
CODEPAGEINFO    ENDS
PCODEPAGEINFO   TYPEDEF FAR PTR CODEPAGEINFO

CPID            STRUCT 2        ; cpid
idCodePage_     WORD    0
Reserved_       WORD    0
CPID            ENDS
PCPID           TYPEDEF FAR PTR CPID

LDTADDRINFO     STRUCT 2        ; ldtaddr
pulPhysAddr_    PULONG  0
cb_             WORD    0
LDTADDRINFO     ENDS
PLDTADDRINFO    TYPEDEF FAR PTR LDADDRINFO

PTRDRAWDATA     STRUCT 2        ; ptrdd
cb_             WORD    0
usConfig_       WORD    0
usFlag_         WORD    0
PTRDRAWDATA     ENDS
PPTRDRAWDATA    TYPEDEF FAR PTR PTRDRAWDATA
