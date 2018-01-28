#!/bin/bash 
#Program:
# This script is used to summary fastqc results.
#History:
# 2017-2-14 gossie first release

#you should chang directory to your fastqc results dir.
#if you need decompress ZIP archive, please remove #

#ls *.zip|while read id;do unzip $id;done

grep 'fastqc$' > fastqcdir.txt

for k in $(cat fastqcdir.txt)
do
  echo $k
  grep '^Total' k | cut -f2 
done

