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
}

betterMessage("## ngrams ready!");