/* c-memstr.h: memcpy, strchr, etc.

   Copyright 1992, 1993, 1994, 1995, 1997 1998, 1999, 2000, 2004, 2005,
   2006 Karl Berry and Olaf Weber.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

*/

#ifndef KPATHSEA_C_MEMSTR_H
#define KPATHSEA_C_MEMSTR_H

/* <X11/Xfuncs.h> tries to declare bcopy etc., which can only conflict.  */
#define _XFUNCS_H_

#ifdef HAVE_STRING_H
#include <string.h>
#else
/* don't ever want both string.h and strings.h; fails on AIX.  */
#ifdef HAVE_STRINGS_H
#include <strings.h>
#endif
#endif

/* An ANSI string.h and pre-ANSI memory.h might conflict.  */
#if !defined (STDC_HEADERS) && defined (HAVE_MEMORY_H)
#include <memory.h>
#endif /* not STDC_HEADERS and HAVE_MEMORY_H */

/* Just to be complete, we make both the system V/ANSI and the BSD
   versions of the string functions available.  */
#if !defined(HAVE_STRCHR) && !defined(strchr)
#define strchr index
#endif

#if !defined(HAVE_STRRCHR) && !defined(strrchr)
#define strrchr rindex
#endif

#if !defined(HAVE_MEMCMP) && !defined(memcmp)
#define memcmp(s1, s2, n) bcmp ((s1), (s2), (n))
#endif

#if !defined(HAVE_MEMCPY) && !defined(memcpy)
#define memcpy(to, from, len) bcopy ((from), (to), (len))
#endif

/* Note that these functions should not be used. */
#if !defined(HAVE_BCMP) && !defined(bcmp)
#define bcmp(s1, s2, len) memcmp ((s1), (s2), (len))
#endif

#if !defined(HAVE_BCOPY) && !defined(bcopy)
#define bcopy(from, to, len) memcpy ((to), (from), (len))
#endif

#if !defined(HAVE_BZERO) && !defined(bzero)
#define bzero(s, len) memset ((s), 0, (len))
#endif

#if !defined(HAVE_INDEX) && !defined(index)
#define index(s, c) strchr ((s), (c))
#endif

#if !defined(HAVE_RINDEX) && !defined(rindex)
#define rindex(s, c) strrchr ((s), (c))
#endif

#if !defined(HAVE_STRING_H)
extern char *strtok ();
#ifndef strstr
extern char *strstr ();
#endif
#endif

#endif /* not KPATHSEA_C_MEMSTR_H */
