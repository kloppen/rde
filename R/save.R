

#' Title
#'
#' @param var the variable that you want to copy
#' @param line.width adds a new line every line.width characters (-1 for no
#' linebreaks)
#' @param no.clipboard the default is FALSE. Indicates that you want the
#' function to return the string that would have been copied to the clipboard
#' without actually copying to the clipboard. This option is mainly used
#' for testing purposes. Normal users will not use it.
#' @param max_size the maximum size of the object, before compression. In
#' most cases, you should be able to keep the default of about 8 MB, but for
#' very large data, you might need to increase this.
#'
#' @return None (or string if no.clipboard=TRUE)
#' @export
#'
#' @importFrom clipr write_clip
#'
copy_rde_var <- function(var, line.width=80L, no.clipboard=FALSE, max_size=8000000L) {
  on.exit({
    close(con)
  })

  con <- file(open="w+b")
  saveRDS(var, file = con)
  bin_data <- readBin(con = con, what = "raw", n = max_size)
  bin_data <- memCompress(bin_data, type = "bzip2")

  txt <- base64_encode(bin_data)

  if (line.width > 0) {
    txt <- gsub(
      paste0("(.{", line.width, "})")
      , "\\1\n", txt
    )
  }

  if (no.clipboard) {
    return(txt)
  }
  clipr::write_clip(txt)
}

base64_encode <- function(bin_data) {
  b64 <- c(LETTERS, letters, 0:9, "+", "/")
  padding <- "="

  b64data <- character(0)

  for (i in 1:ceiling(length(bin_data) / 3)) {
    r0 <- if ((i - 1) * 3 + 0 <= length(bin_data)) bin_data[(i - 1) * 3 + 1] else 0L
    r1 <- if ((i - 1) * 3 + 1 <= length(bin_data)) bin_data[(i - 1) * 3 + 2] else 0L
    r2 <- if ((i - 1) * 3 + 2 <= length(bin_data)) bin_data[(i - 1) * 3 + 3] else 0L
    if(length(r0) == 0 && length(r1) == 0 && length(r2) == 0) {
      break()  # should never get here
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

