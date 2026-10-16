;
; Module Name: BSEDOS.INC
;
; OS/2 Base Include File
;
; Copyright (c) 1987-1990, Microsoft Corporation.  All rights reserved.
;
; =======================================================================
;
; Subcomponents marked with "+" are partially included by default
;
;   #define:          To include:
;
; + INCL_DOSPROCESS   Process and thread support
;   INCL_DOSINFOSEG   InfoSeg support
; + INCL_DOSFILEMGR   File Management
; + INCL_DOSMEMMGR    Memory Management
; + INCL_DOSSEMAPHORES        Semaphore support
; + INCL_DOSDATETIME  Date/Time and Timer support
;   INCL_DOSMODULEMGR Module manager
; + INCL_DOSRESOURCES Resource support
;   INCL_DOSNLS       National Language Support
;   INCL_DOSSIGNALS   Signals
;   INCL_DOSMISC      Miscellaneous
;   INCL_DOSMONITORS  Monitors
;   INCL_DOSQUEUES    Queues
;   INCL_DOSSESMGR    Session Manager Support
;   INCL_DOSDEVICES   Device specific, ring 2 support
;   INCL_DOSNMPIPES   Named Pipes Support
;   INCL_DOSTRACE     Trace support
;

INCL_DOSINCLUDED        EQU     1

IFDEF INCL_DOS
INCL_DOSPROCESS         EQU     1
INCL_DOSINFOSEG         EQU     1
INCL_DOSFILEMGR         EQU     1
INCL_DOSMEMMGR          EQU     1
INCL_DOSSEMAPHORES      EQU     1
INCL_DOSDATETIME        EQU     1
INCL_DOSMODULEMGR       EQU     1
INCL_DOSRESOURCES       EQU     1
INCL_DOSNLS             EQU     1
INCL_DOSSIGNALS         EQU     1
INCL_DOSMISC            EQU     1
INCL_DOSMONITORS        EQU     1
INCL_DOSQUEUES          EQU     1
INCL_DOSSESMGR          EQU     1
INCL_DOSDEVICES         EQU     1
INCL_DOSNMPIPES         EQU     1
INCL_DOSTRACE           EQU     1
ENDIF ; INCL_DOS

IFDEF INCL_ERRORS
INCL_DOSERRORS          EQU     1
ENDIF ; INCL_ERRORS

; DosExit is always defined so that .EXIT will always work
DosExit         PROTO FAR PASCAL \
                fTerminate:BOOL, usExitCode:WORD

; DosExit fTerminate
EXIT_THREAD     EQU     0
EXIT_PROCESS    EQU     1

IF DEFINED( INCL_DOSPROCESS ) OR NOT DEFINED( INCL_NOCOMMON )

; General services
DosBeep         PROTO FAR PASCAL \
                usFrequency:WORD, usDuration:WORD

ENDIF  ; common INCL_DOSPROCESS definitions

IF DEFINED( INCL_DOSPROCESS ) AND NOT DEFINED( INCL_DOSPROCESS_INCLUDED )
INCL_DOSPROCESS_INCLUDED EQU 1

PIDINFO         STRUCT  2 ; pidi
pidCur_         PID     0
tidCur_         TID     0
pidParent_      PID     0
PIDINFO         ENDS
PPIDINFO        TYPEDEF FAR PTR PIDINFO

PFTHREAD        TYPEDEF PROTO FAR PASCAL
PFNTHREAD       TYPEDEF PTR PFTHREAD

DosCreateThread PROTO FAR PASCAL \
                pfnFun:PFNTHREAD, pTidThread:PTID, pbStack:PBYTE

DosResumeThread PROTO FAR PASCAL \
                tidThread:TID

DosSuspendThread PROTO FAR PASCAL \
                tidThread:TID

; DosCwait fScope
DCWA_PROCESS            EQU     0
DCWA_PROCESSTREE        EQU     1

; DosCwait ffWait
DCWW_WAIT               EQU     0
DCWW_NOWAIT             EQU     1

RESULTCODES     STRUCT  2 ; resc
codeTerminate_  WORD    0
codeResult_     WORD    0
RESULTCODES     ENDS
PRESULTCODES    TYPEDEF FAR PTR RESULTCODES

DosCwait        PROTO FAR PASCAL \
                fScope:WORD,
                fWaitFor:WORD,
                prescResults:PRESULTCODES,
                ppidProcess:PPID,
                pidWaitProcess:PID

DosSleep        PROTO FAR PASCAL \
                ulTime:DWORD

; codeTerminate values (also passed to ExitList routines)
TC_EXIT         EQU     0
TC_HARDERROR    EQU     1
TC_TRAP         EQU     2
TC_KILLPROCESS  EQU     3

PFEXITLIST      TYPEDEF PROTO FAR PASCAL :WORD
PFNEXITLIST     TYPEDEF PTR PFEXITLIST

DosEnterCritSec PROTO FAR PASCAL

DosExitCritSec  PROTO FAR PASCAL

DosExitList     PROTO FAR PASCAL \
                fFnCode:WORD, pfnFunction:PFNEXITLIST

; DosExitList fFnCode
EXLST_ADD       EQU     1
EXLST_REMOVE    EQU     2
EXLST_EXIT      EQU     3

DosExecPgm      PROTO FAR PASCAL \
                pchFailName:PCHAR, cbFailName:SWORD,
                fExecFlags:WORD, pszArgs:PSZ, pszEnv:PSZ,
                prescResults:PRESULTCODES, pszPgmName:PSZ

; DosExecPgm fExecFlags
EXEC_SYNC               EQU     0
EXEC_ASYNC              EQU     1
EXEC_ASYNCRESULT        EQU     2
EXEC_TRACE              EQU     3
EXEC_BACKGROUND         EQU     4

DosGetPID       PROTO FAR PASCAL \
                ppidInformation:PPIDINFO

DosGetPPID      PROTO FAR PASCAL \
                pidChild:PID, ppidParent:PPID

DosGetPrty      PROTO FAR PASCAL \
                usScope:WORD, pusPriority:PWORD, pid:WORD

DosSetPrty      PROTO FAR PASCAL \
                usScope:WORD, fPrtyClass:WORD, sChange:SWORD, id:WORD

; DosGetPrty/DosSetPrty usScope
PRTYS_PROCESS           EQU     0
PRTYS_PROCESSTREE       EQU     1
PRTYS_THREAD            EQU     2

; DosGetPrty/DosSetPrty priority classes
PRTYC_NOCHANGE          EQU     0
PRTYC_IDLETIME          EQU     1
PRTYC_REGULAR           EQU     2
PRTYC_TIMECRITICAL      EQU     3
PRTYC_FOREGROUNDSERVER  EQU     4

; DosSetPrty priority deltas (sChange)
PRTYD_MINIMUM           EQU     -31
PRTYD_MAXIMUM           EQU     31

DosKillProcess  PROTO FAR PASCAL \
                usScope:WORD, pidProcess:PID

; DosKillProcess usScope
DKP_PROCESSTREE         EQU     0
DKP_PROCESS             EQU     1

ENDIF ; INCL_DOSPROCESS

; InfoSeg support
IF DEFINED( INCL_DOSINFOSEG ) AND NOT DEFINED( INCL_DOSINFOSEG_INCLUDED )
INCL_DOSINFOSEG_INCLUDED EQU 1

; Global Information Segment
GINFOSEG                STRUCT  2 ; gis
time_                   DWORD   0
msecs_                  DWORD   0
hour_                   BYTE    0
minutes_                BYTE    0
seconds_                BYTE    0
hundredths_             BYTE    0
timezone_               WORD    0
cusecTimerInterval_     WORD    0
day_                    BYTE    0
month_                  BYTE    0
year_                   WORD    0
weekday_                BYTE    0
uchMajorVersion_        BYTE    0
uchMinorVersion_        BYTE    0
chRevisionLetter_       BYTE    0
sgCurrent_              BYTE    0
sgMax_                  BYTE    0
cHugeShift_             BYTE    0
fProtectModeOnly_       BYTE    0
pidForeground_          WORD    0
fDynamicSched_          BYTE    0
csecMaxWait_            BYTE    0
cmsecMinSlice_          WORD    0
cmsecMaxSlice_          WORD    0
bootdrive_              WORD    0
amecRAS_                BYTE    32 DUP (0)
csgWindowableVioMax_    BYTE    0
csgPMMax_               BYTE    0
GINFOSEG                ENDS
PGINFOSEG       TYPEDEF FAR PTR GINFOSEG

; Local Information Segment

LINFOSEG                STRUCT  2 ; lis
pidCurrent_             WORD    0
pidParent_              WORD    0
prtyCurrent_            WORD    0
tidCurrent_             WORD    0
sgCurrent_              WORD    0
rfProcStatus_           BYTE    0
dummy1_                 BYTE    0
fForeground_            WORD    0
typeProcess_            BYTE    0
dummy2_                 BYTE    0
selEnvironment_         WORD    0
offCmdLine_             WORD    0
cbDataSegment_          WORD    0
cbStack_                WORD    0
cbHeap_                 WORD    0
hmod_                   WORD    0
selDS_                  WORD    0
LINFOSEG                ENDS
PLINFOSEG       TYPEDEF FAR PTR LINFOSEG

