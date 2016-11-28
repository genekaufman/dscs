# if we don't have the data available, then go get it
source('load_data_files.R')
library("tm")
baseDataDir <- "data/en_US/";

betterMessage <- function(strIn) {
  message(paste0('[',date(),'] ',strIn));

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

makeTDM <- function (dataIn) {
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
      tempTDM <- VCorpus(VectorSource( dataIn) );
      tempMap <- tm_map(tempTDM, content_transformer(tolower))
      tempMap <- tm_map(tempMap, removePunctuation)
      tempMap <- tm_map(tempMap, removeNumbers)
      tempMap <- tm_map(tempMap, stripWhitespace)
      objTDMName <- DocumentTermMatrix(tempMap)
      betterMessage(paste(objTDMName,'created, saving to',tdmTempRDSFile ));
      saveRDS(objTDMName,file=tdmTempRDSFile);
    }

  }
  betterMessage(paste(objTDMName,'is ready for action!'));
  tempTDM;
}

makeTDMOLD <- function(dataIn) {

  tempMap <- tm_map(dataIn, content_transformer(tolower))
  tempMap <- tm_map(tempMap, removePunctuation)
  tempMap <- tm_map(tempMap, removeNumbers)
  tempMap <- tm_map(tempMap, stripWhitespace)
  tempDocumentTermMatrix <- DocumentTermMatrix(tempMap)

  tempDocumentTermMatrix;
}



message(paste(date(),'Creating Basic data summaries'));

# 0 = blogs
# 1 = news
# 2 = twitter

if (TRUE) {
betterMessage(paste('Calculating lineCounts'));
lineCounts <- c(length(data_blogs_full),
               length(data_news_full),
               length(data_twitter_full));

betterMessage(paste('Calculating longestLines'));
numCharsB <- lapply(data_blogs_full,nchar);
numCharsN <- lapply(data_news_full,nchar);
numCharsT <- lapply(data_twitter_full,nchar);


longestLines <- c(which.max(numCharsB),
                  which.max(numCharsN),
                  which.max(numCharsT));

#rm(list=ls(pattern='numChars'));
}

betterMessage(paste('Checking for Corpus objects'));
#corp_blogs_full <- createCorpus(data_blogs_full);
#tdm_blogs_full <- makeTDM(corp_blogs_full);
#rm(corp_blogs_full);

#corp_news_full <- createCorpus(data_news_full);
#tdm_news_full <- makeTDM(corp_news_full);
rm(corp_news_full);

corp_twitter_full <- createCorpus(data_twitter_full);
tdm_twitter_full <- makeTDM(corp_twitter_full);
rm(corp_twitter_full);

betterMessage(paste('Calculating wordCounts'));
wordCounts <- c(countWords(tdm_blogs_full),
                countWords(tdm_news_full),
                countWords(tdm_twitter_full));
betterMessage(paste('wordCounts done'));

