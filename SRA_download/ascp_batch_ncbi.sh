#!/bin/bash
#Using aspera to download SRA from NCBI on batch model
#It needs two parametes: The fisrt  is a file which only one SRR ID in a row; The second is the dirctory that you want to save the output, and you best use absolute path.
#ps:
#    ascp and the public key should be in current dictory.
#History:
#       2017-8-17 gossie releas 1

cat $1 |while read id;do echo "/sra/sra-instant/reads/ByRun/sra/SRR/`echo $id|cut -c 1-6`/$id/$id.sra" >>SRR_download_list.txt;done
~/ascp -QT -k 2 -L ./ -l 300m -i ~/asperaweb_id_dsa.openssh --mode recv --host ftp-private.ncbi.nlm.nih.gov --user anonftp --file-list  ./SRR_download_list.txt $2
rm SRR_download_list.txt
echo "Finsh! Please check the $2"
