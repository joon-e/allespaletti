comm_palettes <- list(
  dgpuk = c(green1 = "#08A382",
            green2 = "#2DB195",
            green3 = "#52BFA8",
            green4 = "#83D1C1",
            green5 = "#B5E3DA",
            grey = "#EFF1F2"),
  ica = c(red = "#EE3352",
          yellow = "#FFD473",
          green = "#70A094",
          white = "#FEFEFE",
          black = "#000000")
)

get_palette_comm <- function(palette = "ica", reverse = FALSE, order = NULL) {

  # Extract palette
  pal <- comm_palettes[[palette]]

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

scale_colour_comm <- function(palette = "ica",
                              reverse = FALSE, order = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_comm(palette, reverse, order),
                          ...)

}

scale_color_comm <- scale_colour_comm

scale_fill_comm <- function(palette = "ica",
                            reverse = FALSE, order = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_comm(palette, reverse, order),
                          ...)

}
