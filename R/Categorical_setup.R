# What does each function do, and which functions does it export to? Add this for each.

sample_proportion <- function(p, k) {
  if (length(p) == 1) {
    sample_p <- rep(p, k)
  } else {
    sample_p <- p
  }
}

sample_n <- function(n, k) {
  if (length(n) == 1) {
    sample_n <- rep(n, k)
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

sample_group_rep <- function(groups, k) {
  if (length(groups) == 1) {
    sample_group_rep <- rep(groups, k)
  } else {
    sample_group_rep <- groups
  }
}

cat_group_names <- function(group_names, sample_group_rep, groups, k) {
  if (length(group_names) == 1) {
    if (group_names == "default") {
      group_names <- "1"
    }

    group_names <- as.vector(unlist(sapply(seq_along(sample_group_rep), function(i) rep(1:sample_group_rep[i]))))

    total_elements <- max(groups) * k

    sample_group_names <- as.numeric(rep(NA, total_elements))

    final_counter <- 1

    mid_counter <- 1

    for (i in 1:length(sample_group_rep)) {
      sample_group_names[final_counter:(final_counter + sample_group_rep[i] - 1)] <- group_names[mid_counter:(mid_counter + sample_group_rep[i] - 1)]
      final_counter <- final_counter + max(groups)
      mid_counter <- mid_counter + sample_group_rep[i]
    }


    sample_group_names <- matrix(sample_group_names, nrow = k, ncol = max(groups), byrow = TRUE)
  } else {
    total_elements <- max(groups) * k

    sample_group_names <- as.numeric(rep(NA, total_elements))

    final_counter <- 1

    mid_counter <- 1

    for (i in 1:length(groups)) {
      sample_group_names[final_counter:(final_counter + groups[i] - 1)] <- group_names[mid_counter:(mid_counter + groups[i] - 1)]
      final_counter <- final_counter + max(groups)
      mid_counter <- mid_counter + groups[i]
    }


    sample_group_names <- matrix(sample_group_names, nrow = k, ncol = max(groups), byrow = TRUE)
  }
}

cat_group_prop_division <- function(group_prop, groups, k) {
  group_prop_division <- NULL

  if (length(group_prop) == 1) {

    if (group_prop != "equal") {
      stop("Please ensure that the proportions are listed for each group.")
    } else if (group_prop == "equal" & length(groups) == 1) {
        group_prop_division <- 1 / groups

        group_prop <- rep(group_prop_division, groups)

        sample_group_prop <- matrix(rep(group_prop, k), nrow = k, byrow = TRUE)
    } else if (group_prop == "equal" & length(groups) == k) {
        group_prop <- rep(1 / groups, times = groups)

        total_elements <- max(groups) * k

        sample_group_prop <- as.numeric(rep(NA, total_elements))

        final_counter <- 1

        mid_counter <- 1

        for (i in 1:length(groups)) {
          sample_group_prop[final_counter:(final_counter + groups[i] - 1)] <- group_prop[mid_counter:(mid_counter + groups[i] - 1)]
          final_counter <- final_counter + max(groups)
          mid_counter <- mid_counter + groups[i]
        }

        sample_group_prop <- matrix(sample_group_prop, nrow = k, ncol = max(groups), byrow = TRUE)
    }
  }  else if (length(group_prop) == sum(groups) &
             length(groups) %in% c(1, k) & sum(group_prop) == length(groups)) {

               if (length(groups) == 1) {

                 if (length(group_prop) == groups) {
                   group_prop <- rep(group_prop, max(groups, k))
                 }
                  groups <- sample_group_rep(groups, k)
               }

      total_elements <- max(groups) * k

      sample_group_prop <- as.numeric(rep(NA, total_elements))

      final_counter <- 1

      mid_counter <- 1

      for (i in 1:length(groups)) {
        sample_group_prop[final_counter:(final_counter + groups[i] - 1)] <- group_prop[mid_counter:(mid_counter + groups[i] - 1)]
        final_counter <- final_counter + max(groups)
        mid_counter <- mid_counter + groups[i]
      }

    sample_group_prop <- matrix(sample_group_prop, nrow = k, ncol = max(groups), byrow = TRUE)
  }


  else {
    stop("Please ensure that the proportions are listed for each group.")
  }
}
