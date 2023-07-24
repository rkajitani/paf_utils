#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	$total_match{$f[5]} += $f[9];
}
close $in;

$max = 0;
while (($t_name, $n_match) = each %total_match) {
	if ($max < $n_match) {
		$max = $n_match;
		$max_target = $t_name;
	}
}
		
open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	if ($max_target eq $f[5]) {
		print "$l\n";
	}
}
close $in;
