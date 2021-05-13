# Synthetic CDISC Data Archive Accessor Functions

This R package contains functions for accessing synthetic CDISC from data archihve packages. Data from archive packages will not be changed over time so that it can be used for unit testing.

## Installation

Data archive pacakges must be installed separately
```r

devtools::install_github(
  repo = "NEST/scda.2020",
  host = "https://github.roche.com/api/v3",
  upgrade_dependencies = FALSE
)

devtools::install_github(
  repo = "NEST/scda.2021",
  host = "https://github.roche.com/api/v3",
  upgrade_dependencies = FALSE
)

devtools::install_github(
  repo = "NEST/scda",
  host = "https://github.roche.com/api/v3",
  upgrade_dependencies = FALSE
)
```

## Basic Usage

You can see which data are available with
```r
ls_synthetic_cdisc_data()
```

And to load a specific data archive use 
```r
dfs <- synthetic_cdisc_data("rcd_2021_03_22")
names(dfs)

latest_dfs <- synthetic_cdisc_data("latest")
names(latest_dfs)
```
