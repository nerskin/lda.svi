// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// lda_online_cpp
List lda_online_cpp(IntegerVector doc_ids, IntegerVector terms, IntegerVector counts, int K, int passes, int batchsize, int maxiter, double tau_0, double kappa, double eta, double alpha);
RcppExport SEXP _lda_svi_lda_online_cpp(SEXP doc_idsSEXP, SEXP termsSEXP, SEXP countsSEXP, SEXP KSEXP, SEXP passesSEXP, SEXP batchsizeSEXP, SEXP maxiterSEXP, SEXP tau_0SEXP, SEXP kappaSEXP, SEXP etaSEXP, SEXP alphaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< IntegerVector >::type doc_ids(doc_idsSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type terms(termsSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type counts(countsSEXP);
    Rcpp::traits::input_parameter< int >::type K(KSEXP);
    Rcpp::traits::input_parameter< int >::type passes(passesSEXP);
    Rcpp::traits::input_parameter< int >::type batchsize(batchsizeSEXP);
    Rcpp::traits::input_parameter< int >::type maxiter(maxiterSEXP);
    Rcpp::traits::input_parameter< double >::type tau_0(tau_0SEXP);
    Rcpp::traits::input_parameter< double >::type kappa(kappaSEXP);
    Rcpp::traits::input_parameter< double >::type eta(etaSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    rcpp_result_gen = Rcpp::wrap(lda_online_cpp(doc_ids, terms, counts, K, passes, batchsize, maxiter, tau_0, kappa, eta, alpha));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_lda_svi_lda_online_cpp", (DL_FUNC) &_lda_svi_lda_online_cpp, 11},
    {NULL, NULL, 0}
};

RcppExport void R_init_lda_svi(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
