TEXT_SIZE <- 4

editSubplot <- function(p, legendPos='right', legendTitle=NULL)
    return(p + labs(x=NULL, y=NULL, title=legendTitle) +
               theme(legend.position=legendPos,
                     legend.text=element_text(size=TEXT_SIZE, color='black'),
                     legend.title=element_text(size=TEXT_SIZE, color='black'),
                     legend.key.size=unit(0.3, 'cm'),
                     legend.direction='vertical',
                     legend.location='plot',
                     legend.margin=margin(0, 0, 0, 0),
                     axis.text=element_text(size=TEXT_SIZE, color='black')))

quadPlot <- function(plots1, plots2, plots3, plots4, i,
                     legendPos='bottom',
                     legendTitle = NULL){
    p <- (editSubplot(plots1[[i]], legendPos, legendTitle) +
              editSubplot(plots2[[i]], legendPos, legendTitle)) /
        (editSubplot(plots3[[i]], legendPos, legendTitle) +
             editSubplot(plots4[[i]], legendPos, legendTitle)) +
        plot_annotation(tag_levels='A',
                        theme=theme(plot.title=element_text(size=TEXT_SIZE - 1)))
    return(p)
}

octoPlot <- function(plots1, plots2, plots3, plots4, i, j,
                     legendPos='right',
                     legendTitle = NULL){
    p <- (editSubplot(plots1[[i]], legendPos, legendTitle) + editSubplot(plots2[[i]], legendPos, legendTitle)) /
        (editSubplot(plots3[[i]], legendPos, legendTitle) + editSubplot(plots4[[i]], legendPos, legendTitle)) /
        (editSubplot(plots1[[j]], legendPos, legendTitle) + editSubplot(plots2[[j]], legendPos, legendTitle)) /
        (editSubplot(plots3[[j]], legendPos, legendTitle) + editSubplot(plots4[[j]], legendPos, legendTitle)) +
        plot_annotation(tag_levels='A',
                        theme=theme(plot.title=element_text(size=TEXT_SIZE - 1)))
    return(p)
}
