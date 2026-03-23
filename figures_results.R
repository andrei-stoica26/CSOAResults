source('load_all.R')
source('visualization_results.R')

#############################Main results#######################################
seuratPanc <- qs_read('seuratPancGSA.qs2')
seuratLung <- qs_read('seuratLungGSA.qs2')
seuratMerkel <- qs_read('seuratMerkelGSA.qs2')
seuratBlood <- qs_read('seuratBloodGSA.qs2')

smrPanc <- qs_read('smrPanc.qs2')
smrLung <- qs_read('smrLung.qs2')
smrMerkel <- qs_read('smrMerkel.qs2')
smrBlood <- qs_read('smrBlood.qs2')

TEXT_SIZE <- 10
pointSize <- 1
labelSize <- 3

#############################Illustrating predictions###########################


umapPanc <- umapPlots2(seuratPanc, smrPanc, 'label', 'acinar', labelSize)
umapLung <- umapPlots2(seuratLung, smrLung, 'celltype', 'EpendymalCells',
                       labelSize, pointSize)
umapMerkel <- umapPlots2(seuratMerkel, smrMerkel, 'funct',
                         'Chromosome.segregation',
                         labelSize)
umapBlood <- umapPlots2(seuratBlood, smrBlood, 'funct', 'Cell.killing',
                        labelSize)
p <- octoPlot2(umapPanc, umapLung, umapMerkel, umapBlood, 1, 2)
pdf('Figure 2.pdf', width = 12, height = 8)
p
dev.off()

###########################Correctness and efficiency###########################
plotsPanc <- allBenchmarkPlots(smrPanc, pointSize=pointSize)
plotsLung <- allBenchmarkPlots(smrLung, pointSize=pointSize)
plotsMerkel <- allBenchmarkPlots(smrMerkel, pointSize=pointSize)
plotsBlood <- allBenchmarkPlots(smrBlood, pointSize=pointSize)

invisible(mapply(function(i, plotName){
    p <- quadPlot(plotsPanc, plotsLung, plotsMerkel, plotsBlood, i)
    pdf(paste0('Figure ', plotName, '.pdf'), width = 12, height = 8)
    print(p)
    dev.off()
}, c(8, 6, 9, 10, 19, 15, 20, 21),
c('3', 'S1',
  '4','S2',
  '5', 'S3',
  '6', '7')))

#############################Method similarity assessment#######################

segWidth <- 0.1
pointSize <- 0.5
labelSegWidth <- 0.1
maxOverlaps=10
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

jacPanc <- predJaccardPlots(smrPanc$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard',
                            limits=c(0, 1),
                            showNumbers=FALSE)$aggregate
jacLung <- predJaccardPlots(smrLung$predictions,
                            labelSize=labelSize,
                            legendTitle='Jaccard',
                            limits=c(0, 1),
                            showNumbers=FALSE)$aggregate
jacMerkel <- predJaccardPlots(smrMerkel$predictions,
                              labelSize=labelSize,
                              legendTitle='Jaccard',
                              limits=c(0, 1),
                              showNumbers=FALSE)$aggregate
jacBlood <- predJaccardPlots(smrBlood$predictions,
                             labelSize=labelSize,
                             legendTitle='Jaccard',
                             limits=c(0, 1),
                             showNumbers=FALSE)$aggregate

invisible(mapply(function(i, plotName){
    p <- quadPlot(list(mdsPanc, jacPanc),
                  list(mdsLung, jacLung),
                  list(mdsMerkel, jacMerkel),
                  list(mdsBlood, jacBlood), i, removeYLab=FALSE)
    pdf(paste0('Figure ', plotName, '.pdf'), width = 12, height = 8)
    print(p)
    dev.off()
}, c(1, 2),
c('S4', 'S5')))
