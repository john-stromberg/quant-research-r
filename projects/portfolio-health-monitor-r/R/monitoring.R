library(dplyr)
library(PerformanceAnalytics)
library(zoo)

compute_monitoring_metrics <- function(portfolio_df, benchmark_df, rolling_window = 60) {
  joined <- portfolio_df %>%
	rename(portfolio_return = value) %>%
	inner_join(benchmark_df %>% rename(benchmark_return = value), by = "date") %>%
	mutate(active_return = portfolio_return - benchmark_return)

  joined %>%
	mutate(
	  cumulative_portfolio = cumprod(1 + portfolio_return) - 1,
	  drawdown = cumulative_portfolio - cummax(cumulative_portfolio),
	  rolling_vol = zoo::rollapply(portfolio_return, rolling_window, sd, fill = NA, align = "right") * sqrt(252),
	  rolling_sharpe = zoo::rollapply(portfolio_return, rolling_window, function(x) mean(x) / sd(x), fill = NA, align = "right") * sqrt(252),
	  rolling_te = zoo::rollapply(active_return, rolling_window, sd, fill = NA, align = "right") * sqrt(252)
	)
}
