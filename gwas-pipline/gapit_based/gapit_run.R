#!/usr/bin/Rscript --vanilla

# 注意 Rscript 的版本。
# 注意内存
# history：
#    2017-12-26 v1 Gossie
#==============================================================================================================================================
# 工作目录
workspace="~/workspace/research/chl_数据处理/355材料/GWAS_355/gapit_based"
# 表型数据，有表头，第一列是材料名
phedata <- "phenotye.txt"
# 基因型数据，hapmap 格式
gendata <- "geno0.4_maf0.05.hmap.txt"
# PCA 数量
PCs=2
# gapit 包地址，URL或者本地地址
#gapit_path="http://zzlab.net/GAPIT/gapit_functions.txt"
gapit_path="/home/liuqibao/workspace/scripts/gwas-pipline/gapit_based/gapit_functions.txt"
# emma 依赖包越来越，URL或者本地地址
#emma_path="http://zzlab.net/GAPIT/emma.txt"
emma_path="/home/liuqibao/workspace/scripts/gwas-pipline/gapit_based/emma.txt"
#==============================================================================================================================================

setwd(workspace)
# 安装软件包，除了 multtest 包，其它也可以通过 install.packags 安装，但是可能会很慢，且易出错
#source("http://www.bioconductor.org/biocLite.R")
#BiocLite(pkgs=c("multtest","gplots","LDheatmap","genetics","ape","EMMREML","scatterplot3d"))

# 加载包
library(multtest)
library(gplots)
library(LDheatmap)
library(genetics)
library(ape)
library(EMMREML)
library(compiler) #this library is already installed in R
library(scatterplot3d)

# 加载 gapit 包和emma依赖包，可以连网加载，也可以下载到本地再加载
#source("http://zzlab.net/GAPIT/gapit_functions.txt")
#source("http://zzlab.net/GAPIT/emma.txt")
source(gapit_path)
source(emma_path)

myY <- read.table(phedata,header=1)
# hapmap 格式有 header，但是在读取的时候参数还是 header=FALSE；numeric 格式不同，参数 header=TRUE
myG  <- read.table(gendata,header=FALSE)
# 简单应用
mygapit <- GAPIT(Y=myY,G=myG,PCA.total=PCs)

