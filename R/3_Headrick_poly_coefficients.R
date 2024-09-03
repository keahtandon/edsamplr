#' @export

find_poly_coefficients <- function(k, skewness, kurtosis,
                                   gam3 = NaN, gam4 = NaN,
                                   max.ntry = 5, obj.tol = 1e-10, n.valid.sol = 1) {
  # set initial variables

  start <- Sys.time()

  default_gam3 <- FALSE
  default_gam4 <- FALSE

  # set the default gamma 3 and 4 values if not inputted by user

  if (is.nan(gam3[1])) {
    gam3 <- pmax(skewness, kurtosis)
    default_gam3 <- TRUE
  }

  if (is.nan(gam4[1])) {
    gam4 <- pmax(skewness, kurtosis)^2
    default_gam4 <- TRUE
  }

  # setting up input variables to match the number of distributions needed

  len <- c(length(skewness), length(kurtosis), length(gam3), length(gam4))

  if (len[1] == 1) {
    skewness <- rep(skewness, k)
    kurtosis <- rep(kurtosis, k)
    gam3 <- rep(gam3, k)
    gam4 <- rep(gam4, k)
  }

  # make sure the skewness and kurtosis values fit the restrictions of the method

  for (i in 1:k) {
    if (kurtosis[i] <= skewness[i]^2 - 2) {
      cat("Error: the ", i, " th component of kurtosis is not bigger than skewness squared minus 2.\n")
    }
  }

  # solve for the coefficients

  coeff <- NULL
  obj.poly.coeff <- NULL
  poly.coeff <- NULL
  gam3_fit <- rep(0, k)
  gam4_fit <- rep(0, k)

  # will need to load in Headrick's tables and write code to search them before running; refer to OA/rHeadrick for the if/else

  # if the default gamma 3 and 4 are used, run this.
  # loop to get coefficients for each set of moments

  for (i in 1:k) {
    if (default_gam3 && default_gam4) {
      j <- 1
      j3 <- 1
      poly.coeff <- NULL
      upper <- 4
      step_size <- 4
      iterations <- 0

      # loop to run the find_coefficients function

      while (j <= 15 && j3 <= 15 && is.null(poly.coeff)) {
        iterations <- iterations + 1
        tic <- Sys.time()
        gam3_fit[i] <- gam3[i] / 2 * 2^j3
        gam4_fit[i] <- gam4[i] / 2 * 2^j

        poly.coeff <- find_coefficients(
          gam1 = skewness, gam2 = kurtosis,
          gam3 = gam3_fit[i], gam4 = gam4_fit[i],
          max.ntry = max.ntry, obj.tol = obj.tol,
          n.valid.sol = n.valid.sol
        )


        if (is.null(poly.coeff)) {
          j3 <- j3 + 1

          if (j3 == upper + 1 && j < upper) {
            j3 <- 1
            j <- j + 1
          }

          # if there is not a successful convergence, what next?

          else if (j3 == upper + 1 && j == upper) {
            input <- "y"
            cat("No solutions found after ", iterations, " iterations. Do you want to continue searching? (y/n)\n", sep = "")
            input <- readline()

            while (input != "y" && input != "n" && input != "Y" && input != "N") {
              cat("Invalid input. Please try again.\n")
              input <- readline()
            }

            if (input == "y" || input == "Y") {
              j3 <- 1
              j <- j + 1
              upper <- upper + step_size
            }
            if (input == "n" || input == "N") {
              break
            }
          }
        }
      }

      # next steps if a solution was found

      if (!is.null(poly.coeff)) {
        curr.coeff <- poly.coeff$coeff
        curr.obj <- poly.coeff$min.obj
        to_append <- matrix(c(
          skewness[i], kurtosis[i], curr.obj,
          gam3_fit[i], gam4_fit[i], curr.coeff
        ), nrow = 1)
        # write.table(to_append, "compiled.txt",append = T, row.names = F, col.names = F)
      }

      # next steps if a solution was not found

      if (is.null(poly.coeff)) {
        cat("Error: no solution found for the combination of skewness: ", skewness[i], "; kurtosis: ",
          kurtosis[i], ".\n",
          sep = ""
        )
        return(NULL)
      }
    }

    # if the user inputted gamma 3 and 4 values, do this.

    else {
      gam3_fit[i] <- gam3[i]
      gam4_fit[i] <- gam4[i]
      poly.coeff <- find_coefficients(
        gam1 = skewness, gam2 = kurtosis,
        gam3 = gam3_fit[i], gam4 = gam4_fit[i],
        max.ntry = max.ntry, obj.tol = obj.tol,
        n.valid.sol = n.valid.sol
      )

      if (is.null(poly.coeff)) {
        cat("Error: no solution found for the combination of skewness: ", skewness[i], "; kurtosis: ",
          kurtosis[i], " gam3: ", gam3_fit[i], "; gam4: ", gam4_fit[i], ".\n",
          sep = ""
        )
      } else {
        curr.coeff <- poly.coeff$coeff
        curr.obj <- poly.coeff$min.obj
        to_append <- matrix(c(
          skewness[i], kurtosis[i], curr.obj,
          gam3_fit[i], gam4_fit[i], curr.coeff
        ), nrow = 1)
        # write.table(to_append, "compiled.txt",append = T, row.names = F, col.names = F)
      }
    }

    coeff <- c(coeff, curr.coeff)
    obj.poly.coeff <- c(obj.poly.coeff, curr.obj)
  }

  # converting the coefficients into a matrix

  coeff <- matrix(coeff, nrow = 6)

  colnames(coeff) <- paste0("Distribution ", 1:ncol(coeff))
  rownames(coeff) <- paste0("c", 0:5)

  return(coefficients = coeff)
}
