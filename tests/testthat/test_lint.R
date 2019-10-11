if (requireNamespace("lintr", quietly = TRUE)) {
  library(lintr)

  context("linting package")
  test_that("Package Style", {
    expect_lint_free(
      linters = with_defaults(
        object_name_linter(styles = c("dotted.case", "snake_case"))
      )
    )
  })
}
