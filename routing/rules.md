# Routing Rules

## Precedence (strict)

1. Core reviewers (Correctness + Epistemics) fire on every PR — cannot be disabled
2. Per-repo config may add reviewers
3. Per-repo config may narrow conditional triggers
4. Per-repo config may not remove platform safety reviewers on protected paths
5. When multiple rules match, all matched reviewers fire
6. Orchestrator policy overrides repo config

## Default triggers

| Reviewer | Fires when |
|----------|-----------|
| Correctness | Every PR |
| Epistemics | Every PR |
| Security | Paths match auth, karma, settlement, credentials, secrets |
| Reliability | > 200 LOC changed on execution paths |
| Architect | > 500 LOC changed |

## Semantic routing (phase 1)

Per-repo config specifies `watches` — explicit paths. If any file in `watches` appears in the diff, the reviewer fires. Transitive import graph traversal deferred to phase 2.

## Per-PR finding cap

Maximum 20 findings per verdict across all reviewers. Truncated findings are logged but not posted. Truncation order: lowest severity × confidence first.
