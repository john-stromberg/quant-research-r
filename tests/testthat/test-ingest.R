test_that("load_raw_data returns ds/y schema", {
  df <- load_raw_data("data_raw/sample_series.csv", "date", "value")
  expect_true(all(c("ds", "y") %in% names(df)))
  expect_gt(nrow(df), 10)
})
