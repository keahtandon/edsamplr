# Generate k groups of quantitative data with optional standardized effect

`generate_quantitative()` is a function to generate k groups of
quantitative data with specified first four moments and optional
standardized effect

## Usage

``` r
generate_quantitative(
  k = 1,
  mean = 0,
  var = 1,
  skew = 0,
  kurt = 0,
  n = 100,
  effect_size = 0,
  k_names = seq(1:k),
  use_effect_size = FALSE,
  summary = TRUE,
  decimals = 3,
  seed = 1234,
  replication = 1
)
```

## Arguments

- k:

  A numeric vector for the number of groups to generate data for. The
  default value is 1.

- mean:

  A numeric vector for the population mean of the first variable. The
  default value is 0.

- var:

  A numeric vector for the population variance of the first variable.
  The default value is 1.

- skew:

  A numeric vector for the population skew of the variables. Separate
  values of skew can be entered. The default value is 0.

- kurt:

  A numeric vector for the population kurtosis of the variables.
  Separate values of kurtosis can be entered. The default value is 0.

- n:

  A numeric vector for the sample size. Separate values of n can be
  entered for an unbalanced design. The default value is 100.

- effect_size:

  An optional numeric vector for the standardized effect size between
  groups of data.

- k_names:

  An optional character vector for naming successes and failures. The
  default values are 1:k.

- use_effect_size:

  A logical vector to indicate whether to use a standardized effect size
  in generating data for k when k \>= 2. The default value is FALSE.

- summary:

  A logical vector for whether the return should include summary
  statistics. The default value is TRUE.

- decimals:

  A numeric vector for the number of decimals to round the sample data
  to. The default value is 3.

- seed:

  A numeric vector for use in generating unbalanced distributions. The
  default value is 1234.

- replication:

  A numeric vector for the number of times to replicate the sampling.
  The default value is 1.

## Value

If summary = TRUE, a list containing a matrix ("summary") of the input
parameters and descriptive statistics and a data frame ("sample") with n
rows and 2 columns.

If summary = FALSE, a data frame with n rows and 2 columns.

## Details

This function generates sample data based on specified mean, variance,
skew, and kurtosis parameters for one or multiple groups. The default
values are from a standard normal distribution. If generating samples
for multiple groups, the options include specifying parameters for each
of the groups or specifying a standardized effect size. If specifying a
standardized effect size, then the distribution of values of the
subsequent groups are shifted by that much. The data is sampled from the
specified proportions as a parameter, so the output statistics will not
be an exact match to the parameters.

Because the output is a sample, the summary argument allows for summary
statistics to be generated with the sample data. This allows the user to
easily compare the simulation statistics to the specified parameters.

This is useful for teaching statistics because it allows for generating
data that can be used for teaching both parametric and nonparametric
tests with 2-k groups and for demonstrating the effect of an
intervention. The replication argument is useful when teaching about
sampling distributions or the data dependence of statistics.

## Examples

