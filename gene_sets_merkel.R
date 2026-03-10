seuratMerkel <- qs_read('seuratMerkel.qs2')

a <- findMarkers(seuratMerkel, id1='Antigen.processing', minRatio=5)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes1 <- termGenes(m, 'antigen processing and presentation of peptide antigen')

a <- findMarkers(seuratMerkel, id1='Chromosome.segregation', minRatio=5)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes2 <- termGenes(m, 'chromosome segregation')

a <- findMarkers(seuratMerkel, id1='ECM.organization', minRatio=5)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes3 <- termGenes(m, 'extracellular matrix organization')

geneSetsMerkel <- setNames(list(genes1, genes2, genes3),
                           c('Antigen.processing',
                             'Chromosome.segregation',
                             'ECM.organization'))

qs_save(geneSetsMerkel, 'geneSetsMerkel.qs2')

