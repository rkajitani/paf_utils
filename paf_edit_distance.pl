#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);

$max = 0;
while (chomp($l = <$in>)) {
	if ($l =~ /NM:i:(\d+)/) {
		print "$1\n";
	}
	else {
		print "NA\n";
	}
}
close $in;
