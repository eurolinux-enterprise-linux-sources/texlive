
#
# Check for kpathsea
#
AC_DEFUN([AC_CHECK_KPSE_SUPPORT], [
  AC_MSG_CHECKING([whether you have kpathsea headers and they know about the required file formats])
  AC_TRY_COMPILE(
    [
#include <stdio.h>
#include <kpathsea/kpathsea.h>
      ], [
kpse_tex_ps_header_format;
kpse_type1_format;
kpse_vf_format;
kpse_ofm_format;
kpse_ovf_format;
kpse_truetype_format;
    ],
    [ AC_MSG_RESULT(yes)
      AC_CHECK_LIB(kpathsea, xbasename,
        [],
        [ AC_MSG_ERROR([
This version of dvipdfmx requires xbasename() in kpathsea library.
          ]) ]
      )
    ],
    [ AC_MSG_RESULT(no);
      AC_MSG_ERROR([
This version of dvipdfmx requires that kpathsea and its headers be installed.
If you are sure they are installed and in a standard place, maybe you need a
newer version of kpathsea?  You also might try setting the environment
variable CPPFLAGS (or CFLAGS) with -I pointing to the directory containing
the file "tex-file.h"
      ]) ]
  )
])


#
# Check for enc, cmap, sfd formats
#
AC_DEFUN([AC_CHECK_KPSE_TDS_VERSION], [
  AC_MSG_CHECKING([whether kpathsea library supports TDS version 1.1 installation])
  AC_TRY_COMPILE(
    [
#include <stdio.h>
#include <kpathsea/kpathsea.h>
#include <kpathsea/tex-file.h>
      ], [
kpse_enc_format;
kpse_cmap_format;
kpse_sfd_format;
kpse_opentype_format;
    ],
    [ AC_MSG_RESULT(yes);
      AC_DEFINE([__TDS_VERSION__],  0x200406L, [Define if your libkpathsea supports enc formats])
      AM_CONDITIONAL(TDS_VERSION_11, true)
    ],
    [ AC_MSG_RESULT(no);
      AC_DEFINE([__TDS_VERSION__],  0x200302L, [Define if your libkpathsea supports enc formats])
      AM_CONDITIONAL(TDS_VERSION_11, false)
    ]
  )
])


#
# Check for zlib
#
AC_DEFUN([AC_HAS_ZLIB], [
  _cppflags=$CPPFLAGS _ldflags=$LDFLAGS
  AC_ARG_WITH(zlib,  
    [  --with-zlib=DIR         use zlib include/library files from DIR],
    [
if test -d "$withval"; then
  CPPFLAGS="$CPPFLAGS -I$withval/include"
  LDFLAGS="$LDFLAGS -L$withval/lib"
fi
    ]
  )
  AC_MSG_CHECKING([for zlib header files])
  AC_TRY_COMPILE(
    [
#include <zlib.h>
      ], [
z_stream p;
    ],
    [ AC_MSG_RESULT(yes)
      AC_CHECK_LIB(z, compress, [
        AC_DEFINE(HAVE_ZLIB, 1, [Define if you have zlib and its headers])
        LIBS="$LIBS -lz"
        AC_CHECK_LIB(z, compress2, [
          AC_DEFINE(HAVE_ZLIB_COMPRESS2, 1, [Define if your zlib has the compress2 function])
        ])
      ])
    ],
    [CPPFLAGS=$_cppflags LDDFLAGS=$_ldflags AC_MSG_RESULT(no)]
 )
])

#
#   Check for libpng
#
AC_DEFUN([AC_HAS_LIBPNG], [
  _cppflags=$CPPFLAGS _ldflags=$LDFLAGS
  AC_ARG_WITH(png,
    [  --with-png=DIR          use png include/library files from DIR],
    [
if test -d "$withval"; then
  CPPFLAGS="$CPPFLAGS -I$withval/include"
  LDFLAGS="$LDFLAGS -L$withval/lib"
fi
    ]
  )
  AC_CHECK_FUNC(pow, , AC_CHECK_LIB(m, pow, LIBS="$LIBS -lm"))
  AC_MSG_CHECKING([for png header files])
  AC_TRY_COMPILE(
    [
#include <png.h>
      ], [
png_infop p;
    ],
    [ AC_MSG_RESULT(yes)
      AC_CHECK_LIB(png, png_get_image_width,
        [ AC_DEFINE(HAVE_LIBPNG, 1, [Define if you have libpng])
          LIBS="$LIBS -lpng" ], , -lz
      )
    ],
    [ AC_MSG_RESULT(no) ]
  )
])

#
#   Check for libpaper
#
AC_DEFUN([AC_HAS_LIBPAPER], [
  _cppflags=$CPPFLAGS _ldflags=$LDFLAGS
  AC_ARG_WITH(paper,
    [  --with-paper=DIR        use paper include/library files from DIR],
    [
if test -d "$withval"; then
  CPPFLAGS="$CPPFLAGS -I$withval/include"
  LDFLAGS="$LDFLAGS -L$withval/lib"
fi
    ]
  )
  AC_MSG_CHECKING([for paper header files])
  AC_TRY_COMPILE(
    [
#include <paper.h>
      ], [
struct paper *p;
    ],
    [ AC_MSG_RESULT(yes)
      AC_CHECK_LIB(paper, paperpswidth, [
        AC_DEFINE(HAVE_LIBPAPER, 1, [Define if you have libpaper])
        LIBS="$LIBS -lpaper"
      ])
    ],
    [ AC_MSG_RESULT(no) ]
  )
])
