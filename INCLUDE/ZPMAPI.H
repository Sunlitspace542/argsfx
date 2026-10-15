/***************************************************************************
 *
 *  zpmapi.h -- Definitions and structures for 286 protected mode
 *
 *  Copyright (c) 1991 Rational Systems, Incorporated
 *  All Rights Reserved
 */

#ifndef __ZPMAPI_H
#define	__ZPMAPI_H	1

#if __cplusplus
extern "C" {
#endif

#if __I86__ <= 2

#define ZPMAPI _cdecl _loadds _far

extern  void _far *ZPMAPI ZPMProtectedPtr (void _far *, unsigned int);
extern  void _far *ZPMAPI ZPMRealPtr (void _far *);
extern  void _far *ZPMAPI ZPMLowAlloc (unsigned int);
extern  int ZPMAPI ZPMLowFree (void _far *);
extern  long ZPMAPI ZPMExtAvail (void );
extern  long ZPMAPI ZPMLowAvail (void );

#endif

#if __cplusplus
}
#endif

#endif

