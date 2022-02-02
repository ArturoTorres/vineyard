#' Linear regression model applied for predicting yield for Riesling
#'
#' @param stat.tmin1.ries numeric, vector with two columns: 1) year, and 2) first statistic for min temperature.
#' @param stat.tmin01.ries numeric, vector with two columns: 1) year, and 2) second statistic for min temperature.
#' @param stat.tmin02.ries numeric, vector with two columns: 1) year, and 2) third statistic for min temperature.
#' @param stat.rain0.ries numeric, vector with two columns: 1) year, and 2) first statistic for precipitation.
#' @param stat.rain1.ries numeric, vector with two columns: 1) year, and 2) second statistic for precipitation.
#' @param model the predefined model e.g. linear regression (lm). Should be a match between the linear
#' regression coefficients and each statistic in the same definition order.
#'
#' @return  data.frame, n obs. of 4 variables (year, predicted yield for Riesling), and lower and upper values
#' represent the uncertainty band with 95 percent confidence level. n is the total number of years for prediction.
#'
#' @export lm.yield.applied.riesling

lm.yield.applied.riesling <- function(stat.rain0.ries, stat.tmin1.ries, stat.tmin01.ries,
                                      stat.rain1.ries, stat.tmin02.ries, model){

  stats <- cbind.data.frame(year   = stat.rain0.ries[2:nrow(stat.rain0.ries),1],
                            a = stat.rain0.ries[2:nrow(stat.rain0.ries),2],
                            b = stat.tmin1.ries[1:(nrow(stat.tmin1.ries)-1),2],
                            c = stat.tmin01.ries[2:nrow(stat.tmin01.ries),2],
                            d = stat.rain1.ries[1:(nrow(stat.rain1.ries)-1),2],
                            e = stat.tmin02.ries[2:nrow(stat.tmin02.ries),2]
                            )

  My.yield.riesling <- function(vars, model){
    yield <- predict(object = model, newdata = vars, interval = "confidence")

    yield <- cbind.data.frame(year = vars[,1], yield = yield)

    return(yield)
  }

  yield.riesling <- cbind.data.frame(My.yield.riesling(vars = stats, model = model))

  return(yield.riesling)
}


#' Linear regression model applied for predicting yield for Rivaner
#'
#' @param stat.tmin1 numeric, vector with two columns: 1) year, and 2) first statistic for min temperature.
#' @param stat.tmean1 numeric, vector with two columns: 1) year, and 2) first statistic for mean temperature.
#' @param stat.tmax1 numeric, vector with two columns: 1) year, and 2) first statistic for max temperature.
#' @param stat.tmean0 numeric, vector with two columns: 1) year, and 2) second statistic for mean temperature.
#' @param stat.rain01 numeric, vector with two columns: 1) year, and 2) first statistic for precipitation.
#' @param stat.rain02 numeric, vector with two columns: 1) year, and 2) second statistic for precipitation.
#' @param stat.tmin0 numeric, vector with two columns: 1) year, and 2) second statistic for min temperature.
#' @param model the predefined model e.g. linear regression (lm). Should be a match between the linear
#' regression coefficients and each statistic in the same definition order.
#'
#' @return  data.frame, n obs. of 4 variables (year, predicted yield for Rivaner), and lower and upper values
#' represent the uncertainty band with 95 percent confidence level. n is the total number of years for prediction.
#'
#' @export lm.yield.applied.rivaner

lm.yield.applied.rivaner <- function(stat.tmin1, stat.tmean1, stat.tmax1, stat.tmean0, stat.rain01, stat.rain02, stat.tmin0, model){

  stats <- cbind.data.frame(year   = stat.tmean0[,1],
                            a = stat.tmin1[,2],
                            b = stat.tmean1[,2],
                            c = stat.tmax1[,2],
                            d = stat.tmean0[,2],
                            e = stat.rain01[,2],
                            f = stat.rain02[,2],
                            g  = stat.tmin0[,2])

  My.yield.rivaner <- function(vars, model){
    yield <- predict(object = model, newdata = vars, interval = "confidence")

    yield <- cbind.data.frame(year = vars[,1], yield = yield)

    return(yield)
  }

  yield.rivaner <- cbind.data.frame(My.yield.rivaner(vars = stats, model = model))

  return(yield.rivaner)
}
