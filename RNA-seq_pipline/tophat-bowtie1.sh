##

threads=40
GTF=/home/liuqb/data/index/Cotton/HAU1.0/HAU.gene.gtf
index=/home/liuqb/data/index/Cotton/HAU1.0/bowtie_index/HAU1.0_bowtie
cat $file|while read id
do
nohup tophat --library-type fr-unstranded --bowtie1 -p $threads -G $GTF --no-novel-juncs --transcriptome-index /home/liuqb/data/index/Cotton/HAU1.0/transcriptome_index/transcriptome -T -o ${id%%_*}_out $index $id &
done <$1
