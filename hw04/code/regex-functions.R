#' @title Split characters
#' @description takes a character string, and splits the content intoone single character elements
#' @param string String 
#' @return the string split up
split_chars <- function(string) {
  strsplit(string, split = c())[[1]]
}

#' @title number of vowels
#' @description returns the number of vowels in a character vector
#' @param vec vector in which each element is a single character
#' @return character vector
num_vowels <- function(vec) {
  vec <- table(vec)
  vowels <- c('a','e','i','o','u')
  vec <- vec[vowels]
  vec[is.na(vec)] = 0
  names(vec) = vowels
  vec
}

#' @title count vowels
#' @description computes the number of vowels of a character string
#' @param string String
#' @return character vector
count_vowels <- function(string) {
  num_vowels(split_chars(tolower(string)))
}



#' @title reverse character
#' @description reverses a string by characters
#' @param string String
#' @return character vector
reverse_chars <- function(string) {
  paste0(rev(split_chars(string)), collapse = '')
}

#' @title reverse words
#' @description everses a string (i.e. a sentence) by words
#' @param string String
#' @return string
reverse_words <- function(string) {
  paste0(rev(str_split(string, " ")[[1]]), collapse = ' ')
}

