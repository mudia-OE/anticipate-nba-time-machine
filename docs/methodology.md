# Similarity methodology — Version 3 (position-free, 70/30)

## Question
For a selected legendary NBA season, which eligible NBA player in 2025–26 has the closest measurable profile?

## Population
10 user-selected legendary seasons, 279 modern players with 1,000+ NBA minutes in 2025–26. Traded players have one combined season row; source player IDs are unique.

## Included variables
**Statistical:** `pts100`, `relative_ts`, `ast_pct`, `trb_pct`, `usg_pct`, `stl_pct`, `blk_pct`.

**Physical:** `height_cm`, `weight_lb`.

**Position is not scored.** Guard/forward/center labels are descriptive metadata only. A versatile creator such as Magic Johnson or LeBron James should not be penalized simply because the listing assigns a different broad role. Positions carry a **0% weight** and never affect ranking or distance.

3P% and FT% are present in the files but **not scored**: early NBA periods provide limited and non-equivalent three-point shooting opportunities. The model's statistics measure production more than true on-court style.

## Relative true shooting
`relative_ts = player TS% − league TS%`, measured in percentage points. The cleaned 2025–26 table uses the project-supplied league average of 58.1%. Historical rTS values are as supplied; these need verification against year-specific NBA average TS%.

## Standardization
For each numerical variable, calculate its mean and sample standard deviation **across the same 279 modern players**. Compare historical and modern values by difference divided by that standard deviation.

## Distances
For each legend–modern-player pair:

- **Statistical squared distance** = mean of squared standardized differences across available statistical fields.
- **Physical squared distance** = mean squared standardized height and weight differences.
- **Position** = excluded entirely.

Final score, with an intentional 70/30 weighting across the two measured groups:

```text
sqrt(0.70 × stat_distance² + 0.30 × physical_distance²)
```

Here `stat_distance²` averages the seven available squared standardized statistical differences, and `physical_distance²` averages height and weight's squared standardized differences. A group's weight does not apply independently to each field.

Smaller = closer profile; it is **a distance, not a percent similarity or an equivalence in talent**. No data column related to position enters this expression. The weights represent an editorial research choice, not a validated optimum.

When a historical stat is missing, such as Kareem's `usg_pct`, exclude that stat **for that comparison** and average over the remaining available statistics; do not fill with zero. All scored modern variables must be present.

## Version history
- **v1 (archived):** 70% statistics, 20% physical, 10% categorical position mismatch; stored in `results/preliminary_top5_matches.csv`.
- **v2 (archived):** 77.78% statistics, 22.22% physical, **0% position**; stored in `results/position_free_v2_77_22_matches.csv`.
- **v3 (current):** 70% statistics, 30% physical, **0% position**; stored in `results/current_top5_matches.csv`.

The raw distances across model versions are not directly comparable because the weights are renormalized. Historical articles originally published using v1 must be updated or clearly marked as using the archived version before comparing their scores to new v3 results.

## Limitations
- The historical legend-season advanced numbers were supplied by the researcher and have not yet been fully audited.
- Single-season reference profiles ignore other stages of legends' careers.
- Relative TS adjusts efficiency for era, but pace and role contexts are not interchangeable.
- Physical weights are listed measurements, not necessarily verified in-season weights.
- Removing position avoids an arbitrary categorical penalty, but position/role and defensive tasks still influence the statistical inputs indirectly.
- Steal/block percentages are not comprehensive measurements of defense.
- NBA rules and three-point opportunities differ sharply between eras.
- Closest modern profile does not imply equal talent, effectiveness, or achievements.
- The results CSV is independently calculated from project inputs; run the R script before claiming R-runtime reproduction.

## Validation checklist
1. Confirm exactly 279 modern records, all unique IDs, and ten historical seasons.
2. Recompute the v1 scores to ensure the standardization reproduces the archived rankings.
3. Recompute all v3 distances from the two scored groups only, using weights 0.70 and 0.30.
4. Run the R script and compare it with the committed `results/current_top5_matches.csv`.
5. Verify historical values and conduct weight sensitivity tests.
