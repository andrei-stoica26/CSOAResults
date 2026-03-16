source('load_all.R')
source('visualization_results.R')

TEXT_SIZE <- 5.3
pointSize <- 0.5

#############################Main results#######################################
seuratPanc <- qs_read('seuratPancGSA.qs2')
seuratLung <- qs_read('seuratLungGSA.qs2')
seuratMerkel <- qs_read('seuratMerkelGSA.qs2')
seuratBlood <- qs_read('seuratBloodGSA.qs2')

smrPanc <- qs_read('smrPanc.qs2')
smrLung <- qs_read('smrLung.qs2')
smrMerkel <- qs_read('smrMerkel.qs2')
smrBlood <- qs_read('smrBlood.qs2')

#############################Illustrating predictions###########################

labelSize <- 1.5

umapPanc <- umapPlots2(seuratPanc, smrPanc, 'label', 'acinar', labelSize)
umapLung <- umapPlots2(seuratLung, smrLung, 'celltype', 'EpendymalCells',
                       labelSize, pointSize)
umapMerkel <- umapPlots2(seuratMerkel, smrMerkel, 'funct',
                         'Chromosome.segregation',
                         labelSize)
umapBlood <- umapPlots2(seuratBlood, smrBlood, 'funct', 'Cell.killing',
                        labelSize)
devPlot(octoPlot2, umapPanc, umapLung, umapMerkel, umapBlood, 1, 2)

#############################Correctness########################################

plotsPanc <- allBenchmarkPlots(smrPanc, pointSize=pointSize)
plotsLung <- allBenchmarkPlots(smrLung, pointSize=pointSize)
plotsMerkel <- allBenchmarkPlots(smrMerkel, pointSize=pointSize)
plotsBlood <- allBenchmarkPlots(smrBlood, pointSize=pointSize)

for (pair in list(c(8, 6), c(9, 10), c(19, 15)))
    devPlot(octoPlot, plotsPanc, plotsLung, plotsMerkel, plotsBlood,
            pair[1], pair[2])


#############################Computational efficiency###########################

devPlot(octoPlot, plotsPanc, plotsLung, plotsMerkel, plotsBlood, 20, 21)

#############################Method similarity assessment#######################

segWidth <- 0.1
pointSize <- 0.05
labelSegWidth <- 0.1
maxOverlaps=Inf
mdsPanc <- mdsPlots(seuratPanc,
                    smrPanc,
                    pointSize=pointSize,
                    labelSize=labelSize,
                    segWidth=segWidth,
                    labelSegWidth=labelSegWidth,
                    maxOverlaps=maxOverlaps,
                    drawNN=FALSE)$aggregate
mdsLung <- mdsPlots(seuratLung,
                    smrLung,
                    pointSize=pointSize,
                    labelSize=labelSize,
                    segWidth=segWidth,
                    labelSegWidth=labelSegWidth,
                    maxOverlaps=maxOverlaps,
                    drawNN=FALSE)$aggregate
mdsMerkel <- mdsPlots(seuratMerkel,
                      smrMerkel,
                      pointSize=pointSize,
                      labelSize=labelSize,
                      segWidth=segWidth,
                      labelSegWidth=labelSegWidth,
                      maxOverlaps=maxOverlaps,
                      drawNN=FALSE)$aggregate
mdsBlood <- mdsPlots(seuratBlood,
                     smrBlood,
                     pointSize=pointSize,
                     labelSize=labelSize,
                     segWidth=segWidth,
                     labelSegWidth=labelSegWidth,
                     maxOverlaps=maxOverlaps,
                     drawNN=FALSE)$aggregate

jacPanc <- predJaccardPlots(smrPanc$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard',
                            limits=c(0, 1))$aggregate
jacLung <- predJaccardPlots(smrLung$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard',
                            limits=c(0, 1))$aggregate
jacMerkel <- predJaccardPlots(smrMerkel$predictions,
                              labelSize=labelSize,
                              legendTitle='Jaccard',
                              limits=c(0, 1))$aggregate
jacBlood <- predJaccardPlots(smrBlood$predictions,
                             labelSize=labelSize,
                             legendTitle='Jaccard',
                             limits=c(0, 1))$aggregate
devPlot(octoPlot,
        list(mdsPanc, jacPanc),
        list(mdsLung, jacLung),
        list(mdsMerkel, jacMerkel),
        list(mdsBlood, jacBlood),
        1, 2)
