library(targets)
tar_option_set(packages = c("tidyverse", "lubridate", "fredr", "yaml"))

source("R/ingest.R")
source("R/fred_data.R")
source("R/attribution.R")
source("R/scorecard.R")
source("R/alerts.R")
source("R/utils.R")

cfg <- yaml::read_yaml("config/config.yml")

targets::tar_pipeline(
  tar_target(manager_returns, load_manager_returns(cfg$data$manager_returns_csv)),
  tar_target(benchmark_returns, load_benchmark_returns(cfg$data$benchmark_returns_csv)),
  tar_target(sector_weights, load_sector_weights(cfg$data$sector_weights_csv)),
  tar_target(macro_context, load_macro_context(cfg$data$fred_series$rates_proxy)),
  tar_target(active_returns, compute_active_returns(manager_returns, benchmark_returns)),
  tar_target(brinson_effects, compute_brinson_effects(sector_weights)),
  tar_target(scorecard, build_manager_scorecard(active_returns, brinson_effects)),
  tar_target(alerts, flag_underperformance(active_returns, cfg$alerts$underperformance_threshold, cfg$alerts$persistence_periods)),
  tar_target(save_scorecard, write_output(scorecard, "data_processed/manager_scorecard.csv"), format = "file"),
  tar_target(save_alerts, write_output(alerts, "data_processed/manager_alerts.csv"), format = "file")
)
