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
