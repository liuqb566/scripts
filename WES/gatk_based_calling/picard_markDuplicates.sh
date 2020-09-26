while read id
do
#nohup \
picard MarkDuplicates I=${id}.merged.sorted.bam O=${id}.merged.sorted.dedup.bam M=${id}.Marked_dup_metrics.txt \
#&
done < $1
