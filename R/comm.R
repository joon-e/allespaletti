#' Palettes of communication associations
#'
#' Color palettes for various communication associations
#'
#' @rdname scale_comm
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
#'   \item{Communication Associations}{ica, dgpuk}
#'   }
#'
#' @export
scale_colour_comm <- function(palette = "ica",
                              reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_comm(palette, reverse, select),
                          ...)

}

#' @export
#' @rdname scale_comm
scale_color_comm <- scale_colour_comm

#' @export
#' @rdname scale_comm
scale_fill_comm <- function(palette = "ica",
                            reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_comm(palette, reverse, select),
                          ...)

}


#' Comm associations palette
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

#' Get palette function
#'
#' @inheritParams scale_colour_comm
#'
#' @keywords internal
get_palette_comm <- function(palette = "ica", reverse = FALSE, select = NULL) {

  if (!palette %in% names(comm_palettes)) {
    stop(glue::glue("{palette} not avaiable. ",
                    "Please use one of the following: ",
                    "{paste(names(comm_palettes), collapse = ', ')}"))
  }

  # Extract palette
  pal <- comm_palettes[[palette]]

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
