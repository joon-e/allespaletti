#' Palettes of social networking sites
#'
#' Color palettes for various social networking sites
#'
#' @rdname scale_sns
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
#'   \item{SNS}{sns}
#'   }
#'
#' @export
scale_colour_sns <- function(palette = "sns",
                             reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_sns(palette, reverse, select),
                          ...)

}

#' @export
#' @rdname scale_sns
scale_color_sns <- scale_colour_sns

#' @export
#' @rdname scale_sns
scale_fill_sns <- function(palette = "sns",
                           reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_sns(palette, reverse, select),
                          ...)

}

#' SNS palette
sns_palettes <- list(
  sns = c(facebook = "#1977F3",
          twitter = "#1DA1F2",
          whatsapp = "#25D366",
          youtube = "#FF0000",
          instagram = "#C13584",
          snapchat = "#FFFC00",
          reddit = "#FF4400",
          pinterest = "#E60023",
          tiktok = "#000000",
          tumblr = "#001935",
          linkedin = "#006699",
          xing = "#006567",
          wechat = "#01DE6C",
          qq = "#CCCCCC",
          qzone = "#FFDC45",
          sina_weibo = "#E6162D",
          vk = "#5181B8",
          kuaishou = "#FF8000",
          odnoklassniki = "#F58220",
          facebook_dark = "#3B5998"
          )
)


#' Get palette function
#'
#' @inheritParams scale_colour_sns
#'
#' @keywords internal
get_palette_sns <- function(palette = "sns", reverse = FALSE, select = NULL) {

  if (!palette %in% names(sns_palettes)) {
    stop(glue::glue("{palette} not avaiable. ",
                    "Please use one of the following: ",
                    "{paste(names(sns_palettes), collapse = ', ')}"))
  }

  # Extract palette
  pal <- sns_palettes[[palette]]

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
