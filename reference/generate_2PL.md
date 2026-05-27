# Generate samples of 2PL data

`generate_2PL()` is a function to generate i items of sample dichotomous
response data for n students.

## Usage

``` r
generate_2PL(
  difficulty,
  discrimination,
  n,
  identify_groups = FALSE,
  group_pct = 0.27
)
```

## Arguments

- difficulty:

  A numeric vector of difficulty values for the items. A difficulty
  value should be provided for each item.

- discrimination:

  A numeric vector of discrimination values for the items. A
  discrimination value should be provided for each item.

- n:

  A numeric vector for the sample size.

- identify_groups:

  A logical vector for whether students should be grouped into low,
  medium, and high achievement based on their simulated responses.

- group_pct:

  A numeric vector for the proportion of students that should be
  included in the high and low groups. The default is 0.27.

## Value

A data frame with n rows and i columns (based on the length of the
difficulty and discrimination vectors).

- Each row represents a student's response to the simulated test.

- Each column represents a test item.

- The simulated response values are 0 for an incorrect response and 1
  for a correct response.

- The items will be sorted in increasing order of difficulty.

- If the argument to identify groups is TRUE, a total percentage correct
  column and a grouping column will also be in the return.

## Details

This function was originally designed to generate samples of dichotomous
response data to use in teaching undergraduate education majors about
the difficulty and discrimination parameters of the 2PL model for use in
reviewing selected-response tests and making decisions based on the item
parameters.

Users can select the number of items and students to generate responses
for based on item-specific difficulty and discrimination parameters. The
function then simulates data based on those parameters. Because the data
is simulated, the sample will have similar but not exact parameters for
each item.

Not all combinations of difficulty and discrimination parameters result
in viable output. If this occurs, a error message will display in the
console indicating which difficulty and discrimination combination is
not working and will provide a suggested range to change the difficulty
parameter to. Update one of the parameters for that item and re-run.

## Examples

``` r
difficulty <- c(0.57, 0.47, 0.7, 0.41, 0.76)
discrimination <- c(0.2, 0.4, 0.4, 0.99, 0.91)
generate_2PL(difficulty = difficulty,
             discrimination = discrimination,
             n = 30)
#>    Item_1 Item_2 Item_3 Item_4 Item_5
#> 1       0      1      1      1      1
#> 2       0      0      1      1      0
#> 3       0      0      0      1      1
#> 4       0      1      1      1      0
#> 5       1      1      1      1      1
#> 6       0      0      1      1      1
#> 7       1      0      1      1      0
#> 8       0      1      1      1      1
#> 9       0      0      0      1      1
#> 10      0      0      0      1      0
#> 11      0      1      0      1      1
#> 12      0      1      1      1      1
#> 13      0      1      1      1      1
#> 14      0      0      1      1      1
#> 15      0      0      1      1      1
#> 16      0      0      1      1      0
#> 17      0      0      1      1      1
#> 18      0      1      1      1      1
#> 19      1      0      0      1      1
#> 20      0      1      1      1      1
#> 21      1      1      0      1      1
#> 22      1      1      1      1      1
#> 23      0      0      1      0      0
#> 24      0      1      1      1      0
#> 25      1      1      1      1      1
#> 26      1      0      0      1      1
#> 27      0      0      1      1      0
#> 28      0      1      1      1      1
#> 29      0      0      1      1      0
#> 30      0      0      1      1      1

difficulty <- c(0.57, 0.47, 0.7, 0.41, 0.76)
discrimination <- c(0.2, 0.4, 0.4, 0.99, 0.91)
generate_2PL(difficulty = difficulty,
             discrimination = discrimination,
             n = 30,
             identify_groups = TRUE)
#>    Item_1 Item_2 Item_3 Item_4 Item_5
#> 1       1      1      1      1      1
#> 2       1      0      0      1      0
#> 3       0      1      1      1      1
#> 4       1      0      0      1      1
#> 5       1      0      1      1      1
#> 6       0      0      0      1      1
#> 7       0      0      1      1      1
#> 8       1      0      1      1      1
#> 9       0      0      1      1      1
#> 10      0      1      1      1      1
#> 11      0      1      1      1      1
#> 12      0      1      1      1      1
#> 13      1      1      1      0      1
#> 14      1      0      1      1      1
#> 15      1      1      1      1      1
#> 16      1      1      0      1      1
#> 17      1      1      1      1      1
#> 18      0      0      1      1      0
#> 19      0      0      1      1      1
#> 20      0      0      1      1      0
#> 21      0      1      1      1      1
#> 22      1      0      1      1      1
#> 23      0      0      1      1      1
#> 24      0      1      0      1      1
#> 25      1      0      0      0      1
#> 26      0      1      1      1      1
#> 27      0      0      0      1      0
#> 28      1      1      1      1      1
#> 29      1      0      0      1      0
#> 30      1      1      1      1      1
```
