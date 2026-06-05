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
#> 2    3
#> 3    1
#> 4    2
#> 5    1
#> 6    3
#> 7    1
#> 8    2
#> 9    3
#> 10   4
#> 11   1
#> 12   2
#> 13   2
#> 14   1
#> 15   2
#> 16   2
#> 17   1
#> 18   2
#> 19   3
#> 20   1
#> 21   4
#> 22   1
#> 23   2
#> 24   4
#> 25   2
#> 26   3
#> 27   2
#> 28   2
#> 29   3
#> 30   1
#> 31   1
#> 32   3
#> 33   4
#> 34   2
#> 35   3
#> 36   4
#> 37   3
#> 38   4
#> 39   1
#> 40   2
#> 41   4
#> 42   1
#> 43   3
#> 44   4
#> 45   3
#> 46   2
#> 47   4
#> 48   2
#> 49   4
#> 50   2
#> 51   4
#> 52   2
#> 53   4
#> 54   2
#> 55   1
#> 56   3
#> 57   2
#> 58   3
#> 59   4
#> 60   1
#> 61   3
#> 62   4
#> 63   1
#> 64   2
#> 65   1
#> 66   2
#> 67   2
#> 68   4
#> 69   4
#> 70   3
#> 71   1
#> 72   4
#> 73   2
#> 74   4
#> 75   1
#> 76   1
#> 77   3
#> 78   3
#> 79   3
#> 80   2
#> 81   1
#> 82   3
#> 83   2
#> 84   4
#> 85   2
#> 86   2
#> 87   1
#> 88   3
#> 89   2
#> 90   2
#> 91   2
#> 92   2
#> 93   4
#> 94   1
#> 95   1
#> 96   3
#> 97   3
#> 98   3
#> 99   2
#> 100  2
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3   k4
#> input p1  4 100 0.25 0.25 0.25 0.25
#> sample p1 4 100 0.23 0.33 0.24 0.20
#> 

generate_categorical(k = 4,
                     k_names = c("freshman", "sophomore",
                                 "junior", "senior"))
#> $sample
#>            v1
#> 1      junior
#> 2   sophomore
#> 3      junior
#> 4      senior
#> 5      junior
#> 6      senior
#> 7      junior
#> 8    freshman
#> 9    freshman
#> 10  sophomore
#> 11     senior
#> 12     senior
#> 13     senior
#> 14     senior
#> 15  sophomore
#> 16     junior
#> 17   freshman
#> 18     senior
#> 19     senior
#> 20   freshman
#> 21     senior
#> 22   freshman
#> 23     junior
#> 24     junior
#> 25   freshman
#> 26     senior
#> 27  sophomore
#> 28     junior
#> 29  sophomore
#> 30     junior
#> 31   freshman
#> 32   freshman
#> 33  sophomore
#> 34   freshman
#> 35  sophomore
#> 36     junior
#> 37     senior
#> 38     junior
#> 39   freshman
#> 40   freshman
#> 41     senior
#> 42  sophomore
#> 43  sophomore
#> 44     junior
#> 45     senior
#> 46     senior
#> 47   freshman
#> 48     junior
#> 49  sophomore
#> 50     senior
#> 51     junior
#> 52     junior
#> 53  sophomore
#> 54     senior
#> 55     junior
#> 56   freshman
#> 57     senior
#> 58   freshman
#> 59  sophomore
#> 60     senior
#> 61  sophomore
#> 62     junior
#> 63   freshman
#> 64     junior
#> 65  sophomore
#> 66  sophomore
#> 67     junior
#> 68     senior
#> 69     senior
#> 70     senior
#> 71     junior
#> 72  sophomore
#> 73  sophomore
#> 74   freshman
#> 75  sophomore
#> 76     junior
#> 77   freshman
#> 78     senior
#> 79     senior
#> 80     junior
#> 81   freshman
#> 82  sophomore
#> 83     senior
#> 84   freshman
#> 85  sophomore
#> 86  sophomore
#> 87  sophomore
#> 88     senior
#> 89     junior
#> 90   freshman
#> 91  sophomore
#> 92   freshman
#> 93     senior
#> 94  sophomore
#> 95     junior
#> 96     senior
#> 97   freshman
#> 98     senior
#> 99     junior
#> 100 sophomore
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3   k4
#> input p1  4 100 0.25 0.25 0.25 0.25
#> sample p1 4 100 0.22 0.25 0.25 0.28
#> 

