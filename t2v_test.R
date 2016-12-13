library(text2vec)
library(data.table)

con <- file("data/en_US/en_US.twitter.txt", "r") 
betterMessage("Reading file");
data <- readLines(con, encoding = 'UTF-8')
close(con)

vocab = create_vocabulary(data, ngram = c(1L, 2L));

pruned_vocab = prune_vocabulary(vocab, 
                                 term_count_min = 10, 
                                 doc_proportion_max = 0.5,
                                 doc_proportion_min = 0.001)
vectorizer = vocab_vectorizer(pruned_vocab)
# create dtm_train with new pruned vocabulary vectorizer
t1 = Sys.time()
dtm_train  = create_dtm(data, vectorizer)
print(difftime(Sys.time(), t1, units = 'sec'))

dim(dtm_train)

