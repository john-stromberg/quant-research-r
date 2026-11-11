test_that("alerts table has three rules", {
  p <- load_return_series("data_raw/portfolio_returns.csv", "date", "portfolio_return")
  b <- load_return_series("data_raw/benchmark_returns.csv", "date", "benchmark_return")
  m <- compute_monitoring_metrics(p, b, rolling_window = 5)

  thresholds <- list(
	max_drawdown_breach = -0.08,
	volatility_spike = 0.20,
	tracking_error_spike = 0.06
  )

  out <- generate_alerts(m, thresholds)
  expect_equal(nrow(out), 3)
  expect_true(all(c("rule", "breached", "value", "threshold") %in% names(out)))
})
