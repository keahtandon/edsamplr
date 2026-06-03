# Generate samples of binary data

`generate_binary()` is function to generate sample binary data.

## Usage

``` r
generate_binary(
  p = 1,
  n = 100,
  prop = 0.5,
  group_names = c(1:0),
  summary = TRUE,
  replication = 1
)
```

## Arguments

- p:

  A numeric vector for the number of variables. The default value is 1.

- n:

  A numeric vector for the sample size. The default value is 100.

- prop:

  A numeric vector for the proportion of successes. The default value is
  0.5. If k \> 1, you can provide separate proportion values for each k.

- group_names:

  An optional character vector for naming successes and failures. The
  default values are 1 for success and 0 for failure.

- summary:

  A logical vector for whether the return should include summary
  statistics. The default value is TRUE.

- replication:

  A numeric vector for the number of times to replicate the sampling.
  The default value is 1.

## Value

If summary = TRUE, a list containing

- `sample`, a data frame with n rows and k columns

- `summary`, a matrix of the sample size, number of successes,
  proportion statistic, and proportion parameter for each variable, and

- `freq.table`, a matrix of the frequencies of successes and failures
  for each variable

If summary = FALSE, a data frame with n rows and 1 column.

## Details

This function generates samples of binary data based on specified
proportions. It can generate a single column or multiple columns of data
with different proportions specified for each. The data is sampled from
the specified proportions as a parameter, so the output statistics will
not be an exact match to the parameters.

Because the output is a sample, the summary argument allows for summary
statistics to be generated with the sample data. This allows the user to
easily compare the simulation statistics to the specified parameters.

This is useful for introducing students to the basics of probability,
proportion tests, and chi square tests without having to call two (or
more) separate [`rbinom()`](https://rdrr.io/r/stats/Binomial.html)
functions. If you are interested in using binary data for sample student
test responses, consider using
[`generate_2PL()`](https://keahtandon.github.io/edsamplr/reference/generate_2PL.md),
which simulates binary response data based on specified difficulty and
discrimination parameters.

## Examples

``` r
generate_binary()
#> Error in dplyr::mutate(., dplyr::across(dplyr::everything(), ~as.integer(. ==     levels(.)[1]))): ℹ In argument: `dplyr::across(dplyr::everything(), ~as.integer(. ==
#>   levels(.)[1]))`.
#> Caused by error in `across()`:
#> ! Can't compute column `v1`.
#> Caused by error in `dplyr_internal_error()`:

generate_binary(p = 2, prop = c(0.5, 0.7))
#> Error in dplyr::mutate(., dplyr::across(dplyr::everything(), ~as.integer(. ==     levels(.)[1]))): ℹ In argument: `dplyr::across(dplyr::everything(), ~as.integer(. ==
#>   levels(.)[1]))`.
#> Caused by error in `across()`:
#> ! Can't compute column `v1`.
#> Caused by error in `dplyr_internal_error()`:

generate_binary(group_names = c("success", "fail"))
#> $sample
#>          v1
#> 1      fail
#> 2      fail
#> 3      fail
#> 4      fail
#> 5   success
#> 6      fail
#> 7      fail
#> 8   success
#> 9   success
#> 10  success
#> 11  success
#> 12     fail
#> 13  success
#> 14  success
#> 15  success
#> 16  success
#> 17     fail
#> 18  success
#> 19  success
#> 20  success
#> 21     fail
#> 22  success
#> 23     fail
#> 24     fail
#> 25  success
#> 26     fail
#> 27  success
#> 28  success
#> 29     fail
#> 30     fail
#> 31  success
#> 32  success
#> 33  success
#> 34     fail
#> 35     fail
#> 36     fail
#> 37  success
#> 38     fail
#> 39     fail
#> 40     fail
#> 41  success
#> 42     fail
#> 43     fail
#> 44  success
#> 45  success
#> 46     fail
#> 47     fail
#> 48  success
#> 49  success
#> 50     fail
#> 51     fail
#> 52  success
#> 53     fail
#> 54  success
#> 55  success
#> 56     fail
#> 57  success
#> 58  success
#> 59     fail
#> 60     fail
#> 61     fail
#> 62  success
#> 63  success
#> 64     fail
#> 65  success
#> 66     fail
#> 67  success
#> 68     fail
#> 69     fail
#> 70  success
#> 71  success
#> 72  success
#> 73  success
#> 74  success
#> 75     fail
#> 76  success
#> 77  success
#> 78     fail
#> 79  success
#> 80     fail
#> 81     fail
#> 82     fail
#> 83     fail
#> 84  success
#> 85     fail
#> 86  success
#> 87     fail
#> 88     fail
#> 89  success
#> 90  success
#> 91     fail
#> 92     fail
#> 93  success
#> 94     fail
#> 95     fail
#> 96     fail
#> 97     fail
#> 98  success
#> 99  success
#> 100    fail
#> 
#> $proportion_summary
#>          sample size successes sample proportion population proportion
#> sample 1         100        49              0.49                   0.5
#> 
#> $freq.table
#>          successes failures
#> sample 1        49       51
#> 
```
