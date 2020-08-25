#' Download CCAFS data
#'
#' @export
#' @param key (character) a character string specifying a S3 key
#' or a URL (the output from a call to [cc_search()]. the key
#' can have spaces and newlines, which are removed internally - this allows
#' keys to break across lines as keys can be very long
#' @param overwrite (logical) Whether to overwrite files if they already
#' exist on your machine. Default: `FALSE`
#' @param ... Curl options passed on to [crul::verb-GET]
#'
#' @details Note that data is not read into R as data can be very large.
#' See [cc_data_read()]
#'
#' Look in `rappdirs::user_cache_dir("ccafs")` for what files are
#' cached and to delete any.
#'
#' Note that we've made it so that you can index into the return object,
#' getting either one or many results and the S3 class will be retained,
#' so that you can pass the result down to [cc_data_read()]
#'
#' @return A character vector of full file paths. A print method makes a tidy
#' return object in an S3 class.
#'
#' @examples \dontrun{
#' key <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/
#'  2030s/bcc_csm1_1_m/10min/
#'  bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"
#'
#' (res <- cc_data_fetch(key = key))
#' # indexing maintains class for easier subsetting
#' res[1]
#' res[[1]]
#' res[1:2]
#'
#' res <- cc_list_keys()
#' zips <- grep("\\.zip", res$Key, value = TRUE)
#' x <- cc_data_fetch(zips[1])
#' unclass(x)
#' cc_data_read(x[1])
#' cc_data_read(x[1:3])
#' cc_data_read(x)
#'
#' library(raster)
#' plot(cc_data_read(x[1]))
#' plot(cc_data_read(x[1:3]))
#' }
cc_data_fetch <- function(key, overwrite = FALSE, ...) {
  res <- cache_data(key, cache = TRUE, overwrite = overwrite, ...)
  structure(res, class = "ccafs_files")
}

#' @export
print.ccafs_files <- function(x, ...) {
  cat("\n<CCAFS GCM files>", sep = "\n")
  cat(sprintf("   %s files", length(x)), sep = "\n")
  cat(paste0("   Base dir: ", dirname(sub(cc_cache_path(), "", x[1]))),
      sep = "\n")
  files <- basename(x)
  ftypes <- unique(strextract(files, "\\..+"))
  cat("   File types (count): ", sep = "\n")
  for (i in seq_along(ftypes)) {
    cat(sprintf("     - %s: %s", ftypes[i],
                length(grep(sprintf("%s$", ftypes[i]), files))), sep = "\n")
  }
}

#' @export
`[.ccafs_files` <- function(x, i, j, drop = TRUE) {
  structure(unclass(x)[i], class = "ccafs_files")
}

#' @export
`[[.ccafs_files` <- function(x, i) {
  structure(unclass(x)[[i]], class = "ccafs_files")
}
