runMethods <- function(){
    seuratPanc <- qs_read('seuratPanc.qs2')
    seuratLung <- qs_read('seuratLung.qs2')
    seuratMerkel <- qs_read('seuratMerkel.qs2')
    seuratBlood <- qs_read('seuratBlood.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsMerkel <- qs_read('geneSetsMerkel.qs2')
    geneSetsBlood <- qs_read('geneSetsBlood.qs2')

    gsaMethods <- supportedMethods()

    seuratPanc <- runGSAMethods(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(seuratPanc, 'seuratPancGSA.qs2')

    seuratLung <- runGSAMethods(seuratLung, 'celltype', geneSetsLung,
                                gsaMethods)
    qs_save(seuratLung, 'seuratLungGSA.qs2')

    seuratMerkel <- runGSAMethods(seuratMerkel, 'funct', geneSetsMerkel,
                                  gsaMethods)
    qs_save(seuratMerkel, 'seuratMerkelGSA.qs2')

    seuratBlood <- runGSAMethods(seuratBlood, 'funct', geneSetsBlood,
                                 gsaMethods)
    qs_save(seuratBlood, 'seuratBloodGSA.qs2')
}
