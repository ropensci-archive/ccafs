#' List S3 keys
#'
#' @export
#' @param prefix Character string that limits the response to keys that begin
#' with the specified prefix
#' @param delimiter Character string used to group keys.  Read the AWS doc for more detail.
#' @param max Integer indicating the maximum number of keys to return (max 1000).
#' @param marker Character string that pecifies the key to start with when
#' listing objects in a bucket. Amazon S3 returns object keys in alphabetical order,
#' starting with key after the marker in order.
#' @param parse_response logical, should we attempt to parse the response?
#' @param ... Curl options.
#' @return A \code{s3_object} class (a list, basically)
#' @examples \dontrun{
#' list_keys()
#' list_keys(max = 10)
#' list_keys(max = 1)
#' list_keys(prefix = "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/")
#' }
list_keys <- function(prefix = NULL, delimiter = NULL, max = 1000,
                      marker = NULL, parse_response = TRUE, ...) {
  get_bucket(bucket = ccafs_bucket(), prefix = prefix,
             delimiter = delimiter, max = max, marker = marker,
             parse_response = parse_response, ...)
}

# library(httr)
# res <- get_bucket("cgiardata", config=verbose())
# length(res$Contents[[2]])
#
# get_bucket("cgiardata", "/ccafs/ccafs-climate/dat")
#
# res2 <- get_bucket(res[[5]], marker = keys[length(keys)])
# keys <- unname(sapply(res2, function(x) x$Key))
#
#
# get_bucket("cgiardata", prefix = "ipcc_5ar_ciat_tiled")


# if (max > 1000) {
#   x <- TRUE
#   marker <- NULL
#   allkeys <- list()
#   i <- 0
#   while (x) {
#     i <- i + 1
#     res <- get_bucket(ccafs_bucket(), max = max, marker = marker)
#     allkeys[[i]] <- keys <- unname(sapply(res, function(x) x$Key))
#     marker <- last(keys)
#   }
# } else {
#   get_bucket(ccafs_bucket(), max = max)
# }