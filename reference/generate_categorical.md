# Generate samples of categorical data

`generate_categorical()` is a function to generate n variables of sample
categorical data with k groups.

## Usage

``` r
generate_categorical(
  p = 1,
  n = 100,
  k = 1,
  k_prop = "equal",
  k_names = "default",
  separate = FALSE,
  summary = TRUE,
  replication = 1
)
```

## Arguments

- p:

  A numeric vector for the number of variables. The default value is 1.

- n:

  A numeric vector for the sample size. Separate values of n can be
  entered for an unbalanced design. The default value is 100.

- k:

  A numeric vector for the number of groups within each variable. The
  default value is 1. If p\>1, you can provide separate group numbers
  for each p.

- k_prop:

  A vector for the proportion of each group in the population. The
  default value is "equal". For unequal proportions, provide a
  concatenated vector the same length as the number of groups (k). If
  p\>1, you can provide separate sets of proportions for each p.

- k_names:

  An optional character vector for naming successes and failures (or
  other group types). The default values are 1:k. If you want to use the
  separate argument, name your groups with underscores separating the
  place to split.

- separate:

  A logical vector for indicating whether to split the groups into
  separate columns after simulating. This only works if p = 1. The
  default value is FALSE.

- summary:

  A logical vector for indicating whether to return summary statistics.
  The default value is TRUE.

- replication:

  A numeric vector for the number of times to replicate the sampling.
  The default value is 1.

## Value

A list containing a data frame ("sample") with n rows and p columns and
a matrix ("proportion_summary") of the input and sample proportions for
each group and variable.

## Details

