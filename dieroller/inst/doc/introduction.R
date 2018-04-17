## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(collapse = T)
library(dieroller)

## ------------------------------------------------------------------------
fair_die <- die()
fair_die

## ------------------------------------------------------------------------
# die with non-standard sides
weird_die <- die(sides = c('i', 'ii', 'iii', 'iv', 'v', 'vi'))
weird_die

# create a loaded die
loaded_die <- die(prob = c(0.075, 0.1, 0.125, 0.15, 0.20, 0.35))
loaded_die

## ------------------------------------------------------------------------
# roll 50 times
fair_50 <- roll(fair_die, times = 50)
fair_50

## ------------------------------------------------------------------------
summary(fair_50)

## ---- fig.show='hold'----------------------------------------------------
plot(fair_50)

