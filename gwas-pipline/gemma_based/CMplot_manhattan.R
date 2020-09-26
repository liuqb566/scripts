#!/usr/bin/Rscript --vanilla
# 需要先安装 CMplot 包
# 注意: 与 shell 脚本不同，R 脚本运行过程中，不能修改运行脚本

# 工作目录路径
workspace <- "~/workspace/research/chl_数据处理/355材料/GWAS_355/SLAF_ms_0.4/浓度_result_3std_ms_0.4_maf_0.05"
# CMplot 格式文件：SNP、CHR、PS、Phe...
input <- "/home/liuqibao/workspace/research/chl_数据处理/355材料/GWAS_355/SLAF_ms_0.4/浓度_result_3std_ms_0.4_maf_0.05/浓度_pvalue_ms0.4_maf0.05.txt"
#CMplot 参数
#颜色
col <- c("dodgerblue1","darkgoldenrod1")
#Manhattan 图类型：m（方形），c（圆形），q（QQ图），d（SNP 标记密度图）
type <- c("m","q")
# 阈值线:0.01, 0.05, 0.1, 1等，或者c(0.01,0.05)同时画多条
thsh <- 1

library(CMplot)
setwd(workspace)
pvalue <- read.table(input,header = 1)
for(i in 4:dim(pvalue)[2]){CMplot(pvalue[c(1:3,i)],col= col,plot.type = type,threshold = thsh)}

# 画 SNP 标记密度，一次就可以
#CMplot(pvalue[1:4],plot.type = "d")
