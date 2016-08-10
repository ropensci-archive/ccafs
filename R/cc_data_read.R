#' Reaa CCAFS data into R
#'
#' @export
#' @param x A \code{ccafs_files} object, the output from a call to \code{\link{cc_data_fetch}}
#' @return \code{RasterLayer} or \code{RasterBrick} class object
#' @details Look in \code{rappdirs::user_cache_dir("ccafs")} for what files are
#' cached and to delete any.
#' @examples \dontrun{
#' key <- paste0(
#'  "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1_m/10min/",
#'  "bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip")
#' res <- cc_data_fetch(key = key)
#'
#' # a single file
#' cc_data_read(res[1])
#'
#' # select individual files
#' cc_data_read(res[1:2])
#'
#' # all files
#' cc_data_read(res)
#'
#' # character path input
#' ## you can also pass in a path to a file(s)
#' cc_data_read(unclass(res[1]))
#'
#' # plot data
#' plot(cc_data_read(res[1:3]))
#' }
cc_data_read <- function(x) {
  UseMethod("cc_data_read")
}

#' @export
cc_data_read.default <- function(x) {
  stop("no 'cc_data_read' method for class ", class(x), call. = FALSE)
}

#' @export
cc_data_read.ccafs_files <- function(x) {
  cc_data_read(unclass(x))
}

#' @export
cc_data_read.character <- function(x) {
  drop_non_readable(x)
  if (length(x) == 1) {
    raster(x)
  } else if (length(x) > 1) {
    brick(as.list(x))
  } else {
    stop("input had length zero", call. = FALSE)
  }
}

# helpers
drop_non_readable <- function(x) {
  exts <- strextract(basename(unclass(x)), "\\..+")
  if (!all(grepl("\\.asc$", exts))) {
    stop(
      "Some files not readable: \n   ",
      paste0(unclass(x)[grep("\\.asc$", exts, invert = TRUE)], collapse = ", "),
      call. = FALSE
    )
  }
}
