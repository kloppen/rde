context("load data")

expanded_iris <- {
  structure(list(Sepal.Length = c(5.1, 4.9, 4.7, 4.6, 5, 5.4, 4.6,
                                  5, 4.4, 4.9, 5.4, 4.8, 4.8, 4.3, 5.8, 5.7, 5.4, 5.1, 5.7, 5.1,
                                  5.4, 5.1, 4.6, 5.1, 4.8, 5, 5, 5.2, 5.2, 4.7, 4.8, 5.4, 5.2,
                                  5.5, 4.9, 5, 5.5, 4.9, 4.4, 5.1, 5, 4.5, 4.4, 5, 5.1, 4.8, 5.1,
                                  4.6, 5.3, 5, 7, 6.4, 6.9, 5.5, 6.5, 5.7, 6.3, 4.9, 6.6, 5.2,
                                  5, 5.9, 6, 6.1, 5.6, 6.7, 5.6, 5.8, 6.2, 5.6, 5.9, 6.1, 6.3,
                                  6.1, 6.4, 6.6, 6.8, 6.7, 6, 5.7, 5.5, 5.5, 5.8, 6, 5.4, 6, 6.7,
                                  6.3, 5.6, 5.5, 5.5, 6.1, 5.8, 5, 5.6, 5.7, 5.7, 6.2, 5.1, 5.7,
                                  6.3, 5.8, 7.1, 6.3, 6.5, 7.6, 4.9, 7.3, 6.7, 7.2, 6.5, 6.4, 6.8,
                                  5.7, 5.8, 6.4, 6.5, 7.7, 7.7, 6, 6.9, 5.6, 7.7, 6.3, 6.7, 7.2,
                                  6.2, 6.1, 6.4, 7.2, 7.4, 7.9, 6.4, 6.3, 6.1, 7.7, 6.3, 6.4, 6,
                                  6.9, 6.7, 6.9, 5.8, 6.8, 6.7, 6.7, 6.3, 6.5, 6.2, 5.9),
                 Sepal.Width = c(3.5,
                                 3, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3.4, 3, 3, 4,
                                 4.4, 3.9, 3.5, 3.8, 3.8, 3.4, 3.7, 3.6, 3.3, 3.4, 3, 3.4, 3.5,
                                 3.4, 3.2, 3.1, 3.4, 4.1, 4.2, 3.1, 3.2, 3.5, 3.6, 3, 3.4, 3.5,
                                 2.3, 3.2, 3.5, 3.8, 3, 3.8, 3.2, 3.7, 3.3, 3.2, 3.2, 3.1, 2.3,
                                 2.8, 2.8, 3.3, 2.4, 2.9, 2.7, 2, 3, 2.2, 2.9, 2.9, 3.1, 3, 2.7,
                                 2.2, 2.5, 3.2, 2.8, 2.5, 2.8, 2.9, 3, 2.8, 3, 2.9, 2.6, 2.4,
                                 2.4, 2.7, 2.7, 3, 3.4, 3.1, 2.3, 3, 2.5, 2.6, 3, 2.6, 2.3, 2.7,
                                 3, 2.9, 2.9, 2.5, 2.8, 3.3, 2.7, 3, 2.9, 3, 3, 2.5, 2.9, 2.5,
                                 3.6, 3.2, 2.7, 3, 2.5, 2.8, 3.2, 3, 3.8, 2.6, 2.2, 3.2, 2.8,
                                 2.8, 2.7, 3.3, 3.2, 2.8, 3, 2.8, 3, 2.8, 3.8, 2.8, 2.8, 2.6,
                                 3, 3.4, 3.1, 3, 3.1, 3.1, 3.1, 2.7, 3.2, 3.3, 3, 2.5, 3, 3.4,
                                 3),
                 Petal.Length = c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5,
                                  1.4, 1.5, 1.5, 1.6, 1.4, 1.1, 1.2, 1.5, 1.3, 1.4, 1.7, 1.5, 1.7,
                                  1.5, 1, 1.7, 1.9, 1.6, 1.6, 1.5, 1.4, 1.6, 1.6, 1.5, 1.5, 1.4,
                                  1.5, 1.2, 1.3, 1.4, 1.3, 1.5, 1.3, 1.3, 1.3, 1.6, 1.9, 1.4, 1.6,
                                  1.4, 1.5, 1.4, 4.7, 4.5, 4.9, 4, 4.6, 4.5, 4.7, 3.3, 4.6, 3.9,
                                  3.5, 4.2, 4, 4.7, 3.6, 4.4, 4.5, 4.1, 4.5, 3.9, 4.8, 4, 4.9,
                                  4.7, 4.3, 4.4, 4.8, 5, 4.5, 3.5, 3.8, 3.7, 3.9, 5.1, 4.5, 4.5,
                                  4.7, 4.4, 4.1, 4, 4.4, 4.6, 4, 3.3, 4.2, 4.2, 4.2, 4.3, 3, 4.1,
                                  6, 5.1, 5.9, 5.6, 5.8, 6.6, 4.5, 6.3, 5.8, 6.1, 5.1, 5.3, 5.5,
                                  5, 5.1, 5.3, 5.5, 6.7, 6.9, 5, 5.7, 4.9, 6.7, 4.9, 5.7, 6, 4.8,
                                  4.9, 5.6, 5.8, 6.1, 6.4, 5.6, 5.1, 5.6, 6.1, 5.6, 5.5, 4.8, 5.4,
                                  5.6, 5.1, 5.1, 5.9, 5.7, 5.2, 5, 5.2, 5.4, 5.1),
                 Petal.Width = c(0.2,
                                 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.2, 0.1, 0.1,
                                 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4,
                                 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2,
                                 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2, 1.4, 1.5, 1.5,
                                 1.3, 1.5, 1.3, 1.6, 1, 1.3, 1.4, 1, 1.5, 1, 1.4, 1.3, 1.4, 1.5,
                                 1, 1.5, 1.1, 1.8, 1.3, 1.5, 1.2, 1.3, 1.4, 1.4, 1.7, 1.5, 1,
                                 1.1, 1, 1.2, 1.6, 1.5, 1.6, 1.5, 1.3, 1.3, 1.3, 1.2, 1.4, 1.2,
                                 1, 1.3, 1.2, 1.3, 1.3, 1.1, 1.3, 2.5, 1.9, 2.1, 1.8, 2.2, 2.1,
                                 1.7, 1.8, 1.8, 2.5, 2, 1.9, 2.1, 2, 2.4, 2.3, 1.8, 2.2, 2.3,
                                 1.5, 2.3, 2, 2, 1.8, 2.1, 1.8, 1.8, 1.8, 2.1, 1.6, 1.9, 2, 2.2,
                                 1.5, 1.4, 2.3, 2.4, 1.8, 1.8, 2.1, 2.4, 2.3, 1.9, 2.3, 2.5, 2.3,
                                 1.9, 2, 2.3, 1.8),
                 Species = structure(c(1L, 1L, 1L, 1L, 1L,
                                       1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                       1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L,
                                       1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L,
                                       2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                       2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                                       2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L,
                                       3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                       3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                       3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L,
                                       3L),
                                     .Label = c("setosa", "versicolor", "virginica"),
                                     class = "factor")),
            .Names = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"), row.names = c(NA, -150L),
            class = "data.frame")
}

