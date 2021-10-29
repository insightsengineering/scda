
# Synthetic CDISC Data Archive Accessor Functions

This R package contains functions for accessing synthetic CDISC from data archive packages. Data from archive packages will not be changed over time so that it can be used for unit testing.

# Installation

## Clone and install manually
1. Clone the repository

   The repository can be downloaded directly from the `github.com` site as an archive (see [GitHub tutorial on cloning to learn more](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository)). Alternatively, Git command line tools offer the same functionality, without the need for manual downloading and unpacking the archive, but require to authenticate to GitHub. You can authenticate using a key pair or a Personal Access Token (PAT). Please refer to excellent GitHub tutorials on [connecting to GitHub using SSH](https://docs.github.com/en/github/authenticating-to-github) or [creating and using PAT](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token).
   1. Using PAT. Input in the Git Bash console, PowerShell or any Linux shell:

      ```
      $ git clone https://github.com/insightsengineering/scda.git
      Username: your_username_goes_here
      Password: your_token_goes_here
      ```
    1. Using SSH. If set up properly, the repository is ready to be cloned executing:

       ```
       $ git clone https://github.com/insightsengineering/scda.git
       ```
   This creates a sub-directory `scda` containing the cloned repository.

2. Build and install

   The native R tools provide a quick way to install a package. Run in PowerShell or any Linux shell:
   ```
   $ R CMD build scda
   ```
   This command builds the package and creates an archive. The name of the archive is output by the command at then of building. Then input in the shell:
   ```
   $ Rscript -e 'install.packages("name_of_the_archive")
   ```
   Here is an example of a real command (with name_of_the_archive substituted by the output of the build command):
   ```
   $ Rscript -e 'install.packages("scda_0.1.0.9000.tar.gz")'
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

