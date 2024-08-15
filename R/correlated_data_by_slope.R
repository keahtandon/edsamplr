# This function returns a correlated bivariate data set with a specified slope and correlation.

# The 1st, 3rd, and 4th moments of the second variable can be left out of the input if they are the same as the first variable's.
# The variance of the second variable will be calculated based on the rest of the inputs.

# Input the absolute value of the desired slope.

corr_slope <- function (x_moments = c(sample_mean = 0, sample_variance = 1, sample_skew = 0, sample_kurtosis = 0),
                        y_moments = c(sample_mean = NA, sample_skew = NA, sample_kurtosis = NA), 
                        slope = 1, r = 0.5, n = 100, seed = 1234) {
  
  # distribution of first sample
  
  requireNamespace("SimMultiCorrData", quietly = TRUE)
  requireNamespace("psych", quietly = TRUE)
  
  sink(nullfile())
  
  dist1 <- SimMultiCorrData::nonnormvar1(method = "Fleishman", 
                       means = x_moments[1],
                       vars = x_moments[2],
                       skews = x_moments[3], 
                       skurts = x_moments[4],
                       n = n,
                       seed = seed)
  
  sink()
  
  if (dist1$valid.pdf == "FALSE")
    stop(paste0("\n These values of skew and kurtosis do not generate a valid PDF. \nOne or both must be changed to generate data with a valid PDF."))
  
  
  dist1_data <- dist1$continuous_variable$V1
  
  sx <- stats::sd(dist1_data)
  
  sy <- (sx*slope)/r
  
  vy <- sy^2
  
  if (!is.na(y_moments["sample_mean"])) {
    y_moments["sample_mean"]
  } else {
    y_moments["sample_mean"]<-x_moments["sample_mean"]
  }
  
  if (!is.na(y_moments["sample_skew"])) {
    y_moments["sample_skew"]
  } else {
    y_moments["sample_skew"]<-x_moments["sample_skew"]
  }
  
  if (!is.na(y_moments["sample_kurtosis"])) {
    y_moments["sample_kurtosis"]
  } else {
    y_moments["sample_kurtosis"]<-x_moments["sample_kurtosis"]
  }
  
  cormeans <- c(x_moments[["sample_mean"]],y_moments[["sample_mean"]])
  
  corvars <- c(x_moments[["sample_variance"]],vy)
  
  corskews <- c(x_moments[["sample_skew"]],y_moments[["sample_skew"]])
  
  corkurts <- c(x_moments[["sample_kurtosis"]],y_moments[["sample_kurtosis"]])
  
  rho <- matrix(c(1, r, r, 1), ncol = 2)
  
  sink(nullfile())
  
  dist_all <- SimMultiCorrData::rcorrvar(n=n, k_cont = 2, method = "Fleishman", 
                   means = cormeans, vars = corvars, skews = corskews, skurts = corkurts, 
                   rho = rho)
  dist <- dist_all$continuous_variables
  
  sink()
  
  # stats
  
  stats <- psych::describe(dist$V1)
  
  stats2 <- psych::describe(dist$V2)
  
  # matrix
  
  summary <- matrix(c(cormeans[1],
                      sqrt(corvars[1]),
                      corskews[1],
                      corkurts[1],
                      cormeans[2],
                      sy,
                      corskews[2],
                      corkurts[2],
                      round(stats$mean,2), 
                      round(stats$sd,2), 
                      round(stats$skew,2), 
                      round(stats$kurtosis,2),
                      round(stats2$mean,2), 
                      round(stats2$sd,2), 
                      round(stats2$skew,2), 
                      round(stats2$kurtosis,2)), 
                    nrow = 4, ncol = 4, byrow = TRUE,
                    dimnames = list(c("x input", "y input","V1", "V2"),
                                    c("mean", "sd", "skew", "kurtosis")))
  
  r <- stats::cor(dist$V1, dist$V2)
  
  model <- stats::lm(dist$V2 ~ dist$V1)
  
  slope <- round(model$coefficients[[2]])
  
  # final return
  
  return(list(correlation = r, slope = slope ,summary = summary, sample = dist))
  
  
}

