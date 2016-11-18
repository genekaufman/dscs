loveCount <- length(grep('love',full_twitter_data$tmpFile,ignore.case = FALSE))
hateCount <- length(grep('hate',full_twitter_data$tmpFile,ignore.case = FALSE))
loveCount / hateCount
