#' Write out a plot and return its path
#'
#' Wrapper around ggsave() that returns the path of the
#' written file
ggsave_tar <- function(filename, plot, path, device = NULL, ...) {
  ggplot2::ggsave(
    filename = filename,
    plot = plot,
    device = device,
    path = path,
    ...
  )
  if (is.null(path)) {
    path <- "."
  }
  fs::path(path, filename)
}