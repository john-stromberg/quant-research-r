library(fredr)
library(dplyr)

load_macro_rates <- function(series_id) {
  key <- Sys.getenv("FRED_API_KEY")
  if (key == "") {
	warning("FRED_API_KEY not set; returning empty rates frame")
	return(tibble(date = as.Date(character()), value = numeric()))
  }

  fredr_set_key(key)
  fredr(series_id = series_id) %>% transmute(date = as.Date(date), value = value)
}
