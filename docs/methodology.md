# Similarity methodology — Original model + Magic Johnson exception

## Question and population
For one of 10 historical NBA seasons, which of the 279 eligible NBA players (2025–26 season, 1,000+ minutes each) has the closest measurable profile? Traded players have one combined row.

## Scored variables and standardization
**Statistical:** `pts100`, `relative_ts`, `ast_pct`, `trb_pct`, `usg_pct`, `stl_pct`, `blk_pct`.

**Physical:** `height_cm` and `weight_lb`.

**Position group:** broad Guard, Forward, Center categories, **only for the nine non-Magic legends**.

For each numerical variable, use the sample standard deviation of that variable across the 279 modern players. Calculate the difference between the modern and historical values divided by that standard deviation. Average squared differences within statistical and physical groups. Historical missing values (for example, Kareem's usage) must be left out of the statistical group average, never filled with zero.

**Relative TS** is player TS% minus the season's league TS% in percentage points. The project-supplied modern league average is 58.1%. Historical advanced values remain researcher-supplied inputs pending comprehensive external audit.

## Original formula: nine legends other than Magic Johnson
```text
distance = sqrt(0.70 × statistical_squared_distance
              + 0.20 × physical_squared_distance
              + 0.10 × position_mismatch)
```

Position mismatch = 0 when the candidate has the same Guard/Forward/Center group as the reference legend, otherwise 1. The original weights remain unchanged for John Stockton, Isiah Thomas, Charles Barkley, Larry Bird, Moses Malone, Hakeem Olajuwon, Shaquille O'Neal, Kareem Abdul-Jabbar and Michael Jordan.

## Magic Johnson (1986–87) only: custom formula
```text
distance = sqrt(0.70 × statistical_squared_distance
              + 0.30 × physical_squared_distance)
```

Position is excluded entirely for Magic because a categorical designation poorly captures his positional versatility. No position tax is added for any candidate when the reference legend is Magic. This exception does **not** change the scoring rule for other NBA Time Machine episodes.

`statistical_squared_distance` is the mean squared standardized difference across available statistical fields; `physical_squared_distance` is the mean of the two squared standardized height/weight differences. A smaller distance means a closer measured profile, **not** a percent similarity or greatness ranking.

## Files and version history
- `results/current_top5_matches.csv`: currently authoritative results (nine original-weight legends, plus Magic's 70/30 custom scores), with a per-row `method` field.
- `results/preliminary_top5_matches.csv`: original 70/20/10 results for all 10 legends (now archived; the nine unchanged legend rows should match current results exactly).
- `results/position_free_v2_77_22_matches.csv`: superseded experimental 77.78% statistical / 22.22% physical / 0% position for all ten legends.
- `results/position_free_v3_70_30_all_legends_archive.csv`: superseded experimental 70% statistical / 30% physical / 0% position for all ten legends.

**Do not compare raw distance scores across legends scored under different weight schemes.** Earlier published episodes use their original model and are not re-ranked by Magic-specific changes.

## Limitations
- The historical advanced statistics were supplied by the researcher and have not been independently source-audited in full.
- One-season statistical matches are not measures of playing style or greatness.
- Modern standardized differences do not erase different era playing conditions, rules, or roles.
- Physical bio height and weight may not reflect actual in-season measurements.
- Including a position penalty in the original formula is an editorial assumption and may disadvantage hybrid players. Magic alone uses an explicitly stated exception.
- Shooting contexts differ: 3P% and FT% are descriptive only, not scored; raw 3P volume is omitted.
- Steal/block rates do not capture full defensive value.
- Numerical results were independently recomputed; runtime execution of the supplied R script has not been performed in this workflow.

## Validation
1. Check 279 distinct modern records and 10 historical reference rows.
2. Verify nine unchanged legends reproduce the original archived ranks and distances.
3. Verify Magic-only 70/30 ranks and distances match the dedicated Magic article.
4. Run the R script in RStudio and compare output to `results/current_top5_matches.csv` before claiming R-runtime reproduction.
