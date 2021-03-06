#' Palettes of political systems
#'
#' Color palettes for political parties in various countries.
#'
#' @rdname scale_politics
#'
#' @param palette Palette name as a string. See the palettes section.
#' @param reverse Should the palette order be reversed?
#' @param select An optional string vector of color names that indicates
#'   a custom selection of available colors and their order. See
#'   [https://github.com/joon-e/allespaletti](https://github.com/joon-e/allespaletti)
#'   for all color names.
#' @param ... Other arguments passed on scale function to control name,
#' limits, breaks, labels and so forth.
#'
#' @section Palettes:
#'
#' The following palettes are available for use with these scales:
#' \describe{
#'   \item{German parties}{german, german2, fckafd, fckafd2}
#'   \item{US parties}{us, us2}
#'   }
#'
#' @export
scale_colour_politics <- function(palette = "german",
                                  reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_politics(palette, reverse, select),
                          ...)

}

#' @export
#' @rdname scale_politics
scale_color_politics <- scale_colour_politics

#' @export
#' @rdname scale_politics
scale_fill_politics <- function(palette = "german",
                                reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_politics(palette, reverse, select),
                          ...)

}

#' Politics palette
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
  fckafd2 = c(union = "#000000",
              spd = "#E3000F",
              afd = "#6C3121",
              fdp = "#FFFF00",
              linke = "#BE3075",
              gruene = "#46962B",
              other = "#696969"),
  us = c(democrats = "#3885D3",
         republican = "#E02E44",
         independent = "#637684"),
  us2 = c(democrats = "#000E89",
          republican = "#C91602",
          independent = "#DDDDDD")
)

#' Get palette function
#'
#' @inheritParams scale_colour_politics
#'
#' @keywords internal
get_palette_politics <- function(palette = "german", reverse = FALSE, select = NULL) {

  if (!palette %in% names(politics_palettes)) {
    stop(glue::glue("{palette} not avaiable. ",
                    "Please use one of the following: ",
                    "{paste(names(politics_palettes), collapse = ', ')}"))
  }

  # Extract palette
  pal <- politics_palettes[[palette]]

  # Custom select
  if (!is.null(select)) pal <- pal[select]

  # Reverse
  if (reverse) pal <- rev(pal)

  function(n) {

    if (n > length(pal)) {
      warning(glue::glue('Palette "{palette}" contains only {length(pal)} colors, while data needs {n}'))
    }

    unname(pal[1:n])
  }

}
