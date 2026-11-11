test_that("drift table includes abs drift", {
  cw <- load_current_weights(testthat::test_path("..", "..", "data_raw", "current_weights.csv"))
  tw <- load_target_weights(testthat::test_path("..", "..", "data_raw", "target_weights.csv"))
  out <- compute_weight_drift(cw, tw)
  expect_true(all(c("drift", "abs_drift") %in% names(out)))
})
