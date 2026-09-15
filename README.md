# factor-research-lab-r

R project for factor signal research, ranking, portfolio formation, and validation with analytics, report, and tests.

## Analytical question

Which cross-sectional factors show consistent predictive power after simple robustness checks, and how stable are long-short returns over time?

## Recommended data approach

- **FRED + CSV blend**
  - FRED: macro controls/regime context
  - CSV: security-level monthly panel with prices, fundamentals, and returns

## Scope (v1)

- Factor construction (value, momentum, quality)
- Cross-sectional ranking and quantile portfolio formation
- Long-short factor return series
- IC and summary diagnostics
- Quarto report and test coverage

## Quickstart

1. Install packages: `targets`, `tidyverse`, `lubridate`, `slider`, `zoo`, `fredr`, `broom`, `yardstick`, `yaml`, `quarto`, `testthat`
2. Set API key: `Sys.setenv(FRED_API_KEY = "your_key")`
3. Run pipeline: `targets::tar_make()`
4. Run tests: `source("tests/testthat.R")`
5. Render report: `quarto::quarto_render("reports/factor_research_report.qmd")`
