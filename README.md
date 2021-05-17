# lda.svi

This R package fits latent dirichlet allocation models to data using the stochastic variational inference method introduced in [this paper](https://papers.nips.cc/paper/3902-online-learning-for-latent-dirichlet-allocation) by Matthew Hoffman and coauthors. This method purports to allow LDA models to be fit considerably faster, and using considerably less memory, than with the popular batch variational Bayes method. As far as I can tell this is the only R package implementing this method. The key functions are implemented in C++ for speed.

A somewhat more helpful reference for the method is [this paper](http://www.jmlr.org/papers/volume14/hoffman13a/hoffman13a.pdf), which motivates the algorithms and places it in a broader context.

## Non-R Dependencies

* A C++ compiler supporting C++11.

## Philosophy

The interface is designed with Hadley Wickham's [tidy data principles](https://vita.had.co.nz/papers/tidy-data.pdf) in mind, and therefore fits in nicely with the [tidytext](https://github.com/juliasilge/tidytext) package by Julia Silge and David Robinson, which I recommend for preprocessing text and postprocessing model output. 

## Installation

I might submit this to the CRAN at some point, but in the meantime you can install it by running

```{r}
#install.packages('devtools')
devtools::install_github("nerskin/lda.svi")
```
