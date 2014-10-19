#arg 1: relative occurence of fuzzing
#arg 2: Input file
#arg 3: Output file
cat $2 | ../fuzzer/fuzzer $1 > $3



