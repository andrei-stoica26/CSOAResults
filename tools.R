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
                          varsToRegress = NULL){
    seuratObj <- removeRareGenes(seuratObj, minFeatCells)
    seuratObj <- NormalizeData(seuratObj)
    seuratObj <- FindVariableFeatures(seuratObj)
    seuratObj <- ScaleData(seuratObj, vars.to.regress=varsToRegress)
    seuratObj <- RunPCA(seuratObj)
    nUMAPDims <- chooseUMAPDims(seuratObj)
    message(nUMAPDims, ' PCA dimensions will be used for UMAP.')
    seuratObj <- RunUMAP(seuratObj, dims=seq(nUMAPDims))
    return(seuratObj)
}

findMarkers <- function(seuratObj, id1, groupBy='funct',
                        minPct=0.2, logFCThr=1, minRatio=5, ...){
    res <- FindMarkers(seuratObj,
                       group.by=groupBy,
                       ident.1=id1,
                       only.pos=TRUE,
                       min.pct=minPct,
                       logfc.threshold=logFCThr,
                       ...)
    res$pct.ratio <- res$pct.1 / res$pct.2
    res <- subset(res, pct.ratio >= minRatio)
    res <- res[order(res$pct.ratio, decreasing=TRUE), ]
    return(res)
}

clusterMean <- function(seuratObj, genes, clusters, doNormalize = T){
    message('Filtering expression matrix...')
    expression <- as.matrix(LayerData(seuratObj, layer='data')[genes, ])
    df <- data.table::transpose(data.frame(lapply(clusters, function(x){
        message('Assesing mean expression of selected genes in cluster ', x, '...')
        clusterExp <- expression[, which(seuratObj$seurat_clusters == x), drop = F]
        return(rowMeans(clusterExp))
    })))

    if(doNormalize){
        colList <- as.list(df)
        maxima <- apply(df, 2, max)
        df <- data.frame(mapply(function(x, y) x / y, colList, maxima))
        colnames(df) <- genes
    }
    rownames(df) <- clusters

    df$Mean <- rowMeans(df)
    df <- df[order(df$Mean, decreasing = T), ]
    df <- round(df, 2)
    return(df)
}
