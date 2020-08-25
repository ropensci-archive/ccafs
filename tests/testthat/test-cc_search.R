context("cc_search")

test_that("cc_search works - eg1", {
  skip_on_cran()

  aa <- cc_search(file_set = 4, scenario = 6, model = 2, extent = "global",
    format = "ascii", period = 5, variable = 2, resolution = 3)

  expect_is(aa, "character")
  expect_match(aa, "gisweb.ciat.cgiar.org")
  expect_match(aa, "ccafs")
  expect_match(aa, "ipcc_4ar")
})

test_that("cc_search - fails well", {
  skip_on_cran()

  # deprecated file
  expect_error(
    cc_search(file_set = 3, scenario = 2, model = 4, extent = "global",
      format = "ascii", period = 7, variable = 2, resolution = 5
    ),
    "no results found or all files deprecated"
  )
})
