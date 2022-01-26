#' Linear regression applied for predicting yield for Riesling
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
#' @export yield.lr.applied.riesling

yield.lr.applied.riesling <- function(stat.tmin1.ries, stat.tmin01.ries, stat.tmin02.ries, stat.rain0.ries,
                                      stat.rain1.ries, model){

  stats <- cbind.data.frame(year   = stat.tmin1.ries[,1],
                            a  = stat.tmin1.ries[,2],
                            b = stat.tmin01.ries[,2],
                            c = stat.tmin02.ries[,2],
                            d = stat.rain0.ries[,2],
                            e = stat.rain1.ries[,2])

  My.yield.reisling <- function(vars, model){
    yield <- predict(object = model, newdata = vars, interval = "confidence")

    yield <- cbind.data.frame(year = vars[,1], yield = yield)

    return(yield)
  }

  yield.riesling <- cbind.data.frame(My.yield.reisling(vars = stats, model = lr.yield.riesling))

  return(yield.riesling)
}
