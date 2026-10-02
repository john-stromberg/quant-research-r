test_that('validate_input_data enforces required schema', {
  good <- tibble::tibble(x = c(1, 2), y = c(2, 4))
  out <- validate_input_data(good)
  expect_s3_class(out, 'tbl_df')

  bad_cols <- tibble::tibble(a = c(1, 2), y = c(2, 4))
  expect_error(validate_input_data(bad_cols), 'Missing required columns')
})

test_that('validate_input_data rejects invalid values', {
  with_na <- tibble::tibble(x = c(1, NA), y = c(2, 4))
  expect_error(validate_input_data(with_na), 'contains NA values')

  one_row <- tibble::tibble(x = 1, y = 2)
  expect_error(validate_input_data(one_row), 'at least 2 rows')
})

test_that('model workflow returns predictions and metrics', {
  df <- tibble::tibble(x = c(1, 2, 3, 4), y = c(2, 5, 10, 17))
  features <- prepare_features(df)
  model <- fit_baseline_model(features)
  preds <- generate_predictions(model, features)
  metrics <- compute_metrics(preds)

  expect_true('prediction' %in% names(preds))
  expect_equal(nrow(preds), nrow(df))
  expect_true(all(c('rows', 'rmse', 'mae', 'r_squared') %in% names(metrics)))
})

test_that('run_nowcast_pipeline executes end-to-end from config', {
  tmp_dir <- tempdir()
  data_path <- file.path(tmp_dir, 'sample.csv')
  cfg_path <- file.path(tmp_dir, 'config.yml')

  readr::write_csv(tibble::tibble(x = c(1, 2, 3), y = c(2, 5, 10)), data_path)
	data_path_yaml <- normalizePath(data_path, winslash = "/", mustWork = FALSE)
  writeLines(sprintf('data:\n  input_csv: "%s"', data_path_yaml), cfg_path)

  out <- run_nowcast_pipeline(cfg_path)
  expect_true(is.list(out))
  expect_true(all(c('data', 'features', 'model', 'predictions', 'metrics') %in% names(out)))
})

