#library(caret)

baseDataDir <- "data/en_US/";
set.seed(42);

readDataFile <- function(dataFileName) {
#  tmpFile <- readLines(dataFileName,  encoding = "UTF-8" )
  tmpFile <- readLines(dataFileName)
#  tmpFile <-as.data.frame(tmpFile)
  tmpFile
}

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}


# build more manageable data files
full_blogs_file <- "en_US.blogs.txt";
full_news_file <-  "en_US.news.txt";
full_twitter_file <-  "en_US.twitter.txt";

full_blogs_infile <- paste0(baseDataDir, full_blogs_file);
full_news_infile <- paste0(baseDataDir, full_news_file);
full_twitter_infile <- paste0(baseDataDir, full_twitter_file);

if (!exists("data_combined_full")) {
  data_combined_full_RDSfile <- paste0(baseDataDir, "data_combined_full.Rds");
  if (file.exists(data_combined_full_RDSfile)) {
    betterMessage(paste(data_combined_full_RDSfile, " exists, loading"));
    data_combined_full <- readRDS(data_combined_full_RDSfile)
  } else {
    betterMessage(paste(data_combined_full_RDSfile, " doesn't exist, creating"));
    if (!exists("data_blogs_full")) {
      data_blogs_full_RDSfile <- paste0(baseDataDir, "data_blogs_full.Rds");
      if (file.exists(data_blogs_full_RDSfile)) {
        betterMessage(paste(data_blogs_full_RDSfile, " exists, loading"));
        data_blogs_full <- readRDS(data_blogs_full_RDSfile)
      } else {
        betterMessage(paste(data_blogs_full_RDSfile, " doesn't exist, creating"));
        data_blogs_full <- readDataFile(full_blogs_infile);
        saveRDS(data_blogs_full,file=data_blogs_full_RDSfile);
      }
    }
    if (!exists("data_news_full")) {
      data_news_full_RDSfile <- paste0(baseDataDir, "data_news_full.Rds");
      if (file.exists(data_news_full_RDSfile)) {
        betterMessage(paste(data_news_full_RDSfile, " exists, loading"));
        data_news_full <- readRDS(data_news_full_RDSfile)
      } else {
        betterMessage(paste(data_news_full_RDSfile, " doesn't exist, creating"));
        data_news_full <- readDataFile(full_news_infile);
        saveRDS(data_news_full,file=data_news_full_RDSfile);
      }
    }
    if (!exists("data_twitter_full")) {
      data_twitter_full_RDSfile <- paste0(baseDataDir, "data_twitter_full.Rds");
      if (file.exists(data_twitter_full_RDSfile)) {
        betterMessage(paste(data_twitter_full_RDSfile, " exists, loading"));
        data_twitter_full <- readRDS(data_twitter_full_RDSfile)
      } else {
        betterMessage(paste(data_twitter_full_RDSfile, " doesn't exist, creating"));
        data_twitter_full <- readDataFile(full_twitter_infile);
        saveRDS(data_twitter_full,file=data_twitter_full_RDSfile);
      }
    }
    betterMessage(paste("Combining files"));
    data_combined_full <- c(data_blogs_full,data_news_full,data_twitter_full)
    betterMessage(paste("Writing combined files"));
    saveRDS(data_combined_full,file=data_combined_full_RDSfile);
  }
}

if (exists("data_blogs_full")) {rm(data_blogs_full);}
if (exists("data_news_full")) {rm(data_news_full);}
if (exists("data_twitter_full")) {rm(data_twitter_full);}

rm(list=ls(pattern='RDSfile'));
#rm(list=ls(pattern='full_'));
rm(baseDataDir);
#rm(num_samples);
rm(readDataFile);
#rm(list=ls()[substr(ls(),1,5) != 'data_' ]);

#rm(list=ls()[ls()!="data_blogs_full" & ls()!="data_twitter_full" & ls()!="data_news_full" & ls()!="readDataFile"])
betterMessage("Data loaded, ready for processing")


