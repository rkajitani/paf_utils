#!/usr/bin/perl

(@ARGV != 1) and die "usage: $0 in.paf\n";

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	$t_name = (split(/\t/, $l))[5];

	if ($l =~ /NM:i:(\d+)/) {
		$dist = $1;
	}
	else {
		next;
	}

	if (not defined $min{$t_name}) {
		push(@order, $t_name);
		$min{$t_name} = $dist;
		$min_line{$t_name} = $l;
	}
	elsif ($min{$t_name} > $dist) {
		$min{$t_name} = $dist;
		$min_line{$t_name} = $l;
	}
}
close $in;
		
for (@order) {
	print($min_line{$_}, "\n");
}
