benchmark <- function(){
    seuratPanc <- qs_read('seuratPancGSA.qs2')
    seuratLung <- qs_read('seuratLungGSA.qs2')
    seuratMerkel <- qs_read('seuratMerkelGSA.qs2')
    seuratBlood <- qs_read('seuratBloodGSA.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsMerkel <- qs_read('geneSetsMerkel.qs2')
    geneSetsBlood <- qs_read('geneSetsBlood.qs2')

    gsaMethods <- supportedMethods()

    smrPanc <- runBenchmark(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qs_save(smrPanc, 'smrPanc.qs2')

    smrLung <- runBenchmark(seuratLung, 'celltype', geneSetsLung, gsaMethods)
    qs_save(smrLung, 'smrLung.qs2')

    smrMerkel <- runBenchmark(seuratMerkel, 'funct', geneSetsMerkel, gsaMethods)
    qs_save(smrMerkel, 'smrMerkel.qs2')

    smrBlood <- runBenchmark(seuratBlood, 'funct', geneSetsBlood, gsaMethods)
    qs_save(smrBlood, 'smrBlood.qs2')
}
