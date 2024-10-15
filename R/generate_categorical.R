#' Generate samples of categorical data
#'
#' @description
#' generate_categorical() is function to generate k variables of sample categorical data with j groups.
#'
#' @param k A numeric vector for the number of variables. The default value is 1.
#' @param n A numeric vector for the sample size. The default value is 100.
#' @param groups A numeric vector for the number of groups within each variable. The default value is 1. If k>1, you can provide separate group numbers for each k.
#' @param group_prop A vector for the proportion of each group in the population. The default value is "equal". For unequal proportions, provide a concatenated vector the same length as the number of groups. If k>1, you can provide separate sets of proportions for each k.
#' @param group_names An optional character vector for naming successes and failures. The default values are 1:groups.
#' @param replication A numeric vector for the number of times to replicate the sampling. The default value is 1.
#'
#' @return A list containing a data frame ("sample") with n rows and k columns and a matrix ("proportion_summary") of the input and sample proportions for each group and variable.
#'
#' @examples
#' generate_categorical()
#'
#' @examples
#' generate_categorical(groups = 4)
#'
#' @examples
#' generate_categorical(groups = 4, group_names = c("freshman", "sophomore", "junior", "senior"))
#'
#'
#' @examples
#' generate_categorical(groups = 4, group_prop = c(0.25, 0.5, 0.1, 0.15))
#'
#' @examples
#' generate_categorical(k = 2, groups = c(2, 3), group_prop = c(0.3, 0.7, 0.2, 0.2, 0.6))
#'
#' @examples
#' generate_categorical(k = 2, groups = 2, group_prop = c(0.3, 0.7))
#'
#' @export

generate_categorical <- function(k = 1, n = 100, groups = 1, group_prop = "equal",
                                 group_names = "default", replication = 1) {
  if (sum(groups == 0) > 0) {
    stop("The number of groups must be greater than 0.")
  }

  if (length(groups) != k & length(groups) != 1) {
    stop("The number of groups must align with the number of samples.")
  }

  if (n == 0) {
    stop("The sample size must be greater than 0.")
  }

  if (length(n) != k & length(n) != 1) {
    stop("The number of sample sizes must align with the number of samples.")
  }

  if (k == 0) {
    stop("The number of samples must be greater than 0.")
  }

  if (length(group_names) != sum(groups) & length(group_names) != 1) {
    stop("Please ensure there is a name for every group.")
  }

  # replicating any input variables that need replicating

  sample_group_rep <- sample_group_rep(groups, k)

  sample_n_rep <- sample_n(n, k)

  sample_rep <- seq(1:k)

  # setting up group names for all samples

  sample_group_names <- cat_group_names(group_names, sample_group_rep, groups, k)

  # setting up group proportions

  sample_group_prop <- cat_group_prop_division(group_prop, groups, k)

  if (sum(sample_group_prop, na.rm = TRUE) / k != 1 &
    !(length(group_prop) == 1 & length(groups) == 1)) {
    stop("The proportions in each sample need to sum to 1.")
  }

  # setting up for loop

  output <- categorical_loop(
    sample_rep, sample_group_rep, sample_n_rep,
    sample_group_prop, sample_group_names, groups, k,
    replication
  )

  return(output)
}
