#!/bin/bash
#The script can extract and transform a gemma result to CMplot format one by one.
#There is no header in output file,but the four columns are SNP, chromesome, positon and p value. 
ls *.assoc.txt|while read id
do
cut -f2 $id|sed 1d >2th_col.txt
python3 chr_replace.py 2th_col.txt
cut -f3,11 $id|sed 1d |paste result.txt - >cmplot.$id
rm 2th_col.txt
rm result.txt
done


