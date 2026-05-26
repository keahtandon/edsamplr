
<!-- README.md is generated from README.Rmd. Please edit that file -->

# edsamplr

<!-- badges: start -->

<!-- badges: end -->

The goal of edsamplr is to enable users to generate sample data for use
in statistics education. It has a variety of functions that should cover
all topics in a first-semester statistics course. The functions are
designed for users to specify parameters about a distribution and
relationships between variables, which are then used for sampling data.
The functions also have optional summary statistics to compare the
output to the original parameters.

## Installation

You can install the development version of edsamplr from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("keahtandon/edsamplr")
```

## Example

This is a basic example that shows you how to generate a sample (n=100)
from a standard normal distribution with summary statistics:

``` r
library(edsamplr)

#generate_quantitative()
```

This is another basic example that generates another sample (n=100) of
categorical data with four unequal groups, also with summary statstics:

``` r
#generate_categorical(k = 4, k_prop = c(0.25, 0.5, 0.1, 0.15))
```

For more information on the package and its uses, check out the
vignettes.
