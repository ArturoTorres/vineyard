#' Compute degree days by the single (lower) temperature threshold
#'
#' Implementation to compute degree days by the single (lower) temperature threshold by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, single (lower) threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree days.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

dd.lThresh <- function(t.mean, a){
  if(t.mean <= a){
    dd <- 0
  } else if(a < t.mean){
    dd <- (t.mean - a)
  }
  return(dd)
}

#' Compute the cumulative degree days by the single (lower) temperature threshold
#'
#' Implementation to compute the cumulative degree days by the single (lower) temperature threshold by Molitor et al., (2014).
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

cdd.lThresh <- function(data, t.mean.col, a){
  dd.stt <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- dd.lThresh(t.mean = as.numeric(y[t.mean.col]), a = a)
  })
  }
  )

  cdd.stt <- mapply(FUN = function(x, cdd.stt) as.xts(cbind(x, cdd_lt = cumsum(cdd.stt))),
                    x = data, cdd.stt = dd.stt )

  return(cdd.stt)
}

#' Cumulative degree days (cdd) by the single (lower) threshold algorithm for phenology
#'
#' Implementation to compute the cumulative degree days (cdd) by the single (lower) threshold algorithm by
#' Molitor et al. (2014) for phenology.
#'
#' @param cdd.lt list, cumulative degree days (in Celsius degrees) for vine growth in xts format per year
#' as provided by "cdd.1Treshold" function.
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

cdd.lThresh.phenology <- function(cdd.lt, chs.mean){
  idx <- lapply(cdd.lt, FUN = function(x){
    idx <- which(as.numeric(x$cdd_lt) <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(x[idx,])

    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.phen <- as.numeric(coredata(subset$cdd_lt)) - rep(as.numeric(coredata(subset$cdd_lt[1])), nrow(subset))
    subset$cdd_lt <- cdd.phen
    colnames(subset$cdd_lt) <- "cdd_phenology"

    return(subset)
  })
}

#' Compute the degree days by the double (lower and upper) temperature thresholds
#'
#' Implementation to compute the degree days by the double (lower and upper) temperature thresholds by Molitor et al., (2014).
#'
#' @param t.mean vector, daily mean air temperature in Celsius degrees.
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

dd.luThresh <- function(t.mean, a, b){
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
#' @param a numeric, lower threshold temperature (in Celsius degrees) for vine growth.
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

cdd.luThresh <- function(data, t.mean.col, a, b){
  dd.dtt <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- dd.luThresh(t.mean = as.numeric(y[t.mean.col]), a = a, b = b)
  })
  }
  )

  cdd.dtt <- mapply(FUN = function(x, cdd.dtt) as.xts(cbind(x, cdd_lut = cumsum(cdd.dtt))),
                    x = data, cdd.dtt = dd.dtt)

  return(cdd.dtt)
}


#' Cumulative degree days (CDD) by the double (lower and upper) temperature thresholds for phenology
#'
#' Implementation to compute the cumulative degree days by the double (lower and upper) temperature thresholds by
#' Molitor et al. (2014) for phenology.
#'
#' @param cdd.lut list, cumulative degree days (in Celsius degrees) for vine growth in xts format per year
#' as provided by the double threshold temperature ("cdd.double.threshold" function).
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

