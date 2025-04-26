#' @importFrom rlang .data
#' @importFrom magrittr %>%

# This does the stats for the k quant function. It exports to k_quantitative_H and ...

q_stats <- function(k, n, moments, dist) {

  if (length(n) == 1) {

    input <- moments %>%
      dplyr::select(!sample) %>%
      dplyr::mutate(sd = round(sqrt(.data$var), 2), .before = .data$var) %>%
      dplyr::select(!.data$var) %>%
      dplyr::rename(kurtosis = .data$kurt)

    rownames(input) <- paste("input", 1:k)

    stats <- round(psych::describe(dist), 2) %>%
      dplyr::select(c(.data$mean, .data$sd, .data$skew, .data$kurtosis))

    rownames(stats) <- paste("k", 1:k)

    summary <- as.matrix(dplyr::bind_rows(purrr::map2(
      split(input, 1:nrow(input)),
      split(stats, 1:nrow(stats)),
      dplyr::bind_rows
    )))

  } else {

    input <- moments %>%
      dplyr::select(!sample) %>%
      dplyr::mutate(n = n,
                    sd = round(sqrt(.data$var), 2)) %>%
      dplyr::relocate(n, .before = .data$mean) %>%
      dplyr::relocate(.data$sd, .before = .data$var) %>%
      dplyr::select(!.data$var) %>%
      dplyr::rename(kurtosis = .data$kurt)

    rownames(input) <- paste("input", 1:k)

    stats <- round(psych::describe(dist), 2) %>%
      dplyr::select(c(.data$n, .data$mean, .data$sd, .data$skew, .data$kurtosis))

    rownames(stats) <- paste("k", 1:k)

    summary <- as.matrix(dplyr::bind_rows(purrr::map2(
      split(input, 1:nrow(input)),
      split(stats, 1:nrow(stats)),
      dplyr::bind_rows
    )))

  }

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
