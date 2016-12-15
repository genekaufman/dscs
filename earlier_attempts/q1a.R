library(dplyr)

blogs <- tbl_df(data_blogs_full) %>%
  mutate(NumChars=nchar(as.character(tmpFile))) %>%
  arrange(desc(NumChars));
print (paste("Longest blog line: ", blogs[1,2]));

news <- tbl_df(data_news_full) %>%
  mutate(NumChars=nchar(as.character(tmpFile))) %>%
  arrange(desc(NumChars));
print (paste("Longest news line: ", news[1,2]));


