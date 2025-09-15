chooseUMAPDims <- function(seuratObj, reduction='pca'){
    pct <- seuratObj[[reduction]]@stdev /
        sum(seuratObj[[reduction]]@stdev) * 100
    nUMAPDims <- sort(which((pct[1:length(pct) - 1] -
                                 pct[2:length(pct)]) > 0.1),
                      decreasing=TRUE)[1] + 1
    return(nUMAPDims)
}

findRareFeatures <- function(seuratObj, nCells = 10){
    assayData <- LayerData(seuratObj, layer = "counts")
    df <- data.frame(Count = rowSums(assayData != 0))
    df <- subset(df, Count < nCells)
    return(df)
}

removeRareFeatures <- function(seuratObj, nCells = 10, assay = 'RNA'){
    DefaultAssay(seuratObj) <- assay
    rareFeatures <- findRareFeatures(seuratObj, nCells)
    freqFeatures <- setdiff(rownames(seuratObj), rownames(rareFeatures))
    message(paste0('Removing features found in less than ', nCells, ' cells...'))
    seuratObj[[assay]] <- subset(seuratObj[[assay]], features = freqFeatures)
    message(paste0(length(rownames(rareFeatures))), ' rare features removed.')
    return(seuratObj)
}

processSeurat <- function(seuratObj, fileName=NULL){
    seuratObj <- FindVariableFeatures(seuratObj)
    seuratObj <- ScaleData(seuratObj)
    seuratObj <- RunPCA(seuratObj)
    nUMAPDims <- chooseUMAPDims(seuratObj)
    message(nUMAPDims, ' PCA dimensions will be used for UMAP.')
    seuratObj <- RunUMAP(seuratObj, dims=seq(nUMAPDims))
    if(!is.null(fileName))
        qsave(seuratObj, paste0(fileName, '.qs'))
    return(seuratObj)
}

metadataDF(seuratLung) <- addMetadataCategory(seuratLung,
                                      'cluster',
                                      'celltype2',
                                      list(c(0, 1, 3, 4, 6, 10, 16),
                                           c(2, 5, 8, 11, 15),
                                           7,
                                           9,
                                           12,
                                           13,
                                           14,
                                           17,
                                           18,
                                           19,
                                           20,
                                           21,
                                           22),
                                      c('Fibroblasts',
                                        'PulmonaryAlveolarIICells',
                                        'BasalCells',
                                        'LuminalEpithelialCells',
                                        'SmoothMuscleCells',
                                        'EpendymalCells',
                                        'Keratinocytes',
                                        'EndothelialCells',
                                        'MesothelialCells',
                                        'DendriticCells',
                                        'TCells',
                                        'BCells',
                                        'HepaticStellateCells'))