generate_categorical(k = 4,
                     k_prop = c(0.25, 0.5, 0.1, 0.15))
#> $sample
#>     v1
#> 1    4
#> 2    4
#> 3    2
#> 4    2
#> 5    3
#> 6    4
#> 7    2
#> 8    2
#> 9    2
#> 10   2
#> 11   2
#> 12   3
#> 13   2
#> 14   2
#> 15   2
#> 16   2
#> 17   4
#> 18   1
#> 19   1
#> 20   1
#> 21   2
#> 22   1
#> 23   2
#> 24   1
#> 25   2
#> 26   4
#> 27   2
#> 28   3
#> 29   2
#> 30   2
#> 31   2
#> 32   4
#> 33   2
#> 34   2
#> 35   2
#> 36   4
#> 37   1
#> 38   4
#> 39   2
#> 40   1
#> 41   2
#> 42   2
#> 43   1
#> 44   2
#> 45   4
#> 46   2
#> 47   4
#> 48   2
#> 49   3
#> 50   1
#> 51   2
#> 52   2
#> 53   1
#> 54   2
#> 55   4
#> 56   2
#> 57   3
#> 58   2
#> 59   2
#> 60   1
#> 61   1
#> 62   1
#> 63   2
#> 64   2
#> 65   2
#> 66   1
#> 67   2
#> 68   1
#> 69   2
#> 70   1
#> 71   2
#> 72   1
#> 73   2
#> 74   2
#> 75   1
#> 76   3
#> 77   2
#> 78   2
#> 79   3
#> 80   3
#> 81   2
#> 82   2
#> 83   1
#> 84   1
#> 85   1
#> 86   2
#> 87   1
#> 88   2
#> 89   2
#> 90   2
#> 91   2
#> 92   1
#> 93   4
#> 94   1
#> 95   4
#> 96   2
#> 97   4
#> 98   2
#> 99   4
#> 100  4
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3   k4
#> input p1  4 100 0.25 0.50 0.10 0.15
#> sample p1 4 100 0.24 0.52 0.08 0.16
#> 

generate_categorical(p = 2,
                     k = c(2, 3),
                     k_prop = c(0.3, 0.7, 0.2, 0.2, 0.6))
#> $sample
#>     v1 v2
#> 1    2  2
#> 2    2  1
#> 3    1  3
#> 4    1  3
#> 5    2  3
#> 6    2  1
#> 7    2  1
#> 8    2  2
#> 9    2  3
#> 10   2  2
#> 11   2  3
#> 12   2  3
#> 13   1  3
#> 14   1  2
#> 15   2  3
#> 16   1  3
#> 17   2  2
#> 18   1  3
#> 19   1  3
#> 20   2  1
#> 21   2  3
#> 22   1  3
#> 23   2  3
#> 24   2  3
#> 25   1  3
#> 26   1  1
#> 27   1  3
#> 28   2  1
#> 29   1  2
#> 30   2  1
#> 31   2  2
#> 32   1  3
#> 33   2  1
#> 34   1  3
#> 35   2  3
#> 36   2  2
#> 37   2  3
#> 38   2  3
#> 39   2  3
#> 40   2  1
#> 41   2  3
#> 42   2  2
#> 43   1  3
#> 44   1  1
#> 45   2  3
#> 46   1  3
#> 47   2  3
#> 48   1  3
#> 49   2  2
#> 50   2  3
#> 51   1  1
#> 52   2  3
#> 53   1  2
#> 54   2  2
#> 55   2  1
#> 56   1  1
#> 57   2  3
#> 58   1  3
#> 59   1  3
#> 60   2  1
#> 61   1  1
#> 62   2  2
#> 63   2  3
#> 64   2  3
#> 65   1  3
#> 66   2  3
#> 67   2  3
#> 68   2  2
#> 69   2  3
#> 70   2  3
#> 71   2  3
#> 72   2  2
#> 73   2  3
#> 74   1  2
#> 75   1  3
#> 76   2  3
#> 77   1  2
#> 78   1  3
#> 79   2  3
#> 80   2  2
#> 81   2  3
#> 82   2  2
#> 83   2  2
#> 84   2  3
#> 85   1  2
#> 86   1  3
#> 87   2  1
#> 88   2  3
#> 89   2  3
#> 90   1  2
#> 91   2  3
#> 92   2  3
#> 93   2  3
#> 94   2  2
#> 95   2  2
#> 96   1  2
#> 97   1  3
#> 98   2  2
#> 99   2  3
#> 100  2  2
#> 
#> $proportion_summary
#>           k   n   k1   k2   k3
#> input p1  2 100 0.30 0.70   NA
#> sample p1 2 100 0.34 0.66   NA
#> input p2  3 100 0.20 0.20 0.60
#> sample p2 3 100 0.16 0.27 0.57
#> 

