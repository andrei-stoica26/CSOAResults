octoPlot <- function(plots1, plots2, plots3, plots4, i, j,
                     legendPos='right',
                     legendTitle = NULL){
    p <- (editSubplot(plots1[[i]], legendPos, legendTitle) | editSubplot(plots2[[i]], legendPos, legendTitle)) /
        (editSubplot(plots3[[i]], legendPos, legendTitle) | editSubplot(plots4[[i]], legendPos, legendTitle)) /
        (editSubplot(plots1[[j]], legendPos, legendTitle) | editSubplot(plots2[[j]], legendPos, legendTitle)) /
        (editSubplot(plots3[[j]], legendPos, legendTitle) | editSubplot(plots4[[j]], legendPos, legendTitle)) +
        plot_annotation(tag_levels='A') &
        theme(plot.tag=element_text(size=TEXT_SIZE + 5, hjust=-0.5, vjust=-0.5, face='bold'))
    return(p)
}

