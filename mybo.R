library(dplyr)
library(sqldf)

myout <- predictTerms_MYBO("as good as it");
#add in unigrams
nn <- ngram1$vocab[which(ngram1$vocab$terms %in% unique(myout$pred_term)),]
nn <- cbind(nn,ngram="n1",pred_term=nn$terms,n1_terms_perc = nn$terms_perc)
nn <- nn[order(nn$pred_term),];
#myout <- rbind(myout,nn);
aa <- myout[which(unique(myout$pred_term) %in% nn$pred_term),]
aa <- aa[order(aa$pred_term),];
aa <- cbind(aa,n1_terms_perc = nn$terms_perc)
myout <- rbind(aa,nn);




n <- sapply(myout$ngram,function(x) {gsub("n","",x)})
myout <- cbind(myout,n)
wx <- sapply(myout,function(x) {as.numeric(myout$n) * myout$terms_perc * 100})
myout <- cbind(myout,weight = wx[,1],n1_terms_perc = myout[which(myout$n == 1),2])
rm(wx)

myout2 <- myout %>% group_by(pred_term) %>% summarize(total_weight = sum(weight))
finalOut <- myout2[order(myout2$total_weight,decreasing=TRUE),]



rm(myout)
rm(myout2)
rm(n)
rm(weight)
rm(nn)
rm(aa)


