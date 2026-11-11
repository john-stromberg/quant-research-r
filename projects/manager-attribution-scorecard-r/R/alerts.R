library(dplyr)

flag_underperformance <- function(active_df, threshold = -0.01, persistence_periods = 3) {
  active_df %>%
	arrange(manager, date) %>%
	group_by(manager) %>%
	mutate(underperf = active_return <= threshold) %>%
	summarise(
	  latest_underperf_streak = {
		r <- rle(rev(underperf))
		ifelse(length(r$lengths) > 0 && r$values[1], r$lengths[1], 0)
	  },
	  alert = latest_underperf_streak >= persistence_periods,
	  .groups = "drop"
	)
}
