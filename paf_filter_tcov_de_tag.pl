#!/usr/bin/perl

(@ARGV != 3) and die "usage: $0 in.paf min_idt(0-1) min_query_cov(0-1)\n";

$min_idt = $ARGV[1];
$min_t_cov = $ARGV[2];

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($t_len, $t_start, $t_end, $n_match, $aln_len) = (split(/\t/, $l))[6, 7, 8, 9, 10];

	if ($l =~ /\tde:f:([0-9.]+)/) {
		$idt = (1 - $1);
	}
	else {
		next;
	}

	if (($t_end - $t_start) / $t_len >= $min_t_cov and $idt >= $min_idt) {
		print "$l\n";
	}
}
close $in;
