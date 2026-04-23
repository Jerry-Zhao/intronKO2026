#! /usr/local/perl -w

open(INA,"AB_compartment/MicroC_inKO_WT1_256kb.ev.txt")||die("Can't open INA:$!\n");
open(INB,"AB_compartment/MicroC_inKO_WT2_256kb.ev.txt")||die("Can't open INB:$!\n");
open(INC,"AB_compartment/MicroC_inKO_KO1_256kb.ev.txt")||die("Can't open INC:$!\n");
open(IND,"AB_compartment/MicroC_inKO_KO2_256kb.ev.txt")||die("Can't open IND:$!\n");
open(INE,"AB_compartment/MicroC_inKO_WT_256kb.ev.txt")||die("Can't open INE:$!\n");
open(INF,"AB_compartment/MicroC_inKO_KO_256kb.ev.txt")||die("Can't open INF:$!\n");
 
open(OUT,">AB_compartment/Merged_MicroC_inKO_AB_256kb_ev.txt")||die("Can't write OUT:$!\n");

my $score=0;
 
while(<INA>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t([A|B])\t([\w\.\-]+)\t\.$/)
 {
  if(exists $wt1{$1}){print "error1-exists $1\n";}
  else
  {
   if($2 eq "A"){$score=1;}
   elsif($2 eq "B"){$score=-1;}
   else{print "error1-AB: $2\n";}
   $wt1{$1}="$2\t$3\t$score";
  }
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t([A|B])\t([\w\.\-]+)\t\.$/)
 {
  if(exists $wt2{$1}){print "error2-exists $1\n";}
  else
  {
   if($2 eq "A"){$score=1;}
   elsif($2 eq "B"){$score=-1;}
   else{print "error2-AB: $2\n";}
   $wt2{$1}="$2\t$3\t$score";
  }
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t([A|B])\t([\w\.\-]+)\t\.$/)
 {
  if(exists $ko1{$1}){print "error3-exists $1\n";}
  else
  {
   if($2 eq "A"){$score=1;}
   elsif($2 eq "B"){$score=-1;}
   else{print "error3-AB: $2\n";}
   $ko1{$1}="$2\t$3\t$score";
  }
 }
 else{print "error3\t$_\n";}
}

while(<IND>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t([A|B])\t([\w\.\-]+)\t\.$/)
 {
  if(exists $ko2{$1}){print "error4-exists $1\n";}
  else
  {
   if($2 eq "A"){$score=1;}
   elsif($2 eq "B"){$score=-1;}
   else{print "error4-AB: $2\n";}
   $ko2{$1}="$2\t$3\t$score";
  }
 }
 else{print "error4\t$_\n";}
}

while(<INE>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t([A|B])\t([\w\.\-]+)\t\.$/)
 {
  if(exists $wt{$1}){print "error5-exists $1\n";}
  else
  {
   if($2 eq "A"){$score=1;}
   elsif($2 eq "B"){$score=-1;}
   else{print "error5-AB: $2\n";}
   $wt{$1}="$2\t$3\t$score";
  }
 }
 else{print "error5\t$_\n";}
}

while(<INF>)
{
 chomp;
 if(/^(\w\w?\t\d+\t\d+)\t([A|B])\t([\w\.\-]+)\t\.$/)
 {
  if(exists $ko{$1}){print "error6-exists $1\n";}
  else
  {
   if($2 eq "A"){$score=1;}
   elsif($2 eq "B"){$score=-1;}
   else{print "error6-AB: $2\n";}
   $ko{$1}="$2\t$3\t$score";
  }
 }
 else{print "error6\t$_\n";}
}

print OUT "Chr\tStart\tEnd\t";
print OUT "WT1\tWT1_score\tWT1_value\tWT2\tWT2_score\tWT2_value\t";
print OUT "KO1\tKO1_score\tKO1_value\tKO2\tKO2_score\tKO2_value\t";
print OUT "WT\tWT_score\tWT_value\tKO\tKO_score\tKO_value\n";
foreach (keys %wt1)
{
 print OUT "$_\t$wt1{$_}\t$wt2{$_}\t$ko1{$_}\t$ko2{$_}\t$wt{$_}\t$ko{$_}\n";
}

close INA; close INB; close INC;
close IND; close INE; close INF;
close OUT;

