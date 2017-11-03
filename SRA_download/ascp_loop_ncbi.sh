#!/bin/bash
#Using aspera to download SRA from NCBI on for-loop modle.
#It needs two parametes:The first is a file which only one SRR ID in a row; The second is the dirctory that you want to save the output,and you bestly use absolute path
#ps:
#   ascp and the public key should be in current dictory.
#History:
#       2017-8-17 gossie releas 1


cat $1 |while read id;do echo "anonftp@ftp-private.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/`echo $id|cut -c 1-6`/$id/$id.sra" >>SRR_pathway_list.txt;done

cat SRR_pathway_list.txt|while read id;do ~/ascp -QT -k 2 -L ./ -l 300m -i ~/asperaweb_id_dsa.openssh $id $2;done

rm SRR_pathway_list.txt
echo "Finsh! Please check the $2"
