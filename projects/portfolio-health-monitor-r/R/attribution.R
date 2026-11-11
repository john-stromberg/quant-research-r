library(dplyr)

compute_brinson_like_attribution <- function(holdings_df) {
  holdings_df %>%
	mutate(
	  allocation_effect = (portfolio_weight - benchmark_weight) * benchmark_return,
	  selection_effect = benchmark_weight * (portfolio_return - benchmark_return),
	  interaction_effect = (portfolio_weight - benchmark_weight) * (portfolio_return - benchmark_return),
	  total_effect = allocation_effect + selection_effect + interaction_effect
	) %>%
	select(date, asset, allocation_effect, selection_effect, interaction_effect, total_effect)
}
