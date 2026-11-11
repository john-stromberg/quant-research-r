library(dplyr)

build_manager_scorecard <- function(active_df, brinson_df) {
  perf <- active_df %>%
	group_by(manager) %>%
	summarise(
	  avg_active = mean(active_return, na.rm = TRUE),
	  cum_active = prod(1 + active_return) - 1,
	  active_vol = sd(active_return, na.rm = TRUE),
	  .groups = "drop"
	)

  attr <- brinson_df %>%
	group_by(manager) %>%
	summarise(
	  alloc_total = sum(allocation_effect, na.rm = TRUE),
	  select_total = sum(selection_effect, na.rm = TRUE),
	  interaction_total = sum(interaction_effect, na.rm = TRUE),
	  .groups = "drop"
	)

  perf %>%
	left_join(attr, by = "manager") %>%
	arrange(desc(cum_active))
}
