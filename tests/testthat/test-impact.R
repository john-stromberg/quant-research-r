test_that("impact includes net difference", {
  cw <- load_current_weights("data_raw/current_weights.csv")
  tw <- load_target_weights("data_raw/target_weights.csv")
  r <- load_asset_returns("data_raw/asset_returns.csv")
  d <- compute_weight_drift(cw, tw)
  cst <- estimate_rebalance_cost(d, 2, 8, 1.25)
  out <- compute_net_impact(r, cw, tw, cst)
  expect_true("net_difference" %in% names(out))
})
