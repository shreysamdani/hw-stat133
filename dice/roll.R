#' @title Roll a coin
#' @description Creates an object of class "roll"
#' @param die object of class "coin"
#' @param times number of rolls
#' @return an object of class "toss" with the following elements:
#' @return \item{rolls}{vector of rolls}
#' @return \item{sides}{vector of die "sides"}
#' @return \item{prob}{vector of die "prob"}
#' @return \item{total}{total number of rolls}
roll <- function(die, times = 1) {
  check_times(times)
  rolls <- sample(die$sides, size = times, replace = TRUE, prob = die$prob)
  create_roll(die$sides, die$prob , rolls)
}

check_times <- function(times) {
  if (times <= 0 | !is.numeric(times)) {
    stop("\nargument 'times' must be a positive integer")
  } else {
    TRUE
  }
}

create_roll <- function(sides, prob, rolls) {
  obj <- list(
    rolls = rolls,
    sides = sides,
    prob = prob,
    total = length(rolls)
  )
  class(obj) <- "roll"
  obj
  
}

print.roll <- function(x, ...) {
  cat('object "roll"\n\n')
  print(x$rolls)
}


# Summary
summary.roll <- function(x, ...) {
  counts <- c(unname(table(x$rolls)))
  
  frqs <- data.frame(
    side = x$sides,
    count = counts,
    prop = counts/x$total)
  obj <- list(freqs = frqs)
  class(obj) <- "summary.roll"
  obj
}


print.summary.roll <- function(x, ...) {
  cat('summary "roll"\n\n')
  print(x$freqs)
  invisible(x)
}

# Plot
plot.roll <- function(x, ...) {
  barplot(table(x$rolls)/length(x$rolls),
          xlab = "sides of die",
          ylab = "relative frequencies",
          main = paste0("Frequencies in a series of ",
                        x$total,
                        " die rolls"))
}


# replace
"[<-.roll" <- function(x, i, value) {
  if (!is.element(value, x$sides)) {
    stop(paste0('\nreplacing value must be in ', x$sides))
  }
  if (i > length(x$rolls)) {
    stop("\nindex out of bounds")
  }
  x$rolls[i] <- value
  create_roll(x$sides, x$prob , x$rolls)
  
}

# extract
"[.roll" <- function(x, i) {
  x$rolls[i]
}


# add
"+.roll" <- function(x, incr) {
  if (length(incr) != 1 | incr <= 0) {
    stop("\ninvalid increament")
  }
  extra_rolls <- sample(x$sides, size = incr, replace = TRUE, prob = x$prob)
  create_roll(x$sides, x$prob, c(x$rolls, extra_rolls))
}