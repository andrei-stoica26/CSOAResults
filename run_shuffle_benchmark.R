shuffleBenchmark <- function(){
    seuratPanc <- qs_read('seuratPancShuffle.qs2')
    seuratLung <- qs_read('seuratLungShuffle.qs2')
    seuratBreast <- qs_read('seuratBreastShuffle.qs2')
    seuratBlood <- qs_read('seuratBloodShuffle.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsBreast <- qs_read('geneSetsBreast.qs2')
    geneSetsBlood <- qs_read('geneSetsBlood.qs2')

    smrPancShuffle <- runBenchmarkShuffle(seuratPanc, 'label',
                                          geneSetsPanc, 'CSOA')
    qs_save(smrPancShuffle, 'smrPancShuffle.qs2')

    smrLungShuffle <- runBenchmarkShuffle(seuratLung, 'celltype',
                                          geneSetsLung, 'CSOA')
    qs_save(smrLungShuffle, 'smrLungShuffle.qs2')

    smrBreastShuffle <- runBenchmarkShuffle(seuratBreast, 'funct',
                                            geneSetsBreast, 'CSOA')
    qs_save(smrBreastShuffle, 'smrBreastShuffle.qs2')

    smrBloodShuffle <- runBenchmarkShuffle(seuratBlood, 'funct',
                                           geneSetsBlood, 'CSOA')
    qs_save(smrBloodShuffle, 'smrBloodShuffle.qs2')
}
