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
  group_pct = c(0.27, 0.27)
)
```

## Arguments

- difficulty:

  A numeric vector of difficulty values for the items. A difficulty
  value should be provided for each item on a 0 to 1 scale. Values
  closer to 0 indicate harder items, while values closer to 1 indicate
  easier items.

- discrimination:

  A numeric vector of discrimination values for the items. A
  discrimination value should be provided for each item on a -1 to 1
  scale. Negative values are extremely poorly discriminating. Values
  closer to 0 indicate a poorly discriminating item, while values closer
  to 1 indicate better discrimination.

- n:

  A numeric vector for the sample size.

- identify_groups:

  A logical vector for whether students should be grouped into low,
  medium, and high achievement based on their simulated responses.

- group_pct:

  A numeric vector for the proportion of students that should be
  included in the high and low groups. The default is 0.27. The format
  is c(high, low).

## Value

A data frame with n rows and i columns (based on the length of the
difficulty and discrimination vectors).

- Each row represents a vector of scores (correct, incorrect) based on a
  student's response to the simulated test.

- Each column represents a vector of responses to a test item.

- The simulated response values are 0 for an incorrect response and 1
  for a correct response.

- The items will be sorted in increasing order of difficulty.

- If the argument to identify groups is TRUE, a total percentage correct
  column and a grouping column will also be in the return.

## Details

This function requires both the `mirt` and `statmod` packages. If you do
not already have them installed and try to run the function, you will
receive a message about installing them. You can install them
individually, or run
`pak::pak(“keahtandon/edsamplr”, dependencies = TRUE)` to include them
when you install this package.

This function was originally designed to generate samples of dichotomous
response data to use in teaching undergraduate education majors about
the difficulty and discrimination parameters of the two parameter
logistic (2PL) model for use in reviewing selected-response tests and
making decisions based on the item parameters. The 2PL model is an
item-response theory model that uses test response data to model the
probability of an individual correctly responding to a test item based
on the difficulty and discrimination of the item given the individual's
underlying ability level (of the latent trait being studied). Difficulty
is defined as how easy or hard an item is and is calculated through the
proportion of respondents who got the item correct. Discrimination is
defined as how well an item discriminates between individuals with high
ability and low ability. Items that discriminate well will have a higher
probability of a correct answer from high ability individuals than low
ability individuals.

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
#> 1       1      1      1      0      1
#> 2       1      0      1      0      0
#> 3       1      0      1      0      1
#> 4       1      1      1      0      0
#> 5       1      1      1      0      1
#> 6       1      0      1      0      1
#> 7       1      0      1      0      0
#> 8       1      1      1      0      1
#> 9       1      0      1      0      1
#> 10      1      0      1      1      0
#> 11      1      1      1      1      1
#> 12      1      1      1      1      1
#> 13      0      1      1      1      1
#> 14      1      0      1      0      1
#> 15      1      0      1      1      1
#> 16      0      0      1      1      0
#> 17      1      0      1      0      1
#> 18      1      1      1      0      1
#> 19      1      0      0      0      1
#> 20      1      1      1      0      1
#> 21      1      1      0      1      1
#> 22      1      1      1      0      1
#> 23      1      0      1      0      0
#> 24      1      1      1      1      0
#> 25      1      1      1      1      1
#> 26      1      0      0      1      1
#> 27      1      0      1      0      0
#> 28      1      1      1      0      1
#> 29      1      0      1      0      0
#> 30      0      0      1      0      1

difficulty <- c(0.57, 0.47, 0.7, 0.41, 0.76)
discrimination <- c(0.2, 0.4, 0.4, 0.99, 0.91)
generate_2PL(difficulty = difficulty,
             discrimination = discrimination,
             n = 30,
             identify_groups = TRUE)
#> # A tibble: 30 × 7
#>    Item_1 Item_2 Item_3 Item_4 Item_5 Total Group 
#>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl> <chr> 
#>  1      1      1      1      1      1   100 High  
#>  2      1      1      1      1      1   100 High  
#>  3      1      1      1      1      1   100 High  
#>  4      1      1      1      1      1   100 High  
#>  5      1      1      1      0      1    80 High  
#>  6      1      1      1      0      1    80 High  
#>  7      1      0      1      1      1    80 High  
#>  8      1      0      1      1      1    80 High  
#>  9      1      0      1      1      1    80 High  
#> 10      1      1      1      0      1    80 Middle
#> # ℹ 20 more rows
```
