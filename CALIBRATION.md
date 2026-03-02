# Calibration

Monthly review of `review_log.db` to measure whether the council is adding signal or latency.

## Metrics

| Metric | Question | Target |
|--------|----------|--------|
| Precision | Of all `block` findings, what % were real problems? | > 80% |
| Recall | Of all post-merge incidents, what % had a prior finding? | Track trend |
| Noise (per-reviewer) | Average findings per 100 LOC | < 3 |
| Noise (per-PR) | Average findings per PR | < 15 |
| Override rate | % of PRs using escape hatch | < 5% |
| False positive rate | % marked false-positive by author | Track by reviewer |
| SLA compliance | % reviewed within SLA | > 95% |

## Author feedback

Collected via reaction or comment on the GH review comment. Fast signal, weak weight — do not tune prompts based on author feedback alone. Post-merge incident linkage is the higher-weight signal.

## Reviewer tuning

- Exceeds noise budget consistently → prompt tuning sprint
- Low recall → widen reviewer scope
- Low precision → narrow reviewer scope or raise evidence bar
- Track by `reviewer_version` so changes are attributable
