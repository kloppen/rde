

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
  if(useCache) {
    return(cache)
  }

  tryCatch(
    {
      loadFcnSub <- substitute(loadFcn)
      loadFcnResult <- eval(loadFcnSub, parent.env(environment()))

      if(!isTRUE(all.equal(cache, loadFcnResult))) {
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
      return(cache)
    }
  )
}


