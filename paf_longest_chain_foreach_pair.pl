#!/usr/bin/perl

use List::Util qw/min max/;

(@ARGV != 2) and die "usage: $0 in.paf min_aln_distance(bp)\n";

$max_dist = $ARGV[1];

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($qname, $qlen, $strand, $tname, $start, $end) = (split(/\t/, $l))[0, 1, 4, 5, 7, 8];
	push(@{$aln{$qname}{$tname}}, [$start, $end]);
	$seq_len{$qname} = $qlen;
}
close $in;

for $qname (keys %aln) {
	for $tname (keys %{$aln{$qname}}) {
		@pos = @{$aln{$qname}{$tname}};
		@pos = sort{$a->[0] <=> $b->[0]} @pos;

		$max_len = 0;
		@max_index_list = ();
		@is_used = (0) x (@pos + 0);
		for $i (0..$#pos) {
			next if ($is_used[$i]);

			@cur_index_list = ($i);
			$cur_end = $pos[$i][1];
			for $j (($i + 1)..$#pos) {
				if ($pos[$j][0] - $cur_end <= min($max_dist, $seq_len{$qname})) {
					$cur_end = max($cur_end, $pos[$j][1]);
					push(@cur_index_list, $j);
				}
				else {
					if ($cur_end - $pos[$i][0] > $max_len) {
						$max_len = $cur_end - $pos[$i][0];
						@max_index_list = @cur_index_list;
					}
					
					for (@cur_index_list) {
						$is_used[$_] = 1;
					}

					last;
				}
			}
			if ($cur_end - $pos[$i][0] > $max_len) {
				$max_len = $cur_end - $pos[$i][0];
				@max_index_list = @cur_index_list;
			}
		}

		for (@max_index_list) {
			$output_flag{join("\t", ($qname, $tname, $pos[$_][0], $pos[$_][1]))} = 1;
		}
	}
}

open($in, $ARGV[0]);
while (chomp($l = <$in>)) {
	($qname, $strand, $tname, $start, $end) = (split(/\t/, $l))[0, 4, 5, 7, 8];
	if ($output_flag{join("\t", ($qname, $tname, $start, $end))}) {
		print "$l\n";
	}
}
close $in;