modified_iris_3 <- {
  structure(list(Sepal.Length = c(50000.1, 4.9, 4.7),
                 Sepal.Width = c(3.5, 3, 3.2),
                 Petal.Length = c(1.4, 1.4, 1.3),
                 Petal.Width = c(0.2, 0.2, 0.2),
                 Species = structure(c(1L, 1L, 1L),
                                     .Label = c("setosa", "versicolor", "virginica"),
                                     class = "factor")),
            .Names = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
            row.names = c(NA, 3L),
            class = "data.frame")
}

# The first three rows from iris, but with Sepal.Length doubled
scaled_iris_3 <- {
  structure(list(Sepal.Length = c(10.2, 9.8, 9.4),
                 Sepal.Width = c(3.5, 3, 3.2),
                 Petal.Length = c(1.4, 1.4, 1.3),
                 Petal.Width = c(0.2, 0.2, 0.2),
                 Species = structure(c(1L, 1L, 1L),
                                     .Label = c("setosa", "versicolor", "virginica"),
                                     class = "factor")),
            .Names = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
            row.names = c(NA, 3L),
            class = "data.frame")
}

test_that("cached data loaded as expected", {
  b <- load_rde_var(TRUE, {iris}, expanded_iris)

  expect_equal(length(b), 5)
  expect_true(all.equal(b, iris))
})

test_that("new data loaded as expected", {
  b <- load_rde_var(FALSE, {iris}, expanded_iris)

  expect_equal(length(b), 5)
  expect_true(all.equal(b, iris))
})

test_that("new data with multiple lines", {
  b <- load_rde_var(
    FALSE,
    {
      a <- head(iris, 3)
      a$Sepal.Length <- a$Sepal.Length *2
      a
    },
    scaled_iris_3
  )

  expect_equal(length(b), 5)
  expect_true(all.equal(b, scaled_iris_3))
})

test_that("difference between new data and cahced data causes warning", {
  expect_warning(
    load_rde_var(FALSE, {iris}, modified_iris_3)
  )
})

test_that("when there is a difference between new data and cached data, the new data is returned (cache=FALSE)", {
  suppressWarnings({
    b <- load_rde_var(FALSE, {iris}, modified_iris_3)
  })
  expect_true(all.equal(b, iris))
})

test_that("when new data produces error, cached data is returned", {
  b <- load_rde_var(FALSE, {stop("some error")}, expanded_iris)

  expect_equal(length(b), 5)
  expect_true(all.equal(b, expanded_iris))
})

test_that("when new data produces error, message is raised", {
  expect_message(
    load_rde_var(FALSE, {stop("some error")}, expanded_iris),
    "Error raised when loading new data"
  )
})

test_that("data load code can access variables from the calling environment", {
  mult <- 2
  b <- load_rde_var(
    FALSE,
    {
      a <- head(iris, 3)
      a$Sepal.Length <- a$Sepal.Length * mult
      a
    },
    scaled_iris_3
  )

  expect_equal(length(b), 5)
  expect_true(all.equal(b, scaled_iris_3))
})

test_that("expressions in load code don't affect enclosing environment variables", {
  mult <- 1
  b <- load_rde_var(
    FALSE,
    {
      mult <- mult * 2
      a <- head(iris, 3)
      a$Sepal.Length <- a$Sepal.Length * mult
      expect_equal(mult, 2)
      a
    },
    scaled_iris_3
  )

  expect_equal(mult, 1)
  expect_equal(length(b), 5)
  expect_true(all.equal(b, scaled_iris_3))
})
