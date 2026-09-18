library(readr)
library(gprofiler2)

df <- read_tsv("PanglaoDB_markers_27_Mar_2020.tsv")
df <- df[df$species %in% c('Mm Hs', 'Mm'), ]

generateMarkers <- function(df, cellType){
    markers <- df[df$`cell type` == cellType, ]$`official gene symbol`
    markers <- gorth(query = markers,
                     source_organism = "hsapiens",
                     target_organism = "mmusculus")$ortholog_name
    return(markers)
}

microgliaMarkers <- generateMarkers(df, 'Microglia')
tMarkers <- generateMarkers(df, 'T cells')
bMarkers <- generateMarkers(df, 'B cells')
macrophageMarkers <- generateMarkers(df, 'Macrophages')
nkMarkers <- generateMarkers(df, 'NK cells')
tmemoryMarkers <- generateMarkers(df, 'T memory cells')
neutrophilMarkers <- generateMarkers(df, 'Neutrophils')
nuocyteMarkers <- generateMarkers(df, 'Nuocytes')


geneSetsBrain <- list(microgliaMarkers,
                      tMarkers,
                      bMarkers,
                      macrophageMarkers,
                      nkMarkers,
                      tmemoryMarkers,
                      neutrophilMarkers,
                      nuocyteMarkers)

geneSetsBrain <- lapply(geneSetsBrain, function(x)
    intersect(x, rownames(seuratBrain)))
names(geneSetsBrain) <- c('Microglia',
                          'TCells',
                          'BCells',
                          'Macrophages',
                          'NKCells',
                          'TMemoryCells',
                          'Neutrophils',
                          'Nuocytes')

qs_save(geneSetsBrain, 'geneSetsBrain.qs2')

