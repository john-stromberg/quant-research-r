test_that("validate_time_series accepts sample data", {
  df <- load_raw_data(testthat::test_path("..", "..", "data_raw", "sample_series.csv"), "date", "value")
  expect_invisible(validate_time_series(df))
})
