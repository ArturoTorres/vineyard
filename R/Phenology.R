# © 2023 Luxembourg Institute of Science and Technology All Rights Reserved
#
#' Compute degree days by the single (lower) temperature threshold
#'
#' Implementation to compute degree days by the single (lower) temperature threshold by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, single (lower) threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree days.
#'
#' @export dd.lThresh
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
#' @importFrom "zoo" "coredata"
#' @importFrom "xts" "as.xts"
#'
#' @export cdd.lThresh
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
#' @importFrom "zoo" "index" "coredata"
#'
#' @export cdd.lThresh.phenology
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
#' @export dd.luThresh
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
#' @importFrom "zoo" "coredata"
#' @importFrom "xts" "as.xts"
#'
#' @export cdd.luThresh
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
#' @importFrom "zoo" "index" "coredata"
#'
#' @export cdd.luThresh.phenology
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
#' @export dd.luhThresh
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
#' @importFrom "zoo" "coredata"
#' @importFrom "xts" "as.xts"
#'
#' @export cdd.luhThresh
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

  cdd.LUHtt1 <- mapply(FUN = function(x, cdd.LUHtt) as.xts(cbind(x, cdd_luht = cumsum(cdd.LUHtt))),
                    x = data, cdd.LUHtt = dd.LUHtt, SIMPLIFY = FALSE)

  return(cdd.LUHtt1)
}

#' Cumulative degree days (CDD) by the lower, upper and heat temperature thresholds for phenology
#'
#' Implementation to compute the cumulative degree days by the lower, upper and heat temperature thresholds by
#' Molitor et al. (2014) for phenology.
#'
#' @param cdd.bb cumulative degree days (CDD) by the
#' single triangle algorithm for bud break in xts format as provided by "cdd.single.triangle.budbreak" function.
#' @param cdd.luht cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
#' "cdd.luhThresh" function.
#' @param chs.mean numeric, mean cumulative heat sum for bud break (in Celsius degrees).
#'
#' @return the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
#' the cumulative degree days (in Celsius degrees) for phenology.
#'
#' @importFrom "zoo" "index" "coredata"
#'
#' @export cdd.luhThresh.phenology
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

cdd.luhThresh.phenology <- function(cdd.bb, cdd.luht, chs.mean){
  # x <- 46
  idx <- lapply(1:length(cdd.bb), FUN = function(x){
    idx <- which(as.numeric(cdd.bb[[x]]$cdd_st) <= chs.mean)
    idx <- idx[length(idx)] + 1
    idx <- index(cdd.bb[[x]][idx,])

    idx1 <- which(index(cdd.luht[[x]]$cdd_luht) == idx)
    idx1 <- index(cdd.luht[[x]][idx1,])

    idx1.subset <- paste0(idx1,"/")
    subset <- cdd.luht[[x]][idx1.subset]

    cdd.phen <- as.numeric(coredata(subset$cdd_luht)) - rep(as.numeric(coredata(subset$cdd_luht[1])), nrow(subset))
    subset$cdd_luht <- cdd.phen
    colnames(subset$cdd_luht) <- "cdd_phenology"

    return(subset)
  })
}

#' Cumulative degree days (CDD) by the simple algorithm and lower, upper and heat temperature thresholds for phenology
#'
#' Implementation to compute the cumulative degree days by the simple algorithm and the lower, upper and heat temperature thresholds by
#' Molitor et al. (2014) for phenology.
#'
#' @param cdd.bb cumulative degree days (CDD) by the
#' simple algorithm for bud break in xts format as provided by "cdd.simple.budbreak" function.
#' @param cdd.luht cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
#' "cdd.luhThresh" function.
#' @param chs.mean numeric, mean cumulative heat sum for bud break (in Celsius degrees).
#'
#' @return the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
#' the cumulative degree days (in Celsius degrees) for phenology.
#'
#' @importFrom "zoo" "index" "coredata"
#'
#' @export cdd.simple.luhThresh.phenology
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

