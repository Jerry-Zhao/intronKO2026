#! /usr/local/perl -w
## merge the overlapped exons
print "Please enter the species name: e.g. Homo_sapiens.GRCh38.100\n";
chomp($name=<STDIN>);

system("sort -k 2,2 -k 1,1 -k 5,5nr -k 4,4nr $name.exon_minus >$name.exon_minus_sort");
  
open(IN,"$name.exon_minus_sort")||die("Can't open IN:$!\n");
open(OUT,">$name.minus_exon")||die("Can't write OUT:$!\n");

my $linenumber=0; 

while(<IN>)
{
 chomp;
 if(/^([\w\.\-\(\)\/\[\]]+\_exon)\t(\w+)\t(\-)\t(\d+)\t(\d+)$/)
 {
  ## The first line of the file
  if($linenumber==0){$id=$1; $chr=$2; $strand=$3; $start=$4; $end=$5; $exon{$id}=1;}
  $linenumber++;

  if($2 eq $chr) ## same chromosome
  {
   if($1 eq $id) ## still sam gene
   {
    if($5+1 < $start) ## not overlap/adjent
    {
     print OUT "$chr:$start-$end:$id$exon{$id}\t$strand\n";
     $id=$1; $chr=$2; $strand=$3; $start=$4; $end=$5;
     if(exists $exon{$id}){$exon{$id}++;}else{$exon{$id}=1;}
    }
    else ## two exon overlap, merge the two
    {
     if($4 <$start){$start=$4; }
     if($5>$end){$end=$5; print "error: already sorted, should not be the case: $_\n";}
    }
   }
   else ## different genes
   {
    print OUT "$chr:$start-$end:$id$exon{$id}\t$strand\n";
    $id=$1; $chr=$2; $strand=$3; $start=$4; $end=$5;
    if(exists $exon{$id}){$exon{$id}++;}else{$exon{$id}=1;} 
   }
  }
  else ## a new chromosome
  {
   print OUT "$chr:$start-$end:$id$exon{$id}\t$strand\n";
   $id=$1; $chr=$2; $strand=$3; $start=$4; $end=$5;
   if(exists $exon{$id}){$exon{$id}++;}else{$exon{$id}=1;}
  }
 }
 else{print "error1\t$_\n";}
}

print OUT "$chr:$start-$end:$id$exon{$id}\t$strand\n";

close IN; close OUT;

