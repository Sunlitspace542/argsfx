;
; Module Name: BSEERR.INC
;
; This file includes the error codes for Base OS/2 applications.
;
; Copyright (c) 1987-1990, Microsoft Corporation.  All rights reserved.
;
; ===========================================================================
;
; The following symbols are used in this file for conditional sections.
;
;   INCL_DOSERRORS -  OS/2 Errors     - only included if symbol defined
;

IFDEF  INCL_ERRORS
DEFINE INCL_DOSERRORS
ENDIF

IFDEF  INCL_DOSERRORS

BSEERR_INCLUDED EQU     1

; ** Error codes

NO_ERROR                        EQU     0

ERROR_INVALID_FUNCTION          EQU     1
ERROR_FILE_NOT_FOUND            EQU     2
ERROR_PATH_NOT_FOUND            EQU     3
ERROR_TOO_MANY_OPEN_FILES       EQU     4
ERROR_ACCESS_DENIED             EQU     5
ERROR_INVALID_HANDLE            EQU     6
ERROR_ARENA_TRASHED             EQU     7
ERROR_NOT_ENOUGH_MEMORY         EQU     8
ERROR_INVALID_BLOCK             EQU     9
ERROR_BAD_ENVIRONMENT           EQU     10
ERROR_BAD_FORMAT                EQU     11
ERROR_INVALID_ACCESS            EQU     12
ERROR_INVALID_DATA              EQU     13
;  14 is reserved
ERROR_INVALID_DRIVE             EQU     15
ERROR_CURRENT_DIRECTORY         EQU     16
ERROR_NOT_SAME_DEVICE           EQU     17
ERROR_NO_MORE_FILES             EQU     18
ERROR_WRITE_PROTECT             EQU     19
ERROR_BAD_UNIT                  EQU     20
ERROR_NOT_READY                 EQU     21
ERROR_BAD_COMMAND               EQU     22
ERROR_CRC                       EQU     23
ERROR_BAD_LENGTH                EQU     24
ERROR_SEEK                      EQU     25
ERROR_NOT_DOS_DISK              EQU     26
ERROR_SECTOR_NOT_FOUND          EQU     27
ERROR_OUT_OF_PAPER              EQU     28
ERROR_WRITE_FAULT               EQU     29
ERROR_READ_FAULT                EQU     30
ERROR_GEN_FAILURE               EQU     31
ERROR_SHARING_VIOLATION         EQU     32
ERROR_LOCK_VIOLATION            EQU     33
ERROR_WRONG_DISK                EQU     34
ERROR_FCB_UNAVAILABLE           EQU     35
ERROR_SHARING_BUFFER_EXCEEDED   EQU     36
ERROR_NOT_SUPPORTED             EQU     50
ERROR_REM_NOT_LIST              EQU     51 ; Remote computer not listening
ERROR_DUP_NAME                  EQU     52 ; Duplicate name on network
ERROR_BAD_NETPATH               EQU     53 ; Network path not found
ERROR_NETWORK_BUSY              EQU     54 ; Network busy
ERROR_DEV_NOT_EXIST             EQU     55 ; Network device no longer exists
ERROR_TOO_MANY_CMDS             EQU     56 ; Net BIOS command limit exceeded
ERROR_ADAP_HDW_ERR              EQU     57 ; Network adapter hardware error
ERROR_BAD_NET_RESP              EQU     58 ; Incorrect response from network
ERROR_UNEXP_NET_ERR             EQU     59 ; Unexpected network error
ERROR_BAD_REM_ADAP              EQU     60 ; Incompatible remote adapter
ERROR_PRINTQ_FULL               EQU     61 ; Print queue full
ERROR_NO_SPOOL_SPACE            EQU     62 ; Not enough space for print file
ERROR_PRINT_CANCELLED           EQU     63 ; Print file was cancelled
ERROR_NETNAME_DELETED           EQU     64 ; Network name was deleted
ERROR_NETWORK_ACCESS_DENIED     EQU     65 ; Access denied
ERROR_BAD_DEV_TYPE              EQU     66 ; Network device type incorrect
ERROR_BAD_NET_NAME              EQU     67 ; Network name not found
ERROR_TOO_MANY_NAMES            EQU     68 ; Network name limit exceeded
ERROR_TOO_MANY_SESS             EQU     69 ; Net BIOS session limit exceeded
ERROR_SHARING_PAUSED            EQU     70 ; Sharing temporarily paused
ERROR_REQ_NOT_ACCEP             EQU     71 ; Network request not accepted
ERROR_REDIR_PAUSED              EQU     72 ; Print|disk redirection is paused
ERROR_FILE_EXISTS               EQU     80
ERROR_DUP_FCB                   EQU     81
ERROR_CANNOT_MAKE               EQU     82
ERROR_FAIL_I24                  EQU     83
ERROR_OUT_OF_STRUCTURES         EQU     84
ERROR_ALREADY_ASSIGNED          EQU     85
ERROR_INVALID_PASSWORD          EQU     86
ERROR_INVALID_PARAMETER         EQU     87
ERROR_NET_WRITE_FAULT           EQU     88
ERROR_NO_PROC_SLOTS             EQU     89 ; no process slots available
ERROR_NOT_FROZEN                EQU     90
ERR_TSTOVFL                     EQU     91 ; timer service table overflow
ERR_TSTDUP                      EQU     92 ; timer service table duplicate
ERROR_NO_ITEMS                  EQU     93 ; no items to operate upon
ERROR_INTERRUPT                 EQU     95 ; interrupted system call
ERROR_DEVICE_IN_USE             EQU     99 ; Device in use by another thread
ERROR_TOO_MANY_SEMAPHORES       EQU     100
ERROR_EXCL_SEM_ALREADY_OWNED    EQU     101
ERROR_SEM_IS_SET                EQU     102
ERROR_TOO_MANY_SEM_REQUESTS     EQU     103
ERROR_INVALID_AT_INTERRUPT_TIME EQU     104
ERROR_SEM_OWNER_DIED            EQU     105 ; waitsem found owner died
ERROR_SEM_USER_LIMIT            EQU     106 ; too many procs have this sem
ERROR_DISK_CHANGE               EQU     107
ERROR_DRIVE_LOCKED              EQU     108 ; drive locked by another process
ERROR_BROKEN_PIPE               EQU     109 ; write on pipe with no reader
ERROR_OPEN_FAILED               EQU     110 ; open/created failed due to
                                            ; explicit fail command