cdd.simple.luhThresh.phenology <- function(cdd.bb, cdd.luht, chs.mean){
  # x <- 46
  idx <- lapply(1:length(cdd.bb), FUN = function(x){
    idx <- which(as.numeric(cdd.bb[[x]]$cdd_simple) <= chs.mean)
    # idx <- idx[length(idx)] + 1 # TODO: CHECK IF 1 IS IT STILL VALID!
    idx <- idx[length(idx)] + 0 # TODO: CHECK IF 1 IS IT STILL VALID!
    idx <- index(cdd.bb[[x]][idx,])

    idx1 <- which(index(cdd.luht[[x]]$cdd_luht) == idx)
    idx1 <- index(cdd.luht[[x]][idx1,])

    idx1.subset <- paste0(idx1,"/")
    subset <- cdd.luht[[x]][idx1.subset]

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
#' @param ref.data data.frame, reference dataset to define the phenological stages e.g. "GrowthStage_CDD"
#' dataset.
#' @param stage vector, growth stage(s) for which the phenology should be computed. One or more out of
#' the 27 stages that range from 11 (First leaf unfolded and spread away from shoot) to
#' 89 (Berries ripe for harvest) according to Molitor et al. (2014).
#'
#' @return list per year, with each list containing a data.frame with the phenological stages
#' for vine growth.
#'
#' @importFrom "zoo" "coredata"
#'
#' @export phenology.stages
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

phenology.stages <- function(cdd.phen, ref.data, stage, cultivar){
  if(cultivar == "Rivaner") {
    ref.data1 = ref.data[-1, c("BBCH_stage", "Description", "CDD_MuellerThurgau")]
    ref.data2 = ref.data[  , c("BBCH_stage", "Description", "CDD_MuellerThurgau")]
  }else if(cultivar == "Riesling") {
    ref.data1 = ref.data[-1, c("BBCH_stage", "Description", "CDD_Riesling")]
    ref.data2 = ref.data[  , c("BBCH_stage", "Description", "CDD_Riesling")]
  }else if(cultivar == "P.Gris") {
    ref.data1 = ref.data[-1, c("BBCH_stage", "Description", "CDD_PinotNoir")]
    ref.data2 = ref.data[  , c("BBCH_stage", "Description", "CDD_PinotNoir")]
  }

  # w <- cdd.phen[[3]]
  lapply(X = cdd.phen, FUN = function(w){
    id      <- which(ref.data1[1] == stage)
    ref.cdd <- ref.data1[id, 3] # 3 indicates column with CDD_xx
    # x <- ref.cdd[26]
    idx     <- lapply(X = as.list(ref.cdd), FUN = function(x) {
      if(x >= max(as.numeric(coredata(w[,ncol(w)])))){
       NA
      }else{
        min(which(as.numeric(coredata(w[,ncol(w)])) >= as.numeric(x)))
      }
    })

    phen    <- mapply(FUN = function(x, y){
      if (is.na(x) | is.na(y)){
        warning("cdd for the time series doesn't reach one or more phenological stages")
        no.data <- data.frame(t(rep(NA,ncol(w))))
        colnames(no.data) <- colnames(w)
        return(cbind.data.frame(ref.data1[x,], no.data, stringsAsFactors = FALSE))
      }

      cbind.data.frame(ref.data1[x,], w[y,], stringsAsFactors = FALSE)
    }, x = id, y = idx
    )

    phen <- t(phen)
    res  <- cbind.data.frame(ref.data2[1,], w[1,], stringsAsFactors = FALSE)
    phen <- rbind.data.frame(res, phen, stringsAsFactors = FALSE)

    return(phen)
  })
}

#' Compare by growth stage from phenology output
#'
#' Implementation to compare observations versus computations for growth stage from phenology output.
#'
#' @param ref.data data.frame, reference dataset to define the observations for the phenological stage to compare
#' e.g. "data_remich_bbch09" or "data_remich_bbch81" datasets.
#' @param phen list per year, with each list containing a data.frame with the phenological stages
#' for vine growth as the output from the "phenology.stages" function.
#' @param growth.stage numeric, one of the growth stages to compute the summary.
#'
#' @return data.frame, with each row containing a year with the comparison of the phenological stage computed
#' and observed. The last colunm indicates the "Difference" between observed and computed day of year (DOY).
#'
#' @export compare.stage

compare.stage <- function(ref.data, phen, growth.stage){
  # x <- phen[[46]]
  bbch <- lapply(phen, function(x){
    idx <- which(x$BBCH_stage == growth.stage)
    out <- x[idx, c("BBCH_stage", "Description", "Year", "Month", "Day", "DayYear")]
  })

  out <- do.call(rbind, bbch)
  df <- data.frame(matrix(unlist(out), nrow=nrow(out), byrow=FALSE),stringsAsFactors=FALSE)
  colnames(df) <- colnames(out)

  df <- merge(df, ref.data, by="Year")
  df$Difference <- as.numeric(df[, ncol(df)]) - as.numeric(df[, "DayYear"])
  df
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
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80.

# setGeneric("vine.cdd.phenology", function(x) standardGeneric("vine.cdd.phenology"))
#
# setMethod("vine.cdd.phenology", signature = "list",
#           function(x){
#
#           }



