display_palette <- function(palette, which) {
  pal <- palette[[which]]

  if (is.null(names(pal))) {
    colors <- factor(pal, pal, pal)
  } else {
    colors <- as.factor(names(pal))
  }

  p <- data.frame(colors = colors) %>%
    ggplot2::ggplot(ggplot2::aes(colors, fill = colors, label = colors)) +
    ggplot2::geom_bar(width = 1) +
    ggplot2::theme_void() +
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::scale_x_discrete(limits = colors) +
    ggplot2::theme(legend.position = "none",
                   plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::labs(title = which)

  if (!is.null(names(pal))) {
    p <- p + ggplot2::geom_text(ggplot2::aes(label = colors),
                                y = .5, angle = 90, color = "white", size = 6)
  }

  return(p)
}