``` r
generate_quantitative()
#> $summary
#>         mean   sd  skew kurtosis
#> input 1 0.00 1.00  0.00     0.00
#> k 1     0.05 0.89 -0.16     0.28
#> 
#> $sample
#>     Group  Value
#> 1       1  1.878
#> 2       1  0.977
#> 3       1  0.528
#> 4       1  0.286
#> 5       1 -0.451
#> 6       1  0.265
#> 7       1  0.375
#> 8       1 -0.100
#> 9       1 -0.423
#> 10      1 -0.985
#> 11      1 -0.299
#> 12      1  1.326
#> 13      1  0.241
#> 14      1  1.072
#> 15      1 -0.073
#> 16      1 -0.326
#> 17      1  1.857
#> 18      1 -0.424
#> 19      1 -0.434
#> 20      1 -0.139
#> 21      1  0.601
#> 22      1 -1.156
#> 23      1 -0.241
#> 24      1  0.003
#> 25      1  1.747
#> 26      1 -0.107
#> 27      1  0.889
#> 28      1 -1.033
#> 29      1  1.688
#> 30      1  1.266
#> 31      1  1.096
#> 32      1  0.122
#> 33      1 -2.835
#> 34      1 -0.480
#> 35      1  0.041
#> 36      1 -0.311
#> 37      1  1.625
#> 38      1  0.014
#> 39      1  0.457
#> 40      1 -1.678
#> 41      1 -0.414
#> 42      1  0.823
#> 43      1  0.261
#> 44      1 -0.520
#> 45      1  1.126
#> 46      1 -0.224
#> 47      1 -0.978
#> 48      1 -0.030
#> 49      1  0.814
#> 50      1  0.305
#> 51      1  0.825
#> 52      1  0.019
#> 53      1  1.767
#> 54      1 -0.343
#> 55      1  0.965
#> 56      1 -0.818
#> 57      1 -1.676
#> 58      1  0.325
#> 59      1  0.433
#> 60      1 -0.401
#> 61      1 -0.791
#> 62      1  0.130
#> 63      1 -0.351
#> 64      1  0.786
#> 65      1 -1.730
#> 66      1 -0.238
#> 67      1  0.702
#> 68      1  1.268
#> 69      1 -0.241
#> 70      1  1.072
#> 71      1  0.228
#> 72      1 -0.400
#> 73      1 -0.466
#> 74      1 -0.402
#> 75      1 -0.680
#> 76      1  0.295
#> 77      1  1.392
#> 78      1 -0.738
#> 79      1 -0.110
#> 80      1 -0.087
#> 81      1  0.090
#> 82      1 -0.205
#> 83      1 -0.634
#> 84      1  0.351
#> 85      1  0.615
#> 86      1 -0.796
#> 87      1 -0.570
#> 88      1  1.430
#> 89      1 -0.642
#> 90      1  0.751
#> 91      1 -0.519
#> 92      1 -0.522
#> 93      1  0.662
#> 94      1 -0.195
#> 95      1 -0.597
#> 96      1 -1.054
#> 97      1  0.290
#> 98      1  1.199
#> 99      1 -1.249
#> 100     1 -2.017
#> 

generate_quantitative(k = 2,
                      effect_size = 0.3,
                      use_effect_size = TRUE)
#> $summary
#>         mean   sd skew kurtosis
#> input 1 0.00 1.00 0.00     0.00
#> k 1     0.05 0.99 0.20    -0.07
#> input 2 0.30 1.00 0.00     0.00
#> k 2     0.31 1.03 0.09     0.33
#> 
#> $sample
#> # A tibble: 200 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1      0.347
#>  2 1     -0.643
#>  3 1     -0.928
#>  4 1      0.491
#>  5 1      0.512
#>  6 1     -1.15 
#>  7 1     -0.478
#>  8 1      0.654
#>  9 1     -1.77 
#> 10 1     -0.748
#> # ℹ 190 more rows
#> 

generate_quantitative(k = 2,
                      skew = c(0.4, 0.25))
#> $summary
#>          mean   sd  skew kurtosis
#> input 1  0.00 1.00  0.40     0.00
#> k 1      0.02 0.97 -0.01    -0.03
#> input 2  0.00 1.00  0.25     0.00
#> k 2     -0.08 1.03  0.70     1.55
#> 
#> $sample
#> # A tibble: 200 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1     -0.853
#>  2 1     -0.1  
#>  3 1      0.376
#>  4 1      0.155
#>  5 1      0.475
#>  6 1     -1.73 
#>  7 1      0.093
#>  8 1      0.294
#>  9 1      0.672
#> 10 1      0.699
#> # ℹ 190 more rows
#> 

generate_quantitative(k = 3,
                      n = c(100, 150, 200))
#> $summary
#>           n  mean   sd  skew kurtosis
#> input 1 100  0.00 1.00  0.00     0.00
#> k 1     100 -0.15 0.94  0.00     0.55
#> input 2 150  0.00 1.00  0.00     0.00
#> k 2     150  0.15 1.03 -0.16     0.58
#> input 3 200  0.00 1.00  0.00     0.00
#> k 3     200  0.00 1.02 -0.23     0.12
#> 
#> $sample
#> # A tibble: 600 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1      0.289
#>  2 1     -0.605
#>  3 1     -0.873
#>  4 1     -0.635
#>  5 1     -2.35 
#>  6 1     -1.16 
#>  7 1     -0.273
#>  8 1      0.635
#>  9 1     -2.81 
#> 10 1     -0.652
#> # ℹ 590 more rows
#> 

```
