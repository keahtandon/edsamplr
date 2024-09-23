#' Generate samples of binary data
#'
#' @description
#' generate_binary() is function to generate sample binary data.
#'
#' @param k A numeric vector for the number of number of samples. The default value is 1.
#' @param n A numeric vector for the sample size. The default value is 100.
#' @param p A numeric vector for the proportion of successes. The default value is 0.5. If k>1, you can provide separate proportion values for each k.
#' @param group_names An optional character vector for naming successes and failures. The default values are 1 for success and 0 for failure.
#' @param replication A numeric vector for the number of times to replicate the sampling. The default value is 1.
#'
#' @return xx
#'
#' @examples
#' # example code
#'




#' @export

generate_binary <- function(k = 1, n = 100, p = 0.5, group_names = c(1:0),
                            replication = 1) {
  if (any(n == 0)) {
    stop("The total sample size must be greater than 0.")
  }

  if (k == 0) {
    stop("The number of samples must be greater than 0.")
  }

  if (k > 1 & length(p) != 1 & length(p) != k) {
    stop("The number of success proportions must be equal to the number of samples.")
  }

  if (k > 1 & length(n) != 1 & length(n) != k) {
    stop("The number of sample sizes must be equal to the number of samples.")
  }

  if (length(group_names) != 2 & length(group_names) != 2 * k) {
    stop("Please ensure there are labels for both successes and failures.")
  }

  sample_p <- sample_proportion(p, k)

  sample_n <- sample_n(n, k)

  sample_names <- sample_names(group_names, k)

  sample_rep <- seq(1:k)

  output <- proportions_loop(
    sample_rep, sample_n, sample_p, sample_names, k,
    replication
  )

  return(output)
}
