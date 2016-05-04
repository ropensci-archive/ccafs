ccafs
=====



[![Build Status](https://travis-ci.org/ropenscilabs/ccafs.svg?branch=master)](https://travis-ci.org/ropenscilabs/ccafs)
[![Build status](https://ci.appveyor.com/api/projects/status/rd3u4qqmlcloh5j7?svg=true)](https://ci.appveyor.com/project/sckott/ccafs)

Client for CCAFS GCM Data

[CCAFS GCM Data is on S3: root path](http://cgiardata.s3.amazonaws.com)

## Install

Development version


```r
devtools::install_github("ropenscilabs/ccafs")
```


```r
library("ccafs")
```

## Fetch files 

Note, files are not loaded as they can be very large


```r
key <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1_m/10min/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"
(res <- data_fetch(key = key))
#> <CCAFS GCM files>
#>    13 files
#>    Base dir: /bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc
#>    File types (count): 
#>      - .asc: 12
#>      - .asc.aux.xml: 1
```

## Load data

Can load in a single file (gives `RasterLayer`), or many (gives `RasterBrick`)


```r
data_read(res[1])
#> class       : RasterLayer 
#> dimensions  : 900, 2160, 1944000  (nrow, ncol, ncell)
#> resolution  : 0.1666667, 0.1666667  (x, y)
#> extent      : -180, 180, -60, 90  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA 
#> data source : /Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_1.asc 
#> names       : prec_1 
#> values      : -2147483648, 2147483647  (min, max)
```


```r
data_read(res[1:2])
#> class       : RasterBrick 
#> dimensions  : 900, 2160, 1944000, 2  (nrow, ncol, ncell, nlayers)
#> resolution  : 0.1666667, 0.1666667  (x, y)
#> extent      : -180, 180, -60, 90  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA 
#> data source : in memory
#> names       : prec_1, prec_10 
#> min values  :      0,       0 
#> max values  :    966,     997
```

## Plot


```r
library("raster")
plot(data_read(res[1:3]))
```

![plot of chunk unnamed-chunk-7](inst/img/unnamed-chunk-7-1.png)


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/ccafs/issues).
* License: MIT
* Get citation information for `ccafs` in R doing `citation(package = 'ccafs')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![rofooter](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
