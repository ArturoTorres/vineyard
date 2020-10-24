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
#' library(xts)
#' remich.xts <- xts(x = remich.df, order.by = remich.df$time)
#' head(remich.xts)
#'
#' @keywords data
NULL


#' Cumulative degree days and BBCH growth stages
#'
#' A sample dataset containing the cumulative degree days (CDD) for optimized lower,
#' upper, and heat threshold triplets for Mueller-Thurgau (5°C, 20°C, 22°C),
#' Riesling  (7°C, 18°C, 24°C) and Pinot noir  (3°C, 20°C, 24°C) per BBCH growth stages
#' according to Supplementary Table 2 from Molitor and Junk (2019).
#'
#' @name GrowthStage_CDD
#' @docType data
#'
#' @usage data(GrowthStage_CDD)
#'
#' @format 'data.frame':	27 obs. of  3 variables: \cr
#' $ Growth_stage: int  9 11 12 13 14 15 16 17 18 19 ... \cr
#' $ Description : chr  "Budburst: green shoot tips clearly visible"  \cr
#' "First leaf unfolded and spread away from shoot"  \cr
#' "Two leaves unfolded" "Three leaves unfolded" ... \cr
#' $ CDD         : num  NA 34.9 58.6 80.8 110.2 ...
#
#' @references Daniel Molitor, Jürgen Junk.
#' Climate change is implicating a two-fold impact on air temperature increase
#' in the ripening period under the conditions of the Luxembourgish grapegrowing region.
#' Vine and Wine Open Access Journal, Oneo One, (3):409-422, 2019.
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
#' @format Formal class 'STFDF' [package "spacetime"] with 4 slots \cr
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

#' @references Christoph Menz and Thomas Kartschall, 2019. Project CLIM4VITIS: Climate change impact mitigation
#' for European viticulture. Potsdam Institut fuer Klimafolgenforschung (PIK), Germany. \url{https://clim4vitis.eu/}.
#'
#' @examples
#' #' Cohercion to data.frame
#' pik_observ.df <- as.data.frame(data_pik_observ)
#' head(pik_observ.df)
#'
#' #' Cohercion to xts
#' library(xts)
#' pik_observ.xts <- xts(x = pik_observ.df, order.by = pik_observ.df$time)
#' head(pik_observ.xts)
#'
#' #' plot stfdf object
#' year.ini <- which(index(data_pik_observ@time) == as.POSIXct("1973-06-01",  format = "%Y-%m-%d"))
#' year.end <- which(index(data_pik_observ@time) == as.POSIXct("1973-06-30",  format = "%Y-%m-%d"))
#'
#' stplot(data_pik_observ[, year.ini:year.end, "tmit"], scales=list(draw=TRUE))
#' stplot(data_pik_observ[, year.ini:year.end, "tmit"], scales=list(draw=TRUE), mode = "ts")

#' @keywords data
NULL

