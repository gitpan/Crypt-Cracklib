BEGIN {
	$| = 1;

	print "Please enter the location of your pw_dict file:\n";
	$dict = '/usr/local/share/cracklib/pw_dict';
	print "[$dict] ";
	$ndict = <>;
	chomp $ndict;
	$dict = $ndict if $ndict !~ /^\s*$/;
	
	print "1..18\n";
}

END { print "not ok 1\n" unless $loaded; }
use Crypt::Cracklib;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

my $t = 2;

print fascist_check(getpwuid($<).'1',$dict) =~ /username/ ? "ok $t" : "not ok $t", "\n";
$t++;

# it is based upon your password entry
# it is derived from your password entry
# it's derived from your password entry
# it is derivable from your password entry
# it's derivable from your password entry

# it's WAY too short
print fascist_check('bad',$dict) =~ /WAY/ ? "ok $t" : "not ok $t", "\n";
$t++;

# it is too short
print fascist_check('blah',$dict) eq 'it is too short' ? "ok $t" : "not ok $t", "\n";
$t++;

# it does not contain enough DIFFERENT characters
print fascist_check('aaaaaabb',$dict) =~ /DIFFERENT/ ? "ok $t" : "not ok $t", "\n";
$t++;

# it is all whitespace
print fascist_check('',$dict) =~ /whitespace/ ? "ok $t" : "not ok $t", "\n";
$t++;

# it is too simplistic/systematic
print fascist_check('abcdef',$dict) =~ /simplistic/ ? "ok $t" : "not ok $t", "\n";
$t++;

# it looks like a National Insurance number.
#print fascist_check('aadddddda',$dict) =~ /Insurance/ ? "ok $t" : "not ok $t", "\n";
#$t++;

# it is based on a dictionary word
print fascist_check('dictionary',$dict) =~ /dictionary/ ? "ok $t" : "not ok $t", "\n";
$t++;

# it is based on a (reversed) dictionary word
#print fascist_check('apple1',$dict) =~ /reversed/ ? "ok $t" : "not ok $t", "\n";
#$t++;

# Ok
print fascist_check('Sil1ntBob',$dict) eq 'ok' ? "ok $t" : "not ok $t", "\n";
$t++;
print fascist_check('N3veRGs$',$dict) eq 'ok' ? "ok $t" : "not ok $t", "\n";
$t++;
print fascist_check('W1n$uckS',$dict) eq 'ok' ? "ok $t" : "not ok $t", "\n";
$t++;
print fascist_check('PerL4eVr',$dict) eq 'ok' ? "ok $t" : "not ok $t", "\n";
$t++;
print fascist_check('Neg@torY',$dict) eq 'ok' ? "ok $t" : "not ok $t", "\n";
$t++;

# Ok - check wrapper
print !check('blah',$dict) ? "ok $t" : "not ok $t", "\n";
$t++;
print check('N3veRGs$',$dict)  ? "ok $t" : "not ok $t", "\n";
$t++;
print check('blather',$dict)  ? "ok $t" : "not ok $t", "\n";
$t++;
print !check('begin',$dict)  ? "ok $t" : "not ok $t", "\n";
$t++;
print check('Neg@torY',$dict)  ? "ok $t" : "not ok $t", "\n";
$t++;
