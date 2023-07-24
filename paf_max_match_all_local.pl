#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	$total_match{$f[0]}{$f[5]} += $f[9];
}
close $in;

while (($q_name, $q_total_match) = each %total_match) {
	while (($t_name, $n_match) = each %{$q_total_match}) {
		if ($max{$q_name} < $n_match) {
			$max{$q_name} = $n_match;
			$max_target{$q_name} = $t_name;
		}
	}
}
		
open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	if ($max_target{$f[0]} eq $f[5]) {
		print "$l\n";
	}
}
close $in;
