testthat::test_that("synthetic_cdisc_dataset works as expected", {
  # latest
  adsl_ltst <- synthetic_cdisc_dataset("latest", "adsl")
  testthat::expect_gt(nrow(adsl_ltst), 1)
  testthat::expect_gt(ncol(adsl_ltst), 1)
  testthat::expect_identical(tail(attr(adsl_ltst, "class"), 1), "data.frame")
  testthat::expect_identical(attr(adsl_ltst, "label"), "Subject Level Analysis Dataset")

  # specific timestamp
  adsl <- synthetic_cdisc_dataset("rcd_2023_03_17", "adsl")
  testthat::expect_gt(nrow(adsl), 1)
  testthat::expect_gt(ncol(adsl), 1)
  testthat::expect_identical(tail(attr(adsl, "class"), 1), "data.frame")
  testthat::expect_identical(attr(adsl, "label"), "Subject Level Analysis Dataset")
})

testthat::test_that("synthetic_cdisc_data works as expected", {
  # latest
  my_data_ltst <- synthetic_cdisc_data("latest")
  testthat::expect_gte(length(my_data_ltst), 20)
  testthat::expect_true("adsl" %in% names(my_data_ltst))

  # specific timestamp
  my_data <- synthetic_cdisc_data("rcd_2023_03_17")
  testthat::expect_gte(length(my_data), 20)
  testthat::expect_true("adsl" %in% names(my_data))
})

testthat::test_that("ls_synthetic_cdisc_data works as expected", {
  which_data <- ls_synthetic_cdisc_data()
  testthat::expect_gte(nrow(which_data), 42)
  testthat::expect_identical(ncol(which_data), 4)
})
