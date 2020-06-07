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
           green = "#225522",
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
             "#CC4C02", "#993404", "#662506"),
  iridescent = c("#FEFBE9", "#FCF7D5", "#EAF0B5", "#DDECBF", "#D0E7CA", "#C2E3D2",
                 "#B5DDD8", "#A8D9DC", "#9BD2E1", "#8DCBE4", "#81C4E7", "#7BBCE7",
                 "#7EB2E4", "#88A5DD", "#9398D2", "#9B8AC4", "#9D7DB2", "#9A709E",
                 "#906388", "#805770", "#684957", "#46353A"),
  rainbow14 = c("#D1BBD7", "#AE76A3", "#882E72", "#1965B0", "#5289C7", "#7BAFDE",
                "#4EB265", "#90C987", "#CAE0AB", "#F7F056", "#F6C141", "#F1932D",
                "#E8601C", "#DC050C"),
  rainbow23 = c("#E8ECFB", "#D9CCE3", "#CAACCB", "#BA8DB4", "#AA6F9E", "#994F88",
                "#882E72", "#1965B0", "#437DBD", "#6195CF", "#7BAFDE", "#4EB265",
                "#90C987", "#CAE0AB", "#F7F056", "#F7CB45", "#F4A736", "#EE8026",
                "#E65518", "#DC050C", "#A5170E", "#72190E", "#42150A"),
  smooth_rainbow = c("#E8ECFB", "#DDD8EF", "#D1C1E1", "#C3A8D1", "#B58FC2", "#A778B4",
                     "#9B62A7", "#8C4E99", "#6F4C9B", "#6059A9", "#5568B8", "#4E79C5",
                     "#4D8AC6", "#4E96BC", "#549EB3", "#59A5A9", "#60AB9E", "#69B190",
                     "#77B77D", "#8CBC68", "#A6BE54", "#BEBC48", "#D1B541", "#DDAA3C",
                     "#E49C39", "#E78C35", "#E67932", "#E4632D", "#DF4828", "#DA2222",
                     "#B8221E", "#95211B", "#721E17", "#521A13")
)



get_palette_tol <- function(palette = "vibrant", reverse = FALSE, select = NULL,
                            discrete = TRUE, ...) {

  # Extract palette
  pal <- tol_palettes[[palette]]

  if (discrete) {

  }

  # Custom select
  if (!is.null(select)) pal <- pal[select]

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
                            reverse = FALSE, select = NULL, discrete = TRUE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("colour", palette,
                            palette = get_palette_tol(palette, reverse, select, discrete),
                            ...)
  } else {
    ggplot2::scale_color_gradientn(colours = get_palette_tol(palette, reverse, select,
                                                            discrete)(256))
  }

}

scale_color_tol <- scale_colour_tol

scale_fill_tol <- function(palette = "vibrant",
                           reverse = FALSE, select = NULL, discrete = TRUE, ...) {
  if (discrete) {
    ggplot2::discrete_scale("fill", palette,
                            palette = get_palette_tol(palette, reverse, select, discrete),
                            ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = get_palette_tol(palette, reverse, select,
                                                             discrete)(256))
  }

}
