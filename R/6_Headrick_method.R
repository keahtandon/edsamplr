#' Generate data using Headrick's fifth-order polynomial method
#'
#' @description
#' `headrick_method()` uses specified values of mean, variance, skew, kurtosis,
#' and the fifth and sixth moments to determine the constants for the expected
#' values of Y and generate a sample of the specified distribution.
#'
#' @param k A numeric vector indicating the number of variables to sample.
#' @param n A numeric vector for the sample size.
#' @param mean A numeric vector of length k for the means of each variable
#'  in the distribution. The values can be identical.
#' @param var A numeric vector of length k for the variances of each variable
#'  in the distribution. The values can be identical.
#' @param skew A numeric vector of length k for the skews of each variable
#'  in the distribution. The values can be identical.
#' @param kurtosis A numeric vector of length k for the kurtoses of each variable
#'  in the distribution. The values can be identical.
#' @param corr A kxk correlation matrix. The default value is diag(1,k).
#' @param gam3 An optional numeric value for the 5th standardized cumulant.
#'  The default value is computed internally.
#' @param gam4 An optional numeric value for the 6th standardized cumulant.
#'  The default value is computed internally.
#'
#' @return A data frame of n rows and k columns containing the generated
#'   values.
#'
#' @author Oscar L. Olvera Astivia and Keah Tandon
#'
#' @references Headrick, T. C. (2002). Fast fifth-order polynomial transforms
#'  for generating univariate and multivariate nonnormal distributions.
#'  *Computational Statistics & Data Analysis, 40*, 685-711.
#'
#' Olvera Astivia, O. L., & Zumbo, B. D. (2015). A Cautionary Note on the Use
#'  of the Vale and Maurelli Method to Generate Multivariate, Nonnormal Data for
#'  Simulation Purposes. *Educational and Psychological Measurement, 75*, 541-567.
#'
#' @examples
#' headrick_method(1, 100, 0, 1, 0, 0)
#'
#' @examples
#' headrick_method(2, 100, c(0,0), c(1,1), c(0,0), c(0,0))
#'
#' @examples
#' corr <- matrix(c(1, .7, .7, 1), byrow = TRUE, nrow = 2)
#' headrick_method(2, 100, c(0,0), c(1,1), c(0,0), c(0,0), corr = corr)
#'
#' @export
#' @importFrom rlang .data

headrick_method <- function(k, n,
                            mean, var, skew, kurtosis,
                            corr = diag(1, k),
                            gam3 = NaN, gam4 = NaN) {
  coeff <- find_poly_coefficients(k,
    skewness = skew, kurtosis,
    gam3, gam4
  )

  inter_corr <- solve_intercorr(k, coeff, corr)

  dist <- data.frame(generate_headrick_data(k, n, mean, var, coeff,
    inter.corr = inter_corr
  ))

  if (k == 1) {
    dist <- dist %>%
      dplyr::rename(X1 = .data$generate_headrick_data.k..n..mean..var..coeff..inter.corr...inter_corr.)
  }

  return(dist)
}
