#! usr/local/perl -w
## get the intron regions on plus-stand genes

print "Please enter the Species file name: e.g. Homo_sapiens.GRCh38.100 (no .gtf)\n";
chomp($name=<STDIN>);

print "Please enter the species names: e.g. human  mosue fruitfly \n";
chomp($nickname=<STDIN>);
  
open(INA,"$name.plus_intron")||die("Can't open IN:$!\n");
open(INB,"$name.minus_intron")||die("Can't open IN:$!\n");
open(OUT,">Intron_lengths_$name.xls")||die("Can't write OUT:$!\n");

print OUT "ID\tStrand\tLength\tName\n";
while(<INA>)
{
 chomp;
 if(/^\w+\:(\d+)-(\d+):[\w\.\-\(\)\[\]\/]+intron\d+\t\+$/)
 {
  $length=$2-$1+1; 
  print OUT "$_\t$length\t$nickname\n";
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^\w+\:(\d+)-(\d+):[\w\.\-\(\)\[\]\/]+intron\d+\t\-$/)
 {
  $length=$2-$1+1; 
  print OUT "$_\t$length\t$nickname\n";
 }
 else{print "error1\t$_\n";}
}

close INA; close INB;
close OUT;


