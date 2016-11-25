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



# build more manageable data files
full_blogs_infile <- paste0(baseDataDir, "en_US.blogs.txt");
full_news_infile <- paste0(baseDataDir, "en_US.news.txt");
full_twitter_infile <- paste0(baseDataDir, "en_US.twitter.txt");

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


rm(list=ls(pattern='RDSfile'));
rm(list=ls()[substr(ls(),1,5) != 'data_' ]);

#rm(list=ls()[ls()!="data_blogs_full" & ls()!="data_twitter_full" & ls()!="data_news_full" & ls()!="readDataFile"])
message("Data loaded, ready for processing")