ERROR_BUFFER_OVERFLOW           EQU     111 ; buffer passed to system call
                                            ;  is too small to hold return
                                            ;  data.
ERROR_DISK_FULL                 EQU     112 ; not enough space on the disk
                                            ;  (DOSNEWSIZE/w_NewSize)
ERROR_NO_MORE_SEARCH_HANDLES    EQU     113 ; can't allocate another search
                                            ;  structure and handle.
                                            ;  (DOSFINDFIRST/w_FindFirst)
ERROR_INVALID_TARGET_HANDLE     EQU     114 ; Target handle in DOSDUPHANDLE
                                            ;  is invalid
ERROR_PROTECTION_VIOLATION      EQU     115 ; Bad user virtual address
ERROR_VIOKBD_REQUEST            EQU     116
ERROR_INVALID_CATEGORY          EQU     117 ; Category for DEVIOCTL in not
                                            ;  defined
ERROR_INVALID_VERIFY_SWITCH     EQU     118 ; invalid value passed for
                                            ;  verify flag
ERROR_BAD_DRIVER_LEVEL          EQU     119 ; DosDevIOCTL looks for a level
                                            ;  four driver. If the driver
                                            ;  is not level four we return
                                            ;  this code
ERROR_CALL_NOT_IMPLEMENTED      EQU     120 ; returned from stub api calls.
                                            ;  This call will disappear when
                                            ;  all the api's are implemented.
ERROR_SEM_TIMEOUT               EQU     121 ; Time out happened from the
                                            ;  semaphore api functions.
ERROR_INSUFFICIENT_BUFFER       EQU     122 ; Some calls require the
                                            ;  application to pass in a buffer
                                            ;  filled with data.  This error is
                                            ;  returned if the data buffer is too
                                            ;  small.  For example: DosSetFileInfo
                                            ;  requires 4 bytes of data.  If a
                                            ;  two byte buffer is passed in then
                                            ;  this error is returned.
                                            ;  error_buffer_overflow is used when
                                            ;  the output buffer in not big enough.
ERROR_INVALID_NAME              EQU     123 ; illegal character or malformed
                                            ; file system name
ERROR_INVALID_LEVEL             EQU     124 ; unimplemented level for info
                                            ; retrieval or setting
ERROR_NO_VOLUME_LABEL           EQU     125 ; no volume label found with
                                            ; DosQFSInfo command
ERROR_MOD_NOT_FOUND             EQU     126 ; w_getprocaddr,w_getmodhandle
ERROR_PROC_NOT_FOUND            EQU     127 ; w_getprocaddr
ERROR_WAIT_NO_CHILDREN          EQU     128 ; CWait finds to children
ERROR_CHILD_NOT_COMPLETE        EQU     129 ; CWait children not dead yet
ERROR_DIRECT_ACCESS_HANDLE      EQU     130 ; handle operation is invalid
                                            ; for direct disk access
                                            ; handles
ERROR_NEGATIVE_SEEK             EQU     131 ; application tried to seek
                                            ; with negitive offset
ERROR_SEEK_ON_DEVICE            EQU     132 ; application tried to seek
                                            ; on device or pipe
