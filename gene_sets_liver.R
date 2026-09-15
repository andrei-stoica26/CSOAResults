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

endothelialMarkers <- generateMarkers(df, 'Endothelial cells')
hepatocyteMarkers <- generateMarkers(df, 'Hepatocytes')
kupfferMarkers <- generateMarkers(df, 'Kupffer cells')
tmemoryMarkers <- generateMarkers(df, 'T memory cells')
bMarkers <- generateMarkers(df, 'B cells')

geneSetsLiver <- list(endothelialMarkers, hepatocyteMarkers,
                      kupfferMarkers, tmemoryMarkers,
                      bMarkers)

geneSetsLiver <- lapply(geneSetsLiver, function(x)
    intersect(x, rownames(seuratLiver)))
names(geneSetsLiver) <- c('EndothelialCells',
                          'Hepatocytes',
                          'KupfferCells',
                          'TMemoryCells',
                          'BCells')
qs_save(geneSetsLiver, 'geneSetsLiver.qs2')

