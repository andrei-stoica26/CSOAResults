benchmark <- function(){
    seuratPanc <- qs_read('seuratPancGSA.qs2')
    seuratLung <- qs_read('seuratLungGSA.qs2')
    seuratLiver <- qs_read('seuratLiverGSA.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsLiver <- qs_read('geneSetsLiver.qs2')

    gsaMethods <- supportedMethods()

    smrPanc <- runBenchmark(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(smrPanc, 'smrPanc.qs2')

    smrLung <- runBenchmark(seuratLung, 'celltype', geneSetsLung, gsaMethods)
    qs_save(smrLung, 'smrLung.qs2')

    smrLiver <- runBenchmark(seuratLiver, 'celltype', geneSetsLiver, gsaMethods)
    qs_save(smrLiver, 'smrLiver.qs2')

}
