#' Compute degree days by the single temperature threshold
#'
#' Implementation to compute degree days by the single temperature threshold by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree days.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.single.threshold <- function(t.mean, a){
  if(t.mean <= a){
    dd <- 0
  } else if(a < t.mean){
    dd <- (t.mean - a)
  }
  return(dd)
}

#' Compute the cumulative degree days by the single temperature threshold
#'
#' Implementation to compute the cumulative degree days by the single temperature threshold by Molitor et al., (2014).
#'
#' @param data input data in xts format.
#' @param t.mean.col numeric, column position in data for the daily mean air temperature vector in Celsius degrees.
#' @param a numeric, threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return list per year for the input data plus an additional column with the cumulative degree days
#' (in Celsius degrees) for vine growth. The output for each year is a "xts" time series object.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.single.cumulative <- function(data, t.mean.col, a){
  dd.stt <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- DD.single.threshold(t.mean = as.numeric(y[t.mean.col]), a = a)
  })
  }
  )

  cdd.stt <- mapply(FUN = function(x, cdd.stt) as.xts(cbind(x, cdd_stt = cumsum(cdd.stt))),
                    x = data, cdd.stt = dd.stt )

  return(cdd.stt)
}

#' Cumulative degree days (CDD) by the single threshold algorithm for phenology
#'
#' Implementation to compute the cumulative degree days by the single threshold algorithm by
#' Molitor et al. (2010) for phenology.
#'
#' @param cdd.stt cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
#' "DD.single.treshold.cumulative" function.
#' @param chs.mean numeric, mean cumulative heat sum for bud break (in Celsius degrees).
#'
#' @return the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
#' the cumulative degree days (in Celsius degrees) for phenology.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.single.phenology <- function(cdd.stt, chs.mean){
  idx <- lapply(cdd.stt, FUN = function(x){
    idx <- which(x$cdd_stt <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(x[idx,])

    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.phen <- coredata(subset$cdd_stt) - rep(coredata(subset$cdd_stt[1]), nrow(subset))
    subset$cdd_stt <- cdd.phen
    colnames(subset$cdd_stt) <- "cdd_phenology"

    return(subset)
  })
}

#' Compute the degree days by the double (lower and upper) temperature thresholds
#'
#' Implementation to compute the degree days by the double (lower and upper) temperature thresholds by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, lower threshold temperature (in Celsius degrees) for vine growth.
#' @param b numeric, upper threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.double.threshold <- function(t.mean, a, b){
  if(t.mean <= a){
    dd <- 0
  } else if((a < t.mean) && (t.mean <= b)){
    dd <- (t.mean - a)
  } else if(b < t.mean){
    dd <- (b - a)
  }
  return(dd)
}

#' Compute the cumulative degree days by the double (lower and upper) temperature threshold
#'
#' Implementation to compute the cumulative degree days by the double (lower and upper) temperature threshold by Molitor et al., (2014).
#'
#' @param data input data in xts format.
#' @param t.mean.col numeric, column position in data for the daily mean air temperature vector in Celsius degrees.
#' @param a numeric, threshold temperature (in Celsius degrees) for vine growth.
#' @param b numeric, upper threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return list per year for the input data plus an additional column with the cumulative degree days
#' (in Celsius degrees) for vine growth. The output for each year is a "xts" time series object.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.double.cumulative <- function(data, t.mean.col, a, b){
  dd.dtt <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- DD.double.threshold(t.mean = as.numeric(y[t.mean.col]), a = a, b = b)
  })
  }
  )

  cdd.dtt <- mapply(FUN = function(x, cdd.dtt) as.xts(cbind(x, cdd_dtt = cumsum(cdd.dtt))),
                    x = data, cdd.dtt = dd.dtt)

  return(cdd.dtt)
}


#' Cumulative degree days (CDD) by the double (lower and upper) threshold algorithm for phenology
#'
#' Implementation to compute the cumulative degree days by the double (lower and upper) threshold algorithm by
#' Molitor et al. (2010) for phenology.
#'
#' @param cdd.dtt cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
#' "DD.double.treshold.cumulative" function.
#' @param chs.mean numeric, mean cumulative heat sum for bud break (in Celsius degrees).
#'
#' @return the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
#' the cumulative degree days (in Celsius degrees) for phenology.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.double.phenology <- function(cdd.dtt, chs.mean){
  idx <- lapply(cdd.dtt, FUN = function(x){
    idx <- which(x$cdd_dtt <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(x[idx,])

    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.phen <- coredata(subset$cdd_dtt) - rep(coredata(subset$cdd_dtt[1]), nrow(subset))
    subset$cdd_dtt <- cdd.phen
    colnames(subset$cdd_dtt) <- "cdd_phenology"

    return(subset)
  })
}


