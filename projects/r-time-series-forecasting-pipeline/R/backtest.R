library(fable)
library(tsibble)

rolling_backtest <- function(ts_data, .init = 36, .step = 1, h = 1) {
  ts_data %>%
	stretch_tsibble(.init = .init, .step = .step) %>%
	model(
	  ets = ETS(y),
	  arima = ARIMA(y),
	  snaive = SNAIVE(y)
	) %>%
	forecast(h = h)
}
