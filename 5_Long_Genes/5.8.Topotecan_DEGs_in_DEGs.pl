#! /usr/local/perl -w
# Compare Topotecan DEGs and our DEGs
# Bulk DEGs
# snRNAseq CA1 DEGs: clusters 3, 4, 8

open(INA,"../RNAseq2022/DESeq2_Wald_Hs6st3iKO_RNAseq2022_male_Hippocampus_WT_HOMO_whole_gene.xls")||die("Can't open INA:$!\n");

open(INB,"../scRNA2024/Length/DEGs_Cluster_3.length.xls")||die("Can't open INB:$!\n");
open(INC,"../scRNA2024/Length/DEGs_Cluster_4.length.xls")||die("Can't open INC:$!\n");
open(IND,"../scRNA2024/Length/DEGs_Cluster_8.length.xls")||die("Can't open IND:$!\n");
 
open(INE,"Topotecan_DEGs.txt")||die("Can't open INE:$!\n");

open(OUA,">Topotecan_DEGs_total.xls")||die("Can't write OUA:$!\n");
open(OUB,">Topotecan_DEGs_Bulk.xls")||die("Can't write OUB:$!\n");
open(OUC,">Topotecan_DEGs_CA1_1.xls")||die("Can't write OUC:$!\n");
open(OUD,">Topotecan_DEGs_CA1_2.xls")||die("Can't write OUD:$!\n");
open(OUE,">Topotecan_DEGs_CA1_3.xls")||die("Can't write OUE:$!\n");

my $a5=0; 

while(<INA>)
{
 chomp;
 if(/^chr\w\w?\:\d+\-\d+\:ENSMUSG\d+\_([\w\.\-\(\)]+)\:\w+\:[+|-]\t[\d\.]+\t([\w\.\-]+)\t.*\t([\w\.\-]+)$/)
 {
  $bulk{$1}="$2\t$3";
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\-\.]+\t([\d\.\-]+)\t.*\t([\w\.\-]+)\t\d+$/)
 {
  $ca11{$1}="$2\t$3";
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\-\.]+\t([\d\.\-]+)\t.*\t([\w\.\-]+)\t\d+$/)
 {
  $ca12{$1}="$2\t$3";
 }
 else{print "error3\t$_\n";}
}

while(<IND>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\-\.]+\t([\d\.\-]+)\t.*\t([\w\.\-]+)\t\d+$/)
 {
  $ca13{$1}="$2\t$3";
 }
 else{print "error4\t$_\n";}
}

print OUA "gene\tlog2FC\tFDR\tLength\tBulk-FC\tBulk-FDR\tCA1-1-FC\tCA1-1-FDR\tCA1-2-FC\tCA1-2-FDR\tCA1-3-FC\tCA1-3-FDR\n";
print OUB "gene\tlog2FC\tFDR\tLength\tBulk-FC\tBulk-FDR\n";
print OUC "gene\tlog2FC\tFDR\tLength\tCA1-1-FC\tCA1-1-FDR\n";
print OUD "gene\tlog2FC\tFDR\tLength\tCA1-2-FC\tCA1-2-FDR\n";
print OUE "gene\tlog2FC\tFDR\tLength\tCA1-3-FC\tCA1-3-FDR\n";

while(<INE>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\d\.\-]+\t[\w\.\-]+\t[\d\.]+$/)
 {
  $a5++; 
  print OUA "$_\t";
  if(exists $bulk{$1}){print OUA "$bulk{$1}\t";}else{print OUA "NA\tNA\t";}
  if(exists $ca11{$1}){print OUA "$ca11{$1}\t";}else{print OUA "NA\tNA\t";}
  if(exists $ca12{$1}){print OUA "$ca12{$1}\t";}else{print OUA "NA\tNA\t";}
  if(exists $ca13{$1}){print OUA "$ca13{$1}\n";}else{print OUA "NA\tNA\n";}
 
  if(exists $bulk{$1}){$d1++; print OUB "$_\t$bulk{$1}\n";}
  if(exists $ca11{$1}){$d2++; print OUC "$_\t$ca11{$1}\n";}
  if(exists $ca12{$1}){$d3++; print OUD "$_\t$ca12{$1}\n";}
  if(exists $ca13{$1}){$d4++; print OUE "$_\t$ca13{$1}\n";}
 }
 else{print "error5\t$_\n";}
}

print "Topo-gene-tatal: $a5\nOverlap: bulk: $d1\tCA1-1:$d2\tCA1-2:$d3\tCA1-3:$d4\n";

close INA; close INB; close INC; close IND; close INE;
close OUA; close OUB; close OUC; close OUD; close OUE;

