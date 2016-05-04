cp <- function(x) Filter(Negate(is.null), x)

ccafs_bucket <- function() "cgiardata"

make_url <- function(x) {
  paste0(sprintf("http://%s.s3.amazonaws.com/", ccafs_bucket()), x)
}

last <- function(x) {
  x[length(x)]
}

cc_GET <- function(url, path, overwrite = TRUE, ...) {
  x <- GET(url, write_disk(path, overwrite = overwrite), progress(), ...)
  stop_for_status(x)
  x
}

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))
