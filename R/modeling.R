library(fable)
library(fabletools)
library(tsibble)

fit_models <- function(ts_data) {
  ts_data %>%
	model(
	  ets = ETS(y),
	  arima = ARIMA(y),
	  snaive = SNAIVE(y)
	)
}

make_forecast <- function(model_tbl, h = "12 months") {
  model_tbl %>% forecast(h = h)
}
