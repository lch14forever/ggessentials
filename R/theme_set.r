#' @title geUseThemeBW
#'
#' @import ggplot2
#' @param theme ggplot themes (either "bw" or "classic")
#' @export
geUseTheme <- function(theme='bw'){
    figtheme <- switch(theme, 'bw'=theme_bw(), 'classic'=theme_classic())
    if(is.null(figtheme)){
        stop("Currently I only support bw or classic.")
    }

    figtheme <- figtheme +
        theme(text = element_text(size=23,face='bold'),
              axis.line = element_line(size = 1, linetype = "solid"),
              axis.title.y=element_text(margin=margin(0,15,0,0)),axis.title.x=element_text(margin=margin(15,0,0,0)),
              plot.margin = unit(c(1,1,1,1), "cm"),
              plot.title = element_text(margin=margin(0,0,15,0), hjust=0.5))
    theme_set(figtheme)
}
