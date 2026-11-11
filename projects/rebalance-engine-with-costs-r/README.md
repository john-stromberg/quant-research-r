# rebalance-engine-with-costs-r

R project for threshold-based rebalancing with transaction-cost-aware decisioning.

## Analytical question

When is rebalancing worth the cost, and how do turnover and slippage assumptions change net portfolio outcomes?

## Recommended data approach

- **FRED + CSV blend**
  - FRED: macro context for regime-aware thresholds
  - CSV: prices/returns, target weights, and cost assumptions

## Scope (v1)

- Drift calculation vs policy weights
- Threshold trigger logic
- Cost model (fixed + proportional + slippage proxy)
- Net-of-cost rebalance return impact
- Quarto report and test coverage

## Quickstart

1. Install packages: `targets`, `tidyverse`, `lubridate`, `fredr`, `slider`, `zoo`, `yaml`, `quarto`, `testthat`
2. Set API key: `Sys.setenv(FRED_API_KEY = "your_key")`
3. Run pipeline: `targets::tar_make()`
4. Run tests: `source("tests/testthat.R")`
5. Render report: `quarto::quarto_render("reports/rebalance_report.qmd")`
