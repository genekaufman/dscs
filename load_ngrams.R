if (!exists("funcs.loaded")) {
  source('funcs.R')
}

for(n in 1:MaxN_Files){
  thisNgramObjName <- paste0('ngram',n);
  if (exists(thisNgramObjName)) {
    betterMessage(paste(thisNgramObjName, " already loaded"));

  } else {
    thisRDS <- makeNgramFileName(n,samp_perc);
    thisRDSfile <- paste0(thisRDS, ".Rds");
    thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
    betterMessage(paste('### Looking for: ', thisRDSfile));
    if (file.exists(thisRDSfilePath)) {
      betterMessage(paste(thisRDSfilePath, " exists, loading"));
      assign(thisNgramObjName,readRDS(thisRDSfilePath));
    } else {
      betterMessage(paste(thisRDSfilePath, " doesn't exist, skipping"));
    }
  }

  if (exists(thisNgramObjName)) {
    thisNgram <- paste0("ngram",n);
    thisNgram <- eval(parse(text = thisNgram));
    if (!("terms_perc" %in% colnames(thisNgram$vocab))) {
      betterMessage(paste0("27 terms_perc not evaluated for N-",n));
      sumcount <- sum(thisNgram$vocab$terms_counts);
      ngSums <- sapply(thisNgram$vocab$terms_counts,function(x){x / sumcount})
      thisNgram$vocab <- cbind(thisNgram$vocab[,1:2], terms_perc = unlist(ngSums))
      thisColnames <- colnames(thisNgram$vocab);
      betterMessage(paste(thisColnames,"\n"))
    }
  }
}

betterMessage("## ngrams ready!");