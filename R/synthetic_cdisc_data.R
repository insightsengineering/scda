#' Get Synthetic CDISC Dataset
#'
#' @param dataset_name the lowercase name of the requested dataset e.g. `"adsl"`
#' @param name name of data collection. If name = "latest" then the newest datasets get returned
#'
#' @return A data.frame of synthetic data
#' @export
#'
#' @examples
#' \dontrun{
#' library(scda.2021)
#'
#' adsl <- synthetic_cdisc_dataset("adsl", "latest")
#' }
synthetic_cdisc_dataset <- function(dataset_name, name) {
  synthetic_cdisc_data(name)[[dataset_name]]
}



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
#' \dontrun{
#' library(scda.2021)
#'
#' dfs <- synthetic_cdisc_data("rcd_2021_03_22")
#' names(dfs)
#'
#' latest_dfs <- synthetic_cdisc_data("latest")
#' names(latest_dfs)
#' }
synthetic_cdisc_data <- function(name) {
  avail <- ls_synthetic_cdisc_data()

  if (nrow(avail) == 0) {
    stop("No synthetic CDISC data archive packages are installed.", call. = FALSE)
  }

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
#' @importFrom utils installed.packages data
#' @export
#'
#' @examples
#'
#' ls_synthetic_cdisc_data()
ls_synthetic_cdisc_data <- function() {
  all_pkgs <- as.vector(installed.packages()[, "Package"])
  pkgs <- unique(all_pkgs[grepl("^scda\\.[[:digit:]]{4}$", all_pkgs)])

  if (length(pkgs) == 0) {
    data.frame(
      Name = character(0),
      Title = character(0),
      Package = character(0),
      stringsAsFactors = FALSE
    )
  } else {
    all <- do.call(rbind, lapply(pkgs, function(pkgi) {
      dnms <- data(package = pkgi)$results[, 3:4]

      df <- if (length(dnms) == 2) {
        data.frame(
          Item = dnms[1],
          Title = dnms[2],
          row.names = NULL,
          stringsAsFactors = FALSE
        )
      } else {
        as.data.frame(dnms, stringsAsFactors = FALSE)
      }

      df$Package <- pkgi # nolint
      df
    }))

    names(all) <- c("Name", "Title", "Package")

    dates <- as.Date(substring(all$Name, nchar(all$Name) - 9), format = "%Y_%m_%d")

    all$Latest <- FALSE # nolint
    all$Latest[which.max(dates)] <- TRUE

    all
  }
}
