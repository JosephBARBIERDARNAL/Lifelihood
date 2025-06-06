% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lifelihood.R
\name{AICc.lifelihoodResults}
\alias{AICc.lifelihoodResults}
\title{Akaike information criterion for small sample size}
\usage{
AICc.lifelihoodResults(object, ..., k = length(coeff(object)))
}
\arguments{
\item{object}{output of \code{\link[=lifelihood]{lifelihood()}}}

\item{...}{Ignored}

\item{k}{Number of estimated parameter of the modèle. Default to \code{length(coef(object))}}
}
\value{
The AICc
}
\description{
S3 method to compute AICc (Akaike information criterion
corrected for small sample size, see Hurvich and Tsai 1989).
}
\seealso{
\code{\link{AIC}}
}
