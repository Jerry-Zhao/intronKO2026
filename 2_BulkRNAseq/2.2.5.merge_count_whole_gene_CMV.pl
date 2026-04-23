#! /usr/local/perl -w

open(INAA,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_WT_rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAB,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_WT_rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAC,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_WT_rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAD,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_WT_rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAE,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_WT_rep5_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
 
open(INAF,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_KO_rep1_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAG,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_KO_rep2_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAH,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_KO_rep3_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAI,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_KO_rep4_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INAJ,"count/Hs6st3_CMV_2023RNAseq_Hippocampus_KO_rep5_whole_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(OUT,">Merged_Hs6st3_CMV_2023RNAseq_hippocampus_whole_gene_Jerry.xls")||die("Can't write OUT:$!\n");

while(<INAA>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt1{$1}=$2;}else{print"error1\t$_\n";}}
while(<INAB>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt2{$1}=$2;}else{print"error2\t$_\n";}}
while(<INAC>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt3{$1}=$2;}else{print"error3\t$_\n";}}
while(<INAD>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt4{$1}=$2;}else{print"error4\t$_\n";}}
while(<INAE>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hwt5{$1}=$2;}else{print"error5\t$_\n";}}

while(<INAF>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hko1{$1}=$2;}else{print"error11\t$_\n";}}
while(<INAG>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hko2{$1}=$2;}else{print"error12\t$_\n";}}
while(<INAH>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hko3{$1}=$2;}else{print"error13\t$_\n";}}
while(<INAI>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hko4{$1}=$2;}else{print"error14\t$_\n";}}
while(<INAJ>){chomp;if(/^(chr[\w\.\-\(\)\:\+]+)\t(\d+)$/){$Hko5{$1}=$2;}else{print"error15\t$_\n";}}

 
print OUT "\tHippocampus_WT1\tHippocampus_WT2\tHippocampus_WT3\tHippocampus_WT4\tHippocampus_WT5\t";
print OUT "Hippocampus_KO1\tHippocampus_KO2\tHippocampus_KO3\tHippocampus_KO4\tHippocampus_KO5\n";

my $a1=0;
foreach (keys %Hwt1)
{
 $a1++;
 print OUT "$_\t";
 print OUT "$Hwt1{$_}\t$Hwt2{$_}\t$Hwt3{$_}\t$Hwt4{$_}\t$Hwt5{$_}\t";
 print OUT "$Hko1{$_}\t$Hko2{$_}\t$Hko3{$_}\t$Hko4{$_}\t$Hko5{$_}\n";
}

print "total-genes: $a1\n";

close OUT;


