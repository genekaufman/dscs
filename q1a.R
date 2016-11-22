library(dplyr)

blogs <- tbl_df(full_blogs_data) %>%
  mutate(NumChars=nchar(as.character(tmpFile))) %>%
  arrange(desc(NumChars));
print (paste("Longest blog line: ", blogs[1,2]));

news <- tbl_df(full_news_data) %>%
  mutate(NumChars=nchar(as.character(tmpFile))) %>%
  arrange(desc(NumChars));
print (paste("Longest news line: ", news[1,2]));


