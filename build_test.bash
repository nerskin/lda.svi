Rscript -e "Rcpp::compileAttributes()"

R CMD INSTALL .

Rscript -e "lda.svi:::lda_online(rep(0:1,500),rep(0:1,500),rep(10,1000),2)"
