#' @importFrom rlang .data
#' @importFrom magrittr %>%

binary_data <- function(sample_rep, sample_n, sample_prop,
                             sample_names) {

  data <- NULL
  p_hat <- NULL
  x <- NULL
  new_names <- NULL

  for (i in sample_rep) {
    v <- stats::rbinom(sample_n[i], 1, sample_prop[i])

    v_x <- sum(v == 1)

    x <- c(x, v_x)

    v_p_hat <- v_x / sample_n[i]

    p_hat <- c(p_hat, v_p_hat)

    length(v) <- max(sample_n)

    data <- cbind(data, v)

    new_name <- paste0("v", i)

    new_names <- c(new_names, new_name)

    data <- as.data.frame(data)

    names(data) <- new_names

    data[, i] <- factor(data[, i], levels = 1:0, labels = sample_names[i, ])
  }

  return(data)


}

binary_summary <- function(data, sample_rep, sample_n, sample_prop,
                                sample_names, p) {

  x <- data %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), ~ as.integer(. == levels(.)[1]))) %>%
    dplyr::summarise(dplyr::across(dplyr::everything(), sum)) %>%
    tidyr::pivot_longer(dplyr::everything(), names_to = "var", values_to = "x") %>%
    dplyr::pull(x)

  p_hat <- x/sample_n

  matrix_names <- paste("sample", seq(1:p))

  summary <- matrix(c(sample_n, x, round(p_hat, 2), sample_prop),
                    nrow = p, ncol = 4,
                    dimnames = list(matrix_names, c("sample size", "successes",
                                                    "sample proportion", "population proportion"))
  )


  freq <- matrix(c(x, sample_n - x),
                 nrow = p, ncol = 2,
                 dimnames = list(matrix_names, c("successes", "failures"))
  )

  summary_output <- list(summary = summary, freq.table = freq)

  return(summary_output)

}


binary_output <- function(sample_rep, sample_n, sample_prop,
                          sample_names, p, summary, replication) {

  # summary, 1 rep

  if (summary == TRUE & replication == 1) {

    data <- binary_data(sample_rep, sample_n, sample_prop,
                        sample_names)

    summary <- binary_summary(data, sample_rep, sample_n, sample_prop,
                              sample_names, p)

    output <- list(sample = data, proportion_summary = summary$summary, freq.table = summary$freq)

  }

  # no summary, 1 rep

  else if (summary == FALSE & replication == 1) {

    data <- binary_data(sample_rep, sample_n, sample_prop,
                        sample_names)

    output <- data

  }

  # summary, k reps

  else if (summary == TRUE & replication > 1) {

    output <- replicate(replication, expr = {
      data <- binary_data(sample_rep, sample_n, sample_prop,
                          sample_names)

      summary <- binary_summary(data, sample_rep, sample_n, sample_prop,
                                sample_names, p)

      output <- list(sample = data, proportion_summary = summary$summary, freq.table = summary$freq)
    },
    simplify = FALSE)

  }

  # no summary, k reps

  else if (summary == FALSE & replication > 1) {

    output <- replicate(replication, expr = {
      data <- binary_data(sample_rep, sample_n, sample_prop,
                          sample_names)

      output <- data
    },
    simplify = "array")

  }

  return(output)

}