ERROR_IS_JOIN_TARGET            EQU     133
ERROR_IS_JOINED                 EQU     134
ERROR_IS_SUBSTED                EQU     135
ERROR_NOT_JOINED                EQU     136
ERROR_NOT_SUBSTED               EQU     137
ERROR_JOIN_TO_JOIN              EQU     138
ERROR_SUBST_TO_SUBST            EQU     139
ERROR_JOIN_TO_SUBST             EQU     140
ERROR_SUBST_TO_JOIN             EQU     141
ERROR_BUSY_DRIVE                EQU     142
ERROR_SAME_DRIVE                EQU     143
ERROR_DIR_NOT_ROOT              EQU     144
ERROR_DIR_NOT_EMPTY             EQU     145
ERROR_IS_SUBST_PATH             EQU     146
ERROR_IS_JOIN_PATH              EQU     147
ERROR_PATH_BUSY                 EQU     148
ERROR_IS_SUBST_TARGET           EQU     149
ERROR_SYSTEM_TRACE              EQU     150 ; system trace error
ERROR_INVALID_EVENT_COUNT       EQU     151 ; DosMuxSemWait errors
ERROR_TOO_MANY_MUXWAITERS       EQU     152
ERROR_INVALID_LIST_FORMAT       EQU     153
ERROR_LABEL_TOO_LONG            EQU     154
ERROR_TOO_MANY_TCBS             EQU     155
ERROR_SIGNAL_REFUSED            EQU     156
ERROR_DISCARDED                 EQU     157
ERROR_NOT_LOCKED                EQU     158
ERROR_BAD_THREADID_ADDR         EQU     159
ERROR_BAD_ARGUMENTS             EQU     160
ERROR_BAD_PATHNAME              EQU     161
ERROR_SIGNAL_PENDING            EQU     162
ERROR_UNCERTAIN_MEDIA           EQU     163
ERROR_MAX_THRDS_REACHED         EQU     164
ERROR_MONITORS_NOT_SUPPORTED    EQU     165
ERROR_UNC_DRIVER_NOT_INSTALLED  EQU     166

; 	The following error codes refer to demand loading segments     
ERROR_LOCK_FAILED               EQU     167
ERROR_SWAPIO_FAILED             EQU     168
ERROR_SWAPIN_FAILED             EQU     169
ERROR_BUSY                      EQU     170

ERROR_INVALID_SEGMENT_NUMBER    EQU     180
ERROR_INVALID_CALLGATE          EQU     181
ERROR_INVALID_ORDINAL           EQU     182
ERROR_ALREADY_EXISTS            EQU     183
ERROR_NO_CHILD_PROCESS          EQU     184
ERROR_CHILD_ALIVE_NOWAIT        EQU     185
ERROR_INVALID_FLAG_NUMBER       EQU     186
ERROR_SEM_NOT_FOUND             EQU     187

; The following error codes make loader error messages distinct
ERROR_INVALID_STARTING_CODESEG  EQU     188
ERROR_INVALID_STACKSEG          EQU     189
ERROR_INVALID_MODULETYPE        EQU     190
ERROR_INVALID_EXE_SIGNATURE     EQU     191
ERROR_EXE_MARKED_INVALID        EQU     192
ERROR_BAD_EXE_FORMAT            EQU     193
ERROR_ITERATED_DATA_EXCEEDS_64K EQU     194
ERROR_INVALID_MINALLOCSIZE      EQU     195
ERROR_DYNLINK_FROM_INVALID_RING EQU     196
ERROR_IOPL_NOT_ENABLED          EQU     197
ERROR_INVALID_SEGDPL            EQU     198
ERROR_AUTODATASEG_EXCEEDS_64k   EQU     199
ERROR_RING2SEG_MUST_BE_MOVABLE  EQU     200
ERROR_RELOC_CHAIN_XEEDS_SEGLIM  EQU     201
ERROR_INFLOOP_IN_RELOC_CHAIN    EQU     202
ERROR_ENVVAR_NOT_FOUND          EQU     203
ERROR_NOT_CURRENT_CTRY          EQU     204
ERROR_NO_SIGNAL_SENT            EQU     205
ERROR_FILENAME_EXCED_RANGE      EQU     206 ; if filename > 8.3
ERROR_RING2_STACK_IN_USE        EQU     207 ; for FAPI
ERROR_META_EXPANSION_TOO_LONG   EQU     208 ; if "*a" > 8.3
ERROR_INVALID_SIGNAL_NUMBER     EQU     209
ERROR_THREAD_1_INACTIVE         EQU     210
ERROR_INFO_NOT_AVAIL            EQU     211
ERROR_LOCKED                    EQU     212
ERROR_BAD_DYNALINK              EQU     213
ERROR_TOO_MANY_MODULES          EQU     214
ERROR_NESTING_NOT_ALLOWED       EQU     215
ERROR_CANNOT_SHRINK             EQU     216 ; attempt to shrink ring 2 stack
ERROR_ZOMBIE_PROCESS            EQU     217
ERROR_STACK_IN_HIGH_MEMORY      EQU     218
ERROR_INVALID_EXITROUTINE_RING  EQU     219
ERROR_GETBUF_FAILED             EQU     220
ERROR_FLUSHBUF_FAILED           EQU     221
ERROR_TRANSFER_TOO_LONG         EQU     222
ERROR_NO_CHILDREN               EQU     228
ERROR_INVALID_SCREEN_GROUP      EQU     229

