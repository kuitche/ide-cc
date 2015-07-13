# Insight Data Engineering - Coding Challenge
# Date: 7/13/2015
# File: words_tweeted.pl
# Author: Joseph Kuitche
# 
# Purpose: Calculate the total number of times each word has been tweeted
# The probleme can be framed as followed: 
# (1) open tweets file
# (2) for each tweet, track the cumulative occurrence of each word
# a word being delineated by space character
# (3) print each word with its occurrences into a file

# First create INPUT filehandler for reading and 
# OUTPUT filehandler for writing
open INPUT, "tweet_input/tweets.txt" or die $!;
open OUTPUT, ">tweet_output/ft1.txt" or die $!;

# A hash is used to track occurrences of individual words
# where the keys would be the words and the values are cum. occurrence
%seen = ();  			# The hash is initially empty

# The block of code below reads each line of the file (i.e. each tweet)
# remove the newline character at the end of the tweet
# then split into array of words
while(<INPUT>) {
	chomp;
	@list = split(/\s+/);
	foreach $item (@list) {	      # Each element of the array is a hash key
	    unless ($seen{$item}++) { # unless it has already been seen
	       $seen{$item} = 1;
	    }
	}
}

# The block below display (sorted) keys - values pair of the hash built
foreach $key (sort(keys %seen)) {
	printf (OUTPUT "%-20s\t%5d\n", $key, $seen{$key});
}

close INPUT;
close OUTPUT;
