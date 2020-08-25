#' List CCAFS keys
#'
#' @export
#' @param prefix (character) string that limits the response to keys that begin
#' with the specified prefix. the string can have spaces and newlines, which
#' are removed internally - this allows the prefix to break across lines as
#' prefixes can be very long
#' @param delimiter (character) string used to group keys.  Read the AWS doc
#' for more detail.
#' @param max (integer) number indicating the maximum number of keys to return
#' (max 1000).
#' @param marker (character) string that specifies the key to start with when
#' listing objects in a bucket. Amazon S3 returns object keys in alphabetical
#' order, starting with key after the marker in order.
#' @param ... Curl options passed on to [crul::verb-GET]
#' @return A tibble (a data.frame, basically), with the columms:
#' 
#' - Key - object key
#' - LastModified - Object creation date or the last modified date,
#' whichever is the latest.
#' - ETag - "entity tag", used for cache validation
#' - Size - Size of the object, in bytes, divide by 10^6 to get
#' mb (megabytes)
#' - StorageClass - ignore, just useful for CCAFS maintainers
#' 
#' @details This function lists keys from the CCAFS Amazon S3 bucket.
#' Keys are essentially file paths. You can request data from any key that is
#' a file (with a file extension, and has size > 0). Other keys are
#' directories.
#' @examples \dontrun{
#' cc_list_keys(max = 1)
#'
#' cc_list_keys()
#' cc_list_keys(max = 10)
#' cc_list_keys(prefix = "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/")
#' cc_list_keys(prefix = "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/
#' rcp2_6/2030s/bcc_csm1_1/10min/")
#' }
cc_list_keys <- function(prefix = NULL, delimiter = NULL, max = 1000,
                      marker = NULL, ...) {
  args <- cp(list(`max-keys` = max, marker = marker,
                  prefix = fix_key(prefix),
                  delimiter = delimiter))
  tmp <- parsxml(cc_GET(ccafs_base(), query = args, ...))
  df <- data.table::setDF(data.table::rbindlist(tmp, fill = TRUE,
                                                use.names = TRUE))
  tibble::as_tibble(df)
}
