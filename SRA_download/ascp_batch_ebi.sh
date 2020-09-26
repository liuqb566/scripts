#!/bin/bash
#Using aspera to download SRA from EBI on batch model
#It needs two parametes: The fisrt  is a file which only one SRR ID in a row; The second is the dirctory that you want to save the output, and you best use absolute path.
#ps:
#    ascp and the public key should be in current dictory.
#History:
#       2017-8-17 gossie releas 1
<<<<<<< HEAD
# 2020-6-8 gossie v2

while read id
do
echo "/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/${id}" >>SRR_download_list.txt
done<$1
ascp -QT -k1 -l 300m -P33001 -i ~/miniconda3/envs/sra_download/etc/asperaweb_id_dsa.openssh  --mode recv --host fasp.sra.ebi.ac.uk --user era-fasp --file-list  ./SRR_download_list.txt ./
=======

cat $1 |while read id;do echo "/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/${id}_1.fastq.gz" >>SRR_download_list.txt;echo "/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/${id}_2.fastq.gz" >>SRR_download_list.txt;done
~/ascp -QT -k 2 -L ./ -l 300m -i ~/asperaweb_id_dsa.openssh --mode recv --host fasp.sra.ebi.ac.uk --user era-fasp --file-list  ~/SRR_download_list.txt $2
rm SRR_download_list.txt
echo "Finsh! Please check the $2"
>>>>>>> ce752dede0d945ae2e8e2c9a19902f899e223fdb
