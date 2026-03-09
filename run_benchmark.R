benchmark <- function(){
    seuratPanc <- qs_read('seuratPancGSA.qs2')
    seuratLung <- qs_read('seuratLungGSA.qs2')
    seuratBreast <- qs_read('seuratBreastGSA.qs2')
    seuratBlood <- qs_read('seuratBloodGSA.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsBreast <- qs_read('geneSetsBreast.qs2')
    geneSetsBlood <- qs_read('geneSetsBlood.qs2')

    gsaMethods <- supportedMethods()

    smrPanc <- runBenchmark(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(smrPanc, 'smrPanc.qs2')

    smrLung <- runBenchmark(seuratLung, 'celltype', geneSetsLung, gsaMethods)
    qs_save(smrLung, 'smrLung.qs2')

    smrBreast <- runBenchmark(seuratBreast, 'funct', geneSetsBreast, gsaMethods)
    qs_save(smrBreast, 'smrBreast.qs2')

    smrBlood <- runBenchmark(seuratBlood, 'funct', geneSetsBlood, gsaMethods)
    qs_save(smrBlood, 'smrBlood.qs2')
}
