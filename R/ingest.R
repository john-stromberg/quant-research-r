library(readr)
library(dplyr)
library(lubridate)

load_current_weights <- function(path) {
  read_csv(path, show_col_types = FALSE) %>% mutate(date = as_date(date))
}

load_target_weights <- function(path) {
  read_csv(path, show_col_types = FALSE)
}

load_asset_returns <- function(path) {
  read_csv(path, show_col_types = FALSE) %>% mutate(date = as_date(date))
}
