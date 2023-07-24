#!/usr/bin/perl

(@ARGV != 3) and die "usage: $0 in.paf min_idt(0-1) min_query_cov(0-1)\n";

$min_idt = $ARGV[1];
$min_q_cov = $ARGV[2];

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($q_len, $q_start, $q_end, $n_match, $aln_len) = (split(/\t/, $l))[1, 2, 3, 9, 10];

	if ($l =~ /\tde:f:([0-9.]+)/) {
		$idt = (1 - $1);
	}
	else {
		next;
	}

	if (($q_end - $q_start) / $q_len >= $min_q_cov and $idt >= $min_idt) {
		print "$l\n";
	}
}
close $in;
