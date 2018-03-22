
#' @title is_integer
#' @description tests if value is an integer
#' @param x number to be tested
#' @return boolean describing if integer or not
is_integer <- function(x) {
  x %% 1 == 0
}


#' @title is_positive
#' @description tests if value is positive
#' @param x number to be tested
#' @return boolean describing if positive or not
is_positive <- function(x) {
  x > 0
}

#' @title is_nonnegative
#' @description tests if value is nonnegative
#' @param x number to be tested
#' @return boolean describing if nonnegative or not
is_nonnegative <- function(x) {
  x >= 0
}

#' @title is_positive_integer
#' @description tests if value is a positive integer
#' @param x number to be tested
#' @return boolean describing if positive integer or not
is_positive_integer <- function(x) {
  is_positive(x) && is_integer(x)
}

#' @title is_nonneg_integer
#' @description tests if value is a non-negative integer
#' @param x number to be tested
#' @return boolean describing if non-negative integer or not
is_nonneg_integer <- function(x) {
  is_nonnegative(x) && is_integer(x)
}


#' @title is_probability
#' @description tests if value is a probability
#' @param x number to be tested
#' @return boolean describing if probability or not
is_probability <- function(x) {
  x >= 0 && x <= 1
}

#' @title bin_factorial
#' @description calculates the factorial of a nonnegative integer n
#' @param n nonnegative integer
#' @return factorial of n
bin_factorial <- function(n) {
  ans <- 1
  if (n == 0) {
    return (ans)
  }
  for (i in 1:n) {
    ans = ans * i
  }
  return (ans)
}

#' @title bin_combinations
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of successes
#' @param k number of trials
#' @return answer
bin_combinations <- function(n, k) {
  bin_factorial(n)/(bin_factorial(k)*bin_factorial(n-k))
}

#' @title bin_probability
#' @description calculates the probability of getting sucess successes in trials trials
#' @param success number of successes
#' @param trials number of trials
#' @param prob probability of success
#' @return probabbility
bin_probability <- function(trials, success, prob) {
  if (!(is_nonneg_integer(trials)|is_nonneg_integer(success))) {
    stop("Either trials or success is not a non-negative integer")
  }
  if (!is_probability(prob)) {
    stop("prob is not a valid probability")
  }
  bin_combinations(trials, success)*(prob^success)*((1-prob)^(trials-success))
}

#' @title bin_distribution
#' @description creates a binomial probability distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return data frame with the probability distribution
bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- 0:trials
  for (i in probability) {
    probability[i + 1] = bin_probability(trials, i, prob)
  }
  data.frame(success, probability)
}

bin_distribution(trials = 5, prob = 0.5)