; Process Type codes (local information segment typeProcess field)
PT_FULLSCREEN           EQU     0       ; Full screen application
PT_REALMODE             EQU     1       ; Real mode process
PT_WINDOWABLEVIO        EQU     2       ; VIO windowable application
PT_PM                   EQU     3       ; Presentation Manager application
PT_DETACHED             EQU     4       ; Detached application

; Process Status Flag definitions (local info seg rfProcStatus field)
PS_EXITLIST             EQU     1       ; Thread is in exitlist routine

DosGetInfoSeg   PROTO FAR PASCAL \
                pselGlobal:PSEL, pselLocal:PSEL

ENDIF ; INCL_DOSINFOSEG

IFNDEF INCL_SAADEFS

; CCHMAXPATH is the maximum fully qualified path name length including
; the drive letter, colon, backslashes and terminating NULL.
CCHMAXPATH      EQU     260

; CCHMAXPATHCOMP is the maximum individual path component name length
; including a terminating NULL.
CCHMAXPATHCOMP  EQU     256

ENDIF ; INCL_SAADEFS

IF DEFINED( INCL_DOSFILEMGR ) OR NOT \
   DEFINED( INCL_NOCOMMON ) AND NOT \
   DEFINED( INCL_DOSFILEMGR_INCLUDED )

INCL_DOSFILEMGR_INCLUDED EQU 1

; File manager

; DosChgFilePtr file position codes
FILE_BEGIN      EQU     0000h   ; relative to beginning of file
FILE_CURRENT    EQU     0001h   ; relative to current fptr position
FILE_END        EQU     0002h   ; relative to end of file

; DosFindFirst/Next Directory handle types
HDIR_SYSTEM     EQU     0001h   ; Use system handle (1)
HDIR_CREATE     EQU    0ffffh   ; Allocate a new, unused handle

; DosCopy control bits - may be or'ed together
DCPY_EXISTING   EQU     0001h   ; Copy even if target exists
DCPY_APPEND     EQU     0002h   ; Append to existing file, don't replace

; Dosopen/DosQFHandState/DosQueryFileInfo et al file attributes; also
; known as Dos File Mode bits...
FILE_NORMAL     EQU     0000h
FILE_READONLY   EQU     0001h
FILE_HIDDEN     EQU     0002h
FILE_SYSTEM     EQU     0004h
FILE_DIRECTORY  EQU     0010h
FILE_ARCHIVED   EQU     0020h

; DosOpen actions
FILE_EXISTED    EQU     0001h
FILE_CREATED    EQU     0002h
FILE_TRUNCATED  EQU     0003h

; DosOpen open flags
FILE_OPEN       EQU     0001h
FILE_TRUNCATE   EQU     0002h
FILE_CREATE     EQU     0010h

; applies if file already exists
OPEN_ACTION_FAIL_IF_EXISTS      EQU     0000h ; ---- ---- ---- 0000
OPEN_ACTION_OPEN_IF_EXISTS      EQU     0001h ; ---- ---- ---- 0001
OPEN_ACTION_REPLACE_IF_EXISTS   EQU     0002h ; ---- ---- ---- 0010

; applies if file does not exist
OPEN_ACTION_FAIL_IF_NEW         EQU     0000h ; ---- ---- 0000 ----
OPEN_ACTION_CREATE_IF_NEW       EQU     0010h ; ---- ---- 0001 ----

; DosOpen/DosSetFHandState flags
OPEN_ACCESS_READONLY            EQU     0000h ; ---- ---- ---- -000
OPEN_ACCESS_WRITEONLY           EQU     0001h ; ---- ---- ---- -001
OPEN_ACCESS_READWRITE           EQU     0002h ; ---- ---- ---- -010
OPEN_SHARE_DENYREADWRITE        EQU     0010h ; ---- ---- -001 ----
OPEN_SHARE_DENYWRITE            EQU     0020h ; ---- ---- -010 ----
OPEN_SHARE_DENYREAD             EQU     0030h ; ---- ---- -011 ----
OPEN_SHARE_DENYNONE             EQU     0040h ; ---- ---- -100 ----
OPEN_FLAGS_NOINHERIT            EQU     0080h ; ---- ---- 1--- ----
OPEN_FLAGS_NO_LOCALITY          EQU     0000h ; ---- -000 ---- ----
OPEN_FLAGS_SEQUENTIAL           EQU     0100h ; ---- -001 ---- ----
OPEN_FLAGS_RANDOM               EQU     0200h ; ---- -010 ---- ----
OPEN_FLAGS_RANDOMSEQUENTIAL     EQU     0300h ; ---- -011 ---- ----
OPEN_FLAGS_NO_CACHE             EQU     1000h ; ---1 ---- ---- ----
OPEN_FLAGS_FAIL_ON_ERROR        EQU     2000h ; --1- ---- ---- ----
OPEN_FLAGS_WRITE_THROUGH        EQU     4000h ; -1-- ---- ---- ----
OPEN_FLAGS_DASD                 EQU     8000h ; 1--- ---- ---- ----

; DosSearchPath constants from 1.1 (backword compatability)
SEARCH_PATH             EQU     0000h
SEARCH_CUR_DIRECTORY    EQU     0001h
SEARCH_ENVIRONMENT      EQU     0002h
SEARCH_IGNORENETERRS    EQU     0004h

; DosSearchPath constants for 1.2 and later
DSP_PATH                EQU     0       ; path is specified in parameter
DSP_CUR_DIRECTORY       EQU     1       ; current dir will be searched first
DSP_ENVIRONMENT         EQU     2       ; from envirnoment variable
DSP_IGNORENETERR        EQU     4       ; ignore net errs & continue search

DosSearchPath   PROTO FAR PASCAL \
                fsSearch:WORD, pszPath:PSZ, pszFName:PSZ,
                pBuf:PBYTE, cbBuf:WORD


; DosFileIO

; File IO command words
FIO_LOCK        EQU     0       ; Lock Files
FIO_UNLOCK      EQU     1       ; Unlock Files
FIO_SEEK        EQU     2       ; Seek (set file ptr)
FIO_READ        EQU     3       ; File Read
FIO_WRITE       EQU     4       ; File Write

; Lock Sharing Modes
FIO_NOSHARE     EQU     0       ; None
FIO_SHAREREAD   EQU     1       ; Read-Only

FIOLOCKCMD      STRUCT  2       ; FLC  FileLockCmd prefix
usCmd_          WORD    0       ; Cmd = FIO_LOCK
cLockCnt_       WORD    0       ; Lock records that follow
cTimeOut_       DWORD   0       ; in Msec
FIOLOCKCMD      ENDS
PFIOLOCKCMD     TYPEDEF FAR PTR FIOLOCKCMD

FIOLOCKREC      STRUCT  2       ; FLR FileLockRecord
fShare_         WORD    0       ; FIO_NOSHARE or FIO_SHAREREAD
cbStart_        DWORD   0       ; Starting offset for lock region
cbLength_       DWORD   0       ; Length of lock region
FIOLOCKREC      ENDS
PFIOLOCKREC     TYPEDEF FAR PTR FIOLOCKREC

FIOUNLOCKCMD    STRUCT  2       ; FUC FileUnlockCmd prefix
usCmd_          WORD    0       ; Cmd = FIO_UNLOCK
cUnlockCnt_     WORD    0       ; Unlock records that follow
FIOUNLOCKCMD    ENDS
PFIOUNLOCKCMD   TYPEDEF FAR PTR FIOUNLOCKCMD

FIOUNLOCKREC    STRUCT  2       ; FUR FileUnlockRecord
cbStart_        DWORD   0       ; Starting offset for unlock region
cbLength_       DWORD   0       ; Length of unlock region
FIOUNLOCKREC    ENDS
PFIOUNLOCKREC   TYPEDEF FAR PTR FIOUNLOCKREC

FIOSEEKCMD      STRUCT  2       ; FSC Seek command structure
usCmd_          WORD    0       ; Cmd = FIO_SEEK
fsMethod_       WORD    0       ; One of&gml FPM_BEGINNING, FPM_CURRENT,
                                ; or FPM_END
cbDistance_     DWORD   0       ; Byte offset for seek
cbNewPosition_  DWORD   0       ; Bytes from start of file after seek
FIOSEEKCMD      ENDS
PFIOSEEKCMD     TYPEDEF FAR PTR FIOSEEKCMD

