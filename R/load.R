

load_rde_var <- function(useCache = FALSE,
                         loadFcn,
                         cache) {
  if(useCache) {
    return(cache)
  }

  loadFcnSub <- substitute(loadFcn)
  loadFcnResult <- eval(loadFcnSub, parent.env(environment()))

  if(!isTRUE(all.equal(cache, loadFcnResult))) {
    warning("Cached data is different from loaded data")
  }

  return(loadFcnResult)
}


