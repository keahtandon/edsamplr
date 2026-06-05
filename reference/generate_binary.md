# Generate samples of binary data

`generate_binary()` is function to generate sample binary data.

## Usage

``` r
generate_binary(
  p = 1,
  n = 100,
  prop = 0.5,
  group_names = c(1:0),
  output_type = "factor",
  summary = TRUE,
  replication = 1
)
```

## Arguments

- p:

  A positive integer for the number of variables. The default value is
  1.

- n:

  A positive integer for the sample size. The default value is 100.

- prop:

  A numeric vector for the proportion of successes. The default value is
  0.5. If p \> 1, you can provide separate proportion values for each p.

- group_names:

  An optional character or numeric vector for naming successes and
  failures. The default values are 1 for success and 0 for failure.

- output_type:

  A character vector for output type. The options are "character" or
  "numeric." If p \> 1, you can provide separate output types for each
  p.

- summary:

  A logical scalar for whether the return should include summary
  statistics. The default value is TRUE.

- replication:

  A positive integer for the number of times to replicate the sampling.
  The default value is 1.

## Value

If summary = TRUE, a list containing

- `sample`, a data frame with n rows and k columns

- `summary`, a matrix of the sample size, number of successes,
  proportion statistic, and proportion parameter for each variable, and

- `freq.table`, a matrix of the frequencies of successes and failures
  for each variable

If summary = FALSE, a data frame with n rows and p columns.

The output type can be changed depending on one's need. Each column will
return as a factor or as numeric values depending on argument selection.

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

generate_binary(output_type = "numeric")
#> $sample
#>     v1
#> 1    0
#> 2    0
#> 3    0
#> 4    1
#> 5    1
#> 6    1
#> 7    0
#> 8    1
#> 9    1
#> 10   1
#> 11   1
#> 12   0
#> 13   1
#> 14   0
#> 15   0
#> 16   1
#> 17   1
#> 18   0
#> 19   1
#> 20   1
#> 21   1
#> 22   0
#> 23   1
#> 24   0
#> 25   1
#> 26   1
#> 27   1
#> 28   1
#> 29   1
#> 30   0
#> 31   1
#> 32   0
#> 33   1
#> 34   1
#> 35   0
#> 36   1
#> 37   0
#> 38   0
#> 39   1
#> 40   0
#> 41   0
#> 42   1
#> 43   1
#> 44   1
#> 45   1
#> 46   1
#> 47   0
#> 48   0
#> 49   0
#> 50   1
#> 51   1
#> 52   1
#> 53   0
#> 54   1
#> 55   0
#> 56   1
#> 57   1
#> 58   0
#> 59   1
#> 60   1
#> 61   0
#> 62   1
#> 63   0
#> 64   0
#> 65   1
#> 66   0
#> 67   1
#> 68   1
#> 69   1
#> 70   1
#> 71   1
#> 72   0
#> 73   0
#> 74   0
#> 75   1
#> 76   0
#> 77   0
#> 78   0
#> 79   1
#> 80   0
#> 81   1
#> 82   0
#> 83   1
#> 84   1
#> 85   0
#> 86   0
#> 87   0
#> 88   0
#> 89   1
#> 90   0
#> 91   1
#> 92   1
#> 93   1
#> 94   1
#> 95   0
#> 96   0
#> 97   1
#> 98   0
#> 99   1
#> 100  0
#> 
#> $proportion_summary
#>          sample size successes sample proportion population proportion
#> sample 1         100        56              0.56                   0.5
#> 
#> $freq.table
#>          successes failures
#> sample 1        56       44
#> 

