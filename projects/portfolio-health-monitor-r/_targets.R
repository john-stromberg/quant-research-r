library(targets)
tar_option_set(packages = c(
  "tidyverse", "lubridate", "readr", "fredr", "PerformanceAnalytics", "zoo", "yaml"
))

source("R/ingest.R")
source("R/fred_data.R")
source("R/monitoring.R")
source("R/attribution.R")
source("R/alerts.R")
source("R/utils.R")

cfg <- yaml::read_yaml("config/config.yml")

targets::tar_pipeline(
  tar_target(portfolio_returns, load_return_series(cfg$data$portfolio_returns_csv, "date", "portfolio_return")),
  tar_target(benchmark_returns, load_return_series(cfg$data$benchmark_returns_csv, "date", "benchmark_return")),
  tar_target(holdings, load_holdings(cfg$data$holdings_csv)),
  tar_target(fred_macro, load_fred_series(cfg$data$fred_series)),
  tar_target(monitoring_table, compute_monitoring_metrics(portfolio_returns, benchmark_returns, cfg$monitoring$rolling_window_days)),
  tar_target(attribution_table, compute_brinson_like_attribution(holdings)),
  tar_target(alerts_table, generate_alerts(monitoring_table, cfg$alerts)),
  tar_target(save_monitoring, write_output(monitoring_table, "data_processed/monitoring_table.csv"), format = "file"),
  tar_target(save_attribution, write_output(attribution_table, "data_processed/attribution_table.csv"), format = "file"),
  tar_target(save_alerts, write_output(alerts_table, "data_processed/alerts_table.csv"), format = "file")
)
