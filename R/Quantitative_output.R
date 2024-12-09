#' @importFrom rlang .data
#' @importFrom magrittr %>%

# This is a data generation and processing function that uses rHeadrick.
# It exports to k_quantitative_H and provides summary statistics.

quant_with_summary <- function(k, n, mean, var, skew, kurt, effect_size,
                               use_effect_size, group_names, decimals, replication) {
  moments <- moment_fill(k, mean, var, skew, kurt,
    slope = NA, r = NA,
    effect_size, use_effect_size, use_slope = FALSE,
    use_cor = FALSE
  )

  if (replication > 1) {
    output <- vector("list", replication)

    for (i in 1:replication) {
      dist <- headrick_method(
        k = k, n = n,
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      )

      stats <- q_stats(k, moments$moments, dist)

      dist <- data_restructure(k, dist, group_names)

      inter_output <- list(summary = stats, sample = dist)

      output[[i]] <- inter_output
    }
  } else {
    dist <- headrick_method(
      k = k, n = n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    )

    stats <- q_stats(k, moments$moments, dist)

    dist <- data_restructure(k, dist, group_names)

    output <- list(summary = stats, sample = dist)
  }

  return(output)
}

# This is a data generation and processing function that uses rHeadrick.
# It exports to k_quantitative_H with just the sample data.

quant_no_summary <- function(k, n, mean, var, skew, kurt, effect_size,
                             use_effect_size, group_names, decimals, replication) {
  moments <- moment_fill(k, mean, var, skew, kurt,
    slope = NA, r = NA,
    effect_size, use_effect_size, use_slope = FALSE,
    use_cor = FALSE
  )

  if (replication > 1) {
    output <- vector("list", replication)

    for (i in 1:replication) {
      dist <- headrick_method(
        k = k, n = n,
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      )

      inter_output <- data_restructure(k, dist, group_names)

      output[[i]] <- inter_output
    }
  } else {
    dist <- headrick_method(
      k = k, n = n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    )

    output <- data_restructure(k, dist, group_names)
  }

  return(output)
}

# This is a matched pairs generation and processing function that uses rHeadrick.
# It exports to matched_pairs_H and provides summary statistcs.

matched_with_summary <- function(n, mean, var, skew, kurt, effect_size, r,
                                 use_effect_size, decimals, replication) {
  moments <- moment_fill(
    k = 2, mean, var, skew, kurt, slope = NA, r,
    effect_size, use_effect_size, use_slope = FALSE,
    use_cor = TRUE
  )

  if (replication > 1) {
    output <- vector("list", replication)

    for (i in 1:replication) {
      dist <- headrick_method(k = 2, n,
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      )

      dist <- round(dist, decimals) %>%
        dplyr::mutate(Difference = .data$X2 - .data$X1)

      stats <- matched_stats(moments$moments, dist)

      cor <- round(cor(dist$X1, dist$X2), decimals)

      inter_output <- list(correlation = cor, summary = stats, sample = dist)

      output[[i]] <- inter_output
    }
  } else {
    dist <- headrick_method(k = 2, n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    )

    dist <- round(dist, decimals) %>%
      dplyr::mutate(Difference = .data$X2 - .data$X1)

    stats <- matched_stats(moments$moments, dist)

    cor <- round(cor(dist$X1, dist$X2), decimals)

    output <- list(correlation = cor, summary = stats, sample = dist)
  }

  return(output)
}

# This is a matched pairs generation and processing function that uses rHeadrick.
# It exports to matched_pairs_H with just the sample data.

matched_no_summary <- function(n, mean, var, skew, kurt, effect_size,
                               r, use_effect_size, decimals, replication) {
  moments <- moment_fill(
    k = 2, mean, var, skew, kurt, slope = NA, r,
    effect_size, use_effect_size, use_slope = FALSE,
    use_cor = TRUE
  )

  if (replication > 1) {
    output <- vector("list", replication)

    for (i in 1:replication) {
      dist <- headrick_method(k = 2, n,
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      )

      inter_output <- round(dist, decimals) %>%
        dplyr::mutate(Difference = .data$X2 - .data$X1)

      output[[i]] <- inter_output
    }
  } else {
    dist <- headrick_method(k = 2, n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    )

    output <- round(dist, decimals) %>%
      dplyr::mutate(Difference = .data$X2 - .data$X1)
  }

  return(output)
}

# This is a cor and slope generation and processing function that uses Headrick.
# It exports to xx and provides summary statistics.

slope_with_summary <- function(k, n, mean, var, skew, kurt, slope, r, decimals,
                               replication) {
  moments <- moment_fill(
    k = 2, mean, var, skew, kurt, slope, r,
    use_effect_size = FALSE, use_slope = TRUE,
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

      stats <- q_stats(k = 2, moments$moments, dist)

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

    stats <- q_stats(k = 2, moments$moments, dist)

    cor <- round(cor(dist$X1, dist$X2), decimals)

    model <- stats::lm(dist$X2 ~ dist$X1)

    slope <- round(model$coefficients[[2]], decimals)

    output <- list(correlation = cor, slope = slope, summary = stats, sample = dist)
  }

  return(output)
}

# This is a cor and slope generation and processing function that uses Headrick.
# It exports to matched_pairs_H with just the sample data.

slope_no_summary <- function(k, n, mean, var, skew, kurt, slope, r, decimals,
                             replication) {
  moments <- moment_fill(
    k = 2, mean, var, skew, kurt, slope, r,
    use_effect_size = FALSE, use_slope = TRUE,
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
