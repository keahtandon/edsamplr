#' Generate samples of 2PL data
#'
#' @description
#' `generate_2PL()` is a function to generate i items of sample dichotomous response data for n students.
#'
#' @param difficulty A numeric vector of difficulty values for the items. A difficulty value should be provided for each item.
#' @param discrimination A numeric vector of discrimination values for the items. A discrimination value should be provided for each item.
#' @param n A numeric vector for the sample size.
#' @param identify_groups A logical vector for whether students should be grouped into low, medium, and high achievement based on their simulated responses.
#' @param group_pct A numeric vector for the proportion of students that should be included in the high and low groups. The default is 0.27.
#'
#' @return A data frame with n rows and i columns (based on the length of the difficulty and discrimination vectors).
#' * Each row represents a student's response to the simulated test.
#' * Each column represents a test item.
#' * The simulated response values are 0 for an incorrect response and 1 for a correct response.
#' * The items will be sorted in increasing order of difficulty.
#' * If the argument to identify groups is TRUE, a total percentage correct column and a grouping column will also be in the return.
#'
#'
#'
#' @examples
#' difficulty <- c(0.57, 0.47, 0.7, 0.41, 0.76)
#' discrimination <- c(0.2, 0.4, 0.4, 0.99, 0.91)
#' generate_2PL(difficulty = difficulty, discrimination = discrimination, n = 30)
#'
#' @examples
#' # example code
#' difficulty <- c(0.57, 0.47, 0.7, 0.41, 0.76)
#' discrimination <- c(0.2, 0.4, 0.4, 0.99, 0.91)
#' generate_2PL(difficulty = difficulty, discrimination = discrimination,
#' n = 30, identify_groups = TRUE)
#'
#' @export

generate_2PL <- function(difficulty, discrimination, n, identify_groups = FALSE, group_pct = 0.27) {

  rlang::check_installed("mirt", reason = "to use `simdata()`")

  stopifnot(length(difficulty) == length(discrimination))

  parameters <- tibble::tibble(difficulty = difficulty,
                  discrimination = discrimination) %>%
    dplyr::arrange(difficulty)

  difficulty <- parameters$difficulty
  discrimination <- parameters$discrimination

  # Convert p-values into d params
  d_params <- sapply(seq_along(difficulty),
                     function (i) {
                       -p_to_d(difficulty[i], discrimination[i])
                     })

  sim_data <- mirt::simdata(a = discrimination,
                            d = d_params,
                            N = n,
                            itemtype = '2PL')

  sim_data <- as.data.frame(sim_data)

  if (identify_groups == TRUE) {

    output <- sim_data %>%
      identifying_groups(pct_in_group = group_pct)

  }

  output <- sim_data

  return(output)
}
