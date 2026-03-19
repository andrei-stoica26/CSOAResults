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


invisible(mapply(function(i, plotName){
    p <- quadPlot(plotsPancShuffle, plotsLungShuffle,
                  plotsMerkelShuffle, plotsBloodShuffle, i)
    pdf(paste0('Figure ', plotName, '.pdf'), width = 10, height = 8)
    print(p)
    dev.off()
}, c(8, 9, 19, 15, 20, 21),
c('S6', 'S7', 'S8')))
