library(magrittr);
library(stringr);
library(dplyr);
library(sqldf);

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

MaxN_Files <- 10;

term_count_min_val = 10; # minimum count for a term to be included in ngram

Num2ResultsPerNgram <- 5;
showNewTerm <- FALSE;

excluded.words <- c("a","an","and","the");

makeNgramFileName <- function(n,s) {
  thisFnam <- paste0("ngram_samp_", s,"_n",n);
  thisFnam;

}

chopTerm <- function(thisTerm,maxTokens){
  if (showNewTerm) { message("excluded.words: ", excluded.words); }

  mytermArray <- strsplit(thisTerm," ");
  mytermArray2 <- unlist(mytermArray);
  grepTerm <- paste0("\\b(",paste0(excluded.words,collapse = "|"),")\\b");
#  grepTerm <- paste(excluded.words,collapse = "|");
#  grepTerm <- paste0("[",paste(excluded.words,collapse = "|"),"]");
  if (showNewTerm) { message("grepTerm: ", grepTerm); }
  mytermArray <- mytermArray2[!grepl(grepTerm,mytermArray2)]

#  lenMyTerm <- length(mytermArray[[1]]);
  lenMyTerm <- length(mytermArray);
  if (lenMyTerm >= maxTokens) {
    excess <- lenMyTerm - maxTokens + 2; # we want to use the biggest ngram, so that's an additional +1
#    thisTerm <- paste(mytermArray[[1]][excess:lenMyTerm],collapse = " ");
    thisTerm <- paste(mytermArray[excess:lenMyTerm],collapse = " ");
    if (showNewTerm) { message("49 new term: ", thisTerm); }
  } else { # we still want to benefit from stripping out the excluded words
    thisTerm <- paste(mytermArray,collapse = " ");
    if (showNewTerm) { message("52 new term: ", thisTerm); }
  }
  thisTerm;
}

getBestTermSBO <- function(myterm){
  bestTerm <- predictTermsNgramsSBO(myterm);
  if (is.null(bestTerm)) {
    thisOutput <- "Sorry... can't make a prediction";
  } else {
    thisOutput <- bestTerm$pred_term[1];
  }
  thisOutput;
}

predictTermsNgramsSBO <- function(myterm, showAllNgrams = FALSE) {
#  message("Incoming: ", myterm);
  final<-NULL;

  maxTokens <- MaxN_Files;
  numTerms <- str_count(myterm," ");
  if ((numTerms + 2) < maxTokens) {
    maxTokens <- numTerms + 2;
  }

  while(maxTokens > 1) {
    myterm <- chopTerm(myterm,maxTokens);
    interim <- predictTermsNgramsEngineSBO(myterm,maxTokens );
    if (!is.null(interim)) {
      final <- rbind(final,interim);
      if (!showAllNgrams) { break; }
    }
    maxTokens <- maxTokens - 1;
  }
  final;

}

