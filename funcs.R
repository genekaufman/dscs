library(magrittr);
library(stringr);
if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}
funcs.loaded <- TRUE;

baseDataDir <- "data/en_US/";

samp_perc <- 0.5;
seed_primer <- 42;
set.seed(seed_primer * samp_perc);

MaxN_Files <- 5;

term_count_min_val = 10; # minimum count for a term to be included in ngram

Num2ResultsPerNgram <- 5;
showNewTerm <- FALSE;

testThe <- function() {
  xx <- ngram1$vocab[startsWith(ngram1$vocab$terms,"the"),1:2];
  xx;
}

makeNgramFileName <- function(n,s) {
  thisFnam <- paste0("ngram_samp_", s,"_n",n);
  thisFnam;

}

chopTerm <- function(thisTerm,maxTokens){
  mytermArray <- strsplit(thisTerm," ");
  lenMyTerm <- length(mytermArray[[1]]);
  if (lenMyTerm >= maxTokens) {
    excess <- lenMyTerm - maxTokens + 2; # we want to use the biggest ngram, so that's an additional +1
    thisTerm <- paste(mytermArray[[1]][excess:lenMyTerm],collapse = " ");
    if (showNewTerm) { message("new term: ", thisTerm); }
  }
  thisTerm;
}

predictTermsNgramsV2 <- function(myterm) {
  message("Incoming: ", myterm);
  final<-NULL;

  maxTokens <- MaxN_Files;
  numTerms <- str_count(myterm," ");
  if ((numTerms + 2) < maxTokens) {
    maxTokens <- numTerms + 2;
  }

  while(maxTokens > 1) {
    myterm <- chopTerm(myterm,maxTokens);
    interim <- predictTermsNgramsEngine(myterm,maxTokens );
    if (!is.null(interim)) {
      final <- rbind(final,interim);
      break;
    }
    maxTokens <- maxTokens - 1;
  }
  if (!is.null(final)) {
   nfinal <- final[,1:4];
   final <- nfinal;
  }
  final;

}

predictTermsNgrams <- function(myterm) {
  message("Incoming: ", myterm);
  final<-NULL;

  maxTokens <- MaxN_Files;

  while(maxTokens > 1) {
    myterm <- chopTerm(myterm,maxTokens);
    interim <- predictTermsNgramsEngine(myterm,maxTokens );
    if (!is.null(interim)) {
      final <- rbind(final,interim);
    }
    maxTokens <- maxTokens - 1;
  }
  final;

}

predictTermsNgramsEngine <- function (myterm, maxTokens=MaxN_Files) {
#  message("predictTermsNgrams maxTokens:",maxTokens);

  myterm <- chopTerm(myterm,maxTokens);
#  mytermArray <- strsplit(myterm," ");
#  lenMyTerm <- length(mytermArray[[1]]);
#  if (lenMyTerm > MaxN_Files) {
#    excess <- lenMyTerm - MaxN_Files + 2; # we want to use the biggest ngram, so that's an additional +1
#    myterm <- paste(mytermArray[[1]][excess:lenMyTerm],collapse = " ");
#    message(paste("new term: ", myterm));
#  }
  output <- NULL;
  searchTerm <- prepSearchTerm(myterm);
  ngram2use <- str_count(searchTerm,"_") + 1;
#  message("ngram2use:",ngram2use);
  thisNgram <- paste0("ngram",ngram2use);
  if (exists(thisNgram)) {
    # send myterm, not searchTerm, as calling prepSearchTerm a second time strips out _'s
    xx <- getNgramResults(myterm,ngram2use);
    abc <- nrow(xx);
    numResults <- min(Num2ResultsPerNgram,nrow(xx));
    if (!is.null(xx)) {
      xx <- xx[1:numResults,];
      xx$ngram <- paste0("n",ngram2use);
      xx$pred_term <- gsub(searchTerm,"",xx$terms);
      if (exists("output")) {
        output <- rbind(xx,output);
      } else {
        output <- xx;
      }
    } else {
#      if (maxTokens > 2) {
#        message("maxTokens:",maxTokens);
#        nextTokens <- maxTokens - 2;
      #        message("nextTokens:",nextTokens);
      #        nextone <- predictTermsNgrams(myterm = myterm, maxTokens = nextTokens);
      #        if (exists("output")) {
      #          output <- rbind(nextone,output);
      #        } else {
      #          output <- nextone;
      #        }

       # return (nextone);
      #      }
    }
  }

  if (!exists("output")) {
    output <- "not found";
  }

  output;
}

prepSearchTerm <- function(ss) {
  pst <- ss %>%
    tolower() %>%
    gsub(pattern="[^[a-z ]|^\'|^_]", replacement="");
  pst <- paste0(gsub(" ","_",pst),"_");
  pst;
}

getNgramResults <- function(myterm,ngram2use) {
  myterm <- prepSearchTerm(myterm);

  thisNgram <- paste0("ngram",ngram2use);

  if (exists(thisNgram)) {

    thisNgram <- eval(parse(text = thisNgram));
    xx <- thisNgram$vocab[startsWith(thisNgram$vocab$terms,myterm),1:2];
    abc <- nrow(xx);

    numResults <- min(Num2ResultsPerNgram,nrow(xx));
#    if (!is.null(xx)) {
    if (numResults > 0) {
      zz <- xx[1:numResults,];
      zz$ngram <- paste0("n",ngram2use);
      zz$pred_term <- gsub(myterm,"",zz$terms);
      return(zz);
    } else {
      return(NULL);
    }
  } else {
    return(NULL);
  }


}


findTermsNgrams <- function (myterm) {
  numTokensInTerm <- str_count(myterm,"_") + 1;
  for(n in 1:MaxN_Files){
    ngResults <- getNgramResults(myterm,n);
    if (exists("ngResults")) {
      if (exists("output")) {
        output <- rbind(ngResults,output);
      } else {
        output <- ngResults;
      }
    }
  }

  if (!exists("output")) {
    output <- "not found";
  }

  output;
}
