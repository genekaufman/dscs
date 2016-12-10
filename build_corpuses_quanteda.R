# if we don't have the data available, then go get it
source('load_data_filesV1.R')
library("quanteda")

baseDataDir <- "data/en_US/";

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}

countWords <- function(dataIn) {
  rowSums(as.matrix(dataIn))
}

createCorpus <- function (dataIn) {
  betterMessage(paste('####### createCorpus #######'));

  objName <- deparse(substitute(dataIn));
  objCorpName <- gsub('data_','corp_',objName);
  if (!exists(objCorpName)) {
    betterMessage(paste('Corpus',objCorpName,'does not exist'));
    corpusTempRDSFile <- paste0(baseDataDir, paste0(objCorpName,'.Rds') );

    if (file.exists(corpusTempRDSFile)) {
      betterMessage(paste('Reading', corpusTempRDSFile));
      tempCorp <- readRDS(corpusTempRDSFile)
    } else {
      betterMessage(paste(corpusTempRDSFile,'does not exist, creating',objCorpName));
      tempCorp <- VCorpus(VectorSource( dataIn) );
      betterMessage(paste(objCorpName,'created, saving to',corpusTempRDSFile ));
      saveRDS(tempCorp,file=corpusTempRDSFile);
    }
    #assign(objCorpName,tempCorp);
  }
  betterMessage(paste(objCorpName,'is ready for action!'));
  tempCorp;
}

TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

makeDFM <- function (dataIn) {
  betterMessage(paste('####### makeDFM #######'));

  objName <- deparse(substitute(dataIn));
  objDFMName <- gsub('corp_','dfm_',objName);
  if (!exists(objDFMName)) {
    betterMessage(paste('DFM',objDFMName,'does not exist'));
    tdmTempRDSFile <- paste0(baseDataDir, paste0(objDFMName,'.Rds') );

    if (file.exists(tdmTempRDSFile)) {
      betterMessage(paste('Reading', tdmTempRDSFile));
      tempTDM <- readRDS(tdmTempRDSFile)
    } else {
      betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objDFMName));
#      tempTDM <- Corpus(VectorSource( dataIn) );
#      tempMap <- tm_map(tempTDM, content_transformer(tolower))
#      tempMap <- tm_map(tempMap, removePunctuation)
#      tempMap <- tm_map(tempMap, removeNumbers)
#      tempMap <- tm_map(tempMap, stripWhitespace)
      objDFMName <- dfm(tempTDM, verbose = TRUE, stem = FALSE,
                        removePunct = TRUE, removeNumbers = TRUE, toLower=TRUE,
                        removeSeparators = TRUE, ngrams=1 )
      betterMessage(paste(objDFMName,'created, saving to',tdmTempRDSFile ));
      saveRDS(objDFMName,file=tdmTempRDSFile);
    }

  }
  betterMessage(paste(objTDMName,'is ready for action!'));
  tempTDM;
}


makeTDM_tm <- function (dataIn) {
  betterMessage(paste('####### makeTDM #######'));

  objName <- deparse(substitute(dataIn));
  objTDMName <- gsub('corp_','tdm_',objName);
  if (!exists(objTDMName)) {
    betterMessage(paste('TDM',objTDMName,'does not exist'));
    tdmTempRDSFile <- paste0(baseDataDir, paste0(objTDMName,'.Rds') );

    if (file.exists(tdmTempRDSFile)) {
      betterMessage(paste('Reading', tdmTempRDSFile));
      tempTDM <- readRDS(tdmTempRDSFile)
    } else {
      betterMessage(paste(tdmTempRDSFile,'does not exist, creating',objTDMName));
      tempTDM <- Corpus(VectorSource( dataIn) );
      tempMap <- tm_map(tempTDM, content_transformer(tolower))
      tempMap <- tm_map(tempMap, removePunctuation)
      tempMap <- tm_map(tempMap, removeNumbers)
      tempMap <- tm_map(tempMap, stripWhitespace)
      objTDMName <- TermDocumentMatrix(tempMap,control = list(tokenize=TrigramTokenizer))

      betterMessage(paste(objTDMName,'created, saving to',tdmTempRDSFile ));
      saveRDS(objTDMName,file=tdmTempRDSFile);
    }

  }
  betterMessage(paste(objTDMName,'is ready for action!'));
  tempTDM;
}


# 0 = blogs
# 1 = news
# 2 = twitter


betterMessage(paste('Checking for Corpus objects'));

rm(list=ls(pattern='_full'));
rm(list=ls(pattern='data_twitter'));
rm(list=ls(pattern='data_blogs'));
rm(list=ls(pattern='corp_twitter'));
rm(list=ls(pattern='corp_blogs'));

if (FALSE) {
data_blogs_samp_0.1 <- data_blogs_samp;
rm(data_blogs_samp);
corp_blogs_samp <- createCorpus(data_blogs_samp_0.1);
tdm_blogs_samp <- makeTDM(corp_blogs_samp);
rm(corp_blogs_samp);
rm(list=ls(pattern='data_blogs'));

data_twitter_samp_0.1 <- data_twitter_samp;
rm(data_twitter_samp);
corp_twitter_samp <- createCorpus(data_twitter_samp_0.1);
tdm_twitter_samp <- makeTDM(corp_twitter_samp);
rm(corp_twitter_samp);
rm(list=ls(pattern='data_twitter'));

}

data_news_samp_0.01 <- data_news_samp;
rm(data_news_samp);
corp_news_samp <- createCorpus(data_news_samp_0.01);
tdm_news_samp <- makeTDM(corp_news_samp);
rm(corp_news_samp);
rm(list=ls(pattern='data_news'));


#betterMessage(paste('Calculating wordCounts'));
#wordCounts <- c(countWords(tdm_blogs_full),
#                countWords(tdm_news_full),
#                countWords(tdm_twitter_full));
#betterMessage(paste('wordCounts done'));
betterMessage(paste('Corpus creation finished'));
