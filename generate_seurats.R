################################Baron pancreas human############################
seuratPanc <- BaronPancreasData('human')
seuratPanc <- logNormCounts(seuratPanc)
seuratPanc <- as.Seurat(seuratPanc)
seuratPanc <- processSeurat(seuratPanc, 'seuratPanc')

#############################Lung proximal airway stromal#######################
load('SRA640325_SRS2769051.sparse.RData')
rownames(sm) <- make.unique(gsub('_.*', '', rownames(sm)))
clusterInfo <- read.table('SRA640325_SRS2769051.clusters.txt')
sm <- sm[, clusterInfo$V1]
seuratLung <- CreateSeuratObject(sm,
                                 project='lungProximalAirwayStromal')
seuratLung <- removeRareGenes(seuratLung, 10)
seuratLung <- NormalizeData(seuratLung)
seuratLung <- processSeurat(seuratLung)

seuratLung$cluster <- clusterInfo$V2
seuratLung <- addMetadataCategory(seuratLung,
                                  'cluster',
                                  'celltype',
                                  list(c(0, 1, 3, 4, 6, 10, 16),
                                       c(2, 5, 8, 11, 15),
                                       7,
                                       9,
                                       12,
                                       13,
                                       14,
                                       17,
                                       18,
                                       19,
                                       20,
                                       21,
                                       22),
                                  c('Fibroblasts',
                                    'PulmonaryAlveolarIICells',
                                    'BasalCells',
                                    'LuminalEpithelialCells',
                                    'SmoothMuscleCells',
                                    'EpendymalCells',
                                    'Keratinocytes',
                                    'EndothelialCells',
                                    'MesothelialCells',
                                    'DendriticCells',
                                    'TCells',
                                    'BCells',
                                    'HepaticStellateCells'))
qsave(seuratLung, 'seuratLung.qs')

#############################Breast cancer cell line############################
load('SRA704181_SRS3305832.sparse.RData')
rownames(sm) <- make.unique(gsub('_.*', '', rownames(sm)))
seuratBreast <- CreateSeuratObject(sm, project='breastCancer')

seuratBreast  <- PercentageFeatureSet(seuratBreast,
                                      pattern = "^MT-",
                                      col.name = "percent.mt")
seuratBreast  <- PercentageFeatureSet(seuratBreast,
                                      pattern="^RP[SL][[:digit:]]|^RPLP[[:digit:]]|^RPSA",
                                      col.name="percent.ribo")

seuratBreast <- subset(seuratBreast, percent.mt < 10)
seuratBreast <- processSeurat(seuratBreast, varsToRegress=c('nCount_RNA',
                                                            'percent.mt',
                                                            'percent.ribo'))

seuratBreast <- FindNeighbors(seuratBreast, reduction='umap', dims=1:2)
seuratBreast <- FindClusters(seuratBreast, resolution=0.13)
seuratBreast <- addMetadataCategory(seuratBreast,
                                    'seurat_clusters',
                                    'funct',
                                    list(c(0, 4), 1, 2, 3, 5),
                                    c('Bulk cells',
                                      'DNA.replication',
                                      'TGF.beta.response',
                                      'Chromosome.segregation',
                                      'ncRNA.processing'))
qsave(seuratBreast, 'seuratBreast.qs')

########################Peripheral blood mononuclear cells######################
load('SRA550660_SRS2089639.sparse.RData')
rownames(sm) <- make.unique(gsub('_.*', '', rownames(sm)))
clusterInfo <- read.table("SRA550660_SRS2089639.clusters.txt")
sm <- sm[, clusterInfo$V1]

seuratBlood <- CreateSeuratObject(counts = sm, project = "pbmc")
seuratBlood$seurat_clusters <- clusterInfo$V2
seuratBlood <- subset(seuratBlood, subset = !(seurat_clusters %in% c("8", "12")))


seuratBlood  <- PercentageFeatureSet(seuratBlood,
                                     pattern = "^MT-",
                                     col.name = "percent.mt")
seuratBlood  <- PercentageFeatureSet(seuratBlood,
                                     pattern="^RP[SL][[:digit:]]|^RPLP[[:digit:]]|^RPSA",
                                     col.name="percent.ribo")

seuratBlood <- subset(seuratBlood, subset = percent.mt < 5)
seuratBlood <- processSeurat(seuratBlood,  varsToRegress = 'percent.ribo')
seuratBlood <- FindNeighbors(seuratBlood, reduction='umap', dims=1:2)
seuratBlood <- FindClusters(seuratBlood, resolution=0.1)
seuratBlood <- addMetadataCategory(seuratBlood,
                                   'seurat_clusters',
                                   'funct',
                                   list(c(1,2,5,6,7,9,10),0,3,4,8),
                                   c('Bulk.cells',
                                     'immune.response.regulating.signaling.pathway',
                                     'B.cell.receptor.signaling.pathway',
                                     'cell.killing',
                                     'positive.regulation.of.leukocyte.activation'))

qsave(seuratBlood,'seuratBlood.qs')