#' A 'sp' object for the Grevenmacher admininistrative boundaries
#'
#' A dataset containing a 'sp' object for the admininistrative boundaries of the District of Grevenmacher
#' in the Grand-Duchy of Luxembourg. It comprises the Commune and Canton levels as provided by the Luxembourgish Data
#' Platform. The data is provided as a SpatialPolygonsDataFrame from "sp" package.
#'
#' @name data_boundary_grevenmacher
#' @docType data
#'
#' @usage data(data_boundary_grevenmacher)
#'
#' @details The spatial representation for the data corresponds to a SpatialPolygonsDataFrame with
#' coordinate reference system (CRS) EPSG:2169 - Luxembourg 1930 / Gauss - Projected.
#'
#' @format Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots \cr
#'..@ data       :'data.frame':	23 obs. of  4 variables: \cr
#'  .. ..$ COMMUNE : Factor w/ 23 levels "Beaufort","Bech",..: 14 16 1 18 9 12 8 10 4 2 ... \cr
#'  .. ..$ CANTON  : Factor w/ 3 levels "Echternach","Grevenmacher",..: 2 3 1 1 1 2 3 2 2 1 ... \cr
#'  .. ..$ DISTRICT: Factor w/ 1 level "Grevenmacher": 1 1 1 1 1 1 1 1 1 1 ... \cr
#'  .. ..$ LAU2    : Factor w/ 23 levels "1001","1002",..: 13 19 1 6 5 12 17 10 8 2 ... \cr
#'  ..@ polygons   :List of 23 \cr
#'  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'  .. .. .. ..@ Polygons :List of 1 \cr
#'  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots \cr
#'  .. .. .. .. .. .. ..@ labpt  : num [1:2] 97715 87463 \cr
#'  .. .. .. .. .. .. ..@ area   : num 27853866 \cr
#'  .. .. .. .. .. .. ..@ hole   : logi FALSE \cr
#'  .. .. .. .. .. .. ..@ ringDir: int 1 \cr
#'  #'  .. .. .. .. .. .. ..@ coords : num [1:1611, 1:2] 96023 96027 96037 96070 96078 ... \cr
#'  .. .. .. ..@ plotOrder: int 1 \cr
#'  .. .. .. ..@ labpt    : num [1:2] 97715 87463 \cr
#'  .. .. .. ..@ ID       : chr "0" \cr
#'  .. .. .. ..@ area     : num 27853866 \cr
#'  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'  .. .. .. ..@ Polygons :List of 1 \cr
#'  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots \cr
#'  .. .. .. .. .. .. ..@ labpt  : num [1:2] 88254 64603 \cr
#'  .. .. .. .. .. .. ..@ area   : num 13591512 \cr
#'  .. .. .. .. .. .. ..@ hole   : logi FALSE \cr
#'  .. .. .. .. .. .. ..@ ringDir: int 1 \cr
#'  .. .. .. .. .. .. ..@ coords : num [1:1012, 1:2] 89679 89677 89674 89673 89673 ... \cr
#'  .. .. .. ..@ plotOrder: int 1 \cr
#'  .. .. .. ..@ labpt    : num [1:2] 88254 64603 \cr
#'  .. .. .. ..@ ID       : chr "1" \cr
#'  .. .. .. ..@ area     : num 13591512 \cr
#'  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'  .. .. .. ..@ Polygons :List of 1 \cr
#'  .. .. .. ..[list output truncated]
#'
#' @source \url{https://data.public.lu/fr/datasets/limites-administratives-du-grand-duche-de-luxembourg/}
#'
#' @examples
#' data(data_boundary_grevenmacher)
#' str(data_boundary_grevenmacher)
#'
#' #' plot stfdf object
#' plot(data_boundary_grevenmacher)
#'
#' @keywords data
NULL

