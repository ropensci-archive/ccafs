context("cc_list_keys")

test_that("cc_list_keys level works - parsing", {
  skip_on_cran()

  aa <- cc_list_keys()

  expect_is(aa, "tbl_df")
  expect_named(aa, c("Key", "LastModified", "ETag", "Size", "StorageClass"))
  expect_is(aa$Key, "character")
  expect_is(aa$ETag, "character")
})

test_that("cc_list_keys - max parameter works", {
  skip_on_cran()

  aa <- cc_list_keys(max = 1)
  bb <- cc_list_keys(max = 3)
  cc <- cc_list_keys(max = 7)
  dd <- cc_list_keys(max = 0)

  expect_is(aa, "tbl_df")
  expect_is(bb, "tbl_df")
  expect_is(cc, "tbl_df")
  expect_is(dd, "tbl_df")

  expect_gt(NROW(bb), NROW(aa))
  expect_gt(NROW(cc), NROW(aa))
  expect_gt(NROW(cc), NROW(bb))
  expect_equal(NROW(dd), 0)
})

test_that("cc_list_keys - prefix parameter works", {
  skip_on_cran()

  pref <- "ccafs/ccafs-climate/data/ipcc_5ar_ciat_downscaled/"
  aa <- cc_list_keys(prefix = pref, max = 10)

  expect_is(aa, "tbl_df")
  expect_true(all(grepl(paste0("^", pref), aa$Key)))
})

test_that("cc_list_keys - marker parameter works", {
  skip_on_cran()

  aa <- cc_list_keys(max = 3)
  bb <- cc_list_keys(marker = aa$Key[3], max = 3)

  expect_is(aa, "tbl_df")
  expect_is(bb, "tbl_df")
})
