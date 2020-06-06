tol_palettes <- list(
  bright = c(blue = "#4477AA",
             cyan = "#66CCEE",
             green = "#228833",
             yellow = "#CCBB44",
             red = "#EE6677",
             purple = "#AA3377",
             grey = "#BBBBBB"),
  high_contrast = c(yellow = "#DDAA33",
                    red = "#BB5566",
                    blue = "#004488",
                    black = "#000000",
                    white = "#FFFFFF"),
  vibrant = c(blue = "#0077BB",
              cyan = "#33BBEE",
              teal = "#009988",
              orange = "#EE7733",
              red = "#CC3311",
              magenta = "#EE3377",
              grey = "#BBBBBB"),
  muted = c(indigo = "#332288",
            cyan = "#88CCEE",
            teal = "#44AA99",
            green = "#117733",
            olive = "#999933",
            sand = "#DDCC77",
            rose = "#CC6677",
            wine = "#882255",
            purple = "#AA4499",
            grey = "#DDDDDD"),
  pale = c(blue = "#BBCCEE",
           cyan = "#CCEEFF",
           green = "#CCDDAA",
           yellow = "#EEEEBB",
           red = "#FFCCCC",
           grey = "#DDDDDD"),
  dark = c(blue = "#222255",
           cyan = "#225555",
           green = "#666633",
           yellow = "#666633",
           red = "#663333",
           grey = "#555555"),
  light = c(blue = "#77AADD",
            cyan = "#99DDFF",
            mint = "#44BB99",
            pear = "#BBCC33",
            olive = "#AAAA00",
            yellow = "#EEDD88",
            orange = "#EE8866",
            pink = "#FFAABB",
            grey = "#DDDDDD"),
  sunset = c("#364B9A", "#4A7BB7", "#6EA6CD", "#98CAE1", "#C2E4EF", "#EAECCC",
             "#FEDA8B", "#FDB366", "#F67E4B", "#DD3D2D", "#A50026"),
  BuRd = c("#2166AC", "#4393C3", "#92C5DE", "#D1E5F0", "#F7F7F7", "#FDDBC7",
           "#F4A582", "#D6604D", "#B2182B"),
  PRGn = c("#762A83", "#9970AB", "#C2A5CF", "#E7D4E8", "#F7F7F7", "#D9F0D3",
           "#ACD39E", "#5AAE61", "#1B7837"),
  YlOrBr = c("#FFFFE5", "#FFF7BC", "#FEE391", "#FEC44F", "#FB9A29", "#EC7014",
             "#CC4C02", "#993404", "#662506")
)


get_palette_tol <- function(palette = "vibrant", reverse = FALSE, order = NULL,
                            discrete = TRUE, ...) {

  # Extract palette
  pal <- tol_palettes[[palette]]

  if (discrete) {

  }

  # Custom order
  if (!is.null(order)) pal <- pal[order]

  # Reverse
  if (reverse) pal <- rev(pal)

  # Discrete output
  if (discrete) {

    function(n) {

      if (n > length(pal)) {
        warning(glue::glue('Palette "{palette}" contains only {length(pal)} colors, ',
                           'while data needs {n}.',
                           'Consider setting discrete = FALSE'))
      }

      unname(pal[1:n])
    }

  } else {
    # Interpolate values
    colorRampPalette(pal, ...)
  }


}


scale_colour_tol <- function(palette = "vibrant",
                            reverse = FALSE, order = NULL, discrete = TRUE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("colour", palette,
                            palette = get_palette_tol(palette, reverse, order, discrete),
                            ...)
  } else {
    ggplot2::scale_color_gradientn(colours = get_palette_tol(palette, reverse, order,
                                                            discrete)(256))
  }

}

scale_color_tol <- scale_colour_tol

scale_fill_tol <- function(palette = "vibrant",
                           reverse = FALSE, order = NULL, discrete = TRUE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("fill", palette,
                            palette = get_palette_tol(palette, reverse, order, discrete),
                            ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = get_palette_tol(palette, reverse, order,
                                                             discrete)(256))
  }

}
