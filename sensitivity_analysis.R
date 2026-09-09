library(CSOA)
library(GSABenchmark)
library(Seurat)
library(qs2)

sensAnalysis <- function(seuratObj, geneSets, labelCol){
    types <- names(geneSets)
    for (percVal in c(70, 75, 80, 85, 90, 95)){
        markerSetNames <- paste0('CSOA', percVal, '_', types)
        names(geneSets) <- markerSetNames
        seuratObj <- runCSOA(seuratObj, geneSets, percentile=percVal)
    }
    names(geneSets) <- types
    smr <- runBenchmark(seuratObj,
                        labelCol,
                        geneSets,
                        c('CSOA70',
                          'CSOA75',
                          'CSOA80',
                          'CSOA85',
                          'CSOA90',
                          'CSOA95'),
                        runEFBenchmark=FALSE)
    return(smr)
}

seuratObj <- qs_read('seuratPanc.qs2')
geneSets <- qs_read('geneSetsPanc.qs2')
labelCol <- 'label'
smr <- sensAnalysis(seuratObj, geneSets, labelCol)

View(smr$boundary$avg)
View(smr$MCC$boundaryMCC)
View(smr$MCC$directMCC)
View(smr$global$avg)
View(smr$efficiency$space)

seuratObj <- qs_read('seuratLung.qs2')
geneSets <- qs_read('geneSetsLung.qs2')
labelCol <- 'celltype'
smr <- sensAnalysis(seuratObj, geneSets, labelCol)

View(smr$boundary$avg)
View(smr$MCC$boundaryMCC)
View(smr$MCC$directMCC)
View(smr$global$avg)
View(smr$efficiency$space)
