library(ggplot2)
library(ggforce)

drawCellSets <- function(lnWidth=0.3, textSize=3, arrowAngle=20, arrowLen=0.3){
    rectDF <- data.frame(xmin = c(0, 0, 0),
                         xmax = c(3, 3, 3),
                         ymin = c(0, 4, 7),
                         ymax = c(2, 6, 9),
                         color = c('purple', 'blue', 'red'),
                         label = c('Gene N', 'Gene 2', 'Gene 1'))

    ellipseDF <- data.frame(x0 = c(6, 6, 6),
                            y0 = c(1, 5, 8),
                            a = c(2, 2, 2),
                            b = c(1.2, 1.2, 1.2),
                            angle = c(0, 0, 0),
                            color = c('purple', 'blue', 'red'),
                            label = c('Cell set N', 'Cell set 2', 'Cell set 1'))

    arrowDF <- data.frame(x=c(3, 3, 3),
                          y=c(1, 5, 8),
                          xend=c(4, 4, 4),
                          yend=c(1, 5, 8))

    pointDF <- data.frame(x=c(3.1, 3.5, 3.9),
                          y=c(3, 3, 3))

    p <- ggplot() +
        theme_void() +
        geom_rect(data=rectDF,
                  aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                  fill='white', color=rectDF$color, linewidth=lnWidth) +
        geom_text(data=rectDF, aes(x=xmin + 1.5, y=ymin + 1, label=label),
                  size=textSize) +
        geom_ellipse(data=ellipseDF, aes(x0=x0, y0=y0, a=a, b=b, angle=angle),
                     fill='white', linewidth=lnWidth) +
        geom_text(data=ellipseDF, aes(x=x0, y=y0, label=label), size=textSize) +
        geom_segment(data=arrowDF, aes(x=x, y=y, xend=xend),
                     arrow=arrow(angle=arrowAngle, length = unit(arrowLen, "cm")),
                     linewidth=lnWidth) +
        geom_point(data=pointDF, aes(x=x, y=y))
    return(p)
}




