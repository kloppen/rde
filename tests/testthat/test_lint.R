if (requireNamespace("lintr", quietly = TRUE)) {
  library(lintr)

  context("linting package")
  test_that("Package Style", {

    # There is currently a problem with the `lintr` package that causes
    # `expect_lint_free` to fail when checking  a package from the RStudio
    # IDE. For now, including the following check will skip the
    # `expect_lint_free` when it will fail due to this problem

    find_package <- function(path) {
      path <- normalizePath(path, mustWork = FALSE)

      while (!file.exists(file.path(path, "DESCRIPTION"))) {
        path <- dirname(path)
        if (identical(path, dirname(path))) {
          return(NULL)
        }
      }

      path
    }

    if (!is.null(find_package("."))) {
      expect_lint_free(
        linters = with_defaults(
          object_name_linter(styles = c("dotted.case", "snake_case"))
        )
      )
    }
  })
}
