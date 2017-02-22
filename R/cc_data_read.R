#' Read CCAFS data
#'
#' @export
#' @param x A \code{ccafs_files} object, the output from a call to
#' \code{\link{cc_data_fetch}}
#' @param unreadable (character) what to do when unreadable files are passed in.
#' default is to filter them out and proceed ("filter") - alternatively,
#' you can choose "stop", in which case we'll stop with a message.
#' @return \code{RasterLayer} or \code{RasterStack} class object. See their
#' help files in \code{raster} package documentation.
#' @details Look in \code{rappdirs::user_cache_dir("ccafs")} for what files
#' are cached and to delete any.
#'
#' \code{\link{cc_data_fetch}} downloads data to your machine, and this
#' function reads the data into your R session.
#'
#' For more control over vizualizations of raster data, check out the
#' \code{rasterVis} package (https://CRAN.R-project.org/package=rasterVis)
#' @examples \dontrun{
#' key <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/
#'  2030s/bcc_csm1_1_m/10min/
#'  bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"
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
#' library(raster)
#' plot(cc_data_read(res[1:3]))
#' }
cc_data_read <- function(x, unreadable = "filter") {
  UseMethod("cc_data_read")
}

#' @export
cc_data_read.default <- function(x, unreadable = "filter") {
  stop("no 'cc_data_read' method for class ", class(x), call. = FALSE)
}

#' @export
cc_data_read.ccafs_files <- function(x, unreadable = "filter") {
  cc_data_read(unclass(x), unreadable)
}

#' @export
cc_data_read.character <- function(x, unreadable = "filter") {
  stopifnot(unreadable %in% c('filter', 'stop'))
  if (!all(file.exists(x))) stop("one or more files don't exist", call. = FALSE)
  x <- drop_non_readable(x, unreadable)
  if (length(x) == 1 && !file.info(x)$isdir) {
    raster(x)
  } else if (length(x) > 1 || length(x) == 1 && file.info(x)$isdir) {
    if (length(x) == 1) {
      if (file.info(x)$isdir) {
        stack(list.files(x, full.names = TRUE, pattern = ".asc"))
      }
    } else {
      stack(x)
    }
  } else {
    stop("input had length zero", call. = FALSE)
  }
}

# helpers
drop_non_readable <- function(x, unreadable) {
  exts <- strextract(basename(unclass(x)), "\\..+")
  if (!all(grepl("\\.asc$", exts))) {
    if (unreadable == "stop") {
      stop(
        "Some files not readable: \n   ",
        paste0(unclass(x)[grep("\\.asc$", exts, invert = TRUE)], collapse = ", "),
        call. = FALSE
      )
    } else {
      grep("\\.asc$", x, value = TRUE)
    }
  } else {
    return(x)
  }
}
