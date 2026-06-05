#' Generate samples of binary data
#'
#' @description
#' `generate_binary()` is function to generate sample binary data.
#'
#' @param p A positive integer for the number of variables. The default value is 1.
#' @param n A positive integer for the sample size. The default value is 100.
#' @param prop A numeric vector for the proportion of successes. The default value is 0.5. If p > 1, you can provide separate proportion values for each p.
#' @param group_names An optional character or numeric vector for naming successes and failures. The default values are 1 for success and 0 for failure.
#' @param output_type A character vector for output type. The options are "character" or "numeric." If p > 1, you can provide separate output types for each p.
#' @param summary A logical scalar for whether the return should include summary statistics. The default value is TRUE.
#' @param replication A positive integer for the number of times to replicate the sampling. The default value is 1.
#'
#' @return If summary = TRUE, a list containing
#' * `sample`, a data frame with n rows and k columns
#' * `summary`, a matrix of the sample size, number of successes, proportion statistic, and proportion parameter for each variable, and
#' * `freq.table`, a matrix of the frequencies of successes and failures for each variable
#'
#' If summary = FALSE, a data frame with n rows and p columns.
#'
#' The output type can be changed depending on one's need. Each column will return as a factor or as numeric values depending on argument selection.
#'
#' @details
#' This function generates samples of binary data based on specified proportions. It can generate a single column or multiple columns of data with different proportions specified for each. The data is sampled from the specified proportions as a parameter, so the output statistics will not be an exact match to the parameters.
#'
#' Because the output is a sample, the summary argument allows for summary statistics to be generated with the sample data. This allows the user to easily compare the simulation statistics to the specified parameters.
#'
#' This is useful for introducing students to the basics of probability, proportion tests, and chi square tests without having to call two (or more) separate `rbinom()` functions. If you are interested in using binary data for sample student test responses, consider using `generate_2PL()`, which simulates binary response data based on specified difficulty and discrimination parameters.
#'
#'
#' @examples
#' generate_binary()
#'
#' @examples
#' generate_binary(output_type = "numeric")
#'
#' @examples
#' generate_binary(p = 2, prop = c(0.5, 0.7))
#'
#' @examples
#' generate_binary(group_names = c("success", "fail"))
#'
#' @export

generate_binary <- function(p = 1, n = 100, prop = 0.5, group_names = c(1:0),
                            output_type = "factor",
                            summary = TRUE, replication = 1) {
  if (any(n == 0)) {
    stop("The total sample size must be greater than 0.")
  }

  if (p == 0) {
    stop("The number of variables must be greater than 0.")
  }

  if (p > 1 & length(prop) != 1 & length(prop) != p) {
    stop("The number of success proportions must be equal to the number of samples.")
  }

  if (p > 1 & length(n) != 1 & length(n) != p) {
    stop("The number of sample sizes must be equal to the number of samples.")
  }

  if (length(group_names) != 2 & length(group_names) != 2 * p) {
    stop("Please ensure there are labels for both successes and failures.")
  }

  sample_prop <- sample_proportion(prop, p)

  sample_n <- sample_n(n, p)

  sample_names <- sample_names(group_names, p)

  sample_types <- sample_types(output_type, p)

  sample_rep <- seq(1:p)

  output <- binary_output(
    sample_rep, sample_n, sample_prop, sample_names, sample_types, p,
    summary, replication
  )

  return(output)
}
