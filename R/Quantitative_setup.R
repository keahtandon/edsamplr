#' @importFrom rlang .data
#' @importFrom magrittr %>%

# This is a function to fill in moments for multiple samples as needed.
# It exports to k_quantitative_H.

moment_fill <- function(samples, mean, var, skew, kurt, slope, r, effect_size, use_effect_size, use_slope) {
  if (samples > 1) {
    # Variance

    if (use_slope == TRUE) {
      for (i in 1:(samples - 1)) {
        new_var <- (((sqrt(var[i]) * slope) / r)^2)

        var <- c(var, new_var)
      }
    } else {
      if (length(var) == 1) {
        var <- rep(var, samples)
      } else {
        var
      }
    }

    # Mean

    if (use_effect_size == TRUE) {
      for (i in 1:(samples - 1)) {
        new_mean <- (sqrt(var[i]) * effect_size[i]) + mean

        mean <- c(mean, new_mean)
      }
    } else {
      if (length(mean) == 1) {
        mean <- rep(mean, samples)
      } else {
        mean
      }
    }

    # Skew

    if (length(skew) == 1) {
      skew <- rep(skew, samples)
    } else {
      skew
    }

    # Kurtosis

    if (length(kurt) == 1) {
      kurt <- rep(kurt, samples)
    } else {
      kurt
    }

    # Correlation

    if (use_slope == TRUE) {
      if (length(r) == 1) {
        r_matrix <- diag(nrow = samples)

        r_matrix[r_matrix == 0] <- r
      }
    } else {
      if (length(r) == 1) {
        r_matrix <- diag(nrow = samples)
      } else {
        r_matrix <- r
      }
    }

    moments <- list(
      moments = data.frame(
        sample = seq(1:samples),
        mean = mean,
        var = var,
        skew = skew,
        kurt = kurt
      ),
      r = r_matrix
    )
  } else {
    r_matrix <- diag(nrow = samples)

    moments <- list(
      moments = data.frame(
        sample = samples,
        mean = mean,
        var = var,
        skew = skew,
        kurt = kurt
      ),
      r = r_matrix
    )
  }

  return(moments)
}

# This restructures the data and adds the group names.
# It exports to k_quantitative_H and ...

data_restructure <- function(samples, dist, group_names) {
  if (samples == 1) {
    dist <- dist %>%
      dplyr::rename(Value = .data$X1) %>%
      dplyr::mutate(
        Group = factor(1, levels = 1, labels = group_names),
        .before = .data$Value
      )
  } else {
    dist <- dist %>%
      tidyr::pivot_longer(
        cols = tidyselect::everything(),
        names_to = "Group",
        values_to = "Value",
        names_prefix = "X",
        cols_vary = "slowest"
      ) %>%
      dplyr::mutate(Group = factor(.data$Group, levels = 1:max(samples), labels = group_names))
  }
}


# This does the stats for the k quant function. It exports to k_quantitative_H and ...

q_stats <- function(samples, moments, dist) {
  input <- moments %>%
    dplyr::select(!sample) %>%
    dplyr::mutate(sd = round(sqrt(.data$var), 2), .before = .data$var) %>%
    dplyr::select(!.data$var) %>%
    dplyr::rename(kurtosis = .data$kurt)

  rownames(input) <- paste("input", 1:samples)

  stats <- round(psych::describe(dist), 2) %>%
    dplyr::select(c(.data$mean, .data$sd, .data$skew, .data$kurtosis))

  rownames(stats) <- paste("sample", 1:samples)

  summary <- as.matrix(dplyr::bind_rows(purrr::map2(
    split(input, 1:nrow(input)),
    split(stats, 1:nrow(stats)),
    dplyr::bind_rows
  )))

  return(summary)
}

# This does the matched pair data stats

matched_stats <- function(moments, dist) {
  input <- moments %>%
    dplyr::select(!sample) %>%
    dplyr::mutate(sd = round(sqrt(.data$var), 2), .before = .data$var) %>%
    dplyr::select(!.data$var) %>%
    dplyr::rename(kurtosis = .data$kurt)

  rownames(input) <- paste(c("x", "y"), "input")

  stats <- round(psych::describe(dist), 2) %>%
    dplyr::select(c(.data$mean, .data$sd, .data$skew, .data$kurtosis))

  rownames(stats) <- c(paste("sample", c("x", "y")), "difference")

  summary <- purrr::map(seq_len(max(nrow(input), nrow(stats))), function(i) {
    row1 <- if (i <= nrow(input)) input[i, , drop = FALSE] else NULL
    row2 <- if (i <= nrow(stats)) stats[i, , drop = FALSE] else NULL
    combined_row <- rbind(row1, row2)
    combined_row
  })

  summary <- as.matrix(dplyr::bind_rows(summary))

  return(summary)
}
