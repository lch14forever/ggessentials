#' @title geUseThemeBW
#'
#' @import ggplot2
#' @param theme ggplot themes (either "bw" or "classic")
#' @description Set the theme in the current session
#' @export
geUseTheme <- function(theme='bw'){
    figtheme <- switch(theme, 'bw'=theme_bw_ge(), 'classic'=theme_classic_ge())
    if(is.null(figtheme)){
        stop("Currently I only support bw or classic.")
    }
    theme_set(figtheme)
}

## Auxilary function to set the theme
getTheme <- function() theme(text = element_text(size=23,face='bold'),
          axis.line = element_line(size = 1, linetype = "solid"),
          axis.title.y=element_text(margin=margin(0,15,0,0)),axis.title.x=element_text(margin=margin(15,0,0,0)),
          plot.margin = unit(c(1,1,1,1), "cm"),
          plot.title = element_text(margin=margin(0,0,15,0), hjust=0.5))


#' @title theme_bw_ge
#'
#' @import ggplot2
#' @export
theme_bw_ge <- function(){
    figtheme <- theme_bw() +getTheme()
    figtheme
}

#' @title theme_classic_ge
#'
#' @import ggplot2
#' @export
theme_classic_ge <- function(){
    figtheme <- theme_classic() +getTheme()
    figtheme
}
