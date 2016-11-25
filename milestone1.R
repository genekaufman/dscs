# if we don't have the data available, then go get it
source('load_data_files.R')
library("tm")
baseDataDir <- "data/en_US/";

countWords <- function(dataIn) {

  tempCorpus <- VCorpus(VectorSource( dataIn) );
  tempMap <- tm_map(tempCorpus, content_transformer(tolower))
  tempMap <- tm_map(tempMap, removePunctuation)
  tempMap <- tm_map(tempMap, removeNumbers)
  tempMap <- tm_map(tempMap, stripWhitespace)
  tempDocumentTermMatrix <- DocumentTermMatrix(tempMap)

  rowSums(as.matrix(tempDocumentTermMatrix))
}

createCorpus <- function (dataIn,dataFileRDS) {
  #tempCorpus <- VCorpus(VectorSource( dataIn) );
  objName <- deparse(substitute(dataIn));
  objCorpName <- gsub('data_','corp_',objName);
  if (!exists(objCorpName)) {
    message(paste(date(),'Corpus',objCorpName,'does not exist'));
    corpusTempRDSFile <- paste0(baseDataDir, paste0(objCorpName,'.Rds') );

    if (file.exists(corpusTempRDSFile)) {
      message(paste(date(),'Reading', corpusTempRDSFile));
      tempCorp <- readRDS(corpusTempRDSFile)
    } else {
      message(paste(date(), corpusTempRDSFile,'does not exist, creating',objCorpName ));
      tempCorp <- VCorpus(VectorSource( dataIn) );
      message(paste(date(), objCorpName,'created, saving to',corpusTempRDSFile ));
      saveRDS(tempCorp,file=corpusTempRDSFile);
    }
    assign(objCorpName,tempCorp);
  }
  message(paste(date(),objCorpName,'is ready for action!'));
}


message(paste(date(),'Creating Basic data summaries'));

# 0 = blogs
# 1 = news
# 2 = twitter

if (FALSE) {
lineCounts <- c(length(data_blogs_full),
               length(data_news_full),
               length(data_twitter_full));

numCharsB <- lapply(data_blogs_full,nchar);
numCharsN <- lapply(data_news_full,nchar);
numCharsT <- lapply(data_twitter_full,nchar);

longestLines <- c(which.max(numCharsB),
                  which.max(numCharsN),
                  which.max(numCharsT));

rm(list=ls(pattern='numChars'));
}

message(paste(date(),'Checking for Corpus objects'));
#createCorpus(data_blogs_full);
#createCorpus(data_news_full);
rm(data_blogs_full);
rm(data_news_full);
createCorpus(data_twitter_full);

#wordCounts <- c(countWords(data_blogs_full),
#                countWords(data_news_full),
#                countWords(data_twitter_full));
message(paste(date(),'Corpus objects done'));

