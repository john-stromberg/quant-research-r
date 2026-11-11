library(dplyr)

load_config <- function(path = "config/config.yml") {
  cfg <- yaml::read_yaml(path)

  if (is.null(cfg$data) || is.null(cfg$data$input_csv) || !nzchar(cfg$data$input_csv)) {
	stop("Config must contain data.input_csv.", call. = FALSE)
  }

  cfg
}

load_input_data <- function(cfg) {
  readr::read_csv(cfg$data$input_csv, show_col_types = FALSE)
}

validate_input_data <- function(df, required_cols = c("x", "y")) {
  missing_cols <- setdiff(required_cols, names(df))
  if (length(missing_cols) > 0) {
	stop(sprintf("Missing required columns: %s", paste(missing_cols, collapse = ", ")), call. = FALSE)
  }

  if (nrow(df) < 2) {
	stop("Input data must contain at least 2 rows.", call. = FALSE)
  }

  non_numeric <- required_cols[!vapply(df[required_cols], is.numeric, logical(1))]
  if (length(non_numeric) > 0) {
	stop(sprintf("Required columns must be numeric: %s", paste(non_numeric, collapse = ", ")), call. = FALSE)
  }

  if (any(is.na(df[required_cols]))) {
	stop("Input data contains NA values in required columns.", call. = FALSE)
  }

  df
}

prepare_features <- function(df) {
  df %>%
	mutate(
	  x_sq = x^2
	)
}

fit_baseline_model <- function(df) {
  stats::lm(y ~ x + x_sq, data = df)
}

generate_predictions <- function(model, df) {
  df %>%
	mutate(prediction = as.numeric(stats::predict(model, newdata = df)))
}

compute_metrics <- function(df_with_preds) {
  residuals <- df_with_preds$y - df_with_preds$prediction

  tibble::tibble(
	rows = nrow(df_with_preds),
	rmse = sqrt(mean(residuals^2)),
	mae = mean(abs(residuals)),
	r_squared = stats::cor(df_with_preds$y, df_with_preds$prediction)^2
  )
}

run_nowcast_pipeline <- function(config_path = "config/config.yml") {
  cfg <- load_config(config_path)
  raw_data <- load_input_data(cfg)
  validated_data <- validate_input_data(raw_data)
  features <- prepare_features(validated_data)
  model <- fit_baseline_model(features)
  predictions <- generate_predictions(model, features)
  metrics <- compute_metrics(predictions)

  list(
	config = cfg,
	data = validated_data,
	features = features,
	model = model,
	predictions = predictions,
	metrics = metrics
  )
}

