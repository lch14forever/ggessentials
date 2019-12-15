#' @title italicize.plot
#'
#' @import ggplot2
#' @importFrom lazyeval as_name
#' @param p a ggplot object
#' @param string string to replace
#' @description italicize everything that matches the `string` in a given plot `p`
#' @export
italicize.plot <- function(p, string){
    g <- p
    build.plot <- ggplot_build(g)

    ## change axis label and legend label
    g$labels <- lapply(p$labels, function(x) italicize.string(x, string))
    g$labels <- lapply(p$labels, function(x) italicize.string(x, string))

    ## change x axis
    x.col <- as.character(as_name(p$mapping$x))
    if(!is.numeric(p$data[, x.col])){
        g <- g + scale_x_discrete(labels=unlist(lapply(levels(p$data[, x.col]),
                                                       italicize.string, taxon=string)))
    }
    ## change y axis
    y.col <- as.character(as_name(p$mapping$y))
    if(!is.numeric(p$data[, y.col])){
        g <- g + scale_y_discrete(labels=unlist(lapply(levels(p$data[, y.col]),
                                                       italicize.string, taxon=string)))
    }

    ## change color
    if(!is.null(p$labels$colour)){
        g <- g + scale_color_manual(labels=lapply(levels(build.plot$plot$data[,build.plot$plot$labels$colour]),
                                                  function(x) italicize.string(x, string)),
                                    values=unique(build.plot$data[[1]]$colour))
    }
    ## change fill
    if(!is.null(p$labels$fill)){
        g <- g + scale_fill_manual(labels=lapply(levels(build.plot$plot$data[,build.plot$plot$labels$fill]),
                                                 function(x) italicize.string(x, string)),
                                   values=unique(build.plot$data[[1]]$fill))
    }
    g
}


#' @title italicize.string
#'
#' @param sentence a sentence
#' @param taxon a string to italicize
#' @description italicize everything that matches the `taxon` in a given sentence
#' @export
italicize.string <- function(sentence, taxon, ...){
    ## already an expression
    if(!is.character(sentence)) return(sentence)
    ## no pattern matched
    if(length(grep(x=sentence, taxon, fixed = TRUE))==0) return(sentence)
    p <- taxon
    s <- paste0("'~italic('", taxon, "')~'")
    str <- gsub(x=paste0("'",sentence,"'"), p, s, fixed = TRUE)
    return(parse(text=bquote(.(str))))
}
