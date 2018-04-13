context("load data")

# the full iris dataset
base64_iris <- "
QlpoOTFBWSZTWTZfsaQABq9/7/////+AAQgAwARIwC/33YBAAAEwACAAJgggSABtbdAEuQgFUAbDJQkR
IphTyYpp6j1DZE0AANqepoeU9R6T00EMnqEU/Ko0BoAANAGgAAAAA0AAkypSoNAABoAAADEBoADQyAcA
wjCaYhgEAyAGEaZMmEYCGhwDCMJpiGAQDIAYRpkyYRgIafr2w7TkRcpkTPeHfvPD5jioioVC+O7ieTdO
SnJboeX0RlfO6s8TpujlhLfmZiankmjZVQ8qVn8XkAr5bY4hALu4AQBineQCrdEt+YxCWevVinay1jD7
5dVsASVppAtjAy7b9vPUCQGRoEkWGg7gV/aLjtSr9YlYEmhGITSEmLWkgDnQkKgUECzxBlGmV45VCclK
szMik1VEDUtBKwrK4ZWFklkamptoFJFmKSRIasKxVhqCSiRGlFFViJaF0ooo5ihBYhWKBkVRHLFNRTQt
VRTZSSGIEtDC2mVJssPdhnYN4LiM7Ox3VsHg8xYcCmyJhTYEAcb6qAUMiAjQ5gItMgQMGkIliAFpC5zW
0kIDtbfz28f7lepDvjBV+RE6ySp1kR9henIzMzZqSoKU+dckpjbY5I5JPOgxNetkNDaFy5yZQVU3roo1
KqLhQZYnkRwcSAzClMKKTodCClEPhJPJTioc4rDxOcrnDcyUQjtxwKNTlF2FDjJwQhJKKQWRWKZFzQWp
ZwT0eDh4LYGhc1JoERCRQkloJGiVJNMriSZaldytxqEdINLhV0o5liRQaAWZBRhYFJUcrRKTtMudKEIA
hJIUCFAQFDoTE+AftEY3VGaAZAq9Uncultg+PLBz2unWbCKFWwv3L6Qkv0xISWjsSwtLwuGEIgIcbrr5
HEwpmBzCmIczJMEPUaCjsTppJZa5qoZq1OdykKSkNw4hQOw55WoriODHjMgPe6Dh6fBy8AUw9XFRXOKT
JuXcbvVHDaMljXUYLMFd2zdKHkwDu8PR7/qen2cffjGDfF2zuPcco0E7NIqC7+/9RJP2Q4nV4p4E6ggm
X+CF+q7MpngcKM8ksmYzzdo4iKUh9bqbqhRotpIA7BAdCSARt2pNgsKhNto6jrJilKSx6YOOIexC3A4S
dh6/W4PXpV5yFvm5z5no9J5YcXkJCvCADdGl4uMn/i7kinChIGy/Y0gA"

# the first three rows of iris, but with the first element changed
# a <- iris
# a$Sepal.Length[1] <- 5000
base64_modified_iris_3 <- "
QlpoOTFBWSZTWdsanVkABrD/7/////+AAQgAwARIwC/33YBAQAEwCCAAJgggSABtbdAEuR7Ai0AWnrpc
JCSmqeTUaPSNBoemoDIADT0htE2UaNqBoeocaMmRhGIBhNBgE0GgZMmjJkMIDCU8pSqGmQAaDTI0NAYQ
bQhiDQM1DQ0DVTR6QyZqGgDQ000NAAaADQaAGQwIkpJGJtRtJoYCYCGRgAAjCemgmCHe/fxhyuIi4piJ
jzDznfS3DVRFQqF9ZzU59xspstwezwjK+50J1OM4cWEmOqqVeeSrNl6xuJYOPEgFsGFj2KpALr0CANqt
lAK52Sx1NoSzXaNqtTNbbDi3tGFAJLWaQLlYG9qxYc15CQG20CSL7QbIXcE6D1qWK4SvxYiY4wFYN1UA
7UUbQWhB5ao3RTFdcVQnEpVmZkUmqogaloJWFZXBlYWSWRqamzIFJFmKSRIasFYqwagkokRpRRVYiWhc
lFFHGKHCIVigZFURxYpqKaFqqKbFJIYgSyGFsmpIVKZKJ6gYoNuJQxYpfUoW7EpIhILCCSChACI8dUBI
DCAQiSygrBhQhAiiWRAB/QW+v2KiBy5n8+PDyYr5sOfSCr9SJ2UlTsoj1F42MrMuW1KFrb91FJjbY6J7
6N1B2GvKyNDaFxccTFBVTPhRRqVUXBQZYnYjRwkBmFKYUUnIchBSiH0EnZTVQ3VYdTdrdM3EohHM1wFG
pxRcwUNZNEISSikFkVimRcaCylnAnh0cHRbAaFxqTIERCRQkloJGiVJD3nXVcJJlqVxcmoRyQaXBVyUc
ZYkUGgFmQUYWBSVHFaJScyZccmRjZJI0yDjaluA3uk3io8Ofc0956W93lO5yfbz/StLco7MHuul4q0X1
4uW7giv7gIry+i/GLlyoERAjnRd2+5UVVB1FUjqqKhHnMxZ364rUYGfW9GZ87rnWiotG45FB33WhqXSZ
MeM2wcvyFfSfOqASb7WJARWhBSIWoZINCp4Ui9DQkdBEMpxQQWEg9ejHhwZPzwozoQgXq/ZzPmabHIEa
TkY2wXP88iJJyIanQ1Tz5yggmXlIX7rvRszQcUzUUyqmatezklrR/x3m70U4cKSAOT+iA0pIBGrUk2C6
yibbR+DmKlrWpj44clPbhbQ0k7b2uTR7VKu7C3c3e48PE2Ukq4ijhiAHuIujuln/F3JFOFCQ2xqdWQAA
"

