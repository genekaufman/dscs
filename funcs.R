
findTerms <- function(myterm,searchhere) {
  xx <- searchhere[startsWith(names(searchhere),paste0(gsub(" ","_",myterm),"_"))];
  xx;

}

findTermsNgrams <- function (myterm,sampPerc) {
  MaxN_Files <- 2;
  myterm <- paste0(gsub(" ","_",myterm));
  message(paste("myterm:",myterm));
  
  thisNgram <- paste0('n',1,'_s',sampPerc);
  message(thisNgram);

  if(exists(thisNgram)) {
    message(paste("thisNgram class:",class(thisNgram)));
  }
  
  for(n in 1:MaxN_Files){
    thisRDS <- paste0("n", n,"_s",samp_perc);
    thisRDSfile <- paste0(thisRDS, ".Rds");
    thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
#    betterMessage(paste('### Looking for: ', thisRDSfile));
    if (file.exists(thisRDSfilePath)) {
#      betterMessage(paste(thisRDSfilePath, " exists, loading"));
      assign(thisRDS,readRDS(thisRDSfilePath));
      #xx <- thisRDS$vocab[startsWith(thisRDS$vocab$terms,myterm),1:2];
      xx <- n1_s0.5[['vocab']][startsWith(n1_s0.5[['vocab']][['terms']],myterm),1:2];

      xx <- xx[1:5,];
      xx$ngram <- "n1";
      if (exists("output")) {
        output <- rbind(xx,output);
      } else {
        output <- xx;
      }      
    } else {
#      betterMessage(paste(thisRDSfilePath, " doesn't exist, skipping"));
    }
  }
  output;
}


findTermsNgrams0.5 <- function (myterm) {
  myterm <- paste0(gsub(" ","_",myterm));
  message(paste("myterm:",myterm));
  
  if (exists("n1_s0.5")) {
    xx <- n1_s0.5$vocab[startsWith(n1_s0.5$vocab$terms,myterm),1:2];
    xx <- xx[1:5,];
    xx$ngram <- "n1";
    if (exists("output")) {
      output <- rbind(xx,output);
    } else {
      output <- xx;
    }
  }
  if (exists("n2_s0.5")) {
    xx <- n2_s0.5$vocab[startsWith(n2_s0.5$vocab$terms,myterm),1:2];
    xx <- xx[1:5,];
    xx$ngram <- "n2";
    if (exists("output")) {
      output <- rbind(xx,output);
    } else {
      output <- xx;
    }
  }
  
  
  output;
}

findTermsNgrams0.5a <- function (myterm) {
  myterm <- paste0(gsub(" ","_",myterm));
  message(paste("myterm:",myterm));
  
  thisNgram <- paste0('n',1,'_s',0.5);
  message(thisNgram);
#  assign(aa,thisNgram);
  aa <- copyObj(thisNgram);
  class(aa);
  length(aa)
  if (exists("aa")) {
#    xx <- aa[["vocab"]][startsWith(aa[["vocab"]][["terms"]],myterm),1:2];
    xx <- aa["vocab"]["terms"];
#    xx <- xx[1:5,];
    xx$ngram <- "n1";
    if (exists("output")) {
      output <- rbind(xx,output);
    } else {
      output <- xx;
    }
  }

  thisNgram <- paste0('n',2,'_s',0.5);
  message(thisNgram);
  
  aa <- copyObj(thisNgram);
  if (exists("aa")) {
    #    xx <- aa[["vocab"]][startsWith(aa[["vocab"]][["terms"]],myterm),1:2];
    xx <- aa[["vocab"]][["terms"]];
    #    xx <- xx[1:5,];
    xx$ngram <- "n2";
    if (exists("output")) {
      output <- rbind(xx,output);
    } else {
      output <- xx;
    }
  }
  
  
  output;
}

copyObj <- function(thisObj) {
#xx <- deparse(substitute(thisObj));
  thisObj;
}


findTermsNgramsOLD <- function (myterm,searchhere) {
  ss <- deparse(substitute(searchhere));
  xx <- ngram3["vocab"][startsWith(ngram3["vocab"]["terms"],paste0(gsub(" ","_",myterm),"_"))]
  xx;
}