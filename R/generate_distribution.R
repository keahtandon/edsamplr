#' Generate sample data from named distributions
#'
#' @description
#' generate_distribution() is a wrapper function for generating sample data from named continuous distributions.
#'
#' The distributional shapes include beta, Cauchy, chi-squared, exponential, F, gamma, Laplace, logistic, log normal, normal, t, triangular, uniform, and Weibull.
#'
#' @param distribution A character vector to identify which distributional shape to sample. Options include `beta,` `cauchy,` `chi-squared,` `exponential,` `f,` `gamma,` `laplace,` `logistic,` `log normal,` `normal,` `t,` `triangular,` `uniform,` and `weibull.`
#' @param n A numeric vector for the sample size. The default value is 1000.
#' @param seed An optional numeric vector to use in set.seed()
#' @param alpha_shape A non-negative numeric vector required for the shape of the beta, gamma, and Weibull distributions.
#' @param beta_shape A non-negative numeric vector required for the shape of the beta distribution.
#' @param location A numeric vector for the location of the Cauchy, Laplace, and logistic distributions. The default value is 0.
#' @param scale A numeric vector for the scale of the Cauchy, Laplace, logistic, and Weibull distributions. The default value is 1.
#' @param df A numeric vector required for the degrees of freedom of the chi-squared, F, and t distributions.
#' @param df2 A numeric vector required for the degrees of freedom of the F distribution.
#' @param rate A numeric vector for the rate of the exponential and gamma distributions. The default value is 1.
#' @param mean_log A numeric vector for the mean (on the log scale) of the log normal distribution. The default value is 0.
#' @param sd_log A numeric vector for the standard deviation (on the log scale) of the log normal distribution. The default value is 1.
#' @param mean A numeric vector for the mean of the normal distribution. The default value is 0.
#' @param sd A numeric vector for the standard deviation of the normal distribution. The default value is 1.
#' @param theta A numeric vector required for the theta of the triangular distribution.
#' @param min A numeric vector for the minimum value of the triangular and uniform distributions. The default value is 0.
#' @param max A numeric vector for the maximum value of the triangular and uniform distributions. The default value is 1.
#'
#' @return A list of `data:` a vector of length n containing the generated values, and `summary:` a descriptive matrix of input and sample values of the specified distribution's parameters.
#'
#' @examples
#' generate_distribution(distribution = "beta", alpha_shape = 2, beta_shape = 2)
#'
#' @examples
#' generate_distribution(distribution = "cauchy")
#'
#' @examples
#' generate_distribution(distribution = "chi-squared", df = 3)
#'
#' @examples
#' generate_distribution(distribution = "exponential")
#'
#' @examples
#' generate_distribution(distribution = "f", df = 4, df2 = 30)
#'
#' @examples
#' generate_distribution(distribution = "gamma", alpha_shape = 3)
#'
#' @examples
#' generate_distribution(distribution = "laplace")
#'
#' @examples
#' generate_distribution(distribution = "logistic")
#'
#' @examples
#' generate_distribution(distribution = "log normal")
#'
#' @examples
#' generate_distribution(distribution = "normal")
#'
#' @examples
#' generate_distribution(distribution = "t", df = 2)
#'
#' @examples
#' generate_distribution(distribution = "triangular", theta = 1, min = 0, max = 2)
#'
#' @examples
#' generate_distribution(distribution = "uniform")
#'
#' @examples
#' generate_distribution(distribution = "weibull", alpha_shape = 1)#'
#'
#' @export

