# $Id: Makefile.PL,v 1.1 1998/11/28 00:33:13 daniel Exp daniel $

require 5.004_04;
use ExtUtils::MakeMaker;
use Config qw(%Config);

sub MY::libscan {
	my ($self,$path) = @_;

	return '' if($path =~ m:/(RCS|CVS|SCCS)/: ||
		$path =~ m:[~%]$: ||
		$path =~ m:\.(orig|rej)$:
	);

	return $path;
}

print "\nEnter the directory where crack.h/packer.h is located\n";
my $include = '/usr/local/include';
my $incfile = '-Dpacker=1';
print "[$include] ";

while(<>) {
	$_ = '/usr/local/include' if /^\n$/;
	chomp;

	if (/^\S*$/) {
		$include = $_;
		if (-f "$include/packer.h") {
			last;
		} elsif (-f "$include/crack.h") {
			$incfile = '-Dcrack=1';
			last;
		} else {
			die "Can't find Cracklib header file!\n";
		}
	}
}

print "\nEnter the directory where libcrack.(so|a) is located\n";
my $lib = '/usr/local/lib';
print "[$lib] ";

while(<>) {
	$_ = '/usr/local/lib' if /^\n$/;
	chomp;

	if (/^\S*$/) {
		$lib = $_;
		last if -f "$lib/libcrack.so" or -f "$lib/libcrack.a";
	}
}

WriteMakefile(
	'NAME'		=> 'Crypt::Cracklib',
	'VERSION_FROM'	=> 'Cracklib.pm',
	'LIBS'		=> ["-L$lib -lcrack"],
	'DEFINE'	=> $incfile,
	'INC'		=> "-I$include",
	'dist'		=> {	COMPRESS => 'gzip -9f',
				SUFFIX   => 'gz',
				DIST_DEFAULT => 'tardist',
	},
);
