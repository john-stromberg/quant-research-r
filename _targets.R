library(targets)
tar_option_set(packages = c("tidyverse", "lubridate", "fredr", "yaml"))

source("R/ingest.R")
source("R/fred_data.R")
source("R/factors.R")
source("R/portfolio.R")
source("R/evaluate.R")
source("R/utils.R")

cfg <- yaml::read_yaml("config/config.yml")

targets::tar_pipeline(
  tar_target(panel_data, load_security_panel(cfg$data$panel_csv)),
  tar_target(macro_controls, load_macro_controls(cfg$data$fred_series)),
  tar_target(signals, build_factor_signals(panel_data)),
  tar_target(momentum_quantiles, rank_and_form_quantiles(signals, cfg$model$n_quantiles, "momentum_3m")),
  tar_target(momentum_ls, compute_long_short_returns(momentum_quantiles, cfg$model$n_quantiles, 1)),
  tar_target(momentum_ic, compute_ic(signals, "momentum_3m")),
  tar_target(factor_summary, summarize_factor_performance(momentum_ls, momentum_ic)),
  tar_target(save_ls, write_output(momentum_ls, "data_processed/momentum_long_short.csv"), format = "file"),
  tar_target(save_ic, write_output(momentum_ic, "data_processed/momentum_ic.csv"), format = "file"),
  tar_target(save_summary, write_output(factor_summary, "data_processed/factor_summary.csv"), format = "file")
)
