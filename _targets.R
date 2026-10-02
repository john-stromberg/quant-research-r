library(targets)
tar_option_set(packages = c('tidyverse','lubridate','yaml'))
source('R/core.R')
list(
	tar_target(config, load_config('config/config.yml')),
  tar_target(raw_data, load_input_data(config)),
  tar_target(valid_data, validate_input_data(raw_data)),
  tar_target(features, prepare_features(valid_data)),
  tar_target(model, fit_baseline_model(features)),
  tar_target(predictions, generate_predictions(model, features)),
  tar_target(metrics, compute_metrics(predictions)),
	tar_target(report, {
	has_quarto <- nzchar(Sys.which('quarto')) || nzchar(Sys.getenv('QUARTO_PATH'))
	if (has_quarto) {
	  quarto::quarto_render(input = 'reports/report.qmd', quiet = TRUE)
	  'reports/report.html'
	} else {
	  'quarto-not-installed'
	}
  })
)

