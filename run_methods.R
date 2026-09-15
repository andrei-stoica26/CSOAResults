runMethods <- function(){
    seuratPanc <- qs_read('seuratPanc.qs2')
    seuratLung <- qs_read('seuratLung.qs2')
    seuratLiver <- qs_read('seuratLiver.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsLiver <- qs_read('geneSetsLiver.qs2')

    gsaMethods <- supportedMethods()

    seuratPanc <- runGSAMethods(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(seuratPanc, 'seuratPancGSA.qs2')

    seuratLung <- runGSAMethods(seuratLung, 'celltype', geneSetsLung,
                                gsaMethods)
    qs_save(seuratLung, 'seuratLungGSA.qs2')

    seuratLiver <- runGSAMethods(seuratLiver, 'celltype', geneSetsLiver,
                                  gsaMethods)
    qs_save(seuratLiver, 'seuratLiverGSA.qs2')
}
