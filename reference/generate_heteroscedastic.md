# Generate samples of heteroscedastic data

`generate_heteroscedastic()` is a function to generate samples of data
with specified degree of heteroscedasticity

## Usage

``` r
generate_heteroscedastic(n = 1000, degree)
```

## Arguments

- n:

  A numeric vector for the sample size. The default value is 1000.

- degree:

  A numeric vector for the degree of heteroscedasticity, in which 1 is
  homoscedastic and 5 is extremely heteroscedastic.

## Value

A data frame with n rows and 2 columns

## Details

This function was designed to help teach students about
heteroscedasticity and what it looks like. The function allows for
degrees of severity to help show the differences. This is useful for
students who have recently been introduced to it and may not see the
nuance in a real data set.

It can also be used as a data set for demonstrating the consequences of
violating the equal variances assumption in linear regression. While the
ASA recommends the use of real data as a best practice, finding
published data sets that demonstrate heteroscedasticity is more
challenging than for other educational topics.

## Examples

``` r
test <- generate_heteroscedastic(degree = 4)
model <- lm(v2 ~ v1, data = test)
plot(model, 2)


test <- generate_heteroscedastic(n = 20, degree = 2)
model <- lm(v2 ~ v1, data = test)
plot(model, 2)

```
