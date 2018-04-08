

#' Title
#'
#' @param var the variable that you want to copy
#'
#' @return None
#' @export
#'
#' @importFrom clipr write_clip
#'
copy_rde_var <- function(var) {
  on.exit({
    close(con)
  })

  con <- textConnection(NULL, open = "w+t")
  dput(var, file = con)
  txt <- textConnectionValue(con)
  clipr::write_clip(txt)
}
