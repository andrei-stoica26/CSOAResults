shuffleBenchmark <- function(){
    seuratPanc <- qs_read('seuratPancShuffle.qs2')
    seuratLung <- qs_read('seuratLungShuffle.qs2')
    seuratMerkel <- qs_read('seuratMerkelShuffle.qs2')
    seuratBlood <- qs_read('seuratBloodShuffle.qs2')

    geneSetsPanc <- qs_read('geneSetsPanc.qs2')
    geneSetsLung <- qs_read('geneSetsLung.qs2')
    geneSetsMerkel <- qs_read('geneSetsMerkel.qs2')
    geneSetsBlood <- qs_read('geneSetsBlood.qs2')

    smrPancShuffle <- runBenchmarkShuffle(seuratPanc, 'label',
                                          geneSetsPanc, 'CSOA')
    qs_save(smrPancShuffle, 'smrPancShuffle.qs2')

    smrLungShuffle <- runBenchmarkShuffle(seuratLung, 'celltype',
                                          geneSetsLung, 'CSOA')
    qs_save(smrLungShuffle, 'smrLungShuffle.qs2')

    smrMerkelShuffle <- runBenchmarkShuffle(seuratMerkel, 'funct',
                                            geneSetsMerkel, 'CSOA')
    qs_save(smrMerkelShuffle, 'smrMerkelShuffle.qs2')

    smrBloodShuffle <- runBenchmarkShuffle(seuratBlood, 'funct',
                                           geneSetsBlood, 'CSOA')
    qs_save(smrBloodShuffle, 'smrBloodShuffle.qs2')
}
