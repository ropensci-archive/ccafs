cache_data <- function(key, cache = TRUE, overwrite = FALSE,
                       progress = TRUE, ...) {
  cache_dir <- cc_cache_path()

  if (!file.exists(cache_dir)) {
    dir.create(cache_dir, recursive = TRUE)
  }

  file <- file.path(cache_dir, basename(normalize_key(key)))

  if (!file.exists(file)) {
    invisible(cc_GETw(url = make_url(fix_key(key)), path = file, overwrite,
                      progress, ...))
  }

  outdir <- file.path(cache_dir, sub("\\.zip", "", basename(normalize_key(key))))

  # unzip
  if (overwrite || !file.exists(outdir)) {
    utils::unzip(file, exdir = outdir, overwrite = overwrite)
  }

  list.files(outdir, full.names = TRUE, recursive = TRUE)
}

fix_key <- function(x) {
  if (is.null(x)) {
    NULL
  } else {
    gsub("\n|\\s+", "", x)
  }
}

normalize_key <- function(x) {
  if (is.null(x)) {
    NULL
  } else {
    x <- gsub("\n|\\s+", "", x)
    sub("http://cgiardata.s3.amazonaws.com/|http://gisweb.ciat.cgiar.org/", "", x)
  }
}
