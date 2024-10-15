#' Generate samples of correlated quantitative data
#'
#' @description
#' generate_correlated() is a function to generate samples of correlated quantitative data with specified first four moments and specified slope.
#'
#' @param n A numeric vector for the sample size. The default value is 100.
#' @param mean A numeric vector for the population mean of the first variable. The default value is 0.
#' @param var A numeric vector for the population variance of the first variable. The default value is 1.
#' @param skew A numeric vector for the population skew of the variables. Separate values of skew can be entered. The default value is 0.
#' @param kurt A numeric vector for the population kurtosis of the variables. Separate values of kurtosis can be entered. The default value is 0.
#' @param slope A numeric vector for the slope of the regression line. The default value is 0.
#' @param r A numeric vector for the correlation between the variables. The default value is 0.5
#' @param summary A logical vector for whether the return should include summary statistics. The default value is TRUE.
#' @param decimals A numeric vector for the number of decimals to round the sample data to. The default value is 3.
#' @param replication A numeric vector for the number of times to replicate the sampling. The default value is 1.
#'
#' @return
#' If summary=TRUE, a list containing the correlation of the sample, the slope of the sample, a data frame ("sample") with n rows and 2 columns, and a matrix ("summary") of the input parameters and descriptive statistics. If summary=FALSE, a data frame with n rows and 2 columns.
#'
#' @examples
#' generate_correlated()
#'
#' @examples
#' generate_correlated(skew = c(0.4, 0.25))
#'
#' @examples
#' generate_correlated(slope = 3, r = 0.8)
#'
#' @examples
#' generate_correlated(n = 10000, skew = c(0, 1), kurt = c(0, 1.5))
#'
#' @export

generate_correlated <- function(n = 100, mean = 0, var = 1, skew = 0, kurt = 0,
                                slope = 1, r = 0.5, summary = TRUE, decimals = 3,
                                replication = 1) {
  if (!(typeof(mean) %in% c("double", "integer")) | !(typeof(var) %in% c("double", "integer")) |
    !(typeof(skew) %in% c("double", "integer")) | !(typeof(kurt) %in% c("double", "integer"))) {
    stop("Provide numeric parameters only.")
  }

  if (!(typeof(n) %in% c("double", "integer"))) {
    stop("Provide a numeric sample size.")
  }

  if (summary != FALSE & summary != TRUE) {
    stop("Indicate TRUE to provide summary statistics for all samples as part of output.
         Indicate FALSE to limit output to sample data.")
  }

  # Generate the data/stats

  if (summary == TRUE) {
    output <- slope_with_summary(
      k = 2, n, mean, var, skew,
      kurt, slope, r, decimals, replication
    )
  } else {
    output <- slope_no_summary(
      k = 2, n, mean, var, skew,
      kurt, slope, r, decimals, replication
    )
  }

  return(output)
}
