source('visualization_abstract_utils.R')


zebSeurat <- qread('../MGC/zebSeuratCSOA.qs')

dfBar <- geneCellCountDF()
geneSets <- cellSetList()
dfNetwork <- networkDF()
dfScore <- scoreDF()
dfExp <- geneExpDF()

p1 <- geneCellCountPlot(dfBar,
                        nCells,
                        'deepskyblue',
                        paste0('1. For each signature gene, extract the set',
                               ' of cells\nthat highly express the gene'))
p2 <- eulerPlot(geneSets,
                paste0('2. Assess cell set pairwise overlaps',
                ' using hypergeometric tests'))

p3 <- networkPlot(dfNetwork,
                  paste0('3. Select the top overlaps by using',
                         ' connectivity-adjusted ranks based on\np-value',
                         ' and observed-over expected ratio'),
                  nodeColor='orange',
                  edgeColor='green4')

p4 <- rankScorePlot(dfScore,
                    paste0('4. Score the top overlaps logarithmically from 1',
                    ' (the highest-ranked overlap)\nto 0 (the overlap just',
                    ' below the cutoff)'))

p5 <- geneExpPlot(dfExp,
                  paste0('5. Compute per-cell pair scores by multiplying',
                  ' overlap scores with the\nminmax-normalized expression of',
                  'the two involved genes'),
                  'Gene pair score', 2)

p6 <- scoreFeaturePlot(zebSeurat,
                       'neuro',
                       paste0('6. Sum all gene pair scores in each cell and ',
                       ' minmax-normalize the results\nto',
                       ' obtain the CSOA score'))

p <- (p1 | p2 ) / (p3 | p4) / (p5 | p6)

