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

Potential users are probably anyone from scientists asking questions about climate change, to scientists or companies projecting crop yields in the future.

## Install

Dev version


```r
devtools::install_github("ropenscilabs/ccafs")
```


```r
library("ccafs")
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
#> <CCAFS GCM files>
#>    12 files
#>    Base dir: /bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc
#>    File types (count): 
#>      - .asc: 12
```


```r
(res <- cc_data_fetch(key = key))
```

Using the above set of zips, fetch some data:


```r
x <- cc_data_fetch(zips[1])
#> 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |                                                                 |   1%
  |                                                                       
  |=                                                                |   1%
  |                                                                       
  |=                                                                |   2%
  |                                                                       
  |==                                                               |   3%
  |                                                                       
  |==                                                               |   4%
  |                                                                       
  |===                                                              |   4%
  |                                                                       
  |===                                                              |   5%
  |                                                                       
  |====                                                             |   6%
  |                                                                       
  |====                                                             |   7%
  |                                                                       
  |=====                                                            |   7%
  |                                                                       
  |=====                                                            |   8%
  |                                                                       
  |======                                                           |   8%
  |                                                                       
  |======                                                           |   9%
  |                                                                       
  |======                                                           |  10%
  |                                                                       
  |=======                                                          |  10%
  |                                                                       
  |=======                                                          |  11%
  |                                                                       
  |=======                                                          |  12%
  |                                                                       
  |========                                                         |  12%
  |                                                                       
  |========                                                         |  13%
  |                                                                       
  |=========                                                        |  13%
  |                                                                       
  |=========                                                        |  14%
  |                                                                       
  |=========                                                        |  15%
  |                                                                       
  |==========                                                       |  15%
  |                                                                       
  |==========                                                       |  16%
  |                                                                       
  |===========                                                      |  16%
  |                                                                       
  |===========                                                      |  17%
  |                                                                       
  |===========                                                      |  18%
  |                                                                       
  |============                                                     |  18%
  |                                                                       
  |============                                                     |  19%
  |                                                                       
  |=============                                                    |  19%
  |                                                                       
  |=============                                                    |  20%
  |                                                                       
  |=============                                                    |  21%
  |                                                                       
  |==============                                                   |  21%
  |                                                                       
  |==============                                                   |  22%
  |                                                                       
  |===============                                                  |  22%
  |                                                                       
  |===============                                                  |  23%
  |                                                                       
  |===============                                                  |  24%
  |                                                                       
  |================                                                 |  24%
  |                                                                       
  |================                                                 |  25%
  |                                                                       
  |=================                                                |  26%
  |                                                                       
  |=================                                                |  27%
  |                                                                       
  |==================                                               |  27%
  |                                                                       
  |==================                                               |  28%
  |                                                                       
  |===================                                              |  29%
  |                                                                       
  |===================                                              |  30%
  |                                                                       
  |====================                                             |  30%
  |                                                                       
  |====================                                             |  31%
  |                                                                       
  |====================                                             |  32%
  |                                                                       
  |=====================                                            |  32%
  |                                                                       
  |=====================                                            |  33%
  |                                                                       
  |======================                                           |  33%
  |                                                                       
  |======================                                           |  34%
  |                                                                       
  |=======================                                          |  35%
  |                                                                       
  |=======================                                          |  36%
  |                                                                       
  |========================                                         |  36%
  |                                                                       
  |========================                                         |  37%
  |                                                                       
  |========================                                         |  38%
  |                                                                       
  |=========================                                        |  38%
  |                                                                       
  |=========================                                        |  39%
  |                                                                       
  |==========================                                       |  39%
  |                                                                       
  |==========================                                       |  40%
  |                                                                       
  |==========================                                       |  41%
  |                                                                       
  |===========================                                      |  41%
  |                                                                       
  |===========================                                      |  42%
  |                                                                       
  |============================                                     |  42%
  |                                                                       
  |============================                                     |  43%
  |                                                                       
  |============================                                     |  44%
  |                                                                       
  |=============================                                    |  44%
  |                                                                       
  |=============================                                    |  45%
  |                                                                       
  |==============================                                   |  46%
  |                                                                       
  |==============================                                   |  47%
  |                                                                       
  |===============================                                  |  47%
  |                                                                       
  |===============================                                  |  48%
  |                                                                       
  |================================                                 |  48%
  |                                                                       
  |================================                                 |  49%
  |                                                                       
  |================================                                 |  50%
  |                                                                       
  |=================================                                |  50%
  |                                                                       
  |=================================                                |  51%
  |                                                                       
  |==================================                               |  52%
  |                                                                       
  |==================================                               |  53%
  |                                                                       
  |===================================                              |  53%
  |                                                                       
  |===================================                              |  54%
  |                                                                       
  |====================================                             |  55%
  |                                                                       
  |====================================                             |  56%
  |                                                                       
  |=====================================                            |  56%
  |                                                                       
  |=====================================                            |  57%
  |                                                                       
  |=====================================                            |  58%
  |                                                                       
  |======================================                           |  58%
  |                                                                       
  |======================================                           |  59%
  |                                                                       
  |=======================================                          |  59%
  |                                                                       
  |=======================================                          |  60%
  |                                                                       
  |========================================                         |  61%
  |                                                                       
  |========================================                         |  62%
  |                                                                       
  |=========================================                        |  63%
  |                                                                       
  |=========================================                        |  64%
  |                                                                       
  |==========================================                       |  64%
  |                                                                       
  |==========================================                       |  65%
  |                                                                       
  |===========================================                      |  66%
  |                                                                       
  |===========================================                      |  67%
  |                                                                       
  |============================================                     |  67%
  |                                                                       
  |============================================                     |  68%
  |                                                                       
  |=============================================                    |  69%
  |                                                                       
  |=============================================                    |  70%
  |                                                                       
  |==============================================                   |  70%
  |                                                                       
  |==============================================                   |  71%
  |                                                                       
  |==============================================                   |  72%
  |                                                                       
  |===============================================                  |  72%
  |                                                                       
  |===============================================                  |  73%
  |                                                                       
  |================================================                 |  73%
  |                                                                       
  |================================================                 |  74%
  |                                                                       
  |=================================================                |  75%
  |                                                                       
  |=================================================                |  76%
  |                                                                       
  |==================================================               |  76%
  |                                                                       
  |==================================================               |  77%
  |                                                                       
  |==================================================               |  78%
  |                                                                       
  |===================================================              |  78%
  |                                                                       
  |===================================================              |  79%
  |                                                                       
  |====================================================             |  79%
  |                                                                       
  |====================================================             |  80%
  |                                                                       
  |====================================================             |  81%
  |                                                                       
  |=====================================================            |  81%
  |                                                                       
  |=====================================================            |  82%
  |                                                                       
  |======================================================           |  82%
  |                                                                       
  |======================================================           |  83%
  |                                                                       
  |======================================================           |  84%
  |                                                                       
  |=======================================================          |  84%
  |                                                                       
  |=======================================================          |  85%
  |                                                                       
  |========================================================         |  86%
  |                                                                       
  |========================================================         |  87%
  |                                                                       
  |=========================================================        |  87%
  |                                                                       
  |=========================================================        |  88%
  |                                                                       
  |==========================================================       |  89%
  |                                                                       
  |==========================================================       |  90%
  |                                                                       
  |===========================================================      |  90%
  |                                                                       
  |===========================================================      |  91%
  |                                                                       
  |============================================================     |  92%
  |                                                                       
  |============================================================     |  93%
  |                                                                       
  |=============================================================    |  93%
  |                                                                       
  |=============================================================    |  94%
  |                                                                       
  |=============================================================    |  95%
  |                                                                       
  |==============================================================   |  95%
  |                                                                       
  |==============================================================   |  96%
  |                                                                       
  |===============================================================  |  96%
  |                                                                       
  |===============================================================  |  97%
  |                                                                       
  |===============================================================  |  98%
  |                                                                       
  |================================================================ |  98%
  |                                                                       
  |================================================================ |  99%
  |                                                                       
  |=================================================================|  99%
  |                                                                       
  |=================================================================| 100%
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
cc_cache_list()
#>  [1] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc"            
#>  [2] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"        
#>  [3] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_1.asc" 
#>  [4] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_10.asc"
#>  [5] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_11.asc"
#>  [6] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_12.asc"
#>  [7] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_2.asc" 
#>  [8] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_3.asc" 
#>  [9] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_4.asc" 
#> [10] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_5.asc" 
#> [11] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_6.asc" 
#> [12] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_7.asc" 
#> [13] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_8.asc" 
#> [14] "/Users/sacmac/Library/Caches/ccafs/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc/prec_9.asc" 
#> [15] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc"                   
#> [16] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc.zip"               
#> [17] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_1.asc"        
#> [18] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_10.asc"       
#> [19] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_11.asc"       
#> [20] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_12.asc"       
#> [21] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_2.asc"        
#> [22] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_3.asc"        
#> [23] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_4.asc"        
#> [24] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_5.asc"        
#> [25] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_6.asc"        
#> [26] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_7.asc"        
#> [27] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_8.asc"        
#> [28] "/Users/sacmac/Library/Caches/ccafs/hadcm_cntrl_baseline_1970s_prec_20min_sa_eta_asc/prec_9.asc"
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

or all files


```r
cc_data_read(res)
#> class       : RasterBrick 
#> dimensions  : 900, 2160, 1944000, 12  (nrow, ncol, ncell, nlayers)
#> resolution  : 0.1666667, 0.1666667  (x, y)
#> extent      : -180, 180, -60, 90  (xmin, xmax, ymin, ymax)
#> coord. ref. : NA 
#> data source : in memory
#> names       : prec_1, prec_10, prec_11, prec_12, prec_2, prec_3, prec_4, prec_5, prec_6, prec_7, prec_8, prec_9 
#> min values  :      0,       0,       0,       0,      0,      0,      0,      0,      0,      0,      0,      0 
#> max values  :    966,     997,     879,     920,    838,    797,    811,   1064,   2268,   2629,   1693,    956
```

## Visualize


```r
library("raster")
plot(cc_data_read(res[1:6]))
```

![plot of chunk unnamed-chunk-17](img/unnamed-chunk-17-1.png)

For more control over vizualizations of raster data, check out the 
[rasterVis](https://CRAN.R-project.org/package=rasterVis) package.
