# cache data
cache_data <- function(key, cache = TRUE, overwrite = FALSE) {
  cache_dir <- user_cache_dir("ccafs")

  # if (cache) {
    if (!file.exists(cache_dir)) {
      dir.create(cache_dir, recursive = TRUE)
    }

    file <- file.path(cache_dir, basename(key))

    if (!file.exists(file)) {
      cc_GET(make_url(key), file, overwrite)
    }

    outdir <- file.path(cache_dir, sub("\\.zip", "", basename(key)))

    # unzip
    if (overwrite || !file.exists(outdir)) {
      unzip(file, exdir = outdir, overwrite = overwrite)
    }

    list.files(outdir, full.names = TRUE)
  # } else {
  #   tmp <- tempdir()
  #   file <- file.path(cache_dir, basename(key))
  #   on.exit(unlink(tmp))
  #   download.file(make_url(key), file, mode = 'wb')
  #   unzip(file, exdir = tmp)
  #   list.files(tmp, full.names = TRUE, pattern = ".asc")
  # }
}
