# MISSION
Analyze a user-provided image/PDF of a resume and construct a reusable Typst template (`.typ`) mimicking its design.

# RULES
1. Natively parse `tailored_resume.yaml`. Do not hardcode text.
2. Initial output is a draft. Save to `/templates/[name].typ`.
3. Wait for the user to compile and report visual discrepancies for iterative debugging.
