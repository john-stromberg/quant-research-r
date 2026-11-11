test_that("monitoring metrics include expected columns", {
  p <- load_return_series(testthat::test_path("..", "..", "data_raw", "portfolio_returns.csv"), "date", "portfolio_return")
  b <- load_return_series(testthat::test_path("..", "..", "data_raw", "benchmark_returns.csv"), "date", "benchmark_return")
  out <- compute_monitoring_metrics(p, b, rolling_window = 5)

  expect_true(all(c("date", "portfolio_return", "benchmark_return", "active_return", "drawdown", "rolling_vol", "rolling_sharpe", "rolling_te") %in% names(out)))
})
