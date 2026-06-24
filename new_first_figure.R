library(ggplot2)
library(ggforce)

rectDF <- data.frame(xmin = c(0, 0, 0),
                     xmax = c(3, 3, 3),
                     ymin = c(0, 4, 7),
                     ymax = c(2, 6, 9),
                     color = c('purple', 'blue', 'red'),
                     label = c('Gene N', 'Gene 2', 'Gene 1'))
geom_ellipse(aes(x0 = 0, y0 = 0, a = 10, b = 3, angle = 0))
ellipseDF <- data.frame(x0 = c(6, 6, 6),
                        y0 = c(1, 5, 8),
                        a = c(2, 2, 2),
                        b = c(1.2, 1.2, 1.2),
                        angle = c(0, 0, 0),
                        color = c('purple', 'blue', 'red'),
                        label = c('Cell set n', 'Cell set 2', 'Cell set N'))

arrowDF <- data.frame(x=c(3, 3, 3),
                      y=c(1, 5, 8),
                      xend=c(4, 4, 4),
                      yend=c(1, 5, 8))

pointDF <- data.frame(x=c(3.1, 3.5, 3.9),
                      y=c(3, 3, 3))

lnWidth <- 0.8

ggplot() + theme_classic() +
    geom_rect(data=rectDF,
              aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
              fill='white', color=rectDF$color, linewidth=lnWidth) +
    geom_text(data=rectDF, aes(x=xmin + 1.5, y=ymin + 1, label=label)) +
    geom_ellipse(data=ellipseDF, aes(x0=x0, y0=y0, a=a, b=b, angle=angle),
                 fill='white', linewidth=lnWidth) +
    geom_text(data=ellipseDF, aes(x=x0, y=y0, label=label)) +
    geom_segment(data=arrowDF, aes(x=x, y=y, xend=xend), arrow=arrow(),
                 linewidth=lnWidth) +
    geom_point(data=pointDF, aes(x=x, y=y))



