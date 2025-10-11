markerList <- buildMarkerList(seuratBreast, 'funct')
erList <- lapply(markerList, function(x) genesER(rownames(x), 'human'))

geneSetsBreast <- list(termGenes(erList[[1]], 'chromosome segregation'),
                       termGenes(erList[[2]], 'DNA replication'),
                       termGenes(erList[[4]], 'ncRNA processing'),
                       termGenes(erList[[5]], 'cellular response to transforming growth factor beta stimulus'))

names(geneSetsBreast) <- c('Chromosome.segregation', 'DNA.replication',
                           'ncRNA.processing', 'TGF.beta.response')

qsave(geneSetsBreast, 'geneSetsBreast.qs')
