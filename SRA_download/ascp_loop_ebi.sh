#!/bin/bash
#Using aspera to download SRA from EBI on for-loop modle.
#It needs two parametes:The first is a file which only one SRR ID in a row; The second is the dirctory that you want to save the output,and you bestly use absolute path
#ps:
#   ascp and the public key should be in current dictory.
#History:
#       2017-8-17 gossie releas 1

<<<<<<< HEAD
# 2020-6-8 gossie v2
##用conda install -c hcc aspera-cli安装了aspera,安装环境sra_download
## which ascp查看key的目录


while read id
do
echo "ascp -QT -k1 -l 300m -P33001 -i ~/miniconda3/envs/sra_download/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/$id/${id}_1.fastq.gz ./" >>SRA_download.cm
echo "ascp -QT -k1 -l 300m -P33001 -i ~/miniconda3/envs/sra_download/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/$id/${id}_2.fastq.gz ./" >>SRA_download.cm
done <$1

nohup bash SRA_download.cm &

#rm SRR_pathway_list.txt
=======

cat $1 |while read id;do echo "era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/$id/${id}_1.fastq.gz" >>SRR_pathway_list.txt;echo "era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/`echo $id|cut -c 1-6`/00`echo $id|cut -c 10`/$id/${id}_2.fastq.gz" >>SRR_pathway_list.txt;done

cat SRR_pathway_list.txt|while read id;do ~/ascp -QT -k 2 -L ./ -l 300m -i ~/asperaweb_id_dsa.openssh $id $2;done

rm SRR_pathway_list.txt
echo "Finsh! Please check the $2"
>>>>>>> ce752dede0d945ae2e8e2c9a19902f899e223fdb
