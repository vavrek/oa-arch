#!/usr/bin/perl

# Modified Hybrid quick-lm.pl / simple-lm.pl - Create Language Model & Dictionary

# By Ricky Houghton, Alex Hauptmann, Alexander Rudnicky, Andrew Vavrek

# Begin quick-lm.pl - Create Language Model

use Getopt::Std;

$VERBOSE = 1;

sub handler { local($sig) = @_;
	      print STDERR "quick_lm caught a SIG$sig -- dying\n";
	      exit(0);
	    }
foreach (qw(XCPU KILL TERM STOP)) { $SIG{$_} = \&handler; }

if ($#ARGV < 0) { die("usage: quick-lm.pl -s <sentence_file> [-w <word_file>] [-d discount]\n"); }
Getopt::Std::getopts("s:w:d:x");

$sentfile = $opt_s;
$wordfile = $opt_w;
$discount = $opt_d;

$| = 1;  # Always Flush Buffers

if ($VERBOSE>0) {print STDERR "Language model started at ",scalar localtime(),"\n";}

open(IN,"$sentfile") or die("can't open $sentfile!\n");
if ($wordfile ne "") { open(WORDS,"$wordfile"); $wflag = 1;} else { $wflag = 0; }

$log10 = log(10.0);

if ($discount ne "") {
  if (($discount<=0.0) or ($discount>=1.0)) {
    print STDERR "\discount value out of range: must be 0.0 < x < 1.0! ...using 0.5\n";
    $discount_mass = 0.5;  # Use Default
  } else {
    $discount_mass = $discount;
  }
} else {
  $discount_mass = 0.5;  # 0.5 Is Best Nominal Discount
}

$deflator = 1.0 - $discount_mass;

# Create Count Tables
$sent_cnt = 0;
while (<IN>) {	 
  s/^\s*//; s/\s*$//;
  if ( $_ eq "" ) { next; } else { $sent_cnt++; } # Skip Empty Lines
  @word = split(/\s/);    
  for ($j=0;$j<($#word-1);$j++) {	
    $trigram{join(" ",$word[$j],$word[$j+1],$word[$j+2])}++;
    $bigram{ join(" ",$word[$j],$word[$j+1])}++;
    $unigram{$word[$j]}++;
  }
  # Complete Bigrams And Unigrams At End Of Sentence
  $bigram{join(" ",$word[$j],$word[$j+1])}++;
  $unigram{$word[$j]}++;
  $unigram{$word[$j+1]}++;
}

close(IN);
if ($VERBOSE) { print STDERR "$sent_cnt sentences found.\n"; }

# Add Words
if ($wflag) {
  $new = 0; $read_in = 0;
  while (<WORDS>) {
    s/^\s*//; s/\s*$//;
    if ( $_ eq "" ) { next; }  else { $read_in++; }  # Skip Empty Lines
    if (! $unigram{$_}) { $unigram{$_} = 1; $new++; }
  }
  if ($VERBOSE) { print STDERR "tried to add $read_in word; $new were new words\n"; }
  close (WORDS);
}
if ( ($sent_cnt==0) && ($new==0) ) {
  print STDERR "no input?\n";
  exit;
}

# Create Language Model 
open(LM,">$sentfile.lm") or die("can't open $senfile.lm for output!\n");

# Compute Counts
$unisum = 0; $uni_count = 0; $bi_count = 0; $tri_count = 0;
foreach $x (keys(%unigram)) { $uni_count++; $unisum += $unigram{$x}; }
foreach $x (keys(%bigram))  { $bi_count++; }
foreach $x (keys(%trigram)) { $tri_count++; }

print LM $preface;
print LM "\\data\\\n";
print LM "ngram 1=$uni_count\n";
if ( $bi_count > 0 ) { print LM "ngram 2=$bi_count\n"; }
if ( $tri_count > 0 ) { print LM "ngram 3=$tri_count\n"; }
print LM "\n";

# Compute Unigram Probabilities
foreach $x (keys(%unigram)) {
  $uniprob{$x} = ($unigram{$x}/$unisum) * $deflator;
}

# Compute Alphas
foreach $y (keys(%unigram)) {
  $w1 = $y;
  $sum_denom = 0.0;
  foreach $x (keys(%bigram)) {
    if ( substr($x,0,rindex($x," ")) eq $w1 ) {
      $w2 = substr($x,index($x," ")+1);
      $sum_denom += $uniprob{$w2};
    }
  }
  $alpha{$w1} = $discount_mass / (1.0 - $sum_denom);
}

print LM "\\1-grams:\n";
foreach $x (sort keys(%unigram)) {
  printf LM "%6.4f %s %6.4f\n", log($uniprob{$x})/$log10, $x, log($alpha{$x})/$log10;
}
print LM "\n";

# Compute Bigram Probabilities
foreach $x (keys(%bigram)) {
  $w1 = substr($x,0,rindex($x," "));
  $biprob{$x} = ($bigram{$x}*$deflator)/$unigram{$w1};
}

# Compute Bialphas
foreach $x (keys(%bigram)) {
  $w1w2 = $x;
  $sum_denom = 0.0;
  foreach $y (keys(%trigram)) {
    if (substr($y,0,rindex($y," ")) eq $w1w2 ) {
      $w2w3 = substr($y,index($y," ")+1);
      $sum_denom += $biprob{$w2w3};
    }
  }
  $bialpha{$w1w2} = $discount_mass / (1.0 - $sum_denom);
}

# Output Bigrams And Trigrams
if ( $bi_count > 0 ) {
  print LM "\\2-grams:\n";
  foreach $x (sort keys(%bigram)) {
    printf LM "%6.4f %s %6.4f\n",
      log($biprob{$x})/$log10, $x, log($bialpha{$x})/$log10;
  }
  print LM "\n";
}

if ($tri_count > 0 ) {
  print LM "\\3-grams:\n";
  foreach $x (sort keys(%trigram)) {
    $w1w2 = substr($x,0,rindex($x," "));
    printf LM "%6.4f %s\n",
      log(($trigram{$x}*$deflator)/$bigram{$w1w2})/$log10, $x;
  }
  print LM "\n";
}

print LM "\\end\\\n";
close(LM);

if ($VERBOSE>0) { print STDERR "Language model completed at ",scalar localtime(),"\n"; }

# End quick-lm.pl

# Begin simple-lm.pl - Create Dictionary

use Cwd qw();
my $working_dir = Cwd::cwd();
print "Working directory: $working_dir \n";

$CMU_DICT = "cmudict"; # Name Of CMU Dictionary
$OUTPUT_NAME = "new"; # Name Of Temporary Output Files
$NUM_WORDS_TO_KEEP = 3000;  # Maximum Size Of Dictionary
$INPUT_TEXT = "commands.txt"; # Name Of Input Text File
$BIN_DIR = "/usr/bin"; # Location Of cmuclmtk Tools

$input_text = $INPUT_TEXT unless shift;
$output_name = $OUTPUT_NAME unless shift;
$language_dir = "$working_dir/minds/stella/language";
$lm_name = "language-model";
$dic_name = "dictionary";

print "Language directory: $language_dir\n";

chdir ("$language_dir") || die "Can't find language directory: ($language_dir)";

# Create Context Cue .ccs File
if (! -s "ccs.ccs") {
    open CCS,">ccs.ccs";
    print CCS "<s>";
    close CCS; 
}

print "Creating ${input_text}.ccs \n";

# Text Cleaning & Context Cue Formatting
system ("sed -f $language_dir/remove-punctuation.sed < $input_text | tr \"[A-Z]\" \"[a-z]\" | tr -d \'\\r\' | sed \'s/\\,/ /g\' | sed \'s/\\./ /g\' | gawk \' \$1 != \"\" { print \"<s>\", \$0, \"</s>\"; } ' > $input_text.ccs");

# Create .wfreq File
print "Creating ${input_text}.wfreq \n";

system ("cat $input_text.ccs | $BIN_DIR/text2wfreq > $input_text.wfreq");

# Create .vocab File
print "Creating ${input_text}.vocab \n";

system ("cat $input_text.wfreq | $BIN_DIR/wfreq2vocab -top $NUM_WORDS_TO_KEEP | tail +5 | grep -i \"[a-z]\" > $output_name.vocab");

# Create .dic File
print "Creating $output_name.dic \n";

open OUTPUT,">$output_name.dic";

open DICT,"$CMU_DICT"|| die "Cannot find CMU dictionary: ($CMU_DICT) \n";
@dict = <DICT>;
close DICT;

# Create Hash Of Dictionary Entries
for (@dict) { 
  /(\S+)\s+(.*)$/;
  $d{lc($1)} = $2;
}

open VOCAB,"$output_name.vocab";

while (<VOCAB>) {
  chomp;
  if ($d{$_}) {
    printf OUTPUT "%-30s$d{$_}\n",$_;
      
    # Dictionary might contain multiple pronunciations of the same
    # word. Each version has a (counter) appended to the word e.g. 
    # WITH                      W IH DH
    # WITH(2)                   W IH TH
    # WITH(3)                   W IX DH
    # WITH(4)                   W IX TH

    $i=2;     
    while ($dup = $d{"$_($i)"}) {
      printf OUTPUT "%-30s$dup\n","$_($i)";
      $i++;
    }
  }
}

close VOCAB;
close OUTPUT;

# End simple-lm.pl

# Rename Language Model, Dictionary, Remove Working Files

system ("mv $sentfile.lm $language_dir/$lm_name");

system ("mv $output_name.dic $language_dir/$dic_name");

system ("rm *.ccs *.wfreq *.vocab");

sleep (8)