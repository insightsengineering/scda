# Scda: Synthetic CDISC Data Archive Accessor Functions <a href='https://insightsengineering.github.io/scda'><img src="man/figures/logo.png" align="right" height="139" style="max-width: 100%;"/></a>

<!-- start badges -->
[![Check 🛠](https://github.com/insightsengineering/scda/actions/workflows/check.yaml/badge.svg)](https://github.com/insightsengineering/scda/actions/workflows/check.yaml)
[![Docs 📚](https://github.com/insightsengineering/scda/actions/workflows/docs.yaml/badge.svg)](https://insightsengineering.github.io/scda/)
[![Code Coverage 📔](https://raw.githubusercontent.com/insightsengineering/scda/_xml_coverage_reports/data/main/badge.svg)](https://raw.githubusercontent.com/insightsengineering/scda/_xml_coverage_reports/data/main/coverage.xml)

![GitHub forks](https://img.shields.io/github/forks/insightsengineering/scda?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/insightsengineering/scda?style=social)

![GitHub commit activity](https://img.shields.io/github/commit-activity/m/insightsengineering/scda)
![GitHub contributors](https://img.shields.io/github/contributors/insightsengineering/scda)
![GitHub last commit](https://img.shields.io/github/last-commit/insightsengineering/scda)
![GitHub pull requests](https://img.shields.io/github/issues-pr/insightsengineering/scda)
![GitHub repo size](https://img.shields.io/github/repo-size/insightsengineering/scda)
![GitHub language count](https://img.shields.io/github/languages/count/insightsengineering/scda)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Current Version](https://img.shields.io/github/r-package/v/insightsengineering/scda/main?color=purple\&label=package%20version)](https://github.com/insightsengineering/scda/tree/main)
[![Open Issues](https://img.shields.io/github/issues-raw/insightsengineering/scda?color=red\&label=open%20issues)](https://github.com/insightsengineering/scda/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc)
<!-- end badges -->

This R package contains functions for accessing synthetic CDISC from data archive packages such as [scda.2022](https://insightsengineering.github.io/scda.2022).
At least one of these archive packages should be installed in order to use this package.

This synthetic data can be used as test data when developing `teal` applications or statistical analysis functions and due to the data not been derived from a real clinical trial it provides an excellent method for generating reproducible examples when reporting errors.

Note however that this data is somewhat idealized and real trial data is often significantly more complex and messy.

## Installation

For releases from August 2022 it is recommended that you [create and use a Github PAT](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) to install the latest version of this package. Once you have the PAT, run the following:

```r
Sys.setenv(GITHUB_PAT = "your_access_token_here")
if (!require("remotes")) install.packages("remotes")
remotes::install_github("insightsengineering/scda@*release")
```

A stable release of all `NEST` packages from June 2022 is also available [here](https://github.com/insightsengineering/depository#readme).

To install `scda.2022`, run the following:

```r
Sys.setenv(GITHUB_PAT = "your_access_token_here")
if (!require("remotes")) install.packages("remotes")
remotes::install_github("insightsengineering/scda.2022@*release")
```

Please see the [`scda.2022` package website](https://insightsengineering.github.io/scda.2022/) for more details.

## Basic Usage

You can see which data are available with

```r
library(scda)
ls_synthetic_cdisc_data()
```

And to load a specific data archive use

```r
# chose the first one
chosen_data_archive <- ls_synthetic_cdisc_data()$Name[1]
print(chosen_data_archive)
oldest_dfs <- synthetic_cdisc_data(chosen_data_archive)
names(oldest_dfs)

# chose the latest one
latest_dfs <- synthetic_cdisc_data("latest")
names(latest_dfs)
```

## Stargazers and Forkers

### Stargazers over time

[![Stargazers over time](https://starchart.cc/insightsengineering/scda.svg)](https://starchart.cc/insightsengineering/scda)

### Stargazers

[![Stargazers repo roster for @insightsengineering/scda](https://reporoster.com/stars/insightsengineering/scda)](https://github.com/insightsengineering/scda/stargazers)

### Forkers

[![Forkers repo roster for @insightsengineering/scda](https://reporoster.com/forks/insightsengineering/scda)](https://github.com/insightsengineering/scda/network/members)
