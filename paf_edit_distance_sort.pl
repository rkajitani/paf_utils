#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);

$max = 0;
while (chomp($l = <$in>)) {
	if ($l =~ /NM:i:(\d+)/) {
		push(@buf, [$l, $1]);
	}
}
close $in;
		
for (sort{$a->[1] <=> $b->[1]} @buf) {
	print($_->[0], "\n");
}
