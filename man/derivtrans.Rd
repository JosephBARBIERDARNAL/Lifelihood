% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/derivtrans.R
\name{derivtrans}
\alias{derivtrans}
\title{Derivtrans function}
\usage{
derivtrans(estimate, min, max)
}
\arguments{
\item{estimate}{Numeric. The estimate of the parameter}

\item{min}{The minimum value of the parameter}

\item{max}{The maximum value of the parameter}
}
\value{
Numeric. Derivative of the link function at parameter estimate
}
\description{
Derivative of the link function used to transform the parameters from lifelihood scale to original scale.
}
\keyword{internal}
