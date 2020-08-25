cp <- function(x) Filter(Negate(is.null), x)

ccafs_web <- function() "http://ccafs-climate.org"

ccafs_bucket <- function() "cgiardata"

ccafs_base <- function() "http://cgiardata.s3.amazonaws.com"

make_url <- function(x) {
  if (grepl("https?://", x)) return(x)
  paste0(sprintf("http://%s.s3.amazonaws.com/", ccafs_bucket()), x)
}

last <- function(x) {
  x[length(x)]
}

cc_GET <- function(url, ...) {
  cli <- crul::HttpClient$new(
    url = url,
    opts = list(useragent = paste0("ccafs/", utils::packageVersion("ccafs")))
  )
  x <- cli$get(...)
  x$raise_for_status()
  x$parse("UTF-8")
}

cc_GETw <- function(url, path, overwrite = TRUE, ...) {
  cli <- crul::HttpClient$new(
    url = url,
    opts = list(useragent = paste0("ccafs/", utils::packageVersion("ccafs")))
  )
  if (!overwrite) {
    if (file.exists(path)) {
      stop("file exists and ovewrite is not TRUE", call. = FALSE)
    }
  }
  x <- do.call(cli$get, as.list(c(disk = path, ...)))
  if (x$status_code > 201) {
    unlink(path)
    stop(x$status_http()$message, call. = FALSE)
  }
  x
}

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

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

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!class(x) %in% y) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}
