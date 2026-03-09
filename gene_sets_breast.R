seuratBreast <- qs_read('seuratBreast.qs2')

a <- findMarkers(seuratBreast, id1='Chromosome.segregation', minRatio=4)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes1 <- termGenes(m, 'chromosome segregation')

a <- findMarkers(seuratBreast, id1='DNA.replication', minRatio=2)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes2 <- termGenes(m, 'DNA replication')

a <- findMarkers(seuratBreast, id1='TGF.beta.response', minRatio=2)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes3 <- termGenes(m, 'cellular response to transforming growth factor beta stimulus')

geneSetsBreast <- setNames(list(genes1, genes2, genes3),
                           c('Chromosome.segregation',
                             'DNA replication',
                             'cellular response to transforming growth factor beta stimulus'))

qs_save(geneSetsBreast, 'geneSetsBreast.qs2')

