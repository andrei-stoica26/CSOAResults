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
