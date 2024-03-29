#' Get Synthetic CDISC Dataset
#'
#' @param archive_name name of data collection. If `archive_name = "latest"` then the newest dataset gets returned.
#' @param dataset_name the lowercase name of the requested dataset (e.g. `"adsl"`).
#'
#' @return A `data.frame` containing synthetic data.
#'
#' @examples
#' \dontrun{
#' library(scda.2022)
#'
#' adsl <- synthetic_cdisc_dataset("latest", "adsl")
#' }
#'
#' @export
synthetic_cdisc_dataset <- function(archive_name, dataset_name) {
  avail <- ls_synthetic_cdisc_data()
  dt <- paste(archive_name, dataset_name, sep = "_")

  if (nrow(avail) == 0) { # nocov start
    stop("No synthetic CDISC data archive packages are installed.", call. = FALSE)
  } # nocov end

  if (identical(archive_name, "latest")) {
    dt <- paste(substring(avail$Name[avail$Latest], 1, 14)[1], dataset_name, sep = "_")
  }

  stopifnot(
    length(archive_name) == 1 & length(dataset_name) == 1,
    dt %in% avail$Name
  )

  i <- which(dt == avail$Name)

  sel <- as.list(avail[i, ])

  e <- new.env()
  cl <- call("data", sel$Name, envir = quote(e), package = sel$Package)
  eval(cl)

  structure(e[[dt]], data_from = c(sel$Package, sel$Name))
}

#' Get Synthetic CDISC Data
#'
#' @param name name of data collection to return. If `name = "latest"` then the newest datasets get returned.
#'
#' @return A named `list` containing synthetic datasets.
#'
#' @examples
#' \dontrun{
#' library(scda.2022)
#'
#' dfs <- synthetic_cdisc_data("rcd_2022_06_27")
#' names(dfs)
#'
#' latest_dfs <- synthetic_cdisc_data("latest")
#' names(latest_dfs)
#' }
#'
#' @export
synthetic_cdisc_data <- function(name) {
  avail <- ls_synthetic_cdisc_data()

  if (nrow(avail) == 0) { # nocov start
    stop("No synthetic CDISC data archive packages are installed.", call. = FALSE)
  } # nocov end

  if (identical(name, "latest")) {
    name <- substring(avail$Name[avail$Latest], 1, 14)[1]
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
#'
#' @examples
#' ls_synthetic_cdisc_data()
#'
#' @export
ls_synthetic_cdisc_data <- function() {
  all_pkgs <- as.vector(installed.packages()[, "Package"])
  pkgs <- unique(all_pkgs[grepl("^scda\\.[[:digit:]]{4}$", all_pkgs)])

  if (length(pkgs) == 0) { # nocov start
    data.frame(
      Name = character(0),
      Title = character(0),
      Package = character(0),
      stringsAsFactors = FALSE
    )
  } else { # nocov end
    all <- do.call(rbind, lapply(pkgs, function(pkgi) {
      dnms <- data(package = pkgi)$results[, 3:4]

      df <- if (length(dnms) == 2) { # nocov start
        data.frame(
          Item = dnms[1],
          Title = dnms[2],
          row.names = NULL,
          stringsAsFactors = FALSE
        )
      } else { # nocov end
        as.data.frame(dnms, stringsAsFactors = FALSE)
      }

      df$Package <- pkgi # nolint
      df
    }))

    names(all) <- c("Name", "Title", "Package")

    dates <- as.Date(substring(all$Name, 5, 14), format = "%Y_%m_%d")

    all$Latest <- FALSE # nolint
    all$Latest[dates == max(dates)] <- TRUE

    all
  }
}
