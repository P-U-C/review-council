# Arbiter Policy — v0.4

## Verdict derivation (in order, stop at first match)

1. Missing manifest → `human-required`
2. Hard gate triggered (path or semantic) → `human-required`
3. `block` finding with confidence ≥ 0.7 → `block`
4. `block` finding with confidence < 0.7 → `human-required`
5. Reviewer conflict (block from A, pass from B on same surface) → `human-required` + log conflict
6. Two+ `concern` findings from different reviewers on same surface, both confidence > 0.75 → `block`
7. Any `concern` finding → `concern`
8. Required reviewer average confidence < 0.5 → `insufficient-evidence` (treated as `human-required`)
9. No findings above note level → `pass`

## Per-PR cap

Max 20 findings. Truncate by lowest severity × confidence. Log truncated findings with `truncated=true`.

## Conflict handling

Reviewer conflicts preserved in `reviewer_conflicts` on verdict. Never flattened.

## Confidence weighting

Low-confidence block (< 0.6): escalate to `human-required`, not auto-block.
Two high-confidence concerns (> 0.8) from different reviewers on same surface: compound to `block`.
