library(readr)
library(dplyr)
library(lubridate)

load_security_panel <- function(path) {
  read_csv(path, show_col_types = FALSE) %>%
	mutate(date = as_date(date)) %>%
	arrange(date, ticker)
}
