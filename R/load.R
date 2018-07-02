

#' Load data in a reproducible way that allows for exchange of code
#'
#' @description
#' \code{load_rde_var} attempts to execute the code in \code{load.fcn}. If
#' that succeeds, then the return value of that code is returned by
#' \code{load_rde_var}. Otherwise, the value stored in \code{cache} is
#' returned. \code{cache} must contain an encoded copy of the value produced
#' by the function \code{\link{copy_rde_var}}. Optionally, you can force
#' the use of the cached data by setting \code{use.cache = TRUE}.
#'
#' @param use.cache boolean to force the use of cached data
#' @param load.fcn code to load the data from its original source
#' @param cache a cached copy of the data
#'
#'
#' @return The data, either loaded using load.fcn, if possible, or from cache
#' if that fails.
#'
#' @details
#' This package is intended for small datasets. A copy of the data is encoded
#' as a string (using base64 encoding, after compressing the data) and that
#' string is copied into your code. Even though the data is compressed, the
#' encoded string can still be quite long. If your data is more than a few
#' hundred observations, this package probably isn't for you.
#'
#' \code{load.fcn} must contain executable R code. Unless that code is a
#' single expression, normally it would be enclosed in a pair of braces.
#'
#' \code{cache} must be a string that was originally produced by
#' \code{\link{copy_rde_var}}. See the documentation for that function for
#' more details about the format of this string.
#'
#' If the code in \code{load.fcn} fails, then a message is produced to
#' indicate that the failure and the data encoded in \code{cache} is returned
#' instead. This would occur if you share you code with someone who does
#' not have access to the data that you're loading in your code.
#'
#' If \code{use.cache = TRUE}, the code in \code{load.fcn} is ignored and
#' the data is loaded from the encoded string \code{cache}. This can be useful
#' if it takes a very long time obtain the data and you re-run your code
#' often.
#'
#' If the value produced by the code in \code{load.fcn} does not match the
#' value encoded in \code{cache}, then a warning is produced to indicate
#' that there is a mismatch.
#'
#' @examples
#' load_rde_var(use.cache = FALSE, {
#'     head(iris, 3)
#'   }, "
#'   rde1QlpoOTFBWSZTWbGO254AAKT/5P//XAAAAQAAwARIwC/n3YBAAAAwACYFAbAA7IhKIm
#'   lPaU3oaRqekyaDTQNPJP1MhDAaA0AAGmg0A0AaBIokNGgAAAAAANMYUzuJyxRYUJWNnsC1
#'   tgiccpLFvZTHhARK1KFQ1z25bNBCC+0pWKgEnGEzpxVaihSiTBL2j6RRFchjamGBFpBMwN
#'   bAHwgEGosCEGYBoztHPFUVjGcDz3qu9p4cb8rVyVfHmR5S3bWXfDDnTnyJDJh0iMIpionY
#'   lfq1FwK/IvzsuBsOmuZNGtpp7oWrW4upNNGDiL2E9T6iY2RFqabO9/r9oiN6p/YIdV1FPP
#'   ISLqVP4u5IpwoSFjHbc8A=
#'   ")
#'
#' @seealso \link{copy_rde_var}
#'
#' @export
load_rde_var <- function(use.cache = FALSE,
                         load.fcn,
                         cache) {
  cache_data <- decode_cache(cache)

  if (use.cache) {
    return(cache_data)
  }

  tryCatch({
      load_fcn_sub <- substitute(load.fcn)
      load_fcn_result <- eval(load_fcn_sub, environment())

      if (!isTRUE(all.equal(cache_data, load_fcn_result))) {
        warning("Cached data is different from loaded data")
      }

      return(load_fcn_result)
    },
    error = function(e) {
      message(paste(
        "Error raised when loading new data, using cahced data instead.",
        e,
        sep = "\n"
      ))
      return(cache_data)
    }
  )
}

decode_cache <- function(cache) {
  if (typeof(cache) != "character" || length(cache) == 0 || nchar(cache) == 0) {
    message("Cache is empty or not a string")
    return(NULL)
  }

  on.exit({
    close(cache_data_con)
  })

  cache_no_whitespace <- gsub("[[:space:]]", "", cache)

  if (grepl("^rde1", cache_no_whitespace)) {
    cache_no_whitespace <- gsub("^rde1", "", cache_no_whitespace)
    cache_data_compressed <- base64_decode(cache_no_whitespace)
    cache_data_uncompressed <- memDecompress(cache_data_compressed,
                                             type = "bzip2", asChar = FALSE)
    cache_data_con <- file(open = "w+b")
    writeBin(cache_data_uncompressed, cache_data_con)
    cache_data <- readRDS(cache_data_con)
  } else {
    stop("Unrecognized version number in cache text. Did the cache text come
          directly from copy_rde_var()?")
  }

  return(cache_data)
}

base64_decode <- function(txt) {
  b64 <- c(LETTERS, letters, 0:9, "+", "/")
  padding <- "="

  ss <- strsplit(txt, "")[[1]]
  chunks <- paste0(ss[c(TRUE, FALSE, FALSE, FALSE)],
                   ss[c(FALSE, TRUE, FALSE, FALSE)],
                   ss[c(FALSE, FALSE, TRUE, FALSE)],
                   ss[c(FALSE, FALSE, FALSE, TRUE)])
  res <- do.call(c, lapply(chunks, function(ch) {
    r <- integer(3)
    if (substr(ch, 1, 1) != padding) {
      c0 <- which(b64 == substr(ch, 1, 1)) - 1
      r[1] <- bitwShiftL(c0, 2)
    }
    if (substr(ch, 2, 2) != padding) {
      c1 <- which(b64 == substr(ch, 2, 2)) - 1
      r[1] <- r[1] + bitwShiftR(c1, 4)
      r[2] <- bitwShiftL(bitwAnd(c1, 0x0F), 4)
    }
    if (substr(ch, 3, 3) != padding) {
      c2 <- which(b64 == substr(ch, 3, 3)) - 1
      r[2] <- r[2] + bitwShiftR(c2, 2)
      r[3] <- bitwShiftL(bitwAnd(c2, 0x03), 6)
    }
    if (substr(ch, 4, 4) != padding) {
      c3 <- which(b64 == substr(ch, 4, 4)) - 1
      r[3] <- r[3] + c3
    }
    return(c(
      as.raw(r[1]),
      as.raw(r[2]),
      as.raw(r[3])
    ))
  }))
  return(res)
}
