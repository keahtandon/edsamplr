#' @export

generate_quantitative <- function(samples = 1, mean = 0, var = 1, skew = 0, kurt = 0,
                                  n = 100, effect_size = 0, group_names = seq(1:samples),
                                  use_effect_size = FALSE, summary = TRUE, decimals = 3,
                                  replication = 1) {
  # Stop for missing/extraneous data

  if (length(samples) > 1 | !(typeof(samples) %in% c("double", "integer") | samples != round(samples))) {
    stop("Provide a single integer for number of samples.")
  }

  if (!(typeof(mean) %in% c("double", "integer")) | !(typeof(var) %in% c("double", "integer")) |
    !(typeof(skew) %in% c("double", "integer")) | !(typeof(kurt) %in% c("double", "integer")) |
    !(typeof(effect_size) %in% c("double", "integer"))) {
    stop("Provide numeric parameters only.")
  }

  if (!(typeof(n) %in% c("double", "integer"))) {
    stop("Provide a numeric sample size.")
  }

  if (length(mean) != samples & length(mean) != 1 & use_effect_size == FALSE) {
    stop("Make sure to provide a mean for each sample or one mean for all samples.
         Alternative is to turn on effect sizes to calculate the means for each sample.")
  }

  if (length(mean) != samples & length(mean) != 1 & use_effect_size == TRUE) {
    stop("Provide only the mean for the first sample.
         Alternative is to turn off effect sizes and provide means for each sample.")
  }

  if (length(var) != samples & length(var) != 1) {
    stop("Make sure to provide a variance for each sample or one variance for all samples.")
  }

  if (length(skew) != samples & length(skew) != 1) {
    stop("Make sure to provide a skew for each sample or one skew for all samples.")
  }

  if (length(kurt) != samples & length(kurt) != 1) {
    stop("Make sure to provide a kurtosis for each sample or one kurtosis for all samples.")
  }

  if (length(group_names) != samples) {
    stop("Make sure to provide a group name for each sample.")
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
    output <- quant_with_summary(
      samples, n, mean, var, skew, kurt,
      effect_size, use_effect_size, group_names, decimals,
      replication
    )
  } else {
    output <- quant_no_summary(
      samples, n, mean, var, skew, kurt,
      effect_size, use_effect_size, group_names, decimals,
      replication
    )
  }

  return(output)
}
