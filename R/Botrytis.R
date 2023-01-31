# © 2023 Luxembourg Institute of Science and Technology All Rights Reserved
#
#' Linear regression model applied for predicting the CDD_7;18;24 reaching 5\% disease severity (Botrytis cinerea) for Riesling
#'
#' @param stat.tmean01 numeric, vector with two columns: 1) year, and 2) first statistic for mean temperature.
#' @param stat.tmean02 numeric, vector with two columns: 1) year, and 2) second statistic for mean temperature.
#' @param stat.tmean03 numeric, vector with two columns: 1) year, and 2) third statistic for mean temperature.
#' @param stat.rain01 numeric, vector with two columns: 1) year, and 2) first statistic for precipitation.
#' @param stat.rain02 numeric, vector with two columns: 1) year, and 2) second statistic for precipitation.
#' @param model the predefined model e.g. linear regression (lm). Should be a match between the linear
#' regression coefficients and each statistic in the same definition order.
#'
#' @return  data.frame, n obs. of 4 variables (year, predicted CDD for 7, 18 and 24 thresholds reaching 5\% disease severity,
#' Botrytis cinerea, for Riesling), and lower and upper confidence intervals. n is the total number of years for prediction.
#'
#' @export lm.botrytis.applied.riesling

lm.botrytis.applied.riesling <- function(stat.tmean01, stat.tmean02, stat.tmean03, stat.rain01, stat.rain02, model){

  stats <- cbind.data.frame(year   = stat.tmean01[,1],
                            a  = stat.tmean01[,2],
                            b = stat.tmean02[,2],
                            c = stat.tmean03[,2],
                            d = stat.rain01[,2],
                            e = stat.rain02[,2])

  My.botrytis.reisling <- function(vars, model){
    cdd_5perc_botrytis <- predict(object = model, newdata = vars, interval = "confidence")

    bot <- cbind.data.frame(year = vars[,1], cdd_5perc_botrytis = cdd_5perc_botrytis)

    return(bot)
  }

  botrytis.riesling <- cbind.data.frame(My.botrytis.reisling(vars = stats, model = model))

  return(botrytis.riesling)
}

