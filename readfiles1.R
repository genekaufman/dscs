# if we don't have the data available, then go get it
if (!exists("data_news_full")) {
  source('load_data_files.R')
}
baseDataDir <- "data/en_US/";


buildOutputFile <- function(seed2use,smpSize2use,dataObjName,baseFileName) {
  tmpOutFile <- paste0(baseDataDir,baseFileName,"_smp_",smpSize2use,"_seed",seed2use,".txt");
  betterMessage(paste('buildOutputFile,tmpOutFile=',tmpOutFile));
  tmpInFile  <- paste0(baseDataDir,baseFileName,".txt");
  betterMessage(paste('buildOutputFile,tmpInFile=',tmpInFile));
  if (exists(dataObjName)) {
    betterMessage('14');
  }
  objNameBOF <- deparse(substitute(dataObjName));
  betterMessage(paste('buildOutputFile,objNameBOF=',objNameBOF));

  if (!file.exists(tmpOutFile)) {
    set.seed(seed2use);
    dataObjName = data_blogs_full;
    tmpIndex <- sample(1:nrow(dataObjName),smpSize2use);
    tmpSampleData <- dataObjName[tmpIndex,]
    write.table(tmpSampleData,file=tmpOutFile,quote=FALSE,row.names = FALSE,col.names = FALSE);

}

buildFullSet <- function(seed,smplsize,blogData,newsData,twitterData) {
  thisSeed = seed;
  thisSampSize=smplsize;
  buildOutputFile(seed2use=thisSeed,smpSize2use = thisSampSize,dataObjName = data_blogs_full,baseFileName = "en_US.blogs")
  buildOutputFile(seed2use=thisSeed,smpSize2use = thisSampSize,dataObjName = data_news_full,baseFileName = "en_US.news")
  buildOutputFile(seed2use=thisSeed,smpSize2use = thisSampSize,dataObjName = data_twitter_full,baseFileName = "en_US.twitter")

}

######### Build 100-line files #####
doFiles <- TRUE;
if (doFiles) {
  buildFullSet(seed=42,smplsize = 100,blogData = data_blogs_full,newsData = data_news_full, twitterData = data_twitter_full);
#  buildFullSet(seed=42,smplsize = 1000,blogData = data_blogs_full,newsData = data_news_full, twitterData = data_twitter_full);
#  buildFullSet(seed=42,smplsize = 8000,blogData = data_blogs_full,newsData = data_news_full, twitterData = data_twitter_full);
#  buildFullSet(seed=68,smplsize = 1000,blogData = data_blogs_full,newsData = data_news_full, twitterData = data_twitter_full);
#  buildFullSet(seed=1986,smplsize = 5000,blogData = data_blogs_full,newsData = data_news_full, twitterData = data_twitter_full);
}


