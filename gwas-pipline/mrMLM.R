
#基因型文件
Gen="num_format.txt"
#基因型文件类型,Num(numeric)、Cha(charactor)、Hmp（hapmap）
Genformat="Num"
#表型文件
Phe="pheno_all.txt"
#群体结构矩阵
PS="PopStr.csv"
#群体结构矩阵类型,Q(Q矩阵）、PCA（PCA矩阵）
Type="Q"
#分析文件
#method=c("mrMLM","FASTmrMLM","FASTmrEMMA","pLARmEB","pKWmEB","ISIS EM-BLASSO")
method="mrMLM"
#要分析第几个性状，
trait=9:38
#QTN效应计算的跨度，单位kb
Radius=100
#LOD阈值
LOD=3
#是否作图
Plot=FALSE
#输出文件夹
dir="./"


library(mrMLM)
mrMLM(fileGen=Gen,filePhe=Phe,fileKin=NULL,filePS=PS,fileCov=NULL,Genformat=Genformat,method=method,Likelihood="REML",trait=trait,SearchRadius=Radius,CriLOD=LOD,DrawPlot=Plot,dir=dir,PopStrType=Type)
