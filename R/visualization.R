#' @title Display evolution of predicted mortality rate
#'
#' @description
#' Useful function for creating a good-quality line graph
#' of changes in the predicted mortality rate.
#'
#' If you want more control over the style of the graph,
#' use the [pred_mortality_rate()] function to retrieve data.
#'
#' @name plot_mortality_rate
#'
#' @inheritParams lifelihood
#' @inheritParams pred_mortality_rate
#' @inheritParams plot_mortality_rate
#' @inheritParams prediction
#' @inheritParams validate_groupby_arg
#'
#' @details This function requires [ggplot2](https://ggplot2.tidyverse.org/) to be installed.
#'
#' @return a ggplot2 plot
#'
#' @export
plot_fitted_mortality_rate <- function(
  lifelihoodResults,
  interval_width,
  newdata = NULL,
  max_time = NULL,
  groupby = NULL,
  log_x = FALSE,
  log_y = FALSE,
  title = "Mortality rate over time",
  xlab = "Time",
  ylab = "Mortality Rate"
) {
  groupby <- validate_groupby_arg(lifelihoodResults$lifelihoodData, groupby)

  rate_df <- pred_mortality_rate(
    lifelihoodResults,
    interval_width,
    newdata = newdata,
    max_time = max_time,
    groupby = groupby
  )

  plot_mortality_rate(
    rate_df,
    max_time,
    groupby,
    log_x,
    log_y,
    title,
    xlab,
    ylab
  )
}

#' @title Display evolution of empirical mortality rate
#'
#' @description
#' Useful function for creating a good-quality line graph
#' of changes in the empirical mortality rate.
#'
#' You don't need to fit with [lifelihood()] to use this
#' function, only to retrieve a lifelihood data object
#' with [lifelihoodData()]
#'
#' If you want more control over the style of the graph,
#' use the [mortality_rate()] function to retrieve data.
#'
#' @name plot_mortality_rate
#'
#' @inheritParams lifelihood
#' @inheritParams mortality_rate
#' @inheritParams plot_mortality_rate
#' @inheritParams validate_groupby_arg
#'
#' @details This function requires [ggplot2](https://ggplot2.tidyverse.org/) to be installed.
#'
#' @return a ggplot2 plot
#'
#' @export
plot_observed_mortality_rate <- function(
  lifelihoodData,
  interval_width,
  max_time = NULL,
  groupby = NULL,
  log_x = FALSE,
  log_y = FALSE,
  title = "Mortality rate over time",
  xlab = "Time",
  ylab = "Mortality Rate"
) {
  groupby <- validate_groupby_arg(lifelihoodData, groupby)

  rate_df <- mortality_rate(
    lifelihoodData,
    interval_width,
    max_time = max_time,
    groupby = groupby
  )

  plot_mortality_rate(
    rate_df,
    max_time,
    groupby,
    log_x,
    log_y,
    title,
    xlab,
    ylab
  )
}

#' @title Plot mortality rate
#'
#' @description
#' Convenient function used in [plot_observed_mortality_rate()]
#' and [plot_fitted_mortality_rate()].
#'
#' @inheritParams mortality_rate
#' @inheritParams validate_groupby_arg
#' @param rate_df Dataframe with mortality rate, obtained via [mortality_rate()]
#' @param log_x Determine whether the x-axis should be displayed on a logarithmic scale
#' @param log_y Determine whether the y-axis should be displayed on a logarithmic scale
#'
#' @return a ggplot2 plot
#'
#' @keywords internal
plot_mortality_rate <- function(
  rate_df,
  max_time,
  groupby,
  log_x,
  log_y,
  title,
  xlab,
  ylab
) {
  if (!is.null(groupby)) {
    plot <- ggplot2::ggplot(
      rate_df,
      ggplot2::aes(
        x = as.numeric(as.character(Interval)),
        y = MortalityRate,
        color = Group
      )
    )
  } else {
    plot <- ggplot2::ggplot(
      rate_df,
      ggplot2::aes(x = as.numeric(as.character(Interval)), y = MortalityRate)
    )
  }

  plot <- plot +
    ggplot2::geom_line() +
    ggplot2::labs(
      title = title,
      x = xlab,
      y = ylab
    ) +
    ggplot2::theme_minimal()

  if (!is.null(max_time) & !log_x) {
    plot <- plot + ggplot2::xlim(0, max_time)
  }

  if (log_x) {
    plot <- plot + ggplot2::scale_x_log10()
  }
  if (log_y) {
    plot <- plot + ggplot2::scale_y_log10()
  }

  plot
}
