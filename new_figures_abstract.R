source('load_all.R')
source('visualization_abstract_utils.R')
source('visualization_abstract.R')


ABS_TEXT_SIZE <- 9
seuratPanc <- qs_read('seuratPanc.qs2')
acinarPremarkers <- c('KLK1', 'CTRC', 'PNLIP','CELA3A','SPINK1','CELA2A', 'CPB1', 'PNLIPRP1', 'CPA2','CPA1', 'CELA3B', 'PLA2G1B', 'CLPS', 'SYCN')
acinarMarkers <- withr::with_seed(2, sample(acinarPremarkers, 6))

mat <- scExpMat(seuratPanc, genes=acinarMarkers)

#1
cellSets <- percentileSets(mat)
geneFreqs <- lengths(cellSets)
df <- data.frame(Gene = names(geneFreqs),
                 nCells = geneFreqs)
p1 <- geneCellCountPlot(df, 'deepskyblue')
p1 <- centerTitle(p1, 'For each signature gene, extract the set\nof cells highly expressing the gene',
                  size=ABS_TEXT_SIZE)

#2
vennInput <- setNames(c(cellSets[1:2], list(colnames(seuratPanc))),
                      c('Cell set 1',
                        'Cell set 2',
                        ''))
p2 <- ggvenn(vennInput,
             fill_color=c('red', 'yellow'),
             fill_alpha=0.8,
             text_size = 3,
             stroke_size = 0.3,
             show_percentage = FALSE,
             set_name_size = 3)
p2 <- centerTitle(p2, 'Assess the statistical significance of cell set overlaps',
                  size=ABS_TEXT_SIZE)

#3
overlapDF <- generateOverlaps(mat)
overlapDF <- CSOA:::prefilterOverlaps(overlapDF)
overlapDF <- overlapDF[order(overlapDF$pvalAdj), ]
overlapDF$pvalRank <- rank(overlapDF$pvalAdj, ties.method='min')
overlapDF <- overlapDF[order(overlapDF$ratio,
                             decreasing=TRUE), ]
overlapDF$ratioRank <- rank(-overlapDF$ratio, ties.method='min')

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

p3 <- prerankPlot2(prerankDF)
p3 <- centerTitle(p3, 'Rank the overlaps based on adjusted p-value\nand observed-over-expected size ratio',
                  size=ABS_TEXT_SIZE)

#4
overlapDF$rank <- rank(overlapDF$rawAggRank, ties.method='min')
firstOutRawRank <- CSOA:::prepareFiltering(overlapDF)
overlapDF <- CSOA:::filterOverlaps(overlapDF, firstOutRawRank)
overlapDF <- CSOA:::scoreOverlaps(overlapDF, 'log')
df <- overlapDF[, c('rank', 'score')]
p4 <- rankScorePlot(df)
p4 <- centerTitle(p4, 'Map distinct overlap ranks to scores decreasing\nlogarithmically from 1 towards 0',
                  size=ABS_TEXT_SIZE)

#5
normExp <- kerntools::minmax(mat[acinarMarkers, ], rows=TRUE)
pairScores <- CSOA:::computePCPairScores(overlapDF, normExp)
p5 <- basicHeatmap(as.matrix(pairScores), title=NULL)
p5 <- p5 + theme(axis.text.y=element_blank(),
                 axis.title=element_text(size=ABS_TEXT_SIZE),
                 plot.title=element_text(size=ABS_TEXT_SIZE),
                 legend.title=element_text(size=ABS_TEXT_SIZE),
                 legend.text=element_text(size=ABS_TEXT_SIZE - 1),
                 legend.key.size=unit(0.4, 'cm'))+
    labs(x='Cell', y='Gene pair', fill='Score')
p5 <- centerTitle(p5, 'Compute per-cell gene pair scores based on overlap\nscores and the expression of the two genes',
                  size=ABS_TEXT_SIZE)


#6
seuratPanc <- runCSOA(seuratPanc, list(CSOA_acinar=acinarMarkers))
p6 <- featurePlot(seuratPanc, 'CSOA_acinar',
                  palette=paletteer_c("grDevices::Plasma", 30)) +
    theme(axis.title=element_text(size=ABS_TEXT_SIZE),
          axis.text=element_text(size=ABS_TEXT_SIZE),
          plot.title=element_blank(),
          legend.title=element_text(size=ABS_TEXT_SIZE),
          legend.text=element_text(size=ABS_TEXT_SIZE - 1),
          legend.key.size=unit(0.4, 'cm')) + labs(color='Score')
p6 <- centerTitle(p6, 'Sum all gene pair scores in each cell and normalize\nthe results to obtain the CSOA score',
                  size=ABS_TEXT_SIZE)

p <- wrap_plots(p1, p2, p3, p4, p5, p6, ncol=2, nrow=3,
                widths = rep(1, 4), heights = rep(1, 4)) +
    plot_annotation(tag_levels='A') &
    theme(plot.tag=element_text(size=ABS_TEXT_SIZE,
                                hjust=0.5,
                                vjust=0.5,
                                face='bold'))

pdf("Figure 1.pdf", width = 7, height = 9)
p
dev.off()
