geneCellCountDF <- function(seed = 1,
                            nGenes = 30,
                            minCells = 1000,
                            maxCells = 35000){
    df <- data.frame(
        Gene = paste0("gene", 1:nGenes),
        nCells = with_seed(seed, sample(minCells:maxCells, nGenes))
    )
    df$nTopCells <- round(df$nCells / 10)
    return(df)
}

cellSetList <- function(seed = 1,
                        nCellSets = 8,
                        nCells = 10000,
                        minSetSize = 800,
                        maxSetSize = 3000){
    setCounts <- with_seed(seed, sample(minSetSize:maxSetSize, nCellSets))
    geneSets <- lapply(seq(setCounts),
                       function(i) with_seed(seed + i,
                                             sample(nCells, setCounts[i])))
    names(geneSets) <- paste0('Set', seq(nCellSets))
    return(geneSets)
}

rankDF <- function(seed = 1, nOverlaps = 30){
    df <- data.frame(overlap = factor(seq_len(nOverlaps)),
                     pvalRank = with_seed(seed, sample(nOverlaps)),
                     ratioRank = with_seed(seed + 1, sample(nOverlaps)))
    df <- melt(df,
               id.vars = c('overlap'),
               variable.name=('rankType'),
               value.name='rank')
    return(df)
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

overlapDF <- function(seed = 1, nOverlaps = 100){
    df <- data.frame(gene1=seq(nOverlaps),
                     gene2=seq(nOverlaps),
                     rank=with_seed(seed,
                                    rank(sort(ceiling(rnorm(nOverlaps,
                                                       mean=12, sd=4))),
                                         ties.method='min')))
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

scoreDF <- function(maxRank = 30, nOverlaps = 100){
    ranks <- sort(rank(with_seed(1, sample(maxRank, nOverlaps, replace=TRUE)),
                       ties.method='min'))
    rankVals <- unique(ranks)
    logVals <- log(seq(exp(1), 1, length.out =
                           length(rankVals) + 1))[seq_along(rankVals)]
    names(logVals) <- rankVals
    df <- data.frame(x = ranks,
                     y = logVals[as.character(ranks)])
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

editAxes2 <- function (p, axisTitleSize = 6){
    p <- p + theme_classic() + theme(axis.ticks.x = element_blank(),
                                     axis.text.x = element_blank(),
                                     axis.text.y = element_text(size = axisTitleSize - 1),
                                     axis.title = element_text(size = axisTitleSize))

    return(p)
}
