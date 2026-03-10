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
source('visualization_abstract_new.R')

ABS_TEXT_SIZE <- 10

seuratObj <- qs_read('seuratPancGSA.qs2')
acinarMarkers <- c('KLK1', 'CTRC', 'PNLIP',
                   'CELA3A','SPINK1',
                   'CELA2A', 'CPB1',
                   'PNLIPRP1', 'CPA2','CPA1', 'CELA3B',
                   'PLA2G1B', 'CLPS', 'SYCN')
mat <- scExpMat(seuratObj, genes=acinarMarkers)


#1
cellSets <- percentileSets(mat)
geneFreqs <- lengths(cellSets)
df <- data.frame(Gene = names(geneFreqs),
                 nCells = geneFreqs)
p1 <- geneCellCountPlot(df, 'deepskyblue',
                        paste0('1. For each signature gene, extract the set',
                               ' of cells\nthat highly express the gene'))

#2
eulerInput <- c(list(Cells = colnames(seuratObj)), cellSets[1:2])
p2 <- eulerPlot(eulerInput, paste0('2. Assess cell set pairwise overlaps',
                                   ' using hypergeometric tests'))

#3
overlapDF <- generateOverlaps(mat)
overlapDF <- CSOA:::prefilterOverlaps(overlapDF)
overlapDF <- overlapDF[order(overlapDF$pvalAdj), ]
overlapDF$pvalRank <- rank(overlapDF$pvalAdj, ties.method='min')
overlapDF <- overlapDF[order(overlapDF$ratio,
                             decreasing=TRUE), ]
overlapDF$ratioRank <- rank(-overlapDF$ratio, ties.method='min')

df <- overlapDF[, c('pvalRank', 'ratioRank')]
df$globalRank <- rowMeans(df)
df <- df[order(df$globalRank), ]
df$globalRank <- rank(df$globalRank, ties.method='min')
prerankDF <- do.call(rbind, apply(df, 1, function(x)
    data.frame(globalRank = rep(x[3], 2),
               rank = c(x[1], x[2]),
               rankType = c('p-value rank',
                            'Ratio rank'))))
prerankDF$overlap <- seq(nrow(prerankDF))
p3 <- prerankPlot(prerankDF,
            paste0('3. Rank the overlaps based on adjusted p-value\n',
                              'and observed-over-expected size ratio'))
#4
geneConn <- CSOA:::geneBestEdgeRank(overlapDF)
overlapDF$pvalRank <- (geneConn[overlapDF$gene1, 1] +
                           geneConn[overlapDF$gene2, 1]) / 2
overlapDF$ratioRank <- (geneConn[overlapDF$gene1, 2] +
                            geneConn[overlapDF$gene2, 2]) / 2
overlapDF$rawAggRank <- (overlapDF$pvalRank +
                             overlapDF$ratioRank) / 2
overlapDF <- overlapDF[order(overlapDF$rawAggRank), ]

df <- overlapDF[, c('pvalRank', 'ratioRank', 'rawAggRank')]
colnames(df)[3] <- 'globalRank'
prerankDF <- do.call(rbind, apply(df, 1, function(x)
    data.frame(globalRank = rep(x[3], 3),
               rank = x,
               rankType = c('p-value rank',
                            'Ratio rank',
                            'Raw aggregate rank'))))
prerankDF$overlap <- seq(nrow(prerankDF))

p4 <- prerankPlot2(prerankDF,
            paste0('4. Adjust the ranks based on connectivity and',
                   ' average\nthe new ranks to obtain the aggregate rank'))

#5
overlapDF$rank <- rank(overlapDF$rawAggRank, ties.method='min')
overlapCutoffPlot(overlapDF, paste0('5. Set the cutoff for selecting top\n',
                                    'overlaps based on rank frequencies'))

#6
firstOutRawRank <- CSOA:::prepareFiltering(overlapDF)
overlapDF <- CSOA:::filterOverlaps(overlapDF, firstOutRawRank)
overlapDF <- CSOA:::scoreOverlaps(overlapDF, 'log')
df <- overlapDF[, c('rank', 'score')]
rankScorePlot(df, paste0('6. Map distinct overlap ranks to',
                         ' scores decreasing\nlogaritmically from 1 towards 0'))
