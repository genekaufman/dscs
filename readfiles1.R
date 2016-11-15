# build more manageable data files
full_blogs <- "original_data/en_US/en_US.blogs.txt";
full_new <- "original_data/en_US/en_US.news.txt";
full_twitter <- "original_data/en_US/en_US.twitter.txt";

smp_size <- 100;

set.seed(42)
#full_blogs_data <- read.table(full_blogs)


con <- file(full_blogs, "r")
#aa< - readLines(con, smp_size) ## Read the first line of text
aa <- readLines(con, smp_size) ## Read the next line of text
#readLines(con, 5) ## Read in the next 5 lines of text
close(con) ## It's important to close the connection when you are done

