# $Id: Makefile.PL 10 1998-12-16 23:02:45Z daniel $

use inc::Module::Install;

name('Crypt-Cracklib');
license('perl');
perl_version('5.004');
all_from('Cracklib.pm');

cc_lib_links('crack');

auto_install();
WriteAll();
