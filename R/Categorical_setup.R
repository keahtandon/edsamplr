# What does each function do, and which functions does it export to? Add this for each.

sample_proportion <- function(p, k) {
  if (length(p) == 1) {
    sample_p <- rep(p, k)
  } else {
    sample_p <- p
  }
}

sample_n <- function(n, p) {
  if (length(n) == 1) {
    sample_n <- rep(n, p)
  } else {
    sample_n <- n
  }
}

sample_names <- function(group_names, k) {
  if (length(group_names) == 2) {
    sample_names <- rep(group_names, k)
  } else {
    sample_names <- group_names
  }

  sample_names <- matrix(sample_names, nrow = k, byrow = TRUE)
}

sample_k_rep <- function(k, p) {
  if (length(k) == 1) {
    sample_k_rep <- rep(k, p)
  } else {
    sample_k_rep <- k
  }
}

cat_group_names <- function(group_names, sample_k_rep, k, p) {
  if (length(group_names) == 1) {
    if (group_names == "default") {
      group_names <- "1"
    }

    group_names <- as.vector(unlist(sapply(seq_along(sample_k_rep), function(i) rep(1:sample_k_rep[i]))))

    total_elements <- max(k) * p

    sample_group_names <- as.numeric(rep(NA, total_elements))

    final_counter <- 1

    mid_counter <- 1

    for (i in 1:length(sample_k_rep)) {
      sample_group_names[final_counter:(final_counter + sample_k_rep[i] - 1)] <- group_names[mid_counter:(mid_counter + sample_k_rep[i] - 1)]
      final_counter <- final_counter + max(k)
      mid_counter <- mid_counter + sample_k_rep[i]
    }


    sample_group_names <- matrix(sample_group_names, nrow = p, ncol = max(k), byrow = TRUE)
  } else {
    total_elements <- max(k) * p

    sample_group_names <- as.numeric(rep(NA, total_elements))

    final_counter <- 1

    mid_counter <- 1

    for (i in 1:length(k)) {
      sample_group_names[final_counter:(final_counter + k[i] - 1)] <- group_names[mid_counter:(mid_counter + k[i] - 1)]
      final_counter <- final_counter + max(k)
      mid_counter <- mid_counter + k[i]
    }


    sample_group_names <- matrix(sample_group_names, nrow = p, ncol = max(k), byrow = TRUE)
  }
}

cat_k_prop_division <- function(k_prop, k, p) {
  k_prop_division <- NULL

  if (length(k_prop) == 1) {

    if (k_prop != "equal") {
      stop("Please ensure that the proportions are listed for each group.")
    } else if (k_prop == "equal" & length(k) == 1) {
        k_prop_division <- 1 / k

        k_prop <- rep(k_prop_division, k)

        sample_k_prop <- matrix(rep(k_prop, p), nrow = p, byrow = TRUE)
    } else if (k_prop == "equal" & length(k) == p) {
        k_prop <- rep(1 / k, times = k)

        total_elements <- max(k) * p

        sample_k_prop <- as.numeric(rep(NA, total_elements))

        final_counter <- 1

        mid_counter <- 1

        for (i in 1:length(k)) {
          sample_k_prop[final_counter:(final_counter + k[i] - 1)] <- k_prop[mid_counter:(mid_counter + k[i] - 1)]
          final_counter <- final_counter + max(k)
          mid_counter <- mid_counter + k[i]
        }

        sample_k_prop <- matrix(sample_k_prop, nrow = p, ncol = max(k), byrow = TRUE)
    }
  }  else if (length(k_prop) == sum(k) &
             length(k) %in% c(1, p) & sum(k_prop) == length(k)) {

               if (length(k) == 1) {

                 if (length(k_prop) == k) {
                   k_prop <- rep(k_prop, max(k, p))
                 }
                  k <- sample_k_rep(k, p)
               }

      total_elements <- max(k) * p

      sample_k_prop <- as.numeric(rep(NA, total_elements))

      final_counter <- 1

      mid_counter <- 1

      for (i in 1:length(k)) {
        sample_k_prop[final_counter:(final_counter + k[i] - 1)] <- k_prop[mid_counter:(mid_counter + k[i] - 1)]
        final_counter <- final_counter + max(k)
        mid_counter <- mid_counter + k[i]
      }

    sample_k_prop <- matrix(sample_k_prop, nrow = p, ncol = max(k), byrow = TRUE)
  }


  else {
    stop("Please ensure that the proportions are listed for each group.")
  }
}
