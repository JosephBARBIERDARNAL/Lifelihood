#' @title Check if estimation are too close from boundaries.
#'
#' @description
#' Since the parameter boundaries are from [default_bounds_df()]
#' (or customized by user), this function checks is the estimation
#' of each parameter is "too close" (0.5% tolerance) from one of
#' its boundaries (either min or max). If so, it raises a warning
#' that tries to be explicit. This function can be ignored thanks
#' to the `raise_estimation_warning` argument (boolean) in
#' [lifelihood()].
#'
#' @param lifelihoodResults Output object of the [lifelihood()] function.
#'
#' @keywords internal
#'
#' @export
check_valid_estimation <- function(lifelihoodResults) {
  estimations <- lifelihoodResults$effects
  boundaries <- lifelihoodResults$parameter_ranges
  parameter_names <- unique(estimations$parameter)
  for (parameter_name in parameter_names) {
    parameter_values <- subset(estimations, parameter == parameter_name)
    parameter_bounds <- subset(boundaries, name == parameter_name)
    min_bound <- parameter_bounds$min
    max_bound <- parameter_bounds$max
    sum_estimations <- sum(parameter_values$estimation)
    sum_estimations_linked <- link(
      sum_estimations,
      min = min_bound,
      max = max_bound
    )

    tolerance <- 0.005 # 0.5% tolerance
    min_threshold <- min_bound + (min_bound * tolerance)
    max_threshold <- max_bound - (max_bound * tolerance)
    if (sum_estimations_linked <= min_threshold) {
      warning(paste(
        "Estimation of '",
        parameter_name,
        "' is close to the minimum bound: ",
        parameter_name,
        "~=",
        sum_estimations_linked,
        ". ",
        "Consider decreasing minimum bound.",
        sep = ""
      ))
    } else if (sum_estimations_linked >= max_threshold) {
      warning(paste(
        "Estimation of '",
        parameter_name,
        "' is close to the maximum bound: ",
        parameter_name,
        "~=",
        sum_estimations_linked,
        ". ",
        "Consider increasing maximum bound.",
        sep = ""
      ))
    }
  }
}
