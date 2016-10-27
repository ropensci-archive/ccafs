cache_data <- function(key, cache = TRUE, overwrite = FALSE) {
  cache_dir <- cc_cache_path()

  if (!file.exists(cache_dir)) {
    dir.create(cache_dir, recursive = TRUE)
  }

  file <- file.path(cache_dir, basename(key))

  if (!file.exists(file)) {
    cc_GETw(make_url(key), file, overwrite)
  }

  outdir <- file.path(cache_dir, sub("\\.zip", "", basename(key)))

  # unzip
  if (overwrite || !file.exists(outdir)) {
    utils::unzip(file, exdir = outdir, overwrite = overwrite)
  }

  list.files(outdir, full.names = TRUE)
}

