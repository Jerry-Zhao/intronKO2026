#! /usr/local/perl -w

open(INA,"count/Hs6st3iKO_RNAseq_male_cortex_WT_rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INB,"count/Hs6st3iKO_RNAseq_male_cortex_WT_Rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INC,"count/Hs6st3iKO_RNAseq_male_cortex_WT_Rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(IND,"count/Hs6st3iKO_RNAseq_male_cortex_WT_Rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INE,"count/Hs6st3iKO_RNAseq_male_cortex_WT_Rep5_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(INK,"count/Hs6st3iKO_RNAseq_male_cortex_HOMO_Rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INL,"count/Hs6st3iKO_RNAseq_male_cortex_HOMO_Rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INM,"count/Hs6st3iKO_RNAseq_male_cortex_HOMO_Rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INN,"count/Hs6st3iKO_RNAseq_male_cortex_HOMO_Rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INO,"count/Hs6st3iKO_RNAseq_male_cortex_HOMO_Rep5_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(INBA,"count/Hs6st3iKO_RNAseq_male_hippocampus_WT_rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBB,"count/Hs6st3iKO_RNAseq_male_hippocampus_WT_Rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBC,"count/Hs6st3iKO_RNAseq_male_hippocampus_WT_Rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBD,"count/Hs6st3iKO_RNAseq_male_hippocampus_WT_Rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(INBK,"count/Hs6st3iKO_RNAseq_male_hippocampus_HOMO_Rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBL,"count/Hs6st3iKO_RNAseq_male_hippocampus_HOMO_Rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBM,"count/Hs6st3iKO_RNAseq_male_hippocampus_HOMO_Rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBN,"count/Hs6st3iKO_RNAseq_male_hippocampus_HOMO_Rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INBO,"count/Hs6st3iKO_RNAseq_male_hippocampus_HOMO_Rep5_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(OUT,">Merged_Hs6st3iKO_RNAseq2022_male_cortex_hippocampus_whole_gene_Jerry.xls")||die("Can't write OUT:$!\n");

while(<INA>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Cwt1{$1}=$2;}else{print"error1\t$_\n";}}
while(<INB>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Cwt2{$1}=$2;}else{print"error2\t$_\n";}}
while(<INC>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Cwt3{$1}=$2;}else{print"error3\t$_\n";}}
while(<IND>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Cwt4{$1}=$2;}else{print"error4\t$_\n";}}
while(<INE>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Cwt5{$1}=$2;}else{print"error5\t$_\n";}}

while(<INK>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Chomo1{$1}=$2;}else{print"error11\t$_\n";}}
while(<INL>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Chomo2{$1}=$2;}else{print"error12\t$_\n";}}
while(<INM>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Chomo3{$1}=$2;}else{print"error13\t$_\n";}}
while(<INN>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Chomo4{$1}=$2;}else{print"error14\t$_\n";}}
while(<INO>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Chomo5{$1}=$2;}else{print"error15\t$_\n";}}


while(<INBA>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt1{$1}=$2;}else{print"error1\t$_\n";}}
while(<INBB>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt2{$1}=$2;}else{print"error2\t$_\n";}}
while(<INBC>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt3{$1}=$2;}else{print"error3\t$_\n";}}
while(<INBD>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt4{$1}=$2;}else{print"error4\t$_\n";}}

while(<INBK>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hhomo1{$1}=$2;}else{print"error11\t$_\n";}}
while(<INBL>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hhomo2{$1}=$2;}else{print"error12\t$_\n";}}
while(<INBM>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hhomo3{$1}=$2;}else{print"error13\t$_\n";}}
while(<INBN>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hhomo4{$1}=$2;}else{print"error14\t$_\n";}}
while(<INBO>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hhomo5{$1}=$2;}else{print"error15\t$_\n";}}

print OUT "\tCortex_WT1\tCortex_WT2\tCortex_WT3\tCortex_WT4\tCortex_WT5\t"; 
print OUT "Cortex_Homo1\tCortex_Homo2\tCortex_Homo3\tCortex_Homo4\tCortex_Homo5\t";
print OUT "Hippocampus_WT1\tHippocampus_WT2\tHippocampus_WT3\tHippocampus_WT4\t";
print OUT "Hippocampus_Homo1\tHippocampus_Homo2\tHippocampus_Homo3\tHippocampus_Homo4\tHippocampus_Homo5\n";

my $a1=0;
foreach (keys %Cwt1)
{
 $a1++;
 print OUT "$_\t";
 print OUT "$Cwt1{$_}\t$Cwt2{$_}\t$Cwt3{$_}\t$Cwt4{$_}\t$Cwt5{$_}\t";
 print OUT "$Chomo1{$_}\t$Chomo2{$_}\t$Chomo3{$_}\t$Chomo4{$_}\t$Chomo5{$_}\t";
 print OUT "$Hwt1{$_}\t$Hwt2{$_}\t$Hwt3{$_}\t$Hwt4{$_}\t";
 print OUT "$Hhomo1{$_}\t$Hhomo2{$_}\t$Hhomo3{$_}\t$Hhomo4{$_}\t$Hhomo5{$_}\n";
}

print "total-genes: $a1\n";

close OUT;


