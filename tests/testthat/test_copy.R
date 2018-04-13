# context("copy data")
#
#
# test_that("copied data.frame with no linebreaks produces correct code", {
#   code_txt <- copy_rde_var(iris, add.linebreaks = FALSE, no.clipboard = TRUE)
#   expect_type(code_txt, "character")
#   res <- eval(parse(text = code_txt))
#   expect_identical(iris, res)
#
#   expect_false(grepl("\\n", code_txt))
# })
#
# test_that("copied data.frame with linebreaks produces correct code", {
#   code_txt <- copy_rde_var(iris, add.linebreaks = TRUE, no.clipboard = TRUE)
#   expect_type(code_txt, "character")
#   res <- eval(parse(text = code_txt))
#   expect_identical(iris, res)
#
#   expect_true(grepl("\\n", code_txt))
# })
#
# test_atomic_vector <- function(vec, add.linebreaks) {
#   code_txt <- copy_rde_var(vec, add.linebreaks = add.linebreaks,
#                            no.clipboard = TRUE)
#   expect_type(code_txt, "character")
#   res <- eval(parse(text = code_txt))
#   expect_identical(vec, res)
# }
#
# test_that("copied atomic vector (character) produces correct code", {
#   test_atomic_vector("test vector", FALSE)
#   test_atomic_vector("test vector", TRUE)
# })
#
# test_that("copied atomic vector (integer) produces correct code", {
#   test_atomic_vector(44L, FALSE)
#   test_atomic_vector(44L, TRUE)
# })
#
# test_that("copied atomic vector (float) produces correct code", {
#   test_atomic_vector(1.1, FALSE)
#   test_atomic_vector(1.1, TRUE)
# })
#
# test_that("copied atomic vector (boolean) produces correct code", {
#   test_atomic_vector(TRUE, FALSE)
#   test_atomic_vector(TRUE, TRUE)
# })
#
# test_that("copied matrix (of floats) with linebreaks produces correct code", {
#   m <- matrix(2.0*(1:100), nrow = 20)
#   code_txt <- copy_rde_var(m, add.linebreaks = TRUE, no.clipboard = TRUE)
#   expect_type(code_txt, "character")
#   expect_true(grepl("\\n", code_txt))
#   res <- eval(parse(text = code_txt))
#   expect_identical(m, res)
# })
#
# test_that("copied matrix (of floats) with no linebreaks produces correct code", {
#   m <- matrix(2.0*(1:100), nrow = 20)
#   code_txt <- copy_rde_var(m, add.linebreaks = FALSE, no.clipboard = TRUE)
#   expect_type(code_txt, "character")
#   expect_false(grepl("\\n", code_txt))
#   res <- eval(parse(text = code_txt))
#   expect_identical(m, res)
# })
