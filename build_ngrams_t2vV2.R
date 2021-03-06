if (!exists("funcs.loaded")) {
  source('funcs.R')
}

source('build_sample_files.R')

library(text2vec);
library(tm);
library(tokenizers);

betterMessage("Tokenization started...");

# break on everything that is not a letter or an apostrophes (for contractions and pluralization)
#tokens <- data_combined_samp %>%
#          tolower() %>%
#          gsub(pattern="[.?!]", replacement="<EOL>") %>%
##          tokenize_lines()  %>%
#          tokenize_regex((pattern="[^[a-z]|^\']"));

tokens <- data_combined_samp %>%
          tolower() %>%
          tokenize_regex(pattern="[\\.\\!]") %>% unlist() %>%
          tokenize_regex((pattern="[^[a-z]|\']"));

betterMessage("Creating token object ...");

tokenObj <- itoken(tokens );
rm(tokens);
betterMessage("Tokenization complete");

for(n in MinN_Files:MaxN_Files){
  # require lower minimum count as N increases
  term_count_min_val <- 21 - n;
  if (term_count_min_val < 3) { term_count_min_val <- 3; }
  betterMessage(paste0('#### Building n-',n,' ####'));
  thisRDS <- makeNgramFileName(n,samp_perc);
  thisRDSfile <- paste0(thisRDS, ".Rds");
  thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
  betterMessage(paste('### Looking for: ', thisRDSfile));
  if (file.exists(thisRDSfilePath)) {
    betterMessage(paste(thisRDSfilePath, " exists, skipping\n"));
  } else {
    betterMessage(paste(thisRDSfilePath, " doesn't exist, creating"));
    betterMessage(paste("excluded.words:",paste(excluded.words,sep = ",",collapse = " ")));
    if (n > 1) {
      # use only short list of stopwords (excluded.words)
      ngram <-  create_vocabulary(tokenObj, ngram = c(n, n),
                                  stopwords= c(excluded.words,letters)) %>%
                  prune_vocabulary(term_count_min = term_count_min_val);

    } else {
      # only use full list of stopwords for n1
      ngram <-  create_vocabulary(tokenObj, ngram = c(n, n),
                                stopwords= c(stopwords(language = "en"),letters)) %>%
                prune_vocabulary(term_count_min = term_count_min_val);
    }
    ngram$vocab <- ngram$vocab[order(ngram$vocab$terms_counts,decreasing = TRUE)];

    saveRDS(ngram,file=thisRDSfilePath);
    betterMessage(paste0('#### Ngram n-',n,' ready! ####\n'));


  }
}
betterMessage("ALL N-GRAMS CREATED!");
