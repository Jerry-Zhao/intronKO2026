#! /usr/local/perl -w

 open(INA,"Loops/MicroC_inKO_10kb.loop1.WT")||die("Can't open INA:$!\n");
 open(INB,"Loops/MicroC_inKO_10kb.loop2.KO")||die("Can't open INB:$!\n");
 open(INC,"Loops/MicroC_inKO_10kb.diffloop1.WT")||die("Can't open INC:$!\n");
 open(IND,"Loops/MicroC_inKO_10kb.diffloop2.KO")||die("Can't open IND:$!\n");
 open(OUT,">Loops/Merged_diffLoops_MicroC_inKO_10kB.xls")||die("Can't write OUT:$!\n");
##  Total- WT:7190	KO:7744	WT-diff:1943	KO-diff:2765
##  Total- Merged:12366	WT-specific:1943	KO-specific:2765	No-diff:7658



while(<INA>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+\t\w\w?\t\d+\t\d+)\t([\w\.\-]+\t[\w\.]+)$/)
 {
  if(exists $wt{$1}){print "Error1-exists: $_\n";}
  else{ $a1++; $wt{$1}=$2; $total{$1}=1;}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+\t\w\w?\t\d+\t\d+)\t([\w\.\-]+\t[\w\.]+)$/)
 {
  if(exists $ko{$1}){print "Error2-exists: $_\n";}
  else{ $a2++; $ko{$1}=$2; $total{$1}=1;}
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+\t\w\w?\t\d+\t\d+)\t([\w\.\-]+\t[\w\.]+)$/)
 {
  if(exists $wtdiff{$1}){print "Error3-exists: $_\n";}
  else{ $a3++; $wtdiff{$1}=$2;if(!exists $wt{$1}){print "Error3-not-exists: $_\n";}}
 }
 else{print "error3\t$_\n";}
}

while(<IND>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+\t\w\w?\t\d+\t\d+)\t([\w\.\-]+\t[\w\.]+)$/)
 {
  if(exists $kodiff{$1}){print "Error4-exists: $_\n";}
  else{ $a4++; $kodiff{$1}=$2; if(!exists $ko{$1}){print "Error4-not-exists: $_\n";}}
 }
 else{print "error4\t$_\n";}
}

print OUT "Chr1\tStart1\tEnd1\tChr2\tStart2\tEnd2\tFDR1\tScale1\tFDR2\tScale2\tDiff\n";
foreach (keys %total)
{
 $b1++;
 if((exists $wtdiff{$_}) and (exists $kodiff{$_})){print "Error-diff-both: $_\n";}

 if(exists $wtdiff{$_}) 
 {
  $b2++; 
  if(exists $ko{$_}) {print OUT "$_\t$wt{$_}\t$ko{$_}\tLoss in inKO\n";}
  else{print OUT "$_\t$wt{$_}\t1\t0\tLoss in inKO\n";} # only-in-WT, KO: FDR=1 Scale=0
 }
 elsif(exists $kodiff{$_}) 
 {
  $b3++; 
  if(exists $wt{$_}) {print OUT "$_\t$wt{$_}\t$ko{$_}\tGain in inKO\n";} 
  else {print OUT "$_\t1\t0\t$ko{$_}\tGain in inKO\n";} # only-in-KO, WT: FDR=1 Scale=0
 }
 else{$b4++;} # print OUT "$_\t$wt{$_}\t$ko{$_}\tBoth WT and inKO\n";}
}

print "Total- WT:$a1\tKO:$a2\tWT-diff:$a3\tKO-diff:$a4\n";
print "Total- Merged:$b1\tWT-specific:$b2\tKO-specific:$b3\tNo-diff:$b4\n";
 
close INA; close INB; close INC; close IND;
close OUT;

