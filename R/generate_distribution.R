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
                                  n = 100,
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
                                  max = NULL,
                                  mode = NULL) {
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

    sample <- stats::rbeta(n = n, shape1 = alpha_shape, shape2 = beta_shape)

    stats <- MASS::fitdistr(sample, "beta", list(shape1 = alpha_shape, shape2 = beta_shape))

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

    sample <- stats::rcauchy(n = n, location = location, scale = scale)

    stats <- MASS::fitdistr(sample, "cauchy")

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

    sample <- stats::rchisq(n = n, df = df)

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

    sample <- stats::rexp(n = n, rate = rate)

    stats <- MASS::fitdistr(sample, "exponential")

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

    sample <- stats::rf(n = n, df1 = df, df2 = df2)

    stats <- MASS::fitdistr(sample, densfun = "F", list(df1 = df, df2 = df2))

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

    sample <- stats::rgamma(n = n, shape = alpha_shape, rate = rate)

    stats <- MASS::fitdistr(sample, "gamma", list(shape = alpha_shape, rate = rate))

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

    sample <- VGAM::rlaplace(n = n, location = location, scale = scale)

    stats <- MASS::fitdistr(sample, densfun = VGAM::dlaplace, list(location = location, scale = scale))

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

    sample <- stats::rlogis(n = n, location = location, scale = scale)

    stats <- MASS::fitdistr(sample, "logistic", list(location = location, scale = scale))

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

    sample <- stats::rlnorm(n = n, meanlog = mean_log, sdlog = sd_log)

    stats <- MASS::fitdistr(sample, "lognormal")

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

    sample <- stats::rnorm(n = n, mean = mean, sd = sd)

    stats <- MASS::fitdistr(sample, "normal")

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

    sample <- stats::rt(n = n, df = df)

    stats <- MASS::fitdistr(sample, "t")

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

    sample <- VGAM::rtriangle(n = n, theta = theta, lower = min, upper = max)

    stats <- MASS::fitdistr(sample, densfun = VGAM::dtriangle, list(theta = theta, lower = min, upper = max))

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

    sample <- stats::runif(n = n, min = min, max = max)

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

    sample <- stats::rweibull(n = n, shape = alpha_shape, scale = scale)

    stats <- MASS::fitdistr(sample, "weibull", list(shape = alpha_shape, scale = scale))

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
