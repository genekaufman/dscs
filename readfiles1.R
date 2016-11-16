library(caret)

# build more manageable data files
full_blogs <- "data/en_US/en_US.blogs.txt";
full_new <- "data/en_US/en_US.news.txt";
full_twitter <- "data/en_US/en_US.twitter.txt";

smp_size <- 100;

set.seed(42)
if (!exists("full_blogs_data")) {
  full_blogs_data <- readLines(full_blogs)
  full_blogs_data <-as.data.frame(full_blogs_data)

}
rndBlogsIndex <- sample(1:nrow(full_blogs_data),1000)
blogs_data_1000 <- full_blogs_data[rndBlogsIndex,]

#con <- file(full_blogs, "r")
#aa <- readLines(con, smp_size) ## Read the next line of text
##readLines(con, 5) ## Read in the next 5 lines of text
#close(con) ## It's important to close the connection when you are done



