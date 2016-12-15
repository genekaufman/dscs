# if we don't have the data available, then go get it
#if (!exists("data_news_full")) {
  source('load_data_filesV1.R');

#}
library(ngram)
  #https://cran.r-project.org/web/packages/ngram/ngram.pdf

  readDataFileAsVector <- function(dataFileName) {
    #  tmpFile <- readLines(dataFileName,  encoding = "UTF-8" )
    tmpFile <- readLines(dataFileName);
    tmpFile <- as.vector(tmpFile);
    tmpFile
  }



dataFileName <- "en_US.twitter_smp_100_seed42.txt";
dataFileName <- paste0(baseDataDir,dataFileName);
datafile <- readDataFileAsVector(dataFileName);
data_blogs_samp_V <- as.vector(data_news_samp);
datafile <- data_blogs_samp_V;

myngram <- ngram(datafile,n=2);

my1gram <- ngram(datafile,n=1)
my1gram.pt <- get.phrasetable(my1gram)
head(my1gram.pt,n=10)
my2gram.pt <- get.phrasetable(myngram)
head(my2gram.pt)
