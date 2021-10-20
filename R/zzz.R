.onLoad <- function(libname, pkgname) { # nolint
  is_scdax <- any(grepl("scda\\.[0-9]{4,4}", installed.packages()[, 1]))
  packageStartupMessage(
    if (!is_scdax) paste0("There are no scda.XXXX libraries installed, like scda.2021.",
                          "\nPlease install an scda database to take full advantage of the scda package.")
  )
}
