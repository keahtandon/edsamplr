generate_data_summary <- function(k, n, mean, sd, coeff, inter.corr) {
  # separating out the coefficients

  c0 <- as.vector(coeff[1, ], mode = "numeric")
  c1 <- as.vector(coeff[2, ], mode = "numeric")
  c2 <- as.vector(coeff[3, ], mode = "numeric")
  c3 <- as.vector(coeff[4, ], mode = "numeric")
  c4 <- as.vector(coeff[5, ], mode = "numeric")
  c5 <- as.vector(coeff[6, ], mode = "numeric")

  # setting up initial variables

  obs.mean <- NULL
  obs.sd <- NULL
  obs.skew <- NULL
  obs.kurt <- NULL
  obs.gam3 <- NULL
  obs.gam4 <- NULL

  # generating the data

  # generating intermediate normal distribution with desired intermediate correlation

  Z <- MASS::mvrnorm(n, mu = rep(0, k), Sigma = inter.corr)
  Z2 <- Z^2
  Z3 <- Z^3
  Z4 <- Z^4
  Z5 <- Z^5

  ## Generate multivariate distribution with desired property

  Y <- matrix(0, nrow = n, ncol = k)

  for (i in 1:k) {
    Y[, i] <- mean[i] + sd[i] * (c0[i] +
      c1[i] * Z[, i] +
      c2[i] * Z2[, i] +
      c3[i] * Z3[, i] +
      c4[i] * Z4[, i] +
      c5[i] * Z5[, i])
  }

  obs.mean <- rbind(obs.mean, apply(Y, 2, mean))
  obs.sd <- rbind(obs.sd, apply(Y, 2, sd))
  obs.skew <- rbind(obs.skew, apply(Y, 2, f_skew))
  obs.kurt <- rbind(obs.kurt, apply(Y, 2, f_kurt))
  obs.gam3 <- rbind(obs.gam3, apply(Y, 2, f_gamma3))
  obs.gam4 <- rbind(obs.gam4, apply(Y, 2, f_gamma4))

  obs.moments <- data.frame(
    mean = apply(obs.mean, 2, mean),
    sd = apply(obs.sd, 2, mean),
    skewness = apply(obs.skew, 2, mean),
    kurtosis = apply(obs.kurt, 2, mean),
    gam3 = apply(obs.gam3, 2, mean),
    gam4 = apply(obs.gam4, 2, mean)
  )
  obs.moments.sd <- data.frame(
    mean = apply(obs.mean, 2, sd),
    sd = apply(obs.sd, 2, sd),
    skewness = apply(obs.skew, 2, sd),
    kurtosis = apply(obs.kurt, 2, sd),
    gam3 = apply(obs.gam3, 2, sd),
    gam4 = apply(obs.gam4, 2, sd)
  )

  rownames(obs.moments) <- paste0("Y", 1:nrow(obs.moments))
  rownames(obs.moments.sd) <- paste0("Y", 1:nrow(obs.moments.sd))

  obs.corr <- stats::cor(Y)
  rownames(obs.corr) <- paste0("Y", 1:nrow(obs.corr))
  colnames(obs.corr) <- paste0("Y ", 1:ncol(obs.corr))

  return(list(
    data = Y,
    sample_moments = obs.moments,
    sample_moments_sd = obs.moments.sd,
    corr = obs.corr
  ))
}

generate_headrick_data <- function(k, n, mean, var, coeff, inter.corr) {
  sd <- sqrt(var)

  # separating out the coefficients

  c0 <- as.vector(coeff[1, ], mode = "numeric")
  c1 <- as.vector(coeff[2, ], mode = "numeric")
  c2 <- as.vector(coeff[3, ], mode = "numeric")
  c3 <- as.vector(coeff[4, ], mode = "numeric")
  c4 <- as.vector(coeff[5, ], mode = "numeric")
  c5 <- as.vector(coeff[6, ], mode = "numeric")

  # generating the data

  # generating intermediate normal distribution with desired intermediate correlation

  Z <- MASS::mvrnorm(n, mu = rep(0, k), Sigma = inter.corr)
  Z2 <- Z^2
  Z3 <- Z^3
  Z4 <- Z^4
  Z5 <- Z^5

  ## Generate multivariate distribution with desired property

  Y <- matrix(0, nrow = n, ncol = k)

  for (i in 1:k) {
    Y[, i] <- mean[i] + sd[i] * (c0[i] +
      c1[i] * Z[, i] +
      c2[i] * Z2[, i] +
      c3[i] * Z3[, i] +
      c4[i] * Z4[, i] +
      c5[i] * Z5[, i])
  }

  return(data = Y)
}
