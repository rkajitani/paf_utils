#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	unless (defined $q_max{$f[0]}) {
		push(@order, $f[0]);
	}
	if ($q_max{$f[0]} < $f[9]) {
		$q_max{$f[0]} = $f[9];
		$q_max_name{$f[0]} = $f[5];
		$q_max_line{$f[0]} = $l;
	}
	if ($t_max{$f[5]} < $f[9]) {
		$t_max{$f[5]} = $f[9];
		$t_max_name{$f[5]} = $f[0];
	}
}
close $in;
		
for (@order) {
	if ($_ eq $t_max_name{$q_max_name{$_}}) {
		print($q_max_line{$_}, "\n");
	}
}
