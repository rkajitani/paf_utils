#!/usr/bin/perl

use my_bio;

(@ARGV != 3) and die "usage: $0 aln.paf query.fa min_cov[0-1]\n";

$min_cov = $ARGV[2];

open($in, $ARGV[1]);
while (($name, $seq) = fasta_nonwhite_get($in)) {
	$cov{$name} = ('0' x length($seq));
}
close $in;

open(IN, $ARGV[0]);
while (<IN>) {
	@f = split(/\t/, $_);
	($q_name, $q_start, $q_end) = (split(/\t/, $_))[0, 2, 3];
	if (defined($cov{$q_name})) {
		substr($cov{$q_name}, $q_start, $q_end - $q_start, '1' x ($q_end - $q_start));
	}
}
close IN;

for (keys %cov) {
	$cov_len = ($cov{$_} =~ tr/1/1/);
	if ($cov_len / length($cov{$_}) >= $min_cov) {
		print "$_\n";
	}
}

