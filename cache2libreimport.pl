#!/usr/bin/perl -w
#
# post-fm is the only one of these options that works for me:
# http://cmus.sourceforge.net/wiki/doku.php?id=status_display_programs
# Well, when I say "work" it scrobbles with no cache (starting fresh)
# and does cache when offline, but the problem I have is that it 
# doesn't scrobble when there is a large cache - I get an 
# "invalid header" error or something.
# 
# So, until I actually understand Perl and can figure out what's not
# working with post-fm, I thought I'd use the post-fm script as a basis
# for a simple script that converts the cache into a format that can be
# used by libreimport.py:
# http://bugs.foocorp.net/projects/librefm/wiki/LastToLibre
#
use strict;
use warnings;

use Storable;

#Copy post-fm approach

#Globals
our %rc = (
	cache => "$ENV{HOME}/.cmus/last-cache"
);

our $tracks = [];

# Read in the Storable cache file
$tracks = retrieve($rc{cache}) if -r $rc{cache};

# Open an output file
open FILE, "> librefmimport.txt" or die "Cannot open output.txt: $!";

#Loop through the list of tracks, export tab separated values
for my $track (@{$tracks}) {
	my %track = %{$track};
	#           DateTime              Track Name           Artist               Album
	print FILE ($track{"i"} . "\t" . $track{"t"} . "\t" . $track{"a"} . "\t" . $track{"b"} . "\n");

}

close FILE; 
