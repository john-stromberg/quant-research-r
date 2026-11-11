# manager-attribution-scorecard-r

R project for manager performance attribution and scorecard generation with analytics, report, and tests.

## Analytical question

Which managers are generating persistent alpha versus benchmark through allocation and selection decisions, and which require review?

## Recommended data approach

- **FRED + CSV blend**
  - FRED: macro context for period interpretation
  - CSV: manager-level returns, benchmark returns, and sector weights

## Scope (v1)

- Active return decomposition
- Brinson-style allocation/selection effects
- Multi-manager scorecard ranking
- Alert flags for underperformance persistence
- Quarto report and test coverage

## Quickstart

1. Install packages: `targets`, `tidyverse`, `lubridate`, `fredr`, `slider`, `zoo`, `yaml`, `quarto`, `testthat`
2. Set API key: `Sys.setenv(FRED_API_KEY = "your_key")`
3. Run pipeline: `targets::tar_make()`
4. Run tests: `source("tests/testthat.R")`
5. Render report: `quarto::quarto_render("reports/manager_scorecard_report.qmd")`
