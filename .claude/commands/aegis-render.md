---
description: "Replicate a resume's visual design as a Typst template from a PDF or image"
---

Read `aegis/skills/skill_replicate_template.md` and follow its instructions precisely.

The source design reference (PDF or image path) is provided as `$ARGUMENTS` (e.g., `/aegis-render aegis/examples/resumes/master-resume.pdf`).

Output the generated template to `aegis/templates/[name].typ`.
The template must natively parse `aegis/tailored_resume.yaml` — no hardcoded text.
