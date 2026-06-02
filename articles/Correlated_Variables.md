# Simulating Data with Correlated Variables

``` r

#library(edsamplr)
#library(tidyverse)
#library(gt)
```

### Introduction

Imagine you are teaching your students about working with correlated
data. You want to give your students a real-life example from published
research, but the article that you have readily available involves
interaction. You decide that you are going to simulate data based on one
of the explanatory variables and the response variable instead of
searching for a different article.

### Article Abstract

The first objective of this study was to investigate the association
between work-home interaction (a process in which functioning in one of
the two domains is positively or negatively influenced by the other
domain) and teachers’ life satisfaction. The second objective was to
test the moderating role of teachers’ core-self evaluations
(self-esteem, self-efficacy, locus of control, and neuroticism) in the
relationship between work-home interaction and life satisfaction. A
cross-sectional study was conducted on a sample of 168 Romanian
teachers. Results indicated that positive work-home interactions
(situations in which aspects from work facilitate functioning at home
and vice versa) are positively related to life satisfaction only for
teachers with low core-self evaluations. Negative work-home interactions
(situations in which aspects from work interfere with functioning at
home and vice versa) were negatively related with teachers’ life
satisfaction, but core self-evaluations did not moderate these
relationships. Theoretical and practical implications are discussed.
(Nastasa et al. 2020)

### Selected Variables to Sample From

Nastasa and colleagues (2020) had multiple research questions and a much
more complex design than you need for your class, so after looking at
their descriptive statistics table (Table 1), you decide to focus on
self-evaluation and life satisfaction.

  

[TABLE]

*Note*: Cronbach’s alpha reliabilities are in parentheses on the
diagonal, /**p*\<.05, /*/**p\*\<.01. (Nastasa et al. 2020)

  

**Explanatory variable**: Self-evaluation

**Response variable**: Life satisfaction

``` r

selected_vars <- data.frame(Variable = c("Self-Evaluation", "Life Satisfaction"),
                            N = c(186, 186),
                            Mean = c(4.08, 5.64),
                            Var = c(0.48^2, 0.87^2),
                            Cor = c(0.58, NA))

selected_vars
#>            Variable   N Mean    Var  Cor
#> 1   Self-Evaluation 186 4.08 0.2304 0.58
#> 2 Life Satisfaction 186 5.64 0.7569   NA
```

You can use the
[`generate_correlated()`](https://keahtandon.github.io/edsamplr/reference/generate_correlated.md)
function to simulate data that will resemble this.

Since I already created a data frame with the selected variable
information, I can plug that in. Because we have variances for both
variables, we want to make sure to indicate use_slope = FALSE.

``` r

output <- generate_correlated(n = selected_vars$N[1],
                              mean = selected_vars$Mean,
                              var = selected_vars$Var,
                              r = selected_vars$Cor[1],
                              use_slope = FALSE)
```

With the default summary argument (TRUE), our output provides a list
with four elements:

- The correlation of the simulated sample

- The slope of the simulated sample

- The summary statistics of our input “parameters” (statistics from the
  study) and the resulting sample

- The sample data

``` r

data <- output$sample

output$correlation
#> [1] 0.68
output$slope
#> [1] 1.29
output$summary
#>         mean   sd  skew kurtosis
#> input 1 4.08 0.48  0.00     0.00
#> k 1     4.07 0.51 -0.13    -0.25
#> input 2 5.64 0.87  0.00     0.00
#> k 2     5.59 0.96  0.15     0.17
```

If we just want the sample data, we can turn off the summary and just
get a data frame with the simulated data.

If you’re happy with the final product, you’re ready to export the data
for your students. If you’d like to try to get it closer to the original
data, you can rerun the function.

### References

Nastasa, Monica, Florinda Golu, Diana Buruiana, and Bogdan Oprea. 2020.
“Teachers’ Work–Home Interaction and Satisfaction with Life: The
Moderating Role of Core Self-Evaluations.” *Educational Psychology* 141:
806–20. <https://doi.org/10.1080/01443410.2020.1852182>.
