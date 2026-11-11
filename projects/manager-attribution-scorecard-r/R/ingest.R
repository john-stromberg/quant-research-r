library(readr)
library(dplyr)
library(lubridate)

load_manager_returns <- function(path) {
  read_csv(path, show_col_types = FALSE) %>% mutate(date = as_date(date))
}

load_benchmark_returns <- function(path) {
  read_csv(path, show_col_types = FALSE) %>% mutate(date = as_date(date))
}

load_sector_weights <- function(path) {
  read_csv(path, show_col_types = FALSE) %>% mutate(date = as_date(date))
}
