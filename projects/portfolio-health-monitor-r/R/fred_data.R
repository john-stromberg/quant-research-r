library(fredr)
library(dplyr)

load_fred_series <- function(series_ids) {
  key <- Sys.getenv("FRED_API_KEY")
  if (key == "") {
	warning("FRED_API_KEY not set; returning empty macro frame")
	return(tibble(date = as.Date(character()), series_id = character(), value = numeric()))
  }

  fredr_set_key(key)

  purrr::map_dfr(series_ids, function(sid) {
	fredr(series_id = sid) %>%
	  transmute(date = as.Date(date), series_id = sid, value = value)
  })
}
