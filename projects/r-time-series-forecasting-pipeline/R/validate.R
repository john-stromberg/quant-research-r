library(dplyr)

validate_time_series <- function(df) {
  if (!all(c("ds", "y") %in% names(df))) {
	stop("Input data must contain `ds` and `y` columns")
  }

  if (any(is.na(df$ds))) stop("Date column contains NA values")
  if (any(is.na(df$y))) stop("Value column contains NA values")

  dup_n <- df %>% count(ds) %>% filter(n > 1) %>% nrow()
  if (dup_n > 0) stop("Duplicate timestamps found in `ds`")

  if (nrow(df) < 36) {
	warning("Fewer than 36 observations; forecast reliability may be limited")
  }

  invisible(TRUE)
}
