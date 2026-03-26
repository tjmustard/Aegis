# Aegis

A Claude Code-based toolkit for tailoring resumes and cover letters to job descriptions, with Typst PDF generation and a structured career database.

## How It Works

Aegis uses Claude Code slash commands to drive an AI-assisted application workflow:

1. **Ingest** your master resume into a structured YAML career database (`/aegis-ingest`)
2. **Tailor** the career database to a specific job description — interactively selecting the most relevant roles, bullets, and skills (`/aegis-tailor`)
3. **Generate** compiled PDF resume and cover letter from the tailored YAMLs (`/aegis-generate`)

Simpler single-pass commands (`/cover-letter`, `/tailor-resume`) are also available for quick drafts directly from the master resume.

## Prerequisites

- [Claude Code](https://claude.ai/code)
- [uv](https://docs.astral.sh/uv/) (recommended) or Python 3.11+ — build scripts declare their own dependencies via PEP 723, so `uv run` handles installs automatically
- [Typst](https://typst.app/) (for PDF compilation)
- The following fonts, required by the `modern-cv` Typst template:
  - [Roboto](https://fonts.google.com/specimen/Roboto)
  - [Source Sans Pro](https://fonts.google.com/specimen/Source+Sans+3)
  - [Font Awesome](https://fontawesome.com/download) (OTF files)

  Install fonts system-wide or place OTF/TTF files in `~/.local/share/fonts/` (Linux) or `~/Library/Fonts/` (macOS), then run `fc-cache -f` (Linux) or reopen Font Book (macOS).

## Setup

1. Clone this repo.
2. Install the fonts listed above.
3. Add your master resume as `aegis/master_resume.md`.
4. Run `/aegis-ingest` to populate `aegis/master_career_db.yaml`.
5. Drop a job description into `Job_Descriptions/` and run `/aegis-tailor <path>`.

## Slash Commands

| Command | Description |
|---|---|
| `/aegis-tailor <jd-path>` | Full interactive workflow: tailor career DB to JD, generate YAMLs, compile PDFs |
| `/aegis-generate` | Compile PDFs from existing YAMLs in an application folder |
| `/aegis-ingest` | Parse `master_resume.md` into `master_career_db.yaml` |
| `/aegis-render <pdf>` | Replicate a resume's visual design as a new Typst template |
| `/cover-letter <jd-path>` | Quick cover letter draft from the master resume |
| `/tailor-resume <jd-path>` | Quick tailored resume draft from the master resume |

## Directory Structure

```
aegis/
  master_resume.md          # Your master resume (gitignored)
  master_career_db.yaml     # Structured career database (gitignored)
  writing_style.md          # Writing conventions for all generated content
  skills/                   # Skill prompt files
  templates/                # Typst templates for PDF generation
  examples/                 # Reference examples (job descriptions, cover letters, resumes)
  build.py                  # Build a single PDF
  build-all.py              # Build resume + cover letter PDFs for an application folder

Applications/               # Generated application folders (gitignored)
  YYYY.MM.DD_Company_Role/
    <slug>_JD.md
    tailored_resume.yaml
    cover_letter.yaml
    <slug>-Resume.pdf
    <slug>-Cover_Letter.pdf

.claude/commands/           # Slash command definitions
Job_Descriptions/           # Job posting inbox (gitignored)
```

## Writing Style

All generated content follows `aegis/writing_style.md`. Claude reads this file automatically before producing any written output.
