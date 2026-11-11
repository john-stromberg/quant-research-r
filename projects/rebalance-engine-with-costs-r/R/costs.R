library(dplyr)

estimate_rebalance_cost <- function(drift_df, fixed_cost_bps, proportional_cost_bps, slippage_multiplier = 1.0) {
  turnover <- sum(abs(drift_df$drift), na.rm = TRUE)
  variable_cost <- turnover * (proportional_cost_bps / 10000) * slippage_multiplier
  fixed_cost <- fixed_cost_bps / 10000

  tibble(
	turnover = turnover,
	fixed_cost = fixed_cost,
	variable_cost = variable_cost,
	total_cost = fixed_cost + variable_cost
  )
}
