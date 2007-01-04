package Crypt::Cracklib;

# $Id: Cracklib.pm 2 2007-01-04 00:04:12Z dsully $

use strict;
use vars qw($VERSION @ISA @EXPORT $AUTOLOAD);

require Exporter;
require DynaLoader;

$VERSION = '1.0';
@ISA = qw(Exporter DynaLoader);
@EXPORT = qw(
	fascist_check
	check
	GTry
);

# Wrapper.
sub fascist_check {
	my ($password, $dict) = @_;

	if ($password =~ /^\s*$/) {
		return "Nothing to do: \$password is all whitespace!";
	}

	my $val = '';

	if (defined $dict && -f "$dict.pwd") {

		$val = FascistCheck($password, $dict);

	} else {

		$val = FascistCheck($password);
	}

	if (!defined $val or $val =~ /^\s*$/) {

		$val = 'ok';
	}

	return $val;
}

# Wrapper wrapper.
sub check {
	my $val = fascist_check(@_);

	return 1 if $val eq 'ok';
	return 0;
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

=head1 DESCRIPTION

This is a simple interface to the cracklib library.

=head1 FUNCTIONS

=over 4

=item * fascist_check( $password, [ $dictionary ] )

Returns a string value. Either an error, or "ok".

=item * check( $password, [ $dictionary ] )

Returns a true or false value if the password is acceptable or not.

=item * GTry( $rawstring, $password )

Returns true if the password is derived from $rawstring. False otherwise.

=back

=head1 AUTHOR

Dan Sully <daniel@cpan.org>

=head1 SEE ALSO

perl(1).

=cut
