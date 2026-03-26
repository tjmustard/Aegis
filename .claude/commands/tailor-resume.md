---
description: "Generate a tailored resume from the master CV for a specific job description"
---

Generate a tailored resume optimized for a specific job application. The job description file path should be provided as `$ARGUMENTS` (e.g., `/tailor-resume Job_Descriptions/Acme - Senior PM.md`). If no argument is given, ask the user to specify the job description file.

## Steps

1. **Read the job description** from the path given in `$ARGUMENTS`.

2. **Read the master resume** from `aegis/examples/resumes/` (the master resume PDF) or `aegis/master_resume.md` if available.

3. **Analyze the role** — identify:
   - The core competencies and skills the JD emphasizes most
   - The industry/domain context (enterprise IT, scientific AI, pharma/biotech, etc.)
   - Seniority signals and leadership expectations
   - Any specific technologies, methodologies, or frameworks called out

4. **Tailor the resume** by applying these rules:

### Professional Summary
Rewrite the summary (3 short paragraphs, ~75 words each) to lead with the candidate's identity as it maps to *this specific role*. Mirror the JD's language and priorities. Keep the authentic voice — avoid generic buzzwords not already in the source material.

### Skills
Reorder skill groups and individual skills so the most relevant to this JD appear first. Remove skills with no relevance to this role. Do not invent skills not present in the master resume.

### Work History — SandboxAQ
Select and reorder bullet points to prioritize the 4–6 most relevant accomplishments. Lightly rephrase bullet language to mirror the JD's terminology where the underlying achievement matches. Do not fabricate or significantly alter accomplishments. Keep the introductory paragraph.

### Work History — Schrödinger
Apply the same selection and light rephrasing. For roles less relevant to the JD, condense to 3–4 highest-impact bullets.

### Education & Publications
Keep education as-is. For publications, retain the full list but move the most domain-relevant publications to the top of the list if relevance is clear.

## Formatting Rules

- Output clean Markdown, structured to match the original resume layout.
- Header: `# [Your Name]` followed by contact line.
- Use `##` for section headers (Professional Summary, Skills, Work History, Education, Publications).
- Use `###` for company/role subheadings.
- Bullet points for accomplishments (use `-`).
- Bold skill category names (e.g., `**Agentic AI & Ecosystems:**`).
- Do not add sections not present in the master resume.
- Do not include a "tailored for [Company]" note or any meta-commentary in the file itself.

## Output

1. Derive the application slug: `YYYY.MM.DD_CompanyName_JobTitle`
   - Use today's date. Strip special characters; use CamelCase for multi-word names.
   - Example: `2026.03.25_Acme_SeniorProductManager`
2. Create the folder `Applications/<slug>/` if it does not exist.
3. Copy the source JD file into the folder as `<slug>_JD.md`.
4. Write the tailored resume to `Applications/<slug>/<slug>_Resume.md`.
5. After writing, display a brief summary of the key tailoring decisions made (which bullets were prioritized, how the summary was reframed, any notable skill reordering) so the user can review the rationale.
