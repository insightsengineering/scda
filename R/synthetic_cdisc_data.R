
#' Get Synthetic CDISC Data
#'
#' @param name name of data collection. If name == "latest" then the newest datasets get returned
#'
#' @export
#'
#' @return A named list with synthetic data
#'
#'
#' @examples
#'
#' dfs <- synthetic_cdisc_data("rcd_2021_03_22")
#' names(dfs)
#'
#' synthetic_cdisc_data("latest")
#'
synthetic_cdisc_data <- function(name) {

  avail <- ls_synthetic_cdisc_data()

  if (identical(name, "latest")) {
    name <- avail$Name[avail$Latest]
  }

  stopifnot(
    length(name) == 1,
    name %in% avail$Name
  )

  i <- which(name == avail$Name)

  sel <- as.list(avail[i, ])

  e <- new.env()
  cl <- call("data", sel$Name, envir = quote(e), package = sel$Package)
  eval(cl)

  structure(e[[sel$Name]], data_from = c(sel$Package, sel$Name))
}


#' List Available Data
#'
#' @export
#'
#' @examples
#'
#' ls_synthetic_cdisc_data()
#'
ls_synthetic_cdisc_data <- function() {

  all_pkgs <- as.vector(installed.packages()[, "Package"])
  pkgs <- unique(all_pkgs[grepl("^scda\\.[[:digit:]]{4}$", all_pkgs)])

  if (length(pkgs) == 0) {
    data.frame(Name = character(0), Title = character(0), Package = character(0))
  } else {
    all <- do.call(rbind, lapply(pkgs, function(pkgi) {
      dnms <- data(package = pkgi)$results[, 3:4]

      df <- if (length(dnms) == 2) {
        data.frame(Item = dnms[1], Title = dnms[2], row.names = NULL)
      } else {
        as.data.frame(dnms)
      }

      df$Package = pkgi
      df
    }))

    names(all) <- c("Name", "Title", "Package")

    dates <- as.Date(substring(all$Name, nchar(all$Name) - 9), format = "%Y_%m_%d")

    all$Latest <- FALSE
    all$Latest[which.max(dates)] <- TRUE

    all
  }

}
