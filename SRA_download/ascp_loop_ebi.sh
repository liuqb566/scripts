#!/bin/bash
#Using aspera to download SRA from EBI on for-loop modle.
#It needs two parametes:The first is a file which only one SRR ID in a row; The second is the dirctory that you want to save the output,and you bestly use absolute path
#ps:
#   ascp and the public key should be in current dictory.
#History:
#       2017-8-17 gossie releas 1


cat $1 |while read id;do echo "era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/$id/${id}_1.fastq.gz" >>SRR_pathway_list.txt;echo "era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/$id/${id}_2.fastq.gz" >>SRR_pathway_list.txt;done

cat SRR_pathway_list.txt|while read id;do ~/ascp -QT -k 2 -L ./ -l 300m -i ~/asperaweb_id_dsa.openssh $id $2;done

rm SRR_pathway_list.txt
echo "Finsh! Please check the $2"
