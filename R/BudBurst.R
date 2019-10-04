#' Degree days by the single triangle algorithm
#'
#' Implementation to compute the degree days by the single triangle algorithm by Nendel (2010).
#'
#' @param t.min daily minimum air temperature vector in Celsius degrees.
#' @param t.max daily maximum air temperature vector in Celsius degrees.
#' @param t.zero numeric, threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree-days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @export dd.single.triangle
#'
#' @references Nendel, Class (2010). Grapevine bud break prediction for cool winter climates. Int. J. Biometeorol., 54, 231–241.

dd.single.triangle <- function(t.zero, t.min, t.mean, t.max){
  if(t.zero >= t.max){
    dd <- 0
  } else if((t.zero > t.min) && (t.zero < t.max)){
    dd <- ((t.max - t.zero)/2)*((t.max - t.zero)/(t.max - t.min))
  }else if(t.zero <= t.min){
    dd <- t.mean - t.zero
  }

  return(dd)
}

#' Cumulative degree days (CDD) by the single triangle algorithm
#'
#' Implementation to compute the cumulative degree days by the single triangle algorithm by Nendel (2010).
#'
#' @param data input data in xts format.
#' @param t.zero numeric, threshold temperature (in Celsius degrees) for vine growth.
#' @param t.min.col numeric, column position in data for the daily minimum air temperature vector in Celsius degrees.
#' @param t.mean.col numeric, column position in data for the daily mean air temperature vector in Celsius degrees.
#' @param t.max.col numeric, column position in data for the daily maximum air temperature vector in Celsius degrees.
#' @param start.date numeric, calculated optimum starting date in day of year.
#'
#' @return list per year for the input data plus an additional column with the cumulative degree days
#' (in Celsius degrees) for vine growth. The output for each year is a "xts" time series object.
#'
#' @importFrom xts xts
#'
#' @export cdd.single.triangle
#'
#' @references Nendel, Class (2010). Grapevine bud break prediction for cool winter climates.
#' Int. J. Biometeorol., 54, 231–241.

cdd.single.triangle <- function(data, t.zero, t.min.col, t.mean.col, t.max.col){
  gdd <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- dd.single.triangle(t.zero = t.zero, t.min = as.numeric(y[t.min.col]),
                             t.mean = as.numeric(y[t.mean.col]),
                             t.max = as.numeric(y[t.max.col]))
  })
  }
  )

  cdd <- mapply(FUN = function(x, gdd) as.xts(cbind(x, cdd_st=cumsum(gdd))), x = data, gdd = gdd)

  return(cdd)
}


#' Cumulative degree days (CDD) by the single triangle algorithm for bud break
#'
#' Implementation to compute the cumulative degree days by the single triangle algorithm by Nendel (2010)
#' for bud break.
#'
#' @param cdd cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
#' "DD.single.triangle.cumulative" function.
#' @param start.date numeric, calculated optimum starting date in day of year.
#'
#' @return the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
#' the comulative degree days (in Celsius degrees) for bud break.
#'
#' @importFrom xts xts
#'
#' @export cdd.single.triangle.budbreak
#'
#' @references Nendel, Class (2010). Grapevine bud break prediction for cool winter climates.
#' Int. J. Biometeorol., 54, 231–241.

cdd.single.triangle.budbreak <- function(cdd, start.date){
  idx <- lapply(cdd, FUN = function(x){
    idx <- index(x)[start.date]
    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.bb <- as.numeric(coredata(subset[,"cdd_st"])) - rep(as.numeric(coredata(subset[1,"cdd_st"])), nrow(subset))
    subset[,"cdd_st"] <- cdd.bb
    colnames(subset[,"cdd_st"]) <- "cdd.bb"

    return(subset)
    })
}

