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

TEXT_SIZE <- 10
pointSize <- 1

plotsPancShuffle <- allBenchmarkPlots(smrPancShuffle, pointSize=pointSize)
plotsLungShuffle <- allBenchmarkPlots(smrLungShuffle, pointSize=pointSize)
plotsMerkelShuffle <- allBenchmarkPlots(smrMerkelShuffle, pointSize=pointSize)
plotsBloodShuffle <- allBenchmarkPlots(smrBloodShuffle, pointSize=pointSize)


invisible(mapply(function(i, plotName){
    p <- quadPlot(plotsPancShuffle, plotsLungShuffle,
                  plotsMerkelShuffle, plotsBloodShuffle, i)
    pdf(paste0('Figure ', plotName, '.pdf'), width = 12, height = 8)
    print(p)
    dev.off()
}, c(8, 9, 19),
c('S6', 'S7', 'S8')))
