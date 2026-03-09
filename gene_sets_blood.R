seuratBlood <- qs_read('seuratBlood.qs2')

a <- findMarkers(seuratBlood,id1='Cell.killing')
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes1 <- termGenes(m, 'cell killing')

a <- findMarkers(seuratBlood, id1='Chemotaxis')
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes2 <- termGenes(m, 'chemotaxis')

a <- findMarkers(seuratBlood, id1='Positive.regulation.of.cell.activation',
                 minRatio=2)
m <- genesER(rownames(a), 'human', returnDF=TRUE)
genes3 <- termGenes(m, 'positive regulation of cell activation')

geneSetsBlood <- setNames(list(genes1, genes2, genes3),
                          c('Cell.killing',
                            'Chemotaxis',
                            'Positive.regulation.of.cell.activation'))

qs_save(geneSetsBlood, 'geneSetsBlood.qs2')
