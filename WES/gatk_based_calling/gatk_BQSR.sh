#gatk4
#参考基因组
Ref=~/data/genome/Cotton/HAU1.0/HAU_genome.fa
#已知SNP位点，也要index：gatk IndexFeatureFile -I snp_hardfiltered_355_biallelic_maf0.2_ms1.vcf
Knowsites=~/data/resequencing_HAU1.0_lilibei/snp_hardfiltered_355_biallelic_maf0.2_ms1.vcf
while read id
do
gatk BaseRecalibrator -I ${id}.merged.sorted.dedup.bam -R ${Ref} --known-sites ${Knowsites} -O ${id}.table 
gatk ApplyBQSR -R ${Ref} -I ${id}.merged.sorted.dedup.bam --bqsr-recal-file ${id}.table -O ${id}.merged.sorted.dedup.bqsr.bam
done < $1
