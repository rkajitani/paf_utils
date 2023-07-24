#!/usr/bin/perl

use my_bio;

(@ARGV != 2) and die "usage: $0 aln.paf query.fa\n";

open($in, $ARGV[1]);
while (($name, $seq) = fasta_nonwhite_get($in)) {
	$cov{$name} = ('0' x length($seq));
	$gap{$name} = ('0' x length($seq));
	while ($seq =~ /[nN]+/g) {
		substr($gap{$name}, length($`), length($&), '1' x length($&));
	}
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
	$cov_flags = $cov{$_};
	$gap_flags = $gap{$_};
	$cov_len = 0;
	$non_gap_len = 0;
	for $i (0..(length($cov_flags) - 1)) {
		if (substr($gap_flags, $i, 1) == '0') {
			++$non_gap_len;
			if (substr($cov_flags, $i, 1) == '1') {
				++$cov_len;
			}
		}
	}
	print(join("\t", ($_, $non_gap_len, $cov_len, $cov_len / $non_gap_len * 100), "\n"));
}