;  Error codes 230 - 249 are reserved

ERROR_BAD_PIPE                  EQU     230 ; Non-existant pipe or bad operation
ERROR_PIPE_BUSY                 EQU     231 ; Pipe is busy
ERROR_NO_DATA                   EQU     232 ; No data on non-blocking read
ERROR_PIPE_NOT_CONNECTED        EQU     233 ; Pipe was disconnected by server
ERROR_MORE_DATA                 EQU     234 ; More data is available
ERROR_VC_DISCONNECTED           EQU     240
ERROR_CIRCULARITY_REQUESTED     EQU     250 ; When renaming a dir which
                                            ; would cause a circularity
ERROR_DIRECTORY_IN_CDS          EQU     251 ; When renaming a dir
                                            ; which is "in use"
ERROR_INVALID_FSD_NAME          EQU     252 ; when trying to access
                                            ; nonexistent FSD
ERROR_INVALID_PATH              EQU     253 ; bad pseudo device
ERROR_INVALID_EA_NAME           EQU     254 ; Illegal chars in name
ERROR_EA_LIST_INCONSISTENT      EQU     255 ; Size or some field bad
ERROR_EA_LIST_TOO_LONG          EQU     256 ; FEAlist > 64K-1 bytes
ERROR_NO_META_MATCH             EQU     257 ; string doesn't match expression
ERROR_FINDNOTIFY_TIMEOUT        EQU     258 ; FindNotify request timeout
ERROR_NO_MORE_ITEMS             EQU     259 ; QFSAttach ordinal query
ERROR_SEARCH_STRUC_REUSED       EQU     260 ; 3xbox findfirst/next
                                            ; search structure reused
ERROR_CHAR_NOT_FOUND            EQU     261 ; can not find character
ERROR_TOO_MUCH_STACK            EQU     262 ; Stack request exceeds sys limit
ERROR_INVALID_ATTR              EQU     263 ; invalid FS_ATTRIBUTE
ERROR_INVALID_STARTING_RING     EQU     264
ERROR_INVALID_DLL_INIT_RING     EQU     265
ERROR_CANNOT_COPY               EQU     266 ; doscopy
ERROR_DIRECTORY                 EQU     267 ; doscopy
ERROR_OPLOCKED_FILE             EQU     268
ERROR_OPLOCK_THREAD_EXISTS      EQU     269

;  error codes for DosFindNotify
ERROR_VOLUME_CHANGED            EQU     270
ERROR_FINDNOTIFY_HANDLE_IN_USE  EQU     271
ERROR_FINDNOTIFY_HANDLE_CLOSED  EQU     272
ERROR_NOTIFY_OBJECT_REMOVED     EQU     273

;  Error to indicate that ShutDown already done
ERROR_ALREADY_SHUTDOWN          EQU     274

;  error code for DOSFINDFIRST2/NEXT
ERROR_EAS_DIDNT_FIT             EQU     275

;  error codes for EA file format change
ERROR_EA_FILE_CORRUPT           EQU     276
ERROR_EA_TABLE_FULL             EQU     277
ERROR_INVALID_EA_HANDLE         EQU     278
ERROR_NO_CLUSTER                EQU     279
ERROR_CREATE_EA_FILE            EQU     280
ERROR_CANNOT_OPEN_EA_FILE       EQU     281

