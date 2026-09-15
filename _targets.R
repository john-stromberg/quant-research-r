library(targets)
tar_option_set(packages = c("tidyverse", "lubridate", "fredr", "yaml"))

source("R/ingest.R")
source("R/fred_data.R")
source("R/drift.R")
source("R/costs.R")
source("R/impact.R")
source("R/utils.R")

cfg <- yaml::read_yaml("config/config.yml")

targets::tar_pipeline(
  tar_target(current_w, load_current_weights(cfg$data$weights_csv)),
  tar_target(target_w, load_target_weights(cfg$data$targets_csv)),
  tar_target(returns_df, load_asset_returns(cfg$data$returns_csv)),
  tar_target(rates_ctx, load_macro_rates(cfg$data$fred_series$rates_proxy)),
  tar_target(drift_tbl, compute_weight_drift(current_w, target_w)),
  tar_target(rebalance_flag, rebalance_required(drift_tbl, cfg$rebalance$drift_threshold)),
  tar_target(cost_tbl, estimate_rebalance_cost(drift_tbl, cfg$costs$fixed_cost_bps, cfg$costs$proportional_cost_bps, cfg$costs$slippage_multiplier)),
  tar_target(impact_tbl, compute_net_impact(returns_df, current_w, target_w, cost_tbl)),
  tar_target(save_drift, write_output(drift_tbl, "data_processed/drift_table.csv"), format = "file"),
  tar_target(save_cost, write_output(cost_tbl, "data_processed/cost_table.csv"), format = "file"),
  tar_target(save_impact, write_output(impact_tbl, "data_processed/impact_table.csv"), format = "file")
)
