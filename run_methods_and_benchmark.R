seuratPanc <- qread('seuratPanc.qs')
seuratLung <- qread('seuratLung.qs')
seuratBreast <- qread('seuratBreast.qs')
seuratBlood <- qread('seuratBlood.qs')

geneSetsPanc <- qread('geneSetsPanc.qs')
geneSetsLung <- qread('geneSetsLung.qs')
geneSetsBreast <- qread('geneSetsBreast.qs')
geneSetsBlood <- qread('geneSetsBlood.qs')

gsaMethods <- supportedMethods()

seuratPanc <- timeFun(runGSAMethods, seuratPanc, 'label', geneSetsPanc,
                      gsaMethods)
qsave(seuratPanc, 'seuratPancGSA.qs')

seuratLung <- timeFun(runGSAMethods, seuratLung, 'celltype', geneSetsLung,
                      gsaMethods)
qsave(seuratLung, 'seuratLungGSA.qs')

seuratBreast <- timeFun(runGSAMethods, seuratBreast, 'funct', geneSetsBreast,
                      gsaMethods)
qsave(seuratBreast, 'seuratBreastGSA.qs')

seuratBlood <- timeFun(runGSAMethods, seuratBlood, 'funct', geneSetsBlood,
                        gsaMethods) 
qsave(seuratBlood, 'seuratBloodGSA.qs')

seuratPanc <- qread('seuratPancGSA.qs')
seuratLung <- qread('seuratLungGSA.qs')
seuratBreast <- qread('seuratBreastGSA.qs')
seuratBlood <- qread('seuratBloodGSA.qs')

smrPanc <- timeFun(runBenchmark, seuratPanc, 'label', geneSetsPanc,
                    gsaMethods)
qsave(smrPanc, 'smrPanc.qs')

smrLung <- timeFun(runBenchmark, seuratLung, 'celltype', geneSetsLung,
                    gsaMethods)
qsave(smrLung, 'smrLung.qs')

smrBreast <- timeFun(runBenchmark, seuratBreast, 'funct', geneSetsBreast,
                    gsaMethods)
qsave(smrBreast, 'smrBreast.qs')

smrBlood <- timeFun(runBenchmark,seuratBlood1, 'funct', geneSetsBlood,
                    gsaMethods)
qsave(smrBlood, 'smrBlood.qs')