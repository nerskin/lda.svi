#' Fit a Latent Dirichlet Allocation model to tidied text data 
#'
#' @param dtm A data frame with three columns. The first column is a vector of document ids (a character vector), the second is a a vector of terms (a character vector), and the third is a vector of counts (an integer vector).
#' @param passes How many times we look at each document
#' @param batchsize The size of the minibatches
#' @param eta hyperparameter
#' @param alpha hyperparameter
#' @param kappa learning rate parameter
#' @param tau_0 learning rate parameter
#' @param K The number of topics
#' @export

lda_online <- function(dtm,passes=1,batchsize=256,K,eta=1,alpha=1,kappa=0.7,tau_0=1024){
  
	#TODO: rely on names rather than column positions
	docs <- dtm[[1]]
	terms <- dtm[[2]]
	counts <- dtm[[3]]

	doc_ids <- seq(0,length(unique(docs)))
	names(doc_ids) <- unique(docs)

	term_ids <- seq(0,length(unique(terms)))
	names(term_ids) <- unique(terms)
	
	cat('launching cpp code')
	res_list <- lda_online_cpp(doc_ids[docs],term_ids[terms],counts,K,passes,batchsize)

	gamma <- res_list$Gamma
	lambda <- res_list$Lambda
	
	colnames(gamma) <- seq(1:ncol(gamma))#topic labels
	rownames(gamma) <- unique(docs)
	
	colnames(lambda) <- unique(terms)
	rownames(lambda) <- seq(1:nrow(lambda))
	
	# convert variational parameters to model parameters 
	# (this follows from equation 2 in the paper)
	# Noting that the expectation of a Dirichlet(a) rv is a/sum(a)	

	theta <- apply(gamma,MARGIN=1,FUN=function(x)x/sum(x)) 
	beta <- apply(lambda,MARGIN=2,FUN=function(x)x/sum(x))
	
	list('theta'=theta,'beta'=beta)#TODO: tidy output 
}
