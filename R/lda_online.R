#' Fit a Latent Dirichlet Allocation model to a text corpus
#'
#' @param dtm This may be a DocumentTermMatrix from the tm package, a simple_triplet_matrix from the slam package, or anything coercible to a simple_triplet_matrix. This includes a data frame with the document names in the first column, the terms in the second column, and the number or appearances in the third column.
#' @param passes How many times we look at each document. 
#' @param batchsize The size of the minibatches.
#' @param maxiter The maximum iterations for the "E step" for each document (the updating of the per-document parameters within each minibatch). The default of 100 follows the reference implementation in python by the authors.
#' @param eta hyperparameter for the term
#' @param alpha hyperparameter.
#' @param kappa learning rate parameter. Lower values give greater weight to later iterations. For guaranteed convergence to a local optimum, kappa must lie in the interval (0.5,1].
#' @param tau_0 learning rate parameter. Higher values reduce the influence of early iterations.
#' @param K The number of topics
#' @export

lda_svi <- function(dtm,passes=1,batchsize=256,maxiter=100,K,eta=1/K,alpha=1/K,kappa=0.7,tau_0=1024){

	if (is(dtm,"DocumentTermMatrix")){
		if (!any(attr(dtm,'weighting') %in% c('term frequency','tf'))){
			stop('The DocumentTermMatrix object must use term frequency weighting')
		}
	}

	doc_ids <- dtm$i - 1#the c++ code expects 0-indexed ids
	docs <- dtm$dimnames$Docs

	term_ids <- dtm$j - 1#the c++ code expect 0-indexed ids
	terms <- dtm$dimnames$Terms
	
	counts <- dtm$v

	res_list <- lda_online_cpp(doc_ids,term_ids,counts,K,passes,batchsize,maxiter=maxiter,eta=eta,alpha=alpha,tau_0=tau_0,kappa=kappa)

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

	theta <- reshape2::melt(theta)
	beta <- reshape2::melt(beta)

	colnames(beta) <- c('topic','term','value')
	colnames(theta) <- c('document','topic','value')	

	list('theta'=theta,'beta'=beta,'gamma'=gamma,'lambda'=lambda)#TODO: tidy output 
}
