.onAttach <- function(libname, pkgname) { # nolint
  is_scdaX <- any(grepl("scda\\.[0-9]{4,4}", installed.packages()[, 1]))
  packageStartupMessage(
    "\nYou are using scda version ",
    read.dcf(system.file("DESCRIPTION", package = "scda"))[, "Version"],
    if (!is_scdaX) "\nThere are no scda.XXXX libraries installed, like scda.2021. \nPlease install a scda database to take full advantage of the scda package."
  )
}
