#' @export

# This function generates a data frame with a single categorical variable.
# If you do not want an equal proportion in each group, then provide a concatenation of desired proportions
# If you want to name your groups, then provide a concatenation of desired names

# If you do not want the samples to be the same, then provide a concatenation of desired properties

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
