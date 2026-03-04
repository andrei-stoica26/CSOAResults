library(scRNAseq)
library(Seurat)
library(scLang)
library(CSOA)
library(ggplot2)
library(henna)
library(eulerr)
library(ggplotify)

source('tools.R')
source('visualization_abstract_utils.R')

seuratObj <- as.Seurat(BaronPancreasData('human'), data=NULL)
seuratObj <- processSeurat(seuratObj, minFeatCells=5)

DimPlot(seuratObj, group.by='label')

acinarMarkers <- c('KLK1', 'CTRC', 'PNLIP',
                   'CELA3A','SPINK1',
                   'CELA2A', 'CPB1',
                   'PNLIPRP1', 'CPA2','CPA1', 'CELA3B',
                   'PLA2G1B', 'CLPS', 'SYCN')

mat <- scExpMat(seuratObj, genes=acinarMarkers)
cellSets <- percentileSets(mat)
geneFreqs <- lengths(cellSets)
df <- data.frame(Gene = names(geneFreqs),
                 nCells = geneFreqs)

geneCellCountPlot(df, 'deepskyblue',
                  paste0('1. For each signature gene, extract the set',
                         ' of cells\nthat highly express the gene'))

eulerInput <- c(list(Cells = colnames(seuratObj)), cellSets[1:2])
eulerPlot(eulerInput, '2. Assess cell set pairwise overlaps',
          ' using hypergeometric tests')

#4: Replace network plot with a vertical bar plot ranking the overlaps
