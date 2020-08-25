ccafs
=====



<!-- README.md is generated from README.Rmd. Please edit that file -->

[![cran checks](https://cranchecks.info/badges/worst/ccafs)](https://cranchecks.info/pkgs/ccafs)
[![Build Status](https://travis-ci.org/ropensci/ccafs.svg?branch=master)](https://travis-ci.org/ropensci/ccafs)
[![Build status](https://ci.appveyor.com/api/projects/status/vxvcb11726hwu0e2?svg=true)](https://ci.appveyor.com/project/sckott/ccafs)
[![codecov](https://codecov.io/gh/ropensci/ccafs/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/ccafs)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/ccafs)](https://github.com/r-hub/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/ccafs)](https://cran.r-project.org/package=ccafs)
[![](https://badges.ropensci.org/82_status.svg)](https://github.com/ropensci/software-review/issues/82)

R client for Climate Change, Agriculture, and Food Security (CCAFS)
General Circulation Models (GCM) data.

Package Docs: https://docs.ropensci.org/ccafs/

## About CCAFS

The CCAFS-Climate data portal (http://ccafs-climate.org/) provides global and regional future high-resolution climate datasets that serve as a basis for assessing the climate change impacts and adaptation in a variety of fields including biodiversity, agricultural and livestock production, and ecosystem services and hydrology. CCAFS data can be used by anyone from scientists studying climate change, and how climate impacts various aspects of the earth, to companies projecting crop yields in the future. Search google scholar with `"CCAFS" "GCM"` to see example uses.

These open-access datasets are hosted by Amazon Web Services. CCAFS GCM data for this package comes from Amazon S3
(root path: http://cgiardata.s3.amazonaws.com)

As far as I can tell, CCAFS GCM data comes from IPCC data.

## About Amazon S3

Amazon S3 stands for "Simple Storage Service" - it's like a file system,
and they give you links to the files and metadata around those links.

S3 is split up into buckets, essentially folder. All CCAFS data is in
one bucket. Within the CCAFS bucket on S3 are a series of nested folders.
To get to various files we need to navigate down the tree of folders.
Keys are file paths with all their parent folders, e.g., "/foo/bar/1/2".
Unfortunately, there's no meaningful search of the CCCAFS data as they
have on their website http://ccafs-climate.org/. However, you can
set a prefix for a search of these keys, e.g., "/foo/bar" for the key
above.

Check out https://aws.amazon.com/s3/ for more info.

## About the package

`ccafs` is a client to work with the data CCAFS provides via Amazon Web
Services S3 data.

The `ccafs` data has access to is the "Spatial Downscaling" data that you see
on the http://ccafs-climate.org/data/ page. The other data sets are not
open.

## Citations

Cite CCAFS data following their guidelines at http://ccafs-climate.org/about/

Get a citation for this package like `citation(package = 'ccafs')` after
installing the package.

## raster

The main useful output are `raster` package objects of class `RasterLayer` or `RasterBrick` - so in general have `raster` loaded in your session to maximize
happiness.

## Install

CRAN version


```r
install.packages("ccafs")
```

Development version


```r
remotes::install_github("ropensci/ccafs")
```


```r
library("ccafs")
```

## Documentation

Package Docs: https://docs.ropensci.org/ccafs/

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/ccafs/issues).
* License: MIT
* Get citation information for `ccafs` in R doing `citation(package = 'ccafs')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
