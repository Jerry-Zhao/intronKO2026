#! usr/local/perl -w
## get the intron regions on plus-stand genes

print "Please enter the Species name: e.g. Homo_sapiens.GRCh38.100 (no .gtf)\n";
chomp($name=<STDIN>);

open(IN,"$name.minus_exon")||die("Can't open IN:$!\n");
open(OUT,">$name.minus_intron")||die("Can't write OUT:$!\n");

while(<IN>)
{
 chomp;
 if(/^(\w+)\:(\d+)-(\d+):([\w\.\-\(\)\[\]\/]+)exon(\d+)\t\-$/)
 {
  if($5==1) ## exon1
  {
   $gene{$4}=1;
   $chr=$1;
   $start=$2;
  }
  elsif($5>1) ## exon 2 or more
  {
   if($1 ne $chr) ## wrong chromo; no exon1; sorting wrong
   {print "error should not happen wrong chromo: $_\n";}

   if(! (exists $gene{$4})) ## wrong chromo; no exon1; sorting wrong
   {print "error should not happen no exon1: $_\n";}

   if($3 > $start) ## wrong chromo; no exon1; sorting wrong
   {print "error should not happen sorting wrong: $_\n";}

   $intron_id=$5-1; 
   $intron_start=$3+1; $intron_end=$start-1;
   print OUT "$1:$intron_start-$intron_end:$4intron$intron_id\t-\n";

   $chr=$1;
   $start=$2;  ## new end, for next introns
  }
  else{print "error exon numbers: $_\n";}
 }
 else{print "error1\t$_\n";}
}

close IN;
close OUT;

