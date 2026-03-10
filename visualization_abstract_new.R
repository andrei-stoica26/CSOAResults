geneCellCountPlot <- function(df, fillColor, title){
    p <- ggplot(df, aes(x = Gene, y = nCells)) +
        geom_bar(stat = "identity", fill = fillColor, width = 0.6) +
        ylab('Number of cells') +
        xlab("Signature gene")
    p <- editAxes(p)
    p <- centerTitle(p, title)
    return(p)
}

eulerPlot <- function(geneSets,
                      title,
                      fills = c('white','blue',  'red', 'purple', 'green',
                                'orange', 'lavender', 'plum')){
    eulerObj <- euler(geneSets)
    p <- as.ggplot(plot(eulerObj, fills=fills,
                        labels=NULL
    ))
    p <- centerTitle(p, title)
    p <- p + theme(plot.title=element_text(size=ABS_TEXT_SIZE,
                                           color='black'))
    return(p)
}

prerankPlot <- function(df, title=NULL){
    p <- ggplot(df, aes(x = overlap, y = rank, fill = rankType)) +
        geom_col(position = "dodge") +
        labs(x = "Overlap", y = "Rank", fill = "Rank type") +
        scale_fill_manual(values = wes_palette('Darjeeling1')[c(2, 1)],
                          labels = c('p-value rank', 'Ratio rank'))
    p <- editAxes(p)
    p <- centerTitle(p, title)
    p <- editLegend(p)
    return(p)
}

prerankPlot2 <- function(df, title=NULL){
    p <- ggplot(df, aes(x = overlap, y = rank, fill = rankType)) +
        geom_col(position = "dodge") +
        labs(x = "Overlap", y = "Rank", fill = "Rank type") +
        scale_fill_manual(values = wes_palette('Darjeeling1')[c(2, 1, 3)],
                          labels = c('p-value rank', 'Ratio rank',
                                     'Aggregate rank'))
    p <- editAxes(p)
    p <- centerTitle(p, title)
    p <- editLegend(p)
    return(p)
}

