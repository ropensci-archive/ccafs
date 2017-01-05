#' List S3 keys
#'
#' @export
#' @param prefix (character) string that limits the response to keys that begin
#' with the specified prefix
#' @param delimiter (character) string used to group keys.  Read the AWS doc
#' for more detail.
#' @param max (integer) number indicating the maximum number of keys to return
#' (max 1000).
#' @param marker (character) string that specifies the key to start with when
#' listing objects in a bucket. Amazon S3 returns object keys in alphabetical
#' order, starting with key after the marker in order.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @return A tibble (a data.frame, basically)
#' @examples \dontrun{
#' cc_list_keys()
#' cc_list_keys(max = 10)
#' cc_list_keys(max = 1)
#' cc_list_keys(prefix = "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/")
#' }
cc_list_keys <- function(prefix = NULL, delimiter = NULL, max = 1000,
                      marker = NULL, ...) {
  args <- cp(list(`max-keys` = max, marker = marker, prefix = prefix,
                  delimiter = delimiter))
  tmp <- parsxml(cc_GET(ccafs_base(), query = args, ...))
  df <- data.table::setDF(data.table::rbindlist(tmp, fill = TRUE,
                                                use.names = TRUE))
  tibble::as_data_frame(df)
}
