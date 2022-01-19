.onAttach <- function(libname, pkgname) { # nolint
  scda_lookup <- paste0("scda.", 2020:(as.integer(format(Sys.Date(), "%Y")) + 1))
  is_scdax <- any(sapply(scda_lookup, function(x) length(find.package(x, quiet = TRUE)) > 0))
  packageStartupMessage(
    if (!is_scdax) {
      paste0(
        "There are no scda.XXXX libraries installed, like scda.2021.",
        "\nPlease install an scda database to take full advantage of the scda package."
      )
    }
  )
}
