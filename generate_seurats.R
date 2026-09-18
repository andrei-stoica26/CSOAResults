################################Baron pancreas human############################
seuratPanc <- BaronPancreasData('human')
seuratPanc <- Seurat::as.Seurat(seuratPanc, data=NULL)
seuratPanc <- processSeurat(seuratPanc)
qs_save(seuratPanc, 'seuratPanc.qs2')

#############################Lung proximal airway stromal#######################
load('SRA640325_SRS2769051.sparse.RData')
rownames(sm) <- make.unique(gsub('_.*', '', rownames(sm)))
clusterInfo <- read.table('SRA640325_SRS2769051.clusters.txt')
sm <- sm[, clusterInfo$V1]
seuratLung <- CreateSeuratObject(sm,
                                 project='lungProximalAirwayStromal')
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
qs_save(seuratLung, 'seuratLung.qs2')

######################################Brain#####################################
load('SRA866994_SRS4545962.sparse.RData')
rownames(sm) <- make.unique(gsub('_.*', '', rownames(sm)))
clusterInfo <- read.table('SRA866994_SRS4545962.clusters.txt')
sm <- sm[, clusterInfo$V1]
seuratBrain <- CreateSeuratObject(sm, project='brain')
seuratBrain$cluster <- clusterInfo$V2
seuratBrain <- processSeurat(seuratBrain)
seuratBrain <- addMetadataCategory(seuratBrain,
                                  'cluster',
                                  'celltype',
                                  list(c(0, 1, 5, 15),
                                       c(2, 10),
                                       c(3, 16),
                                       c(4, 6, 9, 11),
                                       c(7, 12),
                                       c(8, 13),
                                       c(14, 18),
                                       17),
                                  c('Microglia',
                                    'TCells',
                                    'BCells',
                                    'Macrophages',
                                    'NKCells',
                                    'TMemoryCells',
                                    'Neutrophils',
                                    'Nuocytes'))
qs_save(seuratBrain, 'seuratBrain.qs2')

