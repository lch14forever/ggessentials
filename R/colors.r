#' @title geGetColors
#'
#' @import ggsci
#' @param n the number of colors to use (1-17) [default: 17]
#' @param alpha the alpha value for colors [default: 1]
#' @param named return a list with color names [default: FALSE]
#' @return a vector of colors in hex code
#' @export
geGetColors <- function(n=17, alpha=1, named=FALSE){
    if (n > 17){
        stop("Currently I only support maximally 17 colors...")
    }
    sel_col <- c(pal_npg(alpha = alpha)(10),
                 pal_rickandmorty(alpha = alpha)(12),
                 pal_tron(alpha = alpha)(7)[4])[-c(8,9,13,18,21,22)]
    if(named) {
        col_names <- c('red', 'blue', 'green', 'darkblue', 'orange', 'grey', 'lightgreen', 'lightbrown', 'yellow', 'brown',
                       'lightblue', 'red2', 'darkgreen', 'pink', 'darkyellow', 'cyan', 'green2')
        return(as.list(setNames(sel_col, col_names)))
    }
    return(sel_col[1:n])
}

## Auxilary function (not exporteda)
# motivated by https://www.garrickadenbuie.com/blog/custom-discrete-color-scales-for-ggplot2/
ge_pal <- function(primary = "blue", other = "grey", direction = 1) {
    ge_colors <- geGetColors(named=TRUE)
    stopifnot(primary %in% names(ge_colors))
    function(n) {
        if (n > 17) warning("Branded Color Palette only has 17 colors.")
        if (n == 2) {
            other <- if (!other %in% names(ge_colors)) {
                other
            } else {
                branded_colors[other]
            }
            color_list <- c(other, ge_colors[primary])
        } else {
            color_list <- ge_colors[1:n]
        }

        color_list <- unname(unlist(color_list))
        if (direction >= 0) color_list else rev(color_list)
    }
}


#' @title scale_color_ge
#'
#' @param primary the color used for the primary case [default: "blue"]
#' @param other the color used for the other case [default: "grey"]
#' @param direction positive for normal order, negative for reversed order [default: 1 - normal order]
#' @param ... other parameters passed to `ggplot2::discrete_scale`
#'
#' @export
scale_colour_ge <- function(primary = "blue", other = "grey", direction = 1, ...) {
    ggplot2::discrete_scale(
        "colour", "ge",
        ge_pal(primary, other, direction),
        ...
    )
}

#' @title scale_colour_ge
#'
#' @param primary the color used for the primary case [default: "blue"]
#' @param other the color used for the other case [default: "grey"]
#' @param direction positive for normal order, negative for reversed order [default: 1 - normal order]
#' @param ... other parameters passed to `ggplot2::discrete_scale`
#'
#' @export
scale_color_ge <- scale_colour_ge

#' @title scale_fill_ge
#'
#' @param primary the color used for the primary case [default: "blue"]
#' @param other the color used for the other case [default: "grey"]
#' @param direction positive for normal order, negative for reversed order [default: 1 - normal order]
#' @param ... other parameters passed to `ggplot2::discrete_scale`
#'
#' @export
scale_fill_ge <- function(primary = "blue", other = "grey", direction = 1, ...) {
    ggplot2::discrete_scale(
        "fill", "ge",
        ge_pal(primary, other, direction),
        ...
    )
}


