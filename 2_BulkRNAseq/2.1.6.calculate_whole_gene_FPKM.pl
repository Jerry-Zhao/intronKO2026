#! /usr/local/perl -w
# Normalized to the total read/pairs that are uniquely mapped in gene regions. 
#

print "Please enter the Input file name, no need '_whole_gene_Jerry.txt': GingerasLab_8w_Cortex_mRNA_rep1\n";
chomp($name=<STDIN>);

open(INA,"count/$name\_whole_gene_Jerry.txt")||die("Can't open INA1:$!\n");
open(OUT,">count/FPKM_$name\_whole_gene_Jerry.txt")||die("Can't write OUT:$!\n");

$unique_mapped=0;
while(<INA>)
{
 chomp;
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:(EN\w+\_[\w\.\-\:\+]+)\t(\d+)$/)
 {
  $length=$3-$2+1; $id="$1:$2-$3:$4";  $genelen{$id}=$length;
  $count{$id}=$5;
 }
 elsif(/^####\s+unique-overlap\:\s+(\d+)\s*$/){$unique_mapped=$1;}
 else{print "error count: $_\n";}
}

foreach (keys %count)
{
 $fpkm=int($count{$_}*(1000000/$unique_mapped)*(1000/$genelen{$_})*100000)/100000; ## FPKM. five digits 
 print OUT "$_\t$fpkm\n";
}

close INA; close OUT;

