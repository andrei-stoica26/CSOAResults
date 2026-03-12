editAxes <- function (p){
    p <- p + theme_classic() + theme(axis.ticks=element_blank(),
                                     axis.text=element_blank(),
                                     axis.title=element_text(size=ABS_TEXT_SIZE,
                                                             color='black'),
                                     plot.title=element_text(size=ABS_TEXT_SIZE,
                                                             color='black'))
    return(p)
}

editLegend <- function(p){
    p <- p + theme(legend.text = element_text(size = ABS_TEXT_SIZE - 2),
                   legend.title = element_blank(),
                   legend.position = 'bottom',
                   legend.key.size = unit(0.2, 'cm'),
                   legend.box.spacing = unit(0, 'cm'))
    return(p)
}

editAxes2 <- function (p){
    p <- p + theme_classic() + theme(axis.ticks.x=element_blank(),
                                     axis.text.x=element_blank(),
                                     axis.text.y=element_text(size=ABS_TEXT_SIZE,
                                                             color='black'),
                                     axis.title=element_text(size=ABS_TEXT_SIZE,
                                                             color='black'),
                                     plot.title=element_text(size=ABS_TEXT_SIZE,
                                                             color='black'))

    return(p)
}
