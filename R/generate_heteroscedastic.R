#' Generate samples of heteroscedastic data
#'
#' @description
#' `generate_heteroscedastic()` is a function to generate samples of data with specified degree of heteroscedasticity
#'
#' @param n A numeric vector for the sample size. The default value is 1000.
#' @param degree A numeric vector for the degree of heteroscedasticity, in which 1 is homoscedastic and 5 is extremely heteroscedastic.
#'
#' @return A data frame with n rows and 2 columns
#'
#' @details
#' This function was designed to help teach students about heteroscedasticity and what it looks like. The function allows for degrees of severity to help show the differences. This is useful for students who have recently been introduced to it and may not see the nuance in a real data set.
#'
#' It can also be used as a data set for demonstrating the consequences of violating the equal variances assumption in linear regression. While the ASA recommends the use of real data as a best practice, finding published data sets that demonstrate heteroscedasticity is more challenging than for other educational topics.
#'
#' @examples
#' test <- generate_heteroscedastic(degree = 4)
#' model <- lm(v2 ~ v1, data = test)
#' plot(model, 2)
#'
#' @examples
#' test <- generate_heteroscedastic(n = 20, degree = 2)
#' model <- lm(v2 ~ v1, data = test)
#' plot(model, 2)
#'
#' @export

generate_heteroscedastic <- function(n = 1000, degree) {
  degree_range <- c(
    function(x) {
      return(1)
    },
    function(x) {
      return((1 + 0.01 * x))
    },
    function(x) {
      return((1 + 0.025 * x))
    },
    function(x) {
      return(sqrt(x))
    },
    function(x) {
      return(x)
    }
  )

  degree_function <- degree_range[[degree]]

  x <- stats::runif(n, min = 1, max = n / 10)
  y <- stats::rnorm(n, mean = 0, sd = degree_function(x))

  dist <- data.frame(x, y)

  colnames(dist) <- c("v1", "v2")

  return(dist)
}