#' A 'sp' object for the water surfaces in Grevenmacher
#'
#' A dataset containing a 'sp' object for the water surfaces in the District of Grevenmacher
#' in the Grand-Duchy of Luxembourg. The dataset contains streches from the Moselle (Mosel) and the S{\^u}re rivers.
#' The data is provided by the Luxembourgish Data Platform, and provided as a SpatialPolygonsDataFrame from "sp" package.
#'
#' @name data_water_surface
#' @docType data
#'
#' @usage data(data_water_surface)
#'
#' @details The spatial representation for the data corresponds to a SpatialPolygonsDataFrame with
#' coordinate reference system (CRS) EPSG:2169 - Luxembourg 1930 / Gauss - Projected.\cr
#'
#' The dataset identifies natural or artificial water surface, permanent or not. The field
#' NATURE is defined as:  0 = stream surface; 1 = stagnant water surface; 2 = wet zone; 3 = basin;
#' 4 = purification basin; 5 = pool; 6 = fish farming. \cr
#' The selection criteria for defining the NATURE field is: \cr
#' 0: surface of stream of permanent flow. Minimum width 3.5 m. \cr
#' 1: permanent water surface without flow: lake, pond, pond whose smallest dimension is greater than 20 m.
#' Dams are treated in this class and are updated if their area has increased 50\%. \cr
#' 2: wetland area greater than 2 Ha, marsh, aquatic vegetation. \cr
#' 3: open basin. Treatment plant basins, swimming pools or fish farms are treated with
#' a particular attribute value. Most small dimension must be greater than 10 m and the outline masonry. \cr
#' 4: sewage treatment plant basin, the smallest dimension of which must be greater than 10 m and the
#' masonry outline. \cr
#' 5: swimming pool whose smallest dimension must be greater than 10 m. \cr
#' 6: fish pond with the smallest dimension greater than 10 m and the masonry outline.
#'
#' @format Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots \cr
#'..@ data       :'data.frame':	1373 obs. of  5 variables: \cr
#'  .. ..$ cat     : int [1:1373] 1 2 3 4 5 6 7 8 9 10 ... \cr
#'  .. ..$ id      : int [1:1373] 1 1 1 1 1 1 1 1 1 1 ... \cr
#'  .. ..$ ID_2    : Factor w/ 1353 levels "2?443?282","2?443?944",..: 2 4 9 16 19 35 39 45 51 56 ... \cr
#'  .. ..$ NATURE  : int [1:1373] 3 3 3 3 3 3 3 3 3 3 ... \cr
#'  .. ..$ TOPONYME: Factor w/ 4 levels "Bassin d'?puration",..: NA NA NA NA NA NA NA NA NA NA ... \cr
#'  ..@ polygons   :List of 1373 \cr
#'  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'  .. .. .. ..@ Polygons :List of 1 \cr
#'  .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots \cr
#'  .. .. .. .. .. .. ..@ labpt  : num [1:2] 93462 66333 \cr
#'  .. .. .. .. .. .. ..@ area   : num 145 \cr
#'  .. .. .. .. .. .. ..@ hole   : logi FALSE \cr
#'  .. .. .. .. .. .. ..@ ringDir: int 1 \cr
#'  .. .. .. .. .. .. ..@ ringDir: int 1 \cr
#'  .. .. .. .. .. .. ..@ coords : num [1:11, 1:2] 93468 93468 93466 93464 93462 ... \cr
#'  .. .. .. ..@ plotOrder: int 1 \cr
#'  .. .. .. ..@ labpt    : num [1:2] 93462 66333 \cr
#'  .. .. .. ..@ ID       : chr "0" \cr
#'  .. .. .. ..@ area     : num 145 \cr
#'  .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'  .. .. .. ..@ Polygons :List of 1 \cr
#'  .. .. .. ..[list output truncated]
#'
#' @source \url{  https://data.public.lu/en/datasets/bd-l-tc-surface-deau/#_}
#'
#' @examples
#' data(data_water_surface)
#' str(data_water_surface, list.len = 15)
#'
#' #' plot stfdf object
#' library(sp)
#' spplot(data_water_surface, zcol="id", scales = list(draw = TRUE),
#'        colorkey = FALSE)
#'
#' @keywords data
NULL

#' A 'sp' object for the vineyards along the Mosel in Luxemburg in 2018

