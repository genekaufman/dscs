loveCount <- length(grep('love',data_twitter_full$tmpFile,ignore.case = FALSE))
hateCount <- length(grep('hate',data_twitter_full$tmpFile,ignore.case = FALSE))
loveCount / hateCount
