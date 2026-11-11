library(dplyr)

build_factor_signals <- function(panel_df) {
  panel_df %>%
	group_by(ticker) %>%
	arrange(date, .by_group = TRUE) %>%
	mutate(
	  momentum_3m = (1 + ret_1m) * (1 + lag(ret_1m, 1)) * (1 + lag(ret_1m, 2)) - 1,
	  value = book_to_price,
	  quality = roe
	) %>%
	ungroup()
}
