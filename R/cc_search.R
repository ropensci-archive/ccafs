#' Search CCAFS data
#'
#' @export
#' @param file_set (integer) a file set, 2 through 12
#' @param scenario (integer) a scenario, 1 through 10
#' @param model (integer) a model, 1 through 89
#' @param extent (character) an extent, 'global' or 'region'
#' @param format (character) a format, 'ascii' or 'esri'
#' @param period (integer) a period, 1 through 10
#' @param variable (integer) a variable, 1 through 7, or 9999
#' @param resolution (integer) a resolutions, 1 through 7
#' @param tile (character) a tile defining a spatial area on the globe.
#' one of A1-6, B1-6, or C1-6. See web interface for where those are located.
#'
#' @return character strings, one or more urls
#' @details See [ccafs-search] for details on parameters.
#'
#' note that some URLs will be for Amazon S3 and others will have different
#' base URLS (e.g., http://gisweb.ciat.cgiar.org)
#'
#' Output can be passed to [cc_data_fetch()], and subsequently to
#' [cc_data_read()]
#'
#' @examples \dontrun{
#' (res <- cc_search(file_set = 12, extent = "global", format = "ascii",
#'   period = 4, variable = 1, resolution = 4))
#'
#' res <- cc_search(file_set = 7, extent = "region", format = "ascii",
#'   period = 9, variable = 5, resolution = 6)
#' cc_data_fetch(res[3])
#'
#' # Alternatively, you can use the helper list
#' # where you can reference options by name
#' # the downside is that this is very verbose
#' (res <- cc_search(file_set = cc_params$file_set$`Delta method IPCC AR4`,
#'                   scenario = cc_params$scenario$`SRES B1`,
#'                   model = cc_params$model$bccr_bcm2_0,
#'                   extent = cc_params$extent$global,
#'                   format = cc_params$format$ascii,
#'                   period = cc_params$period$`2040s`,
#'                   variable = cc_params$variable$Precipitation,
#'                   resolution = cc_params$resolution$`5 minutes`))
#' }

cc_search <- function(file_set = NULL, scenario = NULL, model = NULL,
  extent = NULL, format = NULL, period = NULL, variable = NULL,
  resolution = NULL, tile = NULL) {

  assert(file_set, c('integer', 'numeric'))
  assert(scenario, c('integer', 'numeric'))
  assert(model, c('integer', 'numeric'))
  assert(extent, "character")
  assert(format, "character")
  assert(tile, "character")
  assert(period, c('integer', 'numeric'))
  assert(variable, c('integer', 'numeric'))
  assert(resolution, c('integer', 'numeric'))

  # client
  cli <- crul::HttpClient$new(url = ccafs_web())

  # search
  args <- cp(list(fileSet = file_set, tile_name = tile,
                  'scenarios[]' = scenario, 'model[]' = model,
                  extent = switch_extent(extent),
                  'formats[]' = switch_format(format), 'period[]' = period,
                  'variables[]' = variable, resolution = resolution))
  res1 <- cli$get(path = "file-list.php", query = args)
  res1$raise_for_status()
  html <- xml2::read_html(res1$parse('UTF-8'))
  file_set <- xml2::xml_attr(xml2::xml_find_first(
    html,
    "//input[@type=\"hidden\"]"
  ), "value")
  dfs <- xml2::xml_attr(xml2::xml_find_all(
    html,
    "//input[@class=\"checkbox-file\"]"
  ), 'value')
  if (all(is.na(dfs))) stop("no results found or all files deprecated",
                            call. = FALSE)
  dfs <- as.list(stats::setNames(dfs, rep('download-files[]', length(dfs))))

  # get to skip page
  body <- c(dfs, list(fileSet = file_set, `file-type` = "file"))
  res2 <- cli$post("form.php", body = body)
  res2$raise_for_status()

  # generate download link
  body <- list(context = "submit-user-anonymous",
    userId = -1, instituteName = "Anonymous", use = "unknown")
  res3 <- cli$post("ajax/user-info.php", body = body)
  res3$raise_for_status()
  download_id <- res3$parse("UTF-8")

  # get download link
  dfs_file <- stats::setNames(dfs, rep('files[]', length(dfs)))
  body <- c(dfs_file, list(fileSet = file_set, `downloadId[]` = download_id,
    fileType = "file"))
  res4 <- cli$post("ajax/links-generator.php", body = body)
  res4$raise_for_status()
  jsonlite::fromJSON(res4$parse("UTF-8"))$reference
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
