#' Generate k groups of quantitative data with optional standardized effect
#'
#' @description
#' `generate_quantitative()` is a function to generate k groups of quantitative data with specified first four moments and optional standardized effect
#'
#' @param k A numeric vector for the number of groups to generate data for. The default value is 1.
#' @param mean A numeric vector for the population mean of the first variable. The default value is 0.
#' @param var A numeric vector for the population variance of the first variable. The default value is 1.
#' @param skew A numeric vector for the population skew of the variables. Separate values of skew can be entered. The default value is 0.
#' @param kurt A numeric vector for the population kurtosis of the variables. Separate values of kurtosis can be entered. The default value is 0.
#' @param n A numeric vector for the sample size. Separate values of n can be entered for an unbalanced design. The default value is 100.
#' @param effect_size An optional numeric vector for the standardized effect size between groups of data.
#' @param k_names An optional character vector for naming successes and failures. The default values are 1:k.
#' @param use_effect_size A logical vector to indicate whether to use a standardized effect size in generating data for k when k >= 2. The default value is FALSE.
#' @param summary A logical vector for whether the return should include summary statistics. The default value is TRUE.
#' @param decimals A numeric vector for the number of decimals to round the sample data to. The default value is 3.
#' @param seed A numeric vector for use in generating unbalanced distributions. The default value is 1234.
#' @param replication A numeric vector for the number of times to replicate the sampling. The default value is 1.
#'
#' @return If summary = TRUE, a list containing a matrix ("summary") of the input parameters and descriptive statistics and a data frame ("sample") with n rows and 2 columns. If summary = FALSE, a data frame with n rows and 2 columns.
#'
#' @examples
#' generate_quantitative()
#'
#' @examples
#' generate_quantitative(k = 2, effect_size = 0.3, use_effect_size = TRUE)
#'
#' @examples
#' generate_quantitative(k = 2, skew = c(0.4, 0.25))
#'
#' @examples
#' generate_quantitative(k = 3, n = c(100, 150, 200))
#'
#'
#' @export

generate_quantitative <- function(k = 1, mean = 0, var = 1, skew = 0, kurt = 0,
                                  n = 100, effect_size = 0, k_names = seq(1:k),
                                  use_effect_size = FALSE, summary = TRUE, decimals = 3,
                                  seed = 1234, replication = 1) {
  # Stop for missing/extraneous data

  if (length(k) > 1 | !(typeof(k) %in% c("double", "integer") | k != round(k))) {
    stop("Provide a single integer for number of k.")
  }

  if (!(typeof(mean) %in% c("double", "integer")) | !(typeof(var) %in% c("double", "integer")) |
    !(typeof(skew) %in% c("double", "integer")) | !(typeof(kurt) %in% c("double", "integer")) |
    !(typeof(effect_size) %in% c("double", "integer"))) {
    stop("Provide numeric parameters only.")
  }

  if (!(typeof(n) %in% c("double", "integer"))) {
    stop("Provide a numeric sample size.")
  }

  if (length(mean) != k & length(mean) != 1 & use_effect_size == FALSE) {
    stop("Make sure to provide a mean for each sample or one mean for all k.
         Alternative is to turn on effect sizes to calculate the means for each sample.")
  }

  if (length(mean) != k & length(mean) != 1 & use_effect_size == TRUE) {
    stop("Provide only the mean for the first sample.
         Alternative is to turn off effect sizes and provide means for each sample.")
  }

  if (length(var) != k & length(var) != 1) {
    stop("Make sure to provide a variance for each sample or one variance for all k.")
  }

  if (length(skew) != k & length(skew) != 1) {
    stop("Make sure to provide a skew for each sample or one skew for all k.")
  }

  if (length(kurt) != k & length(kurt) != 1) {
    stop("Make sure to provide a kurtosis for each sample or one kurtosis for all k.")
  }

  if (length(k_names) != k) {
    stop("Make sure to provide a group name for each sample.")
  }

  if (use_effect_size != FALSE & use_effect_size != TRUE) {
    stop("Indicate TRUE to use standardized effect sizes to calculate sample means.
         Indicate FALSE to use means provided for all k.")
  }

  if (summary != FALSE & summary != TRUE) {
    stop("Indicate TRUE to provide summary statistics for all k as part of output.
         Indicate FALSE to limit output to sample data.")
  }

  # Generate the data/stats

  output <- quantitative_output(k, n, mean, var, skew, kurt, effect_size,
                                use_effect_size, k_names, decimals,
                                seed, summary, replication)

  return(output)
}
