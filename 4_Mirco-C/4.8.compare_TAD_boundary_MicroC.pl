#! /usr/local/perl -w
 
open(INA,"TAD/MicroC_inKO_Hippo_WT_50kb.insulation.boundary.1mb.bed")||die("Can't open INA:$!\n");
open(INB,"TAD/MicroC_inKO_Hippo_KO_50kb.insulation.boundary.1mb.bed")||die("Can't open INA:$!\n");
open(OUT,">TAD/Merged_TAD_Boundry_50kb_WT_KO.txt")||die("Can't write OUT:$!\n");
# WT-boundary: 3359     KO-boundary: 3356
# WT-boundary: 3359     WT-KO-overlap: 2644     WT-specific: 715
# KO-boundary: 3356     WT-KO-overlap: 2644     KO-specific: 712


my $a1=$a2=$b1=$b2=$b3=$c1=$c2=$c3=0; 

while(<INA>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t\.\t([\d\.]+)\t\+$/)
 {
  if(exists $wt{$1}){print "error exists1: $1\n";}
  else{$a1++; $wt{$1}=$2; $total{$1}=1;}
 }
 else{print "Error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t\.\t([\d\.]+)\t\+$/)
 {
  if(exists $ko{$1}){print "error exists2: $1\n";}
  else{$a2++; $ko{$1}=$2; $total{$1}=1;}
 }
 else{print "Error2\t$_\n";}
}

print OUT "Chr\tStart\tEnd\tWT_TAD\tWT_value\tKO_TAD\tKO_value\n";
foreach (keys %total)
{
 print OUT "$_\t";
 if(exists $wt{$_}){print OUT "Yes\t$wt{$_}\t";}else{print OUT "No\t0\t";}
 if(exists $ko{$_}){print OUT "Yes\t$ko{$_}\n";}else{print OUT "No\t0\n";}
}

foreach(keys %wt){$b1++; if(exists $ko{$_}){$b2++;}else{$b3++;}}
foreach(keys %ko){$c1++; if(exists $wt{$_}){$c2++;}else{$c3++;}}

print "WT-boundary: $a1\tKO-boundary: $a2\n";
print "WT-boundary: $b1\tWT-KO-overlap: $b2\tWT-specific: $b3\n";
print "KO-boundary: $c1\tWT-KO-overlap: $c2\tKO-specific: $c3\n";

close INA; close INB;
close OUT;
