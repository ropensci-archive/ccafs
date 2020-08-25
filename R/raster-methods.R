#' raster::plot
#'
#' re-exported `plot` method from `raster` package to avoid failing
#' when trying to plot raster objects without having `raster` loaded
#' first.
#'
#' @name plot
#' @rdname plot
#' @keywords internal
#' @export
#' @importFrom raster plot
NULL
