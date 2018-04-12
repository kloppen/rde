

#' Title
#'
#' @param var the variable that you want to copy
#' @param add.linebreaks indicates whether you want the output be be a single
#' line (FALSE) or you want linebreaks to be added to help with RStudio's
#' auto-indentation
#' @param no.clipboard the default is FALSE. Indicates that you want the
#' function to return the string that would have been copied to the clipboard
#' without actually copying to the clipboard. This option is mainly used
#' for testing purposes. Normal users will not use it.
#'
#' @return None (or string if no.clipboard=TRUE)
#' @export
#'
#' @importFrom clipr write_clip
#'
copy_rde_var <- function(var, add.linebreaks=TRUE, no.clipboard=FALSE) {
  on.exit({
    close(con)
  })

  con <- file(open="w+b")
  saveRDS(var, file = con)

  txt <- base64_encode(con)

  # TODO: Add linebreaks
  # TODO: Maybe add compression?

  if (no.clipboard) {
    return(txt)
  }
  clipr::write_clip(txt)
}

base64_encode <- function(con) {
  b64 <- c(LETTERS, letters, 0:9, "+", "/")
  padding <- "="

  b64data <- character(0)

  while (TRUE) {
    r0 <- readBin(con = con, what = "raw")
    r1 <- readBin(con = con, what = "raw")
    r2 <- readBin(con = con, what = "raw")
    if(length(r0) == 0 && length(r1) == 0 && length(r2) == 0) {
      break()
    }
    else if(length(r1) == 0 && length(r2) == 0) {
      num <- as.integer(r0) * 2^16
      c0 <- bitwShiftR(bitwAnd(num, 0xFC0000), 18)
      c1 <- bitwShiftR(bitwAnd(num, 0x3F000), 12)
      b64data <- c(b64data, b64[c0 + 1], b64[c1 + 1], "=", "=")
    }
    else if(length(r2) == 0) {
      num <- as.integer(r0) * 2^16 + as.integer(r1) * 2^8
      c0 <- bitwShiftR(bitwAnd(num, 0xFC0000), 18)
      c1 <- bitwShiftR(bitwAnd(num, 0x3F000), 12)
      c2 <- bitwShiftR(bitwAnd(num, 0xFC0), 6)
      b64data <- c(b64data, b64[c0 + 1], b64[c1 + 1], b64[c2 + 1], "=")
    } else {
      num <- as.integer(r0) * 2^16 + as.integer(r1) * 2^8 + as.integer(r2)
      c0 <- bitwShiftR(bitwAnd(num, 0xFC0000), 18)
      c1 <- bitwShiftR(bitwAnd(num, 0x3F000), 12)
      c2 <- bitwShiftR(bitwAnd(num, 0xFC0), 6)
      c3 <- bitwShiftR(bitwAnd(num, 0x3F), 0)
      b64data <- c(b64data, b64[c0 + 1], b64[c1 + 1], b64[c2 + 1], b64[c3 + 1])
    }
  }

  b64data <- paste0(b64data, collapse = "")
  return(b64data)
}

