#' @importFrom rlang .data
#' @importFrom magrittr %>%


# This is a matched pairs generation and processing function that uses rHeadrick.
# It exports to matched_pairs_H and provides summary statistics.

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
