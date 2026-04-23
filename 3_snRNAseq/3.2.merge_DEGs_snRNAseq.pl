#! /usr/local/perl -w

# total <- read.table("Merged_DEGs_cluster_0_8_sorted.txt",header=T,sep="\t",row.names=1)
# total[1:5,]
# library("RColorBrewer")
# library("pheatmap")
# pdf("Merged_DEGs_cluster_0_8.pdf")
# pheatmap(total, color = colorRampPalette(rev(brewer.pal(n =5, name ="RdYlGn")))(500), breaks = seq(-1, 1, length.out = 500), cluster_cols = FALSE, cluster_rows=FALSE)
# dev.off()

open(INA,"DEGs_Cluster_0.xls")||die("Can't open INA:$!\n");
open(INB,"DEGs_Cluster_1.xls")||die("Can't open INB:$!\n");
open(INC,"DEGs_Cluster_2.xls")||die("Can't open INC:$!\n");
open(IND,"DEGs_Cluster_3.xls")||die("Can't open IND:$!\n");
open(INE,"DEGs_Cluster_4.xls")||die("Can't open INE:$!\n");
open(INF,"DEGs_Cluster_5.xls")||die("Can't open INF:$!\n");
open(ING,"DEGs_Cluster_6.xls")||die("Can't open ING:$!\n");
open(INH,"DEGs_Cluster_7.xls")||die("Can't open INH:$!\n");
open(INI,"DEGs_Cluster_8.xls")||die("Can't open INI:$!\n");

open(OUT,">Merged_DEGs_cluster_0_8.xls")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $a1++;
  if($3 < 0.05){$a2++;$c0{$1}=$2; $total{$1}=1;}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $b1++;
  if($3 < 0.05){$b2++;$c1{$1}=$2; $total{$1}=1;}
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $c1++;
  if($3 < 0.05){$c2++;$c2{$1}=$2; $total{$1}=1;}
 }
 else{print "error3\t$_\n";}
}

while(<IND>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $d1++;
  if($3 < 0.05){$d2++;$c3{$1}=$2; $total{$1}=1;}
 }
 else{print "error4\t$_\n";}
}

while(<INE>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $e1++;
  if($3 < 0.05){$e2++;$c4{$1}=$2; $total{$1}=1;}
 }
 else{print "error5\t$_\n";}
}

while(<INF>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $f1++;
  if($3 < 0.05){$f2++;$c5{$1}=$2; $total{$1}=1;}
 }
 else{print "error6\t$_\n";}
}

while(<ING>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $g1++;
  if($3 < 0.05){$g2++;$c6{$1}=$2; $total{$1}=1;}
 }
 else{print "error7\t$_\n";}
}

while(<INH>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $h1++;
  if($3 < 0.05){$h2++;$c7{$1}=$2; $total{$1}=1;}
 }
 else{print "error8\t$_\n";}
}

while(<INI>)
{
 chomp;
 if(/^([\w\.\-]+)\t[\w\.\-]+\t([\d\.\-]+)\t[\d\.]+\t[\d\.]+\t([\w\.\-]+)$/)
 {
  $i1++;
  if($3 < 0.05){$i2++;$c8{$1}=$2; $total{$1}=1;}
 }
 else{print "error9\t$_\n";}
}

print OUT "\tCluster0\tCluster1\tCluster2\tCluster3\tCluster4\t";
print OUT "Cluster5\tCluster6\tCluster7\tCluster8\n";
foreach (keys %total)
{
 print OUT "$_\t";
 if(exists $c0{$_}){print OUT "$c0{$_}\t"; $a3++;}else{print OUT "0\t";}
 if(exists $c1{$_}){print OUT "$c1{$_}\t"; $b3++;}else{print OUT "0\t";}
 if(exists $c2{$_}){print OUT "$c2{$_}\t"; $c3++;}else{print OUT "0\t";}
 if(exists $c3{$_}){print OUT "$c3{$_}\t"; $d3++;}else{print OUT "0\t";}
 if(exists $c4{$_}){print OUT "$c4{$_}\t"; $e3++;}else{print OUT "0\t";}
 if(exists $c5{$_}){print OUT "$c5{$_}\t"; $f3++;}else{print OUT "0\t";}
 if(exists $c6{$_}){print OUT "$c6{$_}\t"; $g3++;}else{print OUT "0\t";}
 if(exists $c7{$_}){print OUT "$c7{$_}\t"; $h3++;}else{print OUT "0\t";}
 if(exists $c8{$_}){print OUT "$c8{$_}\n"; $i3++;}else{print OUT "0\n";}
}

print "Cluster-0: total $a1\t DEGs $a2 $a3\n";
print "Cluster-1: total $b1\t DEGs $b2 $b3\n";
print "Cluster-2: total $c1\t DEGs $c2 $c3\n";
print "Cluster-3: total $d1\t DEGs $d2 $d3\n";
print "Cluster-4: total $e1\t DEGs $e2 $e3\n";
print "Cluster-5: total $f1\t DEGs $f2 $f3\n";
print "Cluster-6: total $g1\t DEGs $g2 $g3\n";
print "Cluster-7: total $h1\t DEGs $h2 $h3\n";
print "Cluster-8: total $i1\t DEGs $i2 $i3\n";

close OUT;


