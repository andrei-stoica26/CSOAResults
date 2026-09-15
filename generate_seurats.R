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

######################################Liver#####################################
load('SRA653146_SRS2874275.sparse.RData')
rownames(sm) <- make.unique(gsub('_.*', '', rownames(sm)))
clusterInfo <- read.table('SRA653146_SRS2874275.clusters.txt')
sm <- sm[, clusterInfo$V1]
seuratLiver <- CreateSeuratObject(sm, project='liver')
seuratLiver$cluster <- clusterInfo$V2
seuratLiver <- processSeurat(seuratLiver)
seuratLiver <- addMetadataCategory(seuratLiver,
                                  'cluster',
                                  'celltype',
                                  list(0,
                                       c(1, 3:5, 7:8, 10:15),
                                       2,
                                       6,
                                       9),
                                  c('EndothelialCells',
                                    'Hepatocytes',
                                    'KupfferCells',
                                    'TMemoryCells',
                                    'BCells'))
qs_save(seuratLiver, 'seuratLiver.qs2')

