# Example Domain Reviewer: Trading Logic — v0.1.0

This file shows how to write a domain reviewer for a specific codebase.
It is NOT a generic component — it is b1e55ed-specific.

## Fires on

PRs touching `engine/brain/`, `engine/producers/`, or any file in the `watches` list in `.review-council.yml`.

## Responsible for

- Basis trade mechanics: is the funding/basis interpretation correct?
- Conviction/confidence formula integrity: does the formula match the spec?
- Forecast append-only invariants: are FORECAST_V1 events immutable after emission?
- Signal decay: is the decay formula applied correctly? Is the half-life defensible?
- Regime detection assumptions: is the regime classification logic sound?
- Hidden market structure assumptions: does this change imply something about market behavior the author didn't declare?

## Key questions

- "Does this change assume a specific market regime that isn't declared?"
- "Is the confidence/magnitude value calibrated, or is it a magic number?"
- "Would a basis trade unwind break this logic?"

## Output format

Same as core reviewers. Use `category: "assumption"` for market structure assumptions.
