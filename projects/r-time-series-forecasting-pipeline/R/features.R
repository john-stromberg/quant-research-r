library(dplyr)
library(tsibble)
library(lubridate)

build_features <- function(df) {
  df %>%
	mutate(
	  year = year(ds),
	  month = month(ds),
	  quarter = quarter(ds)
	) %>%
	as_tsibble(index = ds)
}
