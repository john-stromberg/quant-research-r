test_that("cost table includes total cost", {
  cw <- load_current_weights("data_raw/current_weights.csv")
  tw <- load_target_weights("data_raw/target_weights.csv")
  d <- compute_weight_drift(cw, tw)
  out <- estimate_rebalance_cost(d, 2, 8, 1.25)
  expect_true("total_cost" %in% names(out))
  expect_gt(out$total_cost[[1]], 0)
})
