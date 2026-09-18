runMethods <- function(){
    seuratPanc <- qs_read('seuratPanc.qs2')
    seuratLung <- qs_read('seuratLung.qs2')
    seuratBrain <- qs_read('seuratBrain.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsBrain <- qs_read('geneSetsBrain.qs2')

    gsaMethods <- supportedMethods()

    seuratPanc <- runGSAMethods(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(seuratPanc, 'seuratPancGSA.qs2')

    seuratLung <- runGSAMethods(seuratLung, 'celltype', geneSetsLung,
                                gsaMethods)
    qs_save(seuratLung, 'seuratLungGSA.qs2')

    seuratBrain <- runGSAMethods(seuratBrain, 'celltype', geneSetsBrain,
                                  gsaMethods)
    qs_save(seuratBrain, 'seuratBrainGSA.qs2')
}
