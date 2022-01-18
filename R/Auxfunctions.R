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


#' Defining data.frame for yield and disease computation
#'
#' @param data.years list of zoo time series from the input data splitted by years.
#' @param year.ini numeric, the initial year for computation.
#' @param year.end numeric, the final year for computation.
#' @param phen.luht data.frame for the phenology computation by lower, upper and heat thresholds (luht).
#' @param bbch.stage numeric, the reference BBCH stage.
#'
#' @return  a list with two objects: 1) data.years.subset, the input data.years data.frame subsetted
#' according to the initial and ending year definition; and 2) phen.d_bbch_x.df2, a data.frame with two
#' columns per reference BBCH stage defined, the first column is the actual BBCH DOY and the second column is
#' the DOY for the reference BBCH (a vector of zeros, BBCH DOY reference minus BBCH DOY reference).
#'
#' @importFrom "xts" "xts"
#' @export phen.dbbchx.df2

phen.dbbchx.df2 <- function(data.years, year.ini, year.end, phen.luht, bbch.stage){
  # Subsetting data
  years.lst <- lapply(data.years, function(x) out <- x[1, "Year"])

  years <- do.call(rbind, years.lst)

  id.subset <- which(years == year.ini | years == year.end)
  data.years.subset <- data.years[id.subset[1]:id.subset[2]]

  # D68 definition
  head(data.years.subset[[1]])

  phen.luht.subset <- phen.luht[id.subset[1]:id.subset[2]]
  phen.luht.subset[[1]]

  phen.d_bbch_x <- lapply(phen.luht.subset, function(x) {
    d_bbch_x <- x[,"DayYear"]

    bbch.id <- which(x[, "BBCH_stage"] == bbch.stage)

    d_bbch_x <- d_bbch_x[c(bbch.id)]
    d_bbch_x <- as.matrix(t(as.numeric(d_bbch_x)))

    colnames(d_bbch_x) <- paste0("BBCH.", bbch.stage)
    row.names(d_bbch_x) <- x[1,"Year"]

    return(d_bbch_x)
  })

  phen.d_bbch_x[[1]]
  #      BBCH.09 BBCH.63 BBCH.68 BBCH.81
  # 1993     116     161     167     218

  phen.d_bbch_x <- do.call(rbind, phen.d_bbch_x)
  phen.d_bbch_x.df <- data.frame(matrix(as.numeric(phen.d_bbch_x),
                                   nrow = nrow(phen.d_bbch_x), ncol = ncol(phen.d_bbch_x)))
  colnames(phen.d_bbch_x.df) <- colnames(phen.d_bbch_x)
  row.names(phen.d_bbch_x.df) <- row.names(phen.d_bbch_x)
  phen.d_bbch_x.df

  # D_x definition
  phen.d_bbch_x.df2 <- cbind(phen.d_bbch_x.df[colnames(phen.d_bbch_x.df)],
                        phen.d_bbch_x.df[colnames(phen.d_bbch_x.df)] - phen.d_bbch_x.df[colnames(phen.d_bbch_x.df)]
                        )
  colnames(phen.d_bbch_x.df2) <- mapply(function(i, y) paste0(i, y), i = colnames(phen.d_bbch_x.df2),
                                        y = c("_DOY", paste0("_D", bbch.stage)))
  phen.d_bbch_x.df2
  # summary(phen.d_bbch_x.df2)
  # row.names(phen.d68.df2)

  return(list(data.years.subset = data.years.subset,
              phen.d_bbch_x.df2 = phen.d_bbch_x.df2))
}

#' Time window pane analysis
#'
#' @param x zoo, time series from the input data for one individual year.
#' @param var character, the name of the variable for computing the window pane statistics.
#' @param fun character, name of the function for computation in the window pane.
#' @param t.ini numeric, the initial number in days from the reference to start the window pane statistics.
#' @param width numeric, the width in days of the window pane.
#' @param d68 numeric or logical, one numeric value for the DOY of the reference BBCH stage to computing the statistic for
#' the corresponding year or FALSE if reference BBCH stage day is not taken i.e. computation in actual DOY.
#'
#' @return  numeric, a vector of two values: 1) the computation year; and 2) the computed statistic for the
#' corresponding year.
#'
#' @importFrom "xts" "xts"
#'
#' @export window.stat

# x <- remich.years.subset[[1]]
window.stat <- function(x, var, fun, t.ini, width, d.ref  = FALSE){
  if(d.ref == FALSE){
    out <- data.frame(stat = coredata(x[t.ini:(t.ini + width), c("Year", var)]), stringsAsFactors = FALSE)
  }else {
    out <- data.frame(stat = coredata(x[(d.ref+t.ini):(d.ref+t.ini+width), c("Year", var)]), stringsAsFactors = FALSE)
  }

  out <- apply(X = out, MARGIN = 2, FUN = function(y) as.numeric(as.character(y)))
  out <- apply(X = out, MARGIN = 2, FUN = fun)

  return(out)
}

#' Linear regression applied for calculating the CDD_7;18;24 reaching 5\% disease severity (Botrytis cinerea) for Riesling
#'
#' @param stat.tmean01 numeric, vector with two columns: 1) year, and 2) first statistic for mean temperature.
#' @param stat.tmean02 numeric, vector with two columns: 1) year, and 2) second statistic for mean temperature.
#' @param stat.tmean03 numeric, vector with two columns: 1) year, and 2) third statistic for mean temperature.
#' @param stat.rain01 numeric, vector with two columns: 1) year, and 2) first statistic for precipitation.
#' @param stat.rain02 numeric, vector with two columns: 1) year, and 2) second statistic for precipitation.
#' @param coef the predefined linear regression coefficients,  1 observation of 6 variables, being the first
#' the intercept, and the remainder variables the coefficients for each statistic matching the definition order.
#'
#' @return  data.frame, 7 obs. of 2 variables (year and CDD for 7, 18 and 24 thresholds reaching 5\% disease severity,
#' Botrytis cinerea, for Riesling).
#'
#' @export botrytis.lr.applied.riesling

botrytis.lr.applied.riesling <- function(stat.tmean01, stat.tmean02, stat.tmean03, stat.rain01, stat.rain02, coef){

  stats <- cbind.data.frame(year   = stat.tmean01[,1],
                            tmean01  = stat.tmean01[,2],
                            tmean02 = stat.tmean02[,2],
                            tmean03 = stat.tmean03[,2],
                            rain01 = stat.rain01[,2],
                            rain02 = stat.rain02[,2])

  My.botrytis.reisling <- function(vars, coef){
    cdd_5perc_botrytis <- matrix(NA, nrow = nrow(vars), ncol = 1)

    for(i in 1:nrow(vars)){
      dat <- coef[,"tmean01"]*vars[i,"tmean01"] + coef[,"tmean02"]*vars[i,"tmean02"] +
        coef[,"tmean03"]*vars[i,"tmean03"] +
        coef[,"rain01"]*vars[i,"rain01"] + coef[,"rain02"]*vars[i,"rain02"]

      cdd_5perc_botrytis[i,1] <- coef[1, "intercept"] + dat
    }

    bot <- cbind.data.frame(year = vars[,1], cdd_5perc_botrytis = cdd_5perc_botrytis)

    return(bot)
  }

  botrytis.riesling <- cbind.data.frame(My.botrytis.reisling(vars = stats, coef = coef))

  return(botrytis.riesling)
}