#'
#' A dataset containing a 'sp' object for the vineyards along the Mosel in the Grand-Duchy of Luxembourg in 2018.
#' The data is provided by the Luxembourgish Data Platform, and provided as a SpatialPolygonsDataFrame from "sp" package.
#'
#' @name data_vineyards2018
#' @docType data
#'
#' @usage data(data_vineyards2018)
#'
#' @details The spatial representation for the data corresponds to a SpatialPolygonsDataFrame with
#' coordinate reference system (CRS) EPSG:2169 - Luxembourg 1930 / Gauss - Projected. \cr
#'
#' @format Formal class 'SpatialPolygonsDataFrame' [package "sp"] with 5 slots \cr
#' ..@ data       :'data.frame':	4966 obs. of  7 variables: \cr
#'   .. ..$ Weinbergsn: Factor w/ 4950 levels "1","10005","10007",..: 1359 4035 3194 2950 2952 1083 2849 2871 2874 2951 ... \cr
#'   .. ..$ CODE_ELEM : Factor w/ 1 level "V": 1 1 1 1 1 1 1 1 1 1 ... \cr
#'   .. ..$ CODE_COM  : Factor w/ 14 levels "?","022","023",..: 12 4 14 6 12 12 14 14 14 14 ... \cr
#'   .. ..$ CODE_SECT : Factor w/ 8 levels "A","b","B","c",..: 1 7 8 7 3 3 7 7 7 7 ... \cr
#'   .. ..$ Shape_Leng: num [1:4966] 164 247 231 311 282 ... \cr
#'   .. ..$ Shape_Le_1: num [1:4966] 164 247 231 311 282 ... \cr
#'   .. ..$ Shape_Area: num [1:4966] 504 3773 3000 6016 2686 ... \cr
#'   ..@ polygons   :List of 4966 \cr
#'   .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'   .. .. .. ..@ Polygons :List of 1 \cr
#'   .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots \cr
#'   .. .. .. .. .. .. ..@ labpt  : num [1:2] 93823 71477 \cr
#'   .. .. .. .. .. .. ..@ area   : num 504 \cr
#'   .. .. .. .. .. .. ..@ hole   : logi FALSE \cr
#'   .. .. .. .. .. .. ..@ ringDir: int 1 \cr
#'   .. .. .. .. .. .. ..@ coords : num [1:6, 1:2] 93793 93797 93853 93851 93849 ... \cr
#'   .. .. .. ..@ plotOrder: int 1 \cr
#'   .. .. .. ..@ labpt    : num [1:2] 93823 71477 \cr
#'   .. .. .. ..@ ID       : chr "0" \cr
#'   .. .. .. ..@ area     : num 504 \cr
#'   .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'   .. .. .. ..@ Polygons :List of 1 \cr
#'   .. .. .. .. ..$ :Formal class 'Polygon' [package "sp"] with 5 slots \cr
#'   .. .. .. .. .. .. ..@ labpt  : num [1:2] 96817 77073 \cr
#'   .. .. .. .. .. .. ..@ area   : num 3773 \cr
#'   .. .. .. .. .. .. ..@ hole   : logi FALSE \cr
#'   .. .. .. .. .. .. ..@ ringDir: int 1 \cr
#'   .. .. .. .. .. .. ..@ coords : num [1:8, 1:2] 96857 96848 96839 96827 96777 ... \cr
#'   .. .. .. ..@ plotOrder: int 1 \cr
#'   .. .. .. ..@ labpt    : num [1:2] 96817 77073 \cr
#'   .. .. .. ..@ ID       : chr "1" \cr
#'   .. .. .. ..@ area     : num 3773 \cr
#'   .. ..$ :Formal class 'Polygons' [package "sp"] with 5 slots \cr
#'   .. .. .. ..@ Polygons :List of 1 \cr
#'   .. .. .. ..[list output truncated]
#'
#' @source \url{https://data.public.lu/fr/datasets/vineyards/}
#'
#' @examples
#' data(data_vineyards2018)
#' str(data_vineyards2018, list.len = 15)
#'
#' #' plot sp object
#' library(sp)
#' spplot(data_vineyards2018, zcol="Weinbergsn", col = "Brown", scales = list(draw = TRUE),
#'        colorkey = FALSE)
#'
#' @keywords data
NULL

#' Observed day of year (DOY) of stage BBCH-09 in Remich
#'
#' A sample dataset containing the Observed day of year (DOY) of stage BBCH-09 in Remich
#' for the period 1972 to 2019 from Molitor et al. (?).
#'
#' @name data_remich_bbch09
#' @docType data
#'
#' @usage data(data_remich_bbch09)
#'
#' @format 'data.frame':	48 obs. of  9 variables: \cr
#' $ Year     : int  1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 ... \cr
#' $ Elbling  : int  123 132 103 123 120 124 105 133 124 103 ... \cr
#' $ Rivaner  : int  124 133 104 123 122 124 107 133 126 104 ... \cr
#' $ Auxerrois: int  124 132 104 124 122 125 107 133 126 105 ... \cr
#' $ P.Blanc  : int  123 135 104 123 122 124 107 134 127 105 ... \cr
#' $ P.Gris   : int  123 134 104 124 122 124 106 134 126 106 ... \cr
#' $ Riesling : int  125 135 105 124 123 125 108 134 127 105 ... \cr
#' $ Gew.Tr.  : int  123 134 104 123 120 125 104 133 127 104 ... \cr
#' $ Average  : num  124 134 104 123 122 ...
#'
#' @references Daniel Molitor, ...
#' @keywords data
NULL



#' Observed day of year (DOY) of stage BBCH-81 in Remich
#'
#' A sample dataset containing the Observed day of year (DOY) of stage BBCH-81 in Remich
#' for the period 1972 to 2015 from Molitor et al. (?).
#'
#' @name data_remich_bbch81
#' @docType data
#'
#' @usage data(data_remich_bbch81)
#'
#' @format 'data.frame':	44 obs. of  9 variables: \cr
#' $ Year     : int  1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 ... \cr
#' $ Elbling  : int  268 247 254 242 233 NA NA NA NA NA ... \cr
#' $ Rivaner  : int  240 236 234 228 224 NA 246 NA 253 229 ... \cr
#' $ Auxerrois: int  244 237 246 232 227 NA NA NA NA NA ... \cr
#' $ P.Blanc  : int  249 246 249 242 232 NA NA NA NA NA ... \cr
#' $ P.Gris   : int  248 239 237 232 230 NA NA NA NA NA ... \cr
#' $ Riesling : int  266 242 252 241 232 NA NA NA NA NA ... \cr
#' $ Gew.Tr.  : int  249 236 249 236 228 NA NA NA NA NA ... \cr
#' $ Average  : num  252 240 246 236 229 ...
#'
#' @references Daniel Molitor, ...
#' @keywords data
NULL


