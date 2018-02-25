
a <- iris

# process_column <- function(colData) {
#   if (is.integer(colData) || is.double(colData)) {
#     return(
#       paste0("c(",
#              paste0(colData, collapse = ","),
#              ")")
#     )
#   } else if (is.factor(colData)) {
#     lev <- levels(colData)
#     lev_text <- paste0(
#       sapply(levels(colData), function (s) {
#         paste0("\"", s, "\"")
#       }),
#       collapse = ","
#     )
#     return(
#       paste0("factor(c(",
#              paste0(
#                sapply(colData, function (s) {
#                  paste0("\"", s, "\"")
#                }),
#                collapse = ","),
#              "),levels=c(",
#              lev_text,
#              "))")
#     )
#   } else if (is.character(colData)) {
#     return(
#       paste0("c(",
#              paste0(
#                sapply(colData, function (s) {
#                  paste0("\"", s, "\"")
#                }),
#                collapse = ","),
#              ")")
#     )
#   } else {
#     error(paste0("Variable ", colName, " is of unsuported type."))
#   }
# }
#
# # TODO: Should check that input is a data.frame
#
# res <- paste0(
#   "data.frame(",
#   paste0(
#     lapply(names(a), function(colName) {
#       colData <- a[[colName]]
#       return(
#         paste0(
#           colName,
#           "=",
#           process_column(colData)
#         )
#       )
#     }),
#     collapse = ","
#   ),
#   ")"
# )
#
# cat(res)
#
# str(a[["Species"]])
# class(a[["Species"]])
#
#
# # from: https://gist.github.com/kprybol/045264c16c3bde8f7179
# cb <- function(df, sep="\t", dec=",", max.size=(200*1000)){
#   # Copy a data.frame to clipboard
#   write.table(df, paste0("clipboard-", formatC(max.size, format="f", digits=0)), sep=sep, row.names=FALSE, dec=dec)
# }
#
#
# cb(a)


#####

a <- iris

library(clipr)

con <- textConnection(NULL, open="w+t")
dump("a", file=con, evaluate = TRUE)
txt <- textConnectionValue(con)
clipr::write_clip(txt)
close(con)

fcn <- function(x) {
  x
}



f <- function(x) {
  a <- substitute(x)
  eval(a, envir = parent.env(environment()))
}
f(1:10)

f({
  a <- "hello1"
})