ERROR_INVALID_PROCID            EQU     303
ERROR_INVALID_PDELTA            EQU     304
ERROR_NOT_DESCENDANT            EQU     305
ERROR_NOT_SESSION_MANAGER       EQU     306
ERROR_INVALID_PCLASS            EQU     307
ERROR_INVALID_SCOPE             EQU     308
ERROR_INVALID_THREADID          EQU     309
ERROR_DOSSUB_SHRINK             EQU     310
ERROR_DOSSUB_NOMEM              EQU     311
ERROR_DOSSUB_OVERLAP            EQU     312
ERROR_DOSSUB_BADSIZE            EQU     313
ERROR_DOSSUB_BADFLAG            EQU     314
ERROR_DOSSUB_BADSELECTOR        EQU     315
ERROR_MR_MSG_TOO_LONG           EQU     316
ERROR_MR_MID_NOT_FOUND          EQU     317
ERROR_MR_UN_ACC_MSGF            EQU     318
ERROR_MR_INV_MSGF_FORMAT        EQU     319
ERROR_MR_INV_IVCOUNT            EQU     320
ERROR_MR_UN_PERFORM             EQU     321
ERROR_TS_WAKEUP                 EQU     322
ERROR_TS_SEMHANDLE              EQU     323
ERROR_TS_NOTIMER                EQU     324
ERROR_TS_HANDLE                 EQU     326
ERROR_TS_DATETIME               EQU     327
ERROR_SYS_INTERNAL              EQU     328
ERROR_QUE_CURRENT_NAME          EQU     329
ERROR_QUE_PROC_NOT_OWNED        EQU     330
ERROR_QUE_PROC_OWNED            EQU     331
ERROR_QUE_DUPLICATE             EQU     332
ERROR_QUE_ELEMENT_NOT_EXIST     EQU     333
ERROR_QUE_NO_MEMORY             EQU     334
ERROR_QUE_INVALID_NAME          EQU     335
ERROR_QUE_INVALID_PRIORITY      EQU     336
ERROR_QUE_INVALID_HANDLE        EQU     337
ERROR_QUE_LINK_NOT_FOUND        EQU     338
ERROR_QUE_MEMORY_ERROR          EQU     339
ERROR_QUE_PREV_AT_END           EQU     340
ERROR_QUE_PROC_NO_ACCESS        EQU     341
ERROR_QUE_EMPTY                 EQU     342
ERROR_QUE_NAME_NOT_EXIST        EQU     343
ERROR_QUE_NOT_INITIALIZED       EQU     344
ERROR_QUE_UNABLE_TO_ACCESS      EQU     345
ERROR_QUE_UNABLE_TO_ADD         EQU     346
ERROR_QUE_UNABLE_TO_INIT        EQU     347
ERROR_VIO_INVALID_MASK          EQU     349
ERROR_VIO_PTR                   EQU     350
ERROR_VIO_APTR                  EQU     351
ERROR_VIO_RPTR                  EQU     352
ERROR_VIO_CPTR                  EQU     353
ERROR_VIO_LPTR                  EQU     354
ERROR_VIO_MODE                  EQU     355
ERROR_VIO_WIDTH                 EQU     356
ERROR_VIO_ATTR                  EQU     357
ERROR_VIO_ROW                   EQU     358
ERROR_VIO_COL                   EQU     359
ERROR_VIO_TOPROW                EQU     360
ERROR_VIO_BOTROW                EQU     361
ERROR_VIO_RIGHTCOL              EQU     362
ERROR_VIO_LEFTCOL               EQU     363
ERROR_SCS_CALL                  EQU     364
ERROR_SCS_VALUE                 EQU     365
ERROR_VIO_WAIT_FLAG             EQU     366
ERROR_VIO_UNLOCK                EQU     367
ERROR_SGS_NOT_SESSION_MGR       EQU     368
ERROR_SMG_INVALID_SGID          EQU     369
ERROR_SMG_INVALID_SESSION_ID    EQU     369
ERROR_SMG_NOSG                  EQU     370
ERROR_SMG_NO_SESSIONS           EQU     370
ERROR_SMG_GRP_NOT_FOUND         EQU     371
ERROR_SMG_SESSION_NOT_FOUND     EQU     371
ERROR_SMG_SET_TITLE             EQU     372
ERROR_KBD_PARAMETER             EQU     373
ERROR_KBD_NO_DEVICE             EQU     374
ERROR_KBD_INVALID_IOWAIT        EQU     375
ERROR_KBD_INVALID_LENGTH        EQU     376
ERROR_KBD_INVALID_ECHO_MASK     EQU     377
ERROR_KBD_INVALID_INPUT_MASK    EQU     378
ERROR_MON_INVALID_PARMS         EQU     379
ERROR_MON_INVALID_DEVNAME       EQU     380
ERROR_MON_INVALID_HANDLE        EQU     381
ERROR_MON_BUFFER_TOO_SMALL      EQU     382
ERROR_MON_BUFFER_EMPTY          EQU     383
ERROR_MON_DATA_TOO_LARGE        EQU     384
ERROR_MOUSE_NO_DEVICE           EQU     385
ERROR_MOUSE_INV_HANDLE          EQU     386
ERROR_MOUSE_INV_PARMS           EQU     387
ERROR_MOUSE_CANT_RESET          EQU     388
ERROR_MOUSE_DISPLAY_PARMS       EQU     389
ERROR_MOUSE_INV_MODULE          EQU     390
ERROR_MOUSE_INV_ENTRY_PT        EQU     391
ERROR_MOUSE_INV_MASK            EQU     392
NO_ERROR_MOUSE_NO_DATA          EQU     393
NO_ERROR_MOUSE_PTR_DRAWN        EQU     394
ERROR_INVALID_FREQUENCY         EQU     395
ERROR_NLS_NO_COUNTRY_FILE       EQU     396
ERROR_NLS_OPEN_FAILED           EQU     397
ERROR_NLS_NO_CTRY_CODE          EQU     398
ERROR_NO_COUNTRY_OR_CODEPAGE    EQU     398
ERROR_NLS_TABLE_TRUNCATED       EQU     399
ERROR_NLS_BAD_TYPE              EQU     400
ERROR_NLS_TYPE_NOT_FOUND        EQU     401
ERROR_VIO_SMG_ONLY              EQU     402
ERROR_VIO_INVALID_ASCIIZ        EQU     403
ERROR_VIO_DEREGISTER            EQU     404
ERROR_VIO_NO_POPUP              EQU     405
ERROR_VIO_EXISTING_POPUP        EQU     406
ERROR_KBD_SMG_ONLY              EQU     407
ERROR_KBD_INVALID_ASCIIZ        EQU     408
ERROR_KBD_INVALID_MASK          EQU     409
ERROR_KBD_REGISTER              EQU     410
ERROR_KBD_DEREGISTER            EQU     411
ERROR_MOUSE_SMG_ONLY            EQU     412
ERROR_MOUSE_INVALID_ASCIIZ      EQU     413
ERROR_MOUSE_INVALID_MASK        EQU     414
ERROR_MOUSE_REGISTER            EQU     415
ERROR_MOUSE_DEREGISTER          EQU     416
ERROR_SMG_BAD_ACTION            EQU     417
ERROR_SMG_INVALID_CALL          EQU     418
ERROR_SCS_SG_NOTFOUND           EQU     419
ERROR_SCS_NOT_SHELL             EQU     420
ERROR_VIO_INVALID_PARMS         EQU     421
ERROR_VIO_FUNCTION_OWNED        EQU     422
ERROR_VIO_RETURN                EQU     423
ERROR_SCS_INVALID_FUNCTION      EQU     424
ERROR_SCS_NOT_SESSION_MGR       EQU     425
ERROR_VIO_REGISTER              EQU     426
ERROR_VIO_NO_MODE_THREAD        EQU     427
ERROR_VIO_NO_SAVE_RESTORE_THD   EQU     428
ERROR_VIO_IN_BG                 EQU     429
ERROR_VIO_ILLEGAL_DURING_POPUP  EQU     430
ERROR_SMG_NOT_BASESHELL         EQU     431
ERROR_SMG_BAD_STATUSREQ         EQU     432
ERROR_QUE_INVALID_WAIT          EQU     433
ERROR_VIO_LOCK                  EQU     434
ERROR_MOUSE_INVALID_IOWAIT      EQU     435
ERROR_VIO_INVALID_HANDLE        EQU     436
ERROR_VIO_ILLEGAL_DURING_LOCK   EQU     437
ERROR_VIO_INVALID_LENGTH        EQU     438
ERROR_KBD_INVALID_HANDLE        EQU     439
ERROR_KBD_NO_MORE_HANDLE        EQU     440
ERROR_KBD_CANNOT_CREATE_KCB     EQU     441
ERROR_KBD_CODEPAGE_LOAD_INCOMPL EQU     442
ERROR_KBD_INVALID_CODEPAGE_ID   EQU     443
ERROR_KBD_NO_CODEPAGE_SUPPORT   EQU     444
ERROR_KBD_FOCUS_REQUIRED        EQU     445
ERROR_KBD_FOCUS_ALREADY_ACTIVE  EQU     446
ERROR_KBD_KEYBOARD_BUSY         EQU     447
ERROR_KBD_INVALID_CODEPAGE      EQU     448
ERROR_KBD_UNABLE_TO_FOCUS       EQU     449
ERROR_SMG_SESSION_NON_SELECT    EQU     450
ERROR_SMG_SESSION_NOT_FOREGRND  EQU     451
ERROR_SMG_SESSION_NOT_PARENT    EQU     452
ERROR_SMG_INVALID_START_MODE    EQU     453
ERROR_SMG_INVALID_RELATED_OPT   EQU     454
ERROR_SMG_INVALID_BOND_OPTION   EQU     455
ERROR_SMG_INVALID_SELECT_OPT    EQU     456
ERROR_SMG_START_IN_BACKGROUND   EQU     457
ERROR_SMG_INVALID_STOP_OPTION   EQU     458
ERROR_SMG_BAD_RESERVE           EQU     459
ERROR_SMG_PROCESS_NOT_PARENT    EQU     460
ERROR_SMG_INVALID_DATA_LENGTH   EQU     461
ERROR_SMG_NOT_BOUND             EQU     462
ERROR_SMG_RETRY_SUB_ALLOC       EQU     463
ERROR_KBD_DETACHED              EQU     464
ERROR_VIO_DETACHED              EQU     465
ERROR_MOU_DETACHED              EQU     466
ERROR_VIO_FONT                  EQU     467
ERROR_VIO_USER_FONT             EQU     468
ERROR_VIO_BAD_CP                EQU     469
ERROR_VIO_NO_CP                 EQU     470
ERROR_VIO_NA_CP                 EQU     471
ERROR_INVALID_CODE_PAGE         EQU     472
ERROR_CPLIST_TOO_SMALL          EQU     473
ERROR_CP_NOT_MOVED              EQU     474
ERROR_MODE_SWITCH_INIT          EQU     475
ERROR_CODE_PAGE_NOT_FOUND       EQU     476
ERROR_UNEXPECTED_SLOT_RETURNED  EQU     477
ERROR_SMG_INVALID_TRACE_OPTION  EQU     478
ERROR_VIO_INTERNAL_RESOURCE     EQU     479
ERROR_VIO_SHELL_INIT            EQU     480
ERROR_SMG_NO_HARD_ERRORS        EQU     481
ERROR_CP_SWITCH_INCOMPLETE      EQU     482
ERROR_VIO_TRANSPARENT_POPUP     EQU     483
ERROR_CRITSEC_OVERFLOW          EQU     484
ERROR_CRITSEC_UNDERFLOW         EQU     485
ERROR_VIO_BAD_RESERVE           EQU     486
ERROR_INVALID_ADDRESS           EQU     487
ERROR_ZERO_SELECTORS_REQUESTED  EQU     488
ERROR_NOT_ENOUGH_SELECTORS_AVA  EQU     489
ERROR_INVALID_SELECTOR          EQU     490
ERROR_SMG_INVALID_PROGRAM_TYPE  EQU     491
ERROR_SMG_INVALID_PGM_CONTROL   EQU     492
ERROR_SMG_INVALID_INHERIT_OPT   EQU     493
ERROR_VIO_EXTENDED_SG           EQU     494
ERROR_VIO_NOT_PRES_MGR_SG       EQU     495
ERROR_VIO_SHIELD_OWNED          EQU     496
ERROR_VIO_NO_MORE_HANDLES       EQU     497
ERROR_VIO_SEE_ERROR_LOG         EQU     498
ERROR_VIO_ASSOCIATED_DC         EQU     499
ERROR_KBD_NO_CONSOLE            EQU     500
ERROR_MOUSE_NO_CONSOLE          EQU     501
ERROR_MOUSE_INVALID_HANDLE      EQU     502
ERROR_SMG_INVALID_DEBUG_PARMS   EQU     503
ERROR_KBD_EXTENDED_SG           EQU     504
ERROR_MOU_EXTENDED_SG           EQU     505
ERROR_SMG_INVALID_ICON_FILE     EQU     506

