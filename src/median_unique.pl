# Insight Data Engineering - Coding Challenge
# Date: 7/13/2015
# File: median_unique.pl
# Author: Joseph Kuitche
# 
# Purpose: Calculate the updated median number of unique words as tweets come in
# The probleme can be framed as followed: 
# (1) For each tweet that comes in 
# (2) Determine the number of unique words and add to the set
# a word being delineated by space character
# (3) Compute the median of the set of numbers
# (4) print the median with 2 digit precision

use strict;
# Opening input file for reading and output file for writing
open INPUT, "tweet_input/tweets.txt" or die $!;
open OUTPUT, ">tweet_output/ft2.txt" or die $!;

my @uniq = ();		# for tracking the set of numbers of unique words
while(<INPUT>) {
	chomp;
	my @list = split(/\s+/);	   # A word is delineated by space
	my $num = uniq(@list);	           # receive the number of unique words
	push(@uniq, $num);	           # and  add to the set of numbers
	my $median = median(@uniq);        # receive the median of the set
	printf (OUTPUT "%.2f\n", $median); # and print
}

# The subroutine uniq() takes the list of words in a tweet
# Determines and returns the number of unique words in that tweet
sub uniq {
	my @list = @_;	
	my %seen = ();
	my @uniq = ();
	foreach my $item (@list) {
		push(@uniq, $item) unless $seen{$item}++;
	}
	my $len = @uniq;
	return $len;	
}

# The subroutine median() takes the set of numbers of unique words
# for each tweet received at any given time
# then computes and returns the median of that set
sub median {
	my @sizes = @_;
	my $len = @_;
	my $median;
	if ($len%2==0) {
		my $x = $len/2;
		my $y = $x - 1;
		$median = ($sizes[$y] + $sizes[$x])/2; 
	}
	else {
		my $x = ($len - 1)/2;
		$median = $sizes[$x];
	}
	return $median;
}


close INPUT;
close OUTPUT;
