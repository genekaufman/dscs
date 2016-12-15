source('build_sample_files.R')

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}
baseDataDir <- "data/en_US/";
term_count_min_val = 10;

library(text2vec);
library(tm);

tokens <- data_combined_samp %>% tolower(); # %>%  word_tokenizer();

tokenObj <- itoken(tokens);
rm(data_combined_samp);

########
#Create unigram
betterMessage("### Unigram ###");
ngram_RDSfile <- paste0(baseDataDir, "n1_s_",samp_perc, ".Rds");
if (!exists("ngram1")) {
  if (file.exists(ngram_RDSfile)) {
    betterMessage(paste(ngram_RDSfile, " exists, loading"));
    ngram1 <- readRDS(ngram_RDSfile)
  } else {
    betterMessage(paste(ngram_RDSfile, " doesn't exist, creating"));

    ngram1 <- create_vocabulary(tokenObj, ngram = c(1L, 1L),
                            stopwords= c(stopwords("english"),letters)) %>%
          prune_vocabulary(term_count_min = term_count_min_val);

    ngram1$vocab <- ngram1$vocab[order(ngram1$vocab$terms_counts,decreasing = TRUE)];

    saveRDS(ngram1,file=ngram_RDSfile);
  }
}
betterMessage("## Unigram ready!");

########
#Create bigram
betterMessage("### Bigram ###");
ngram_RDSfile <- paste0(baseDataDir, "n1_s_",samp_perc, ".Rds");
if (!exists("ngram2")) {
  if (file.exists(ngram_RDSfile)) {
    betterMessage(paste(ngram_RDSfile, " exists, loading"));
    ngram2 <- readRDS(ngram_RDSfile)
  } else {
    betterMessage(paste(ngram_RDSfile, " doesn't exist, creating"));

    ngram2 <- create_vocabulary(tokenObj, ngram = c(2L, 2L)) %>%
        prune_vocabulary(term_count_min = term_count_min_val);

    ngram2$vocab <- ngram2$vocab[order(ngram2$vocab$terms_counts,decreasing = TRUE)];

    saveRDS(ngram2,file=ngram_RDSfile);
  }
}
betterMessage("## Bigram ready!");

########
#Create trigram
betterMessage("### Trigram ###");
ngram_RDSfile <- paste0(baseDataDir, "n3_s_",samp_perc, ".Rds");
if (!exists("ngram3")) {
  if (file.exists(ngram_RDSfile)) {
    betterMessage(paste(ngram_RDSfile, " exists, loading"));
    ngram3 <- readRDS(ngram_RDSfile)
  } else {
    betterMessage(paste(ngram_RDSfile, " doesn't exist, creating"));

    ngram3 <- create_vocabulary(tokenObj, ngram = c(3L, 3L)) %>%
      prune_vocabulary(term_count_min = term_count_min_val);

    ngram3$vocab <- ngram3$vocab[order(ngram3$vocab$terms_counts,decreasing = TRUE)];

    saveRDS(ngram3,file=ngram_RDSfile);
  }
}
betterMessage("## Trigram ready!");

########
#Create 4-gram
betterMessage("### 4-gram ###");
ngram_RDSfile <- paste0(baseDataDir, "n4_s_",samp_perc, ".Rds");
if (!exists("ngram4")) {
  if (file.exists(ngram_RDSfile)) {
    betterMessage(paste(ngram_RDSfile, " exists, loading"));
    ngram4 <- readRDS(ngram_RDSfile)
  } else {
    betterMessage(paste(ngram_RDSfile, " doesn't exist, creating"));

    ngram4 <- create_vocabulary(tokenObj, ngram = c(4L, 4L)) %>%
      prune_vocabulary(term_count_min = term_count_min_val);

    ngram4$vocab <- ngram4$vocab[order(ngram4$vocab$terms_counts,decreasing = TRUE)];

    saveRDS(ngram4,file=ngram_RDSfile);
  }
}
betterMessage("## 4-gram ready!");
