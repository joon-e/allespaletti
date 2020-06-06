tol_palettes_qualitative <- list(
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
            grey = "#DDDDDD")
)


get_palette_tol <- function(palette = "vibrant", reverse = FALSE, order = NULL) {

  # Extract palette
  pal <- tol_palettes_qualitative[[palette]]

  # Custom order
  if (!is.null(order)) pal <- pal[order]

  # Reverse
  if (reverse) pal <- rev(pal)

  function(n) {

    if (n > length(pal)) {
      warning(glue::glue('Palette "{palette}" contains only {length(pal)} colors, while data needs {n}'))
    }

    unname(pal[1:n])
  }

}


scale_colour_tol <- function(palette = "vibrant",
                           reverse = FALSE, order = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_tol(palette, reverse, order),
                          ...)

}

scale_color_tol <- scale_colour_tol

scale_fill_tol <- function(palette = "vibrant",
                       reverse = FALSE, order = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_tol(palette, reverse, order),
                          ...)

}


ggplot2::ggplot(ggplot2::diamonds, ggplot2::aes(clarity, fill = cut)) +
  ggplot2::geom_bar() +
  scale_fill_tol("vibrant")
