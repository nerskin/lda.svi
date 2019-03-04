#include<RcppArmadillo.h>
#include "lda_svi.h"

#include<boost/math/special_functions/digamma.hpp>

arma::rowvec dirichlet_expectation(const arma::rowvec &alpha){
	arma::rowvec result(alpha.size());
	double alpha_sum = 0;
	for (double i : alpha){
		alpha_sum += i;
	}
	for (int i=0;i<alpha.size();i++){
		result[i]=boost::math::digamma(alpha[i]) - boost::math::digamma(alpha_sum);
	}
	return result;
}
