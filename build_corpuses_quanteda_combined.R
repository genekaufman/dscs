# if we don't have the data available, then go get it
source('load_data_filesV2.R')
#library("tm")
library("quanteda")

baseDataDir <- "data/en_US/";

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}

data_comb<-c(data_news_samp,data_blogs_samp,data_twitter_samp);

rm(list=ls(pattern='_full'));
rm(list=ls(pattern='_news'));
rm(list=ls(pattern='_twitter'));
rm(list=ls(pattern='_blogs'));

data_comb_999 <- data_comb;

ngramsize = 1
betterMessage(paste('### Creating ngram-',ngramsize));
dfmName <- deparse(substitute(data_comb_999));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

if (!exists(tdmTempRDSFile)) {
	betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
	objDFMName <- dfm(data_comb_999, verbose = TRUE, stem = FALSE,
	                  removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
	                  removeSeparators = TRUE, ngrams=ngramsize )
	betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
	saveRDS(objDFMName,file=tdmTempRDSFile);
}


ngramsize = 2
betterMessage(paste('### Creating ngram-',ngramsize));
dfmName <- deparse(substitute(data_comb_999));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

if (!exists(tdmTempRDSFile)) {
  betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
  objDFMName <- dfm(data_comb_999, verbose = TRUE, stem = FALSE,
                    removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                    removeSeparators = TRUE, ngrams=ngramsize )
  betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
  saveRDS(objDFMName,file=tdmTempRDSFile);
}


ngramsize = 3
betterMessage(paste('### Creating ngram-',ngramsize));
dfmName <- deparse(substitute(data_comb_999));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

if (!exists(tdmTempRDSFile)) {
  betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
  objDFMName <- dfm(data_comb_999, verbose = TRUE, stem = FALSE,
                    removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                    removeSeparators = TRUE, ngrams=ngramsize )
  betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
  saveRDS(objDFMName,file=tdmTempRDSFile);
}


ngramsize = 4
betterMessage(paste('### Creating ngram-',ngramsize));
dfmName <- deparse(substitute(data_comb_999));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

if (!exists(tdmTempRDSFile)) {
  betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
  objDFMName <- dfm(data_comb_999, verbose = TRUE, stem = FALSE,
                    removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                    removeSeparators = TRUE, ngrams=ngramsize )
  betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
  saveRDS(objDFMName,file=tdmTempRDSFile);
}


ngramsize = 5
betterMessage(paste('### Creating ngram-',ngramsize));
dfmName <- deparse(substitute(data_comb_999));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

if (!exists(tdmTempRDSFile)) {
  betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
  objDFMName <- dfm(data_comb_999, verbose = TRUE, stem = FALSE,
                    removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                    removeSeparators = TRUE, ngrams=ngramsize )
  betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
  saveRDS(objDFMName,file=tdmTempRDSFile);
}


betterMessage(paste('Corpus creation finished'));
