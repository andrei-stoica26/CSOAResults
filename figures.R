source('load_all.R')
source('visualization.R')

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

for (pair in list(c(8, 6), c(9, 10), c(19, 15), c(20, 21)))
    devPlot(octoPlot, plotsPanc, plotsLung, plotsBreast, plotsBlood,
            pair[1], pair[2])

segWidth <- 0.1
labelSize <- 1
pointSize <- 0.1
mdsPanc <- list(mdsPlots(seuratPanc, smrPanc, pointSize=pointSize,
                         labelSize=labelSize, segWidth=segWidth)$aggregate)
mdsLung <- list(mdsPlots(seuratLung, smrLung, pointSize=pointSize,
                         labelSize=labelSize, segWidth=segWidth)$aggregate)
mdsBreast <- list(mdsPlots(seuratBreast, smrBreast, pointSize=pointSize,
                           labelSize=labelSize, segWidth=segWidth)$aggregate)
mdsBlood <- list(mdsPlots(seuratBlood, smrBlood, pointSize=pointSize,
                          labelSize=labelSize, segWidth=segWidth)$aggregate)

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
        c(mdsPanc, jacPanc),
        c(mdsLung, jacLung),
        c(mdsBreast, jacBreast),
        c(mdsBlood, jacBlood),
        1, 2)


