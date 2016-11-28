library(caret)

baseDataDir <- "data/en_US/";
samp_perc <- 0.15;
set.seed(42);

readDataFile <- function(dataFileName) {
#  tmpFile <- readLines(dataFileName,  encoding = "UTF-8" )
  tmpFile <- readLines(dataFileName)
#  tmpFile <-as.data.frame(tmpFile)
  tmpFile
}

betterMessage <- function(strIn) {
  message(paste0('[',date(),'] ',strIn));

}

createDataObject <- function (dataIn, sampPerc=1) {
  betterMessage(paste('####### createDataObject:', dataIn, 'sampPerc:',sampPerc,'#######'));

  objName <- deparse(substitute(dataIn));
  objName <- dataIn;
#  message(paste('23: objName:',objName));
  objDataName <- gsub('en_US.','data_',objName);
  objDataName <- gsub('.txt','',objDataName);
  if (sampPerc == 1) {
    objDataName <- paste0(objDataName,'_full');
  } else {
    objDataFull <- paste0(objDataName,'_full');
    objDataName <- paste0(objDataName,'_samp');
  }
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
        if (sampPerc == 1) {
          tempObj <- readDataFile(TempDataFile);
        } else {
          message(paste('48 dataIn:',dataIn));
          objDataFull <- createDataObject(dataIn,sampPerc=1);
          num_rows <- length(objDataFull);
message(paste('50 num_rows:',num_rows));
          num_samples <- round(num_rows * sampPerc);
          message(paste('52 num_samples:',num_samples));

          tempObj <- objDataFull[sample(1:num_rows, num_samples, replace=FALSE)]

        }
        betterMessage(paste(objDataName,'created, saving to',TempRDSFile ));
        saveRDS(tempObj,file=TempRDSFile);
      } else {
        stop(paste('Error!',TempDataFile,' does not exist!'));
      }
    }
    betterMessage(paste(objDataName,'is ready for action!'));
    tempObj;

 } else {
    betterMessage(paste(objDataName,'found!'));
    message(paste('69 dataIn:',dataIn,'length:',length(dataIn)));
    message(paste('70 objDataName:',objDataName,'length:',length(objDataName)));
    message(paste('71 deparse(substitute(dataIn)):',deparse(substitute(dataIn)),'length:',length(objDataName)));
tempObj <-
    objDataName;
  }
}

# build more manageable data files
full_blogs_file <- "en_US.blogs.txt";
full_news_file <-  "en_US.news.txt";
full_twitter_file <-  "en_US.twitter.txt";

full_blogs_infile <- paste0(baseDataDir, full_blogs_file);
full_news_infile <- paste0(baseDataDir, full_news_file);
full_twitter_infile <- paste0(baseDataDir, full_twitter_file);

data_blogs_full <- createDataObject(full_blogs_file);
#data_news_full <- createDataObject(full_news_file);
#data_twitter_full <- createDataObject(full_twitter_file);
#data_blogs_samp <- createDataObject(full_blogs_file,sampPerc = 0.15);

if (FALSE) {
if (!exists("data_blogs_full")) {
  data_blogs_full_RDSfile <- paste0(baseDataDir, "data_blogs_full.Rds");
  if (file.exists(data_blogs_full_RDSfile)) {
    data_blogs_full <- readRDS(data_blogs_full_RDSfile)
  } else {
    data_blogs_full <- readDataFile(full_blogs_infile);
    saveRDS(data_blogs_full,file=data_blogs_full_RDSfile);
  }
}
if (!exists("data_news_full")) {
  data_news_full_RDSfile <- paste0(baseDataDir, "data_news_full.Rds");
  if (file.exists(data_news_full_RDSfile)) {
    data_news_full <- readRDS(data_news_full_RDSfile)
  } else {
    data_news_full <- readDataFile(full_news_infile);
    saveRDS(data_news_full,file=data_news_full_RDSfile);
  }
}
if (!exists("data_twitter_full")) {
  data_twitter_full_RDSfile <- paste0(baseDataDir, "data_twitter_full.Rds");
  if (file.exists(data_twitter_full_RDSfile)) {
    data_twitter_full <- readRDS(data_twitter_full_RDSfile)
  } else {
    data_twitter_full <- readDataFile(full_twitter_infile);
    saveRDS(data_twitter_full,file=data_twitter_full_RDSfile);
  }
}

if (!exists("data_blogs_samp")) {
  data_blogs_samp_RDSfile <- paste0(baseDataDir, "data_blogs_samp.Rds");
  if (file.exists(data_blogs_samp_RDSfile)) {
    data_blogs_samp <- readRDS(data_blogs_samp_RDSfile)
  } else {
    num_rows <- length(data_blogs_full);

    num_samples <- round(num_rows * samp_perc);
    data_blogs_samp <- data_blogs_full[sample(1:num_rows, num_rows * samp_perc, replace=FALSE)]

    saveRDS(data_blogs_samp,file=data_blogs_samp_RDSfile);
  }
}
if (!exists("data_news_samp")) {
  data_news_samp_RDSfile <- paste0(baseDataDir, "data_news_samp.Rds");
  if (file.exists(data_news_samp_RDSfile)) {
    data_news_samp <- readRDS(data_news_samp_RDSfile)
  } else {
    num_rows <- length(data_news_full);

    num_samples <- round(num_rows * samp_perc);
    data_news_samp <- data_news_full[sample(1:num_rows, num_rows * samp_perc, replace=FALSE)]

    saveRDS(data_news_samp,file=data_news_samp_RDSfile);
  }
}
if (!exists("data_twitter_samp")) {
  data_twitter_samp_RDSfile <- paste0(baseDataDir, "data_twitter_samp.Rds");
  if (file.exists(data_twitter_samp_RDSfile)) {
    data_twitter_samp <- readRDS(data_twitter_samp_RDSfile)
  } else {
    num_rows <- length(data_twitter_full);

    num_samples <- round(num_rows * samp_perc);
    data_twitter_samp <- data_twitter_full[sample(1:num_rows, num_rows * samp_perc, replace=FALSE)]

    saveRDS(data_twitter_samp,file=data_twitter_samp_RDSfile);
  }
}
}

rm(list=ls(pattern='RDSfile'));
#rm(list=ls()[substr(ls(),1,5) != 'data_' & substr(ls(),1,5) != 'data_' ]);

#rm(list=ls()[ls()!="data_blogs_full" & ls()!="data_twitter_full" & ls()!="data_news_full" & ls()!="readDataFile"])
betterMessage("Data loaded, ready for processing")


