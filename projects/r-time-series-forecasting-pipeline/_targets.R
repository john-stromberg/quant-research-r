library(targets)
tar_option_set(packages = c(
  "tidyverse", "lubridate", "tsibble", "fable", "fabletools", "yardstick", "readr"
))

source("R/ingest.R")
source("R/validate.R")
source("R/features.R")
source("R/modeling.R")
source("R/backtest.R")
source("R/evaluate.R")
source("R/utils.R")

config <- yaml::read_yaml("config/config.yml")

targets::tar_pipeline(
  tar_target(raw_data, load_raw_data(config$data$input_path, config$data$date_col, config$data$value_col), format = "qs"),
  tar_target(validated_data, { validate_time_series(raw_data); raw_data }, format = "qs"),
  tar_target(processed_data, build_features(validated_data), format = "qs"),
  tar_target(fitted_models, fit_models(processed_data), format = "qs"),
  tar_target(point_forecast, make_forecast(fitted_models, h = config$model$horizon), format = "qs"),
  tar_target(backtest_fcst, rolling_backtest(processed_data, .init = config$backtest$initial_window, .step = config$backtest$step, h = config$backtest$h), format = "qs"),
  tar_target(accuracy_table, evaluate_accuracy(point_forecast, validated_data), format = "qs"),
  tar_target(report, {
	quarto::quarto_render(
	  input = "reports/forecast_report.qmd",
	  execute_params = list(output_path = "outputs"),
	  quiet = TRUE
	)
	"reports/forecast_report.html"
  }, format = "file")
)
