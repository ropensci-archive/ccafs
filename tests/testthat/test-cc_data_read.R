context("cc_data_read")

key1 <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/rcp2_6/2030s/bcc_csm1_1_m/10min/bcc_csm1_1_m_rcp2_6_2030s_prec_10min_r1i1p1_no_tile_asc.zip"

test_that("cc_data_read works", {
  skip_on_cran()

  res <- cc_data_fetch(key = key1, progress = FALSE)

  # single
  aa <- cc_data_read(res[1])
  expect_is(aa, "RasterLayer")

  # a few
  bb <- cc_data_read(res[1:2])
  expect_is(bb, "RasterStack")

  # all
  cc <- cc_data_read(res)
  expect_is(cc, "RasterStack")
})

test_that("cc_data_read - fails well", {
  skip_on_cran()

  expect_error(cc_data_read(), "argument \"x\" is missing")
  expect_error(cc_data_read("Adfadfs"), "don't exist")

  # fails well when bad unreadable param used
  res <- cc_data_fetch(key = key1, progress = FALSE)
  expect_error(cc_data_read(x = res, unreadable = "Adfadfs"),
               "is not TRUE")
})
