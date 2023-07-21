.onAttach <- function(libname, pkgname) { # nolint
  scda_lookup <- paste0("scda.", seq(2020, 2030))
  is_scdax <- any(vapply(scda_lookup, function(x) length(find.package(x, quiet = TRUE)) > 0, logical(1)))
  packageStartupMessage(
    if (!is_scdax) { # nocov start
      paste0(
        "There are no scda.XXXX libraries installed, like scda.2022.",
        "\nPlease install an scda database to take full advantage of the scda package.",
        "\nVisit https://insightsengineering.github.io/scda.2022/ for details on scda.2022 and how it can be installed."
      )
    } # nocov end
  )
}
