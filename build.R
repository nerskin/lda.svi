#!/usr/bin/env Rscript

Rcpp::compileAttributes()
pkgload::load_all()
roxygen2::roxygenise()
