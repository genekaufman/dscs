
findTerms <- function(myterm,searchhere) {
  xx <- searchhere[startsWith(names(searchhere),paste0(gsub(" ","_",myterm),"_"))];
  xx;

}
