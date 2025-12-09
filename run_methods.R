runMethods <- function(){
    seuratPanc <- qread('seuratPanc.qs')
    seuratLung <- qread('seuratLung.qs')
    seuratBreast <- qread('seuratBreast.qs')
    seuratBlood <- qread('seuratBlood.qs')

    geneSetsPanc <- qread('geneSetsPanc.qs')
    geneSetsLung <- qread('geneSetsLung.qs')
    geneSetsBreast <- qread('geneSetsBreast.qs')
    geneSetsBlood <- qread('geneSetsBlood.qs')

    timeFun(runssGSEA, 'time', FALSE, seuratPanc, geneSetsPanc[1])

    gsaMethods <- supportedMethods()

    seuratPanc <- runGSAMethods(seuratPanc, 'label', geneSetsPanc, gsaMethods)
    qsave(seuratPanc, 'seuratPancGSA.qs')

    seuratLung <- runGSAMethods(seuratLung, 'celltype', geneSetsLung,
                                gsaMethods)
    qsave(seuratLung, 'seuratLungGSA.qs')

    seuratBreast <- runGSAMethods(seuratBreast, 'funct', geneSetsBreast,
                                  gsaMethods)
    qsave(seuratBreast, 'seuratBreastGSA.qs')

    seuratBlood <- runGSAMethods(seuratBlood, 'funct', geneSetsBlood,
                                 gsaMethods)
    qsave(seuratBlood, 'seuratBloodGSA.qs')
}
