

# a <- iris
#
# library(clipr)
#
# Sys.getenv("DISPLAY")
#
# con <- textConnection(NULL, open="w+t")
# dump("a", file=con, evaluate = TRUE)
# txt <- textConnectionValue(con)
# clipr::write_clip(txt)
# close(con)
#
# fcn <- function(x) {
#   x
# }


#' Title
#'
#' @param var
#'
#' @return
#' @export
#'
#' @importFrom clipr write_clip
#'
#' @examples
copy_rde_var <- function(var) {
  on.exit({
    close(con)
  })

  con <- textConnection(NULL, open = "w+t")
  dput(var, file = con)
  txt <- textConnectionValue(con)
  clipr::write_clip(txt)
}

# copy_rde_var(a)