This function is an extension of
[`generate_binary()`](https://keahtandon.github.io/edsamplr/reference/generate_binary.md).
It is used to generate one or more columns of data with values based on
specified proportions. The default return of the function uses numeric
values for the different groups, but there is an optional argument to
label the groups with specified strings. The data is sampled from the
specified proportions as a parameter, so the output statistics will not
be an exact match to the parameters.

Because the output is a sample, the summary argument allows for summary
statistics to be generated with the sample data. This allows the user to
easily compare the simulation statistics to the specified parameters.

This is useful for teaching statistics because it allows for the user to
create samples of categorical data without having to calculate the n
associated with each proportion and then call
[`rep()`](https://rdrr.io/r/base/rep.html) to generate the data.

It is also useful for creating proportions that cross multiple
variables, demonstrated in the final example, below. This function can
accommodate users who are interested in creating a data frame that
contains a combination of two separate demographics with the proportion
at the combination level rather than the individual demographic level.
This is done through calling the function as if there was one variable,
specifying the proportions of that variable, naming the groups with the
level of each variable separated with an underscore, and using the
separate argument. This will simulate the data and then split it into
separate columns.

## Examples

``` r
generate_categorical()
#> $sample
#>     v1
#> 1    1
#> 2    1
#> 3    1
#> 4    1
#> 5    1
#> 6    1
#> 7    1
#> 8    1
#> 9    1
#> 10   1
#> 11   1
#> 12   1
#> 13   1
#> 14   1
#> 15   1
#> 16   1
#> 17   1
#> 18   1
#> 19   1
#> 20   1
#> 21   1
#> 22   1
#> 23   1
#> 24   1
#> 25   1
#> 26   1
#> 27   1
#> 28   1
#> 29   1
#> 30   1
#> 31   1
#> 32   1
#> 33   1
#> 34   1
#> 35   1
#> 36   1
#> 37   1
#> 38   1
#> 39   1
#> 40   1
#> 41   1
#> 42   1
#> 43   1
#> 44   1
#> 45   1
#> 46   1
#> 47   1
#> 48   1
#> 49   1
#> 50   1
#> 51   1
#> 52   1
#> 53   1
#> 54   1
#> 55   1
#> 56   1
#> 57   1
#> 58   1
#> 59   1
#> 60   1
#> 61   1
#> 62   1
#> 63   1
#> 64   1
#> 65   1
#> 66   1
#> 67   1
#> 68   1
#> 69   1
#> 70   1
#> 71   1
#> 72   1
#> 73   1
#> 74   1
#> 75   1
#> 76   1
#> 77   1
#> 78   1
#> 79   1
#> 80   1
#> 81   1
#> 82   1
#> 83   1
#> 84   1
#> 85   1
#> 86   1
#> 87   1
#> 88   1
#> 89   1
#> 90   1
#> 91   1
#> 92   1
#> 93   1
#> 94   1
#> 95   1
#> 96   1
#> 97   1
#> 98   1
#> 99   1
#> 100  1
#> 
#> $proportion_summary
#>           k   n k1
#> input p1  1 100  1
#> sample p1 1 100  1
#> 

generate_categorical(k = 4)
#> $sample
#>     v1
#> 1    3
#> 2    4
#> 3    2
#> 4    4
#> 5    4
#> 6    4
#> 7    2
#> 8    4
#> 9    4
#> 10   3
#> 11   4
#> 12   4
#> 13   1
#> 14   4
#> 15   3
#> 16   3
#> 17   2
#> 18   3
#> 19   4
#> 20   2
#> 21   4
#> 22   4
#> 23   4
#> 24   2
#> 25   1
#> 26   4
#> 27   4
#> 28   2
#> 29   1
#> 30   2
#> 31   2
#> 32   1
#> 33   4
#> 34   3
#> 35   1
#> 36   2
#> 37   4
#> 38   2
#> 39   4
#> 40   1
#> 41   1
#> 42   1
#> 43   2
#> 44   1
#> 45   1
#> 46   4
#> 47   3
#> 48   1
#> 49   4
#> 50   3
#> 51   1
#> 52   1
#> 53   2
#> 54   4
#> 55   2
#> 56   4
#> 57   4
#> 58   2
#> 59   1
#> 60   1
#> 61   3
#> 62   4
#> 63   1
#> 64   3
#> 65   3
#> 66   2
#> 67   2
#> 68   3
#> 69   2
#> 70   4
#> 71   1
#> 72   4
#> 73   3
#> 74   4
#> 75   3
#> 76   4
#> 77   3
#> 78   1
#> 79   1
#> 80   2
#> 81   3
#> 82   4
#> 83   3
#> 84   4
#> 85   4
#> 86   2
#> 87   1
#> 88   2
#> 89   1
#> 90   4
#> 91   1
#> 92   3
#> 93   3
#> 94   3
#> 95   1
#> 96   3
#> 97   3
#> 98   1
#> 99   2
#> 100  1
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3   k4
#> input p1  4 100 0.25 0.25 0.25 0.25
#> sample p1 4 100 0.25 0.21 0.22 0.32
#> 

generate_categorical(k = 4,
                     k_names = c("freshman", "sophomore",
                                 "junior", "senior"))
#> $sample
#>            v1
#> 1      junior
#> 2      junior
#> 3    freshman
#> 4   sophomore
#> 5    freshman
#> 6      junior
#> 7    freshman
#> 8   sophomore
#> 9      junior
#> 10     senior
#> 11   freshman
#> 12  sophomore
#> 13  sophomore
#> 14   freshman
#> 15  sophomore
#> 16  sophomore
#> 17   freshman
#> 18  sophomore
#> 19     junior
#> 20   freshman
#> 21     senior
#> 22   freshman
#> 23  sophomore
#> 24     senior
#> 25  sophomore
#> 26     junior
#> 27  sophomore
#> 28  sophomore
#> 29     junior
#> 30   freshman
#> 31   freshman
#> 32     junior
#> 33     senior
#> 34  sophomore
#> 35     junior
#> 36     senior
#> 37     junior
#> 38     senior
#> 39   freshman
#> 40  sophomore
#> 41     senior
#> 42   freshman
#> 43     junior
#> 44     senior
#> 45     junior
#> 46  sophomore
#> 47     senior
#> 48  sophomore
#> 49     senior
#> 50  sophomore
#> 51     senior
#> 52  sophomore
#> 53     senior
#> 54  sophomore
#> 55   freshman
#> 56     junior
#> 57  sophomore
#> 58     junior
#> 59     senior
#> 60   freshman
#> 61     junior
#> 62     senior
#> 63   freshman
#> 64  sophomore
#> 65   freshman
#> 66  sophomore
#> 67  sophomore
#> 68     senior
#> 69     senior
#> 70     junior
#> 71   freshman
#> 72     senior
#> 73  sophomore
#> 74     senior
#> 75   freshman
#> 76   freshman
#> 77     junior
#> 78     junior
#> 79     junior
#> 80  sophomore
#> 81   freshman
#> 82     junior
#> 83  sophomore
#> 84     senior
#> 85  sophomore
#> 86  sophomore
#> 87   freshman
#> 88     junior
#> 89  sophomore
#> 90  sophomore
#> 91  sophomore
#> 92  sophomore
#> 93     senior
#> 94   freshman
#> 95   freshman
#> 96     junior
#> 97     junior
#> 98     junior
#> 99  sophomore
#> 100 sophomore
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3   k4
#> input p1  4 100 0.25 0.25 0.25 0.25
#> sample p1 4 100 0.23 0.33 0.24 0.20
#> 

generate_categorical(k = 4,
                     k_prop = c(0.25, 0.5, 0.1, 0.15))
#> $sample
#>     v1
#> 1    2
#> 2    2
#> 3    2
#> 4    1
#> 5    2
#> 6    1
#> 7    2
#> 8    3
#> 9    3
#> 10   2
#> 11   1
#> 12   1
#> 13   1
#> 14   1
#> 15   2
#> 16   2
#> 17   4
#> 18   1
#> 19   1
#> 20   4
#> 21   1
#> 22   3
#> 23   2
#> 24   2
#> 25   4
#> 26   1
#> 27   2
#> 28   2
#> 29   2
#> 30   2
#> 31   4
#> 32   4
#> 33   2
#> 34   4
#> 35   2
#> 36   2
#> 37   1
#> 38   2
#> 39   4
#> 40   3
#> 41   1
#> 42   2
#> 43   2
#> 44   2
#> 45   1
#> 46   1
#> 47   4
#> 48   2
#> 49   2
#> 50   1
#> 51   2
#> 52   2
#> 53   2
#> 54   1
#> 55   2
#> 56   4
#> 57   1
#> 58   3
#> 59   2
#> 60   1
#> 61   2
#> 62   2
#> 63   4
#> 64   2
#> 65   2
#> 66   2
#> 67   2
#> 68   1
#> 69   1
#> 70   1
#> 71   2
#> 72   2
#> 73   2
#> 74   4
#> 75   2
#> 76   2
#> 77   3
#> 78   1
#> 79   1
#> 80   2
#> 81   3
#> 82   2
#> 83   1
#> 84   3
#> 85   2
#> 86   2
#> 87   2
#> 88   1
#> 89   2
#> 90   4
#> 91   2
#> 92   4
#> 93   1
#> 94   2
#> 95   2
#> 96   1
#> 97   4
#> 98   1
#> 99   2
#> 100  2
#> 
#> $proportion_summary
#>           k   n   k1  k2   k3   k4
#> input p1  4 100 0.25 0.5 0.10 0.15
#> sample p1 4 100 0.28 0.5 0.08 0.14
#> 

generate_categorical(p = 2,
                     k = c(2, 3),
                     k_prop = c(0.3, 0.7, 0.2, 0.2, 0.6))
#> $sample
#>     v1 v2
#> 1    1  3
#> 2    1  3
#> 3    2  1
#> 4    2  1
#> 5    1  3
#> 6    1  3
#> 7    2  3
#> 8    2  3
#> 9    2  3
#> 10   2  3
#> 11   2  3
#> 12   1  3
#> 13   2  1
#> 14   2  2
#> 15   2  3
#> 16   2  1
#> 17   1  3
#> 18   2  2
#> 19   1  1
#> 20   1  2
#> 21   2  3
#> 22   2  1
#> 23   2  3
#> 24   2  3
#> 25   2  2
#> 26   1  1
#> 27   2  2
#> 28   1  3
#> 29   2  2
#> 30   2  3
#> 31   2  3
#> 32   1  1
#> 33   2  3
#> 34   2  2
#> 35   2  3
#> 36   1  3
#> 37   2  3
#> 38   1  3
#> 39   2  3
#> 40   1  3
#> 41   2  3
#> 42   2  2
#> 43   1  2
#> 44   2  1
#> 45   1  3
#> 46   2  1
#> 47   1  2
#> 48   2  1
#> 49   1  2
#> 50   2  3
#> 51   2  2
#> 52   2  2
#> 53   1  2
#> 54   2  3
#> 55   1  3
#> 56   2  2
#> 57   1  3
#> 58   2  1
#> 59   2  1
#> 60   2  3
#> 61   2  1
#> 62   2  3
#> 63   2  3
#> 64   2  3
#> 65   2  1
#> 66   2  3
#> 67   2  3
#> 68   2  3
#> 69   2  3
#> 70   2  3
#> 71   2  3
#> 72   1  3
#> 73   2  3
#> 74   2  2
#> 75   2  2
#> 76   1  3
#> 77   2  2
#> 78   2  1
#> 79   1  3
#> 80   1  3
#> 81   2  3
#> 82   2  3
#> 83   1  3
#> 84   1  3
#> 85   2  1
#> 86   2  1
#> 87   2  2
#> 88   2  3
#> 89   2  2
#> 90   2  2
#> 91   2  3
#> 92   2  3
#> 93   1  3
#> 94   2  3
#> 95   1  3
#> 96   2  1
#> 97   1  1
#> 98   2  3
#> 99   1  3
#> 100  1  3
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3
#> input p1  2 100 0.30 0.70   NA
#> sample p1 2 100 0.32 0.68   NA
#> input p2  3 100 0.20 0.20 0.60
#> sample p2 3 100 0.20 0.21 0.59
#> 

generate_categorical(p = 2,
                     k = 2,
                     k_prop = c(0.3, 0.7))
#> $sample
#>     v1 v2
#> 1    1  2
#> 2    1  2
#> 3    2  2
#> 4    2  1
#> 5    2  2
#> 6    1  2
#> 7    1  2
#> 8    2  2
#> 9    2  2
#> 10   2  2
#> 11   2  2
#> 12   2  2
#> 13   2  1
#> 14   2  2
#> 15   2  2
#> 16   2  2
#> 17   1  1
#> 18   2  2
#> 19   2  2
#> 20   1  2
#> 21   2  1
#> 22   2  1
#> 23   2  2
#> 24   2  1
#> 25   2  1
#> 26   1  1
#> 27   2  1
#> 28   1  2
#> 29   1  2
#> 30   1  2
#> 31   2  2
#> 32   2  1
#> 33   1  2
#> 34   2  2
#> 35   2  1
#> 36   2  2
#> 37   2  2
#> 38   2  2
#> 39   2  1
#> 40   1  2
#> 41   2  2
#> 42   2  2
#> 43   2  2
#> 44   1  2
#> 45   2  2
#> 46   2  1
#> 47   2  2
#> 48   2  2
#> 49   2  1
#> 50   2  1
#> 51   1  2
#> 52   2  2
#> 53   1  2
#> 54   1  2
#> 55   1  2
#> 56   1  2
#> 57   2  2
#> 58   2  2
#> 59   2  1
#> 60   1  2
#> 61   1  1
#> 62   2  2
#> 63   2  2
#> 64   2  2
#> 65   2  1
#> 66   2  1
#> 67   2  2
#> 68   1  2
#> 69   2  1
#> 70   2  2
#> 71   2  2
#> 72   1  2
#> 73   2  2
#> 74   1  1
#> 75   2  2
#> 76   2  1
#> 77   1  2
#> 78   2  1
#> 79   2  2
#> 80   1  2
#> 81   2  2
#> 82   2  1
#> 83   1  2
#> 84   2  2
#> 85   2  2
#> 86   2  2
#> 87   1  2
#> 88   2  2
#> 89   2  2
#> 90   1  2
#> 91   2  1
#> 92   2  1
#> 93   2  2
#> 94   2  1
#> 95   2  2
#> 96   1  2
#> 97   2  1
#> 98   1  2
#> 99   2  1
#> 100  2  2
#> 
#> $proportion_summary
#>           k   n   k1   k2
#> input p1  2 100 0.30 0.70
#> sample p1 2 100 0.30 0.70
#> input p2  2 100 0.30 0.70
#> sample p2 2 100 0.29 0.71
#> 

generate_categorical(p = 1,
                     k = 4,
                     k_prop = c(0.2, 0.3, 0.4, 0.1),
                     k_names = c("freshman_female",
                                 "freshman_male",
                                 "sophomore_female",
                                 "sophomore_male"),
                     separate = TRUE)
#> $sample
#> # A tibble: 100 × 2
#>    `Condition 1` Result
#>    <fct>         <fct> 
#>  1 sophomore     female
#>  2 sophomore     male  
#>  3 freshman      female
#>  4 freshman      male  
#>  5 freshman      male  
#>  6 sophomore     female
#>  7 freshman      female
#>  8 sophomore     female
#>  9 freshman      male  
#> 10 sophomore     female
#> # ℹ 90 more rows
#> 
#> $proportion_summary
#>           k  n   k1   k2
#> input p1  2 46 0.20 0.30
#> sample p1 2 46 0.46 0.54
#> input p2  2 54 0.40 0.10
#> sample p2 2 54 0.63 0.37
#> 
```
