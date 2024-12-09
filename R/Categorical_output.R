#' @importFrom rlang .data

# What does each function do, and which functions does it export to? Add this for each.

proportions_loop <- function(sample_rep, sample_n, sample_p,
                             sample_names, k, replication) {
  if (replication > 1) {
    output <- vector("list", replication)

    for (j in 1:replication) {
      data <- NULL

      p_hat <- NULL

      x <- NULL

      new_names <- NULL

      for (i in sample_rep) {
        v <- stats::rbinom(sample_n[i], 1, sample_p[i])

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

      matrix_names <- paste("sample", seq(1:k))

      summary <- matrix(c(sample_n, x, round(p_hat, 2), sample_p),
        nrow = k, ncol = 4,
        dimnames = list(matrix_names, c("sample size", "successes", "sample proportion", "population proportion"))
      )


      freq <- matrix(c(x, sample_n - x),
        nrow = k, ncol = 2,
        dimnames = list(matrix_names, c("successes", "failures"))
      )

      inter_output <- list(summary = summary, sample = data, freq.table = freq)

      output[[j]] <- inter_output
    }
  } else {
    data <- NULL

    p_hat <- NULL

    x <- NULL

    new_names <- NULL

    for (i in sample_rep) {
      v <- stats::rbinom(sample_n[i], 1, sample_p[i])

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

    matrix_names <- paste("sample", seq(1:k))

    summary <- matrix(c(sample_n, x, round(p_hat, 2), sample_p),
      nrow = k, ncol = 4,
      dimnames = list(matrix_names, c("sample size", "successes", "sample proportion", "population proportion"))
    )


    freq <- matrix(c(x, sample_n - x),
      nrow = k, ncol = 2,
      dimnames = list(matrix_names, c("successes", "failures"))
    )

    output <- list(summary = summary, sample = data, freq.table = freq)
  }

  return(output)
}

categorical_loop <- function(sample_rep, sample_group_rep, sample_n_rep,
                             sample_group_prop, sample_group_names, k, p,
                             replication) {
  if (replication > 1) {
    output <- vector("list", replication)

    for (j in 1:replication) {
      data <- NULL

      new_names <- NULL

      for (i in sample_rep) {
        group_rep <- seq(1:sample_group_rep[i])

        v <- sample(group_rep, sample_n_rep[i],
          replace = TRUE,
          prob = sample_group_prop[i, 1:sample_group_rep[i]]
        )

        length(v) <- max(sample_n_rep)

        data <- cbind(data, v)

        new_name <- paste0("v", i)

        new_names <- c(new_names, new_name)

        data <- as.data.frame(data)

        names(data) <- new_names

        data[, i] <- factor(data[, i],
          levels = group_rep,
          labels = sample_group_names[i, 1:sample_group_rep[i]]
        )
      }

      # matrix

      summary_rownames <- NULL

      summary <- matrix(NA, nrow = 2 * p, ncol = max(k) + 2)

      input_counter <- 1
      sample_counter <- 2

      for (i in 1:p) {
        freq_table <- table(data[, i])

        prop_table <- prop.table(freq_table)

        input_row <- c(sample_group_rep[i], sample_n_rep[i], round(sample_group_prop[i, ], 2))

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

      inter_output <- list(sample = data, proportion_summary = summary)

      output[[j]] <- inter_output
    }
  } else {
    data <- NULL

    new_names <- NULL

    for (i in sample_rep) {
      group_rep <- seq(1:sample_group_rep[i])

      v <- sample(group_rep, sample_n_rep[i],
        replace = TRUE,
        prob = sample_group_prop[i, 1:sample_group_rep[i]]
      )

      length(v) <- max(sample_n_rep)

      data <- cbind(data, v)

      new_name <- paste0("v", i)

      new_names <- c(new_names, new_name)

      data <- as.data.frame(data)

      names(data) <- new_names

      data[, i] <- factor(data[, i],
        levels = group_rep,
        labels = sample_group_names[i, 1:sample_group_rep[i]]
      )
    }

    # matrix

    summary_rownames <- NULL

    summary <- matrix(NA, nrow = 2 * p, ncol = max(k) + 2)

    input_counter <- 1
    sample_counter <- 2

    for (i in 1:p) {
      freq_table <- table(data[, i])

      prop_table <- prop.table(freq_table)

      input_row <- c(sample_group_rep[i], sample_n_rep[i], round(sample_group_prop[i, ], 2))

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

    output <- list(sample = data, proportion_summary = summary)
  }

  return(output)
}
