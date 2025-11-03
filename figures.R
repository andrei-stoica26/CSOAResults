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

for (pair in list(c(8, 6), c(9, 10), c(17, 15), c(18, 19)))
    devPlot(octoPlot, plotsPanc, plotsLung, plotsBreast, plotsBlood,
            pair[1], pair[2])

mdsPanc <- list(mdsPlots(seuratPanc, smrPanc, pointSize=0.5,
                         labelSize=2.5, segWidth=0.2)$aggregate)
mdsLung <- list(mdsPlots(seuratLung, smrLung, pointSize=0.5,
                         labelSize=2.5, segWidth=0.2)$aggregate)
mdsBreast <- list(mdsPlots(seuratBreast, smrBreast, pointSize=0.5,
                           labelSize=2.5, segWidth=0.2)$aggregate)
mdsBlood <- list(mdsPlots(seuratBlood, smrBlood, pointSize=0.5,
                          labelSize=2.5, segWidth=0.2)$aggregate)

devPlot(quadPlot, mdsPanc, mdsLung, mdsBreast, mdsBlood, 1, 'right')
