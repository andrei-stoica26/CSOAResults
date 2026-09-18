benchmark <- function(){
    seuratPanc <- qs_read('seuratPancGSA.qs2')
    seuratLung <- qs_read('seuratLungGSA.qs2')
    seuratBrain <- qs_read('seuratBrainGSA.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsBrain <- qs_read('geneSetsBrain.qs2')

    gsaMethods <- supportedMethods()

    smrPanc <- runBenchmark(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(smrPanc, 'smrPanc.qs2')

    smrLung <- runBenchmark(seuratLung, 'celltype', geneSetsLung, gsaMethods)
    qs_save(smrLung, 'smrLung.qs2')

    smrBrain <- runBenchmark(seuratBrain, 'celltype', geneSetsBrain, gsaMethods)
    qs_save(smrBrain, 'smrBrain.qs2')

}
