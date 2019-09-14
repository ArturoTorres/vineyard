#' Compute the degree-days by the single triangle algorithm
#'
#' @param x xts object containing the input data
#' @param t.min daily minimum air temperature
#' @param t.max daily maximum air temperature
#' @param t.zero threshold temperature for vine growth
#'
#' @return a vector with the degree-days for vine growth
#'
#' @importFrom xts xts

DD.single.triang <- function(t.zero, t.min, t.mean, t.max){
  if(t.zero >= t.max){
    dd <- 0
  } else if((t.zero > t.min) && (t.zero < t.max)){
    dd <- ((t.max - t.zero)/2)*((t.max - t.zero)/(t.max - t.min))
  }else if(t.zero <= t.min){
    dd <- t.mean - t.zero
  }
  return(dd)
}


