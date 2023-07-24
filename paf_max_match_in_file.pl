#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);

$max = 0;
while (chomp($l = <$in>)) {
	@f = split(/\t/, $l);
	if ($max < $f[9]) {
		$max = $f[9];
		$max_line = $l;
	}
}
close $in;
		
print($max_line, "\n");
