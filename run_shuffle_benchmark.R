shuffleBenchmark <- function(){
    seuratPanc <- qread('seuratPancShuffle.qs')
    seuratLung <- qread('seuratLungShuffle.qs')
    seuratBreast <- qread('seuratBreastShuffle.qs')
    seuratBlood <- qread('seuratBloodShuffle.qs')

    geneSetsPanc <- qread('geneSetsPanc.qs')
    geneSetsLung <- qread('geneSetsLung.qs')
    geneSetsBreast <- qread('geneSetsBreast.qs')
    geneSetsBlood <- qread('geneSetsBlood.qs')

    smrPancShuffle <- timeFun(runBenchmarkShuffle, seuratPanc, 'label', geneSetsPanc,
                          'CSOA')
    qsave(smrPancShuffle, 'smrPancShuffle.qs')

    smrLungShuffle <- timeFun(runBenchmarkShuffle, seuratLung, 'celltype', geneSetsLung,
                          'CSOA')
    qsave(smrLungShuffle, 'smrLungShuffle.qs')

    smrBreastShuffle <- timeFun(runBenchmarkShuffle, seuratBreast, 'funct', geneSetsBreast,
                            'CSOA')
    qsave(smrBreastShuffle, 'smrBreastShuffle.qs')

    smrBloodShuffle <- timeFun(runBenchmarkShuffle, smrBloodShuffle , 'funct', geneSetsBlood,
                           'CSOA')
    qsave(smrBloodShuffle , 'smrBloodShuffle ')
}
