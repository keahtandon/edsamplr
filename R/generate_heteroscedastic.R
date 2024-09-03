#' @export

# This is a function to generate a two variable dataset that demonstrates the
# spectrum of homoscedasticity to heteroscedasticity.

# Degree of 1 is homoscedastic, 2 is very mildly heteroscedastic,
# 3 is moderately heteroscedastic, 4 is very heteroscedastic, and 5 is extremely heteroscedastic.

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
