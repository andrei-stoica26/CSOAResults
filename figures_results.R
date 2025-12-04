source('load_all.R')
source('visualization_results.R')

#############################Main results#######################################
seuratPanc <- qread('seuratPancGSA.qs')
seuratLung <- qread('seuratLungGSA.qs')
seuratBreast <- qread('seuratBreastGSA.qs')
seuratBlood <- qread('seuratBloodGSA.qs')

smrPanc <- qread('smrPanc.qs')
smrLung <- qread('smrLung.qs')
smrBreast <- qread('smrBreast.qs')
smrBlood <- qread('smrBlood.qs')

plotsPanc <- allBenchmarkPlots(smrPanc, pointSize=0.5)
plotsLung <- allBenchmarkPlots(smrLung, pointSize=0.5)
plotsBreast <- allBenchmarkPlots(smrBreast, pointSize=0.5)
plotsBlood <- allBenchmarkPlots(smrBlood, pointSize=0.5)

for (pair in list(c(8, 6), c(9, 10), c(19, 15)))
    devPlot(octoPlot, plotsPanc, plotsLung, plotsBreast, plotsBlood,
            pair[1], pair[2])

#############################Illustrating predictions###########################

labelSize <- 1.5
pointSize <- 0.5

umapPanc <- umapPlots2(seuratPanc, smrPanc, 'label', 'acinar', labelSize)
umapLung <- umapPlots2(seuratLung, smrLung, 'celltype', 'EpendymalCells',
                       labelSize, pointSize)
umapBreast <- umapPlots2(seuratBreast, smrBreast, 'funct',
                         'Chromosome.segregation',
                         labelSize)
umapBlood <- umapPlots2(seuratBlood, smrBlood, 'funct', 'cell.killing',
                        labelSize)
devPlot(octoPlot2, umapPanc, umapLung, umapBreast, umapBlood, 1, 2)

#############################Computational efficiency###########################

devPlot(octoPlot, plotsPanc, plotsLung, plotsBreast, plotsBlood, 20, 21)

#############################Method similarity assessment#######################

segWidth <- 0.1
labelSize <- 1
pointSize <- 0.05
labelSegWidth <- 0.1
maxOverlaps=Inf
mdsPanc <- mdsPlots(seuratPanc,
                    smrPanc,
                    pointSize=pointSize,
                    labelSize=labelSize,
                    segWidth=segWidth,
                    labelSegWidth=labelSegWidth,
                    maxOverlaps=maxOverlaps)$aggregate
mdsLung <- mdsPlots(seuratLung,
                    smrLung,
                    pointSize=pointSize,
                    labelSize=labelSize,
                    segWidth=segWidth,
                    labelSegWidth=labelSegWidth,
                    maxOverlaps=maxOverlaps)$aggregate
mdsBreast <- mdsPlots(seuratBreast,
                      smrBreast,
                      pointSize=pointSize,
                      labelSize=labelSize,
                      segWidth=segWidth,
                      labelSegWidth=labelSegWidth,
                      maxOverlaps=maxOverlaps)$aggregate
mdsBlood <- mdsPlots(seuratBlood,
                     smrBlood,
                     pointSize=pointSize,
                     labelSize=labelSize,
                     segWidth=segWidth,
                     labelSegWidth=labelSegWidth,
                     maxOverlaps=maxOverlaps)$aggregate

jacPanc <- predJaccardPlots(smrPanc$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard')$aggregate
jacLung <- predJaccardPlots(smrLung$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard')$aggregate
jacBreast <- predJaccardPlots(smrBreast$predictions,
                              labelSize=labelSize,
                              legendTitle='Jaccard')$aggregate
jacBlood <- predJaccardPlots(smrBlood$predictions,
                             labelSize=labelSize,
                             legendTitle='Jaccard')$aggregate

devPlot(octoPlot,
        list(mdsPanc, jacPanc),
        list(mdsLung, jacLung),
        list(mdsBreast, jacBreast),
        list(mdsBlood, jacBlood),
        1, 2)

