source('load_all.R')
source('visualization_abstract_utils.R')
source('visualization_abstract.R')
source('new_first_figure.R')


ABS_TEXT_SIZE <- 9
seuratPanc <- qs_read('seuratPanc.qs2')
acinarPremarkers <- c('KLK1', 'CTRC', 'PNLIP','CELA3A','SPINK1','CELA2A', 'CPB1', 'PNLIPRP1', 'CPA2','CPA1', 'CELA3B', 'PLA2G1B', 'CLPS', 'SYCN')
acinarMarkers <- withr::with_seed(2, sample(acinarPremarkers, 6))

mat <- scExpMat(seuratPanc, genes=acinarMarkers)

#1
p1 <- drawCellSets()
p1 <- centerTitle(p1, '1. Build a high-expression cell set\nfor each signature gene',
                  size=ABS_TEXT_SIZE)

#2
cellSets <- percentileSets(mat)
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
p2 <- centerTitle(p2, '2. Assess the statistical significance of cell set overlaps',
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
prerankDF$overlap <- sort(rep(seq(1, nrow(prerankDF) / 3), 3))

p3 <- prerankPlot2(prerankDF)
p3 <- centerTitle(p3, '3. Rank the overlaps based on adjusted p-value\nand observed-over-expected size ratio',
                  size=ABS_TEXT_SIZE)

#4
overlapDF$rank <- rank(overlapDF$rawAggRank, ties.method='min')
firstOutRawRank <- CSOA:::prepareFiltering(overlapDF)
overlapDF <- CSOA:::filterOverlaps(overlapDF, firstOutRawRank)
overlapDF <- CSOA:::scoreOverlaps(overlapDF, 'log')
df <- overlapDF[, c('rank', 'score')]
p4 <- rankScorePlot(df)
p4 <- centerTitle(p4, '4. Convert overlap ranks to weights between 0 and 1',
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
p5 <- centerTitle(p5, '5. Compute gene pair scores for each cell\nusing overlap weights and the expression\nof the two genes',
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
p6 <- centerTitle(p6, '6. Normalize the summed gene-pair scores for each\ncell to obtain the CSOA score',
                  size=ABS_TEXT_SIZE)

p <- wrap_plots(p1, p2, p3, p4, p5, p6, ncol=2, nrow=3,
                widths = rep(1, 4), heights = rep(1, 4))

pdf("Figure 1.pdf", width = 7, height = 9)
p
dev.off()
