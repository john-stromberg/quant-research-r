library(dplyr)

rank_and_form_quantiles <- function(signal_df, n_quantiles = 5, signal_col = "momentum_3m") {
  signal_df %>%
	filter(!is.na(.data[[signal_col]])) %>%
	group_by(date) %>%
	mutate(q = dplyr::ntile(.data[[signal_col]], n_quantiles)) %>%
	ungroup()
}

compute_long_short_returns <- function(quantile_df, top_q = 5, bottom_q = 1) {
  top <- quantile_df %>% filter(q == top_q) %>% group_by(date) %>% summarise(top_ret = mean(ret_1m, na.rm = TRUE), .groups = "drop")
  bot <- quantile_df %>% filter(q == bottom_q) %>% group_by(date) %>% summarise(bot_ret = mean(ret_1m, na.rm = TRUE), .groups = "drop")

  top %>%
	inner_join(bot, by = "date") %>%
	mutate(long_short_ret = top_ret - bot_ret)
}
