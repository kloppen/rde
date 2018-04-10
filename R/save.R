

#' Title
#'
#' @param var the variable that you want to copy
#' @param add.linebreaks indicates whether you want the output be be a single
#' line (FALSE) or you want linebreaks to be added to help with RStudio's
#' auto-indentation
#'
#' @return None
#' @export
#'
#' @importFrom clipr write_clip
#'
copy_rde_var <- function(var, add.linebreaks=TRUE) {
  on.exit({
    close(con)
  })

  con <- textConnection(NULL, open = "w+t")
  dput(var, file = con)
  txt <- textConnectionValue(con)
  txt <- paste(txt, collapse = " ")
  if (add.linebreaks) {
    txt <- break_parenthesis(txt)
  }
  clipr::write_clip(txt)
}


break_parenthesis <- function(code) {
  re <- "^([^()]*\\()(.*)$"
  if (grepl(re, code)) {
    # contains a parenthesis
    before <- sub(re, "\\1", code)
    # before also includes the opening parenthesis itself
    after <- sub(re, "\\2", code)
    processed_after <- break_parenthesis(after)
    return(paste(before, processed_after, sep = "\n"))
  } else {
    # no opening parenthesis found
    re <- "^([^)]*\\),?)(.*)$"
    if (grepl(re, code)) {
      # contains a closing parenthesis
      before <- sub(re, "\\1", code)
      # before also includes closing parenthesis and optional comma
      after <- sub(re, "\\2", code)
      processed_after <- break_parenthesis(after)
      return(paste(before, processed_after, sep = "\n"))
    } else {
      # does not contain a closing parenthesis
      return(code)
    }
  }
}


