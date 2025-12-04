geneCellCountDF <- function(nGenes = 20, minCells = 1000, maxCells = 35000){
    df <- data.frame(
        Gene = paste0("gene", 1:nGenes),
        nCells = sample(minCells:maxCells, nGenes)
    )
    df$nTopCells <- round(df$nCells / 10)
    return(df)
}

cellSetList <- function(nCellSets = 7, setCellsLimit = 12000, minSetSize = 1000,
                        maxSetSize = 4000, nCells = 40000){
    setCounts <- sample(minSetSize:maxSetSize, nCellSets)
    geneSets <- lapply(setCounts, function(x) sample(setCellsLimit, x))
    geneSets[[length(geneSets) + 1]] <- 1:nCells
    names(geneSets) <- c(paste0('CS', 1:nCellSets ), 'Cells')
    return(geneSets)
}
networkDF <- function(nOverlaps = 30, nOverlapGenes = 20){
    df <- data.frame(gene1 = paste0('gene', sample(nOverlapGenes - 1,
                                                   nOverlaps, replace = TRUE)))
    seen <- c()
    df$gene2 <- sapply(df$gene1, function(firstGene){
        start <- as.integer(str_replace(firstGene, 'gene', '')) + 1
        isUnique = FALSE
        while (!isUnique){
            secondGene <- paste0('gene', sample(start:nOverlapGenes, 1))
            pair <- paste0(firstGene, ' ', secondGene)
            if (!pair %in% seen){
                seen <<- c(seen, pair)
                isUnique = TRUE
            }

        }
        return(secondGene)
    }
    )
    df$rank <- seq_len(nOverlaps)
    return(df)
}

geneExpDF <- function(nGenes = 20,
                      nCells = 10000,
                      coefs = c(20, 40, 60, 80, 100, 120)){
    coefs <- sample(coefs, nGenes, replace = TRUE)
    df <- data.table::transpose(data.frame(lapply(coefs, function(x)
        runif(nCells, min = 0, max = 1) ^ x)))
    rownames(df) <- paste0('Gene', seq_len(nGenes))
    colnames(df) <- paste0('Cell', seq_len(nCells))
    df <- kerntools::minmax(df, rows = T)
    df$row <- seq_len(nrow(df))
    df <- pivot_longer(df, cols = -row, names_to = "column",
                       values_to = "value")
    return(df)
}

scoreDF <- function(nOverlaps = 20){
    overlapRange <- seq_len(nOverlaps)
    df <- data.frame(x = overlapRange,
                     y = log(seq(exp(1), 1,
                                 length.out = nOverlaps + 1)[overlapRange]))
    return(df)
}

editAxes <- function (p){
    p <- p + theme_classic() + theme(axis.ticks = element_blank(),
                                     axis.text = element_blank())
    return(p)
}

editLegend <- function(p){
    p <- p + theme(legend.text = element_text(size = 6),
                   legend.title = element_blank(),
                   legend.position = 'bottom',
                   legend.key.size = unit(0.2, 'cm'),
                   legend.box.spacing = unit(0, 'cm'))
    return(p)
}
