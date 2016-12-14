
findTerms <- function(myterm,searchhere) {
  xx <- searchhere[startsWith(names(searchhere),paste0(gsub(" ","_",myterm),"_"))];
  xx;

}

findTermsNgrams <- function (myterm,searchhere) {
  ss <- deparse(substitute(searchhere));
  xx <- ngram3["vocab"][startsWith(ngram3["vocab"]["terms"],paste0(gsub(" ","_",myterm),"_"))]
  xx;
}