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

get_palette_sns <- function(palette = "sns", reverse = FALSE, select = NULL) {

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

scale_colour_sns <- function(palette = "sns",
                              reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("colour", palette,
                          palette = get_palette_sns(palette, reverse, select),
                          ...)

}

scale_color_sns <- scale_colour_sns

scale_fill_sns <- function(palette = "sns",
                            reverse = FALSE, select = NULL, ...) {
  ggplot2::discrete_scale("fill", palette,
                          palette = get_palette_sns(palette, reverse, select),
                          ...)

}

