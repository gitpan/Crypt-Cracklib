package Crypt::Cracklib;

# $Id: Cracklib.pm,v 1.1 1998/11/24 03:13:38 daniel Exp daniel $

use strict;
use vars qw($VERSION @ISA @EXPORT $AUTOLOAD $DICT);

require Exporter;
require DynaLoader;

$VERSION = '0.01';
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw(
	MAXBLOCKLEN
	MAXWORDLEN
	NUMWORDS
	PFOR_FLUSH
	PFOR_USEHWMS
	PFOR_WRITE
	PIH_MAGIC
	STRINGSIZE
	TRUNCSTRINGSIZE
	fascist_check
	check
);

# Wrapper.
sub fascist_check {
	my ($password,$dict) = @_;
	$dict = $DICT if !defined $dict or $dict =~ /^\s*$/;

	return "it is all whitespace" if $password =~ /^\s*$/;
	return "No dictionary specified" if !defined $dict or $dict =~ /^\s*$/;
	
	my $val = FascistCheck($password,$dict);
	$val = 'ok' if !defined $val or $val =~ /^\s*$/;
	return $val;
}

# Wrapper wrapper.
sub check {
	my $val = fascist_check(@_);

	return 1 if $val eq 'ok';
	return 0;
}

sub AUTOLOAD {
	my $constname;
	($constname = $AUTOLOAD) =~ s/.*:://;
	my $val = constant($constname, @_ ? $_[0] : 0);

	if ($! != 0) {
		if ($! =~ /Invalid/) {
			$AutoLoader::AUTOLOAD = $AUTOLOAD;
			goto &AutoLoader::AUTOLOAD;
		} else {
			warn "Your vendor has not defined Crypt::Cracklib macro $constname";
		}
	}

	eval "sub $AUTOLOAD { $val }";
	goto &$AUTOLOAD;
}

bootstrap Crypt::Cracklib $VERSION;

1;
__END__

=head1 NAME

Crypt::Cracklib - Perl interface to Alec Muffett's Cracklib.

=head1 SYNOPSIS

  use Crypt::Cracklib;
  
  my $reason = fascist_check($password, $dictionary);

  print "Ok"  if  check($password, $dictionary);
  print "Bad" if !check($password, $dictionary);

  $Crypt::Cracklib::DICT = '/path/to/cracklib/dictionary';
  my $reason = fascist_check($password);

=head1 DESCRIPTION

This is a simple interface to Alec Muffett's Crack library.

=head1 Exported constants

  MAXBLOCKLEN
  MAXWORDLEN
  NUMWORDS
  PFOR_FLUSH
  PFOR_USEHWMS
  PFOR_WRITE
  PIH_MAGIC
  STRINGSIZE
  TRUNCSTRINGSIZE

=head1 AUTHOR

Daniel <daniel-cpan-cracklib@electricrain.com>

=head1 SEE ALSO

perl(1).

=cut
