library(dplyr)

compute_active_returns <- function(manager_df, benchmark_df) {
  manager_df %>%
	inner_join(benchmark_df, by = "date") %>%
	mutate(active_return = return - benchmark_return)
}

compute_brinson_effects <- function(sector_df) {
  sector_df %>%
	mutate(
	  allocation_effect = (portfolio_weight - benchmark_weight) * benchmark_return,
	  selection_effect = benchmark_weight * (portfolio_return - benchmark_return),
	  interaction_effect = (portfolio_weight - benchmark_weight) * (portfolio_return - benchmark_return),
	  total_effect = allocation_effect + selection_effect + interaction_effect
	)
}
