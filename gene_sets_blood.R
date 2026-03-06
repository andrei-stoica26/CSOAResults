seuratBlood <- qs_read('seuratBlood.qs2')

markerList <- buildMarkerList(seuratBlood, logFCThr = 0.1, minPct = 0.1) %>%
    lapply(function(marker_df) {
        filter(marker_df, pct.2 < 0.2& avg_log2FC > 0.2)
    })

erList <- lapply(markerList, function(marker_df) {
    marker_genes <- rownames(marker_df)
    genesER(marker_genes, species = 'human')
})

unique(unlist(lapply(df[df$Description %in% terms, ]$geneID,
                     function(x) str_split(x, "/")[[1]])))

geneSetsBlood <- list(termGenes(erList[["0"]],
                                'immune response-regulating signaling pathway'),
                      termGenes(erList[["3"]],
                                'B cell receptor signaling pathway'),
                      termGenes(erList[["4"]],
                                'cell killing'),
                      termGenes(erList[["8"]],
                                'positive regulation of leukocyte activation')
)

names(geneSetsBlood) <- c('immune.response.regulating.signaling.pathway',
                          'B.cell.receptor.signaling.pathway',
                          'cell.killing',
                          'positive.regulation.of.leukocyte.activation'
)

qs_save(geneSetsBlood, 'geneSetsBlood.qs2')
