seuratPanc <- qread('seuratPanc.qs')
seuratLung <- qread('seuratLung.qs')
seuratBreast <- qread('seuratBreast.qs')

geneSetsPanc <- qread('geneSetsPanc.qs')
geneSetsLung <- qread('geneSetsLung.qs')
geneSetsBreast <- qread('geneSetsBreast.qs')

gsaMethods <- supportedMethods()

seuratPanc <- timeFun(runGSAMethods, seuratPanc, 'label', geneSetsPanc,
                      gsaMethods)
qsave(seuratPanc, 'seuratPancGSA.qs')

seuratLung <- timeFun(runGSAMethods, seuratLung, 'celltype', geneSetsLung,
                      gsaMethods)
qsave(seuratPanc, 'seuratLungGSA.qs')

seuratBreast <- timeFun(runGSAMethods, seuratBreast, 'funct', geneSetsBreast,
                      gsaMethods)
qsave(seuratBreast, 'seuratBreastGSA.qs')

smrPanc <-  timeFun(runBenchmark, seuratPanc, 'label', geneSetsPanc,
                    gsaMethods)
qsave(smrPanc, 'smrPanc.qs')

smrLung <-  timeFun(runBenchmark, seuratLung, 'celltype', geneSetsLung,
                    gsaMethods)
qsave(smrLung, 'smrLung.qs')

smrBreast <-  timeFun(runBenchmark, seuratBreast, 'funct', geneSetsBreast,
                    gsaMethods)
qsave(smrBreast, 'smrBreast.qs')

smrBlood <- qread('Peripheral blood mononuclear cells.qs')
qsave(smrBlood, 'smrBlood.qs')

smrBreast
p <- allBenchmarkPlots(smrBreast)
p[[2]]
