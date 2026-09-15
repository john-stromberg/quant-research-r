test_that('placeholder analysis returns row count', {
  x <- tibble::tibble(a = 1:3)
  out <- run_placeholder_analysis(x)
  expect_equal(out[[1]], 3)
})

