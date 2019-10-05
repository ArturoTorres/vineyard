#' Sample of meteorological data for Remich station
#'
#' A sample dataset containing time series of meteorological data for Remich station located in the
#' Grand-Duchy of Luxembourg obtained by the Institut Viti-vinicole in Remich.
#' The data covers the period from 1970 to 2017 at daily time interval. The data is providad as
#' a space-time full data frame (STFDF) object from "spacetime" package.
#'
#' @name data_remich
#' @docType data
#'
#' @usage data(data_remich)
#'
#' @details The spatial representation for the data corresponds to a SpatialPointsDataFrame with
#' coordinate reference system (CRS) EPSG:2169 - Luxembourg 1930 / Gauss - Projected.

#'
#' @format Formal class 'STFDF' [package "spacetime"] with 4 slots \cr
#' ..@ data   :'data.frame':	17532 obs. of  8 variables: \cr
#' .. ..$ Year    : num [1:17532] 1970 1970 1970 1970 1970 1970 1970 1970 1970 1970 ... \cr
#' .. ..$ Month   : num [1:17532] 1 1 1 1 1 1 1 1 1 1 ... \cr
#' .. ..$ Day     : num [1:17532] 1 2 3 4 5 6 7 8 9 10 ... \cr
#' .. ..$ DayYear : num [1:17532] 1 2 3 4 5 6 7 8 9 10 ... \cr
#' .. ..$ T.max   : num [1:17532] -3.5 -1 1 0.8 -0.1 -0.7 0 -0.3 3.6 4.3 ... \cr
#' .. ..$ T.min   : num [1:17532] -4.8 -6.5 -2.5 -0.4 -4.1 -4.5 -4.8 -5.4 -1.6 2.5 ... \cr
#' .. ..$ T.mean  : num [1:17532] -4.15 -3.75 -0.75 0.2 -2.1 -2.6 -2.4 -2.85 1 3.4 ... \cr
#' .. ..$ Rainfall: num [1:17532] 0 0 2.7 0.8 4 3.2 0 0 1.8 5.8 ... \cr
#' ..@ sp     :Formal class 'SpatialPointsDataFrame' [package "sp"] with 5 slots \cr
#' .. .. ..@ data       :'data.frame':	1 obs. of  4 variables: \cr
#' .. .. .. ..$ id: Factor w/ 1 level "1": 1 \cr
#' .. .. .. ..$ x : num 6.35 \cr
#' .. .. .. ..$ y : num 49.5 \cr
#' .. .. .. ..$ z : Factor w/ 1 level "207": 1 \cr
#' .. .. ..@ coords.nrs : num(0) \cr
#' .. .. ..@ coords     : num [1, 1:2] 93626 67967 \cr
#' .. .. .. ..- attr(*, "dimnames")=List of 2 \cr
#' .. .. .. .. ..$ : NULL \cr
#' .. .. .. .. ..$ : chr [1:2] "coords.x1" "coords.x2" \cr
#' .. .. ..@ bbox       : num [1:2, 1:2] 93626 67967 93626 67967 \cr
#' .. .. .. ..- attr(*, "dimnames")=List of 2 \cr
#' .. .. .. .. ..$ : chr [1:2] "coords.x1" "coords.x2" \cr
#' .. .. .. .. ..$ : chr [1:2] "min" "max" \cr
#' .. .. ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slot \cr
#' .. .. .. .. ..@ projargs: chr "+proj=tmerc +lat_0=49.83333333333334 +lon_0=6.166666666666667
#'                               +k=1 +x_0=80000 +y_0=100000 +ellps=intl +units=m +no_defs" \cr
#' ..@ time   :An ‘xts’ object on 1970-01-01/2017-12-31 containing: \cr
#'   Data: int [1:17532, 1] 1 2 3 4 5 6 7 8 9 10 ... \cr
#' - attr(*, "dimnames")=List of 2 \cr
#' ..$ : NULL \cr
#' ..$ : chr "timeIndex" \cr
#' Indexed by objects of class: [POSIXct,POSIXt] TZ: \cr
#'   xts Attributes: \cr
#'   NULL \cr
#' ..@ endTime: POSIXct[1:17532], format: "1970-01-02" "1970-01-03" "1970-01-04" "1970-01-05" ...

#' @source \url{https://agriculture.public.lu/de/weinbau-oenologie.html}
#'
#' @examples
#' #' Cohercion to data.frame
#' remich.df <- as.data.frame(data_remich)
#' head(remich.df)
#'
#' #' Cohercion to xts
#' remich.xts <- xts(x = remich.df, order.by = remich.df$time)
#' head(remich.xts)
#'
#' @keywords data
NULL


#' Cumulative degree days and growth stages
#'
#' A sample dataset containing the cumulative degree days (CDD) with optimized lower,
#' upper, and heat threshold triplets (5, 20, 22°C) per growth stages
#' according to Table 4 from Molitor et al. (2014).
#'
#' @name GrowthStage_CDD
#' @docType data
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer.
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80, 2014.
#' @keywords data
NULL


