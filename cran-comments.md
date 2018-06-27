# rde 0.1.0
## Addressed CRAN comments
> Thanks, please elaborate your Description a bit. I'm not sure I understand
> what you mean.

The description field in the DESCRIPTION file has been updated.

> Please replace \dontrun{} by \donttest{} in your Rd-files.

Replaced `\dontrun{}` with `\donttest{}` in copy_rde_var.Rd

## Test environments
- docker image: rocker/tidyverse:3.5.0 (R 3.5.0)
- local Ubuntu 16.04 (R 3.4.4)
- local Windows 10 (R 3.4.2)
- win-builder (release and devel)

## R CMD check results
There were no ERRORs or WARNINGs.

This is the first submission of this package, hence there is one NOTE:

> * checking CRAN incoming feasibility ... NOTE
> Maintainer: 'Stefan Kloppenborg <stefan.kloppenborg@gmail.com>'
>
> New submission

## Downstream dependencies
Since this is a new package, there are no downstream dependencies.
