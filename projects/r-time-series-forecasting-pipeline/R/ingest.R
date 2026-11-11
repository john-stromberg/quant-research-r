library(readr)
library(dplyr)
library(lubridate)

load_raw_data <- function(path, date_col, value_col) {
  df <- read_csv(path, show_col_types = FALSE)

  required_cols <- c(date_col, value_col)
  missing_cols <- setdiff(required_cols, names(df))
  if (length(missing_cols) > 0) {
	stop(sprintf("Missing required columns: %s", paste(missing_cols, collapse = ", ")))
  }

  df %>%
	transmute(
	  ds = as_date(.data[[date_col]]),
	  y = as.numeric(.data[[value_col]])
	) %>%
	arrange(ds)
}

save_processed_data <- function(df, path) {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  write_csv(df, path)
  invisible(path)
}