ERROR_USER_DEFINED_BASE         EQU     0FF00h

ERROR_I24_WRITE_PROTECT         EQU     0
ERROR_I24_BAD_UNIT              EQU     1
ERROR_I24_NOT_READY             EQU     2
ERROR_I24_BAD_COMMAND           EQU     3
ERROR_I24_CRC                   EQU     4
ERROR_I24_BAD_LENGTH            EQU     5
ERROR_I24_SEEK                  EQU     6
ERROR_I24_NOT_DOS_DISK          EQU     7
ERROR_I24_SECTOR_NOT_FOUND      EQU     8
ERROR_I24_OUT_OF_PAPER          EQU     9
ERROR_I24_WRITE_FAULT           EQU     10
ERROR_I24_READ_FAULT            EQU     11
ERROR_I24_GEN_FAILURE           EQU     12
ERROR_I24_DISK_CHANGE           EQU     13
ERROR_I24_WRONG_DISK            EQU     15
ERROR_I24_UNCERTAIN_MEDIA       EQU     16
ERROR_I24_CHAR_CALL_INTERRUPTED EQU     17
ERROR_I24_NO_MONITOR_SUPPORT    EQU     18
ERROR_I24_INVALID_PARAMETER     EQU     19
ERROR_I24_DEVICE_IN_USE         EQU     20

