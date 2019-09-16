#' Compute the degree-days by the single triangle algorithm
#'
#' Implementation to compute the degree-days by the single triangle algorithm by Nendel (2010).
#'
#' @param t.min daily minimum air temperature vector in Celsius degrees.
#' @param t.max daily maximum air temperature vector in Celsius degrees.
#' @param t.zero numeric, threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree-days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Nendel, Class (2010). Grapevine bud break prediction for cool winter climates. Int. J. Biometeorol., 54, 231–241.

DD.single.triangle <- function(t.zero, t.min, t.mean, t.max){
  if(t.zero >= t.max){
    dd <- 0
  } else if((t.zero > t.min) && (t.zero < t.max)){
    dd <- ((t.max - t.zero)/2)*((t.max - t.zero)/(t.max - t.min))
  }else if(t.zero <= t.min){
    dd <- t.mean - t.zero
  }
  return(dd)
}


#' Compute the degree-days by the single temperature threshold
#'
#' Implementation to compute the degree-days by the single temperature threshold by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree-days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer.
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80, 2014.

DD.single.threshold <- function(t.mean, a){
  if(t.mean < a){
    dd <- 0
  } else if(a < t.mean){
    dd <- (t.mean - a)
  }
  return(dd)
}


#' Compute the degree-days by the lower and upper temperature thresholds
#'
#' Implementation to compute the degree-days by the lower and upper temperature thresholds by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, lower threshold temperature (in Celsius degrees) for vine growth.
#' @param b numeric, upper threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree-days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer.
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80, 2014.

DD.double.threshold <- function(t.mean, a, b){
  if(t.mean < a){
    dd <- 0
  } else if((a < t.mean) && (t.mean < b)){
    dd <- (t.mean - a)
  } else if(b < t.mean){
    dd <- (b - a)
  }
  return(dd)
}


#' Compute the degree-days by a heat threshold temperature
#'
#' Implementation to compute the degree-days by a heat threshold temperature by Molitor et al., (2014).
#'
#' @param t.mean daily mean air temperature vector in Celsius degrees.
#' @param a numeric, lower threshold temperature (in Celsius degrees) for vine growth.
#' @param b numeric, upper threshold temperature (in Celsius degrees) for vine growth.
#' @param c numeric, heat threshold temperature (in Celsius degrees) for vine growth.
#'
#' @return a vector with the degree-days (in Celsius degrees) for vine growth.
#'
#' @importFrom xts xts
#'
#' @references Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer.
#' A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
#' Am. J. Enol. Vitic., (65:1):72–80, 2014.

DD.heat.threshold <- function(t.mean, a, b, c){
  if((t.mean < a) || (c + (b - a) < t.mean)){
    dd <- 0
  } else if((a < t.mean) && (t.mean < b)){
    dd <- (t.mean - a)
  } else if(b < t.mean){
    dd <- (b - a)
  } else if(c < t.mean) {
    dd <- (b - a) - (t.mean - c)
  }
  return(dd)
}