FIOREADWRITE    STRUCT  2       ; FRWC Read&Write command structure
usCmd_          WORD    0       ; Cmd = FIO_READ or FIO_WRITE
pbBuffer_       PVOID   0       ; Pointer to data buffer
cbBufferLen_    WORD    0       ; Bytes in buffer or max size
cbActualLen_    WORD    0       ; Bytes actually read/written
FIOREADWRITE    ENDS
PFIOREADWRITE   TYPEDEF FAR PTR FIOREADWRITE

; EA Info Levels & Find First/Next
; API's: DosFindFirst, DosQueryFileInfo, DosQueryPathInfo, DosSetFileInfo,
;        DosSetPathInfo

; File info levels : All listed API's
FIL_STANDARD            EQU     1       ; Info level 1, standard file info
FIL_QUERYEASIZE         EQU     2       ; Level 2, return Full EA size
FIL_QUERYEASFROMLIST    EQU     3       ; Level 3, return requested EA's

; File info levels: Dos...PathInfo only
FIL_QUERYFULLNAME       EQU     5       ; Level 5, return fully qualified
                                        ; name of file
FIL_NAMEISVALID         EQU     6       ; Level 6, check validity of
                                        ; file/path name for this FSD

; DosFindNotifyFirst
FNOTIL_STANDARD         EQU     1       ; Find-Notify Info level 1&gml Return
                                        ; standard directory change info
; DosFsAttach
; Attact or detach
FSATTACH                EQU     0       ; Attach file server
FSDETACH                EQU     1       ; Detach file server

; DosFsCtl
; Routing type
FSCTL_HANDLE            EQU     1       ; File Handle directs req routing
FSCTL_PATHNAME          EQU     2       ; Path Name directs req routing
FSCTL_FSDNAME           EQU     3       ; FSD Name directs req routing

; DosQueryFSAttach
; Information level types (defines method of query)
FSAIL_QUERYNAME         EQU     1       ; Return data for a Drive or Device
FSAIL_DEVNUMBER         EQU     2       ; Return data for Ordinal Device #
FSAIL_DRVNUMBER         EQU     3       ; Return data for Ordinal Drive #

; Item types (from data structure item "iType")
FSAT_CHARDEV            EQU     1       ; Resident character device
FSAT_PSEUDODEV          EQU     2       ; Pseudo-character device
FSAT_LOCALDRV           EQU     3       ; Local drive
FSAT_REMOTEDRV          EQU     4       ; Remote drive attached to FSD

; Data structure for QFSAttach
FSQBUFFER       STRUCT  2               ; fsqbf
iType_          WORD    0               ; Item type
cbName_         WORD    0               ; Length of item name, sans NULL
szName_         BYTE    1 DUP (0)       ; ASCIIZ item name               ;??
cbFSDName_      WORD    0               ; Length of FSD name, sans NULL
szFSDName_      BYTE    1 DUP (0)       ; ASCIIZ FSD name                ;??
cbFSAData_      WORD    0               ; Length of FSD Attach data returned
rgFSAData_      BYTE    1 DUP (0)       ; FSD Attach data from FSD       ;??
FSQBUFFER       ENDS
PFSQBUFFER      TYPEDEF FAR PTR FSQBUFFER

; File System Drive Information&gml DosQFSInfo DosSetFSInfo

; FS Drive Info Levels
FSIL_ALLOC              EQU     1       ; Drive allocation info (Query only)
FSIL_VOLSER             EQU     2       ; Drive Volume/Serial information

; HANDTYPE values
HANDTYPE_FILE           EQU     0000h
HANDTYPE_DEVICE         EQU     0001h
HANDTYPE_PIPE           EQU     0002h
HANDTYPE_NETWORK        EQU     8000h

; DosQHandType
; Handle classes (low 8 bits of Handle Type)
FHT_DISKFILE            EQU     0000h       ; Disk file handle
FHT_CHRDEV              EQU     0001h       ; Character device handle
FHT_PIPE                EQU     0002h       ; Pipe handle

; Handle bits (high 8 bits of Handle Type)
FHB_DSKREMOTE           EQU     8000h       ; Remote disk
FHB_CHRDEVREMOTE        EQU     8001h       ; Remote character device
FHB_PIPEREMOTE          EQU     8002h       ; Remote pipe

IFNDEF INCL_SAADEFS

; File time and date types
FTIME   RECORD  twosecs:5, minutes:6, hours:5   ; ftime
PFTIME  TYPEDEF FAR PTR FTIME

FDATE   RECORD  day:5, month:4, year:7          ; fdate
PFDATE  TYPEDEF FAR PTR FDATE

FILEFINDBUF     STRUCT  2 ; findbuf
fdateCreation_          FDATE   <>
ftimeCreation_          FTIME   <>
fdateLastAccess_        FDATE   <>
ftimeLastAccess_        FTIME   <>
fdateLastWrite_         FDATE   <>
ftimeLastWrite_         FTIME   <>
cbFile_         DWORD   0
cbFileAlloc_    DWORD   0
attrFile_       WORD    0
cchName_        BYTE    0
achName_        SBYTE   CCHMAXPATHCOMP DUP (0)
FILEFINDBUF     ENDS
PFILEFINDBUF    TYPEDEF FAR PTR FILEFINDBUF

FILEFINDBUF2    STRUCT  2 ; findbuf2
fdateCreation_          FDATE   <>
ftimeCreation_          FTIME   <>
fdateLastAccess_        FDATE   <>
ftimeLastAccess_        FTIME   <>
fdateLastWrite_         FDATE   <>
ftimeLastWrite_         FTIME   <>
cbFile_         DWORD   0
cbFileAlloc_    DWORD   0
attrFile_       WORD    0
cbList_         DWORD   0
cchName_        BYTE    0
achName_        SBYTE   CCHMAXPATHCOMP DUP (0)
FILEFINDBUF2    ENDS
PFILEFINDBUF2   TYPEDEF FAR PTR FILEFINDBUF2

; extended attribute structures
GEA             STRUCT  2               ; gea
cbName_         BYTE    0               ; name length not including NULL
szName_         SBYTE   1 DUP (0)       ; attribute name    ;???
GEA             ENDS
PGEA            TYPEDEF FAR PTR GEA

GEALIST         STRUCT  2               ; geal
cbList_         DWORD   0               ; total bytes of structure inc full list
list_           GEA     1 DUP (<>)      ; variable length GEA structures
GEALIST         ENDS
PGEALIST        TYPEDEF FAR PTR GEALIST

FEA             STRUCT  2       ; fea
fEA_            BYTE    0       ; flags
cbName_         BYTE    0       ; name length not including NULL
cbValue_        WORD    0       ; value length
FEA             ENDS
PFEA            TYPEDEF FAR PTR FEA

; flags for _FEA.fEA

; need EA bit
FEA_NEEDEA      EQU     0080h

FEALIST         STRUCT  2       ; feal
cbList_         DWORD   0       ; total bytes of structure inc full list
list_           FEA     1 DUP (<>) ; variable length FEA structures
FEALIST         ENDS
PFEALIST        TYPEDEF FAR PTR FEALIST

EAOP            STRUCT  2               ; eaop
fpGEAList_      PGEALIST        0       ; general EA list
fpFEAList_      PFEALIST        0       ; full EA list
oError_         DWORD           0
EAOP            ENDS
PEAOP           TYPEDEF FAR PTR EAOP

; Equates for EA types
;
; Values 0xFFFE thru 0x8000 are reserved.
; Values 0x0000 thru 0x7fff are user definable.
; Value  0xFFFC is not used

