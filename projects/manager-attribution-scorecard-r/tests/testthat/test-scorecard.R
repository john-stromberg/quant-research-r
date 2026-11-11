test_that("scorecard includes manager metrics", {
  m <- load_manager_returns(testthat::test_path("..", "..", "data_raw", "manager_returns.csv"))
  b <- load_benchmark_returns(testthat::test_path("..", "..", "data_raw", "benchmark_returns.csv"))
  s <- load_sector_weights(testthat::test_path("..", "..", "data_raw", "sector_weights.csv"))

  a <- compute_active_returns(m, b)
  br <- compute_brinson_effects(s)
  out <- build_manager_scorecard(a, br)

  expect_true(all(c("manager", "cum_active", "alloc_total", "select_total") %in% names(out)))
})
