Capstone Project - Text Prediction
========================================================
author: Gene Kaufman
date: December 30, 2016

Goal
========================================================

The Data Sciences Capstone Project is to develop a Shiny application that will predict the next word for a user-submitted phrase.

As they say, the devil is in the details...

In the course of this project, I developed (well, implemented...) multiple prediction algorithms. Two of them are presented in my Shiny application.

How to use Shiny app
========================================================

My application is very easy to use - simply enter a phrase into the text box, and hit the PREDICT! button. The results will show on the right side.

After submission, the search phrase is "chopped" down (terms removed from the left) to a specific size first. There is also some cleaning and standardization of the phrase as well (i.e. remove numbers, convert to lower case, etc). The largest ngram I've implemented is a 10-gram. Therefore, any phrase with more than 9 words gets reduced to only the 9 right-most words.

There are then 2 algorithms that work on the new search phrase...

Algorithm - Stupid Back Off
========================================================

The first predicted word comes from my implementation of the Stupid Back Off algorithm.

 If any term in the 10-gram starts with the 9 word phrase, then the remaining word in the ngram term is pulled out and the algorithm stops. If there are multiple terms that start with the shortened search phrase, then the term with the largest frequency count is used.

If there are no terms in the 10-gram that start with the 9 word search phrase, then the left-most word is removed from the search phrase, and the new phrase is searched for in the 9-gram.

This process is repeated until either a term is found or until the search phrase is just a single word.

Algorithm - Hybrid Back Off
========================================================

The second predicted word comes from an algorithm that I created utilizing principles of other Back Off methods.

Similar to the Stupid Back Off algorithm, the search phrase is chopped down from the left and searched in increasingly smaller ngrams. However, the process only stops when the search phrase is down to a single word (i.e. using a bigram).

At each ngram, any terms found that start with the search phrase are given a weight of Frequency (%) * n-gram * 100 . (So that the larger the ngram, the more weight is given). The right-most word in the ngram term is assigned this weight, and at the end of the process, the weights are summed (for all ngrams) for the right-most word, and the biggest weight is the new predicted word.