predictTermsNgramsEngineSBO <- function (myterm, maxTokens=MaxN_Files) {
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
#  message("predictTermsNgramsEngineSBO: searchTerm:",searchTerm);
#  message("predictTermsNgramsEngineSBO: myterm:",myterm);
  thisNgram <- paste0("ngram",ngram2use);
  if (exists(thisNgram)) {
    # send myterm, not searchTerm, as calling prepSearchTerm a second time strips out _'s
    xx <- getNgramResultsSBO(myterm,ngram2use);
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

getBestPrediction_MYBO <- function(myterm, showAllNgrams = TRUE, includeUnigrams = FALSE) {
  #  message("Incoming: ", myterm);
  bestTerm<-NULL;
  searchTerm <- prepSearchTerm(myterm);
  myout <- predictTerms_MYBO(myterm);
  #add in unigrams
  if (includeUnigrams) {
  nn <- ngram1$vocab[which(ngram1$vocab$terms %in% unique(myout$pred_term)),]
  nn <- cbind(nn,ngram="n1",pred_term=nn$terms)
  myout <- rbind(myout,nn);
  rm(nn)
  }

  n <- sapply(myout$ngram,function(x) {gsub("n","",x)})
  myout <- cbind(myout,n)
  wx <- sapply(myout,function(x) {as.numeric(myout$n) * myout$terms_perc * 100})
  myout <- cbind(myout,weight = wx[,1])
  rm(wx)
  myout2 <- myout %>% group_by(pred_term) %>% summarize(total_weight = sum(weight), max_n = max(ngram))
  bestTerm <- myout2[order(myout2$total_weight,decreasing=TRUE),]

  if (is.null(bestTerm)) {
    thisOutput <- "Sorry... can't make a prediction";
  } else {
    thisOutput <- bestTerm$pred_term[1];
    thisOutput <- bestTerm[1,];
    #    thisOutput <- bestTerm[1:5,]
  }
  thisOutput;

}

predictTerms_MYBO <- function(myterm, showAllNgrams = TRUE) {
#  message("Incoming: ", myterm);
  final<-NULL;

  maxTokens <- MaxN_Files;
  numTerms <- str_count(myterm," ");
  if ((numTerms + 2) < maxTokens) {
    maxTokens <- numTerms + 2;
  }

  while(maxTokens > 1) {
    myterm <- chopTerm(myterm,maxTokens);
    interim <- predictTermsEngine_MYBO(myterm,maxTokens );
    if (!is.null(interim)) {
      final <- rbind(final,interim);
      if (!showAllNgrams) { break; }
    }
    maxTokens <- maxTokens - 1;
  }
  final;

}

predictTerms_KBO <- function(myterm, showAllNgrams = TRUE) {
  #  message("Incoming: ", myterm);
  final<-NULL;

  maxTokens <- MaxN_Files;
  maxTokens <- 4;
  numTerms <- str_count(myterm," ");
  if ((numTerms + 2) < maxTokens) {
    maxTokens <- numTerms + 2;
  }

  while(maxTokens >= 1) {
    myterm <- chopTerm(myterm,maxTokens);
    interim <- predictTermsEngine_MYBO(myterm,maxTokens );
    if (!is.null(interim)) {
      final <- rbind(final,interim);
      if (!showAllNgrams) { break; }
    }
    maxTokens <- maxTokens - 1;
  }
  final;

}

predictTermsEngine_MYBO <- function (myterm, maxTokens=MaxN_Files) {
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
#  message("predictTermsNgramsEngineSBO: searchTerm:",searchTerm);
#  message("predictTermsNgramsEngineSBO: myterm:",myterm);
  thisNgram <- paste0("ngram",ngram2use);
  if (exists(thisNgram)) {
    # send myterm, not searchTerm, as calling prepSearchTerm a second time strips out _'s
    xx <- getNgramResults_MYBO(myterm,ngram2use);
    ##numResults <- min(Num2ResultsPerNgram,nrow(xx));
    numResults <- nrow(xx);
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
  pst <- pst %>% gsub(pattern = "\\_+",replacement="_");
  pst;
}


getNgramResults_MYBO <- function(myterm,ngram2use) {
  myterm <- prepSearchTerm(myterm);

  thisNgram <- paste0("ngram",ngram2use);

  if (exists(thisNgram)) {

    thisNgram <- eval(parse(text = thisNgram));
    xx <- thisNgram$vocab[startsWith(thisNgram$vocab$terms,myterm),];
#    numResults <- min(Num2ResultsPerNgram,nrow(xx));
    numResults <- nrow(xx);
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


getNgramResultsSBO <- function(myterm,ngram2use) {
  myterm <- prepSearchTerm(myterm);

  thisNgram <- paste0("ngram",ngram2use);

  if (exists(thisNgram)) {

    thisNgram <- eval(parse(text = thisNgram));
    xx <- thisNgram$vocab[startsWith(thisNgram$vocab$terms,myterm),];
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


# NOT USED #
findTermsNgrams <- function (myterm) {
  numTokensInTerm <- str_count(myterm,"_") + 1;
  for(n in 1:MaxN_Files){
    ngResults <- getNgramResultsSBO(myterm,n);
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


junk <- function() {

  betterMessage("start");
  sumcount <- sum(ngram1$vocab$terms_counts);
  ngSums <- sapply(ngram1$vocab$terms_counts,function(x){x / sumcount})
  ngram1$vocab <- cbind(ngram1$vocab, terms_perc = unlist(ngSums))
betterMessage("finish");


}
