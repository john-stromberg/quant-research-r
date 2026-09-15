library(dplyr)

compute_net_impact <- function(returns_df, current_w, target_w, cost_tbl) {
  latest <- returns_df %>% filter(date == max(date))

  base_w <- current_w %>% select(asset, weight) %>% tibble::deframe()
  tgt_w <- target_w %>% select(asset, target_weight) %>% tibble::deframe()

  gross_current <- latest$equity * base_w[["equity"]] + latest$bonds * base_w[["bonds"]] + latest$commodities * base_w[["commodities"]]
  gross_target <- latest$equity * tgt_w[["equity"]] + latest$bonds * tgt_w[["bonds"]] + latest$commodities * tgt_w[["commodities"]]

  tibble(
	gross_current = gross_current,
	gross_target = gross_target,
	gross_difference = gross_target - gross_current,
	total_cost = cost_tbl$total_cost[[1]],
	net_difference = (gross_target - gross_current) - cost_tbl$total_cost[[1]]
  )
}
