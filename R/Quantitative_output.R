#' @importFrom rlang .data
#' @importFrom magrittr %>%

quantitative_data <- function(k, n, mean, var, skew, kurt, effect_size,
                              use_effect_size, k_names, decimals,
                              seed) {


  moments <- moment_fill(k, mean, var, skew, kurt,
                         slope = NA, r = NA,
                         effect_size, use_effect_size, use_slope = FALSE,
                         use_cor = FALSE
  )

  if (length(n) == 1) {

    dist <- round(headrick_method(
      k = k, n = n,
      mean = as.vector(moments$moments$mean),
      var = as.vector(moments$moments$var),
      skew = as.vector(moments$moments$skew),
      kurtosis = as.vector(moments$moments$kurt),
      corr = moments$r,
      gam3 = NaN, gam4 = NaN
    ), decimals)

  }

  else {
    max_ln <- max(n)
    dist_list <- list()

    for (i in 1:length(n)) {

      set.seed(seed)
      inter_dist <- round(headrick_method(
        k = k, n = n[i],
        mean = as.vector(moments$moments$mean),
        var = as.vector(moments$moments$var),
        skew = as.vector(moments$moments$skew),
        kurtosis = as.vector(moments$moments$kurt),
        corr = moments$r,
        gam3 = NaN, gam4 = NaN
      ), decimals)

      inter_dist <- inter_dist[[i]]

      inter_dist_padded <- c(inter_dist, rep(NA, max_ln - length(inter_dist)))

      dist_list[[paste0("X", i)]] <- inter_dist_padded

      dist <- as.data.frame(dist_list)

    }

  }

  return(dist)
}

quantitative_summary <- function(k, n, mean, var, skew, kurt, effect_size,
                                 use_effect_size, dist) {

  moments <- moment_fill(k, mean, var, skew, kurt,
                         slope = NA, r = NA,
                         effect_size, use_effect_size, use_slope = FALSE,
                         use_cor = FALSE
  )

  moments <- moments$moments

  if (length(n) == 1) {

    input <- moments %>%
      dplyr::select(!sample) %>%
      dplyr::mutate(sd = round(sqrt(.data$var), 2), .before = .data$var) %>%
      dplyr::select(!"var") %>%
      dplyr::rename(kurtosis = .data$kurt)

    rownames(input) <- paste("input", 1:k)

    stats <- round(psych::describe(dist), 2) %>%
      dplyr::select(c(.data$mean, .data$sd, .data$skew, .data$kurtosis))

    rownames(stats) <- paste("k", 1:k)

  } else {

    input <- moments %>%
      dplyr::select(!sample) %>%
      dplyr::mutate(n = n,
                    sd = round(sqrt(.data$var), 2)) %>%
      dplyr::relocate(n, .before = .data$mean) %>%
      dplyr::relocate(.data$sd, .before = .data$var) %>%
      dplyr::select(!"var") %>%
      dplyr::rename(kurtosis = .data$kurt)

    rownames(input) <- paste("input", 1:k)

    stats <- round(psych::describe(dist), 2) %>%
      dplyr::select(c(.data$n, .data$mean, .data$sd, .data$skew, .data$kurtosis))

    rownames(stats) <- paste("k", 1:k)


  }

  summary <- as.matrix(dplyr::bind_rows(purrr::map2(
    split(input, 1:nrow(input)),
    split(stats, 1:nrow(stats)),
    dplyr::bind_rows
  )))

  return(summary)

}


quantitative_output <- function(k, n, mean, var, skew, kurt, effect_size,
                                use_effect_size, k_names, decimals,
                                seed, summary, replication) {


  if (summary == TRUE & replication == 1) {


    dist <- quantitative_data(k, n, mean, var, skew, kurt, effect_size,
                              use_effect_size, k_names, decimals,
                              seed)

    stats <- quantitative_summary(k, n, mean, var, skew, kurt, effect_size,
                                  use_effect_size, dist)

    data <- data_restructure(k, dist, k_names)

    output <- list(summary = stats, sample = data)

  }

  else if (summary == FALSE & replication == 1) {

    dist <- quantitative_data(k, n, mean, var, skew, kurt, effect_size,
                              use_effect_size, k_names, decimals,
                              seed)

    data <- data_restructure(k, dist, k_names)

    output <- data

  }

  else if (summary == TRUE & replication > 1) {

    output <- replicate(replication, expr = {

      dist <- quantitative_data(k, n, mean, var, skew, kurt, effect_size,
                                use_effect_size, k_names, decimals,
                                seed)

      stats <- quantitative_summary(k, n, mean, var, skew, kurt, effect_size,
                                    use_effect_size, dist)


      data <- data_restructure(k, dist, k_names)

      output <- list(summary = stats, sample = data)

    },
    simplify = FALSE)

  }

  else if (summary == FALSE & replication > 1) {

    output <- replicate(replication, expr = {

      dist <- quantitative_data(k, n, mean, var, skew, kurt, effect_size,
                                use_effect_size, k_names, decimals,
                                seed)

      data <- data_restructure(k, dist, k_names)

      output <- data

    },
    simplify = FALSE)

  }

  return(output)

}














