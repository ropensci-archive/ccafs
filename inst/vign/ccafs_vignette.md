<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{ccafs introduction}
%\VignetteEncoding{UTF-8}
-->



ccafs introduction
==================

`ccafs` provides access to Climate Change, Agriculture, and Food Security (CCAFS)
General Circulation Models (GCM) data. Data is stored in Amazon S3, from
which we provide functions to fetch data.

Potential users are probably anyone from scientists asking questions about
climate change, to scientists or companies projecting crop yields in the future.

## Install

CRAN version


```r
install.packages("ccafs")
```

Dev version


```r
devtools::install_github("ropensci/ccafs")
```


```r
library("ccafs")
```



## Search

Search CCAFS

You can search by the numbers representing each possible value for
each parameter. See the `?'ccafs-search'` for help on that.


```r
(res <- cc_search(file_set = 4, scenario = 6, model = 2, extent = "global",
  format = "ascii", period = 5, variable = 2, resolution = 3))
#> [1] "http://gisweb.ciat.cgiar.org/ccafs_climate/files/data/ipcc_4ar_ciat/sres_b1/2040s/bccr_bcm2_0/5min/bccr_bcm2_0_sres_b1_2040s_prec_5min_no_tile_asc.zip"
```

Some saerches, like that above, result in one URL, while others, like that
below, result in many URLs.


```r
res <- cc_search(file_set = 12, extent = "global", format = "ascii",
  period = 4, variable = 1, resolution = 4)
length(res)
#> [1] 106
res[1:5]
#> [1] "http://cgiardata.s3.amazonaws.com/ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/10min/bcc_csm1_1_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc.zip"
#> [2] "http://cgiardata.s3.amazonaws.com/ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1_m/10min/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc.zip"
#> [3] "http://cgiardata.s3.amazonaws.com/ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bnu_esm/10min/bnu_esm_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc.zip"
#> [4] "http://cgiardata.s3.amazonaws.com/ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/cccma_canesm2/10min/cccma_canesm2_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc.zip"
#> [5] "http://cgiardata.s3.amazonaws.com/ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/cesm1_cam5/10min/cesm1_cam5_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc.zip"
```

One we have some URLs, we can fetch the files at the URLs

One at a time


```r
cc_data_fetch(res[1], progress = FALSE)
#>
#> <CCAFS GCM files>
#>    19 files
#>    Base dir: /bcc_csm1_1_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc
#>    File types (count):
#>      - .asc: 19
```

Or many at once


```r
lapply(res[1:3], cc_data_fetch, progress = FALSE)
#> [[1]]
#>
#> <CCAFS GCM files>
#>    19 files
#>    Base dir: /bcc_csm1_1_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc
#>    File types (count):
#>      - .asc: 19
#>
#> [[2]]
#>
#> <CCAFS GCM files>
#>    19 files
#>    Base dir: /bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc
#>    File types (count):
#>      - .asc: 19
#>
#> [[3]]
#>
#> <CCAFS GCM files>
#>    19 files
#>    Base dir: /bnu_esm_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc
#>    File types (count):
#>      - .asc: 19
```

Alternatively, you can use the helper list where you can reference options
by name; the downside is that this leads to very verbose code.


```r
(res <- cc_search(file_set = cc_params$file_set$`Delta method IPCC AR4`,
                  scenario = cc_params$scenario$`SRES B1`,
                  model = cc_params$model$bccr_bcm2_0,
                  extent = cc_params$extent$global,
                  format = cc_params$format$ascii,
                  period = cc_params$period$`2040s`,
                  variable = cc_params$variable$Precipitation,
                  resolution = cc_params$resolution$`5 minutes`))
#> [1] "http://gisweb.ciat.cgiar.org/ccafs_climate/files/data/ipcc_4ar_ciat/sres_b1/2040s/bccr_bcm2_0/5min/bccr_bcm2_0_sres_b1_2040s_prec_5min_no_tile_asc.zip"
```


## List keys

Keys are basically paths to files on Amazon S3's store of CCAFS files


```r
cc_list_keys()
#> # A tibble: 1,000 × 5
#>                                                                           Key
#>                                                                         <chr>
#> 1                                                                      ccafs/
#> 2                              ccafs/2014-05-24-01-19-33-3A0DFF1F86F3E7F7.txt
#> 3                                                              ccafs/amzn.csv
#> 4                                                        ccafs/ccafs-climate/
#> 5                                                   ccafs/ccafs-climate/data/
#> 6                                               ccafs/ccafs-climate/data/eta/
#> 7                             ccafs/ccafs-climate/data/eta/eta_south_america/
#> 8                    ccafs/ccafs-climate/data/eta/eta_south_america/baseline/
#> 9              ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/
#> 10 ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/hadcm_cntrl/
#> # ... with 990 more rows, and 4 more variables: LastModified <chr>,
#> #   ETag <chr>, Size <chr>, StorageClass <chr>
```

Max keys


