#! /usr/local/perl -w
# Compare melting genes and DEGs
# Bulk DEGs
# snRNAseq CA1 DEGs: clusters 3, 4, 8

open(INA,"../RNAseq2022/DESeq2_Wald_Hs6st3iKO_RNAseq2022_male_Hippocampus_WT_HOMO_whole_gene.xls")||die("Can't open INA:$!\n");

open(INB,"../scRNA2024/Length/DEGs_Cluster_3.length.xls")||die("Can't open INB:$!\n");
open(INC,"../scRNA2024/Length/DEGs_Cluster_4.length.xls")||die("Can't open INC:$!\n");
open(IND,"../scRNA2024/Length/DEGs_Cluster_8.length.xls")||die("Can't open IND:$!\n");
 
open(INE,"Melting_scores.txt")||die("Can't open INE:$!\n");

open(OUA,">Melting_scores_total.xls")||die("Can't write OUA:$!\n");
open(OUB,">Melting_scores_Bulk.xls")||die("Can't write OUB:$!\n");
open(OUC,">Melting_scores_CA1_1.xls")||die("Can't write OUC:$!\n");
open(OUD,">Melting_scores_CA1_2.xls")||die("Can't write OUD:$!\n");
open(OUE,">Melting_scores_CA1_3.xls")||die("Can't write OUE:$!\n");

my $a1=$a2=$a3=$a4=$a5=0; 
my $b1=$b2=$b3=$b4=$b5=$b6=$b7=$b8=$b9=$b10=$b11=0;
my $c1=$c2=$c3=$c4=$c5=$c6=$c7=$c8=$c9=$c10=$c11=0;

while(<INA>)
{
 chomp;
 if(/^chr\w\w?\:\d+\-\d+\:ENSMUSG\d+\_([\w\.\-\(\)]+)\:\w+\:[+|-]\t[\d\.]+\t([\w\.\-]+)\t.*\t([\w\.\-]+)$/)
 {
  $bulk{$1}="$2\t$3"; 
  if($3 eq "NA") {}
  else{if($2<0 and $3<0.05){$a1++; $bulkdown{$1}="$2\t$3";}}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\-\.]+\t([\d\.\-]+)\t.*\t([\w\.\-]+)\t\d+$/)
 {
  $ca11{$1}="$2\t$3";
  if($2<0 and $3<0.05){$a2++; $ca11down{$1}="$2\t$3";}
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\-\.]+\t([\d\.\-]+)\t.*\t([\w\.\-]+)\t\d+$/)
 {
  $ca12{$1}="$2\t$3";
  if($2<0 and $3<0.05){$a3++; $ca12down{$1}="$2\t$3";}
 }
 else{print "error3\t$_\n";}
}

while(<IND>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\-\.]+\t([\d\.\-]+)\t.*\t([\w\.\-]+)\t\d+$/)
 {
  $ca13{$1}="$2\t$3";
  if($2<0 and $3<0.05){$a4++; $ca13down{$1}="$2\t$3";}
 }
 else{print "error4\t$_\n";}
}

