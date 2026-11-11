# panel-data-models-r

Econometrics R module scaffold with analytics, report, and tests.

## Scope
- Topic-focused empirical workflow
- Reproducible pipeline via targets
- Report output via Quarto
- Test scaffolding via testthat

## Quickstart
1. Install packages: targets, tidyverse, lubridate, yaml, quarto, testthat
2. Run pipeline: targets::tar_make()
3. Run tests: source('tests/testthat.R')
4. Render report: quarto::quarto_render('reports/report.qmd')

