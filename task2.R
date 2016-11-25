# if we don't have the data available, then go get it
#if (!exists("data_news_full")) {
  source('load_data_files.R')
#}
library(ngram)
  #https://cran.r-project.org/web/packages/ngram/ngram.pdf

  readDataFileAsVector <- function(dataFileName) {
    #  tmpFile <- readLines(dataFileName,  encoding = "UTF-8" )
    tmpFile <- readLines(dataFileName);
    tmpFile <- as.vector(tmpFile);
    tmpFile
  }



baseDataDir <- "data/en_US/";
dataFileName <- "en_US.twitter_smp_100_seed42.txt";
dataFileName <- paste0(baseDataDir,dataFileName);
datafile <- readDataFileAsVector(dataFileName);


myngram <- ngram(datafile,n=2);

my1gram <- ngram(datafile,n=1)
my1gram.pt <- get.phrasetable(my1gram)
head(my1gram.pt,n=10)
my2gram.pt <- get.phrasetable(myngram)
head(my2gram.pt)
