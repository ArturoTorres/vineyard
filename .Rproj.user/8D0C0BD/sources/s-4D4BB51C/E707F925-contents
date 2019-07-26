#' Raw data to xts object
#'
#' @param t.min daily minimum air temperature
#' @param t.max daily maximum air temperature
#' @param t.zero threshold temperature for vine growth
#'
#' @return a vector with the degree-days for vine growth
#'
#' @importFrom xts xts

Raw2xts <- function(data){
  time <- paste(data$Jahr, data$Monat, data$Tag, sep = "-")
  time <- xts(x = data, order.by = as.POSIXct(time, format = "%Y-%m-%d"))
}


#' Find indexes for NA data in time series
#'
#' @param x the input time series as xts object
#'
#' @return a vector with the index for NAs data in the time series

Id.na <- function(x){
  ids.na <- which(is.na(as.numeric(x)) == TRUE)
}

#' Plot NA data in time series
#'
#' @param x the input time series as xts object
#'
#' @return plots with the NAs highlighted

plot.na <- function(x, ids.na){
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
#' @param x the input time series as xts object
#'
#' @return a time series with the NAs replaced by data according to the na.locf zoo function
#'
#' @importFrom zoo na.locf


FillNA <- function(x){
  x.full <- na.approx(x)
}

