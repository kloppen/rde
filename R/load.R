

#' Title
#'
#' @param useCache boolean to force the use of cached data
#' @param loadFcn code to load the data from its original source
#' @param cache code that acts as a cache for the data
#'
#' @return The data, either loaded using loadFcn, if possible, or from cache if that fails.
#' @export
#'
load_rde_var <- function(useCache = FALSE,
                         loadFcn,
                         cache) {
  cache_data <- decode_cache(cache)

  if(useCache) {
    return(cache_data)
  }

  tryCatch(
    {
      loadFcnSub <- substitute(loadFcn)
      loadFcnResult <- eval(loadFcnSub, environment())

      if(!isTRUE(all.equal(cache_data, loadFcnResult))) {
        warning("Cached data is different from loaded data")
      }

      return(loadFcnResult)
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
  on.exit({
    close(cache_data_con)
  })

  cache_no_whitespace <- gsub("[[:space:]]", "", cache)

  if (grepl("^rde1", cache_no_whitespace)) {
    cache_no_whitespace <- gsub("^rde1", "", cache_no_whitespace)
    cache_data_compressed <- base64_decode(cache_no_whitespace)
    cache_data_uncompressed <- memDecompress(cache_data_compressed, type = "bzip2", asChar = FALSE)
    cache_data_con <- file(open="w+b")
    writeBin(cache_data_uncompressed, cache_data_con)
    cache_data <- readRDS(cache_data_con)
  } else {
    stop("Unrecognized version number in cache text. Did the cache text come directly
         from copy_rde_var()?")
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
    if(substr(ch, 1, 1) != padding) {
      c0 <- which(b64 == substr(ch, 1, 1)) - 1
      r[1] <- bitwShiftL(c0, 2)
    }
    if(substr(ch, 2, 2) != padding) {
      c1 <- which(b64 == substr(ch, 2, 2)) - 1
      r[1] <- r[1] + bitwShiftR(c1, 4)
      r[2] <- bitwShiftL(bitwAnd(c1, 0x0F), 4)
    }
    if(substr(ch, 3, 3) != padding) {
      c2 <- which(b64 == substr(ch, 3, 3)) - 1
      r[2] <- r[2] + bitwShiftR(c2, 2)
      r[3] <- bitwShiftL(bitwAnd(c2, 0x03), 6)
    }
    if(substr(ch, 4, 4) != padding) {
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


