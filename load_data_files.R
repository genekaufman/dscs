library(caret)

baseDataDir <- "data/en_US/";

readDataFile <- function(dataFileName) {
#  tmpFile <- readLines(dataFileName,  encoding = "UTF-8" )
  tmpFile <- readLines(dataFileName)
  tmpFile <-as.data.frame(tmpFile)
  tmpFile
}



# build more manageable data files
full_blogs_infile <- paste0(baseDataDir, "en_US.blogs.txt");
full_news_infile <- paste0(baseDataDir, "en_US.news.txt");
full_twitter_infile <- paste0(baseDataDir, "en_US.twitter.txt");

if (!exists("full_blogs_data")) {
  full_blogs_datafile <- paste0(baseDataDir, "full_blogs_data.Rds");
  if (file.exists(full_blogs_datafile)) {
    full_blogs_data <- readRDS(full_blogs_datafile)
  } else {
    full_blogs_data <- readDataFile(full_blogs_infile);
    saveRDS(full_blogs_data,file=full_blogs_datafile);
  }
}
if (!exists("full_news_data")) {
  full_news_datafile <- paste0(baseDataDir, "full_news_data.Rds");
  if (file.exists(full_news_datafile)) {
    full_news_data <- readRDS(full_news_datafile)
  } else {
    full_news_data <- readDataFile(full_news_infile);
    saveRDS(full_news_data,file=full_news_datafile);
  }
}
if (!exists("full_twitter_data")) {
  full_twitter_datafile <- paste0(baseDataDir, "full_twitter_data.Rds");
  if (file.exists(full_twitter_datafile)) {
    full_twitter_data <- readRDS(full_twitter_datafile)
  } else {
    full_twitter_data <- readDataFile(full_twitter_infile);
    saveRDS(full_twitter_data,file=full_twitter_datafile);
  }
}
rm(list=ls()[ls()!="full_blogs_data" & ls()!="full_twitter_data" & ls()!="full_news_data" & ls()!="readDataFile"])
message("Data loaded, ready for processing")


