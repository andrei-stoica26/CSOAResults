source('load_all.R')
source('visualization_abstract_utils.R')
source('visualization_abstract.R')
source('visualization_results.R')


zebSeurat <- qread('../MGC/zebSeuratCSOA.qs')

dfBar <- geneCellCountDF()
geneSets <- cellSetList()
dfRank <- rankDF()
dfNetwork <- networkDF()
dfOverlap <- overlapDF()
dfScore <- scoreDF()
dfExp <- geneExpDF()

ABS_TEXT_SIZE <- 7

p1 <- geneCellCountPlot(dfBar,
                        nCells,
                        'deepskyblue',
                        paste0('1. For each signature gene, extract the set',
                               ' of cells\nthat highly express the gene'))
p2 <- eulerPlot(geneSets,
                paste0('2. Assess cell set pairwise overlaps',
                ' using hypergeometric tests'))

p3 <- prerankPlot(dfRank,
                      paste0('3. Rank the overlaps based on adjusted p-value\n',
                      'and observed-over-expected size ratio'))

p4 <- overlapNetworkPlot(dfNetwork,
                         paste0('4. Adjust the two ranks based on connectivity and',
                                '\naverage the new ranks to obtain the final rank'),
                         nodeSize=4,
                         nodeTextSize=0.2,
                         edgeWidth=0.1) +
    theme(axis.ticks=element_blank(),
          axis.text=element_blank(),
          plot.title=element_text(size=ABS_TEXT_SIZE,
                                  color='black'))

p5 <- overlapCutoffPlot(dfOverlap,
                        paste0('5. Set the cutoff for selecting top\n',
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

p6 <- rankScorePlot(dfScore,
                    paste0('6. Map distinct overlap ranks to',
                    ' scores decreasing\nlogaritmically from 1 towards 0'))

p7 <- geneExpPlot(dfExp,
                  paste0('7. Compute per-cell gene pair scores by multiplying',
                  ' overlap scores with\nthe min-max-normalized expression of',
                  ' the two genes'),
                  'Gene pair score', 2)

p8 <- scoreFeaturePlot(zebSeurat,
                       'neuro',
                       paste0('8. Sum all gene pair scores in each cell and ',
                       ' min-max-normalize\nthe results to',
                       ' obtain the CSOA score'))

plots <- list(p1, p2, p3, p4, p5, p6, p7, p8)

p <- (plots[[1]] | plots[[2]] ) / (plots[[3]] | plots[[4]]) /
    (plots[[5]] | plots[[6]]) / (plots[[7]] | plots[[8]]) +
    plot_annotation(tag_levels='A',
                    theme=theme(plot.title=element_text(size=TEXT_SIZE - 1, hjust=-0.5, vjust=-0.5)))
devPlot(p)
