hashMap <- function(hashKeys, hashValues){
    hashNames <- unlist(hashKeys)
    hash <- unlist(mapply(function(x, y) rep(y, length(x)), hashKeys, hashValues))
    names(hash) <- hashNames
    return(hash)
}

updateHashKeys <- function(df, colStr, hashKeys){
    hashKeys[[length(hashKeys) + 1]] <- setdiff(unique(df[[colStr]]),
                                                unlist(hashKeys))
    return(hashKeys)
}

addCategory <- function(df, colStr, newColStr, hashKeys, hashValues){
    remainder <- setdiff(unique(df[[colStr]]), unlist(hashKeys))
    if (length(hashKeys) + 1 == length(hashValues))
        hashKeys <- updateHashKeys(df, colStr, hashKeys)
    else if (length(remainder) > 0){
        hashKeys <- c(hashKeys, remainder)
        hashValues <- c(hashValues, remainder)
    }
    hash <- hashMap(hashKeys, hashValues)
    df[[newColStr]] <- hash[as.character(df[[colStr]])]
    return(df)
}

addSeuratCategory <- function(seuratObj,
                              colStr,
                              newColStr,
                              hashKeys,
                              hashValues,
                              newColStr2 = NULL,
                              hashValues2 = NULL){
    seuratObj[[]] <- addCategory(seuratObj[[]], colStr, newColStr,
                                 hashKeys, hashValues)
    if (!is.null(newColStr2))
    {
        hashValues2 <- unlist(lapply(hashValues2, function(x)
            paste0(x, collapse = '/')))
        seuratObj[[]] <- addCategory(seuratObj[[]], colStr, newColStr2,
                                     hashKeys, hashValues2)
    }
    return(seuratObj)
}



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
