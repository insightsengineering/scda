library(testthat)

pkg_name <- "scda"
library(pkg_name, character.only = TRUE)
testthat::test_check(pkg_name)
