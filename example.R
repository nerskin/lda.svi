## ------------------------------------------------------------------------
library(tidyverse)
library(lda.svi)

## ----cache=TRUE----------------------------------------------------------
bench::system_time(lda_fit <- lda_online(reddit_tidy[,c(2,1,3)],K=25,passes=1))

## ------------------------------------------------------------------------
beta <- lda_fit$beta %>% reshape2::melt() %>% transmute(topic=Var1,term=Var2,beta=value)

theta <- lda_fit$theta %>% as.data.frame() %>% rownames_to_column('document') %>% gather(-document,key='topic',value='theta')
# theta

## ------------------------------------------------------------------------
beta %>%
  group_by(topic) %>%
  top_n(beta,n=6) %>%
  arrange(desc(beta)) %>%
  ggplot(aes(term,beta)) +
    geom_col() + 
  coord_flip() +
  theme_minimal() +
  facet_wrap(~topic,scales='free')

## ------------------------------------------------------------------------
#apply(lda_fit$gamma,FUN=function(x)x/sum(x),MARGIN=1) %>%
#  colSums()

