test_that("factor signals include momentum/value/quality", {
  x <- load_security_panel("data_raw/security_panel.csv")
  out <- build_factor_signals(x)
  expect_true(all(c("momentum_3m", "value", "quality") %in% names(out)))
})
