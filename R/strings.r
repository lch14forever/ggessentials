#' @title italicize.plot
#'
#' @param p a ggplot object
#' @param string string or vector of strings to replace
#' @import ggplot2
#' @importFrom grid editGrob
#' @importFrom grid grid.ls
#' @importFrom grid grid.force
#' @importFrom grid getGrob
#' @importFrom grid gPath
#' @description italicize everything that matches the `string` in a given plot `p`
#' @references https://github.com/GuangchuangYu/yyplot/blob/master/R/set_font.R
#'
#' @examples
#' library(ggessentials)
#' data(iris)
#' p <- ggplot(iris, aes(x=Species, y=Sepal.Width, color=Species)) +
#'   geom_boxplot()
#' g <- italicize.plot(p, c('setosa','versicolor'))
#' plot(g)
#'
#' @export
italicize.plot <- function(p, string){
    g <- ggplotGrob(p)
    ng <- grid.ls(grid.force(g), print=FALSE)$name
    txt <- ng[which(grepl("text", ng))]

    for (i in seq_along(txt)) {
        label.original <- getGrob(grid.force(g), gPath(txt[i]))$label
        label.new <- italicize.string(label.original, string)
        g <- editGrob(grid.force(g), gPath(txt[i]),
                      grep = TRUE, label=label.new)
    }
    return(g)
}


#' @title italicize.string
#'
#' @param sentence a sentence
#' @param taxon a string (or vector of strings) to italicize in the given sentence
#' @importFrom stringr str_replace_all
#' @description italicize everything that matches the `taxon` in a given sentence
#' @export
italicize.string <- function(sentence, taxon){
    ## already an expression
    if(!is.character(sentence)) return(sentence)
    s <- vapply(unique(taxon),
                function(x) paste0("'~italic('", x, "')~'"), 'string')
    str <- str_replace_all(sentence, s)
    str <- paste0("'", str, "'")
    return(parse(text=bquote(.(str))))
}
