#! /bin/python3
#python version:>3.0
# reshape alignmet state file from 'samtools flagstate' to read easily
# the last cmd line is 'for i in *bam;do echo $i >>SLAF_alignment_stat.txt;samtools-1.6 flagstat $i >>SLAF_alignment_stat.txt;done' and the result like:
#-----
#SRR3203168.bam
#5233992 + 0 in total (QC-passed reads + QC-failed reads)
#0 + 0 secondary
#2460 + 0 supplementary
#0 + 0 duplicates
#5176304 + 0 mapped (98.90% : N/A)
#5231532 + 0 paired in sequencing
#2615766 + 0 read1
#2615766 + 0 read2
#4764008 + 0 properly paired (91.06% : N/A)
#5152854 + 0 with itself and mate mapped
#20990 + 0 singletons (0.40% : N/A)
#164296 + 0 with mate mapped to a different chr
#56877 + 0 with mate mapped to a different chr (mapQ>=5)
#SRR3203174.bam
#-----
#This also is the input file for the scripts
#History
#2017-11-5 v1 gossie

import re
with open('SLAF_alignment_stat.txt','r') as stat_f:
     print("runs","total_reas","secondary","supplementary","duplicates","total_mapped","total_mapped_ratio","paired_reads","read1","read2","properly_mapped","properly_ratio","itself_and_mate_mapped","singletons_mapped","singletons_mapped_ratio","mapped_to_dif_chr","dif_chr_mapQ<5",sep='\t')
     for line in stat_f:
         line=line.strip()
         if line.endswith('bam'):
             runs=line[0:-4]
         elif 'total' in line:
             total_reads=re.split(r'[\s\+\(]',line)[0]
         elif 'secondary' in line:
             sec_reads=line.split()[0]
         elif 'supplementary' in line:
             sup_reads=line.split()[0]
         elif 'duplicates' in line:
             dup_reads=line.split()[0]
         elif 'mapped' in line and 'N/A' in line:
             mapped_reads=re.split(r'[\s\(]',line)[0]
             total_ratio=re.split(r'[\s\(]',line)[5]
         elif 'paired in sequencing' in line:
             paired_total=line.split()[0]
         elif 'read1' in line:
             read1=line.split()[0]
         elif 'read2' in line:
             read2=line.split()[0]
         elif 'properly' in line:
             pro_reads=re.split(r'[\s\(]',line)[0]
             pro_ratio=re.split(r'[\s\(]',line)[6]
         elif 'itself and mate' in line:
             itself_mate_reads=line.split()[0]
         elif 'singletons' in line:
             singletons_reads=line.split()[0]
             singletons_ratio=re.split(r'[\s\(]',line)[5]
         elif 'chr' in line and 'mapQ' not in line:
             map_dif_chr=line.split()[0]
         elif 'mapQ' in line:
             mapQ_dif_chr=line.split()[0]
             print(runs,total_reads,sec_reads,sup_reads,dup_reads,mapped_reads,total_ratio,paired_total,read1,read2,pro_reads,pro_ratio,itself_mate_reads,singletons_reads,singletons_ratio,map_dif_chr,mapQ_dif_chr,sep='\t')
