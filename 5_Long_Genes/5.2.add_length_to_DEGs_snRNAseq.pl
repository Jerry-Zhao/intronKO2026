#! /usr/local/perl -w

# Cluster 0: Total-cluster-gene: 9126	Exists: 8860	Non-exists: 266
# Cluster 1: Total-cluster-gene: 9717	Exists: 9222	Non-exists: 495
# Cluster 2: Total-cluster-gene: 8009	Exists: 7828	Non-exists: 181
# Cluster 3: Total-cluster-gene: 11204	Exists: 10534	Non-exists: 670
# Cluster 4: Total-cluster-gene: 11176	Exists: 10534	Non-exists: 642
# Cluster 5: Total-cluster-gene: 11881	Exists: 11147	Non-exists: 734
# Cluster 6: Total-cluster-gene: 10907	Exists: 10284	Non-exists: 623
# Cluster 7: Total-cluster-gene: 11572	Exists: 10896	Non-exists: 676
# Cluster 8: Total-cluster-gene: 10670	Exists: 10126	Non-exists: 544
# Merged DEGs: Total-cluster-gene: 1458	Exists: 1432	Non-exists: 26

open(INA,"/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf.gene")||die("Can't open INA:$!\n");

print "Please enter the file name: e.g. DEGs_Cluster_0\n";
chomp($name=<STDIN>); 

open(INB,"$name.xls")||die("Can't open INB:$!\n");
open(OUT,">Length/$name.length.xls")||die("Can't write OUA:$!\n");

while(<INA>)
{
 chomp;
 if(/^chr\w\w?\:\d+\-\d+\:ENSMUSG\d+\_([\w\.\-\(\)]+)\:\w+\:[+|-]\t(\d+)$/)
 {
  $annota{$1}=$2;
 }
 else{print "Error1\t$_\n";}
}

my $a1=$a2=$a3=0; 
while(<INB>)
{
 chomp;
 if(/^([\w\.\-\(\)]+)\t[\w\.\-]+\t[\d\.\-]+/)
 {
  $a1++;
  if(exists $annota{$1}){print OUT "$_\t$annota{$1}\n"; $a2++;}
  else{print "error not exists ID: $_\n"; $a3++;}
 }
 else{print "Error2\t$_\n"; print OUT "\t$_\tLength\n";}
}

print "Total-cluster-gene: $a1\tExists: $a2\tNon-exists: $a3\n";

close INA; close INB;
close OUT;


