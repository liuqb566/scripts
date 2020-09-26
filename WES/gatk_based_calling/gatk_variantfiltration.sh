gatk=/home/liuqb/tools/gatk-4.1.0.0/gatk
# gz格式需要用tabix索引
vcf=snps.vcf.gz
out_prefix=snp_hardfiltereannotated
#-filter "SOR > 3.0" --filter-name "SOR3" 该参数很多文章没有用到，此处也不用。可能受测序深度影响大。
$gatk VariantFiltration \
    -V $vcf \
    -filter "QD < 2.0" --filter-name "QD2" \
    -filter "QUAL < 30.0" --filter-name "QUAL30" \
    -filter "FS > 60.0" --filter-name "FS60" \
    -filter "MQ < 40.0" --filter-name "MQ40" \
    -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
    -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
    -O ${out_prefix}.vcf.gz
