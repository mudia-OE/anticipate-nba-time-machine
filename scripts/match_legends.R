# ANTICIPATE | NBA Time Machine
# Magic Johnson custom model: 70% stats, 30% physical, 0% position.
# All nine other legends: original 70% stats, 20% physical, 10% position.
# Run from repo root: source("scripts/match_legends.R")
# First time only: install.packages("tidyverse")

library(tidyverse)

modern <- read_csv("data/modern_2025_26.csv", show_col_types = FALSE)
legends <- read_csv("data/legends.csv", show_col_types = FALSE)

stopifnot(nrow(modern) == 279, nrow(legends) == 10)
stopifnot(n_distinct(modern$player_id) == nrow(modern))
stopifnot(!any(is.na(modern$height_cm)), !any(is.na(modern$weight_lb)))

stats <- c("pts100", "relative_ts", "ast_pct", "trb_pct",
           "usg_pct", "stl_pct", "blk_pct")

means <- modern %>% summarise(across(all_of(stats), mean, na.rm = TRUE))
sds <- modern %>% summarise(across(all_of(stats), sd, na.rm = TRUE))
height_sd <- sd(modern$height_cm)
weight_sd <- sd(modern$weight_lb)

find_matches <- function(legend_name) {
  legend <- legends %>% filter(player == legend_name)
  stopifnot(nrow(legend) == 1)

  available <- stats[!is.na(unlist(legend[1, stats]))]
  squared_differences <- rep(0, nrow(modern))
  for (stat in available) {
    modern_z <- (modern[[stat]] - means[[stat]]) / sds[[stat]]
    legend_z <- (legend[[stat]][1] - means[[stat]]) / sds[[stat]]
    squared_differences <- squared_differences + (modern_z - legend_z)^2
  }

  stats_d2 <- squared_differences / length(available)
  physical_d2 <- (
    ((modern$height_cm - legend$height_cm[1]) / height_sd)^2 +
    ((modern$weight_lb - legend$weight_lb[1]) / weight_sd)^2
  ) / 2

  # Original positional mismatch applies to everyone EXCEPT Magic.
  # For Magic, position is not an input to the scoring formula.
  is_magic <- legend_name == "Magic Johnson"
  if (is_magic) {
    overall_d2 <- 0.70 * stats_d2 + 0.30 * physical_d2
    method_name <- "Magic-only: 70% stats / 30% physical / 0% position"
  } else {
    position_d2 <- as.numeric(modern$position_group != legend$position[1])
    overall_d2 <- 0.70 * stats_d2 + 0.20 * physical_d2 + 0.10 * position_d2
    method_name <- "Original: 70% stats / 20% physical / 10% position"
  }

  modern %>%
    mutate(
      legend = legend_name,
      legend_season = legend$season[1],
      stat_distance = sqrt(stats_d2),
      physical_distance = sqrt(physical_d2),
      overall_distance = sqrt(overall_d2)
    ) %>%
    arrange(overall_distance) %>%
    slice_head(n = 5) %>%
    mutate(rank = row_number()) %>%
    transmute(
      legend, legend_season, rank, modern_player = player, team,
      stat_distance = round(stat_distance, 4),
      physical_distance = round(physical_distance, 4),
      overall_distance = round(overall_distance, 4),
      method = method_name
    )
}

all_matches <- map_dfr(legends$player, find_matches)
write_csv(all_matches, "results/current_top5_matches.csv")
print(all_matches, n = 50)
