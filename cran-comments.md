# rde 0.1.0
## General
Thanks for donating your time to volunteer for CRAN. I appreciate the time
that the CRAN volunteers have spent reviewing this package, and their
patience.

Please note that I've changed the email address in the `DESCRIPTION` file from
stefan.kloppenborg@gmail.com to stefan@kloppenborg.ca. I've used the old
address to send an email confirming this change to
CRAN-submissions@R-project.org.

## Addressed CRAN comments
### Comments (1-Jul-2018)
> Thanks, we see:
```
* checking tests ...
** running tests for arch 'i386' ... [7s] OK
 Running 'spelling.R' [3s]
 Comparing 'spelling.Rout' to 'spelling.Rout.save' ...4,5c4,5
< +   spelling::spell_check_test(vignettes = TRUE, error = FALSE)
< + }
---
> >   spelling::spell_check_test(vignettes = TRUE, error = FALSE)
> > }
```
> And indeed, R continutation lines start with a "+" rather than with a ">".
> Not sure where these come from in your Rout.save file.
>
> Please fix spelling.Rout.save and resubmit.

This was addressed by removing the check (that used `requireNamespace`) that
ensured that the package `spelling` is available in the file tests/spelling.R.
The package `spelling` is a suggested package for the package `rde`. Omitting
the `requireNamespace` check in tests involving the `spelling` package seems
to be common. This is the default test code created by
`spelling::spell_check_setup()`. This is also the case in the `writexl`,
`curl` and `httptest` packages, for example.

### Comments (24-Jun-2018)
> Thanks, please elaborate your Description a bit. I'm not sure I understand
> what you mean.

The description field in the DESCRIPTION file has been updated.

> Please replace \dontrun{} by \donttest{} in your Rd-files.

Replaced `\dontrun{}` with `\donttest{}` in copy_rde_var.Rd

## Test environments
- docker image: rocker/tidyverse:3.5.0 (R 3.5.0)
- local Ubuntu 16.04 (R 3.4.4)
- win-builder (release and devel)

## R CMD check results
There were no ERRORs or WARNINGs.

This is the first submission of this package, hence there is one NOTE:

> * checking CRAN incoming feasibility ... NOTE
> Maintainer: 'Stefan Kloppenborg <stefan@kloppenborg.ca>'
>
> New submission

## Downstream dependencies
Since this is a new package, there are no downstream dependencies.
