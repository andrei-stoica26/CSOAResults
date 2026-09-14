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

hepatocyteMarkers <- generateMarkers(df, 'Hepatocytes')
endothelialMarkers <- generateMarkers(df, 'Endothelial cells')
kupfferMarkers <- generateMarkers(df, 'Kupffer cells')

geneSetsLiver <- list(hepatocyteMarkers, endothelialMarkers, kupfferMarkers)

geneSetsLiver <- lapply(geneSetsLiver, function(x)
    intersect(x, rownames(seuratLiver)))
names(geneSetsLiver) <- c('Hepatocytes',
                         'EndothelialCells',
                         'KupfferCells')
qs_save(geneSetsLiver, 'geneSetsLiver.qs2')

