################################Baron Pancreas human############################

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
seuratLung <- removeRareFeatures(seuratLung, 10)
seuratLung <- NormalizeData(seuratLung)
seuratLung <- processSeurat(seuratLung)

seuratLung$cluster <- clusterInfo$V2
seuratLung <- addSeuratCategory(seuratLung, 'cluster', 'celltype',
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
