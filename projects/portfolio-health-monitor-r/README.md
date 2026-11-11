# portfolio-health-monitor-r

R project for portfolio monitoring, attribution, and alerting using a FRED + CSV data workflow.

## Analytical question

How is portfolio risk/return evolving over time, what is driving active performance, and when should alerts trigger review actions?

## Scope (v1)

- Monitoring: returns, volatility, drawdown, rolling Sharpe
- Attribution: allocation vs selection effect summary
- Alerts: threshold-based flags for drawdown, volatility spike, and tracking-error drift
- Data blend: FRED macro series + CSV portfolio/benchmark holdings and returns

## Repo structure

- `R/` modular functions
- `config/config.yml` thresholds and runtime settings
- `data_raw/` CSV inputs
- `data_processed/` transformed outputs
- `reports/` Quarto report
- `tests/testthat/` tests
- `_targets.R` pipeline orchestration

## Quickstart

1. Install packages:
   - `targets`, `tidyverse`, `lubridate`, `readr`, `tidyquant`, `PerformanceAnalytics`, `xts`, `yardstick`, `yaml`, `quarto`, `testthat`, `fredr`
2. Configure FRED API key in environment:
   - `Sys.setenv(FRED_API_KEY = "your_key")`
3. Run pipeline:
   - `targets::tar_make()`
4. Run tests:
   - `source("tests/testthat.R")`
5. Render report:
   - `quarto::quarto_render("reports/portfolio_health_report.qmd")`

## Decision memo template

- **Question:** What changed in portfolio health and active performance?
- **Evidence:** Monitoring dashboard tables + attribution summary + alerts log.
- **Interpretation:** Identify principal risk/performance drivers.
- **Action:** Rebalance, hedge, de-risk, or maintain stance.
