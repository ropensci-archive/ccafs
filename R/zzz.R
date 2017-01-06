cp <- function(x) Filter(Negate(is.null), x)

ccafs_bucket <- function() "cgiardata"

ccafs_base <- function() "http://cgiardata.s3.amazonaws.com"

make_url <- function(x) {
  paste0(sprintf("http://%s.s3.amazonaws.com/", ccafs_bucket()), x)
}

last <- function(x) {
  x[length(x)]
}

cc_GET <- function(url, ...) {
  x <- GET(url, ...)
  stop_for_status(x)
  contutf8(x)
}

cc_GETw <- function(url, path, overwrite = TRUE, progress = TRUE, ...) {
  x <- GET(url, write_disk(path, overwrite = overwrite),
           if (progress) progress(), ...)
  if (x$status_code > 201) {
    unlink(path)
    stop(httr::http_status(x)$message, call. = FALSE)
  }
  x
}

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

contutf8 <- function(x) {
  content(x, "text", encoding = 'UTF-8')
}

parsxml <- function(x) {
  xml <- xml2::read_xml(x)
  ch <- xml2::xml_children(xml)
  cont <- ch[xml2::xml_name(ch) == "Contents"]
  flat_list(lapply(cont, xml2::as_list))
}

flat_list <- function(z) {
  Map(function(x) as.list(unlist(x)), z)
}

cc_cache_path <- function() rappdirs::user_cache_dir("ccafs")
