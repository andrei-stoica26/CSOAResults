chooseUMAPDims <- function(seuratObj, reduction='pca'){
    pct <- seuratObj[[reduction]]@stdev /
        sum(seuratObj[[reduction]]@stdev) * 100
    nUMAPDims <- sort(which((pct[1:length(pct) - 1] -
                                 pct[2:length(pct)]) > 0.1),
                      decreasing=TRUE)[1] + 1
    return(nUMAPDims)
}

processSeurat <- function(seuratObj,
                          minFeatCells = 10,
                          varsToRegress = NULL,
                          fileName = NULL){
    seuratObj <- removeRareGenes(seuratObj, minFeatCells)
    seuratObj <- NormalizeData(seuratObj)
    seuratObj <- FindVariableFeatures(seuratObj)
    seuratObj <- ScaleData(seuratObj, vars.to.regress=varsToRegress)
    seuratObj <- RunPCA(seuratObj)
    nUMAPDims <- chooseUMAPDims(seuratObj)
    message(nUMAPDims, ' PCA dimensions will be used for UMAP.')
    seuratObj <- RunUMAP(seuratObj, dims=seq(nUMAPDims))
    if(!is.null(fileName))
        qsave(seuratObj, paste0(fileName, '.qs'))
    return(seuratObj)
}
