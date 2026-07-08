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
pointSize <- 2
palette <- c(rgb(169/255, 169/255, 169/255),
             rgb(247/255, 147/255, 30/255),
             rgb(220/255, 20/255, 60/255),
             rgb(150/255, 206/255, 180/255),
             rgb(3/255, 161/255, 198/255),
             rgb(192/255, 193/255, 48/255),
             rgb(255/255, 191/255, 15/255),
             rgb(157/255, 115/255, 194/255),
             rgb(183/255, 76/255, 171/255),
             rgb(140/255, 198/255, 63/255),
             rgb(103/255, 199/255, 193/255),
             rgb(97/255, 156/255, 255/255))

plotsPancShuffle <- allBenchmarkPlots(smrPancShuffle, pointSize=pointSize)
plotsPancShuffle <- lapply(plotsPancShuffle, function(p)
    p + scale_color_manual(values=palette))

plotsLungShuffle <- allBenchmarkPlots(smrLungShuffle, pointSize=pointSize)
plotsLungShuffle <- lapply(plotsLungShuffle, function(p)
    p + scale_color_manual(values=palette))

plotsMerkelShuffle <- allBenchmarkPlots(smrMerkelShuffle, pointSize=pointSize)
plotsMerkelShuffle <- lapply(plotsMerkelShuffle, function(p)
    p + scale_color_manual(values=palette))

plotsBloodShuffle <- allBenchmarkPlots(smrBloodShuffle, pointSize=pointSize)
plotsBloodShuffle <- lapply(plotsBloodShuffle, function(p)
    p + scale_color_manual(values=palette))

invisible(mapply(function(i, plotName){
    p <- quadPlot(plotsPancShuffle, plotsLungShuffle,
                  plotsMerkelShuffle, plotsBloodShuffle, i)
    pdf(paste0('Figure ', plotName, '.pdf'), width = 12, height = 8)
    print(p)
    dev.off()
}, c(8, 9, 19),
c('S2', 'S3', 'S4')))
