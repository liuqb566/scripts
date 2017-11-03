#!/bin/bash

#extract p value from gemma results
#PS:
#   Because gemma would excute some SNP when there are phenotype missing, Please be carful for the numbers of output files.

#提取前三列，分别为chr,snp,ps
cut -f1,2,3 spad_1.assoc.txt >tmp.txt

for i in `seq 1 12`
do
echo 'spad_'$i'.assoc.txt'
cut -f11 'spad_'$i'.assoc.txt' >p_value.txt
paste tmp.txt p_value.txt >tmp2.txt
mv tmp2.txt tmp.txt
rm p_value.txt
echo 'spad_'$i'.assoc.txt is ok'
done
