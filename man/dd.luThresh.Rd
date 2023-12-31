% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Phenology.R
\name{dd.luThresh}
\alias{dd.luThresh}
\title{Compute the degree days by the double (lower and upper) temperature thresholds}
\usage{
dd.luThresh(t.mean, a, b)
}
\arguments{
\item{t.mean}{vector, daily mean air temperature in Celsius degrees.}

\item{a}{numeric, lower threshold temperature (in Celsius degrees) for vine growth.}

\item{b}{numeric, upper threshold temperature (in Celsius degrees) for vine growth.}
}
\value{
a vector with the degree days (in Celsius degrees) for vine growth.
}
\description{
Implementation to compute the degree days by the double (lower and upper) temperature thresholds by Molitor et al., (2014).
}
\references{
Daniel Molitor, Jürgen Junk, Danièle Evers, Lucien Hoffmann, and Marco Beyer (2014).
A high-resolution cumulative degree day-based model to simulate phenological development of grapevine.
Am. J. Enol. Vitic., (65:1):72–80.
}
