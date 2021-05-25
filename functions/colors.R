#https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2?s=08

#'vector oof colors

ndc_cols <- c(
  
  blue_navy = '#152864',
  blue_light = '#149AD1',
  blue_grey = '#025C6C',
  green = '#028339',
  grey = '7C6E66',
  purple = '#8D2B8B',
  yellow = '#F9B114',
  brown = '#70271C'
  
  
)


#' Function to extract drsimonj colors as hex codes
#'
#' @param ... Character names of drsimonj_colors 
#'
ndc_colors <- function(...) {
  cols <- c(...)
  
  if (is.null(cols))
    return (ndc_cols)
  
  ndc_cols[cols]
}


#list of palletes
ndc_pals <- list(
  `main`  = ndc_colors("blue_navy", "blue_light", "green", "yellow"),
  
  `blues`  = ndc_colors("blue_navy", "blue_light", "blue_grey")
  
)

#' Return function to interpolate a drsimonj color palette
#'
#' @param palette Character name of palette in drsimonj_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
ncd_pallete <- function(palette = "main", reverse = FALSE, ...) {
  pal <- ndc_pals[[palette]]
  
  if (reverse) pal <- rev(pal)
  
  colorRampPalette(pal, ...)
}

ncd_pallete()
