#!/usr/bin/env perl -s

# urlencode - URL or HTML encode or decode the given strings
# Steve Kinzler, kinzler@cs.indiana.edu, Jan 03/Aug 09
# http://www.cs.indiana.edu/~kinzler/home.html#web

$usage = "$0 [ -d ] [ -H [ -q ] ] [ arg ... ]
	-d	decode instead of encode
	-H	HTML coding instead of URL coding
	-q	also HTML encode double-quotes
If no arguments are given, standard input is used.\n";
die $usage if $h;

$in = (@ARGV) ? join(' ', @ARGV) : join('', <>);

print $H ? ($d ? &htmldecode($in) : &htmlencode($in))
	 : ($d ? &urldecode( $in) : &urlencode( $in));

###############################################################################

sub urlencode {
	local($_) = join('', @_);
	s/[^ \w!\$'()*,\-.]/sprintf('%%%02x', ord $&)/ge;
	s/ /+/g;
	return $_;
}

sub urldecode {
	local($_) = join('', @_);
	s/\+/ /g;
	s/%([\da-f]{2})/pack('C', hex $1)/gie;
	return $_;
}

sub htmlencode {
	local($_) = join('', @_);
	s/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g;
	s/"/&quot;/g if $q;
	return $_;
}

sub htmldecode {
	local($_) = join('', @_);
	s/&amp;/&/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g;
	return $_;
}