EAT_BINARY      EQU     0fffeh  ; length preceeded binary
EAT_ASCII       EQU     0fffdh  ; length preceeded ASCII
EAT_BITMAP      EQU     0fffbh  ; length preceeded bitmap
EAT_METAFILE    EQU     0fffah  ; length preceeded metafile
EAT_ICON        EQU     0fff9h  ; length preceeded icon
EAT_EA          EQU     0ffeeh  ; length preceeded ASCII extended attribute
                                ; name of associated data (#include)
EAT_MVMT        EQU     0ffdfh  ; multi-valued, multi-typed field
EAT_MVST        EQU     0ffdeh  ; multi-valued, single-typed field
EAT_ASN1        EQU     0ffddh  ; ASN.1 field

ENDIF ; INCL_SAADEFS

DosOpen         PROTO FAR PASCAL \
                pszFname:PSZ, phfOpen:PHFILE, pusAction:PWORD,
                ulFSize:DWORD, usAttr:WORD, fsOpenFlags:WORD,
                fsOpenMode:WORD, ulReserved:DWORD

DosOpen2        PROTO FAR PASCAL \
                pszFname:PSZ, phf:PHFILE, pusAction:PWORD,
                ulFSize:DWORD, usAttr:WORD, usOpenFlags:WORD,
                usOpenMode:DWORD, pvEABuf:PEAOP, ulReserved:DWORD

DosClose        PROTO FAR PASCAL \
                hf:HFILE

DosRead         PROTO FAR PASCAL \
                hf:HFILE, pBuf:PVOID, cbBuf:WORD, pcbBytesRead:PWORD

DosWrite        PROTO FAR PASCAL \
                hf:HFILE, bBuf:PVOID, cbBuf:WORD, pcbBytesWritten:PWORD

DosOplockRelease PROTO FAR PASCAL \
                cookie:DWORD, procBlkKey:WORD

DosOplockWait   PROTO FAR PASCAL \
                pcookie:PDWORD, procBlkKey:PDWORD

; File system shutdown
DosShutdown     PROTO FAR PASCAL \
                ulReserved:DWORD

; File time and date types
FILESTATUS      STRUCT  2 ; fsts
fdateCreation_          FDATE   <>
ftimeCreation_          FTIME   <>
fdateLastAccess_        FDATE   <>
ftimeLastAccess_        FTIME   <>
fdateLastWrite_         FDATE   <>
ftimeLastWrite_         FTIME   <>
cbFile_         DWORD   0
cbFileAlloc_    DWORD   0
attrFile_       WORD    0
FILESTATUS      ENDS
PFILESTATUS     TYPEDEF FAR PTR FILESTATUS

FILESTATUS2     STRUCT  2 ; fsts2
fdateCreation_          FDATE   <>
ftimeCreation_          FTIME   <>
fdateLastAccess_        FDATE   <>
ftimeLastAccess_        FTIME   <>
fdateLastWrite_         FDATE   <>
ftimeLastWrite_         FTIME   <>
cbFile_         DWORD   0
cbFileAlloc_    DWORD   0
attrFile_       WORD    0
cbList          DWORD   0
FILESTATUS2     ENDS
PFILESTATUS2    TYPEDEF FAR PTR FILESTATUS2

FSALLOCATE      STRUCT  2 ; fsalloc
ulReserved_     DWORD   0
cSectorUnit_    DWORD   0
cUnit_          DWORD   0
cUnitAvail_     DWORD   0
cbSector_       WORD    0
FSALLOCATE      ENDS
PFSALLOCATE     TYPEDEF FAR PTR FSALLOCATE

VOLUMELABEL     STRUCT  2 ; vol
cch_            BYTE    0
szVolLabel_     SBYTE   12 DUP (0)
VOLUMELABEL     ENDS
PVOLUMELABEL    TYPEDEF FAR PTR VOLUMELABEL

FSINFO          STRUCT  2       ; fsinf
ulVSN_          DWORD           0
vol_            VOLUMELABEL     <>      ;???
FSINFO          ENDS
PFSINFO         TYPEDEF FAR PTR FSINFO

FILELOCK        STRUCT  2 ; flock
lOffset_        SDWORD  0
lRange_         SDWORD  0
FILELOCK        ENDS
PFILELOCK       TYPEDEF FAR PTR FILELOCK

HDIR            TYPEDEF         WORD    ; hdir
PHDIR           TYPEDEF         FAR PTR HDIR

DosDelete       PROTO FAR PASCAL \
                pszFName:PSZ, ulReserverd:DWORD

DosDupHandle    PROTO FAR PASCAL \
                hfOld:HFILE, phfNew:PHFILE

DosQFHandState  PROTO FAR PASCAL \
                hf:HFILE, pfsOpenMode:PWORD

DosSetFHandState PROTO FAR PASCAL \
                hf:HFILE, fsState:WORD

DosQHandType    PROTO FAR PASCAL \
                hf:HFILE, pfsType:PWORD, pusDevAttr:PWORD

DosReadAsync    PROTO FAR PASCAL \
                hf:HFILE, hsemRam:PDWORD, pusErrCode:PWORD,
                pBuf:PVOID, cbBuf:WORD, pcbBytesRead:PWORD

DosWriteAsync   PROTO FAR PASCAL \
                hf:HFILE, hsemRam:PDWORD, pusErrCode:PWORD,
                pBuf:PVOID, cbBuf:WORD, pcbBytesWritten:PWORD

DosFindFirst    PROTO FAR PASCAL \
                pszFSpec:PSZ, phd:PHDIR, usAttr:WORD,
                pffb:PFILEFINDBUF, cbBuf:WORD, pcSearch:PWORD,
                ulReserved:DWORD

DosFindFirst2   PROTO FAR PASCAL \
                pszFSpec:PSZ, phd:PHDIR, usAttr:WORD, pBuf:PVOID,
                cbBuf:WORD, pcSearch:PWORD, usInfoLevel:WORD,
                ulReserved:DWORD

DosFindNext     PROTO FAR PASCAL \
                hd:HDIR, pffb:PFILEFINDBUF, cbBuf:WORD, pcSearch:PWORD

DosFindClose    PROTO FAR PASCAL \
                hd:HDIR

DosFSAttach     PROTO FAR PASCAL \
                pszDevName:PSZ, pszFSD:PSZ, pData:PBYTE, cbData:WORD,
                fsOp:WORD, ulReserved:DWORD

DosQFSAttach    PROTO FAR PASCAL \
                pszDev:PSZ, usOrdinal:WORD, usInfoLevel:WORD,
                pFSAttBuf:PBYTE, cbBuf:PWORD, ulReserved:DWORD

DosFSCtl        PROTO FAR PASCAL \
                pData:PBYTE, cbData:WORD, pcbData:PWORD, pParms:PBYTE,
                cbParms:WORD, pcbParms:PWORD, usFunCode:WORD,
                pszRoute:PSZ, hf:HFILE, usRouteMethod:WORD, ulReserved:DWORD

DosNewSize      PROTO FAR PASCAL \
                hf:HFILE, ulNewSize:DWORD

DosBufReset     PROTO FAR PASCAL \
                hf:HFILE

DosChgFilePtr   PROTO FAR PASCAL \
                hf:HFILE, lOffset:SDWORD, fsMethod:WORD, pulNewOffset:PDWORD

DosSetFilePtr   PROTO FAR PASCAL \
                hf:HFILE, lOffset:SDWORD, fsMethod:WORD, pulNewOffset:PDWORD

DosFileLocks    PROTO FAR PASCAL \
                hf:HFILE, pUnlock:PFILELOCK, pLock:PFILELOCK

DosMove         PROTO FAR PASCAL \
                pszOld:PSZ, pszNew:PSZ, ulReserved:DWORD

DosCopy         PROTO FAR PASCAL \
                pszSrc:PSZ, pszDst:PSZ, usOpt:WORD, ulReserved:DWORD

DosEditName     PROTO FAR PASCAL \
                usEditLevel:WORD, pszSrc:PSZ, pszEdit:PSZ, pszDst:PSZ,
                cbDst:WORD


DosFileIO       PROTO FAR PASCAL \
                hf:HFILE, pbCmd:PBYTE, cbCmd:WORD, pusErr:PWORD

DosMkDir        PROTO FAR PASCAL \
                pszDirName:PSZ, usReserved:DWORD

DosMkDir2       PROTO FAR PASCAL \
                pszDir:PSZ, pBuf:PEAOP, ulReserved:DWORD

DosRmDir        PROTO FAR PASCAL \
                pszDir:PSZ, ulReserved:DWORD

DosSelectDisk   PROTO FAR PASCAL \
                usDrvNum:WORD

DosQCurDisk     PROTO FAR PASCAL \
                pusDrvNum:PWORD, pulLogDrvMap:PDWORD

DosChDir        PROTO FAR PASCAL \
                pszDir:PSZ, ulReserved:DWORD

DosQCurDir      PROTO FAR PASCAL \
                usDrvNum:WORD, pszPathBuf:PSZ, pcbPathBuf:PWORD

DosQFSInfo      PROTO FAR PASCAL \
                usDrvNum:WORD, usInfoLevel:WORD, pbInfo:PBYTE, cbInfo:WORD

DosSetFSInfo    PROTO FAR PASCAL \
                usDrvNum:WORD, usInfoLevel:WORD, pBuf:FAR PTR BYTE, cbBuf:WORD

DosQVerify      PROTO FAR PASCAL \
                pfVerifyOn:FAR PTR WORD

DosSetVerify    PROTO FAR PASCAL \
                fVerify:WORD

DosSetMaxFH     PROTO FAR PASCAL \
                usHandles:WORD

DosQFileInfo    PROTO FAR PASCAL \
                hf:HFILE, usInfoLevel:WORD, pInfoBuf:PVOID, cbInfoBuf:WORD

DosSetFileInfo  PROTO FAR PASCAL \
                hf:HFILE, usInfoLevel:WORD, pInfoBuf:PBYTE, cbInfoBuf:WORD

DosQPathInfo    PROTO FAR PASCAL \
                pszPath:PSZ, usInfoLevel:WORD, pInfoBuf:PBYTE,
                cbInfoBuf:WORD, ulReserved:DWORD

DosSetPathInfo  PROTO FAR PASCAL \
                pszPath:PSZ, usInfoLevel:WORD, pInfoBuf:FAR PTR BYTE, cbInfoBuf:WORD, usFlags:WORD, ulReserved:DWORD


; defines for DosSetPathInfo -fsOptions flag

DSPI_WRTTHRU    EQU     0010h       ; write through
DosQFileMode    PROTO FAR PASCAL \
                pszFName:PSZ, pusAttr:PWORD, ulReserved:DWORD

DosSetFileMode  PROTO FAR PASCAL \
                pszFName:PSZ, usAttr:WORD, ulReserved:DWORD

; constants for DosEnumAttribute
ENUMEA_REFTYPE_FHANDLE  EQU     0
ENUMEA_REFTYPE_PATH     EQU     1
ENUMEA_LEVEL_NO_VALUE   EQU     1

DosEnumAttribute PROTO FAR PASCAL \
                usRefType:WORD, pvFile:PVOID, ulEntry:DWORD, pvBuf:PVOID,
                cbBuf:DWORD, pulCount:PDWORD, ulInfoLevel:DWORD,
                ulReserved:DWORD

; ENUMEA_LEVEL_NO_VALUE info returned from DosEnumAttribute
DENA1           STRUCT  2               ; dena
reserved_       BYTE    0               ; 0
cbName_         BYTE    0               ; length of name exculding NULL
cbValue_        WORD    0               ; length of value
szName_         BYTE    1 DUP (0)       ; variable length asciiz name
DENA1           ENDS
PDENA1          TYPEDEF FAR PTR DENA1

ENDIF ; common INCL_DOSFILEMGR

IF DEFINED( INCL_DOSMEMMGR ) OR NOT DEFINED( INCL_NOCOMMON )
; Memory management

DosAllocSeg     PROTO FAR PASCAL \
                cbSize:WORD, pselector:PSEL, fsAlloc:WORD

DosReallocSeg   PROTO FAR PASCAL \
                cbNewSize:WORD, selector:SEL

DosFreeSeg      PROTO FAR PASCAL \
                selector:SEL

DosGiveSeg      PROTO FAR PASCAL \
                selector:SEL, pidProcess:PID, pSelRecipient:PSEL

DosGetSeg       PROTO FAR PASCAL \
                selector:SEL

DosSizeSeg      PROTO FAR PASCAL \
                selector:SEL, pcbSize:PDWORD

; Segment attribute flags (used with DosAllocSeg)
SEG_NONSHARED   EQU     0000h
SEG_GIVEABLE    EQU     0001h
SEG_GETTABLE    EQU     0002h
SEG_DISCARDABLE EQU     0004h
SEG_SIZEABLE    EQU     0008h

ENDIF ; common INCL_DOSMEMMGR

IF DEFINED( INCL_DOSMEMMGR ) AND NOT DEFINED( INCL_DOSMEMMGR_INCLUDED )
INCL_DOSMEMMGR_INCLUDED EQU 1

DosAllocHuge    PROTO FAR PASCAL \
                cSegs:WORD, cbPartialSeg:WORD, pselector:PSEL,
                cMaxSegs:WORD, fsAlloc:WORD

DosReallocHuge  PROTO FAR PASCAL \
                cSegs:WORD, cbPartialSeg:WORD, selector:SEL

DosGetHugeShift PROTO FAR PASCAL \
                pusShiftCount:PWORD

DosAllocShrSeg  PROTO FAR PASCAL \
                cbSeg:WORD, pszSegName:PSZ, pselector:PSEL

DosLockSeg      PROTO FAR PASCAL \
                selector:SEL

DosUnlockSeg    PROTO FAR PASCAL \
                selector:SEL

DosGetShrSeg    PROTO FAR PASCAL \
                pszSegName:PSZ, pselector:PSEL

DosMemAvail     PROTO FAR PASCAL \
                pcbFree:PDWORD

DosCreateCSAlias PROTO FAR PASCAL \
                selDS:SEL, pselCS:PSEL

DosSubAlloc     PROTO FAR PASCAL \
                selector:SEL, pusOffset:PWORD, cb:WORD

DosSubFree      PROTO FAR PASCAL \
                selector:SEL, offBlock:WORD, cb:WORD

DosSubSet       PROTO FAR PASCAL \
                selector:SEL, fFlags:WORD, cbNew:WORD

ENDIF ; INCL_DOSMEMMGR

IF DEFINED( INCL_DOSSEMAPHORES ) OR NOT DEFINED( INCL_NOCOMMON )

; Semaphore support

SEM_INDEFINITE_WAIT     EQU     -1
SEM_IMMEDIATE_RETURN    EQU     0

DosSemClear     PROTO FAR PASCAL \
                hsm:HSEM

DosSemSet       PROTO FAR PASCAL \
                hsm:HSEM

DosSemWait      PROTO FAR PASCAL \
                hsm:HSEM, lTimeOut:SDWORD

DosSemSetWait   PROTO FAR PASCAL \
                hsm:HSEM, lTimeOut:SDWORD

DosSemRequest   PROTO FAR PASCAL \
                hsm:HSEM, lTimeOut:SDWORD

ENDIF ; common INCL_DOSSEMAPHORES

IF DEFINED( INCL_DOSSEMAPHORES ) AND NOT \
   DEFINED( INCL_DOSSEMAPHORES_INCLUDED )
INCL_DOSSEMAPHORES_INCLUDED EQU 1

HSYSSEM         TYPEDEF FAR PTR ; hssm
PHSYSSEM        TYPEDEF FAR PTR HSYSSEM

DosCreateSem    PROTO FAR PASCAL \
                fExclusive:WORD, phsem:PHSYSSEM, pszSemName:PSZ

CSEM_PRIVATE    EQU     0
CSEM_PUBLIC     EQU     1

DosOpenSem      PROTO FAR PASCAL \
                phsm:PHSEM, pszSemName:PSZ

DosCloseSem     PROTO FAR PASCAL \
                hsm:HSEM

MUXSEM          STRUCT  2 ; mxs
zero_           WORD    0
hsem_           HSEM    0
MUXSEM          ENDS
PMUXSEM         TYPEDEF FAR PTR MUXSEM

MUXSEMLIST      STRUCT  2 ; mxsl
cmxs_           WORD    0
amxs_           MUXSEM  16 DUP (<>)
MUXSEMLIST      ENDS
PMUXSEMLIST     TYPEDEF FAR PTR MUXSEMLIST

; Since a MUXSEMLIST structure is actually a variable length
; structure, the following macro may be used to define a MUXSEMLIST
; structure having size elements, named "name".



DEFINEMUXSEMLIST MACRO name_:REQ, size_:REQ ;???
name_   STRUCT  2
cmxs    WORD    0
amxs    MUXSEM  size_ DUP (<>)
name_   ENDS
ENDM

; This function actually takes a far pointer to a MUXSEMLIST structure
; as its second parameter, but in order to allow its use with the
; DEFINEMUXSEMLIST macro, it is declared here as PVOID.
;
DosMuxSemWait   PROTO FAR PASCAL \
                pisemCleared:PWORD, pmsxl:PVOID, lTimeOut:SDWORD

; Fast safe ram semaphores
DOSFSRSEM       STRUCT  2 ; dosfsrs
cb_             WORD    0
pid_            PID     0
tid_            TID     0
cUsage_         WORD    0
client_         WORD    0
sem_            DWORD   0
DOSFSRSEM       ENDS
PDOSFSRSEM      TYPEDEF FAR PTR DOSFSRSEM

DosFSRamSemRequest PROTO FAR PASCAL \
                pdosfsrs:PDOSFSRSEM, lTimeOut:SDWORD

DosFSRamSemClear PROTO FAR PASCAL \
                pdosfsrs:PDOSFSRSEM

ENDIF ; INCL_DOSSEMAPHORES

IF DEFINED( INCL_DOSDATETIME ) OR NOT \
   DEFINED( INCL_NOCOMMON ) AND NOT \
   DEFINED( INCL_DOSDATETIME_INCLUDED )

; Time support
DATETIME        STRUCT  2 ; date
hours_          BYTE    0
minutes_        BYTE    0
seconds_        BYTE    0
hundredths_     BYTE    0
day_            BYTE    0
month_          BYTE    0
year_           WORD    0
timezone_       SWORD   0
weekday_        BYTE    0
DATETIME        ENDS
PDATETIME       TYPEDEF FAR PTR DATETIME

DosGetDateTime  PROTO FAR PASCAL \
                pdatetime:PDATETIME

DosSetDateTime  PROTO FAR PASCAL \
                pdatetime:PDATETIME

ENDIF ; common INCL_DOSDATETIME

IF DEFINED( INCL_DOSDATETIME ) AND NOT DEFINED( INCL_DOSDATETIME_INCLUDED )
INCL_DOSDATETIME_INCLUDED EQU 1

HTIMER          TYPEDEF         WORD
PHTIMER         TYPEDEF         FAR PTR HTIMER

DosTimerAsync   PROTO FAR PASCAL \
                ulTime:DWORD, hsm:HSEM, phtime:PHTIMER

DosTimerStart   PROTO FAR PASCAL \
                ulTime:DWORD, hsm:HSEM, phtime:PHTIMER

DosTimerStop    PROTO FAR PASCAL \
                htimer:HTIMER

ENDIF ; INCL_DOSDATETIME

; Module manager

IF DEFINED( INCL_DOSMODULEMGR ) AND NOT DEFINED( INCL_DOSMODULEMGR_INCLUDED )

INCL_DOSMODULEMGR_INCLUDED EQU 1

DosLoadModule   PROTO FAR PASCAL \
                pszFailName:PSZ, cbFileName:WORD, pszModName:PSZ,
                phmod:PHMODULE

DosFreeModule   PROTO FAR PASCAL \
                hmod:HMODULE

DosGetProcAddr  PROTO FAR PASCAL \
                hmod:HMODULE, pszProcName:PSZ, ppfnProcAddr:PPFN

DosGetModHandle PROTO FAR PASCAL \
                pszModName:PSZ, phMod:PHMODULE

DosGetModName   PROTO FAR PASCAL \
                hmod:HMODULE, cbBuf:WORD, pchBuf:PCHAR

ENDIF ; INCL_DOSMODULEMGR

IF DEFINED( INCL_DOSRESOURCES ) AND NOT DEFINED( INCL_NOCOMMON )

; Resource support
; Predefined resource types

RT_POINTER      EQU     1       ; mouse pointer shape
RT_BITMAP       EQU     2       ; bitmap
RT_MENU         EQU     3       ; menu template
RT_DIALOG       EQU     4       ; dialog template
RT_STRING       EQU     5       ; string tables
RT_FONTDIR      EQU     6       ; font directory
RT_FONT         EQU     7       ; font
RT_ACCELTABLE   EQU     8       ; accelerator tables
RT_RCDATA       EQU     9       ; binary data
RT_MESSAGE      EQU     10      ; error mesage tables
RT_DLGINCLUDE   EQU     11      ; dialog include file name
RT_VKEYTBL      EQU     12      ; key to vkey tables
RT_KEYTBL       EQU     13      ; key to UGL tables
RT_CHARTBL      EQU     14
RT_DISPLAYINFO  EQU     15      ; screen display information
RT_FKASHORT     EQU     16      ; function key area short form
RT_FKALONG      EQU     17      ; function key area long form
RT_HELPTABLE    EQU     18
RT_HELPSUBTABLE EQU     19
RT_FDDIR        EQU     20
RT_FD           EQU     21
RT_MAX          EQU     22      ; 1st unused Resource Type

ENDIF ; common INCL_DOSRESOURCES

IF DEFINED( INCL_DOSRESOURCES ) AND NOT DEFINED( INCL_DOSRESOURCES_INCLUDED )
INCL_DOSRESOURCES_INCLUDED EQU 1

DosGetResource  PROTO FAR PASCAL \
                hmod:HMODULE, idType:WORD, idName:WORD, pselector:PSEL

DosGetResource2 PROTO FAR PASCAL \
                hmod:HMODULE, idType:WORD, idName:WORD, ppData:FAR PTR PVOID

DosFreeResource PROTO FAR PASCAL \
                pData:PVOID

ENDIF ; INCL_DOSRESOURCES


; NLS Support

IF DEFINED( INCL_DOSNLS ) AND NOT DEFINED( INCL_DOSNLS_INCLUDED )
INCL_DOSNLS_INCLUDED EQU 1

COUNTRYCODE     STRUCT  2 ; ctryc
country_        WORD    0
codepage_       WORD    0
COUNTRYCODE     ENDS
PCOUNTRYCODE    TYPEDEF FAR PTR COUNTRYCODE

; fsDateFmt

DATEFMT_MM_DD_YY        EQU     0000h
DATEFMT_DD_MM_YY        EQU     0001h
DATEFMT_YY_MM_DD        EQU     0002h

; fsCurrencyFmt
CURRENCY_FOLLOW         EQU     0001h
CURRENCY_SPACE          EQU     0002h
CURRENCY_DECIMAL        EQU     0004h

COUNTRYINFO             STRUCT  2 ; ctryi
country_                WORD    0
codepage_               WORD    0
fsDateFmt_              WORD    0
szCurrency_             SBYTE   5 DUP (0)
szThousandsSeparator_   SBYTE   2 DUP (0)
szDecimal_              SBYTE   2 DUP (0)
szDateSeparator_        SBYTE   2 DUP (0)
szTimeSeparator_        SBYTE   2 DUP (0)
fsCurrencyFmt_          BYTE    0
cDecimalPlace_          BYTE    0
fsTimeFmt_              BYTE    0
abReserved1_            WORD    2 DUP (0)
szDataSeparator_        SBYTE   2 DUP (0)
abReserved2_            WORD    5 DUP (0)
COUNTRYINFO             ENDS
PCOUNTRYINFO    TYPEDEF FAR PTR COUNTRYINFO

DosGetCtryInfo  PROTO FAR PASCAL \
                cbBuf:WORD, pctryc:PCOUNTRYCODE, pctryi:PCOUNTRYINFO,
                pcbCtryInfo:PWORD

DosGetDBCSEv    PROTO FAR PASCAL \
                cbBuf:WORD, pctryc:PCOUNTRYCODE, pchBuf:PCHAR

DosCaseMap      PROTO FAR PASCAL \
                usLen:WORD, pctryc:PCOUNTRYCODE, pchStr:PCHAR

DosGetCollate   PROTO FAR PASCAL \
                cbBuf:WORD, pctryc:PCOUNTRYCODE, pchBuf:PCHAR, pcbTable:PWORD

DosGetCp        PROTO FAR PASCAL \
                cbBuf:WORD, pBuf:PWORD, pcbCodePgLst:PWORD

DosSetCp        PROTO FAR PASCAL \
                usCodePage:WORD, usReserved:WORD

DosSetProcCp    PROTO FAR PASCAL \
                usCodePage:WORD, usReserved:WORD

ENDIF ; INCL_DOSNLS


; Signal support

IF DEFINED( INCL_DOSSIGNALS ) AND NOT DEFINED( INCL_DOSSIGNALS_INCLUDED )
INCL_DOSSIGNALS_INCLUDED EQU 1

; Signal Numbers for DosSetSigHandler
SIG_CTRLC               EQU     1       ; Control C
;                               2       ; Undefined
SIG_KILLPROCESS         EQU     3       ; Program Termination
SIG_CTRLBREAK           EQU     4       ; Control Break
SIG_PFLG_A              EQU     5       ; Process Flag A
SIG_PFLG_B              EQU     6       ; Process Flag B
SIG_PFLG_C              EQU     7       ; Process Flag C
SIG_CSIGNALS            EQU     8       ; number of signals plus one

; Flag Numbers for DosFlagProcess
PFLG_A                  EQU     0       ; Process Flag A
PFLG_B                  EQU     1       ; Process Flag B
PFLG_C                  EQU     2       ; Process Flag C

; Signal actions
SIGA_KILL               EQU     0
SIGA_IGNORE             EQU     1
SIGA_ACCEPT             EQU     2
SIGA_ERROR              EQU     3
SIGA_ACKNOWLEDGE        EQU     4

; DosHoldSignal constants
HLDSIG_ENABLE           EQU     0
HLDSIG_DISABLE          EQU     1

; DosFlagProcess codes
FLGP_SUBTREE            EQU     0
FLGP_PID                EQU     1

PFSIGHANDLER    TYPEDEF PROTO FAR PASCAL :WORD, :WORD
PFNSIGHANDLER   TYPEDEF PTR PFSIGHANDLER

DosSetSigHandler PROTO FAR PASCAL \
                pfnHandler:PFNSIGHANDLER, ppfnPrev:FAR PTR PFNSIGHANDLER,
                pfAction:PWORD, fAction:WORD, usSigNum:WORD

DosFlagProcess  PROTO FAR PASCAL \
                pidProcess:PID, fScope:WORD, usFlagNum:WORD, usFlagArg:WORD

DosHoldSignal   PROTO FAR PASCAL \
                fDisable:WORD

DosSendSignal   PROTO FAR PASCAL \
                idProcess:WORD, usSigNumber:WORD

ENDIF ; INCL_DOSSIGNALS


; Monitor support

IF DEFINED( INCL_DOSMONITORS ) AND NOT DEFINED( INCL_DOSMONITORS_INCLUDED )
INCL_DOSMONITORS_INCLUDED EQU 1

MONITOR_DEFAULT EQU     0000h
MONITOR_BEGIN   EQU     0001h
MONITOR_END     EQU     0002h

HMONITOR        TYPEDEF WORD    ; hmon
PHMONITOR       TYPEDEF FAR PTR HMONITOR

MONIN           STRUCT  2 ; mnin
cb_             WORD    0
abReserved_     BYTE    18 DUP (0)
abBuffer_       BYTE    108 DUP (0)
MONIN           ENDS
PMONIN          TYPEDEF FAR PTR MONIN

MONOUT          STRUCT  2 ; mnout
cb_             WORD    0
abReserved_     BYTE    18 DUP (0)
abBuffer_       BYTE    108 DUP (0)
MONOUT          ENDS
PMONOUT         TYPEDEF FAR PTR MONOUT

DosMonOpen      PROTO FAR PASCAL \
                pszDevName:PSZ, phmon:PHMONITOR

DosMonClose     PROTO FAR PASCAL \
                hmon:HMONITOR

DosMonReg       PROTO FAR PASCAL \
                hmon:HMONITOR, pbInBuf:PBYTE, pbOutBuf:PBYTE,
                fPosition:WORD, usIndex:WORD

DosMonRead      PROTO FAR PASCAL \
                pbInBuf:PBYTE, fWaitFor:WORD, pbDataBuf:PBYTE, pcbData:PWORD

DosMonWrite     PROTO FAR PASCAL \
                pbOutBuf:PBYTE, pbDataBuf:PBYTE, cbData:WORD

ENDIF ; INCL_DOSMONITORS

; Pipe and queue support

if DEFINED( INCL_DOSQUEUES ) AND NOT DEFINED( INCL_DOSQUEUES_INCLUDED )
INCL_DOSQUEUES_INCLUDED EQU 1

; DosCreateQueue priority

QUE_FIFO        EQU     0000h
QUE_LIFO        EQU     0001h
QUE_PRIORITY    EQU     0002h

HQUEUE          TYPEDEF WORD    ; hq
PHQUEUE         TYPEDEF FAR PTR HQUEUE

QUEUERESULT     STRUCT  2 ; qresc
pidProcess_     WORD    0
usEventCode_    WORD    0
QUEUERESULT     ENDS
PQUEUERESULT    TYPEDEF FAR PTR QUEUERESULT

DosMakePipe     PROTO FAR PASCAL \
                phfRead:PHFILE, phfWrite:PHFILE, cb:WORD

DosCloseQueue   PROTO FAR PASCAL \
                hq:HQUEUE

DosCreateQueue  PROTO FAR PASCAL \
                phq:PHQUEUE, fQueueOrder:WORD, pszQueueName:PSZ

DosOpenQueue    PROTO FAR PASCAL \
                ppidOwner:FAR PTR WORD, phq:PHQUEUE, pszQueueName:PSZ


DosPeekQueue    PROTO FAR PASCAL \
                hq:HQUEUE, pqresc:PQUEUERESULT, pcbElement:PWORD,
                ppBuf:PVOID, pElemCode:PWORD, fWaitFor:BYTE,
                pbElemPrty:PBYTE, hsem:DWORD

DosPurgeQueue   PROTO FAR PASCAL \
                hq:HQUEUE

DosQueryQueue   PROTO FAR PASCAL \
                hq:HQUEUE, pcElem:PWORD

DosReadQueue    PROTO FAR PASCAL \
                hq:HQUEUE, pqresc:PQUEUERESULT, pcbElem:PWORD,
                ppv:FAR PTR PVOID, usElem:WORD, fWaitFor:BYTE,
                pbElemPrty:PBYTE, hsm:HSEM

DosWriteQueue   PROTO FAR PASCAL \
                hq:HQUEUE, usRequest:WORD, cbBuf:WORD,
                pBuf:PBYTE, fPriority:BYTE

ENDIF ; INCL_DOSQUEUES

IF DEFINED( INCL_DOSMISC ) AND NOT DEFINED( INCL_DOSMISC_INCLUDED )
INCL_DOSMISC_INCLUDED EQU 1

; DosQSysInfo index

Q_MAX_PATH_LENGTH       EQU     0       ; index for query max path length

; DosError error-handling types
HARDERROR_ENABLE        EQU     0001h
HARDERROR_DISABLE       EQU     0000h
EXCEPTION_ENABLE        EQU     0000h
EXCEPTION_DISABLE       EQU     0002h

; DosSetVec vectors
VECTOR_DIVIDE_BY_ZERO   EQU     0000h
VECTOR_OVERFLOW         EQU     0004h
VECTOR_OUTOFBOUNDS      EQU     0005h
VECTOR_INVALIDOPCODE    EQU     0006h
VECTOR_NO_EXTENSION     EQU     0007h
VECTOR_EXTENSION_ERROR  EQU     0010h

; DosGetMachineMode machine modes
MODE_REAL               EQU     0000h
MODE_PROTECTED          EQU     0001h

DosError        PROTO FAR PASCAL \
                fEnable:WORD

DosSetVec       PROTO FAR PASCAL \
                usVecNum:WORD, pfnFun:PFN, ppfnPrev:PPFN

DosGetMessage   PROTO FAR PASCAL \
                ppchVTable:FAR PTR PCHAR, usVCount:WORD, pchBuf:PCHAR,
                cbBuf:WORD, usMsgNum:WORD, pszFileName:PSZ, pcbMsg:PWORD

DosErrClass     PROTO FAR PASCAL \
                usErrCode:WORD, pusClass:PWORD, pfsAction:PWORD,
                pusLocus:PWORD

DosInsMessage   PROTO FAR PASCAL \
                ppchVTable:FAR PTR PCHAR, usVCount:WORD, pszMsg:PSZ,
                cbMsg:WORD, pchBuf:PCHAR, cbBuf:WORD, pcbMsg:PWORD

DosPutMessage   PROTO FAR PASCAL \
                hf:HFILE, cbMsg:WORD, pchMsg:PCHAR

DosQSysInfo     PROTO FAR PASCAL \
                index:WORD, pBuf:PBYTE, cbBuf:WORD

DosGetEnv       PROTO FAR PASCAL \
                pselEnv:PWORD, pOffsetCmd:PWORD

DosScanEnv      PROTO FAR PASCAL \
                pszVarName:PSZ, ppszResult:FAR PTR PSZ

DosGetVersion   PROTO FAR PASCAL \
                pVer:PWORD

DosGetMachineMode PROTO FAR PASCAL \
                pMachMode:PBYTE

ENDIF ; INCL_DOSMISC

; Session manager support

IF DEFINED( INCL_DOSSESMGR ) AND NOT DEFINED( INCL_DOSSESMGR_INCLUDED )
INCL_DOSSESMGR_INCLUDED EQU 1

; DosQAppType application types

NOTSPECIFIED    EQU     0000h
NOTWINDOCOMPAT  EQU     0001h
WINDOWCOMPAT    EQU     0002h
WINDOWAPI       EQU     0003h
BOUNDTYPE       EQU     0004h   ; Called BOUND in OS/2 documentation
DYNAMICLINK     EQU     0008h
DOSFORMAT       EQU     0010h

STARTDATA       STRUCT  2 ; stdata
Length_         WORD    0
Related_        WORD    0
FgBg_           WORD    0
TraceOpt_       WORD    0
PgmTitle_       PSZ     0
PgmName_        PSZ     0
PgmInputs_      PBYTE   0
TermQ_          PBYTE   0
Environment_    PBYTE   0
InheritOpt_     WORD    0
SessionType_    WORD    0
IconFile_       PSZ     0
PgmHandle_      DWORD   0
PgmControl_     WORD    0
InitXPos_       WORD    0
InitYPos_       WORD    0
InitXSize_      WORD    0
InitYSize_      WORD    0
STARTDATA       ENDS
PSTARTDATA      TYPEDEF FAR PTR STARTDATA

; STATUSDATA.SelectInd constants

TARGET_UNCHANGED        EQU     0000h
TARGET_SELECTABLE       EQU     0001h
TARGET_NOT_SELECTABLE   EQU     0002h

; STATUSDATA.BondInd constants
BOND_UNCHANGED          EQU     0000h
BOND_CHILD              EQU     0001h
BOND_NONE               EQU     0002h

STATUSDATA      STRUCT  2 ; stsdata
Length_         WORD    0
SelectInd_      WORD    0
BondInd_        WORD    0
STATUSDATA      ENDS
PSTATUSDATA     TYPEDEF FAR PTR STATUSDATA

DosStartSession PROTO FAR PASCAL \
                pstdata:PSTARTDATA, pidSession:PWORD, ppid:PWORD

DosSetSession   PROTO FAR PASCAL \
                idSession:WORD, pstsdata:PSTATUSDATA

DosSelectSession PROTO FAR PASCAL \
                idSession:WORD, ulReserved:DWORD

DosStopSession  PROTO FAR PASCAL \
                fScope:WORD, idSession:WORD, ulReserved:DWORD

DosQAppType     PROTO FAR PASCAL \
                pszPrgName:PSZ, pusType:PWORD

ENDIF ; INCL_DOSSESMGR

; Device support

IF DEFINED( INCL_DOSDEVICES ) AND NOT DEFINED( INCL_DOSDEVICES_INCLUDED )
INCL_DOSDEVICES_INCLUDED EQU 1

; DosPhysicalDisk physical disk information

INFO_COUNT_PARTITIONABLE_DISKS  EQU     0001h
INFO_GETIOCTLHANDLE             EQU     0002h
INFO_FREEIOCTLHANDLE            EQU     0003h

; DosDevConfig information requests

DEVINFO_PRINTER                 EQU     0000h
DEVINFO_RS232                   EQU     0001h
DEVINFO_FLOPPY                  EQU     0002h
DEVINFO_COPROCESSOR             EQU     0003h
DEVINFO_SUBMODEL                EQU     0004h
DEVINFO_MODEL                   EQU     0005h
DEVINFO_ADAPTER                 EQU     0006h

DosDevConfig    PROTO FAR PASCAL \
                pDevInfo:PVOID, usItem:WORD, usReserved:WORD

DosDevIOCtl     PROTO FAR PASCAL \
                pData:PVOID, pParms:PVOID, usFun:WORD,
                usCategory:WORD, hDev:HFILE

DosDevIOCtl2    PROTO FAR PASCAL \
                pData:PVOID, cbData:WORD, pParm:PVOID, cbParm:WORD,
                usFun:WORD, usCategory:WORD, hDev:HFILE

DosCLIAccess    PROTO FAR PASCAL

DosPortAccess   PROTO FAR PASCAL \
                usReserved:WORD, fRelease:WORD, usFirstPort:WORD,
                usLastPort:WORD

DosPhysicalDisk PROTO FAR PASCAL \
                usFun:WORD, pOut:PBYTE, cbOut:WORD, pParm:PBYTE, cbParm:WORD

DosR2StackRealloc PROTO FAR PASCAL \
                cbStack:WORD

DosCallback     PROTO FAR PASCAL \
                pfunc:PFN

ENDIF ; INCL_DOSDEVICES

; DosNamedPipes API Support

IF DEFINED( INCL_DOSNMPIPES ) AND NOT DEFINED( INCL_DOSNMPIPES_INCLUDED )
INCL_DOSNMPIPES_INCLUDED EQU 1

HPIPE           TYPEDEF WORD    ; hp
PHPIPE          TYPEDEF FAR PTR WORD

; Data structures and equates used with named pipes

PIPEINFO        STRUCT  2 ; nmpinf
cbOut_          WORD    0
cbIn_           WORD    0
cbMaxInst_      BYTE    0
cbCurInst_      BYTE    0
cbName_         BYTE    0
szName_         SBYTE   1 DUP (0)
PIPEINFO        ENDS
PPIPEINFO       TYPEDEF FAR PTR PIPEINFO


PIPESEMSTATE    STRUCT  2 ; nmpsmst
fStatus_        BYTE    0
fFlag_          BYTE    0
usKey_          WORD    0
usAvail_        WORD    0
PIPESEMSTATE    ENDS
PPIPESEMSTATE   TYPEDEF FAR PTR PIPESEMSTATE

; values in npss_status
NPSS_EOI        EQU     0       ; End Of Information
NPSS_RDATA      EQU     1       ; read data available
NPSS_WSPACE     EQU     2       ; write space available
NPSS_CLOSE      EQU     3       ; pipe in CLOSING state

; values in npss_flag
NPSS_WAIT       EQU     0001h   ; waiting thread on end of pipe

; defined bits in pipe mode
NP_NBLK         EQU     8000h   ; non-blocking read/write
NP_SERVER       EQU     4000h   ; set if server end
NP_WMESG        EQU     0400h   ; write messages
NP_RMESG        EQU     0100h   ; read as messages
NP_ICOUNT       EQU     00ffh   ; instance count field

; Named pipes may be in one of several states depending on the actions
; that have been taken on it by the server end and client end.  The
; following state/action table summarizes the valid state transitions:
;
; Current state           Action                  Next state
;
;  <none>             server DosMakeNmPipe        DISCONNECTED
;  DISCONNECTED       server connect              LISTENING
;  LISTENING          client open                 CONNECTED
;  CONNECTED          server disconn              DISCONNECTED
;  CONNECTED          client close                CLOSING
;  CLOSING            server disconn              DISCONNECTED
;  CONNECTED          server close                CLOSING
;  <any other>        server close                <pipe deallocated>
;
; If a server disconnects his end of the pipe, the client end will enter a
; special state in which any future operations (except close) on the file
; descriptor associated with the pipe will return an error.

; Values for named pipe state
NP_DISCONNECTED         EQU     1       ; after pipe creation or Disconnect
NP_LISTENING            EQU     2       ; after DosNmPipeConnect
NP_CONNECTED            EQU     3       ; after Client open
NP_CLOSING              EQU     4       ; after Client or Server close

; DosMakeNmPipe open modes
NP_ACCESS_INBOUND       EQU     0000h
NP_ACCESS_OUTBOUND      EQU     0001h
NP_ACCESS_DUPLEX        EQU     0002h
NP_INHERIT              EQU     0000h
NP_NOINHERIT            EQU     0080h
NP_WRITEBEHIND          EQU     0000h
NP_NOWRITEBEHIND        EQU     4000h

; DosMakeNmPipe and DosQNmPHandState state
NP_READMODE_BYTE        EQU     0000h
NP_READMODE_MESSAGE     EQU     0100h
NP_TYPE_BYTE            EQU     0000h
NP_TYPE_MESSAGE         EQU     0400h
NP_END_CLIENT           EQU     0000h
NP_END_SERVER           EQU     4000h
NP_WAIT                 EQU     0000h
NP_NOWAIT               EQU     8000h
NP_UNLIMITED_INSTANCES  EQU     00ffh

AVAILDATA       STRUCT  2       ; PeekNMPipe Bytes Available record
cbpipe_         WORD    0       ; bytes left in the pipe
cbmessage_      WORD    0       ; bytes left in current message
AVAILDATA       ENDS
PAVAILDATA      TYPEDEF FAR PTR AVAILDATA

DosCallNmPipe   PROTO FAR PASCAL \
                pszName:PSZ, pInBuf:PBYTE, cbInBuf:WORD, pbOutBuf:PBYTE,
                cbOutBuf:WORD, pcbRead:PWORD, ulTimeOut:DWORD

DosConnectNmPipe PROTO FAR PASCAL \
                hp:HPIPE

DosDisConnectNmPipe     PROTO FAR PASCAL \
                hp:HPIPE

DosMakeNmPipe   PROTO FAR PASCAL \
                pszName:PSZ, php:PHPIPE, fsOpenMode:WORD, fsPipeMode:WORD,
                cbOutBuf:WORD, cbInBuf:WORD, ulTimeOut:DWORD

DosPeekNmPipe   PROTO FAR PASCAL \
                hp:HPIPE, pBuf:PBYTE, cbBuf:WORD, pcbRead:PWORD,
                pAvail:PAVAILDATA, pfsState:PWORD

DosQNmPHandState PROTO FAR PASCAL \
                hp:HPIPE, pfsState:PWORD

DosQNmPipeInfo  PROTO FAR PASCAL \
                hp:HPIPE, usInfoLevel:WORD, pBuf:PBYTE, cb:WORD

DosQNmPipeSemState PROTO FAR PASCAL \
                hsm:HSEM, pnmpsmst:PPIPESEMSTATE, cb:WORD

DosSetNmPHandState PROTO FAR PASCAL \
                hp:HPIPE, fsState:WORD

DosSetNmPipeSem PROTO FAR PASCAL \
                hp:HPIPE, hsm:HSEM, usKeyVal:WORD

DosTransactNmPipe PROTO FAR PASCAL \
                hp:HPIPE, pbOutBuf:PBYTE, cbOut:WORD, pInBuf:PBYTE,
                cbIn:WORD, pcbRead:PWORD

DosWaitNmPipe   PROTO FAR PASCAL \
                pszName:PSZ, ulTimeOut:DWORD

ENDIF ; INCL_DOSNMPIPES

; Trace support

IF DEFINED( INCL_DOSTRACE ) AND NOT DEFINED( INCL_DOSTRACE_INCLUDED )
INCL_DOSTRACE_INCLUDED EQU 1

PTRACEBUF       STRUCT  2 ; ptrcbf
pid_            PID     0
tid_            TID     0
cmd_            WORD    0
value_          WORD    0
offv_           WORD    0
segv_           WORD    0
mte_            WORD    0
rAX_            WORD    0
rBX_            WORD    0
rCX_            WORD    0
rDX_            WORD    0
rSI_            WORD    0
rDI_            WORD    0
rBP_            WORD    0
rDS_            WORD    0
rES_            WORD    0
rIP_            WORD    0
rCS_            WORD    0
rF_             WORD    0
rSP_            WORD    0
rSS_            WORD    0
PTRACEBUF       ENDS
PPTRACEBUF      TYPEDEF FAR PTR PTRACEBUF


DosPTrace       PROTO FAR PASCAL \
                pPtraceBuf:FAR PTR BYTE

ENDIF ; INCL_DOSTRACE
