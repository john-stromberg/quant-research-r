test_that("alerts table has alert flag", {
  m <- load_manager_returns("data_raw/manager_returns.csv")
  b <- load_benchmark_returns("data_raw/benchmark_returns.csv")
  a <- compute_active_returns(m, b)

  out <- flag_underperformance(a, threshold = -0.01, persistence_periods = 2)
  expect_true(all(c("manager", "latest_underperf_streak", "alert") %in% names(out)))
})
