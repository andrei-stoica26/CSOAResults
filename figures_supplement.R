source('load_all.R')
source('visualization_results.R')

seuratPancShuffle <- qs_read('seuratPancShuffle.qs2')
seuratLungShuffle <- qs_read('seuratLungShuffle.qs2')
seuratMerkelShuffle <- qs_read('seuratMerkelShuffle.qs2')
seuratBloodShuffle <- qs_read('seuratBloodShuffle.qs2')

smrPancShuffle <- qs_read('smrPancShuffle.qs2')
smrLungShuffle <- qs_read('smrLungShuffle.qs2')
smrMerkelShuffle <- qs_read('smrMerkelShuffle.qs2')
smrBloodShuffle <- qs_read('smrBloodShuffle.qs2')

plotsPancShuffle <- allBenchmarkPlots(smrPancShuffle, pointSize=0.5)
plotsLungShuffle <- allBenchmarkPlots(smrLungShuffle, pointSize=0.5)
plotsMerkelShuffle <- allBenchmarkPlots(smrMerkelShuffle, pointSize=0.5)
plotsBloodShuffle <- allBenchmarkPlots(smrBloodShuffle, pointSize=0.5)

for (pair in list(c(8, 6), c(9, 10), c(19, 15), c(20, 21)))
    devPlot(octoPlot, plotsPancShuffle, plotsLungShuffle,
            plotsMerkelShuffle, plotsBloodShuffle,
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
mdsMerkelShuffle <- mdsPlots(seuratMerkelShuffle, smrMerkelShuffle, pointSize=pointSize,
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
jacMerkelShuffle <- predJaccardPlots(smrMerkelShuffle$predictions,
                                     labelSize=labelSize,
                                     legendTitle='Jaccard')$aggregate
jacBloodShuffle <- predJaccardPlots(smrBloodShuffle$predictions,
                                    labelSize=labelSize,
                                    legendTitle='Jaccard')$aggregate

devPlot(octoPlot,
        list(mdsPancShuffle, jacPancShuffle),
        list(mdsLungShuffle, jacLungShuffle),
        list(mdsMerkelShuffle, jacMerkelShuffle),
        list(mdsBloodShuffle, jacBloodShuffle),
        1, 2)
