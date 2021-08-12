#' @title geom_reduction_axes
#'
#' @import ggplot2
geom_reduction_axes <- function(mapping = NULL, len = 0.1, offset = 0.1, ...) {
    default_aes <- aes_(group = NA)
    if (is.null(mapping)) {
        mapping <- default_aes
    } else {
        mapping <- modifyList(default_aes, mapping)
    }
    mapping <- modifyList(default_aes, mapping)
    layer(
        geom = "segment",
        stat = StatReductionAxes,
        mapping = mapping,
        position = 'identity',
        show.legend = FALSE,
        data = NULL,
        params = list(
            offset = offset,
            len = len,
            ...
        )
    )
}

#' @title geom_reduction_axes_label
#'
#' @import ggplot2
geom_reduction_axes_label <- function(mapping = NULL, len = 0.1, offset = 0.1,
                                      label="X", axis=1,
                                      ...) {
    default_aes <- aes_(group = NA)
    if (is.null(mapping)) {
        mapping <- default_aes
    } else {
        mapping <- modifyList(default_aes, mapping)
    }
    mapping <- modifyList(default_aes, mapping)
    layer(
        geom = "text",
        stat = StatReductionAxesLabel,
        mapping = mapping,
        position = 'identity',
        show.legend = FALSE,
        data = NULL,
        params = list(
            offset = offset,
            len = len,
            label=label,
            axis=axis,
            ...
        )
    )
}

#' @title StatReductionAxes
#'
#' @import ggplot2
StatReductionAxes <- ggproto("StatReductionAxes", Stat,
                          compute_group = function(self, data, scales, params,
                                                   offset, len){
                              dat <- aux(data, offset=offset, len=len)
                              dat
                          },
                          required_aes = c("x", "y")
)

#' @title StatReductionAxesLabel
#'
#' @import ggplot2
StatReductionAxesLabel <- ggproto("StatReductionAxesLabel", Stat,
                             compute_group = function(self, data, scales, params,
                                                      offset, len,
                                                      label, axis){
                                 dat <- aux(data, offset=offset, len=len)
                                 if (axis==2){
                                    dat <- data.frame(x=(dat[1,1]+dat[1,3])/2, y=(dat[1,2]+dat[1,4])/2, label=label)
                                 }else if(axis==1){
                                    dat <- data.frame(x=(dat[2,1]+dat[2,3])/2, y=(dat[2,2]+dat[2,4])/2, label=label)
                                 }else{
                                     stop("axis should 1 or 2")
                                 }
                                 dat
                             },
                             required_aes = c("x", "y")
)

aux <- function(data, offset, len) {
    x.r <- c(min(data$x), max(data$x))
    y.r <- c(min(data$y), max(data$y))
    x <- x.r[1] - offset*(diff(x.r))
    y <- y.r[1] - offset*(diff(y.r))
    xend <- x + len*(diff(x.r))
    yend <- y + len*(diff(y.r))

    dat <- rbind(
        data.frame(x=x,y=y,xend=x,yend=yend),
        data.frame(x=x,y=y,xend=xend,yend=y)
    )
}
