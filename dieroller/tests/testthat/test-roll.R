context("Check roll arguments and functionality")

test_that("check_times with ok numbers", {

  expect_true(check_times(5))
  expect_true(check_times(6.0))
})


test_that("check_times fails with non-positive numbers", {

  expect_error(check_times(-6))
  expect_error(check_times(-7))
  expect_error(check_times(0))

})


test_that("check_times fails with invalid types", {

  expect_error(check_times(4.2))
  expect_error(check_times(c(1,2)))
})

test_that("indexing works with valid indices", {
  set.seed(123)
  fair_die <- die()
  fair500 <- roll(fair_die, times = 500)

  expect_true(fair500[1] == 3)
  expect_true(fair500[2] == 6)
  expect_true(fair500[3] == 4)
  expect_true(fair500[500] == 6)

})


test_that("replace works with valid replacements", {
  set.seed(123)
  fair_die <- die()
  fair500 <- roll(fair_die, times = 500)
  fair500[1] <- 4
  fair500[2] <- 5
  fair500[3] <- 6

  expect_true(fair500[1] == 4)
  expect_true(fair500[2] == 5)
  expect_true(fair500[3] == 6)

})

test_that("replace fails with invalid replacements or indices", {
  set.seed(123)
  fair_die <- die()
  fair500 <- roll(fair_die, times = 500)

  expect_error((fair500[600] = 4))
  expect_error((fair500[1] = 7))
  expect_error((fair500[40] = 0))

})

test_that("add fails with invalid arguments", {
  set.seed(123)
  fair_die <- die()
  fair500 <- roll(fair_die, times = 500)

  expect_error(fair500 - 3)
  expect_error(fair500 + 0)
  expect_error(fair500 + c(1,2,3))

})

test_that("add works with valid arguments", {
  set.seed(123)
  fair_die <- die()
  fair500 <- roll(fair_die, times = 500)
  fair500 = fair500 + 100

  expect_true(fair500[600] == 2)
  expect_true(fair500[599] == 1)
  expect_true(fair500[598] == 4)

})
