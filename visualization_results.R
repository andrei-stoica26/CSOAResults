TEXT_SIZE <- 3

editSubplot <- function(p, legendPos='right', legendTitle=NULL){
    if (legendPos == 'none')
        p <- p + easy_remove_axes() else{
            p <- p + labs(y=NULL, title=legendTitle) +
                theme(axis.text=element_text(size=TEXT_SIZE, color='black'),
                      axis.title=element_text(size=TEXT_SIZE, color='black'))
            p <- p + theme(legend.position=legendPos,
                           legend.text=element_text(size=TEXT_SIZE, color='black'),
                           legend.title=element_text(size=TEXT_SIZE, color='black'),
                           legend.key.size=unit(0.3, 'cm'),
                           legend.direction='vertical',
                           legend.location='plot',
                           legend.margin=margin(0, 0, 0, 0))
        }
    return(p)
}

quadPlot <- function(plots1, plots2, plots3, plots4, i,
                     legendPos='bottom',
                     legendTitle = NULL){
    p <- (editSubplot(plots1[[i]], legendPos, legendTitle) |
              editSubplot(plots2[[i]], legendPos, legendTitle)) /
        (editSubplot(plots3[[i]], legendPos, legendTitle) |
             editSubplot(plots4[[i]], legendPos, legendTitle)) |
        plot_annotation(tag_levels='A',
                        theme=theme(plot.title=element_text(size=TEXT_SIZE - 1, hjust=-0.5, vjust=-0.5)))
    return(p)
}

octoPlot <- function(plots1, plots2, plots3, plots4, i, j,
                     legendPos='right',
                     legendTitle = NULL){
    p <- (editSubplot(plots1[[i]], legendPos, legendTitle) | editSubplot(plots2[[i]], legendPos, legendTitle)) /
        (editSubplot(plots3[[i]], legendPos, legendTitle) | editSubplot(plots4[[i]], legendPos, legendTitle)) /
        (editSubplot(plots1[[j]], legendPos, legendTitle) | editSubplot(plots2[[j]], legendPos, legendTitle)) /
        (editSubplot(plots3[[j]], legendPos, legendTitle) | editSubplot(plots4[[j]], legendPos, legendTitle)) +
        plot_annotation(tag_levels='A',
                        theme=theme(plot.title=element_text(size=TEXT_SIZE - 1, hjust=-0.5, vjust=-0.5)))
    return(p)
}

umapPlots <- function(seuratObj, smr, labelCol, label, pointSize = 0.5,
                      featLabelSize=2, alpha=1){
    dimred <- scUMAPMat(seuratObj)
    pointsObj <- dimred[which(smr$predictions[[label]][, 'CSOA'] == 1), ]
    p1 <- featureWes(seuratObj, paste0('CSOA_', label), idClass=labelCol,
                     repel=TRUE, labelSize=featLabelSize) + ggtitle(NULL) +
        NoLegend()
    p2 <- pointsDimPlot(seuratObj, pointsObj=pointsObj, labelSize=NULL,
                        group.by=labelCol, pointSize=pointSize,
                        pointShape=10,
                        alpha=alpha,
                        pointColor='violetred4', pt.size=pointSize)
    return(list(p1, p2))
}

umapPlots2 <- function(seuratObj, smr, labelCol, label, labelSize=2, pointSize=0.5){
    cells <- which(smr$predictions[[label]][, 'CSOA'] == 1)
    p1 <- featureWes(seuratObj, paste0('CSOA_', label), idClass=labelCol,
                     repel=TRUE, labelSize=labelSize, pt.size=pointSize) + ggtitle(NULL) +
        NoLegend()
    p2 <- DimPlot(subset(seuratObj, cells=cells), group.by=labelCol, label=TRUE,
                         repel=TRUE, label.size=labelSize, pt.size=pointSize) + NoLegend() + ggtitle(NULL)
    return(list(p1, p2))
}

octoPlot2 <- function(plots1, plots2, plots3, plots4, i, j,
                     legendPos = 'none',
                     legendTitle = NULL){
    p <- (editSubplot(plots1[[i]], legendPos, legendTitle) | editSubplot(plots1[[j]], legendPos, legendTitle)) /
        (editSubplot(plots2[[i]], legendPos, legendTitle) | editSubplot(plots2[[j]], legendPos, legendTitle)) /
        (editSubplot(plots3[[i]], legendPos, legendTitle) | editSubplot(plots3[[j]], legendPos, legendTitle)) /
        (editSubplot(plots4[[i]], legendPos, legendTitle) | editSubplot(plots4[[j]], legendPos, legendTitle)) +
        plot_annotation(tag_levels='A',
                        theme=theme(plot.title=element_text(size=TEXT_SIZE - 1)))
    return(p)
}

