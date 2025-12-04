source('load_all.R')
source('visualization_abstract_utils.R')
source('visualization_abstract.R')


zebSeurat <- qread('../MGC/zebSeuratCSOA.qs')

dfBar <- geneCellCountDF()
geneSets <- cellSetList()
dfNetwork <- networkDF()
dfScore <- scoreDF()
dfExp <- geneExpDF()

p1 <- geneCellCountPlot(dfBar,
                        nCells,
                        'navy',
                        paste0('1. For each signature gene, extract the set',
                               ' of cells\nthat highly express the gene'))
p2 <- eulerPlot(geneSets,
                paste0('2. Assess cell set pairwise overlaps',
                ' using hypergeometric tests'))

p3 <- overlapRankPlot(rankDF,
                      paste0('3. Rank the overlaps based on adjusted p-value',
                      ' and observed-over-expected size ratio'))

p4 <- networkPlot(dfNetwork,
                  paste0('4. Adjust the two ranks based on connectivity and',
                         ' create the final rank as the average of',
                         'the adjusted ranks'),
                  nodeColor='orange',
                  edgeColor='green4')

p5 <- overlapCutoffPlot(dfOverlap,
                        paste0('5. Set the cutoff for selecting top overlaps',
                               ' based on rank frequencies'))

p6 <- rankScorePlot(dfScore,
                    paste0('4. Score the overlaps by mapping distinct overlap
                           ranks to values decreasing logaritmically from 1 towards 0'))

p7 <- geneExpPlot(dfExp,
                  paste0('5. Compute per-cell pair scores by multiplying',
                  ' overlap scores with the\nminmax-normalized expression of',
                  'the two involved genes'),
                  'Gene pair score', 2)

p8 <- scoreFeaturePlot(zebSeurat,
                       'neuro',
                       paste0('6. Sum all gene pair scores in each cell and ',
                       ' minmax-normalize the results\nto',
                       ' obtain the CSOA score'))

p <- (p1 | p2 ) / (p3 | p4) / (p5 | p6) / (p7 | p8)

