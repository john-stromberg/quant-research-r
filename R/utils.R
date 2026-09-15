library(dplyr)
library(rlang)

ensure_dir <- function(path) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  invisible(path)
}

log_step <- function(msg) {
  message(sprintf("[pipeline] %s", msg))
  invisible(msg)
}
