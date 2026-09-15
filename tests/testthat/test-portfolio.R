test_that("long-short returns are computed", {
  x <- load_security_panel("data_raw/security_panel.csv")
  s <- build_factor_signals(x)
  q <- rank_and_form_quantiles(s, n_quantiles = 5, signal_col = "momentum_3m")
  ls <- compute_long_short_returns(q, top_q = 5, bottom_q = 1)
  expect_true("long_short_ret" %in% names(ls))
})
