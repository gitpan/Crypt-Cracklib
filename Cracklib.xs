/* $Id: Cracklib.xs 10 1998-12-16 23:02:45Z daniel $ */

#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include <crack.h>

MODULE = Crypt::Cracklib PACKAGE = Crypt::Cracklib		

const char*
FascistCheck(password, path = CRACKLIB_DICTPATH)
	const char *password
	const char *path
	PROTOTYPE: $$

int
GTry(rawtext, password)
	char *rawtext
	char *password
	PROTOTYPE: $$
