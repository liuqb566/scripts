此文件夹收集了用 gemma 时行 GWAS 分析中用到的脚本

#由于 line 的排序比较乱，所以加表型的时候得重新排序
add_phe_to_fam.sh

# 运行 gemma
gemma_run.sh

# 将结果整理成 CMplot 格式
transform_gemma_result_to_cmplot_formate.sh
# 用 CMplot 画图：Manhattan、SNP density、QQplot
CMplot_manhattan.R

# 抽取显著 SNP
filter_signaficant_snp.py

