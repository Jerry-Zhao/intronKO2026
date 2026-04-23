#! /usr/local/perl -w
## get the lines for "exon" for counting

open(INA,"Nothobranchius_furzeri.Nfu_20140520.106.gtf")||die("Can't open INA:$!\n");
open(OUA,">Nothobranchius_furzeri.Nfu_20140520.106.exon_plus")||die("Can't write OUT:$!\n");
open(OUB,">Nothobranchius_furzeri.Nfu_20140520.106.exon_minus")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^(\w+)\.?\d?\t(\w+)\texon\t(\d+\t\d+)\t\.\t([+|-])\t\.\tgene_id\s+\"(\w+)\"\;.*exon_number\s+\"(\d+)\".*gene_name\s+\"([\w\.\-\(\)\,\/\[\]\|\{\}]+)\"\;.*transcript_biotype\s+\"(\w+)\"\;/)
 {
  if($8 eq "protein_coding")
  {
   if($4 eq "+"){print OUA "$5_$7_exon\t$1\t$4\t$3\n";}
   elsif($4 eq "-"){print OUB "$5_$7_exon\t$1\t$4\t$3\n";}
   else{print "error strand; $_\n";}
  }
  else{$others{$8}=1;}
 }
 ## No gene_name in GTF file
 elsif(/^(\w+)\.?\d?\t(\w+)\texon\t(\d+\t\d+)\t\.\t([+|-])\t\.\tgene_id\s+\"(\w+)\"\;.*exon_number\s+\"(\d+)\".*transcript_biotype\s+\"(\w+)\"\;/)
 {
  if($7 eq "protein_coding")
  {
   if($4 eq "+"){print OUA "$5_NoName_exon\tchr$1\t$4\t$3\n";}
   elsif($4 eq "-"){print OUB "$5_NoName_exon\tchr$1\t$4\t$3\n";}
   else{print "error strand; $_\n";}
  }
  else{$others{$7}=1;}
 }
 elsif(/^[\w\.]+\t\w+\texon\t/)
 {
  print "error exon $_\n";
 }
 else{}
}

foreach (keys %others){print "$_\n";}

close INA; close OUA; close OUB;

#Mt_tRNA
#transcribed_unprocessed_pseudogene
#IG_V_pseudogene
#non_stop_decay
#IG_V_gene
#TR_V_gene
#rRNA_pseudogene
#TR_V_pseudogene
#TEC
#retained_intron
#vaultRNA
#nonsense_mediated_decay
#processed_transcript
#IG_C_gene
#sRNA
#scaRNA
#Mt_rRNA
#IG_C_pseudogene
#ribozyme
#scRNA
#unitary_pseudogene
#TR_C_gene
#rRNA
#translated_processed_pseudogene
#IG_J_gene
#IG_D_gene
#polymorphic_pseudogene
#IG_J_pseudogene
#TR_J_pseudogene
#TR_D_gene
#TR_J_gene
#transcribed_processed_pseudogene
#pseudogene
#translated_unprocessed_pseudogene
#misc_RNA
#transcribed_unitary_pseudogene
#unprocessed_pseudogene
#processed_pseudogene
#IG_pseudogene

