
n<-1;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram1$vocab$terms_counts);
ngSums <- sapply(ngram1$vocab$terms_counts,function(x){x / sumcount})
ngram1$vocab <- cbind(ngram1$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram1,file=thisRDSfilePath);

n<-2;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram2$vocab$terms_counts);
ngSums <- sapply(ngram2$vocab$terms_counts,function(x){x / sumcount})
ngram2$vocab <- cbind(ngram2$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram2,file=thisRDSfilePath);

n<-3;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram3$vocab$terms_counts);
ngSums <- sapply(ngram3$vocab$terms_counts,function(x){x / sumcount})
ngram3$vocab <- cbind(ngram3$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram3,file=thisRDSfilePath);

n<-4;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram4$vocab$terms_counts);
ngSums <- sapply(ngram4$vocab$terms_counts,function(x){x / sumcount})
ngram4$vocab <- cbind(ngram4$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram4,file=thisRDSfilePath);

n<-5;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram5$vocab$terms_counts);
ngSums <- sapply(ngram5$vocab$terms_counts,function(x){x / sumcount})
ngram5$vocab <- cbind(ngram5$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram5,file=thisRDSfilePath);

n<-6;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram6$vocab$terms_counts);
ngSums <- sapply(ngram6$vocab$terms_counts,function(x){x / sumcount})
ngram6$vocab <- cbind(ngram6$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram6,file=thisRDSfilePath);

n<-7;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram7$vocab$terms_counts);
ngSums <- sapply(ngram7$vocab$terms_counts,function(x){x / sumcount})
ngram7$vocab <- cbind(ngram7$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram7,file=thisRDSfilePath);

n<-8;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram8$vocab$terms_counts);
ngSums <- sapply(ngram8$vocab$terms_counts,function(x){x / sumcount})
ngram8$vocab <- cbind(ngram8$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram8,file=thisRDSfilePath);

n<-9;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram9$vocab$terms_counts);
ngSums <- sapply(ngram9$vocab$terms_counts,function(x){x / sumcount})
ngram9$vocab <- cbind(ngram9$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram9,file=thisRDSfilePath);

n<-10;
thisRDS <- makeNgramFileName(n,samp_perc);
thisRDSfile <- paste0(thisRDS, ".Rds");
thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
sumcount <- sum(ngram10$vocab$terms_counts);
ngSums <- sapply(ngram10$vocab$terms_counts,function(x){x / sumcount})
ngram10$vocab <- cbind(ngram10$vocab[,1:2], terms_perc = unlist(ngSums))

saveRDS(ngram10,file=thisRDSfilePath);