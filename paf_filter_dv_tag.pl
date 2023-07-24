#!/usr/bin/perl

(@ARGV != 3) and die "usage: $0 minimap.paf min_idt(0-1) min_aln_len\n";

$min_idt = $ARGV[1];
$min_aln_len = $ARGV[2];

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	$aln_len = (split(/\t/, $l))[10];

	if ($l =~ /\tdv:f:([0-9.]+)/) {
		$idt = (1 - $1);
	}
	else {
		next;
	}

	if ($aln_len >= $min_aln_len and $idt >= $min_idt) {
		print "$l\n";
	}
}
close $in;
