#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($q_len, $q_start, $q_end, $n_match, $aln_len) = (split(/\t/, $l))[1, 2, 3, 9, 10];

	print(join("\t", ($n_match / $aln_len, ($q_end - $q_start) / $q_len)), "\n");
}
close $in;
