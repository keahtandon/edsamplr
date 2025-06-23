#' @importFrom rlang .data
#' @importFrom magrittr %>%

categorical_data <- function(sample_rep, sample_k_rep, sample_n_rep,
                             sample_k_prop, sample_group_names, k, p, separate) {

  data <- NULL

  new_names <- NULL

  for (i in sample_rep) {
    group_rep <- seq(1:sample_k_rep[i])

    v <- sample(group_rep, sample_n_rep[i],
                replace = TRUE,
                prob = sample_k_prop[i, 1:sample_k_rep[i]]
    )

    length(v) <- max(sample_n_rep)

    data <- cbind(data, v)

    new_name <- paste0("v", i)

    new_names <- c(new_names, new_name)

    data <- as.data.frame(data)

    names(data) <- new_names

    data[, i] <- factor(data[, i],
                        levels = group_rep,
                        labels = sample_group_names[i, 1:sample_k_rep[i]]
    )
  }

  if (separate == TRUE) {

    num_conditions <- stringr::str_count(sample_group_names, "_")

    if (n_distinct(num_conditions) > 1) {
      stop("All group names should have the same number of underscores.")
    }

    condition_names <- c(paste("Condition", seq(1:min(num_conditions))), "Result")

    data <- data %>%
      dplyr::mutate(v1 = as.character(v1)) %>%
      tidyr::separate_wider_delim(v1, names = condition_names, delim = "_") %>%
      dplyr::mutate(dplyr::across(dplyr::everything(), ~ factor(.)))

  }

  return(data)

}

categorical_summary <- function(data, sample_rep, sample_k_rep, sample_n_rep,
                                sample_k_prop, sample_group_names, k, p,
                                separate) {

  summary_rownames <- NULL

  input_counter <- 1
  sample_counter <- 2

  if (separate == FALSE) {

    summary <- matrix(NA, nrow = 2 * p, ncol = max(k) + 2)

    for (i in 1:p) {
      freq_table <- table(data[, i])

      prop_table <- prop.table(freq_table)

      input_row <- c(sample_k_rep[i], sample_n_rep[i], round(sample_k_prop[i, ], 2))

      if (length(input_row) < ncol(summary)) {
        input_row <- c(input_row, rep(NA, ncol(summary) - length(input_row)))
      }

      summary[input_counter, ] <- input_row

      sample_row <- c(nlevels(data[, i]), sample_n_rep[i], unname(round(prop_table, 2)))

      if (length(sample_row) < ncol(summary)) {
        sample_row <- c(sample_row, rep(NA, ncol(summary) - length(sample_row)))
      }

      summary[sample_counter, ] <- sample_row

      summary_rownames <- c(summary_rownames, paste0("input p", i), paste0("sample p", i))

      input_counter <- input_counter + 2
      sample_counter <- sample_counter + 2
    }

    rownames(summary) <- summary_rownames

    colnames(summary) <- c("k", "n", paste0("k", seq(1:max(k))))

  } else {

    p <- ncol(data)
    k <- k/p
    sample_k_prop <- matrix(sample_k_prop, nrow = p, ncol = k, byrow = TRUE)
    sample_k_rep <- rep(k, p)

    sample_n_rep <- data %>%
      dplyr::group_by(data[1]) %>%
      dplyr::count() %>%
      dplyr::ungroup() %>%
      dplyr::pull(n)

    summary <- matrix(NA, nrow = 2 * p, ncol = max(k) + 2)

    for (i in 1:p) {

      freq_table <- table(data[, i])

      prop_table <- prop.table(freq_table)

      input_row <- c(sample_k_rep[i], sample_n_rep[i], round(sample_k_prop[i, ], 2))

      if (length(input_row) < ncol(summary)) {
        input_row <- c(input_row, rep(NA, ncol(summary) - length(input_row)))
      }

      summary[input_counter, ] <- input_row

      sample_row <- c(nlevels(pull(data[, i])), sample_n_rep[i], unname(round(prop_table, 2)))

      if (length(sample_row) < ncol(summary)) {
        sample_row <- c(sample_row, rep(NA, ncol(summary) - length(sample_row)))
      }

      summary[sample_counter, ] <- sample_row

      summary_rownames <- c(summary_rownames, paste0("input p", i), paste0("sample p", i))

      input_counter <- input_counter + 2
      sample_counter <- sample_counter + 2

    }

    rownames(summary) <- summary_rownames

    colnames(summary) <- c("k", "n", paste0("k", seq(1:max(k))))

  }

  return(summary)

}


categorical_output <- function(sample_rep, sample_k_rep, sample_n_rep,
                               sample_k_prop, sample_group_names, k, p,
                               separate, summary, replication) {

  # summary, 1 rep

  if (summary == TRUE & replication == 1) {

    data <- categorical_data(sample_rep, sample_k_rep, sample_n_rep,
                              sample_k_prop, sample_group_names, k, p, separate)

    summary <- categorical_summary(data, sample_rep, sample_k_rep, sample_n_rep,
                                   sample_k_prop, sample_group_names, k, p,
                                   separate)

    output <- list(sample = data, proportion_summary = summary)

  }

  # no summary, 1 rep

  else if (summary == FALSE & replication == 1) {

    output <- categorical_data(sample_rep, sample_k_rep, sample_n_rep,
                              sample_k_prop, sample_group_names, k, p, separate)


  }

  # summary, k reps

  else if (summary == TRUE & replication > 1) {

    output <- replicate(replication, expr = {
      data <- categorical_data(sample_rep, sample_k_rep, sample_n_rep,
                               sample_k_prop, sample_group_names, k, p, separate)

      summary <- categorical_summary(data, sample_rep, sample_k_rep, sample_n_rep,
                                     sample_k_prop, sample_group_names, k, p,
                                     separate)

      output <- list(sample = data, proportion_summary = summary)
      },
      simplify = FALSE)

  }

  # no summary, k reps

  else if (summary == FALSE & replication > 1) {

    output <- replicate(replication, expr = {
      output <- categorical_data(sample_rep, sample_k_rep, sample_n_rep,
                               sample_k_prop, sample_group_names, k, p, separate)

    },
    simplify = "array")

  }

  return(output)

}
