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
#> $sample
#>     v1
#> 1    1
#> 2    1
#> 3    0
#> 4    1
#> 5    1
#> 6    0
#> 7    0
#> 8    1
#> 9    0
#> 10   0
#> 11   0
#> 12   1
#> 13   1
#> 14   1
#> 15   1
#> 16   1
#> 17   1
#> 18   0
#> 19   0
#> 20   1
#> 21   0
#> 22   1
#> 23   1
#> 24   0
#> 25   1
#> 26   0
#> 27   1
#> 28   0
#> 29   1
#> 30   1
#> 31   1
#> 32   0
#> 33   1
#> 34   0
#> 35   0
#> 36   0
#> 37   1
#> 38   0
#> 39   0
#> 40   1
#> 41   1
#> 42   1
#> 43   1
#> 44   1
#> 45   1
#> 46   1
#> 47   1
#> 48   0
#> 49   0
#> 50   1
#> 51   1
#> 52   0
#> 53   0
#> 54   1
#> 55   0
#> 56   1
#> 57   1
#> 58   0
#> 59   0
#> 60   1
#> 61   1
#> 62   0
#> 63   1
#> 64   0
#> 65   1
#> 66   0
#> 67   0
#> 68   0
#> 69   1
#> 70   0
#> 71   1
#> 72   0
#> 73   0
#> 74   1
#> 75   1
#> 76   0
#> 77   1
#> 78   1
#> 79   0
#> 80   1
#> 81   0
#> 82   1
#> 83   0
#> 84   0
#> 85   0
#> 86   1
#> 87   0
#> 88   0
#> 89   0
#> 90   1
#> 91   0
#> 92   1
#> 93   0
#> 94   1
#> 95   0
#> 96   1
#> 97   1
#> 98   1
#> 99   1
#> 100  1
#> 
#> $proportion_summary
#>          sample size successes sample proportion population proportion
#> sample 1         100        55              0.55                   0.5
#> 
#> $freq.table
#>          successes failures
#> sample 1        55       45
#> 

generate_binary(p = 2, prop = c(0.5, 0.7))
#> $sample
#>     v1 v2
#> 1    0  1
#> 2    0  0
#> 3    0  0
#> 4    1  0
#> 5    1  1
#> 6    1  1
#> 7    0  1
#> 8    1  0
#> 9    1  1
#> 10   1  0
#> 11   1  1
#> 12   0  1
#> 13   1  1
#> 14   0  1
#> 15   0  1
#> 16   1  1
#> 17   1  1
#> 18   0  0
#> 19   1  1
#> 20   1  0
#> 21   1  1
#> 22   0  1
#> 23   1  1
#> 24   0  1
#> 25   1  0
#> 26   1  1
#> 27   1  0
#> 28   1  1
#> 29   1  0
#> 30   0  1
#> 31   1  0
#> 32   0  0
#> 33   1  1
#> 34   1  1
#> 35   0  1
#> 36   1  0
#> 37   0  1
#> 38   0  1
#> 39   1  0
#> 40   0  1
#> 41   0  1
#> 42   1  1
#> 43   1  1
#> 44   1  0
#> 45   1  1
#> 46   1  1
#> 47   0  0
#> 48   0  0
#> 49   0  0
#> 50   1  0
#> 51   1  0
#> 52   1  1
#> 53   0  1
#> 54   1  1
#> 55   0  0
#> 56   1  1
#> 57   1  0
#> 58   0  1
#> 59   1  0
#> 60   1  1
#> 61   0  0
#> 62   1  0
#> 63   0  1
#> 64   0  1
#> 65   1  1
#> 66   0  0
#> 67   1  1
#> 68   1  0
#> 69   1  0
#> 70   1  1
#> 71   1  1
#> 72   0  1
#> 73   0  1
#> 74   0  0
#> 75   1  0
#> 76   0  1
#> 77   0  0
#> 78   0  0
#> 79   1  0
#> 80   0  1
#> 81   1  1
#> 82   0  0
#> 83   1  0
#> 84   1  1
#> 85   0  1
#> 86   0  1
#> 87   0  1
#> 88   0  1
#> 89   1  1
#> 90   0  1
#> 91   1  1
#> 92   1  0
#> 93   1  1
#> 94   1  1
#> 95   0  1
#> 96   0  1
#> 97   1  1
#> 98   0  1
#> 99   1  0
#> 100  0  0
#> 
#> $proportion_summary
#>          sample size successes sample proportion population proportion
#> sample 1         100        56              0.56                   0.5
#> sample 2         100        62              0.62                   0.7
#> 
#> $freq.table
#>          successes failures
#> sample 1        56       44
#> sample 2        62       38
#> 

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
