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
#>          mean  sd skew kurtosis
#> input 1  0.00 1.0 0.00     0.00
#> k 1     -0.07 0.9 0.13    -0.02
#> 
#> $sample
#>     Group  Value
#> 1       1  1.266
#> 2       1 -0.228
#> 3       1  1.057
#> 4       1  0.217
#> 5       1 -0.381
#> 6       1 -0.445
#> 7       1 -0.383
#> 8       1 -0.655
#> 9       1  0.280
#> 10      1  1.402
#> 11      1 -0.713
#> 12      1 -0.105
#> 13      1 -0.082
#> 14      1  0.085
#> 15      1 -0.194
#> 16      1 -0.610
#> 17      1  0.334
#> 18      1  0.591
#> 19      1 -0.771
#> 20      1 -0.546
#> 21      1  1.443
#> 22      1 -0.617
#> 23      1  0.727
#> 24      1 -0.496
#> 25      1 -0.499
#> 26      1  0.638
#> 27      1 -0.185
#> 28      1 -0.573
#> 29      1 -1.037
#> 30      1  0.275
#> 31      1  1.192
#> 32      1 -1.245
#> 33      1 -2.087
#> 34      1 -0.957
#> 35      1 -1.081
#> 36      1  0.887
#> 37      1 -1.351
#> 38      1  1.540
#> 39      1 -1.336
#> 40      1 -0.889
#> 41      1 -0.756
#> 42      1 -1.331
#> 43      1  0.345
#> 44      1 -0.544
#> 45      1 -0.625
#> 46      1 -0.369
#> 47      1 -0.051
#> 48      1  0.817
#> 49      1  0.443
#> 50      1 -0.578
#> 51      1 -1.028
#> 52      1 -0.278
#> 53      1  0.602
#> 54      1  1.382
#> 55      1  0.142
#> 56      1 -0.699
#> 57      1 -0.769
#> 58      1 -0.032
#> 59      1  0.274
#> 60      1 -0.345
#> 61      1 -2.145
#> 62      1  0.427
#> 63      1  2.386
#> 64      1 -0.548
#> 65      1 -0.526
#> 66      1 -0.198
#> 67      1 -1.461
#> 68      1  1.009
#> 69      1 -2.186
#> 70      1 -0.079
#> 71      1 -0.567
#> 72      1 -0.367
#> 73      1 -0.895
#> 74      1  0.074
#> 75      1 -2.012
#> 76      1 -0.090
#> 77      1  1.808
#> 78      1  0.681
#> 79      1 -0.508
#> 80      1 -0.471
#> 81      1  0.443
#> 82      1  0.026
#> 83      1  0.778
#> 84      1 -0.100
#> 85      1 -0.057
#> 86      1  0.515
#> 87      1  0.718
#> 88      1  0.667
#> 89      1 -0.450
#> 90      1  1.171
#> 91      1 -0.437
#> 92      1  0.539
#> 93      1  1.841
#> 94      1 -0.110
#> 95      1  1.250
#> 96      1 -0.260
#> 97      1  0.726
#> 98      1 -1.029
#> 99      1  1.511
#> 100     1  0.153
#> 

generate_quantitative(k = 2,
                      effect_size = 0.3,
                      use_effect_size = TRUE)
#> $summary
#>          mean   sd skew kurtosis
#> input 1  0.00 1.00 0.00     0.00
#> k 1     -0.06 0.95 0.21     0.47
#> input 2  0.30 1.00 0.00     0.00
#> k 2      0.28 1.01 0.02     0.07
#> 
#> $sample
#> # A tibble: 200 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1      0.654
#>  2 1     -0.861
#>  3 1      1.26 
#>  4 1     -0.914
#>  5 1      0.247
#>  6 1      0.817
#>  7 1      0.434
#>  8 1     -1.80 
#>  9 1      0.839
#> 10 1      0.076
#> # ℹ 190 more rows
#> 

generate_quantitative(k = 2,
                      skew = c(0.4, 0.25))
#> $summary
#>          mean   sd skew kurtosis
#> input 1  0.00 1.00 0.40     0.00
#> k 1     -0.01 0.93 0.20    -0.01
#> input 2  0.00 1.00 0.25     0.00
#> k 2      0.06 1.02 0.84     0.76
#> 
#> $sample
#> # A tibble: 200 × 2
#>    Group  Value
#>    <fct>  <dbl>
#>  1 1      1.59 
#>  2 1      2.24 
#>  3 1      0.4  
#>  4 1     -0.929
#>  5 1      0.579
#>  6 1     -1.06 
#>  7 1     -0.054
#>  8 1     -0.487
#>  9 1      0.374
#> 10 1      0.325
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
