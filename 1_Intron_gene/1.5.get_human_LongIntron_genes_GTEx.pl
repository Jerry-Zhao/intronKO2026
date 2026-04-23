#! /usr/local/perl -w

# Total-GTEx: 56156	Top100: 100	Top100-uniq: 92
# Output-genes: 88

# Error-not-exists-in-GTEx: ENSG00000275163
# Error-not-exists-in-GTEx: ENSG00000249209
# Error-not-exists-in-GTEx: ENSG00000282278
# Error-not-exists-in-GTEx: ENSG00000250349  
  
open(INA,"GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct")||die("Can't open INA:$!\n");
open(INB,"Top100_long_introns_human.txt")||die("Can't open INB:$!\n");
open(OUT,">Top100_long_introns_human_geneID.txt")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^(ENSG\d+)(\.\d+)\s+/)
 {
  $a1++;
  if(exists $gene{$1}){print "error exists $1\n";}
  else{$gene{$1}="$1$2";}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^chr\w\w?\:\d+\-\d+\:(ENSG\d+)\_/)
 {
  $a2++;
  $gene2{$1}=1; 
 }
 else{print "error2\t$_\n";}
}

foreach (keys %gene2)
{
 $a3++;
 if(exists $gene{$_}){$a4++; print OUT "$gene{$_}\n";}
 else{print "Error-not-exists-in-GTEx: $_\n";}
}

print "Total-GTEx: $a1\tTop100: $a2\tTop100-uniq: $a3\nOutput-genes: $a4\n";

close INA; close INB;
close OUT;


