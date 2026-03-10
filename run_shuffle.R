runShuffle <- function(){
    seuratPanc <- qs_read('seuratPancGSA.qs2')
    seuratLung <- qs_read('seuratLungGSA.qs2')
    seuratMerkel <- qs_read('seuratMerkelGSA.qs2')
    seuratBlood <- qs_read('seuratBloodGSA.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsMerkel <- qs_read('geneSetsMerkel.qs2')
    geneSetsBlood <- qs_read('geneSetsBlood.qs2')

    loss <- c(0.2, 0.5, 0.8)
    noise <- c(0.2, 0.5, 0.8)
    seeds <- seq(10)

    seuratPanc <- runMethodShuffle(seuratPanc, 'label', geneSetsPanc, 'CSOA',
                                   loss, noise, seeds = seeds)
    qs_save(seuratPanc, 'seuratPancShuffle.qs2')

    seuratLung <- runMethodShuffle(seuratLung, 'celltype', geneSetsLung,
                                   'CSOA', loss, noise, seeds = seeds)
    qs_save(seuratLung, 'seuratLungShuffle.qs2')

    seuratMerkel <- runMethodShuffle(seuratMerkel, 'funct', geneSetsMerkel,
                                     'CSOA', loss, noise, seeds = seeds)
    qs_save(seuratMerkel, 'seuratMerkelShuffle.qs2')

    seuratBlood <- runMethodShuffle(seuratBlood, 'funct', geneSetsBlood,
                           'CSOA', loss, noise, seeds = seeds)
    qs_save(seuratBlood, 'seuratBloodShuffle.qs2')
}
