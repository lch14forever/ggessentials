#' @title geGetColors
#'
#' @import ggsci
#' @param n the number of colors to use (1-17)
#' @param alpha the alpha value for colors [default: 1]
#' @return a vector of colors in hex code
#' @export
geGetColors <- function(n, alpha=1){
    if (n > 17){
        stop("Currently I only support maximally 17 colors...")
    }
    sel_col <- c(pal_npg(alpha = alpha)(10),
                 pal_rickandmorty(alpha = alpha)(12),
                 pal_tron(alpha = alpha)(7)[4])[-c(8,9,13,18,21,22)]
    return(sel_col[1:n])
}
