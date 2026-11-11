library(dplyr)
library(yardstick)

evaluate_accuracy <- function(forecast_tbl, actual_tbl) {
  joined <- forecast_tbl %>%
	as_tibble() %>%
	select(ds, .model, .mean) %>%
	left_join(actual_tbl %>% select(ds, y), by = "ds")

  metrics <- metric_set(rmse, mae, mape)
  joined %>%
	group_by(.model) %>%
	metrics(truth = y, estimate = .mean)
}
