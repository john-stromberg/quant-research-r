# forecasting-nowcasting-lab-r

An econometric forecasting/nowcasting laboratory implemented in R, designed for reproducible empirical workflows, transparent model diagnostics, and research-grade documentation.

## 1. Research Motivation and Scope

This repository provides a compact but extensible framework for time-adjacent prediction tasks (forecasting and nowcasting) under a reproducible computational design. The objective is to support iterative empirical research where each stage—configuration, data ingestion, validation, feature construction, model fitting, and evaluation—can be audited and reproduced.

The current baseline uses a polynomial linear specification:

\[
y_t = \beta_0 + \beta_1 x_t + \beta_2 x_t^2 + \epsilon_t
\]

with deterministic preprocessing and explicit metric reporting (RMSE, MAE, and \(R^2\)).

## 2. Repository Architecture

```text
forecasting-nowcasting-lab-r/
├── _targets.R                    # Reproducible pipeline definition
├── R/
│   └── core.R                    # Core analytics functions
├── config/
│   └── config.yml                # Runtime configuration (input paths)
├── data_raw/
│   └── sample.csv                # Example input data
├── reports/
│   └── report.qmd                # Report template
├── tests/
│   ├── testthat.R                # Test runner entrypoint
│   └── testthat/
│       └── test-core.R           # Unit tests for core logic
└── notebooks/                    # Academic notebooks (.qmd and .Rmd)
```

## 3. Methodological Design

### 3.1 Configuration Contract

Configuration is loaded from `config/config.yml` via `load_config()`. The required field is:

```yaml
data:
  input_csv: data_raw/sample.csv
```

The contract is validated early to reduce silent failures downstream.

### 3.2 Input Validation Strategy

`validate_input_data()` enforces:

1. Required columns exist (`x`, `y` by default).
2. Minimum sample size (`n >= 2`).
3. Numeric typing for required columns.
4. Absence of missing values in required columns.

These checks make model behavior explicit and improve reproducibility across machines.

### 3.3 Feature Engineering

`prepare_features()` currently augments data with:

- `x_sq = x^2`

This produces a minimal nonlinear baseline while preserving interpretability.

### 3.4 Model Estimation

`fit_baseline_model()` fits OLS using `lm(y ~ x + x_sq)`.

The model is intentionally simple for pedagogical clarity and can be replaced by richer specifications (distributed lag models, regularized regressions, mixed-frequency designs, etc.) without changing the orchestration pattern.

### 3.5 Predictive Evaluation

`compute_metrics()` returns:

- `rows`: number of evaluated rows
- `rmse`: root mean squared error
- `mae`: mean absolute error
- `r_squared`: squared correlation between observed and predicted values

## 4. Reproducibility and Pipeline Orchestration

The project uses `targets` for declarative pipeline execution. Current targets include configuration, raw data, validated data, engineered features, model object, predictions, and metrics.

To improve environment robustness, the `report` target checks whether Quarto CLI is installed:

- If Quarto is available: renders HTML report.
- If Quarto is unavailable: returns sentinel value (`"quarto-not-installed"`) and allows the computational pipeline to complete.

This design separates analytic reproducibility from optional reporting dependencies.

## 5. Testing Philosophy

`testthat` coverage in `tests/testthat/test-core.R` includes:

- Schema validation failure behavior
- Missing-value and sample-size guards
- Model/prediction/metric artifact checks
- End-to-end pipeline execution from a temporary config file

The test suite prioritizes deterministic functional guarantees over snapshot-heavy outputs.

## 6. Environment Setup

### 6.1 Required R Packages

- `targets`
- `tidyverse`
- `lubridate`
- `yaml`
- `quarto`
- `testthat`

Install:

```r
install.packages(c("targets", "tidyverse", "lubridate", "yaml", "quarto", "testthat"))
```

### 6.2 Quarto CLI (Optional but Recommended)

R package `quarto` and Quarto CLI are distinct requirements for report rendering. If report target rendering fails, install Quarto CLI and ensure it is on `PATH`.

## 7. Execution Guide

### 7.1 Run the full targets pipeline

```r
targets::tar_make()
```

### 7.2 Inspect target outputs

```r
targets::tar_read(metrics)
targets::tar_read(predictions)
```

### 7.3 Run the test suite

```r
source("tests/testthat.R")
```

### 7.4 Render report directly (optional)

```r
quarto::quarto_render("reports/report.qmd")
```

## 8. Academic Interpretation Guidance

When using this framework in empirical work, interpret model outputs with explicit caveats:

- The baseline polynomial specification is a structural simplification.
- Fit metrics are in-sample unless a holdout or CV design is added.
- Causal interpretation is not implied by predictive association.
- Robustness should include alternative functional forms, outlier sensitivity, and temporal validation.

## 9. Extension Roadmap

Recommended next research-grade extensions:

1. Add train/validation/test temporal splits.
2. Add rolling-origin backtesting.
3. Add model comparison targets (OLS vs regularized vs tree-based).
4. Add diagnostics target (residual plots, heteroskedasticity checks, influence metrics).
5. Add CI workflow to run tests on push/PR.

## 10. Citation and Reuse

If this repository supports academic output, include:

- model version/date
- commit hash used for analysis
- package versions (`sessionInfo()`)
- any modifications to config or preprocessing

This preserves computational provenance and facilitates independent replication.

