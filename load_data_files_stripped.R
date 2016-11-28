library(caret)

baseDataDir <- "data/en_US/";
samp_perc <- 0.15;
set.seed(42);

readDataFile <- function(dataFileName) {
  tmpFile <- readLines(dataFileName)
  tmpFile
}

betterMessage <- function(strIn) {
  message(paste0('[',date(),'] ',strIn));

}

createDataObject <- function (dataIn) {
  betterMessage(paste('####### createDataObject:', dataIn,'#######'));

  objName <- dataIn;
  objDataName <- gsub('en_US.','data_',objName);
  objDataName <- gsub('.txt','',objDataName);
  objDataName <- paste0(objDataName,'_full');
  if (!exists(objDataName)) {
    betterMessage(paste('Object',objDataName,'does not exist'));
    TempRDSFile <- paste0(baseDataDir, paste0(objDataName,'.Rds') );

    if (file.exists(TempRDSFile)) {
      betterMessage(paste('Reading', TempRDSFile));
      tempObj <- readRDS(TempRDSFile)
    } else {
      betterMessage(paste(TempRDSFile,'does not exist, creating',objDataName));
      TempDataFile <- paste0(baseDataDir, dataIn )
      if (file.exists(TempDataFile)) {
        betterMessage(paste(TempDataFile,'found, creating',objDataName));
        tempObj <- readDataFile(TempDataFile);
        betterMessage(paste(objDataName,'created, saving to',TempRDSFile ));
        saveRDS(tempObj,file=TempRDSFile);
      } else {
        stop(paste('Error!',TempDataFile,' does not exist!'));
      }
    }
    betterMessage(paste(objDataName,'is ready for action!'));
    tempObj;
  }
}

# build more manageable data files
full_blogs_file <- "en_US.blogs.txt";
full_news_file <-  "en_US.news.txt";
full_twitter_file <-  "en_US.twitter.txt";

full_blogs_infile <- paste0(baseDataDir, full_blogs_file);
full_news_infile <- paste0(baseDataDir, full_news_file);
full_twitter_infile <- paste0(baseDataDir, full_twitter_file);

if (!exists("data_blogs_full")) { data_blogs_full <- createDataObject(full_blogs_file) };
if (!exists("data_news_full")) { data_news_full <- createDataObject(full_news_file) };
if (!exists("data_twitter_full")) { data_twitter_full <- createDataObject(full_twitter_file) };

#rm(list=ls(pattern='RDSfile'));
#rm(list=ls()[substr(ls(),1,5) != 'data_' & substr(ls(),1,5) != 'data_' ]);

#rm(list=ls()[ls()!="data_blogs_full" & ls()!="data_twitter_full" & ls()!="data_news_full" & ls()!="readDataFile"])
betterMessage("Data loaded, ready for processing")