generate_distribution <- function(distribution = c(
                                    "beta",
                                    "cauchy",
                                    "chi-squared",
                                    "exponential",
                                    "f",
                                    "gamma",
                                    "laplace",
                                    "logistic",
                                    "log normal",
                                    "normal",
                                    "t",
                                    "triangular",
                                    "uniform",
                                    "weibull"
                                  ),
                                  n = 1000,
                                  seed = NULL,
                                  alpha_shape = NULL,
                                  beta_shape = NULL,
                                  location = NULL,
                                  scale = NULL,
                                  df = NULL,
                                  df2 = NULL,
                                  rate = NULL,
                                  mean_log = NULL,
                                  sd_log = NULL,
                                  mean = NULL,
                                  sd = NULL,
                                  theta = NULL,
                                  min = NULL,
                                  max = NULL) {
  if (is.null(distribution)) {
    stop("Please provide the distribution.")
  }

  if (!distribution %in% c(
    "beta", "cauchy", "chi-squared", "exponential", "f",
    "gamma", "laplace", "logistic", "log normal",
    "normal", "t", "triangular", "uniform", "weibull"
  )) {
    stop("Please provide one of the support distributions.")
  }

  if (!is.null(seed)) {
    set.seed(seed = seed)
  }

  # beta

  if (distribution == "beta") {
    if (is.null(alpha_shape) | is.null(beta_shape)) {
      stop("Please provide both shape parameters (alpha_shape, beta_shape).")
    }

    if (alpha_shape < 0 | beta_shape < 0) {
      stop("Please make sure that both shape parameters have positive values.")
    }

    sample <- suppressWarnings(stats::rbeta(n = n, shape1 = alpha_shape, shape2 = beta_shape))

    stats <- suppressWarnings(MASS::fitdistr(sample, "beta", list(shape1 = alpha_shape, shape2 = beta_shape)))

    summary <- matrix(
      c(
        alpha_shape, beta_shape,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("alpha shape", "beta shape"))
    )
  }

  # cauchy

  if (distribution == "cauchy") {
    location_correction <- if (is.null(location)) NA_real_ else location

    location <- dplyr::if_else(is.null(location), 0, location_correction)

    scale_correction <- if (is.null(scale)) NA_real_ else scale

    scale <- dplyr::if_else(is.null(scale), 1, scale_correction)

    sample <- suppressWarnings(stats::rcauchy(n = n, location = location, scale = scale))

    stats <- suppressWarnings(MASS::fitdistr(sample, "cauchy"))

    summary <- matrix(
      c(
        location, scale,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("location", "scale"))
    )
  }

  # chi-square

  if (distribution == "chi-squared") {
    if (is.null(df)) {
      stop("Please provide the degrees of freedom (df).")
    }

    sample <- suppressWarnings(stats::rchisq(n = n, df = df))

    neg_log_likelihood <- function(df, data) {
      -sum(stats::dchisq(data, df, log = TRUE))
    }

    # Optimize the negative log-likelihood and get the df stat
    stats <- stats::optimize(neg_log_likelihood, interval = c(0.01, (mean(sample) * 5)), data = sample)

    summary <- matrix(c(df, round(stats$minimum[[1]], 2)),
      nrow = 2, ncol = 1,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("df"))
    )
  }

  # exponential

  if (distribution == "exponential") {
    rate_correction <- if (is.null(rate)) NA_real_ else rate

    rate <- dplyr::if_else(is.null(rate), 1, rate_correction)

    sample <- suppressWarnings(stats::rexp(n = n, rate = rate))

    stats <- suppressWarnings(MASS::fitdistr(sample, "exponential"))

    summary <- matrix(
      c(
        rate,
        round(stats$estimate[[1]], 2)
      ),
      nrow = 2, ncol = 1,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("rate"))
    )
  }

  # F

  if (distribution == "f") {
    if (is.null(df) | is.null(df2)) {
      stop("Please provide both degrees of freedom (df, df2).")
    }

    sample <- suppressWarnings(stats::rf(n = n, df1 = df, df2 = df2))

    stats <- suppressWarnings(MASS::fitdistr(sample, densfun = "F", list(df1 = df, df2 = df2)))

    summary <- matrix(
      c(
        df, df2,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("df1", "df2"))
    )
  }

  # gamma

  if (distribution == "gamma") {
    if (is.null(alpha_shape)) {
      stop("Please provide the shape (alpha_shape).")
    }

    rate_correction <- if (is.null(rate)) NA_real_ else rate

    rate <- dplyr::if_else(is.null(rate), 1, rate_correction)

    sample <- suppressWarnings(stats::rgamma(n = n, shape = alpha_shape, rate = rate))

    stats <- suppressWarnings(MASS::fitdistr(sample, "gamma", list(shape = alpha_shape, rate = rate)))

    summary <- matrix(
      c(
        alpha_shape, rate,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("shape", "rate"))
    )
  }

  # laplace

  if (distribution == "laplace") {

    location_correction <- if (is.null(location)) NA_real_ else location

    location <- dplyr::if_else(is.null(location), 0, location_correction)

    scale_correction <- if (is.null(scale)) NA_real_ else scale

    scale <- dplyr::if_else(is.null(scale), 1, scale_correction)

    sample <- suppressWarnings(VGAM::rlaplace(n = n, location = location, scale = scale))

    stats <- suppressWarnings(MASS::fitdistr(sample, VGAM::dlaplace,
                                             start = list(location = location, scale = scale)))

    summary <- matrix(
      c(
        location, scale,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("location", "scale"))
    )
  }

  # logistic

  if (distribution == "logistic") {
    location_correction <- if (is.null(location)) NA_real_ else location

    location <- dplyr::if_else(is.null(location), 0, location_correction)

    scale_correction <- if (is.null(scale)) NA_real_ else scale

    scale <- dplyr::if_else(is.null(scale), 1, scale_correction)

    sample <- suppressWarnings(stats::rlogis(n = n, location = location, scale = scale))

    stats <- suppressWarnings(MASS::fitdistr(sample, "logistic", list(location = location, scale = scale)))

    summary <- matrix(
      c(
        location, scale,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("location", "scale"))
    )
  }

  # log normal

  if (distribution == "log normal") {
    mean_log_correction <- if (is.null(mean_log)) NA_real_ else mean_log

    mean_log <- dplyr::if_else(is.null(mean_log), 0, mean_log_correction)

    sd_log_correction <- if (is.null(sd_log)) NA_real_ else sd_log

    sd_log <- dplyr::if_else(is.null(sd_log), 1, sd_log_correction)

    sample <- suppressWarnings(stats::rlnorm(n = n, meanlog = mean_log, sdlog = sd_log))

    stats <- suppressWarnings(MASS::fitdistr(sample, "lognormal"))

    summary <- matrix(
      c(
        mean_log, sd_log,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("mean log", "sd log"))
    )
  }

  # normal

  if (distribution == "normal") {
    mean_correction <- if (is.null(mean)) NA_real_ else mean

    mean <- dplyr::if_else(is.null(mean), 0, mean_correction)

    sd_correction <- if (is.null(sd)) NA_real_ else sd

    sd <- dplyr::if_else(is.null(sd), 1, sd_correction)

    sample <- suppressWarnings(stats::rnorm(n = n, mean = mean, sd = sd))

    stats <- suppressWarnings(MASS::fitdistr(sample, "normal"))

    summary <- matrix(
      c(
        mean, sd,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("mean", "sd"))
    )
  }

  # t

  if (distribution == "t") {
    if (is.null(df)) {
      stop("Please provide the degrees of freedom (df).")
    }

    sample <- suppressWarnings(stats::rt(n = n, df = df))

    stats <- suppressWarnings(MASS::fitdistr(sample, "t"))

    summary <- matrix(
      c(
        df,
        round(stats$estimate[[3]], 2)
      ),
      nrow = 2, ncol = 1,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("df"))
    )
  }

  # triangular

  if (distribution == "triangular") {
    if (is.null(theta)) {
      stop("Please provide the theta parameter.")
    }

    min_correction <- if (is.null(min)) NA_real_ else min

    min <- dplyr::if_else(is.null(min), 0, min_correction)

    max_correction <- if (is.null(max)) NA_real_ else max

    max <- dplyr::if_else(is.null(max), 1, max_correction)

    sample <- suppressWarnings(VGAM::rtriangle(n = n, theta = theta, lower = min, upper = max))

    stats <- suppressWarnings(MASS::fitdistr(sample, densfun = VGAM::dtriangle, list(theta = theta, lower = min, upper = max)))

    summary <- matrix(
      c(
        theta, min, max,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2), round(stats$estimate[[3]], 2)
      ),
      nrow = 2, ncol = 3,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("theta", "lower", "upper"))
    )
  }

  # uniform

  if (distribution == "uniform") {
    min_correction <- if (is.null(min)) NA_real_ else min

    min <- dplyr::if_else(is.null(min), 0, min_correction)

    max_correction <- if (is.null(max)) NA_real_ else max

    max <- dplyr::if_else(is.null(max), 1, max_correction)

    sample <- suppressWarnings(stats::runif(n = n, min = min, max = max))

    summary <- matrix(
      c(
        min, max,
        round(min(sample), 2), round(max(sample), 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("min", "max"))
    )
  }

  #  weibull

  if (distribution == "weibull") {
    if (is.null(alpha_shape)) {
      stop("Please provide the shape (alpha_shape).")
    }

    scale_correction <- if (is.null(scale)) NA_real_ else scale

    scale <- dplyr::if_else(is.null(scale), 1, scale_correction)

    sample <- suppressWarnings(stats::rweibull(n = n, shape = alpha_shape, scale = scale))

    stats <- suppressWarnings(MASS::fitdistr(sample, "weibull", list(shape = alpha_shape, scale = scale)))

    summary <- matrix(
      c(
        alpha_shape, scale,
        round(stats$estimate[[1]], 2), round(stats$estimate[[2]], 2)
      ),
      nrow = 2, ncol = 2,
      byrow = TRUE, dimnames = list(c("input", "sample"), c("shape", "scale"))
    )
  }

  return(list(data = sample, summary = summary))
}
