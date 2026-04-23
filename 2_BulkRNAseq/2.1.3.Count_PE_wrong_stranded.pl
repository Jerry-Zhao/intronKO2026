#! /usr/local/perl -w

#@filenames=(
#           "LongGeneLab_N2a2021_N2a_totalRNA_cell_Rep1"
#           );
 
#@filenames=("Ceman_N2a_RNAseq_RAday0_rep1");
 
@chromo=("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chrX","chrY");

#foreach $sam (@filenames)
#{

print "Please enter the sample name: GingerasLab_8w_Cortex_rep1 \n";
chomp($sam=<STDIN>);

print "Working on File: $sam\n";

open(OUT,">count/$sam\_whole_gene_Jerry.txt")||die("Can't write OUT:$!\n");
 
my $total_reads=$overlap=$others=0;

foreach $chromosome (@chromo)
{
 open(INA,"/Users/jerry/Analysis/Genome/Ensembl_100/Mus_musculus.GRCm38.100.gtf.gene")||die("Can't open INA:$!\n");
 open(INC,"/Users/jerry/Analysis/Split/$sam\.sam.$chromosome")||die("Can't open INC:$!\n");
 
 print "Working on chromosome: $chromosome\n";

 while(<INA>)
 {
  chomp;
  if(/^(chr\w+)\:(\d+)-(\d+):([\w\.\-\(\)]+):(\w+):([+|-])\t\d+$/)
  {
   if($1 eq $chromosome)
   {
    $gene_id="$1:$2-$3:$4:$5:$6";
    $count{$gene_id}=0;
    
    if($6 eq "+")
    {
     for($i=$2;$i<=$3;$i++)
     {
      if(exists $plus{$i}){$plus{$i}.=";;$gene_id";} ## overlaped regions, more gene IDs
      else{$plus{$i}=$gene_id;}
     }
    }
    elsif($6 eq "-")
    {
     for($i=$2;$i<=$3;$i++)
     {
      if(exists $minus{$i}){$minus{$i}.=";;$gene_id";} ## overlaped regions, more intron IDs
      else{$minus{$i}=$gene_id;}
     }
    }
    else{print "error Strand: $_\n";}
    
   }
  }
  else{print "error1\t$_\n";}
 }


 while(<INC>)
 {
  chomp;
  if(/^([\w\.\:\-]+)\t(\d+)\t(\w\w?)\t(\d+)\t\d+\t(\w+)\t\=/)
  {

  ### Right strand-specific: + 99/147;  - 163/83
#  if(($2 == 99) or ($2 == 147)){$str="plus"; $overlap="plus_over";}
#  elsif(($2 == 163) or ($2 == 83)){$str="minus"; $overlap="minus_over";}
#  else{print "error Strand-FLAG: $_\n";}

  ### Wrong strand-specific RNA-seq, reads mapped to gene opposite strand 
   if(($2 == 99) or ($2 == 147)){$str="minus";}
   elsif(($2 == 163) or ($2 == 83)){$str="plus";}
   else{print "error Strand-FLAG: $_\n";}

  
   $read_id=$1;
   $chr="chr$3";   ## read mapping chromosome
   if($chr ne $chromosome){print "error wrong sam-chr: $_\n";}

   $start=$4;             ## read mapping start

   $cigar=$5; ## using this to define the end position of the read
    ## M: match   
    ## I: read has insertion compared to the reference genome; no use for gene count
    ## D: read has deletion compared to the genome; useful
    ## H: hard clip of the reads; no use
    ## S: soft clip of the read;  no use
    ## N: skipped region of the genome; useful, intron region
    ## 
    ## End = Start + Ms + Ns + Ds.          

   if(($2 == 99) or ($2 == 163)) ## first of the pair
   {
    $total_reads++; ## total reads
    print "Processes lines: $total_reads\n" if($total_reads%1000000==0);

    $label=0; ## first of the pair  
    while($cigar=~/(\d+)([A-Z])/g) 
    {
     if($2 eq "M")
     {
      for ($j=$start; $j<=($start+$1-1); $j++)
      {
       if(exists $$str{$j}) ## read overlap with gene
       {
        $label=1;
        if(exists $name{$read_id}) ## this read already overlap with gene
        {
         if($name{$read_id} =~ /$$str{$j}/){} ## already this gene ID
         else{$name{$read_id}.=";;$$str{$j}";} ## add this gene ID to this reads
        }
        else{$name{$read_id}=$$str{$j};} ## First gene overlap with this read
       }
      }
      $start=$start+$1; ## End of this match 
     }
     elsif(($2 eq "D") or ($2 eq "N")){$start=$start+$1;}## Add the insertion region
    }
   }

   if(($2 == 147) or ($2 == 83)) ## second of the pair
   {
    if(($label==1) or ($label==0)) ## first of this pair--uniquely mapped to a gene; or not overlaped with gene(maybe intron)
    {
     while($cigar=~/(\d+)([A-Z])/g)
     {
      if($2 eq "M")
      {
       for ($j=$start; $j<=($start+$1-1); $j++)
       {
        if(exists $$str{$j}) ## read overlap with gene
        {
         $label=1;
         if(exists $name{$read_id}) ## this read already overlap with gene
         {
          if($name{$read_id} =~ /$$str{$j}/){} ## already this gene ID
          else{$name{$read_id}.=";;$$str{$j}";} ## add this gene ID to this reads
         }
         else{$name{$read_id}=$$str{$j};} ## First gene overlap with this read
        }
       }
       $start=$start+$1; ## End of this match 
      }
      elsif(($2 eq "D") or ($2 eq "N")){$start=$start+$1;}## Add the insertion region
     }
    }
 
    if($label==0){$non_overlap++;}
    elsif($label==1) ## pair mapped to intron
    {
     $overlap++;
 
     @arraylist=split(/;;/,$name{$read_id});
     foreach (@arraylist){$tmphash{$_}=0;}
     @newlist=keys %tmphash;
     
     foreach (@newlist){$count{$_}++;};
    }
    else{$others++;}
  
    delete $name{$read_id}; ## delete information of this reads from HASH
    foreach (keys %tmphash){delete $tmphash{$_};}
   }
  }
  else{print "error2\t$_\n";}
 }

 foreach (keys %count){print OUT "$_\t$count{$_}\n"; $result++; delete $count{$_};}
 foreach (keys %plus){delete $plus{$_};}
 foreach (keys %minus){delete $minus{$_};}
  
 close INA; close INC;
}

print OUT "####  Total-reads:  $total_reads\n";
print OUT "####  unique-overlap: $overlap\n";
print OUT "####  Non-overlap: $non_overlap\n";

print "Total-reads: $total_reads\noverlap: $overlap\n";
print "Non-overlap: $non_overlap\nOthers: $others\n";
 
print "Result gene ID: $result\n";

close INA;
close OUT;
#}


