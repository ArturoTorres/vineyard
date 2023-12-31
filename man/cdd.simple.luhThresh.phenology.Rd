% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Phenology.R
\name{cdd.simple.luhThresh.phenology}
\alias{cdd.simple.luhThresh.phenology}
\title{Cumulative degree days (CDD) by the simple algorithm and lower, upper and heat temperature thresholds for phenology}
\usage{
cdd.simple.luhThresh.phenology(cdd.bb, cdd.luht, chs.mean)
}
\arguments{
\item{cdd.bb}{cumulative degree days (CDD) by the
simple algorithm for bud break in xts format as provided by "cdd.simple.budbreak" function.}

\item{cdd.luht}{cumulative degree days (in Celsius degrees) for vine growth in xts format as provided by
"cdd.luhThresh" function.}

\item{chs.mean}{numeric, mean cumulative heat sum for bud break (in Celsius degrees).}
}
\value{
the cumulative degree days (in Celsius degrees) for vine growth plus an additional column with
the cumulative degree days (in Celsius degrees) for phenology.
}
\description{
Implementation to compute the cumulative degree days by the simple algorithm and the lower, upper and heat temperature thresholds by
Molitor et al. (2014) for phenology.
}
\references{
Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
Am. J. Enol. Vitic., (65:1):72–80.
}
