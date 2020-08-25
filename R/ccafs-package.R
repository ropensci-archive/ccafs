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
#' CCAFS website: http://ccafs-climate.org/
#'
#' CCAFS GCM data for this package comes from Amazon S3
#' http://cgiardata.s3.amazonaws.com More about Amazon S3 below.
#'
#' CCAFS data can be used for studying climate change, and how climate
#' impacts various aspects of the earth. Search google scholar with
#' `"CCAFS" "GCM"` to see example uses.
#'
#' As far as I can tell, CCAFS GCM data comes from IPCC data.
#'
#' @section About Amazon S3:
#' Amazon S3 stands for "Simple Storage Service" - it's like a file system,
#' and they give you links to the files and metadata around those links.
#'
#' S3 is split up into buckets, essentially folder. All CCAFS data is in
#' one bucket. Within the CCAFS bucket on S3 are a series of nested folders.
#' To get to various files we need to navigate down the tree of folders.
#' Keys are file paths with all their parent folders, e.g., "/foo/bar/1/2".
#' Unfortunately, there's no meaningful search of the CCCAFS data as they
#' have on their website http://ccafs-climate.org/ . However, you can
#' set a prefix for a search of these keys, e.g., "/foo/bar" for the key
#' above.
#'
#' Check out https://aws.amazon.com/s3/ for more info.
#'
#' @section About the package:
#' \pkg{ccafs} is a client to work with the data CCAFS provides via Amazon Web
#' Services S3 data.
#'
#' The \pkg{ccafs} data has access to is the "Spatial Downscaling" data that
#' you see on the http://ccafs-climate.org/data/ page. The other data
#' sets are not open.
#'
#' Currently, we don't provide a way to search for what data is available.
#' You have to know what you want, or you can list what is available, and then
#' pick files from the list. Though there's not a lot of information in the
#' metadata returned from S3.
#'
#' We'll work on incorporating a way to search - currently there is no
#' solution.
#'
#' @section raster:
#' The main useful output are `raster` package objects of class
#' `RasterLayer` or `RasterBrick` - so in general have `raster`
#' loaded in your session to maximize happiness.
#'
#' @section Citations:
#' Cite CCAFS data following their guidelines at
#' http://ccafs-climate.org/about/
#'
#' Get a citation for this package like `citation(package = 'ccafs')`
#'
#' @importFrom rappdirs user_cache_dir
#' @importFrom raster raster stack
#' @name ccafs-package
#' @aliases ccafs
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
#'
#' @section Vignette:
#' \pkg{ccafs} has the following vignettes:
#' 
#' - `vignette("ccafs", package = "ccafs")`
#' - `vignette("amazon_s3_keys", package = "ccafs")`
#' 
NULL