ALLOWED_FAIL            EQU     0001h
ALLOWED_ABORT           EQU     0002h
ALLOWED_RETRY           EQU     0004h
ALLOWED_IGNORE          EQU     0008h
ALLOWED_ACKNOWLEDGE     EQU     0010h
ALLOWED_DISPATCH        EQU     8000h

I24_OPERATION           EQU     01h
I24_AREA                EQU     06h
I24_CLASS               EQU     80h

;  Values for error CLASS
ERRCLASS_OUTRES         EQU     1 ; Out of Resource
ERRCLASS_TEMPSIT        EQU     2 ; Temporary Situation
ERRCLASS_AUTH           EQU     3 ; Permission problem
ERRCLASS_INTRN          EQU     4 ; Internal System Error
ERRCLASS_HRDFAIL        EQU     5 ; Hardware Failure
ERRCLASS_SYSFAIL        EQU     6 ; System Failure
ERRCLASS_APPERR         EQU     7 ; Application Error
ERRCLASS_NOTFND         EQU     8 ; Not Found
ERRCLASS_BADFMT         EQU     9 ; Bad Format
ERRCLASS_LOCKED         EQU     10 ; Locked
ERRCLASS_MEDIA          EQU     11 ; Media Failure
ERRCLASS_ALREADY        EQU     12 ; Collision with Existing Item
ERRCLASS_UNK            EQU     13 ; Unknown/other
ERRCLASS_CANT           EQU     14
ERRCLASS_TIME           EQU     15

