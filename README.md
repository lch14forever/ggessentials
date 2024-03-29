## ggessentials: My ggplot2 essential configurations used for paper figures.

### Functions

-   `geUseTheme`: use a preset theme for plotting (support `bw` or
    `classic` at the moment)
-   `geGetColors`: get a vector of colors
-   `italicize.string`: italicize strings in a sentence
-   `italicize.plot`: italicize strings in a ggplot

Known issues with `italicize.plot`:

-   overwrites bold font face

### Aesthetics

-   `scale_color_ge`/`scale_fill_ge`: selected color scheme

### Themes

-   `theme_bw_ge`
-   `theme_classic_ge`
-   `theme_umap_ge`

Known issue with `theme_umap_ge`: this is a function returns a list of
`geom_text`, `geom_segment` and `theme_void()`. Better implementation
should define `element_line_umap` that can be used in `theme(axis.line)`

### Installation

``` r
devtools::install_github("lch14forever/ggessentials")
```

### Usage

``` r
library(ggessentials)

## to get a list of colors (1-17)
colors <- geGetColors(3)

data("iris")
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point() +
    scale_color_manual(values=colors) +
    theme_bw_ge()
```

![](README_files/figure-gfm/usage-1.png)<!-- -->

#### Italicize a taxon name in a plot

``` r
p <- ggplot(iris, aes(x=Species, y=Sepal.Width, color=Species)) + 
    geom_boxplot() +
    scale_color_manual(values=colors) +
    theme_bw_ge()

grid::grid.draw(italicize.plot(p, string = c('setosa', 'versicolor')))
```

![](README_files/figure-gfm/italicize.plot-1.png)<!-- -->

#### Set theme for the current session

``` r
## preset the theme
geUseTheme('classic')
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point() +
    scale_color_manual(values=colors)
```

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

#### Disrete color scale with `scale_color_ge` or `scale_fill_ge`

``` r
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point() +
    scale_color_ge()
```

![](README_files/figure-gfm/scale_color_ge-1.png)<!-- -->

``` r
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + 
    geom_point(shape=21) +
    scale_fill_ge()
```

![](README_files/figure-gfm/scale_fill_ge-1.png)<!-- -->

#### Simplified axes (for UMAP plots)

``` r
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point() +
    theme_umap_ge()
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Another implementation \[will be replaced by `theme_umap_ge` soon\]

``` r
g <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point() +
    scale_color_manual(values=colors) +
    theme_bw_ge()
add_axes_umap(g)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
