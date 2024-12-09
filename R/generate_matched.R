#' Generate samples of quantitative matched pair data with correlation and optional standardized effect
#'
#' @description
#' `generate_matched()` is a function to generate samples of quantitative matched pair data with specified first four moments, correlation, and optional standardized effect size
#' @param n A numeric vector for the sample size. The default value is 100.
#' @param mean A numeric vector for the population mean of the first variable. The default value is 0.
#' @param var A numeric vector for the population variance of the first variable. The default value is 1.
#' @param skew A numeric vector for the population skew of the variables. Separate values of skew can be entered. The default value is 0.
#' @param kurt A numeric vector for the population kurtosis of the variables. Separate values of kurtosis can be entered. The default value is 0.
#' @param effect_size An optional numeric vector for the standardized effect size between groups of data.
#' @param r A numeric vector for the correlation between the variables. The default value is 0.5.
#' @param use_effect_size A logical vector to indicate whether to use a standardized effect size in generating data for k when k >= 2. The default value is FALSE.
#' @param summary A logical vector for whether the return should include summary statistics. The default value is TRUE.
#' @param decimals A numeric vector for the number of decimals to round the sample data to. The default value is 3.
#' @param replication A numeric vector for the number of times to replicate the sampling. The default value is 1.
#'
#'  @return If summary = TRUE, a list containing a vector ("correlation") with the correlation between the pairs, a matrix ("summary") of the input parameters and descriptive statistics, and a data frame ("sample") with n rows and 3 columns (values from each set of the pair and the difference of X2 and X1). If summary = FALSE, a data frame with n rows and 3 columns.
#'
#' @examples
#' generate_matched()
#'
#' @examples
#' generate_matched(use_effect_size = FALSE)
#'
#' @examples
#' generate_matched(skew = c(0.4, 0.25))#'
#'
#' @export

generate_matched <- function(n = 100, mean = 0, var = 1, skew = 0, kurt = 0,
                             effect_size = 0.5, r = 0.5, use_effect_size = TRUE,
                             summary = TRUE, decimals = 3, replication = 1) {
  if (!(typeof(mean) %in% c("double", "integer")) | !(typeof(var) %in% c("double", "integer")) |
    !(typeof(skew) %in% c("double", "integer")) | !(typeof(kurt) %in% c("double", "integer")) |
    !(typeof(effect_size) %in% c("double", "integer"))) {
    stop("Provide numeric parameters only.")
  }

  if (!(typeof(n) %in% c("double", "integer"))) {
    stop("Provide a numeric sample size.")
  }

  if (use_effect_size != FALSE & use_effect_size != TRUE) {
    stop("Indicate TRUE to use standardized effect sizes to calculate sample means.
         Indicate FALSE to use means provided for all samples.")
  }

  if (summary != FALSE & summary != TRUE) {
    stop("Indicate TRUE to provide summary statistics for all samples as part of output.
         Indicate FALSE to limit output to sample data.")
  }

  # Generate the data/stats

  if (summary == TRUE) {
    output <- matched_with_summary(
      n, mean, var, skew, kurt,
      effect_size, r, use_effect_size, decimals,
      replication
    )
  } else {
    output <- matched_no_summary(
      n, mean, var, skew, kurt,
      effect_size, r, use_effect_size, decimals,
      replication
    )
  }

  return(output)
}
