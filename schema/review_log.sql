CREATE TABLE review_log (
  finding_id          TEXT PRIMARY KEY,
  verdict_id          TEXT REFERENCES verdicts(verdict_id),
  reviewer            TEXT NOT NULL,
  reviewer_version    TEXT NOT NULL,
  manifest_version    TEXT,
  pr_number           INTEGER NOT NULL,
  repo                TEXT NOT NULL,
  file                TEXT,
  start_line          INTEGER,
  end_line            INTEGER,
  severity            TEXT NOT NULL,         -- low | medium | high | critical
  disposition         TEXT NOT NULL,         -- note | concern | block
  category            TEXT NOT NULL,
  finding             TEXT NOT NULL,
  evidence_type       TEXT,
  evidence_excerpt    TEXT,
  evidence_why        TEXT,
  suggestion          TEXT,
  reviewer_confidence REAL,
  pass_number         INTEGER DEFAULT 1,     -- 1 = independent, 2 = cross-examination
  truncated           BOOLEAN DEFAULT FALSE, -- true if removed by per-PR cap
  -- Merge outcome
  merged              BOOLEAN,
  -- Pre-merge resolution
  resolved_pre_merge  BOOLEAN,
  resolution_type     TEXT,    -- fixed | accepted-risk | dismissed | duplicate | override
  resolution_note     TEXT,
  duplicate_of        TEXT REFERENCES review_log(finding_id),
  duplicate_declared_by TEXT,  -- arbiter | human (who decided this is a duplicate)
  -- Post-merge calibration
  incident_linked     TEXT,
  incident_severity   TEXT,
  finding_validated   BOOLEAN,
  -- Author feedback (weak signal — fast, not ground truth)
  author_feedback     TEXT,    -- valid | false-positive | helpful-not-actionable | null
  -- Performance
  diff_size_lines     INTEGER,
  review_duration_ms  INTEGER,
  created_at          TEXT NOT NULL,
  updated_at          TEXT NOT NULL
);

CREATE TABLE verdicts (
  verdict_id          TEXT PRIMARY KEY,
  task_key            TEXT NOT NULL,         -- repo:pr:sha idempotency key
  pr_number           INTEGER NOT NULL,
  repo                TEXT NOT NULL,
  verdict             TEXT NOT NULL,
  reviewers_fired     TEXT NOT NULL,         -- JSON array
  reviewer_conflicts  TEXT,                  -- JSON array
  gate_trigger        TEXT,
  block_reason        TEXT,
  label_applied       TEXT,
  merge_blocked       BOOLEAN,
  manifest_present    BOOLEAN,
  manifest_version    TEXT,
  total_findings      INTEGER,
  findings_truncated  INTEGER DEFAULT 0,
  review_duration_ms  INTEGER,
  diff_size_lines     INTEGER,
  timestamp           TEXT NOT NULL
);

CREATE TABLE locks (
  lock_key            TEXT PRIMARY KEY,      -- repo:pr_number
  acquired_at         TEXT NOT NULL,
  expires_at          TEXT NOT NULL,
  task_key            TEXT
);
