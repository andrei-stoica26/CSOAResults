runShuffle <- function(){
    seuratPanc <- qread('seuratPancGSA.qs')
    seuratLung <- qread('seuratLungGSA.qs')
    seuratBreast <- qread('seuratBreastGSA.qs')
    seuratBlood <- qread('seuratBloodGSA.qs')

    geneSetsPanc <- qread('geneSetsPanc.qs')
    geneSetsLung <- qread('geneSetsLung.qs')
    geneSetsBreast <- qread('geneSetsBreast.qs')
    geneSetsBlood <- qread('geneSetsBlood.qs')

    loss <- c(0.2, 0.5, 0.8)
    noise <- c(0.2, 0.5, 0.8)

    seuratPanc <- timeFun(runMethodShuffle, seuratPanc, 'label', geneSetsPanc,
                          'CSOA', loss, noise)
    qsave(seuratPanc, 'seuratPancShuffle.qs')

    seuratLung <- timeFun(runMethodShuffle, seuratLung, 'celltype', geneSetsLung,
                          'CSOA', loss, noise)
    qsave(seuratLung, 'seuratLungShuffle.qs')

    seuratBreast <- timeFun(runMethodShuffle, seuratBreast, 'funct', geneSetsBreast,
                            'CSOA', loss, noise)
    qsave(seuratBreast, 'seuratBreastShuffle.qs')

    seuratBlood <- timeFun(runMethodShuffle, seuratBlood, 'funct', geneSetsBlood,
                           'CSOA', loss, noise)
    qsave(seuratBlood, 'seuratBloodShuffle.qs')
}


