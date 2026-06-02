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
#> k 1     0.05 0.89 -0.14     0.36
#> 
#> $sample
#>     Group  Value
#> 1       1  1.937
#> 2       1  0.958
#> 3       1  0.505
#> 4       1  0.272
#> 5       1 -0.430
#> 6       1  0.251
#> 7       1  0.357
#> 8       1 -0.095
#> 9       1 -0.403
#> 10      1 -0.966
#> 11      1 -0.284
#> 12      1  1.329
#> 13      1  0.229
#> 14      1  1.057
#> 15      1 -0.069
#> 16      1 -0.310
#> 17      1  1.914
#> 18      1 -0.404
#> 19      1 -0.414
#> 20      1 -0.132
#> 21      1  0.577
#> 22      1 -1.146
#> 23      1 -0.229
#> 24      1  0.003
#> 25      1  1.793
#> 26      1 -0.101
#> 27      1  0.866
#> 28      1 -1.016
#> 29      1  1.727
#> 30      1  1.264
#> 31      1  1.082
#> 32      1  0.115
#> 33      1 -2.772
#> 34      1 -0.458
#> 35      1  0.039
#> 36      1 -0.295
#> 37      1  1.658
#> 38      1  0.014
#> 39      1  0.436
#> 40      1 -1.717
#> 41      1 -0.395
#> 42      1  0.799
#> 43      1  0.247
#> 44      1 -0.497
#> 45      1  1.114
#> 46      1 -0.212
#> 47      1 -0.959
#> 48      1 -0.028
#> 49      1  0.790
#> 50      1  0.289
#> 51      1  0.801
#> 52      1  0.018
#> 53      1  1.815
#> 54      1 -0.326
#> 55      1  0.945
#> 56      1 -0.794
#> 57      1 -1.715
#> 58      1  0.309
#> 59      1  0.412
#> 60      1 -0.382
#> 61      1 -0.767
#> 62      1  0.123
#> 63      1 -0.334
#> 64      1  0.762
#> 65      1 -1.774
#> 66      1 -0.226
#> 67      1  0.677
#> 68      1  1.266
#> 69      1 -0.228
#> 70      1  1.057
#> 71      1  0.217
#> 72      1 -0.381
#> 73      1 -0.445
#> 74      1 -0.383
#> 75      1 -0.655
#> 76      1  0.280
#> 77      1  1.402
#> 78      1 -0.713
#> 79      1 -0.105
#> 80      1 -0.082
#> 81      1  0.085
#> 82      1 -0.194
#> 83      1 -0.610
#> 84      1  0.334
#> 85      1  0.591
#> 86      1 -0.771
#> 87      1 -0.546
#> 88      1  1.443
#> 89      1 -0.617
#> 90      1  0.727
#> 91      1 -0.496
#> 92      1 -0.499
#> 93      1  0.638
#> 94      1 -0.185
#> 95      1 -0.573
#> 96      1 -1.037
#> 97      1  0.275
#> 98      1  1.192
#> 99      1 -1.245
#> 100     1 -2.087
#> 

generate_quantitative(k = 2,
                      effect_size = 0.3,
                      use_effect_size = TRUE)
#> $summary
#>         mean   sd skew kurtosis
#> input 1 0.00 1.00 0.00     0.00
#> k 1     0.05 0.98 0.17    -0.23
#> input 2 0.30 1.00 0.00     0.00
#> k 2     0.30 1.03 0.06     0.11
#> 
#> $sample
#> # A tibble: 200 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1      0.365
#>  2 1     -0.668
#>  3 1     -0.949
#>  4 1      0.514
#>  5 1      0.535
#>  6 1     -1.16 
#>  7 1     -0.5  
#>  8 1      0.679
#>  9 1     -1.72 
#> 10 1     -0.773
#> # ℹ 190 more rows
#> 

generate_quantitative(k = 2,
                      skew = c(0.4, 0.25))
#> $summary
#>          mean   sd  skew kurtosis
#> input 1  0.00 1.00  0.40     0.00
#> k 1      0.02 0.97 -0.04    -0.11
#> input 2  0.00 1.00  0.25     0.00
#> k 2     -0.08 1.03  0.70     1.55
#> 
#> $sample
#> # A tibble: 200 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1     -0.871
#>  2 1     -0.114
#>  3 1      0.391
#>  4 1      0.157
#>  5 1      0.494
#>  6 1     -1.65 
#>  7 1      0.091
#>  8 1      0.304
#>  9 1      0.698
#> 10 1      0.725
#> # ℹ 190 more rows
#> 

generate_quantitative(k = 3,
                      n = c(100, 150, 200))
#> $summary
#>           n  mean   sd  skew kurtosis
#> input 1 100  0.00 1.00  0.00     0.00
#> k 1     100 -0.15 0.94  0.00     0.55
#> input 2 150  0.00 1.00  0.00     0.00
#> k 2     150  0.15 1.04 -0.22     0.80
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
