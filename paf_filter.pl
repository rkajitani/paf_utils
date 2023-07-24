#!/usr/bin/perl

(@ARGV != 3) and die "usage: $0 minimap.paf min_idt(0-1) min_aln_len\n";

$min_idt = $ARGV[1];
$min_aln_len = $ARGV[2];

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($q_start, $q_end, $t_start, $t_end, $n_match, $aln_len) = (split(/\t/, $l))[2, 3, 7, 8, 9, 10];
#	$q_aln_len = $q_end - $q_start;
#	$t_aln_len = $t_end - $t_start;
#	if (($q_aln_len >= $min_aln_len or $t_aln_len >= $min_aln_len) and ($n_match / $q_aln_len >= $min_idt or $n_match / $t_aln_len)) {
	if ($aln_len >= $min_aln_len and $n_match / $aln_len >= $min_idt) {
		print "$l\n";
	}
}
close $in;