print OUA "gene_symbol\tlsRRPM_mESC\tlsRRPM_PGN\tlsARPM_mESC\tlsARPM_PGN\tmeltingScore_PGN_R1\tmeltingScore_PGN_R2\tmeltingScore_PGN_mean\tBulk-FC\tBulk-FDR\tCA1-1-FC\tCA1-1-FDR\tCA1-2-FC\tCA1-2-FDR\tCA1-3-FC\tCA1-3-FDR\n";
print OUB "gene_symbol\tlsRRPM_mESC\tlsRRPM_PGN\tlsARPM_mESC\tlsARPM_PGN\tmeltingScore_PGN_R1\tmeltingScore_PGN_R2\tmeltingScore_PGN_mean\tBulk-FC\tBulk-FDR\n";
print OUC "gene_symbol\tlsRRPM_mESC\tlsRRPM_PGN\tlsARPM_mESC\tlsARPM_PGN\tmeltingScore_PGN_R1\tmeltingScore_PGN_R2\tmeltingScore_PGN_mean\tCA1-1-FC\tCA1-1-FDR\n";
print OUD "gene_symbol\tlsRRPM_mESC\tlsRRPM_PGN\tlsARPM_mESC\tlsARPM_PGN\tmeltingScore_PGN_R1\tmeltingScore_PGN_R2\tmeltingScore_PGN_mean\tCA1-2-FC\tCA1-2-FDR\n";
print OUE "gene_symbol\tlsRRPM_mESC\tlsRRPM_PGN\tlsARPM_mESC\tlsARPM_PGN\tmeltingScore_PGN_R1\tmeltingScore_PGN_R2\tmeltingScore_PGN_mean\tCA1-3-FC\tCA1-3-FDR\n";

while(<INE>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t.*\t([\d\.]+)$/)
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

  if($2>5)
  {
   $b1++;
   if(exists $bulk{$1}){$b2++;}
   if(exists $bulkdown{$1}){$b3++;}
   if(exists $ca11{$1}){$b4++;}
   if(exists $ca11down{$1}){$b5++;}
   if(exists $ca12{$1}){$b6++;}
   if(exists $ca12down{$1}){$b7++;}
   if(exists $ca13{$1}){$b8++;}
   if(exists $ca13down{$1}){$b9++;}
   if((exists $bulk{$1}) or (exists $ca11{$1}) or (exists $ca12{$1}) or (exists $ca13{$1})){$b10++;}
   if((exists $bulkdown{$1}) or (exists $ca11down{$1}) or (exists $ca12down{$1}) or (exists $ca13down{$1})){$b11++;}
  }
  else
  {
   $c1++;
   if(exists $bulk{$1}){$c2++;}
   if(exists $bulkdown{$1}){$c3++;}
   if(exists $ca11{$1}){$c4++;}
   if(exists $ca11down{$1}){$c5++;}
   if(exists $ca12{$1}){$c6++;}
   if(exists $ca12down{$1}){$c7++;}
   if(exists $ca13{$1}){$c8++;}
   if(exists $ca13down{$1}){$c9++;}
   if((exists $bulk{$1}) or (exists $ca11{$1}) or (exists $ca12{$1}) or (exists $ca13{$1})){$c10++;} 
   if((exists $bulkdown{$1}) or (exists $ca11down{$1}) or (exists $ca12down{$1}) or (exists $ca13down{$1})){$c11++;}
  }
 }
 else{print "error5\t$_\n";}
}

print "Down-DEGs: Bulk:$a1\tCA1-1: $a2\tCA1-2: $a3\tCA1-3: $a4\n";
print "Melting-gene-tatal: $a5\nMelt-gene: $b1\tnon-Melt-gene: $c1\n\n";

print "Melt-gene: Bulk: $b2\tBulk-down: $b3\nCA1-1: $b4\t CA1-1-down: $b5\n";
print "CA1-2: $b6\t CA1-2-down: $b7\nCA1-3: $b8\t CA1-3-down: $b9\n";
print "Total-expressed: $b10\tTotal-down-DEGs: $b11\n\n";
 
print "non-Melt-gene: Bulk: $c2\tBulk-down: $c3\nCA1-1: $c4\t CA1-1-down: $c5\n";
print "CA1-2: $c6\t CA1-2-down: $c7\nCA1-3: $c8\t CA1-3-down: $c9\n";
print "Total-expressed: $c10\tTotal-down-DEGs: $c11\n\n";

print "Melting-gene-tatal: $a5\nOverlap: bulk: $d1\tCA1-1:$d2\tCA1-2:$d3\tCA1-3:$d4\n";

close INA; close INB; close INC; close IND; close INE;
close OUA; close OUB; close OUC; close OUD; close OUE;