;  Values for error ACTION
ERRACT_RETRY            EQU     1 ; Retry
ERRACT_DLYRET           EQU     2 ; Delay Retry, retry after pause
ERRACT_USER             EQU     3 ; Ask user to regive information
ERRACT_ABORT            EQU     4 ; abort with clean up
ERRACT_PANIC            EQU     5 ; abort immediately
ERRACT_IGNORE           EQU     6 ; ignore
ERRACT_INTRET           EQU     7 ; Retry after User Intervention

;  Values for error LOCUS
ERRLOC_UNK              EQU     1 ; no appropriate value
ERRLOC_DISK             EQU     2 ; Random Access Mass Storage
ERRLOC_NET              EQU     3 ; Network
ERRLOC_SERDEV           EQU     4 ; Serial Device
ERRLOC_MEM              EQU     5 ; Memory

; Abnormal termination codes
TC_NORMAL               EQU     0
TC_HARDERR              EQU     1
TC_GP_TRAP              EQU     2
TC_SIGNAL               EQU     3

ERROR_SWAPPER_NOT_ACTIVE        EQU     32768
ERROR_INVALID_SWAPID            EQU     32769
ERROR_IOERR_SWAP_FILE           EQU     32770
ERROR_SWAP_TABLE_FULL           EQU     32771
ERROR_SWAP_FILE_FULL            EQU     32772
ERROR_CANT_INIT_SWAPPER         EQU     32773
ERROR_SWAPPER_ALREADY_INIT      EQU     32774
ERROR_PMM_INSUFFICIENT_MEMORY   EQU     32775
ERROR_PMM_INVALID_FLAGS         EQU     32776
ERROR_PMM_INVALID_ADDRESS       EQU     32777
ERROR_PMM_LOCK_FAILED           EQU     32778
ERROR_PMM_UNLOCK_FAILED         EQU     32779
ERROR_PMM_MOVE_INCOMPLETE       EQU     32780
ERROR_UCOM_DRIVE_RENAMED        EQU     32781
ERROR_UCOM_FILENAME_TRUNCATED   EQU     32782
ERROR_UCOM_BUFFER_LENGTH        EQU     32783
ERROR_MON_CHAIN_HANDLE          EQU     32784
ERROR_MON_NOT_REGISTERED        EQU     32785
ERROR_SMG_ALREADY_TOP           EQU     32786
ERROR_PMM_ARENA_MODIFIED        EQU     32787
ERROR_SMG_PRINTER_OPEN          EQU     32788
ERROR_PMM_SET_FLAGS_FAILED      EQU     32789
ERROR_INVALID_DOS_DD            EQU     32790
ERROR_CPSIO_CODE_PAGE_INVALID   EQU     65026
ERROR_CPSIO_NO_SPOOLER          EQU     65027
ERROR_CPSIO_FONT_ID_INVALID     EQU     65028
ERROR_CPSIO_INTERNAL_ERROR      EQU     65033
ERROR_CPSIO_INVALID_PTR_NAME    EQU     65034
ERROR_CPSIO_NOT_ACTIVE          EQU     65037
ERROR_CPSIO_PID_FULL            EQU     65039
ERROR_CPSIO_PID_NOT_FOUND       EQU     65040
ERROR_CPSIO_READ_CTL_SEQ        EQU     65043
ERROR_CPSIO_READ_FNT_DEF        EQU     65045
ERROR_CPSIO_WRITE_ERROR         EQU     65047
ERROR_CPSIO_WRITE_FULL_ERROR    EQU     65048
ERROR_CPSIO_WRITE_HANDLE_BAD    EQU     65049
ERROR_CPSIO_SWIT_LOAD           EQU     65074
ERROR_CPSIO_INV_COMMAND         EQU     65077
ERROR_CPSIO_NO_FONT_SWIT        EQU     65078

ENDIF ; INCL_DOSERRORS
