---
description: "Score JD match against master_career_db, identify gaps, and optionally enrich the DB with new achievements"
---

Read `aegis/skills/skill_score_jd.md` and follow its instructions precisely.

The job description file path is provided as `$ARGUMENTS` (e.g., `/aegis-score Applications/2026.03.29_GDIT_AIProductManager/2026.03.29_GDIT_AIProductManager_JD.md`).

Source data: `aegis/master_career_db.yaml`

If the user approves new achievements, write them directly to `aegis/master_career_db.yaml`.
