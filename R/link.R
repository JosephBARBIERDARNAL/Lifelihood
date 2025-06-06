#' @title Link function
#'
#' @description
#' Link function to transform the parameters from the
#' lifelihood scale to the original scale
#'
#' @keywords internal
#'
#' @param estimate The estimate of the parameter
#' @param min The minimum value of the parameter
#' @param max The maximum value of the parameter
#'
#' @return The transformed parameter
link <- function(estimate, min, max) {
  return(min + (max - min) / (1 + exp(-estimate)))
}

#' @title Delink function
#'
#' @description
#' Delink function to transform the parameters from original scale
#' to lifelihood scale.
#'
#' @keywords internal
#'
#' @param obs The observed value of the parameter
#' @param min The minimum value of the parameter
#' @param max The maximum value of the parameter
#'
#' @return Numeric. The transformed parameter
delink <- function(obs, min, max) {
  return(log((obs - min) / (max - obs)))
}

#' @title derivLink function
#'
#' @description
#' Derivative of the link function used to transform the parameters from
#' lifelihood scale to original scale.
#'
#' @keywords internal
#'
#' @param estimate The estimate of the parameter
#' @param min The minimum value of the parameter
#' @param max The maximum value of the parameter
#'
#' @return Numeric. Derivative of the link function at parameter estimate
derivLink <- function(estimate, min, max) {
  numerator <- (max - min) * exp(-estimate)
  denominator <- (1 + exp(-estimate))^2

  return(numerator / denominator)
}
