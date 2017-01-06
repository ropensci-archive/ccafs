context("cc_data_fetch")

key1 <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1_m/10min/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"

test_that("cc_data_fetch works", {
  skip_on_cran()

  aa <- cc_data_fetch(key = key1, progress = FALSE)

  expect_is(aa, "ccafs_files")
  expect_null(names(aa))
  expect_is(unclass(aa)[1], "character")
  expect_match(unclass(aa)[1], cc_cache_path())
  expect_match(unclass(aa)[1], "bcc_csm1")
})

test_that("cc_data_fetch - fails well", {
  skip_on_cran()

  expect_error(cc_data_fetch(), "argument \"key\" is missing")
  expect_error(cc_data_fetch("Adfadfs", progress = FALSE), "Not Found")
})
