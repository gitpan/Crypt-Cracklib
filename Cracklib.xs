#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

/* $Id: Cracklib.xs,v 1.1 1998/11/24 03:13:55 daniel Exp daniel $ */

#ifdef packer
#include <packer.h>
#endif

#ifdef crack
#include <crack.h>
#endif

static int not_here(char *s) {
	croak("%s not implemented on this architecture", s);
	return -1;
}

static double
constant(name, arg)
char *name;
int arg;
{
    errno = 0;
    switch (*name) {
    case 'A':
	break;
    case 'B':
	break;
    case 'C':
	break;
    case 'D':
	break;
    case 'E':
	break;
    case 'F':
	break;
    case 'G':
	break;
    case 'H':
	break;
    case 'I':
	break;
    case 'J':
	break;
    case 'K':
	break;
    case 'L':
	break;
    case 'M':
	if (strEQ(name, "MAXBLOCKLEN"))
#ifdef MAXBLOCKLEN
	    return MAXBLOCKLEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAXWORDLEN"))
#ifdef MAXWORDLEN
	    return MAXWORDLEN;
#else
	    goto not_there;
#endif
	break;
    case 'N':
	if (strEQ(name, "NUMWORDS"))
#ifdef NUMWORDS
	    return NUMWORDS;
#else
	    goto not_there;
#endif
	break;
    case 'O':
	break;
    case 'P':
	if (strEQ(name, "PFOR_FLUSH"))
#ifdef PFOR_FLUSH
	    return PFOR_FLUSH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PFOR_USEHWMS"))
#ifdef PFOR_USEHWMS
	    return PFOR_USEHWMS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PFOR_WRITE"))
#ifdef PFOR_WRITE
	    return PFOR_WRITE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PIH_MAGIC"))
#ifdef PIH_MAGIC
	    return PIH_MAGIC;
#else
	    goto not_there;
#endif
	break;
    case 'Q':
	break;
    case 'R':
	break;
    case 'S':
	if (strEQ(name, "STRINGSIZE"))
#ifdef STRINGSIZE
	    return STRINGSIZE;
#else
	    goto not_there;
#endif
	break;
    case 'T':
	if (strEQ(name, "TRUNCSTRINGSIZE"))
#ifdef TRUNCSTRINGSIZE
	    return TRUNCSTRINGSIZE;
#else
	    goto not_there;
#endif
	break;
    case 'U':
	break;
    case 'V':
	break;
    case 'W':
	break;
    case 'X':
	break;
    case 'Y':
	break;
    case 'Z':
	break;
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}

MODULE = Crypt::Cracklib		PACKAGE = Crypt::Cracklib		

double
constant(name, arg)
	char *name
	int   arg

char*
FascistCheck(password, path)
	char *password
	char *path
	PROTOTYPE: $$
