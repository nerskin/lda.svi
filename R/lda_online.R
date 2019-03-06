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

lda_online <- function(dtm,passes=1,batchsize=256,K,eta=1/K,alpha=1/K,kappa=0.7,tau_0=1024){
	docs <- dtm[[1]]
	terms <- dtm[[2]]
	counts <- dtm[[3]]

	doc_ids <- seq(0,length(unique(docs)))
	names(doc_ids) <- unique(docs)

	term_ids <- seq(0,length(unique(terms)))
	names(term_ids) <- unique(terms)
	
	cat('launching cpp code\n')
	res_list <- lda_online_cpp(doc_ids[docs],term_ids[terms],counts,K,passes,batchsize,eta=eta,alpha=alpha,tau_0=tau_0,kappa=kappa)

	gamma <- res_list$Gamma
	lambda <- res_list$Lambda
	
	colnames(gamma) <- seq(1:ncol(gamma))#topic labels
	rownames(gamma) <- unique(docs)
	
	colnames(lambda) <- unique(terms)
	rownames(lambda) <- seq(1:nrow(lambda))
	
	# convert variational parameters to model parameters 
	# (this follows from equation 2 in the paper)
	# Noting that the expectation of a Dirichlet(a) rv is a/sum(a)	

	theta <- gamma
	beta <- lambda
	
	for (i in seq(1,nrow(gamma))){
	  theta[i,] <- theta[i,]/sum(theta[i,])
	}
	
	for (i in seq(1,nrow(lambda))){
	  beta[i,] <- lambda[i,]/sum(lambda[i,])
	}
	
	list('theta'=theta,'beta'=beta,'lambda'=lambda,'gamma'=gamma)#TODO: tidy output 
}
