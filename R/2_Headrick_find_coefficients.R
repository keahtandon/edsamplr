#' @export


find_coefficients <- function(gam1, gam2, gam3, gam4,
                              max.ntry = 10,
                              obj.tol = 1e-10,
                              n.valid.sol = 1) {
  gammas <- c(gam1, gam2, gam3, gam4)

  # set starting vectors and list

  OPT <- list()
  ntry <- 0
  cnt <- 0

  # loop to try and converge Headrick's equations

  while (ntry < max.ntry) {
    ntry <- ntry + 1
    start <- stats::rnorm(6, sd = .5)

    # optimization using the equations and gamma values

    opt <- stats::nlminb(
      start = start,
      objective = headrick_coef_eqs,
      scale = 10,
      lower = -2,
      upper = 2,
      control = list(
        abs.tol = 1e-20,
        rel.tol = 1e-15,
        eval.max = 1e6,
        iter.max = 1e6
      ),
      gamma = gammas
    )

    # if the convergence is successful and the equation output are within the tolerance,
    # add 1 to the count and add the optimization output to the list

    if (opt$convergence == 0 && opt$objective <= obj.tol) {
      cnt <- cnt + 1
      OPT[[cnt]] <- opt
    }

    # stop the loop when enough valid solutions have been found

    if (length(OPT) >= n.valid.sol || (opt$objective <= min(1e-15, obj.tol) && opt$convergence == 0)) {
      break
    }
  }

  # if no valid solutions were found after the maximum number of attempts, return the message

  if (length(OPT) == 0) {
    return(NULL)
    stop(paste("cannot find the coefficients of polynomial after", max.ntry, "attempts"))
  }

  # if the objective value is less than the specified minimum objective value,
  # overwrite the minimum objective value

  min.obj <- 1e20
  idx <- -1

  for (i in 1:length(OPT)) {
    if (OPT[[i]]$objective < min.obj) {
      min.obj <- OPT[[i]]$objective
      idx <- i
    }
  }

  # return the best set of parameters for the specified gammas and the minimum objective value

  coeff <- OPT[[idx]]$par

  return(list(coeff = coeff, min.obj = min.obj))
}
