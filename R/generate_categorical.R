#' Generate samples of categorical data
#'
#' @description
#' `generate_categorical()` is function to generate n variables of sample categorical data with k groups.
#'
#' @param p A numeric vector for the number of variables. The default value is 1.
#' @param n A numeric vector for the sample size. The default value is 100.
#' @param k A numeric vector for the number of groups within each variable. The default value is 1. If p>1, you can provide separate group numbers for each p.
#' @param k_prop A vector for the proportion of each group in the population. The default value is "equal". For unequal proportions, provide a concatenated vector the same length as the number of groups (k). If p>1, you can provide separate sets of proportions for each p.
#' @param k_names An optional character vector for naming successes and failures. The default values are 1:k.
#' @param replication A numeric vector for the number of times to replicate the sampling. The default value is 1.
#'
#' @return A list containing a data frame ("sample") with n rows and p columns and a matrix ("proportion_summary") of the input and sample proportions for each group and variable.
#'
#' @examples
#' generate_categorical()
#'
#' @examples
#' generate_categorical(k = 4)
#'
#' @examples
#' generate_categorical(k = 4, k_names = c("freshman", "sophomore", "junior", "senior"))
#'
#' @examples
#' generate_categorical(k = 4, k_prop = c(0.25, 0.5, 0.1, 0.15))
#'
#' @examples
#' generate_categorical(p = 2, k = c(2, 3), k_prop = c(0.3, 0.7, 0.2, 0.2, 0.6))
#'
#' @examples
#' generate_categorical(p = 2, k = 2, k_prop = c(0.3, 0.7))
#'
#' @export

generate_categorical <- function(p = 1, n = 100, k = 1, k_prop = "equal",
                                 k_names = "default", replication = 1) {
  if (sum(k == 0) > 0) {
    stop("The number of groups must be greater than 0.")
  }

  if (length(k) != p & length(k) != 1) {
    stop("The number of groups must align with the number of samples.")
  }

  if (n == 0) {
    stop("The sample size must be greater than 0.")
  }

  if (length(n) != p & length(n) != 1) {
    stop("The number of sample sizes must align with the number of samples.")
  }

  if (p == 0) {
    stop("The number of samples must be greater than 0.")
  }

  if (length(k_names) != sum(k) & length(k_names) != 1) {
    stop("Please ensure there is a name for every group.")
  }

  # replicating any input variables that need replicating

  sample_group_rep <- sample_group_rep(k, p)

  sample_n_rep <- sample_n(n, p)

  sample_rep <- seq(1:p)

  # setting up group names for all samples

  sample_group_names <- cat_group_names(k_names, sample_group_rep, k, p)

  # setting up group proportions

  sample_group_prop <- cat_group_prop_division(k_prop, k, p)

  if (sum(sample_group_prop, na.rm = TRUE) / p != 1 &
    !(length(k_prop) == 1 & length(k) == 1)) {
    stop("The proportions in each sample need to sum to 1.")
  }

  # setting up for loop

  output <- categorical_loop(
    sample_rep, sample_group_rep, sample_n_rep,
    sample_group_prop, sample_group_names, k, p,
    replication
  )

  return(output)
}
