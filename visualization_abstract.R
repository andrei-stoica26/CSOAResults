geneCellCountPlot <- function(df, yCol, fillColor, title){
    p <- ggplot(df, aes(x = Gene, y = {{yCol}})) +
        geom_bar(stat = "identity", fill = fillColor, width = 0.6) +
        ylab('Number of cells') +
        ylim(0, 40000) +
        xlab("Signature gene")
    p <- editAxes(p)
    p <- centerTitle(p, title)
    return(p)
}

eulerPlot <- function(geneSets,
                      title,
                      fills = c('blue', 'yellow', 'red', 'purple', 'green',
                                'orange', 'lavender', 'brown')){
    eulerObj <- euler(geneSets)
    p <- as.ggplot(plot(eulerObj, fills=fills,
                   labels=list(
                       font=rep(1, length(geneSets)),
                       cex=rep(0.4, length(geneSets)))
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

rankScorePlot <- function(df, title=NULL){
    p <- ggplot(df, aes(x, y)) + geom_line(color = 'mediumpurple4') +
        geom_point(color = 'red', size = 1) +
        labs(x = 'Overlap rank', y = 'Overlap score')
    p <- editAxes2(p)
    p <- centerTitle(p, title)
    return(p)
}

geneExpPlot <- function(df, title, ylab = 'Gene', colorIndex = 1){
    colorSchemes <- list(wes_palette('IsleofDogs1')[c(5, 1)],
                         wes_palette('Royal1')[c(3, 2)],
                         wes_palette('AsteroidCity2')[c(3, 5)]
    )
    p <- ggplot(df, aes(x = column, y = factor(row), fill = value)) +
        geom_tile() +
        scale_fill_gradientn(colors = colorSchemes[[colorIndex]], breaks = c(0, 0.5, 1)) +
        labs(x = 'Cell', y = ylab)
    p <- editAxes(p)
    p <- centerTitle(p, title)
    p <- editLegend(p)
    return(p)
}

scoreFeaturePlot <- function(seuratObj, feature, title){
    p <- FeaturePlot(seuratObj, feature)
    p <- editAxes(p)
    p <- centerTitle(p, title, face='plain')
    p <- editLegend(p)
    p <- p + scale_color_gradientn(colors = wes_palette('Royal1')[c(3, 2)],
                                   breaks = c(0, 0.5, 1))
    return(p)
}
