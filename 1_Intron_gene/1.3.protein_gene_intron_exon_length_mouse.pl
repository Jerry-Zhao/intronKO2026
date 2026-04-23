#! /usr/local/perl -w

open(INA, "/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf.gene")||die("Can't open INA:$!\n");

open(INB, "/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf_plus_final.exon")||die("Can't open INB:$!\n");
open(INC, "/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf_minus_final.exon")||die("Can't open INC:$!\n");
 
open(IND, "/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf_plus_final.intron")||die("Can't open IND:$!\n");
open(INE, "/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf_minus_final.intron")||die("Can't open INE:$!\n");
 
open(OUT,">Mouse_gene_exon_intron_lengths.xls")||die("Can't write OUT:$!\n");

my $a=$b=$c=$d=0;
while(<INA>)
{
 if(/^chr\w\w?\:\d+\-\d+\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\:(\w+)\:[+|-]\t(\d+)$/)
 {
  if($2 eq "protein_coding"){$gene{$1}=$3; $a++;}
 }
 else{print "Error1\t$_\n";}
}

while(<INB>)
{
 if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\_exon\d+\t\+$/)
 {
  $length=$2-$1+1; 
  if(exists $exon{$3}){$exon{$3}=$exon{$3}+$length;}
  else{$exon{$3}=$length; $b++;}
 }
 else{print "Error2\t$_\n";}
}

while(<INC>)
{
 if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\_exon\d+\t\-$/)
 {
  $length=$2-$1+1; 
  if(exists $exon{$3}){$exon{$3}=$exon{$3}+$length;}
  else{$exon{$3}=$length; $b++;}
 }
 else{print "Error3\t$_\n";}
}

while(<IND>)
{
 if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\_intron\d+\t\+$/)
 {
  $length=$2-$1+1; 
  if(exists $intron{$3}){$intron{$3}=$intron{$3}+$length;}
  else{$intron{$3}=$length; $c++;}
 }
 else{print "Error4\t$_\n";}
}

while(<INE>)
{
 if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\_intron\d+\t\-$/)
 {
  $length=$2-$1+1;
  if(exists $intron{$3}){$intron{$3}=$intron{$3}+$length;}
  else{$intron{$3}=$length; $c++;}
 }
 else{print "Error5\t$_\n";}
}

print OUT "ID\tGene\tExon\tIntron\n";
foreach (keys %gene)
{
 if((exists $exon{$_}) and (exists $intron{$_}))
 {
  $d++; 
  print OUT "$_\t$gene{$_}\t$exon{$_}\t$intron{$_}\n";
 }
}

print "Total - Gene: $a\tExon: $b\tIntron: $c\tOveralp: $d\n";

close INA; close INB; close INC; close IND; close INE; 
close OUT;

