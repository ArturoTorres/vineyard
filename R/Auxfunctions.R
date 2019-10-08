#' Raw data to xts object
#'
#' @param data the dataframe to convert to xts time series.
#' @param year.name the column name for the variable year.
#' @param month.name the column name for the variable month.
#' @param day.name the column name for the variable day.
#'
#' @return the xts object for the input dataframe.
#'
#' @importFrom "xts" "xts"
#'
#' @export raw2xts

raw2xts <- function(data, year.name, month.name, day.name){
  time <- paste(data[, year.name], data[,month.name], data[,day.name], sep = "-")
  time <- xts(x = data, order.by = as.POSIXct(time, format = "%Y-%m-%d"))
}


#' Find indexes for NA data in time series
#'
#' @param x the input time series as xts object.
#'
#' @return a vector with the index for NA data in the time series.
#'
#' @export id.na

id.na <- function(x){
  ids.na <- which(is.na(as.numeric(x)) == TRUE)
}

#' Plot NA data in time series
#'
#' @param x the input time series as xts object.
#' @param ids.na the vector which contains indexes for NA data as provided by the Id.na function.
#'
#' @return plots with the NAs highlighted.
#'
#' @importFrom "graphics" "abline" "par" "plot"
#' @export plot_na

plot_na <- function(x, ids.na){
  par(mfrow=c(5,2))
  dat.na <- lapply(ids.na, function(y){
    ifelse((y - 50) >= 0, idx.ini <- index(x)[y - 50], idx.ini <- index(x)[1])
    ifelse((y + 50) <= nrow(x), idx.end <- index(x)[y + 50], idx.end <- index(x)[nrow(x)])
    x.subset <- x[paste0(idx.ini, "/", idx.end)]
    x.time <- seq.POSIXt(idx.ini, idx.end, length.out = nrow(x.subset))
    plot(x.time, as.numeric(x.subset), typ="l", main = paste0("Index: ", y, " (", index(x)[y], ")"),
         ylab = colnames(x), xlab = "time")
    abline(v = index(x)[y], col = "red")
    abline(v = index(x)[y-1], col = "blue")
    abline(v = index(x)[y+1], col = "blue")
  })
}


#' Fill NA data in time series
#'
#' @param x the input time series as xts object.
#'
#' @return a time series with the NAs replaced by data according to the na.locf zoo function.
#'
#' @importFrom "zoo" "na.approx"
#'
#' @export fill.na


fill.na <- function(x){
  x.full <- na.approx(x)
}