generate_categorical(p = 2,
                     k = 2,
                     k_prop = c(0.3, 0.7))
#> $sample
#>     v1 v2
#> 1    2  2
#> 2    2  1
#> 3    2  1
#> 4    1  2
#> 5    2  2
#> 6    2  2
#> 7    2  1
#> 8    2  2
#> 9    2  2
#> 10   2  2
#> 11   2  2
#> 12   2  2
#> 13   1  2
#> 14   2  2
#> 15   2  2
#> 16   2  2
#> 17   1  2
#> 18   2  2
#> 19   2  1
#> 20   2  2
#> 21   1  2
#> 22   1  2
#> 23   2  2
#> 24   1  2
#> 25   1  2
#> 26   1  2
#> 27   1  2
#> 28   2  1
#> 29   2  2
#> 30   2  2
#> 31   2  2
#> 32   1  2
#> 33   2  2
#> 34   2  2
#> 35   1  1
#> 36   2  1
#> 37   2  2
#> 38   2  2
#> 39   1  2
#> 40   2  1
#> 41   2  2
#> 42   2  2
#> 43   2  2
#> 44   2  2
#> 45   2  2
#> 46   1  2
#> 47   2  2
#> 48   2  2
#> 49   1  1
#> 50   1  2
#> 51   2  1
#> 52   2  1
#> 53   2  1
#> 54   2  2
#> 55   2  2
#> 56   2  1
#> 57   2  2
#> 58   2  2
#> 59   1  2
#> 60   2  2
#> 61   1  2
#> 62   2  2
#> 63   2  2
#> 64   2  2
#> 65   1  1
#> 66   1  1
#> 67   2  2
#> 68   2  2
#> 69   1  2
#> 70   2  2
#> 71   2  2
#> 72   2  1
#> 73   2  2
#> 74   1  2
#> 75   2  2
#> 76   1  1
#> 77   2  1
#> 78   1  2
#> 79   2  2
#> 80   2  2
#> 81   2  1
#> 82   1  2
#> 83   2  2
#> 84   2  2
#> 85   2  1
#> 86   2  1
#> 87   2  2
#> 88   2  2
#> 89   2  2
#> 90   2  1
#> 91   1  2
#> 92   1  2
#> 93   2  2
#> 94   1  2
#> 95   2  2
#> 96   2  2
#> 97   1  1
#> 98   2  2
#> 99   1  2
#> 100  2  2
#> 
#> $proportion_summary
#>           k   n   k1   k2
#> input p1  2 100 0.30 0.70
#> sample p1 2 100 0.29 0.71
#> input p2  2 100 0.30 0.70
#> sample p2 2 100 0.23 0.77
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
#>  1 sophomore     male  
#>  2 sophomore     female
#>  3 freshman      male  
#>  4 freshman      female
#>  5 sophomore     female
#>  6 freshman      male  
#>  7 sophomore     female
#>  8 sophomore     female
#>  9 sophomore     female
#> 10 freshman      male  
#> # ℹ 90 more rows
#> 
#> $proportion_summary
#>           k  n   k1   k2
#> input p1  2 57 0.20 0.30
#> sample p1 2 57 0.57 0.43
#> input p2  2 43 0.40 0.10
#> sample p2 2 43 0.56 0.44
#> 
```
