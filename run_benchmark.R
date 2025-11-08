benchmark <- function(){
    seuratPanc <- qread('seuratPancGSA.qs')
    seuratLung <- qread('seuratLungGSA.qs')
    seuratBreast <- qread('seuratBreastGSA.qs')
    seuratBlood <- qread('seuratBloodGSA.qs')

    geneSetsPanc <- qread('geneSetsPanc.qs')
    geneSetsLung <- qread('geneSetsLung.qs')
    geneSetsBreast <- qread('geneSetsBreast.qs')
    geneSetsBlood <- qread('geneSetsBlood.qs')

    gsaMethods <- supportedMethods()

    smrPanc <- timeFun(runBenchmark, seuratPanc, 'label', geneSetsPanc,
                       gsaMethods)
    qsave(smrPanc, 'smrPanc.qs')

    smrLung <- timeFun(runBenchmark, seuratLung, 'celltype', geneSetsLung,
                       gsaMethods)
    qsave(smrLung, 'smrLung.qs')

    smrBreast <- timeFun(runBenchmark, seuratBreast, 'funct', geneSetsBreast,
                         gsaMethods)
    qsave(smrBreast, 'smrBreast.qs')

    smrBlood <- timeFun(runBenchmark,seuratBlood, 'funct', geneSetsBlood,
                        gsaMethods)
    qsave(smrBlood, 'smrBlood.qs')
}

