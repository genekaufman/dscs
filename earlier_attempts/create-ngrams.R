# https://gist.github.com/ambodi/b9d3fd69bc02b078b1ab7d180301dd29

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}


source("fast-ngrams.R")
con <- file("data/en_US/en_US.twitter.txt", "r") 
betterMessage("Reading file");
data <- readLines(con, encoding = 'UTF-8')
close(con)

betterMessage("Cleaning data");
data <- clean(data)

betterMessage("Building n-1");
onegram <- text_to_ngrams(decode(data), 1);
saveRDS(onegram,file="data/en_US/n1_twitter.Rds");
rm(onegram);

betterMessage("Building n-2");
bigram <- text_to_ngrams(decode(data), 2)
saveRDS(bigram,file="data/en_US/n2_twitter.Rds");
rm(bigram);

betterMessage("Building n-3");
trigram <- text_to_ngrams(decode(data, 3))
saveRDS(trigram,file="data/en_US/n3_twitter.Rds");
rm(trigram);

betterMessage("Done!");


# How to calculate ngrams for a term
sum(blogs_ngram[,colnames(onegram) == 'term'])