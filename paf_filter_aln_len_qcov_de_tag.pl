#!/usr/bin/perl

(@ARGV != 4) and die "usage: $0 in.paf min_idt(0-1) min_aln_len(bp) min_query_cov(0-1)\n";

$min_idt = $ARGV[1];
$min_aln_len = $ARGV[2];
$min_q_cov = $ARGV[3];

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($q_len, $q_start, $q_end, $n_match, $aln_len) = (split(/\t/, $l))[1, 2, 3, 9, 10];

	if ($l =~ /\tde:f:([0-9.]+)/) {
		$idt = (1 - $1);
	}
	else {
		next;
	}

	$aln_len = $q_end - $q_start;
	if (($aln_len / $q_len >= $min_q_cov or $aln_len >= $min_aln_len) and $idt >= $min_idt) {
		print "$l\n";
	}
}
close $in;
