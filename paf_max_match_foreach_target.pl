#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	unless (defined $max{$f[5]}) {
		push(@order, $f[5]);
	}
	if ($max{$f[5]} < $f[9]) {
		$max{$f[5]} = $f[9];
		$max_line{$f[5]} = $l;
	}
}
close $in;
		
for (@order) {
	print($max_line{$_}, "\n");
}
