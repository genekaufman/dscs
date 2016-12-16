if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}
baseDataDir <- "data/en_US/";

samp_perc <- 0.5;
MaxN_Files <- 10;


for(n in 1:MaxN_Files){
  thisRDS <- paste0("n", n,"_s",samp_perc);
  thisRDSfile <- paste0(thisRDS, ".Rds");
  thisRDSfilePath <- paste0(baseDataDir, thisRDSfile);
  betterMessage(paste('### Looking for: ', thisRDSfile));
  if (file.exists(thisRDSfilePath)) {
    betterMessage(paste(thisRDSfilePath, " exists, loading"));
    assign(thisRDS,readRDS(thisRDSfilePath));
  } else {
    betterMessage(paste(thisRDSfilePath, " doesn't exist, skipping"));
  }
}

betterMessage("## ngrams ready!");