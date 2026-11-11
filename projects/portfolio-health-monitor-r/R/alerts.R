library(dplyr)

generate_alerts <- function(monitoring_df, thresholds) {
  last_row <- monitoring_df %>% filter(date == max(date))

  alerts <- tibble(
	rule = c("drawdown", "volatility", "tracking_error"),
	breached = c(
	  last_row$drawdown <= thresholds$max_drawdown_breach,
	  last_row$rolling_vol >= thresholds$volatility_spike,
	  last_row$rolling_te >= thresholds$tracking_error_spike
	),
	value = c(last_row$drawdown, last_row$rolling_vol, last_row$rolling_te),
	threshold = c(thresholds$max_drawdown_breach, thresholds$volatility_spike, thresholds$tracking_error_spike)
  )

  alerts
}
