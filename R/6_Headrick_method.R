#' @export
#' @importFrom rlang .data

# Headrick method

headrick_method <- function(k, n,
                            mean, var, skew, kurtosis, corr,
                            gam3 = NaN, gam4 = NaN, replication,
                            abs.tol = 1e-20, eval.max = 1e5, iter.max = 1e3) {
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
