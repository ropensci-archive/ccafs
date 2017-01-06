cache_data <- function(key, cache = TRUE, overwrite = FALSE,
                       progress = TRUE, ...) {
  cache_dir <- cc_cache_path()

  key <- normalize_key(key)

  if (!file.exists(cache_dir)) {
    dir.create(cache_dir, recursive = TRUE)
  }

  file <- file.path(cache_dir, basename(key))

  if (!file.exists(file)) {
    invisible(cc_GETw(url = make_url(key), path = file, overwrite,
                      progress, ...))
  }

  outdir <- file.path(cache_dir, sub("\\.zip", "", basename(key)))

  # unzip
  if (overwrite || !file.exists(outdir)) {
    utils::unzip(file, exdir = outdir, overwrite = overwrite)
  }

  list.files(outdir, full.names = TRUE)
}

normalize_key <- function(x) {
  if (is.null(x)) {
    NULL
  } else {
    gsub("\n|\\s+", "", x)
  }
}
