source('load_all.R')
source('visualization_abstract_utils.R')
source('visualization_abstract.R')

ABS_TEXT_SIZE <- 12

################################################################################

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
p1 <- geneCellCountPlot(df, 'deepskyblue')

#2
vennInput <- setNames(c(cellSets[1:2], list(colnames(seuratPanc))),
                      c('Cell set 1',
                      'Cell set 2',
                      ''))
p2 <- ggvenn(vennInput,
             fill_color=c('red', 'yellow'),
             fill_alpha=0.8,
             text_size = 5,
             stroke_size = 0.3,
             show_percentage = FALSE,
             set_name_size = 5)

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
p3 <- prerankPlot(prerankDF)

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

p4 <- prerankPlot2(prerankDF)

#5
overlapDF$rank <- rank(overlapDF$rawAggRank, ties.method='min')
p5 <- overlapCutoffPlot(overlapDF, NULL,
    alpha=0.5,
    hullWidth=0.4,
    pointSize=1) +
    theme(axis.ticks=element_blank(),
          axis.text=element_blank(),
          axis.title=element_text(size=ABS_TEXT_SIZE,
                                  color='black'),
          plot.title=element_text(size=ABS_TEXT_SIZE,
                                  color='black'),
          legend.text=element_text(size=ABS_TEXT_SIZE,
                                   color='black'),
          legend.key.size=unit(0.4, 'cm'))

#6
firstOutRawRank <- CSOA:::prepareFiltering(overlapDF)
overlapDF <- CSOA:::filterOverlaps(overlapDF, firstOutRawRank)
overlapDF <- CSOA:::scoreOverlaps(overlapDF, 'log')
df <- overlapDF[, c('rank', 'score')]
p6 <- rankScorePlot(df)

#7
normExp <- kerntools::minmax(mat[acinarMarkers, ], rows=TRUE)
pairScores <- CSOA:::computePCPairScores(overlapDF, normExp)
p7 <- basicHeatmap(as.matrix(pairScores), title=NULL)
p7 <- p7 + theme(axis.text.y=element_blank(),
                 axis.title=element_text(size=ABS_TEXT_SIZE),
                 plot.title=element_text(size=ABS_TEXT_SIZE),
                 legend.text=element_text(size=ABS_TEXT_SIZE - 1),
                 legend.key.size=unit(0.4, 'cm'))+
    labs(x='Cell', y='Gene pair', fill='Score')

#8
seuratPanc <- runCSOA(seuratPanc, list(CSOA_acinar=acinarMarkers))
p8 <- featurePlot(seuratPanc, 'CSOA_acinar',
                  palette=paletteer_c("grDevices::Plasma", 30)) +
    theme(axis.title=element_text(size=ABS_TEXT_SIZE),
          axis.text=element_text(size=ABS_TEXT_SIZE),
          plot.title=element_blank(),
          legend.title=element_text(size=ABS_TEXT_SIZE),
          legend.text=element_text(size=ABS_TEXT_SIZE - 1),
          legend.key.size=unit(0.4, 'cm')) + labs(color='Score')

p <- wrap_plots(p1, p2, p3, p4, p5, p6, p7, p8, ncol=4, nrow=2,
                widths = rep(1, 4), heights = rep(1, 4)) +
    plot_annotation(tag_levels='A') &
    theme(plot.tag=element_text(size=ABS_TEXT_SIZE,
                                hjust=-0.5,
                                vjust=-0.5,
                                face='bold'))

pdf("Figure 1.pdf", width = 20, height = 8)
p
dev.off()

#Extract, for each signature gene, the set of cells that highly express the gene (A)
#Assess the significance of cell set pairwise overlaps using hypergeometric tests (B)
#Rank the overlaps based on adjusted p-value and observed-over-expected size ratio (C)
#Adjust the ranks based on connectivity and average the new ranks to obtain the aggregate rank(D)
#Set the cutoff for selecting top overlaps based on rank frequencies (E)
#Map distinct overlap ranks to scores decreasing logarithmically from 1 towards 0 (F)
#Compute per-cell gene pair scores by multiplying overlap scores with the min-max-normalized expression of the two genes (G)
#Sum all gene pair scores in each cell and min-max-normalize the results to obtain the CSOA score (H)
