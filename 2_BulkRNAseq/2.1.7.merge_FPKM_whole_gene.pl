#! /usr/local/perl -w

open(INA,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_WT_rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INB,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_WT_rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INC,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_WT_rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(IND,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_WT_rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(INE,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_HOMO_rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INF,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_HOMO_rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(ING,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_HOMO_rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INH,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_HOMO_rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INI,"count/FPKM_Hs6st3iKO_RNAseq_male_hippocampus_HOMO_rep5_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(OUT,">Merged_FPKM_Hs6st3iKO_RNAseq_hippocampus_whole_gene_Jerry.xls")||die("Can't write OUT:$!\n");

while(<INA>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$wt1{$1}=$2;}else{print"error1\t$_\n";}}
while(<INB>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$wt2{$1}=$2;}else{print"error2\t$_\n";}}
while(<INC>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$wt3{$1}=$2;}else{print"error3\t$_\n";}}
while(<IND>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$wt4{$1}=$2;}else{print"error4\t$_\n";}}

while(<INE>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$ko1{$1}=$2;}else{print"error5\t$_\n";}}
while(<INF>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$ko2{$1}=$2;}else{print"error6\t$_\n";}}
while(<ING>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$ko3{$1}=$2;}else{print"error7\t$_\n";}}
while(<INH>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$ko4{$1}=$2;}else{print"error8\t$_\n";}}
while(<INI>){chomp;if(/^(chr[\:\w\.\-\(\)\+]+)\t([\d\.]+)$/){$ko5{$1}=$2;}else{print"error9\t$_\n";}}

print OUT "\tWT1\tWT2\tWT3\tWT4\t";
print OUT "iKO1\tiKO2\tiKO3\tiKO4\tiKO5\n";

my $a1=0;
foreach (keys %wt1)
{
 $a1++;
 print OUT "$_\t";
 print OUT "$wt1{$_}\t$wt2{$_}\t$wt3{$_}\t$wt4{$_}\t";
 print OUT "$ko1{$_}\t$ko2{$_}\t$ko3{$_}\t$ko4{$_}\t$ko5{$_}\n";
}

print "total-genes: $a1\n";

close OUT;


