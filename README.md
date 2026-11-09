# ANTICIPATE | NBA Time Machine

**Which players from the 2025–26 NBA season most closely resemble ten all-time greats?**

An approachable R analytics project from **Anticipate**. It compares the statistical production and physical profiles of 10 selected NBA legends with **279 players from the completed 2025–26 NBA season** who played at least 1,000 minutes.

> **Important:** Similarity is **not** a greatness ranking. A modern player can have a similar one-season statistical profile to a legend without being comparably accomplished or talented. The historical statistics are researcher-supplied and **not yet independently verified**.

## How to run

1. Install [R](https://cran.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/) if needed.
2. Open this repository folder as an RStudio project or set the R working directory to the repository root.
3. Install the dependency once and run the model:

```r
install.packages("tidyverse")  # first time only
source("scripts/match_legends.R")
```

The script writes `results/current_top5_matches.csv` and prints the closest five modern players for each legend. Run `getwd()` if R cannot find the CSV files; it should point to this repository's top-level directory.

## Project contents

| File | Purpose |
| --- | --- |
| `data/modern_2025_26.csv` | 279 modern players, at least 1,000 minutes; per-100, advanced, positions, bio height/weight, source URLs |
| `data/legends.csv` | The 10 selected historical players and season-specific profiles (historical stats still unverified) |
| `scripts/match_legends.R` | Beginner-friendly tidyverse similarity model |
| `results/current_top5_matches.csv` | Position-free v3 (70/30) top-five matches calculated from the complete project dataset |
| `results/position_free_v2_77_22_matches.csv` | Archived position-free v2 rankings (77.78/22.22), retained for audit |
| `results/preliminary_top5_matches.csv` | Archived preliminary v1 results, retained for audit and comparison |
| `docs/methodology.md` | Definitions, scoring formula, and limitations |
| `docs/data_dictionary.md` | Column definitions and data provenance |

## The comparison method

The model gives each matchup a **distance score**, using these current group weights:

- **70% statistical profile**: points per 100 possessions, era-relative true shooting, assist %, total rebound %, usage %, steal %, block %.
- **30% physical profile**: height in centimetres and listed weight in pounds.
- **0% position**: guard, forward and center labels are preserved as descriptive context, but never enter the score. Magic Johnson and other versatile or hybrid players should not receive a categorical tax for their listed position.

The numerical variables are standardized by the 2025–26 qualified-player distribution, then compared using squared differences. Version 3 deliberately assigns 70% to statistics and 30% to physical measurements. The older 77.78/22.22 weighting is archived as v2; the original model's 70/20/10 weighting is archived as v1. Scores across versions are not directly comparable. **Lower scores represent closer statistical/physical matches.** The scoring weights are editorial starting assumptions, not scientifically validated optima.

3P% and FT% are retained for descriptive research, but not included in the similarity calculation. We don't use 3P attempt rate because of cross-era play-style changes.

Read [the detailed methods](docs/methodology.md) before interpreting any results.

## Source acknowledgments and data integrity

- **Modern-season statistical tables:** Basketball-Reference [2025–26 Per 100 Possessions](https://www.basketball-reference.com/leagues/NBA_2026_per_poss.html) and [Advanced](https://www.basketball-reference.com/leagues/NBA_2026_advanced.html), supplied for the project by the researcher and cleaned into a 279-player table.
- **Modern height/weight:** season-specific export from [EasySportsApps/nba_api_25_26_data](https://github.com/EasySportsApps/nba_api_25_26_data), documented by its creator as collected through the NBA Stats API; [NBA player bio page](https://www.nba.com/stats/players/bio). Measurements were converted to whole centimetres and pounds.
- **Jaylen Wells exception:** source bio did not specify weight; 206 lb was taken from the [Memphis Grizzlies' official game notes](https://www.nba.com/gamenotes/grizzlies.pdf), as recorded in the dataset.
- **Historical legend profiles:** selected seasons and figures supplied by the researcher; **pending independent Basketball-Reference verification**. Kareem's unavailable usage and three-point percentages remain missing, not zero.
- **Time period:** 2025–26 only for modern players. No 2026–27 performances included.

Names and traded-player season totals are normalized in the processed modern dataset. Each modern player appears exactly once. Season summaries may be subject to upstream source revisions.

## Possible next improvements

Verify the 10 historical lines against the source, run sensitivity tests for the new 70/30 balance, use three-season peaks rather than single legend seasons, and supplement the numerical results with video/scouting analysis.

*Made for Anticipate — NBA research through approachable R.*
