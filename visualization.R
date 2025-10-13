editSubplot <- function(p)
    return(p + labs(x=NULL, y=NULL, title=NULL) +
               theme(legend.position='bottom',
                     legend.text=element_text(size=6, color='black'),
                     legend.title=element_blank(),
                     legend.key.size=unit(0.3, 'cm'),
                     legend.direction='vertical',
                     legend.location='plot',
                     legend.margin=margin(0, 0, 0, 0),
                     axis.text=element_text(size=8, color='black')))

quadPlot <- function(plots1, plots2, plots3, plots4, i){
    p <- (editSubplot(plots1[[i]]) + editSubplot(plots2[[i]])) /
        (editSubplot(plots3[[i]]) + editSubplot(plots4[[i]])) +
        plot_annotation(tag_levels='A',
                        theme=theme(plot.title=element_text(size=7)))
    return(p)
}
