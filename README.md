
<!-- README.md is generated from README.Rmd. Please edit that file -->

# edsamplr

<!-- badges: start -->

<!-- badges: end -->

The edsamplr package supports introductory statistics instruction with
functions for generating sample data to illustrate many of the topics in
a first-semester statistics course. Users can specify parameters of
univariate or bivariate distributions when obtaining sample data. The
functions also calculate summary statistics for illustrating sampling
variation from population parameters.

## Installation

You can install the development version of edsamplr from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("keahtandon/edsamplr")
```

If you plan to use the generate_2PL() function, which generates data to
exemplify measurement concepts related to the two parameter logistic
model, you should include an argument to install the optional packages
required for this function at the same time you install the development
version of edsamplr:

``` r
# install.packages("pak")
pak::pak("keahtandon/edsamplr", dependencies = TRUE)
```

Because this is a source package, users must also install Rtools in
order to install the package. You can install Rtools from
[CRAN](https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html).

You can check to see if you already have Rtools installed with
`pkgbuild`:

``` r
# install.packages("pkgbuild")
pkgbuild::has_rtools(install_rtools = TRUE)
```

*Note*: In both of the above code chunks, the `install.packages()` line
is commented out. If you do not have either of these packages installed,
you will need to remove the comment symbol (#) before running the code.

## Example

This is a basic example that shows you how to generate a sample (n=100)
from a standard normal distribution with summary statistics:

``` r
library(edsamplr)

#generate_quantitative()
```

This is another basic example that generates another sample (n=100) of
categorical data with four unequal groups, also with summary statistics:

``` r
#generate_categorical(k = 4, k_prop = c(0.25, 0.5, 0.1, 0.15))
```

*Note*: Both of these examples have the code commented out to prevent
having the output directly on this description page. To run either
function, you will need to remove the comment symbol (#) before running
the code.

## More Information

For more information on the package and its uses, check out the Get
Started tab. Individual function documentation available under
References and articles about various use cases are available as well.
