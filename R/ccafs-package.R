#' @title Client for CCAFS GCM Data
#'
#' @description Client for Climate Change, Agriculture, and Food Security
#' (CCAFS) General Circulation Models (GCM) data. Data is stored in
#' Amazon S3, from which we provide functions to fetch data.
#'
#' @importFrom rappdirs user_cache_dir
#' @importFrom httr GET stop_for_status write_disk progress content
#' @importFrom raster raster brick
#' @name ccafs-package
#' @aliases ccafs
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
#'
#' @section Vignette:
#' You can access the vignette like \code{vignette(package = "ccafs")} or
#' \code{vignette("ccafs_vignette", package = "ccafs")}
NULL
