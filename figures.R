library(Seurat)

seuratPanc <- qread('seuratPancGSA.qs')
seuratLung <- qread('seuratLungGSA.qs')
seuratBreast <- qread('seuratBreastGSA.qs')
seuratBlood <- qread('seuratBloodGSA.qs')

smrPanc <- qread('smrPanc.qs')
smrLung <- qread('smrLung.qs')
smrBreast <- qread('smrBreast.qs')
smrBlood <- qread('smrBlood.qs')

plotsPanc <- allBenchmarkPlots(smrPanc, pointSize=0.8)
plotsLung <- allBenchmarkPlots(smrLung, pointSize=0.8)
plotsBreast <- allBenchmarkPlots(smrBreast, pointSize=0.8)
plotsBlood <- allBenchmarkPlots(smrBlood, pointSize=0.8)

for (i in c(8, 6, 10, 17, 15, 18, 19))
    devPlot(quadPlot, plotsPanc, plotsLung, plotsBreast, plotsBlood, i)

mdsPanc <- list(mdsPlots(seuratPanc, smrPanc, pointSize=0.5,
                         labelSize=2, segWidth=0.2, legendTitle='Density')$aggregate)
mdsLung <- list(mdsPlots(seuratLung, smrLung, pointSize=0.5,
                         labelSize=2, segWidth=0.2, legendTitle='Density')$aggregate)
mdsBreast <- list(mdsPlots(seuratBreast, smrBreast, pointSize=0.5,
                           labelSize=2, segWidth=0.2, legendTitle='Density')$aggregate)
mdsBlood <- list(mdsPlots(seuratBlood, smrBlood, pointSize=0.5,
                          labelSize=2, segWidth=0.2, legendTitle='Density')$aggregate)

devPlot(quadPlot, mdsPanc, mdsLung, mdsBreast, mdsBlood, 1, 'right')

?henna::densityPlot

View(henna::densityPlot)
