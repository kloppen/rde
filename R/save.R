

#' Encode, compress and copy data into the clipboard
#'
#' @description
#' \code{copy_rde_var} is intended to work with \code{\link{load_rde_var}}.
#' The normal workflow would use \code{copy_rde_var} to copy a variable to
#' the clipboard and then paste it in to the third argument of \code{load_rde_var}.
#'
#' @param var the variable to copy
#' @param line.width the desired width of lines of text (-1 for no
#' line breaks)
#' @param no.clipboard the default is FALSE. Indicates that you want the
#' function to return the string that would have been copied to the clipboard
#' without actually copying to the clipboard. This option is mainly used
#' for testing purposes. Normal users will not use it.
#'
#' @return None (or string if no.clipboard=TRUE)
#'
#' @details
#' The variable in the argument \code{var} is first saved using
#' \code{\link{saveRDS}}. Then the saved variable is compressed using
#' bzip2 compression. Next, the compressed data is base 64 encoded into
#' a character string. Next, that string is prepended with a code that
#' indicates the version of this package. The prepended code (currently
#' `rde1` allows for future changes while providing backwards compatibility).
#' Finally, the string is optionally broken up into lines of width
#' \code{line.width}. Whitespace and line breaks are ignored by
#' \code{\link{load_rde_var}}.
#'
#' On X11 systems (e.g. Linux), external software is required in order to
#' access the clipboard. Either `xsel` or `xclip` is required. Installation
#' of this software will depend on the installation that you use, but on
#' Ubuntu/Debian, `sudo apt-get install xsel` will probably work.
#'
#' On Windows and OSX, no additional software is required.
#'
#' @examples
#' \donttest{
#' copy_rde_var(iris)
#' }
#'
#' @export
#' @importFrom clipr write_clip
#'
copy_rde_var <- function(var, line.width=80L, no.clipboard=FALSE) {
  on.exit({
    close(con)
  })

  max_size <- 800000L

  con <- file(open = "w+b")
  saveRDS(var, file = con)

  bin_data <- raw(0)

  repeat {
    new_data <- readBin(con = con, what = "raw", n = max_size)
    if (all(new_data == as.raw(0L))) {
      break
    }
    bin_data <- c(bin_data, new_data)
  }

  bin_data <- memCompress(bin_data, type = "bzip2")

  txt <- base64_encode(bin_data)

  txt <- paste0("rde1", txt)

  if (line.width > 0) {
    txt <- gsub(
      paste0("(.{", line.width, "})")
      , "\\1\n", txt
    )
  }

  if (no.clipboard) {
    return(txt)
  }
  clipr::write_clip(txt, object_type = "character", breaks = NULL, eos = NULL,
                    return_new = TRUE)
}

base64_encode <- function(bin_data) {
  b64 <- c(LETTERS, letters, 0:9, "+", "/")
  padding <- "="

  b64data <- character(0)

  for (i in 0:(ceiling(length(bin_data) / 3) - 1)) {
    r0 <- if (i * 3 + 0 < length(bin_data)) bin_data[i * 3 + 1] else raw(0)
    r1 <- if (i * 3 + 1 < length(bin_data)) bin_data[i * 3 + 2] else raw(0)
    r2 <- if (i * 3 + 2 < length(bin_data)) bin_data[i * 3 + 3] else raw(0)
    if (length(r0) == 0 && length(r1) == 0 && length(r2) == 0) {
      break  # should never get here
    }
    else if (length(r1) == 0 && length(r2) == 0) {
      num <- as.integer(r0) * 2 ^ 16
      c0 <- bitwShiftR(bitwAnd(num, 0xFC0000), 18)
      c1 <- bitwShiftR(bitwAnd(num, 0x3F000), 12)
      b64data <- c(b64data, b64[c0 + 1], b64[c1 + 1], padding, padding)
    }
    else if (length(r2) == 0) {
      num <- as.integer(r0) * 2 ^ 16 + as.integer(r1) * 2 ^ 8
      c0 <- bitwShiftR(bitwAnd(num, 0xFC0000), 18)
      c1 <- bitwShiftR(bitwAnd(num, 0x3F000), 12)
      c2 <- bitwShiftR(bitwAnd(num, 0xFC0), 6)
      b64data <- c(b64data, b64[c0 + 1], b64[c1 + 1], b64[c2 + 1], padding)
    } else {
      num <- as.integer(r0) * 2 ^ 16 + as.integer(r1) * 2 ^ 8 + as.integer(r2)
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
