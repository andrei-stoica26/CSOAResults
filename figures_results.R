source('load_all.R')
source('visualization_results.R')

#################################Main results###################################
seuratPanc <- qs_read('seuratPancGSA.qs2')
seuratLung <- qs_read('seuratLungGSA.qs2')
seuratMerkel <- qs_read('seuratMerkelGSA.qs2')
seuratBlood <- qs_read('seuratBloodGSA.qs2')

smrPanc <- qs_read('smrPanc.qs2')
smrLung <- qs_read('smrLung.qs2')
smrMerkel <- qs_read('smrMerkel.qs2')
smrBlood <- qs_read('smrBlood.qs2')

TEXT_SIZE <- 10
pointSize <- 2
labelSize <- 3
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

#############################Illustrating predictions###########################


umapPanc <- umapPlots2(seuratPanc, smrPanc, 'label', 'acinar', labelSize)
umapLung <- umapPlots2(seuratLung, smrLung, 'celltype', 'EpendymalCells',
                       labelSize, pointSize)
umapMerkel <- umapPlots2(seuratMerkel, smrMerkel, 'funct',
                         'Chromosome.segregation',
                         labelSize)
umapBlood <- umapPlots2(seuratBlood, smrBlood, 'funct', 'Cell.killing',
                        labelSize)
umaps <- c(umapPanc, umapLung, umapMerkel, umapBlood)

p <- wrap_plots(umaps, ncol=2, nrow=4,
                widths = rep(1, 4), heights = rep(1, 4)) +
    plot_annotation(tag_levels='A') &
    theme(plot.tag=element_text(size=TEXT_SIZE,
                                hjust=0.5,
                                vjust=0.5,
                                face='bold'))

pdf('Figure 2.pdf', width=8.27, height=11.69)
p
dev.off()

png('Figure 2.png', width=595, height=842)
p
dev.off()

###########################Correctness and efficiency###########################
plotsPanc <- allBenchmarkPlots(smrPanc, pointSize=pointSize)
plotsPanc <- lapply(plotsPanc, function(p)
    p + scale_color_manual(values=palette))

plotsLung <- allBenchmarkPlots(smrLung, pointSize=pointSize)
plotsLung <- lapply(plotsLung, function(p)
    p + scale_color_manual(values=palette))

plotsMerkel <- allBenchmarkPlots(smrMerkel, pointSize=pointSize)
plotsMerkel <- lapply(plotsMerkel, function(p)
    p + scale_color_manual(values=palette))

plotsBlood <- allBenchmarkPlots(smrBlood, pointSize=pointSize)
plotsBlood <- lapply(plotsBlood, function(p)
    p + scale_color_manual(values=palette))

invisible(mapply(function(i, plotName){
    p <- quadPlot(plotsPanc, plotsLung, plotsMerkel, plotsBlood, i)
    pdf(paste0('Figure ', plotName, '.pdf'), width=8.27, height=11.69)
    print(p)
    dev.off()
    png(paste0('Figure ', plotName, '.png'), width=595, height=842)
    print(p)
    dev.off()
}, c(8, 6, 9, 10, 19, 15, 20, 21),
c('3', 'S7',
  '4','S8',
  '5', 'S9',
  '6', '7')))

#############################Method similarity assessment#######################

segWidth <- 0.1
pointSize <- 0.5
labelSegWidth <- 0.1
maxOverlaps=7
mdsPanc <- mdsPlots(seuratPanc,
                    smrPanc,
                    pointSize=pointSize,
                    labelSize=labelSize,
                    segWidth=segWidth,
                    labelSegWidth=labelSegWidth,
                    maxOverlaps=maxOverlaps,
                    drawNN=FALSE,
                    xLab = 'MDS_1',
                    yLab = 'MDS_2')$aggregate
mdsLung <- mdsPlots(seuratLung,
                    smrLung,
                    pointSize=pointSize,
                    labelSize=labelSize,
                    segWidth=segWidth,
                    labelSegWidth=labelSegWidth,
                    maxOverlaps=maxOverlaps,
                    drawNN=FALSE,
                    xLab = 'MDS_1',
                    yLab = 'MDS_2')$aggregate
mdsMerkel <- mdsPlots(seuratMerkel,
                      smrMerkel,
                      pointSize=pointSize,
                      labelSize=labelSize,
                      segWidth=segWidth,
                      labelSegWidth=labelSegWidth,
                      maxOverlaps=maxOverlaps,
                      drawNN=FALSE,
                      xLab = 'MDS_1',
                      yLab = 'MDS_2')$aggregate
mdsBlood <- mdsPlots(seuratBlood,
                     smrBlood,
                     pointSize=pointSize,
                     labelSize=labelSize,
                     segWidth=segWidth,
                     labelSegWidth=labelSegWidth,
                     maxOverlaps=maxOverlaps,
                     drawNN=FALSE,
                     xLab = 'MDS_1',
                     yLab = 'MDS_2')$aggregate

xAngle <- 60
jacPanc <- predJaccardPlots(smrPanc$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard',
                            limits=c(0, 1),
                            showNumbers=FALSE,
                            xAngle=xAngle)$aggregate
jacLung <- predJaccardPlots(smrLung$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard',
                            limits=c(0, 1),
                            showNumbers=FALSE,
                            xAngle=xAngle)$aggregate
jacMerkel <- predJaccardPlots(smrMerkel$predictions,
                              labelSize=labelSize,
                              legendTitle='Jaccard',
                              limits=c(0, 1),
                              showNumbers=FALSE,
                              xAngle=xAngle)$aggregate
jacBlood <- predJaccardPlots(smrBlood$predictions,
                             labelSize=labelSize,
                             legendTitle='Jaccard',
                             limits=c(0, 1),
                             showNumbers=FALSE,
                             xAngle=xAngle)$aggregate

invisible(mapply(function(i, plotName){
    p <- quadPlot(list(mdsPanc, jacPanc),
                  list(mdsLung, jacLung),
                  list(mdsMerkel, jacMerkel),
                  list(mdsBlood, jacBlood), i, removeYLab=FALSE)
    pdf(paste0('Figure ', plotName, '.pdf'), width=8.27, height=11.69)
    print(p)
    dev.off()
    png(paste0('Figure ', plotName, '.png'), width=595, height=842)
    print(p)
    dev.off()
}, c(1, 2),
c('S5', 'S6')))

