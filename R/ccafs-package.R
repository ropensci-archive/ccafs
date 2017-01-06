#' @title Client for CCAFS GCM Data
#'
#' @description Client for Climate Change, Agriculture, and Food Security
#' (CCAFS) General Circulation Models (GCM) data. Data is stored in
#' Amazon S3, from which we provide functions to fetch data.
#'
#' @section About CCAFS:
#' Client for Climate Change, Agriculture, and Food Security
#' (CCAFS) General Circulation Models (GCM) data. Data is stored in
#' Amazon S3, from which we provide functions to fetch data.
#'
#' R client for Climate Change, Agriculture, and Food Security (CCAFS)
#' General Circulation Models (GCM) data.
#'
#' CCAFS website: <http://ccafs-climate.org/>
#'
#' CCAFS GCM data for this package comes from Amazon S3
#' \url{http://cgiardata.s3.amazonaws.com} . Amazon S3 stands for "Simple
#' Storage Service" - it's like a file system, and they give you links to
#' the files and metadata around those links.
#'
#' CCAFS data can be used for studying climate change, and how climate
#' impacts various aspects of the earth. Search google scholar with
#' `"CCAFS" "GCM"` to see example uses.
#'
#' As far as I can tell, CCAFS GCM data comes from IPCC data.
#'
#' @section About the package:
#' \pkg{ccafs} is a client to work with the data CCAFS provides via Amazon Web
#' Services S3 data.
#'
#' Currently, we don't provide a way to search for what data is available.
#' You have to know what you want, or you can list what is available, and then
#' pick files from the list. Though there's not a lot of information in the
#' metadata returned from S3.
#'
#' We'll work on incorporating a way to search - currently there is no
#' solution.
#'
#' @importFrom rappdirs user_cache_dir
#' @importFrom httr GET stop_for_status write_disk progress content
#' @importFrom raster raster brick
#' @name ccafs-package
#' @aliases ccafs
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
#'
#' @section Vignette:
#' You can access the vignette like \code{vignette(package = "ccafs")} or
#' \code{vignette("ccafs_vignette", package = "ccafs")}
NULL
