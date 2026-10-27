# Similarity methodology — Version 1

## Question
For a selected legendary NBA season, which eligible NBA player in 2025–26 has the closest measurable profile?

## Population
10 user-selected legendary seasons, 279 modern players with 1,000+ NBA minutes in 2025–26. Traded players have one combined season row; source player IDs are unique.

## Included variables
**Statistical:** `pts100`, `relative_ts`, `ast_pct`, `trb_pct`, `usg_pct`, `stl_pct`, `blk_pct`.

**Physical:** `height_cm`, `weight_lb`. **Position:** broad `Guard`, `Forward`, `Center` group.

3P% and FT% are present in the files but **not scored**: early NBA periods provide limited and non-equivalent three-point shooting opportunities. The model's statistics measure production more than true on-court style.

## Relative true shooting
`relative_ts = player TS% − league TS%`, measured in percentage points. The cleaned 2025–26 table uses the project-supplied league average of 58.1%. Historical rTS values are as supplied; these need verification against year-specific NBA average TS%.

## Standardization
For each numerical variable, calculate its mean and standard deviation **across the same 279 modern players**. Convert all data to comparable units using the modern standard deviation; equivalently compare modern and historical z-scores.

## Distances
For each legend–modern-player pair:

- **Statistical squared distance** = mean of squared standardized differences across available statistical fields.
- **Physical squared distance** = mean squared difference in standardized height and weight.
- **Position penalty** = 0 for same broad group and 1 for a different broad group.

Final score:

```text
sqrt(0.70 × stat_distance² + 0.20 × physical_distance² + 0.10 × position_penalty)
```

Smaller = closer profile; this is a **distance, not a percent similarity**. The position penalty strength depends on the overall range of squared-distance scores. The weights represent a research choice, not a validated statistical fact.

When a historical stat is absent, as with Kareem's `usg_pct`, exclude that stat **for that comparison** and average over the others. Never set missing values to zero. The modern profiles must have all required numerical fields to be used without adjustment.

## Limitations
- The legend seasons and numbers haven't been independently source-audited.
- Single-season reference profiles ignore different stages of the legends' careers.
- Relative TS adjusts efficiency for era, but pace and role contexts are not fully interchangeable.
- Physical weights are listed bio measurements, not necessarily playing-season weights for the legends.
- Guard/forward/center categories lose nuance, especially for hybrid players.
- Steal/block percentages are not comprehensive measures of defensive value.
- NBA 3-point rules, shot selection and opportunity differed sharply across eras.
- A player's closest modern profile is not a claim of equal talent, effectiveness, or achievements.
- The results file was precalculated outside R. The R code is provided for reproducibility and should be run in RStudio before publication.

## Next validation
1. Verify legend values with Basketball-Reference for the selected seasons.
2. Execute the supplied R script and compare it against the preliminary CSV.
3. Check alternative weighting schemes and small-sample bias.
4. Consider three-year reference peaks to reduce variance.