generate_binary(p = 2, prop = c(0.5, 0.7))
#> $sample
#>     v1 v2
#> 1    0  1
#> 2    1  1
#> 3    1  1
#> 4    1  1
#> 5    0  0
#> 6    0  1
#> 7    1  1
#> 8    1  0
#> 9    0  0
#> 10   1  1
#> 11   0  1
#> 12   0  1
#> 13   0  0
#> 14   1  0
#> 15   1  1
#> 16   0  0
#> 17   0  1
#> 18   1  0
#> 19   1  0
#> 20   1  0
#> 21   0  1
#> 22   1  1
#> 23   0  1
#> 24   1  1
#> 25   1  1
#> 26   1  1
#> 27   1  1
#> 28   1  1
#> 29   1  1
#> 30   0  1
#> 31   1  0
#> 32   1  1
#> 33   0  1
#> 34   0  1
#> 35   0  1
#> 36   1  1
#> 37   0  0
#> 38   0  1
#> 39   1  1
#> 40   1  1
#> 41   0  1
#> 42   1  1
#> 43   0  1
#> 44   1  0
#> 45   0  0
#> 46   0  1
#> 47   1  1
#> 48   1  0
#> 49   1  1
#> 50   1  1
#> 51   1  1
#> 52   0  1
#> 53   0  1
#> 54   1  1
#> 55   1  0
#> 56   0  1
#> 57   1  0
#> 58   1  0
#> 59   1  1
#> 60   1  1
#> 61   1  1
#> 62   1  0
#> 63   0  0
#> 64   0  1
#> 65   0  0
#> 66   1  1
#> 67   0  0
#> 68   1  1
#> 69   1  1
#> 70   0  1
#> 71   1  0
#> 72   0  0
#> 73   1  1
#> 74   1  1
#> 75   1  1
#> 76   0  0
#> 77   1  1
#> 78   1  1
#> 79   1  1
#> 80   0  1
#> 81   0  1
#> 82   1  1
#> 83   1  1
#> 84   0  0
#> 85   0  1
#> 86   0  0
#> 87   0  1
#> 88   0  1
#> 89   0  0
#> 90   0  0
#> 91   1  1
#> 92   1  1
#> 93   0  1
#> 94   0  1
#> 95   0  1
#> 96   0  1
#> 97   0  1
#> 98   0  1
#> 99   1  0
#> 100  1  1
#> 
#> $proportion_summary
#>          sample size successes sample proportion population proportion
#> sample 1         100        54              0.54                   0.5
#> sample 2         100        71              0.71                   0.7
#> 
#> $freq.table
#>          successes failures
#> sample 1        54       46
#> sample 2        71       29
#> 

generate_binary(group_names = c("success", "fail"))
#> $sample
#>          v1
#> 1   success
#> 2   success
#> 3      fail
#> 4      fail
#> 5      fail
#> 6      fail
#> 7      fail
#> 8      fail
#> 9      fail
#> 10     fail
#> 11     fail
#> 12  success
#> 13  success
#> 14  success
#> 15     fail
#> 16     fail
#> 17     fail
#> 18  success
#> 19  success
#> 20  success
#> 21  success
#> 22     fail
#> 23     fail
#> 24  success
#> 25     fail
#> 26  success
#> 27  success
#> 28     fail
#> 29  success
#> 30     fail
#> 31  success
#> 32  success
#> 33  success
#> 34  success
#> 35  success
#> 36  success
#> 37  success
#> 38  success
#> 39     fail
#> 40     fail
#> 41  success
#> 42     fail
#> 43     fail
#> 44  success
#> 45  success
#> 46     fail
#> 47  success
#> 48  success
#> 49  success
#> 50  success
#> 51  success
#> 52     fail
#> 53     fail
#> 54     fail
#> 55  success
#> 56  success
#> 57  success
#> 58  success
#> 59     fail
#> 60     fail
#> 61     fail
#> 62  success
#> 63     fail
#> 64  success
#> 65     fail
#> 66     fail
#> 67  success
#> 68  success
#> 69  success
#> 70  success
#> 71     fail
#> 72  success
#> 73     fail
#> 74     fail
#> 75  success
#> 76  success
#> 77  success
#> 78     fail
#> 79  success
#> 80     fail
#> 81     fail
#> 82  success
#> 83     fail
#> 84  success
#> 85  success
#> 86  success
#> 87  success
#> 88     fail
#> 89  success
#> 90  success
#> 91     fail
#> 92  success
#> 93  success
#> 94  success
#> 95  success
#> 96     fail
#> 97  success
#> 98  success
#> 99     fail
#> 100    fail
#> 
#> $proportion_summary
#>          sample size successes sample proportion population proportion
#> sample 1         100        57              0.57                   0.5
#> 
#> $freq.table
#>          successes failures
#> sample 1        57       43
#> 
```
