# Data dictionary

## `data/modern_2025_26.csv`

One unique record per player who played 1,000 or more NBA minutes in 2025–26, based on the user-provided Basketball-Reference advanced and per-100-possession season tables. Player identity uses `player_id`, the Basketball-Reference identifier.

| Column | Meaning |
| --- | --- |
| `player`, `team`, `age`, `position` | Player name, season team (or combined team code), age, listed position |
| `position_group` | Simplified Guard / Forward / Center grouping |
| `games`, `minutes` | Season appearances and minutes; sample restriction is >=1,000 minutes |
| `pts100` | Points per 100 possessions |
| `ts_pct`, `league_ts_pct` | Player and supplied 2025–26 league TS%, in 0–100 units |
| `relative_ts` | `ts_pct - league_ts_pct`, in percentage points |
| `ast_pct`, `trb_pct`, `usg_pct`, `stl_pct`, `blk_pct` | Advanced statistics, 0–100 units |
| `three_pct`, `ft_pct` | Three-point and free-throw percentages, 0–100 units; 3P% blank when not meaningful |
| `three_attempts_per100` | Three-point attempts per 100 possessions; descriptive only |
| `height_cm`, `weight_lb` | Listed bio measurements rounded to whole cm and lb |
| `source_per100`, `source_advanced`, `profile_source`, `height_weight_source`, `height_weight_note` | Data provenance and exceptions |

## `data/legends.csv`

One researcher-selected season for each of 10 NBA legends. Column names for similarity features match the modern table, while `position` has the broad Guard / Forward / Center group. **Statistical values have not yet been independently verified.** Kareem has missing `usg_pct` and `three_pct` fields.

## `results/preliminary_top5_matches.csv`

For every legend, five candidate modern players ordered by `overall_distance` (smaller is closer). `stat_distance` and `physical_distance` are root-mean-square standardized differences; `position_penalty` is 0 or 1. This is an exploratory output pending source and R-runtime verification.
