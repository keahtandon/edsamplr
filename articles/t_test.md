# Teaching Independent Samples t Test

``` r

# library(edsamplr)
# library(tidyverse)
```

### Introduction

Imagine you want to teach your students about independent samples $`t`$
tests. You want to give your students a real-life example, and you
recently came across Deng and McShane’s (2025) article on emojis in
marketing. Unfortunately, you cannot find the original data and you do
not have have time to contact the authors. Fortunately, you can use the
statistics from the article as parameters for simulating sample data.

### Article Abstract

Contributing to a burgeoning area of research on the nuanced effects of
emojis in brand communications, the current research builds
understanding of two dominant forms of emoji role—emojis as text
reinforcement and emojis as text substitution—and their downstream
effects. Across three studies, we examine how emoji roles differentially
interact with message features to influence brand-level outcomes (brand
attitudes, product quality expectations and consumers’ willingness to
try a brand’s product) through their effects on processing fluency. We
find robust evidence that substitution emojis elicit more negative
brand-level outcomes than reinforcement emojis both when the emoji has
low congruence with the text and when the complexity of the text in the
message is high, and that these effects are mediated by processing
fluency. These findings deepen our understanding of emojis’ effects in
brand communications and provide practical guidance for digital
marketers regarding how to effectively leverage emojis. (Deng and
McShane 2025)

### Selected Findings to Sample From

Deng and McShane (2025) had multiple studies and a more complex design,
but their first analysis in their first study was an independent samples
$`t`$ test. The authors compared processing fluency in tweets that
contained emojis and text and those that just contained text and found
that there was a statistically significant difference between the two
groups (Deng and McShane 2025).
``` math
M_{emoji} = 5.86 \text{ vs. } M_{text} = 6.27, t(247) = 2.73, p = 0.003
```

  

**Explanatory variable**: Tweet type

**Response variable**: Processing fluency

  

Since we don’t have the variance or standard deviation of the two
groups, we will have to calculate that from what we do have. We know
from the $`F`$ tests later in the article that the sample sizes are
$`n_{emoji}=171`$ and $`n_{text}=78`$, and we can use the results from
those $`F`$ tests to calculate the variances.

``` r


# what we know

n_emoji <- 171
n_text <- 78
m_emoji <- 5.86
m_text <- 6.27
t <- 2.73

# calculating variance from F stats

m_emoji_r <- 6
m_emoji_s <- 5.73
n_emoji_r <- 87
n_emoji_s <- 84
F_rs <- 2.15

diff_rs <- m_emoji_r - m_emoji_s
var_emoji <- diff_rs^2/(F_rs * (1/n_emoji_r + 1/n_emoji_s))

F_st <- 9.65

se2_total <- (m_text - m_emoji_s)^2/F_st
var_text <- (se2_total - (var_emoji/n_emoji_s)) * n_text
```

Now that we have the variances, we can simulate data. The
[`generate_quantitative()`](https://keahtandon.github.io/edsamplr/reference/generate_quantitative.md)
function provides us the sample data and summary statistics comparing
our input to our output. We can’t get an exact match to the original
data, but we can get close.

``` r


sample <- generate_quantitative(k = 2,
                              mean = c(m_emoji, m_text),
                              var = c(var_emoji, var_text),
                              n = c(n_emoji, n_text),
                              k_names = c("emoji", "text"))

data <- sample$sample

sample$summary
#>           n mean   sd  skew kurtosis
#> input 1 171 5.86 1.20  0.00     0.00
#> k 1     171 5.96 1.17 -0.18     0.57
#> input 2  78 6.27 1.01  0.00     0.00
#> k 2      78 6.06 1.00  0.78     0.21
```

Just to check to see, here is a $`t`$ with the resulting data. We were
not able to recreate their findings, but we had similar data.

``` r


t.test(Value ~ Group, data = data, var.equal = TRUE)
#> 
#>  Two Sample t-test
#> 
#> data:  Value by Group
#> t = -0.65978, df = 247, p-value = 0.51
#> alternative hypothesis: true difference in means between group emoji and group text is not equal to 0
#> 95 percent confidence interval:
#>  -0.4019664  0.2002403
#> sample estimates:
#> mean in group emoji  mean in group text 
#>            5.963175            6.064038
```

If you’re happy with the final product, you’re ready to export the data
for your students. If you’d like to try to get it closer to the original
findings, you can update the arguments in the function and re-run.
Either way, make sure to tell your students that this is not the
original data but a sample simulated from moments that are similar to
the statistics from the original.

### References

Deng, Qi, and Lindsay McShane. 2025. “Emoji Are Not All Created Equal:
The Effects of Emoji Variations on Brand Attitudes, Product Quality
Expectations, and Trial Intentions.” *International Journal of Consumer
Studies* 49. <https://doi.org/10.1111/ijcs.70088>.
