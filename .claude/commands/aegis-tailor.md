---
description: "Interactively tailor master_career_db.yaml to a job description and generate cover letter"
---

Read `aegis/skills/skill_tailor_interactive.md` and follow its instructions precisely.

The job description file path is provided as `$ARGUMENTS` (e.g., `/aegis-tailor Job_Descriptions/Acme - Senior PM.md`).

Source data: `aegis/master_career_db.yaml`

All outputs go into a new application folder following this convention:
- Folder: `Applications/YYYY.MM.DD_CompanyName_JobTitle/`
- JD copy: `Applications/YYYY.MM.DD_CompanyName_JobTitle/YYYY.MM.DD_CompanyName_JobTitle_JD.md`
- Outputs: `tailored_resume.yaml`, `cover_letter.yaml` saved into that same folder
- PDFs compiled by running:
  ```
  python aegis/build.py --app-dir Applications/<slug> resume
  python aegis/build.py --app-dir Applications/<slug> cover-letter
  ```