#' Average dates of BBCH 09, 63, 68 and 81 for Rivaner in Remich
#'
#' A sample dataset containing the average dates of BBCH 09 (budbreak),
#' 63 (early bloom: 30\% of caps fallen), 68 (80\% of caps fallen) and 81
#' (beginning of ripening) in Luxembourg for the wine grape cultivars
#' Müller-Thurgau (Rivaner).
#' Data were arranged relative to 1 January (DOY) or relative to the date
#' of BBCH 68 (D68). Table 2 from Molitor ad Keller (2016).
#'
#' @name data_remich_rivaner_d68
#' @docType data
#'
#' @usage data(data_remich_rivaner_d68)
#'
#' @format 'data.frame':	23 obs. of  9 variables: \cr
#' $ Year       : int  1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 ... \cr
#' $ BBCH.09_DOY: int  116 118 120 119 115 120 117 117 126 113 ... \cr
#' $ BBCH.09_D68: int  -48 -58 -61 -61 -63 -54 -56 -49 -50 -58 ... \cr
#' $ BBCH.63_DOY: int  158 172 177 172 166 169 167 162 172 167 ... \cr
#' $ BBCH.63_D68: int  -6 -4 -4 -8 -12 -5 -6 -4 -4 -4 ... \cr
#' $ BBCH.68_DOY: int  164 176 181 180 178 174 173 166 176 171 ... \cr
#' $ BBCH.68_D68: int  0 0 0 0 0 0 0 0 0 0 ... \cr
#' $ BBCH.81_DOY: int  224 227 230 236 230 232 230 228 229 227 ... \cr
#' $ BBCH.81_D68: int  60 51 49 56 52 58 57 62 53 56 ... \cr
#'
#' @references Daniel Molitor, and Markus Keller. Yield of Müller-Thurgau
#' and Riesling grapevines is altered by meteorological conditions in the
#' current and previous growing seasons.
#' Vine and Wine Open Access Journal, Oneo One, 50(4):245-258, 2016.
#'
#' @source Institut Viti-vinicole, Remich.
#'
#' @keywords data
NULL


#' Average annual yield for Rivaner and Riesling, and meteorological variables in Remich
#'
#' Average annual yield (hl/ha) in Luxembourg for the wine grape cultivars
#' Müller-Thurgau and Riesling, as well as key annual and growing season
#' (April – October) meteorological variables (meteorological data from
#' Remich). Table 1 from Molitor ad Keller (2016).
#'
#' @name data_remich_yield
#' @docType data
#'
#' @usage data(data_remich_yield)
#'
#' @format 'data.frame':	23 obs. of  7 variables: \cr
#' $ Year                        : int  1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 ... \cr
#' $ Yield_MuellerThurgau_hl_ha  : int  137 147 130 118 49 142 162 109 122 140 ... \cr
#' $ Yield_Riesling_hl_ha        : int  96 94 77 78 64 102 110 95 72 98 ... \cr
#' $ Mean_annual_temp_C          : num  9.9 11.1 10.6 9 10.4 10.2 11.3 11.3 10.7 11.1 ... \cr
#' $ Mean_growing_season.temp_C  : num  14.4 14.9 15.3 13.9 14.7 14.6 15.3 15.3 15.3 15 ... \cr
#' $ Annual_precip_sum_mm        : int  737 741 816 534 785 790 732 948 994 776 ... \cr
#' $ Growing_season_precip_sum_mm: int  437 451 387 280 461 560 409 596 562 414 ... \cr
#'
#' @references Daniel Molitor, and Markus Keller. Yield of Müller-Thurgau
#' and Riesling grapevines is altered by meteorological conditions in the
#' current and previous growing seasons.
#' Vine and Wine Open Access Journal, Oneo One, 50(4):245-258, 2016.
#'
#' @keywords data
NULL
