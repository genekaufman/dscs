source('load_data_filesV3.R')

baseDataDir <- "data/en_US/";
samp_perc <- 0.01;
samp_perc <- 333;
samp_perc <- 0.20;
set.seed(42);

if (!exists("betterMessage")) {
  betterMessage <- function(strIn) {
    message(paste0('[',date(),'] ',strIn));

  }
}

if (!exists("data_combined_samp")) {
  data_combined_samp_filebase <- paste0("data_combined_samp_",samp_perc);

  data_combined_samp_RDSfile <- paste0(baseDataDir, data_combined_samp_filebase, ".Rds");
  if (file.exists(data_combined_samp_RDSfile)) {
    betterMessage(paste(data_combined_samp_RDSfile, " exists, loading"));
    data_combined_samp <- readRDS(data_combined_samp_RDSfile)
  } else {
    betterMessage(paste(data_combined_samp_RDSfile, " doesn't exist, creating"));
    num_rows <- length(data_combined_full);

    if (samp_perc > 1) {
      num_samples <- samp_perc;
    } else {
      num_samples <- round(num_rows * samp_perc);
    }

    data_combined_samp <- data_combined_full[sample(1:num_rows, num_samples, replace=FALSE)];

    saveRDS(data_combined_samp,file=data_combined_samp_RDSfile);
  }
}
betterMessage("### Data sampled!");



rm(list=ls(pattern='RDSfile'));
rm(list=ls(pattern='full'));
rm(baseDataDir);
if (exists("data_combined_samp_filebase")) {rm(data_combined_samp_filebase);}
if (exists("num_rows")) {rm(num_rows);}
if (exists("num_samples")) {rm(num_samples);}
#if (exists("samp_perc")) {rm(samp_perc);}



