# if we don't have the data available, then go get it
source('load_data_filesV1.R')
#library("tm")
library("quanteda")

baseDataDir <- "data/en_US/";

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}

rm(list=ls(pattern='_full'));
rm(list=ls(pattern='_news'));
rm(list=ls(pattern='_twitter'));


if (FALSE) {

data_blogs_samp_0.01 <- data_blogs_samp;
#rm(data_blogs_samp);
#corp_blogs_samp <- createCorpus(data_blogs_samp_0.1);
tdm_blogs_samp <- makeDFM(data_blogs_samp_0.01);
rm(corp_blogs_samp);
rm(list=ls(pattern='data_twitter'));

}

data_blogs_samp_0.01 <- data_blogs_samp;
#rm(data_news_samp);
##corp_news_samp <- createCorpus(data_news_samp_0.01);
#tdm_news_samp <- makeDFM(data_news_samp_0.01);

ngramsize = 1
dfmName <- deparse(substitute(data_blogs_samp_0.01));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
objDFMName <- dfm(data_blogs_samp_0.01, verbose = TRUE, stem = FALSE,
                  removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                  removeSeparators = TRUE, ngrams=ngramsize )
betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
saveRDS(objDFMName,file=tdmTempRDSFile);

ngramsize = 2
dfmName <- deparse(substitute(data_blogs_samp_0.01));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
objDFMName <- dfm(data_news_samp_0.01, verbose = TRUE, stem = FALSE,
                  removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                  removeSeparators = TRUE, ngrams=ngramsize )
betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
saveRDS(objDFMName,file=tdmTempRDSFile);

ngramsize = 3
dfmName <- deparse(substitute(data_blogs_samp_0.01));
objName <- paste0(dfmName,'_n',ngramsize);
objDFMName <- gsub('data_','dfm_',objName);
  tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

    betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
    objDFMName <- dfm(data_news_samp_0.01, verbose = TRUE, stem = FALSE,
                      removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                      removeSeparators = TRUE, ngrams=ngramsize )
    betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
    saveRDS(objDFMName,file=tdmTempRDSFile);


#rm(corp_news_samp);
#rm(list=ls(pattern='data_news'));


#betterMessage(paste('Calculating wordCounts'));
#wordCounts <- c(countWords(tdm_blogs_full),
#                countWords(tdm_news_full),
#                countWords(tdm_blogs_full));
#betterMessage(paste('wordCounts done'));
betterMessage(paste('Corpus creation finished'));
