# r-time-series-forecasting-pipeline

Intermediate R project that demonstrates an end-to-end forecasting workflow with reproducible pipeline orchestration and analytical communication.

## Repo structure

- `data_raw/` input data
- `data_processed/` transformed datasets
- `R/` modular pipeline functions
- `_targets.R` orchestration DAG
- `config/config.yml` runtime settings
- `reports/forecast_report.qmd` decision-oriented report
- `tests/testthat/` validation tests
- `tests/testthat.R` test runner

## Quickstart

1. Install packages:
   - `targets`, `tidyverse`, `lubridate`, `tsibble`, `fable`, `fabletools`, `forecast`, `yardstick`, `yaml`, `quarto`, `testthat`
2. Run pipeline:
   - `targets::tar_make()`
3. Run tests:
   - `source("tests/testthat.R")`
4. Render report:
   - `quarto::quarto_render("reports/forecast_report.qmd")`

## Analytical framing

- **Question:** Which model best forecasts the next horizon under rolling validation?
- **Method:** Compare ETS, ARIMA, and SNAIVE with reproducible pipeline steps.
- **Evidence:** Accuracy table and forecast diagnostics.
- **Action:** Promote the most stable, lowest-error model and monitor drift.
