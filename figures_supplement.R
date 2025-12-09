source('load_all.R')
source('visualization_results.R')
source('correct_shuffle_benchmark.R')

seuratPancShuffle <- qread('seuratPancShuffle.qs')
seuratLungShuffle <- qread('seuratLungShuffle.qs')
seuratBreastShuffle <- qread('seuratBreastShuffle.qs')
seuratBloodShuffle <- qread('seuratBloodShuffle.qs')

smrPancShuffle <- qread('smrPancShuffle.qs')
smrLungShuffle <- qread('smrLungShuffle.qs')
smrBreastShuffle <- qread('smrBreastShuffle.qs')
smrBloodShuffle <- qread('smrBloodShuffle.qs')

smrPancShuffle <- correctSummary(smrPancShuffle, newRows)
smrLungShuffle <- correctSummary(smrLungShuffle, newRows)
smrBreastShuffle <- correctSummary(smrBreastShuffle, newRows)
smrBloodShuffle <- correctSummary(smrBloodShuffle, newRows)

plotsPancShuffle <- allBenchmarkPlots(smrPancShuffle, pointSize=0.5)
plotsLungShuffle <- allBenchmarkPlots(smrLungShuffle, pointSize=0.5)
plotsBreastShuffle <- allBenchmarkPlots(smrBreastShuffle, pointSize=0.5)
plotsBloodShuffle <- allBenchmarkPlots(smrBloodShuffle, pointSize=0.5)

for (pair in list(c(8, 6), c(9, 10), c(19, 15), c(20, 21)))
    devPlot(octoPlot, plotsPancShuffle, plotsLungShuffle,
            plotsBreastShuffle, plotsBloodShuffle,
            pair[1], pair[2])

segWidth <- 0.1
labelSize <- 1
pointSize <- 0.05
labelSegWidth <- 0.1
maxOverlaps <- 10
mdsPancShuffle <- mdsPlots(seuratPancShuffle, smrPancShuffle, pointSize=pointSize,
                           labelSize=labelSize, segWidth=segWidth,
                           labelSegWidth=labelSegWidth, maxOverlaps=maxOverlaps)$aggregate
mdsLungShuffle <- mdsPlots(seuratLungShuffle, smrLungShuffle, pointSize=pointSize,
                           labelSize=labelSize, segWidth=segWidth,
                           labelSegWidth=labelSegWidth, maxOverlaps=maxOverlaps)$aggregate
mdsBreastShuffle <- mdsPlots(seuratBreastShuffle, smrBreastShuffle, pointSize=pointSize,
                             labelSize=labelSize, segWidth=segWidth,
                             labelSegWidth=labelSegWidth, maxOverlaps=maxOverlaps)$aggregate
mdsBloodShuffle <- mdsPlots(seuratBloodShuffle, smrBloodShuffle, pointSize=pointSize,
                            labelSize=labelSize, segWidth=segWidth,
                            labelSegWidth=labelSegWidth, maxOverlaps=maxOverlaps)$aggregate

jacPancShuffle <- predJaccardPlots(smrPancShuffle$predictions,
                                   labelSize=labelSize,
                                   legendTitle='Jaccard')$aggregate
jacLungShuffle <- predJaccardPlots(smrLungShuffle$predictions,
                                   labelSize=labelSize,
                                   legendTitle='Jaccard')$aggregate
jacBreastShuffle <- predJaccardPlots(smrBreastShuffle$predictions,
                                     labelSize=labelSize,
                                     legendTitle='Jaccard')$aggregate
jacBloodShuffle <- predJaccardPlots(smrBloodShuffle$predictions,
                                    labelSize=labelSize,
                                    legendTitle='Jaccard')$aggregate

devPlot(octoPlot,
        list(mdsPancShuffle, jacPancShuffle),
        list(mdsLungShuffle, jacLungShuffle),
        list(mdsBreastShuffle, jacBreastShuffle),
        list(mdsBloodShuffle, jacBloodShuffle),
        1, 2)
