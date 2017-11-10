#!/usr/bin/perl -w

use strict;

open FL1,"<D.fa";
open FL2,"<1.txt";
open FL3,">100.txt";

my ($ID,%seq,@a,$b,$seq);

while (<FL1>) {
	if		(/>/) {chomp;$ID=$_;}
	else	{chomp;$seq{$ID}.=$_;}
}

while (<FL2>) {
	@a=split /\t/,$_;
	foreach  $b(keys %seq) {
		if ($a[0] eq $b) {
			$seq=substr ($seq{$b},$a[1]-1,$a[2]-$a[1]+1);
				print FL3 "$_$seq\n";
		}
	}
}

close FL1;
close FL2;
close FL3;
exit;