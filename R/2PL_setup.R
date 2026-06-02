#' @importFrom rlang .data
#' @importFrom magrittr %>%

p_to_d <- function(p, a, quadpts = 121) {

  rlang::check_installed("statmod", reason = "to use `gauss.quad.prob()`")

  gh <- statmod::gauss.quad.prob(quadpts, dist = "normal")
  nodes <- gh$nodes
  weights <- gh$weights

  expected_p <- function (d) {

    prob <- 1 / (1 + exp(-a * (nodes - d)))
    sum(prob * weights)

  }

  # min and max possible values
  end_points <- sort(c(expected_p(-6), expected_p(6)))

  if (p <= end_points[1] || p >= end_points[2]) {
    stop(sprintf("Target p=%.3f is outside achievable range [%.3f, %.3f] for a=%.2f",
                 p, end_points[1], end_points[2], a))
  }

  d <- stats::uniroot(function(d) expected_p(d) - p,
                      lower = -6, upper = 6)$root

  return(d)

}

identifying_groups <- function(df, pct_in_group = c(0.27, 0.27)) {

  N <- nrow(df)

  num_items <- sum(stringr::str_detect(names(df), "^Item"))

  output_w_total <- df %>%
    dplyr::rowwise() %>%
    dplyr::mutate(Total = round(sum(dplyr::across(tidyselect::everything()))/num_items, 2) * 100) %>%
    dplyr::ungroup()

  n_group_low <- ceiling(N * pct_in_group[2])
  n_group_high <- ceiling(N * pct_in_group[1])

  total_w_group <- output_w_total %>%
    dplyr::arrange(dplyr::desc(.data$Total)) %>%
    dplyr::mutate(Group = dplyr::case_when(dplyr::row_number() <= n_group_high ~ "High",
                                           (dplyr::n() - dplyr::row_number()) < n_group_low ~ "Low",
                                           TRUE ~ "Middle"))

  return(output = total_w_group)

}
