#' @title Die
#' @description Creates an object of class "die"
#' @param sides vector of die sides
#' @param prob vector of side probabilities
#' @return an object of class "die"
#' @export
die <- function(sides = c(1,2,3,4,5,6), prob = rep(1/6,6)) {
  check_sides(sides)
  check_prob(prob)

  obj <- list(
    sides = sides,
    prob = prob)
  class(obj) <- "die"

  obj

}

check_sides <- function(sides) {
  if (length(sides) != 6) {
    stop("\n'prob' must be a vector of length 6")
  }
  if (!is.numeric(sides) & !is.character(sides)) {
    stop("\n'sides' must be a character or numeric vector")
  }
  TRUE
}

check_prob <- function(prob) {
  if (length(prob) != 6 | !is.numeric(prob)) {
    stop("\n'prob' must be a numeric vector of length 6")
  }
  if (any(is.na(prob))) {
    stop("\n'prob' cannot contain missing values")
  }
  if (any(prob < 0) | any(prob > 1)) {
    stop("\n'prob' values must be between 0 and 1")
  }
  if (sum(prob) != 1) {
    stop("\nelements in 'prob' must add up to 1")
  }
  TRUE
}

#' @export
print.die <- function(x, ...) {
  cat('object "die"\n\n')
  print(data.frame(
    side = x$sides,
    prob = x$prob
  ))
  invisible(x)
}

