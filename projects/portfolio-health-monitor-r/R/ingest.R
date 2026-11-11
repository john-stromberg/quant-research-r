library(readr)
library(dplyr)
library(lubridate)

load_return_series <- function(path, date_col, value_col) {
  read_csv(path, show_col_types = FALSE) %>%
	transmute(
	  date = as_date(.data[[date_col]]),
	  value = as.numeric(.data[[value_col]])
	) %>%
	arrange(date)
}

load_holdings <- function(path) {
  read_csv(path, show_col_types = FALSE) %>%
	mutate(date = as_date(date))
}
