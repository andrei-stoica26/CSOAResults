library(scRNAseq)
library(Seurat)
library(scLang)
library(CSOA)
library(ggplot2)
library(henna)
library(eulerr)
library(ggplotify)
library(patchwork)

source('tools.R')
source('visualization_abstract_utils.R')
source('visualization_abstract.R')

ABS_TEXT_SIZE <- 7

seuratPanc <- qs_read('seuratPanc.qs2')
acinarMarkers <- c('KLK1', 'CTRC', 'PNLIP',
                   'CELA3A','SPINK1',
                   'CELA2A', 'CPB1',
                   'PNLIPRP1', 'CPA2','CPA1', 'CELA3B',
                   'PLA2G1B', 'CLPS', 'SYCN')
mat <- scExpMat(seuratPanc, genes=acinarMarkers)


#1
cellSets <- percentileSets(mat)
geneFreqs <- lengths(cellSets)
df <- data.frame(Gene = names(geneFreqs),
                 nCells = geneFreqs)
p1 <- geneCellCountPlot(df, 'deepskyblue',
                        paste0('1. For each signature gene, extract the set',
                               ' of cells\nthat highly express the gene'))

#2
eulerInput <- cellSets[1:2]
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
p5 <- overlapCutoffPlot(overlapDF, paste0(
    '5. Set the cutoff for selecting top\n',
    'overlaps based on rank frequencies'),
    hullWidth=0.2,
    pointSize=0.5) +
    theme(axis.ticks=element_blank(),
          axis.text=element_blank(),
          axis.title=element_text(size=ABS_TEXT_SIZE,
                                  color='black'),
          plot.title=element_text(size=ABS_TEXT_SIZE,
                                  color='black'),
          legend.text=element_text(size=ABS_TEXT_SIZE - 1,
                                   color='black'),
          legend.key.size=unit(0.2, 'cm'))

#6
firstOutRawRank <- CSOA:::prepareFiltering(overlapDF)
overlapDF <- CSOA:::filterOverlaps(overlapDF, firstOutRawRank)
overlapDF <- CSOA:::scoreOverlaps(overlapDF, 'log')
df <- overlapDF[, c('rank', 'score')]
p6 <- rankScorePlot(df, paste0('6. Map distinct overlap ranks to',
                         ' scores decreasing\nlogaritmically from 1 towards 0'))

#7
normExp <- kerntools::minmax(mat[acinarMarkers, ], rows=TRUE)
pairScores <- CSOA:::computePCPairScores(overlapDF, normExp)
p7 <- basicHeatmap(as.matrix(pairScores), title = paste0(
    '7. Compute per-cell gene pair scores by multiplying\n',
    ' overlap scores with the min-max-normalized\n',
    ' expression of the two genes'))
p7 <- p7 + theme(axis.text.y=element_blank(),
                 axis.title=element_text(size=ABS_TEXT_SIZE),
                 plot.title=element_text(size=ABS_TEXT_SIZE),
                 legend.title=element_blank(),
                 legend.text=element_text(size=ABS_TEXT_SIZE - 1),
                 legend.key.size=unit(0.2, 'cm'))+
    labs(x = 'Cell', y = 'Gene pair score')

#8
seuratPanc <- runCSOA(seuratPanc, list(CSOA_acinar=acinarMarkers))
p8 <- featurePlot(seuratPanc, 'CSOA_acinar', paste0('8. Sum all gene pair scores in each cell and ',
                  ' min-max-normalize\nthe results to',
                  ' obtain the CSOA score')) +
    theme(axis.title=element_text(size=ABS_TEXT_SIZE),
          axis.text=element_text(size=ABS_TEXT_SIZE),
          plot.title=element_text(size=ABS_TEXT_SIZE),
          legend.title=element_text(size=ABS_TEXT_SIZE - 1),
          legend.text=element_text(size=ABS_TEXT_SIZE - 1),
          legend.key.size=unit(0.2, 'cm'))

plots <- list(p1, p2, p3, p4, p5, p6, p7, p8)

p <- (plots[[1]] | plots[[2]] ) / (plots[[3]] | plots[[4]]) /
    (plots[[5]] | plots[[6]]) / (plots[[7]] | plots[[8]]) +
    plot_annotation(tag_levels='A',
                    theme=theme(plot.title=element_text(size=ABS_TEXT_SIZE - 1, hjust=-0.5, vjust=-0.5)))
devPlot(p)
