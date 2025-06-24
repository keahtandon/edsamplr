#' @importFrom rlang .data
#' @importFrom magrittr %>%

# This is a cor and slope generation and processing function that uses Headrick.
# It exports to xx and provides summary statistics.

slope_with_summary <- function(n, mean, var, skew, kurt, slope, r,
                               use_slope, decimals, replication) {

  k <- 2

  moments <- moment_fill(
    k = 2, mean = mean, var = var, skew = skew, kurt = kurt, slope = slope, r = r,
    use_effect_size = FALSE, use_slope = use_slope,
    use_cor = TRUE
  )

  if (replication > 1) {
    output <- vector("list", replication)

    for (i in 1:replication) {
      dist <- headrick_method(k, n,
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      )

      dist <- round(dist, decimals)

      stats <- q_stats(k = 2, n, moments$moments, dist)

      cor <- round(cor(dist$X1, dist$X2), decimals)

      model <- stats::lm(dist$X2 ~ dist$X1)

      slope <- round(model$coefficients[[2]], decimals)

      inter_output <- list(correlation = cor, slope = slope, summary = stats, sample = dist)

      output[[i]] <- inter_output
    }
  } else {
    dist <- headrick_method(k, n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    )

    dist <- round(dist, decimals)

    stats <- q_stats(k = 2, n, moments$moments, dist)

    cor <- round(cor(dist$X1, dist$X2), decimals)

    model <- stats::lm(dist$X2 ~ dist$X1)

    slope <- round(model$coefficients[[2]], decimals)

    output <- list(correlation = cor, slope = slope, summary = stats, sample = dist)
  }

  return(output)
}

# This is a cor and slope generation and processing function that uses Headrick.
# It exports to matched_pairs_H with just the sample data.

slope_no_summary <- function(n, mean, var, skew, kurt, slope, r,
                             use_slope, decimals, replication) {

  k <- 2

  moments <- moment_fill(
    k = 2, mean, var, skew, kurt, slope, r, effect_size = NA,
    use_effect_size = FALSE, use_slope = use_slope,
    use_cor = TRUE
  )

  if (replication > 1) {
    output <- vector("list", replication)

    for (i in 1:replication) {
      inter_output <- headrick_method(
        k = k, n = n,
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      )

      output[[i]] <- inter_output
    }
  } else {
    output <- headrick_method(
      k = k, n = n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    )
  }

  return(output)
}
