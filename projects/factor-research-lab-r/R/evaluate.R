library(dplyr)

compute_ic <- function(signal_df, signal_col = "momentum_3m") {
  signal_df %>%
	group_by(date) %>%
	summarise(ic = suppressWarnings(cor(.data[[signal_col]], ret_1m, use = "complete.obs")), .groups = "drop")
}

summarize_factor_performance <- function(ls_df, ic_df) {
  tibble(
	periods = nrow(ls_df),
	mean_ls = mean(ls_df$long_short_ret, na.rm = TRUE),
	vol_ls = sd(ls_df$long_short_ret, na.rm = TRUE),
	cum_ls = prod(1 + ls_df$long_short_ret) - 1,
	mean_ic = mean(ic_df$ic, na.rm = TRUE)
  )
}