# The first three rows from iris, but with Sepal.Length doubled
# a <- head(iris, 3)
# a$Sepal.Length <- a$Sepal.Length * 2
base64_scaled_iris_3 <- "
QlpoOTFBWSZTWTV4+F0AAKT/5P//SAAcAQAAwARIwC/n3YBAAAAwACYFAbAA7ICUQSnim9DSNT0IBo9Q
NoNMjUMaGhoAMhoAAAAAJFFNGjQAAAAAAA4wnkeSFSiwlSkbJUEW1CJvxwWLc1ON0BEpUlVDV+sy15EI
LrSlYpAncITOjFVJ6FKJMEvSPhFEVxGNqYYEWkEzA1MAe+AQaiwHBcA0ZVj5hVFYxlx6blXc08N9uNa4
quzoR5Yefiyy5h0ny5GAxw/AjCKcFEzMLdWosBZsS3KqwGw663Jo1tNPdCtaXlk5plveRmYSUTUDjbEW
hpt75vb8REb2Treh2S8TPNw5Lyf/F3JFOFCQNXj4XQAA"

test_that("cached data loaded as expected", {
  b <- load_rde_var(TRUE, {iris}, base64_iris)

  expect_equal(length(b), 5)
  expect_true(all.equal(b, iris))
})

test_that("new data loaded as expected", {
  b <- load_rde_var(FALSE, {iris}, base64_iris)

  expect_equal(length(b), 5)
  expect_true(all.equal(b, iris))
})

test_that("new data with multiple lines", {
  b <- load_rde_var(
    FALSE,
    {
      a <- head(iris, 3)
      a$Sepal.Length <- a$Sepal.Length * 2
      a
    },
    base64_scaled_iris_3
  )

  expect_equal(length(b), 5)
  expect_true(all.equal(b$Sepal.Length, head(iris, 3)$Sepal.Length * 2))
  expect_true(all.equal(b$Species, head(iris, 3)$Species))
})

test_that("difference between new data and cahced data causes warning", {
  expect_warning(
    load_rde_var(FALSE, {iris}, base64_modified_iris_3)
  )
})

test_that("when there is a difference between new data and cached data, the new data is returned (cache=FALSE)", {
  suppressWarnings({
    b <- load_rde_var(FALSE, {iris}, base64_modified_iris_3)
  })
  expect_true(all.equal(b, iris))
})

test_that("when new data produces error, cached data is returned", {
  b <- load_rde_var(FALSE, {stop("some error")}, base64_iris)

  expect_equal(length(b), 5)
  expect_true(all.equal(b, iris))
})

test_that("when new data produces error, message is raised", {
  expect_message(
    load_rde_var(FALSE, {stop("some error")}, base64_iris),
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
    base64_scaled_iris_3
  )

  expect_equal(length(b), 5)
  expect_true(all.equal(b$Sepal.Length, head(iris, 3)$Sepal.Length * 2))
  expect_true(all.equal(b$Species, head(iris, 3)$Species))
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
    base64_scaled_iris_3
  )

  expect_equal(mult, 1)
  expect_equal(length(b), 5)
  expect_true(all.equal(b$Sepal.Length, head(iris, 3)$Sepal.Length * 2))
  expect_true(all.equal(b$Species, head(iris, 3)$Species))
})