#' Sample of meteorological data for the Moselle region in Luxembourg
#'
#' A sample dataset containing time series of meteorological data for the Moselle region located in the
#' Grand-Duchy of Luxembourg obtained by the Potsdam Institute for Climate Impact Research (PIK) in Germany.
#' The data covers the period from 1961 to 2018 at daily time interval. The data is provided as
#' a space-time full data frame (STFDF) object from "spacetime" package.
#'
#' @name data_pik_observ
#' @docType data
#'
#' @usage data(data_pik_observ)
#'
#' @details The spatial representation for the data corresponds to a SpatialPoints with
#' coordinate reference system (CRS) EPSG:2169 - Luxembourg 1930 / Gauss - Projected.

#'
#' Formal class 'STFDF' [package "spacetime"] with 4 slots \cr
#' ..@ data   :'data.frame':	466048 obs. of  9 variables: \cr
#'   .. ..$ ta        : num [1:466048] 1 1 1 1 1 1 1 1 1 1 ... \cr
#'   .. ..$ mo        : num [1:466048] 1 1 1 1 1 1 1 1 1 1 ... \cr
#'   .. ..$ jahr      : num [1:466048] 1961 1961 1961 1961 1961 ... \cr
#'   .. ..$ tmax      : num [1:466048] 3.5 3.3 3 2.6 2.8 2.5 2 2.5 2.2 2 ... \cr
#'   .. ..$ tmit      : num [1:466048] 2.3 2.2 1.7 1.3 1.6 1.1 0.5 1.5 1.1 0.7 ... \cr
#'   .. ..$ tmin      : num [1:466048] 1.2 1 0.5 0 -0.1 -0.4 -0.9 -0.7 -0.9 -1.1 ... \cr
#'   .. ..$ prec      : num [1:466048] 0 0 0 0 0 0 0 0 0 0 ... \cr
#'   .. ..$ ludr      : num [1:466048] 984 982 978 973 980 ... \cr
#'   .. ..$ station_id: Factor w/ 22 levels "00809","00810",..: 1 2 3 4 5 6 7 8 9 10 ... \cr
#'   ..@ sp     :Formal class 'SpatialPoints' [package "sp"] with 3 slots \cr
#'   .. .. ..@ coords     : num [1:22, 1:2] 90823 102882 115006 127122 100946 ... \cr
#'   .. .. .. ..- attr(*, "dimnames")=List of 2 \cr
#'   .. .. .. .. ..$ : NULL \cr
#'   .. .. .. .. ..$ : chr [1:2] "x" "y" \cr
#'   .. .. ..@ bbox       : num [1:2, 1:2] 81069 43466 127122 109652 \cr
#'   .. .. .. ..- attr(*, "dimnames")=List of 2 \cr
#'   .. .. .. .. ..$ : chr [1:2] "x" "y" \cr
#'   .. .. .. .. ..$ : chr [1:2] "min" "max" \cr
#'   .. .. ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slot \cr
#'   .. .. .. .. ..@ projargs: chr "+proj=tmerc +lat_0=49.83333333333334 +lon_0=6.166666666666667  \cr
#'                                 +k=1 +x_0=80000 +y_0=100000 +ellps=intl +units=m +no_defs" \cr
#'   ..@ time   :An ‘xts’ object on 1961-01-01/2018-12-31 containing: \cr
#'     Data: int [1:21184, 1] 1 2 3 4 5 6 7 8 9 10 ... \cr
#'     - attr(*, "dimnames")=List of 2 \cr
#'     ..$ : NULL..$ : chr "timeIndex" \cr
#'     Indexed by objects of class: [POSIXct,POSIXt] TZ: \cr
#'       xts Attributes: \cr
#'         NULL \cr
#'         ..@ endTime: POSIXct[1:21184], format: "1961-01-02" "1961-01-03" "1961-01-04" "1961-01-05" ... \cr

#' @source \url{https://www.pik-potsdam.de/}
#'
#' @examples
#' #' Cohercion to data.frame
#' pik_observ.df <- as.data.frame(data_pik_observ)
#' head(pik_observ.df)
#'
#' #' Cohercion to xts
#' pik_observ.xts <- xts(x = pik_observ.df, order.by = pik_observ.df$time)
#' head(pik_observ.xts)
#'
#' #' plot stfdf object
#' year.ini <- which(index(data_pik_observ@time) == as.POSIXct("1973-06-01",  format = "%Y-%m-%d"))
#' year.end <- which(index(data_pik_observ@time) == as.POSIXct("1973-06-30",  format = "%Y-%m-%d"))
#'
#' stplot(data.stfdf[, year.ini:year.end, "tmit"], scales=list(draw=TRUE))
#' stplot(data.stfdf[, year.ini:year.end, "tmit"], scales=list(draw=TRUE), mode = "ts")

#' @keywords data
NULL