#' Compute the degree days by a lower, upper and heat threshold temperatures
#'
#' Implementation to compute the degree days by a lower, upper and heat threshold temperatures
#' by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, lower threshold temperature (in Celsius degrees) for vine growth.
#' @param b numeric, upper threshold temperature (in Celsius degrees) for vine growth.
#' @param c numeric, heat threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.LUH.threshold <- function(t.mean, a, b, c){
  if((t.mean <= a) || (c + (b - a) < t.mean)){
    dd <- 0
  } else if((a < t.mean) && (t.mean < b)){
    dd <- (t.mean - a)
  } else if(b <= t.mean){
    dd <- (b - a)
  } else if(c < t.mean) {
    dd <- (b - a) - (t.mean - c)
  }
  return(dd)
}


#' Compute cumulative degree days by the lower, upper and heat temperature thresholds
#'
#' Implementation to compute cumulative degree days by the lower, upper and heat temperature threshold
#' by Molitor et al., (2014).
#'
#' @param data input data in xts format.
#' @param t.mean.col numeric, column position in data for the daily mean air temperature vector in Celsius degrees.
#' @param a numeric, threshold temperature (in Celsius degrees) for vine growth.
#' @param b numeric, upper threshold temperature (in Celsius degrees) for vine growth.
#' @param c numeric, heat threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return list per year for the input data plus an additional column with the cumulative degree days
#' (in Celsius degrees) for vine growth. The output for each year is a "xts" time series object.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.LUH.cumulative <- function(data, t.mean.col, a, b, c){
  dd.LUHtt <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- DD.LUH.threshold(t.mean = as.numeric(y[t.mean.col]), a = a, b = b, c = c)
  })
  }
  )

  cdd.LUHtt <- mapply(FUN = function(x, cdd.LUHtt) as.xts(cbind(x, cdd_LUHtt = cumsum(cdd.LUHtt))),
                    x = data, cdd.LUHtt = dd.LUHtt)

  return(cdd.LUHtt)
}


#' Cumulative degree days (CDD) by the lower, upper and heat thresholds algorithm for phenology
#'
#' Implementation to compute the cumulative degree days by the lower, upper and heat threshold algorithm by
#' Molitor et al. (2010) for phenology.
#'
#' @param cdd.LUHtt cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
#' "DD.LUH.cumulative" function.
#' @param chs.mean numeric, mean cumulative heat sum for bud break (in Celsius degrees).
#'
#' @return the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
#' the cumulative degree days (in Celsius degrees) for phenology.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

DD.LUH.phenology <- function(cdd.LUHtt, chs.mean){
  idx <- lapply(cdd.LUHtt, FUN = function(x){
    idx <- which(x$cdd_LUHtt <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(x[idx,])

    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.phen <- coredata(subset$cdd_LUHtt) - rep(coredata(subset$cdd_LUHtt[1]), nrow(subset))
    subset$cdd_LUHtt <- cdd.phen
    colnames(subset$cdd_LUHtt) <- "cdd_phenology"

    return(subset)
  })
}


#' Compute phenological stages
#'
#' Implementation to compute phenological stages by Molitor et al., (2014).
#'
#' @param cdd.phen list, cumulative degree days (in Celsius degrees) for vine growth in xts format as
#' provided by e.g. "DD.single.treshold.phenology" function.
#' @param ref.data data.frame, reference dataset to define the phenological stages e.g. "GowthStage_CDD"
#' dataset.
#' @param stage vector, growth stage(s) for which the phenology should be computed.
#'
#' @return list per year, with each list containing a data.frame with the phenological stages
#' for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

Phenology.stages <- function(cdd.phen, ref.data, stage){
  lapply(X = cdd.phen, FUN = function(w){
    id      <- which(ref.data[1] == stage)
    ref.cdd <- ref.data[id, "CDD"]
    idx     <- lapply(X = as.list(ref.cdd), FUN = function(x) {
      min(which(coredata(w[,9]) >= x))
    })

    phen    <- mapply(FUN = function(x, y){
      cbind.data.frame(ref.data[x,], w[y,])
    }, x = id, y = idx
    )

    return(t(phen))
  })
}
