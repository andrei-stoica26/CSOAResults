library(CSOA)
library(GSABenchmark)
library(hammers)
library(qs)
library(scRNAseq)
library(scuttle)
library(Seurat)

source('baron_pancreas_human.R')
source('tools.R')
source('load_seurats.R')

gsaMethods <- supportedMethods()
seuratPanc <- timeFun(runGSAMethods, seuratPanc, 'label', geneSetsPanc,
                      gsaMethods)
qsave(seuratPanc, 'seuratPancGSA.qs')

