#' @importFrom rlang .data

find_intercorr <- function(k, coeff, corr) {
  # setting initial values

  c0 <- as.vector(coeff[1, ], mode = "numeric")
  c1 <- as.vector(coeff[2, ], mode = "numeric")
  c2 <- as.vector(coeff[3, ], mode = "numeric")
  c3 <- as.vector(coeff[4, ], mode = "numeric")
  c4 <- as.vector(coeff[5, ], mode = "numeric")
  c5 <- as.vector(coeff[6, ], mode = "numeric")

  l <- 0

  inter_corr <- diag(1, k)

  corr_matrix <- matrix(NA, k, k)

  # finding intermediate correlation

  for (i in 1:(k - 1)) {
    for (j in (i + 1):k) {
      l <- l + 1
      rhoY <- corr[i, j]

      # optimization using the eq26, the coefficients, and the correlation

      opt <- stats::nlminb(
        start = rhoY,
        objective = .data$Headrick_rho_eq,
        scale = 10,
        lower = -1,
        upper = 1,
        control = list(
          abs.tol = 1e-20,
          eval.max = 1e5,
          iter.max = 1e3
        ),
        c0 = c0,
        c1 = c1,
        c2 = c2,
        c3 = c3,
        c4 = c4,
        c5 = c5,
        i = i,
        j = j,
        rhoY = rhoY
      )

      if (opt$convergence == 0) {
        inter_corr[i, j] <- opt$par
        inter_corr[j, i] <- opt$par

        corr_matrix[i, j] <- opt$objective
      } else {
        stop("error in solving intermediate correlation")
      }
    }
  }

  return(list(inter.corr = inter_corr, matrix = corr_matrix))
}

solve_intercorr <- function(k, coeff, corr) {
  if (k > 1) {
    corr.match <- .data$Headrick_intermediate_corr(k, coeff, corr)
    inter.corr <- corr.match$inter.corr
    obj.corr.match <- corr.match$matrix


    colnames(inter.corr) <- paste0("Z", 1:ncol(inter.corr))
    rownames(inter.corr) <- paste0("Z", 1:nrow(inter.corr))

    colnames(obj.corr.match) <- paste0("Z", 1:ncol(obj.corr.match))
    rownames(obj.corr.match) <- paste0("Z", 1:nrow(obj.corr.match))

    output <- inter.corr
  } else {
    inter.corr <- corr

    colnames(inter.corr) <- paste0("Z", 1:ncol(inter.corr))
    rownames(inter.corr) <- paste0("Z", 1:nrow(inter.corr))

    output <- inter.corr
  }

  return(output)
}
