library(targets)
tar_option_set(packages = c('tidyverse','lubridate','yaml'))
source('R/core.R')
cfg <- yaml::read_yaml('config/config.yml')
targets::tar_pipeline(
  tar_target(example_data, readr::read_csv(cfg, show_col_types = FALSE)),
  tar_target(report, { quarto::quarto_render(input = 'reports/report.qmd', quiet = TRUE); 'reports/report.html' }, format = 'file')
)

