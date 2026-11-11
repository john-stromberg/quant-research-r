test_that("active returns include active_return column", {
  m <- load_manager_returns("data_raw/manager_returns.csv")
  b <- load_benchmark_returns("data_raw/benchmark_returns.csv")
  out <- compute_active_returns(m, b)
  expect_true("active_return" %in% names(out))
})