cdd.luThresh.phenology <- function(cdd.lut, chs.mean){
  idx <- lapply(cdd.lut, FUN = function(x){
    idx <- which(as.numeric(x$cdd_lut) <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(x[idx,])

    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.phen <- as.numeric(coredata(subset$cdd_lut)) - rep(as.numeric(coredata(subset$cdd_lut[1])), nrow(subset))
    subset$cdd_lut <- cdd.phen
    colnames(subset$cdd_lut) <- "cdd_phenology"

    return(subset)
  })
}


#' Compute the degree days by a lower, upper and heat temperature thresholds
#'
#' Implementation to compute the degree days by a lower, upper and heat temperature thresholds
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

dd.luhThresh <- function(t.mean, a, b, c){
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
#' Implementation to compute cumulative degree days by the lower, upper and heat temperature thresholds
#' by Molitor et al., (2014).
#'
#' @param data input data in xts format.
#' @param t.mean.col numeric, column position in data for the daily mean air temperature vector in Celsius degrees.
#' @param a numeric, lower threshold temperature (in Celsius degrees) for vine growth.
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

cdd.luhThresh <- function(data, t.mean.col, a, b, c){
  dd.LUHtt <- lapply(data, function(x) {apply(X = coredata(x), MARGIN = 1, FUN = function(y){
    dd <- dd.luhThresh(t.mean = as.numeric(y[t.mean.col]), a = a, b = b, c = c)
  })
  }
  )

  cdd.LUHtt <- mapply(FUN = function(x, cdd.LUHtt) as.xts(cbind(x, cdd_luht = cumsum(cdd.LUHtt))),
                    x = data, cdd.LUHtt = dd.LUHtt)

  return(cdd.LUHtt)
}


#' Cumulative degree days (CDD) by the lower, upper and heat temperature thresholds for phenology
#'
#' Implementation to compute the cumulative degree days by the lower, upper and heat temperature thresholds by
#' Molitor et al. (2014) for phenology.
#'
#' @param cdd.luht cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
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

cdd.luhThresh.phenology <- function(cdd.luht, chs.mean){
  idx <- lapply(cdd.luht, FUN = function(x){
    idx <- which(as.numeric(x$cdd_luht) <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(x[idx,])

    idx.subset <- paste0(idx,"/")
    subset <- x[idx.subset]

    cdd.phen <- as.numeric(coredata(subset$cdd_luht)) - rep(as.numeric(coredata(subset$cdd_luht[1])), nrow(subset))
    subset$cdd_luht <- cdd.phen
    colnames(subset$cdd_luht) <- "cdd_phenology"

    return(subset)
  })
}


#' Compute phenological stages
#'
#' Implementation to compute phenological stages by Molitor et al., (2014).
#'
#' @param cdd.phen list, cumulative degree days (in Celsius degrees) for vine growth in xts format as
#' provided by any of the functions "cdd.1Tresh.phenology" or "cdd.2Tresh.phenology" or  "cdd.3Tresh.phenology".
#' @param ref.data data.frame, reference dataset to define the phenological stages e.g. "GowthStage_CDD"
#' dataset.
#' @param stage vector, growth stage(s) for which the phenology should be computed. One or more out of
#' the 27 stages that range from 11 (First leaf unfolded and spread away from shoot) to
#' 89 (Berries ripe for harvest) according to Molitor et al. (2014).
#'
#' @return list per year, with each list containing a data.frame with the phenological stages
#' for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

phenology.stages <- function(cdd.phen, ref.data, stage){
  lapply(X = cdd.phen, FUN = function(w){
    id      <- which(ref.data[1] == stage)
    ref.cdd <- ref.data[id, "CDD"]
    idx     <- lapply(X = as.list(ref.cdd), FUN = function(x) {
      min(which(as.numeric(coredata(w[,ncol(w)])) >= as.numeric(x)))
    })

    phen    <- mapply(FUN = function(x, y){
      cbind.data.frame(ref.data[x,], w[y,], stringsAsFactors = FALSE)
    }, x = id, y = idx
    )

    return(t(phen))
  })
}



#' Cumulative degree days (CDD) by temperature thresholds for phenology
#'
#' Implementation to compute cumulative degree days (CDD) by temperature thresholds for phenology
#' by Molitor et al., (2014).
#'
#' @param cdd.phen list, cumulative degree days (in Celsius degrees) for vine growth in xts format as
#' provided by any of the functions "cdd.1Tresh.phenology" or "cdd.2Tresh.phenology" or  "cdd.3Tresh.phenology".
#' @param ref.data data.frame, reference dataset to define the phenological stages e.g. "GowthStage_CDD"
#' dataset.
#' @param stage vector, growth stage(s) for which the phenology should be computed. One or more out of
#' the 27 stages that range from 11 (First leaf unfolded and spread away from shoot) to
#' 89 (Berries ripe for harvest) according to Molitor et al. (2014).
#'
#' @return list per year, with each list containing a data.frame with the phenological stages
#' for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

# setGeneric("vine.cdd.phenology", function(x) standardGeneric("vine.cdd.phenology"))
#
# setMethod("vine.cdd.phenology", signature = "list",
#           function(x){
#
#           }
