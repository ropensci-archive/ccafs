#' Search CCAFS data
#'
#' @export
#' @param file_set (integer) a file set, 2 through 12
#' @param scenario (integer) a scenario, 1 through 10
#' @param model (integer) a model, 1 through 89
#' @param extent (character) an extent, global (1) or region (2)
#' @param format (character) a format, ascii (1) or esri (2)
#' @param period (integer) a period, 1 through 10
#' @param variable (integer) a variable, 1 through 7, or 9999
#' @param resolution (integer) a resolutions, 1 through 7
#'
#' @details See \code{\link{ccafs-search}} for details on parameters
#'
#' @examples
#' cc_search(file_set = 4, scenario = 6, model = 2, extent = "global",
#'   format = "ascii", period = 5, variable = 2, resolution = 3
#' )
#'
#' cc_search(file_set = 12, extent = "global", format = "ascii",
#'   period = 4, variable = 1, resolution = 4
#' )
#'
#' # a deprecated file
#' # cc_search(file_set = 3, scenario = 2, model = 4, extent = "global",
#' #   format = "ascii", period = 7, variable = 2, resolution = 5
#' # )
cc_search <- function(file_set = NULL, scenario = NULL, model = NULL,
  extent = NULL, format = NULL, period = NULL, variable = NULL,
  resolution = NULL) {

  # client
  cli <- crul::HttpClient$new(url = ccafs_web())

  # search
  args <- cp(list(fileSet = file_set, tile_name = NULL,
                  'scenarios[]' = scenario, 'model[]' = model,
                  extent = switch_extent(extent),
                  'formats[]' = switch_format(format), 'period[]' = period,
                  'variables[]' = variable, resolution = resolution))
  res <- cli$get(path = "file-list.php", query = args)
  html <- xml2::read_html(res$parse('UTF-8'))
  file_set <- xml2::xml_attr(xml2::xml_find_first(
    html,
    "//input[@type=\"hidden\"]"
  ), "value")
  dfs <- xml2::xml_attr(xml2::xml_find_all(
    html,
    "//input[@class=\"checkbox-file\"]"
  ), 'value')
  if (all(is.na(dfs))) stop("no results found or all files deprecated", call. = FALSE)
  dfs <- as.list(stats::setNames(dfs, rep('download-files[]', length(dfs))))

  # get to skip page
  body <- c(dfs, list(fileSet = file_set, `file-type` = "file"))
  res <- cli$post("form.php", body = body)

  # generate download link
  body <- list(context = "submit-user-anonymous",
    userId = -1, instituteName = "Anonymous", use = "unknown")
  res <- cli$post("ajax/user-info.php", body = body)
  download_id <- res$parse("UTF-8")

  # get download link
  dfs_file <- stats::setNames(dfs, rep('files[]', length(dfs)))
  body <- c(dfs_file, list(fileSet = file_set, `downloadId[]` = download_id,
    fileType = "file"))
  res <- cli$post("ajax/links-generator.php", body = body)
  jsonlite::fromJSON(res$parse("UTF-8"))$reference
}

switch_extent <- function(x) {
  if (!is.null(x)) {
    x <- tolower(x)
    if (!x %in% c('global', 'region')) {
      stop("'extent' must be one of global or region", call. = FALSE)
    }
    switch(x, global = 1, region = 2)
  } else {
    NULL
  }
}

switch_format <- function(x) {
  if (!is.null(x)) {
    x <- tolower(x)
    if (!x %in% c('ascii', 'esri')) {
      stop("'format' must be one of ascii or esri", call. = FALSE)
    }
    switch(x, ascii = 1, esri = 2)
  } else {
    NULL
  }
}

# # Search
# #url <- 'http://ccafs-climate.org/file-list.php?fileSet=4&tile_name=&scenarios%5B%5D=6&model%5B%5D=2&extent=1&formats%5B%5D=1&period%5B%5D=5&variables%5B%5D=2&resolution=3'
# url <- "http://ccafs-climate.org/file-list.php?fileSet=12&tile_name=&extent=1&formats%5B%5D=1&period%5B%5D=4&variables%5B%5D=1&resolution=4"
# cli <- crul::HttpClient$new(url = url)
# res <- cli$get()
# #cat(res$parse('UTF-8'))
# html <- xml2::read_html(res$parse('UTF-8'))
# library(xml2)
# file_set <- xml_attr(xml_find_first(
#   html,
#   "//input[@type=\"hidden\"]"
# ), "value")
# dfs <- xml_attr(xml_find_all(
#   html,
#   "//input[@class=\"checkbox-file\"]"
# ), 'value')
# dfs <- as.list(stats::setNames(dfs, rep('download-files[]', length(dfs))))
#
# # get to skip page
# ccafs_url2 <- "http://ccafs-climate.org/"
# cli2 <- crul::HttpClient$new(url = ccafs_url2)
# body <- c(dfs, list(
#   fileSet = file_set,
#   `file-type` = "file"
# ))
# res <- cli2$post("form.php", body = body, verbose = TRUE)
# cat(res$parse())
#
# # generate download link
# body <- list(
#   context = "submit-user-anonymous",
#   userId = -1,
#   instituteName = "Anonymous",
#   use = "unknown"
# )
# res <- cli2$post("ajax/user-info.php", body = body, verbose = TRUE)
# download_id <- res$parse("UTF-8")
#
# # get download link
# dfs_file <- stats::setNames(dfs, rep('files[]', length(dfs)))
# body <- c(dfs_file, list(
#   fileSet = file_set,
#   `downloadId[]` = download_id,
#   fileType = "file"
# ))
# res <- cli2$post("ajax/links-generator.php", body = body, verbose = TRUE)
# jsonlite::fromJSON(res$parse("UTF-8"))$reference