```r
cc_list_keys(max = 3)
#> # A tibble: 3 × 5
#>                                              Key             LastModified
#>                                            <chr>                    <chr>
#> 1                                         ccafs/ 2014-02-28T15:15:45.000Z
#> 2 ccafs/2014-05-24-01-19-33-3A0DFF1F86F3E7F7.txt 2014-07-01T02:15:51.000Z
#> 3                                 ccafs/amzn.csv 2014-02-28T15:21:32.000Z
#> # ... with 3 more variables: ETag <chr>, Size <chr>, StorageClass <chr>
```

Key prefix


```r
cc_list_keys(prefix = "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/")
#> # A tibble: 1,000 × 5
#>                                                                            Key
#>                                                                          <chr>
#> 1                           ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/
#> 2                    ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/
#> 3              ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/
#> 4   ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/
#> 5  ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/1
#> 6  ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/1
#> 7  ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/1
#> 8  ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/1
#> 9  ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/1
#> 10 ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1/1
#> # ... with 990 more rows, and 4 more variables: LastModified <chr>,
#> #   ETag <chr>, Size <chr>, StorageClass <chr>
```

You can find certain files easily. Here, we'll find zip files


```r
res <- cc_list_keys()
zips <- grep("\\.zip", res$Key, value = TRUE)
zips[1:5]
#> [1] "ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/hadcm_cntrl/20min/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc.zip"
#> [2] "ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/hadcm_cntrl/20min/hadcm_cntrl_baseline_1970s_tmax_20min_sa_eta_asc.zip"
#> [3] "ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/hadcm_cntrl/20min/hadcm_cntrl_baseline_1970s_tmean_20min_sa_eta_asc.zip"
#> [4] "ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/hadcm_cntrl/20min/hadcm_cntrl_baseline_1970s_tmin_20min_sa_eta_asc.zip"
#> [5] "ccafs/ccafs-climate/data/eta/eta_south_america/baseline/1970s/hadcm_high/20min/hadcm_high_baseline_1970s_prec_20min_sa_eta_asc.zip"
```

Which you can use below to fetch data from.


## Fetch some data


```r
key <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/
  2030s/bcc_csm1_1_m/10min/
  bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"
```


```
#>
#> <CCAFS GCM files>
#>    12 files
#>    Base dir: /bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc
#>    File types (count):
#>      - .asc: 12
```


```r
(res <- cc_data_fetch(key = key, progress = FALSE))
```

Using the above set of zips, fetch some data:


```r
x <- cc_data_fetch(zips[1], progress = FALSE)
cc_data_read(x[1])
#> class       : RasterLayer
#> dimensions  : 151, 141, 21291  (nrow, ncol, ncell)
#> resolution  : 0.400002, 0.400002  (x, y)
#> extent      : -81.99999, -25.59971, -49.20001, 11.2003  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA
#> data source : /Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_1.asc
#> names       : prec_1
```


### Caching

When requesting data, we first check if you already have that data cached.
You'll know when this happens as the request will finish much faster when
you have data cached already.

You can list cached files


```r
cc_cache_list()[1:10]
#>  [1] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc"
#>  [2] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc.zip"
#>  [3] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_1.asc"
#>  [4] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_10.asc"
#>  [5] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_11.asc"
#>  [6] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_12.asc"
#>  [7] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_13.asc"
#>  [8] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_14.asc"
#>  [9] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_15.asc"
#> [10] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_bio_10min_r1i1p1_no_tile_asc/bio_16.asc"
```

See `?cc_cache` for all the cache management functions.

## Read data

After fetching data, you need to read the data into a `RasterLayer` or
`RasterBrick` object

You can read a single file


```r
cc_data_read(res[1])
#> class       : RasterLayer
#> dimensions  : 900, 2160, 1944000  (nrow, ncol, ncell)
#> resolution  : 0.1666667, 0.1666667  (x, y)
#> extent      : -180, 180, -60, 90  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA
#> data source : /Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_1.asc
#> names       : prec_1
#> values      : -2147483648, 2147483647  (min, max)
```

many files


```r
cc_data_read(res[1:2])
#> class       : RasterStack
#> dimensions  : 900, 2160, 1944000, 2  (nrow, ncol, ncell, nlayers)
#> resolution  : 0.1666667, 0.1666667  (x, y)
#> extent      : -180, 180, -60, 90  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA
#> names       :      prec_1,     prec_10
#> min values  : -2147483648, -2147483648
#> max values  :  2147483647,  2147483647
```

or all files


```r
cc_data_read(res)
#> class       : RasterStack
#> dimensions  : 900, 2160, 1944000, 12  (nrow, ncol, ncell, nlayers)
#> resolution  : 0.1666667, 0.1666667  (x, y)
#> extent      : -180, 180, -60, 90  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA
#> names       :      prec_1,     prec_10,     prec_11,     prec_12,      prec_2,      prec_3,      prec_4,      prec_5,      prec_6,      prec_7,      prec_8,      prec_9
#> min values  : -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648
#> max values  :  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647,  2147483647
```

## Visualize


```r
library("raster")
plot(cc_data_read(res[1:6]))
```

![plot of chunk unnamed-chunk-23](img/unnamed-chunk-23-1.png)

For more control over vizualizations of raster data, check out the
[rasterVis](https://CRAN.R-project.org/package=rasterVis) package.
