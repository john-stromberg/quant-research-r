test_that("attribution output has total effect", {
  h <- load_holdings("data_raw/holdings.csv")
  out <- compute_brinson_like_attribution(h)

  expect_true("total_effect" %in% names(out))
  expect_equal(nrow(out), nrow(h))
})
