#!/usr/bin/perl -w
use LWP::Simple;
my %Uhash;
my @Uarray = ("http://tw.stock.yahoo.com/");
my $history = "history.txt";

while ($link = pop(@Uarray))
{
  if (!$Uhash{$link})
  {
    print $link."\n";
    $Uhash{$link} = 1;
    my $result = get($link) or next;
    
    while ($result =~ /href="(http:\/\/[^>]*?\/?)"/g)
    {
      #print $1."\n";
      push @Uarray,$1;
    }

    #It's for printing last 5 items 
    open OUT, ">", $history;
    for($i=$#Uarray;$i>$#Uarray-5;$i--)
    {
      print OUT $Uarray[$i]."\n";
    }
    close OUT;
  }
}
