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

    smrPanc <- runBenchmark(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qsave(smrPanc, 'smrPanc.qs')

    smrLung <- runBenchmark(seuratLung, 'celltype', geneSetsLung, gsaMethods)
    qsave(smrLung, 'smrLung.qs')

    smrBreast <- runBenchmark(seuratBreast, 'funct', geneSetsBreast, gsaMethods)
    qsave(smrBreast, 'smrBreast.qs')

    smrBlood <- runBenchmark(seuratBlood, 'funct', geneSetsBlood, gsaMethods)
    qsave(smrBlood, 'smrBlood.qs')
}
