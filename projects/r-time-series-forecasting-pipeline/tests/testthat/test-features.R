test_that("build_features returns tsibble", {
  df <- load_raw_data("data_raw/sample_series.csv", "date", "value")
  ts_data <- build_features(df)
  expect_true("tbl_ts" %in% class(ts_data))
})
