library(caret)

baseDataDir <- "data/en_US/";
samp_perc <- 0.01;
samp_perc <- 333;
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
data_samp <- paste0("data_blogs_samp_",samp_perc);
if (!exists(data_samp)) {
  data_blogs_samp_RDSfile <- paste0(baseDataDir, data_samp, ".Rds");
  if (file.exists(data_blogs_samp_RDSfile)) {
    data_blogs_samp <- readRDS(data_blogs_samp_RDSfile)
  } else {
    num_rows <- length(data_blogs_full);

    if (samp_perc > 1) {
      num_samples <- samp_perc;
    } else {
      num_samples <- round(num_rows * samp_perc);
    }

    data_blogs_samp <- data_blogs_full[sample(1:num_rows, num_samples, replace=FALSE)];

    saveRDS(data_blogs_samp,file=data_blogs_samp_RDSfile);
  }
}

data_samp <- paste0("data_news_samp_",samp_perc);
if (!exists(data_samp)) {
  data_news_samp_RDSfile <- paste0(baseDataDir, data_samp, ".Rds");
  if (file.exists(data_news_samp_RDSfile)) {
    data_news_samp <- readRDS(data_news_samp_RDSfile)
  } else {
    num_rows <- length(data_news_full);

    if (samp_perc > 1) {
      num_samples <- samp_perc;
    } else {
      num_samples <- round(num_rows * samp_perc);
    }
    data_news_samp <- data_news_full[sample(1:num_rows, num_samples, replace=FALSE)]

    saveRDS(data_news_samp,file=data_news_samp_RDSfile);
  }
}

data_samp <- paste0("data_twitter_samp_",samp_perc);
if (!exists(data_samp)) {
  data_twitter_samp_RDSfile <- paste0(baseDataDir, data_samp, ".Rds");
  if (file.exists(data_twitter_samp_RDSfile)) {
    data_twitter_samp <- readRDS(data_twitter_samp_RDSfile)
  } else {
    num_rows <- length(data_twitter_full);

    if (samp_perc > 1) {
      num_samples <- samp_perc;
    } else {
      num_samples <- round(num_rows * samp_perc);
    }
    data_twitter_samp <- data_twitter_full[sample(1:num_rows, num_samples, replace=FALSE)]

    saveRDS(data_twitter_samp,file=data_twitter_samp_RDSfile);
  }
}


rm(list=ls(pattern='RDSfile'));
rm(list=ls(pattern='full_'));
rm(baseDataDir);
rm(data_samp);
if (exists("num_rows")) {rm(num_rows);}
if (exists("num_samples")) {rm(num_samples);}
#rm(num_samples);
rm(samp_perc);
rm(readDataFile);
#rm(list=ls()[substr(ls(),1,5) != 'data_' ]);

#rm(list=ls()[ls()!="data_blogs_full" & ls()!="data_twitter_full" & ls()!="data_news_full" & ls()!="readDataFile"])
betterMessage("Data loaded, ready for processing")


