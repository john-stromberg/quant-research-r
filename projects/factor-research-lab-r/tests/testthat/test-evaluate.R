test_that("summary includes IC and cumulative LS", {
  x <- tibble::tibble(
	date = as.Date(c("2024-01-31", "2024-02-29")),
	long_short_ret = c(0.01, -0.005)
  )
  y <- tibble::tibble(
	date = as.Date(c("2024-01-31", "2024-02-29")),
	ic = c(0.10, 0.05)
  )
  out <- summarize_factor_performance(x, y)
  expect_true(all(c("cum_ls", "mean_ic") %in% names(out)))
})
