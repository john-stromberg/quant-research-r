library(dplyr)

run_placeholder_analysis <- function(df) {
  df %>% summarise(rows = n())
}

