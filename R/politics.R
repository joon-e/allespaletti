politics_palettes <- list(
  german = c(union = "#231F20",
             spd = "#ED1B24",
             afd = "#00ADEF",
             fdp = "#FFDE00",
             linke = "#B47AB5",
             gruene = "#21B24B",
             other = "#A8A9AD"),
  german2 = c(union = "#000000",
              spd = "#E3000F",
              afd = "#009EE0",
              fdp = "#FFFF00",
              linke = "#BE3075",
              gruene = "#46962B",
              other = "#696969"),
  fckafd = c(union = "#231F20",
             spd = "#ED1B24",
             afd = "#6C3121",
             fdp = "#FFDE00",
             linke = "#B47AB5",
             gruene = "#21B24B",
             other = "#A8A9AD"),
  us = c(democrats = "#3885D3",
         republican = "#E02E44",
         independent = "#637684"),
  us2 = c(democrats = "#000E89",
          republican = "#C91602",
          independent = "#DDDDDD")
)

get_palette_politics <- function(palette = "german", reverse = FALSE, order = NULL) {

  # Extract palette
  pal <- politics_palettes[[palette]]

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

scale_colour_politics <- function(palette = "vibrant",
                              reverse = FALSE, order = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_politics(palette, reverse, order),
                          ...)

}

scale_color_politics <- scale_colour_politics

scale_fill_politics <- function(palette = "vibrant",
                            reverse = FALSE, order = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_politics(palette, reverse, order),
                          ...)

}
