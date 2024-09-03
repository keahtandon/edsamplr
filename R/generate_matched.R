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
