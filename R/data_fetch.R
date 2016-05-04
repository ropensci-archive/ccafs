#' Fetch data
#'
#' @export
#' @param key A S3 object, either a character string, or a \code{s3_object}
#' class
#' @param overwrite (logical) Whether to overwrite files if they already
#' exist on your machine. Default: \code{FALSE}
#' @details Note that data is not read into R as data can be very large.
#' See \code{\link{data_read}}
#' @return A character vector of full file paths. A print method makes a tidy
#' return object
#' @examples \dontrun{
#' key <- paste0(
#'  "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1_m/10min/",
#'  "bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip")
#' (res <- data_fetch(key = key))
#' # indexing maintains class for easier subsetting
#' res[1]
#' res[[1]]
#' res[1:2]
#' }
data_fetch <- function(key, overwrite = FALSE) {
  res <- cache_data(key, cache = TRUE, overwrite = overwrite)
  structure(res, class = "ccafs_files")
}

#' @export
print.ccafs_files <- function(x, ...) {
  cat("<CCAFS GCM files>", sep = "\n")
  cat(sprintf("   %s files", length(x)), sep = "\n")
  cat(paste0("   Base dir: ", dirname(sub(user_cache_dir("ccafs"), "", x[1]))), sep = "\n")
  files <- basename(x)
  ftypes <- unique(strextract(files, "\\..+"))
  cat("   File types (count): ", sep = "\n")
  for (i in seq_along(ftypes)) {
    cat(sprintf("     - %s: %s", ftypes[i], length(grep(sprintf("%s$", ftypes[i]), files))), sep = "\n")
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
