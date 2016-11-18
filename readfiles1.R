library(caret)

baseDataDir <- "data/en_US/";

readDataFile <- function(dataFileName) {
#  tmpFile <- readLines(dataFileName,  encoding = "UTF-8" )
  tmpFile <- readLines(dataFileName)
  tmpFile <-as.data.frame(tmpFile)
  tmpFile
}

buildOutputFile <- function(seed2use,smpSize2use,dataObjName,baseFileName) {
  tmpOutFile <- paste0(baseDataDir,baseFileName,"_smp_",smpSize2use,"_seed",seed2use,".txt");
  tmpInFile  <- paste0(baseDataDir,baseFileName,".txt");
  if (!file.exists(tmpOutFile)) {
    set.seed(seed2use);
    tmpIndex <- sample(1:nrow(dataObjName),smpSize2use);
    tmpSampleData <- dataObjName[tmpIndex,]
    write.table(tmpSampleData,file=tmpOutFile,quote=FALSE,row.names = FALSE,col.names = FALSE);
  }

}

buildFullSet <- function(seed,smplsize,blogData,newsData,twitterData) {
  thisSeed = seed;
  thisSampSize=smplsize;
  buildOutputFile(seed2use=thisSeed,smpSize2use = thisSampSize,dataObjName = blogData,baseFileName = "en_US.blogs")
  buildOutputFile(seed2use=thisSeed,smpSize2use = thisSampSize,dataObjName = newsData,baseFileName = "en_US.news")
  buildOutputFile(seed2use=thisSeed,smpSize2use = thisSampSize,dataObjName = twitterData,baseFileName = "en_US.twitter")

}

# build more manageable data files
full_blogs_infile <- paste0(baseDataDir, "en_US.blogs.txt");
full_news_infile <- paste0(baseDataDir, "en_US.news.txt");
full_twitter_infile <- paste0(baseDataDir, "en_US.twitter.txt");

start.time <- Sys.time()

if (!exists("full_blogs_data")) {
  full_blogs_data <- readDataFile(full_blogs_infile)
}
if (!exists("full_news_data")) {
  full_news_data <- readDataFile(full_news_infile)
}
if (!exists("full_twitter_data")) {
  full_twitter_data <- readDataFile(full_twitter_infile)
}

######### Build 100-line files #####
doFiles <- FALSE;
if (doFiles) {
  buildFullSet(seed=42,smplsize = 100,blogData = full_blogs_data,newsData = full_news_data, twitterData = full_twitter_data);
  buildFullSet(seed=42,smplsize = 1000,blogData = full_blogs_data,newsData = full_news_data, twitterData = full_twitter_data);
  buildFullSet(seed=42,smplsize = 8000,blogData = full_blogs_data,newsData = full_news_data, twitterData = full_twitter_data);
  buildFullSet(seed=68,smplsize = 1000,blogData = full_blogs_data,newsData = full_news_data, twitterData = full_twitter_data);
  buildFullSet(seed=1986,smplsize = 5000,blogData = full_blogs_data,newsData = full_news_data, twitterData = full_twitter_data);
}


