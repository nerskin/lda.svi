#include<RcppArmadillo.h>
#include<cmath>
#include "lda_svi.h"

using namespace std;

// '@export
// [[Rcpp::export]]
double lse(const arma::rowvec &log_probs){
	double alpha = arma::max(log_probs);
	cout << alpha << endl;
	double result = alpha + std::log(arma::accu(arma::exp(log_probs - alpha)));
	return result;
}

