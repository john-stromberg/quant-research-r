library(dplyr)

compute_weight_drift <- function(current_w, target_w) {
  current_w %>%
	select(asset, weight) %>%
	inner_join(target_w, by = "asset") %>%
	mutate(
	  drift = weight - target_weight,
	  abs_drift = abs(drift)
	)
}

rebalance_required <- function(drift_df, threshold = 0.03) {
  max(drift_df$abs_drift, na.rm = TRUE) >= threshold
}
