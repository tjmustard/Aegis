# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Aegis is a Claude Code-based toolkit for tailoring resumes and cover letters to job descriptions, with Typst PDF generation and a structured career database.

## Directory Structure

- **`aegis/`** — Core framework
  - `master_resume.md` — Canonical master resume source (gitignored, personal)
  - `master_career_db.yaml` — Structured career database (gitignored, personal)
  - `writing_style.md` — Writing conventions all generated content must follow
  - `skills/` — Skill prompt files for each slash command
  - `templates/` — Typst templates for PDF generation (`classic.typ`, `coverletter2.typ`, etc.)
  - `examples/` — Reference examples: job descriptions, cover letters, resumes
  - `build.py` / `build-all.py` — PDF build scripts
- **`Applications/`** — Generated application folders (gitignored); each subfolder = one application
  - Naming: `YYYY.MM.DD_CompanyName_JobTitle/`
  - Contains: `<slug>_JD.md`, `<slug>_CoverLetter.md`, `tailored_resume.yaml`, `cover_letter.yaml`, compiled PDFs
- **`.claude/commands/`** — Slash command definitions

## Source of Truth for Resume Content

The canonical resume source is `aegis/master_resume.md` (Markdown) and the structured `aegis/master_career_db.yaml`. The `/aegis-tailor` workflow reads from the career DB. The simpler `/cover-letter` and `/tailor-resume` commands read from the master resume PDF in `aegis/examples/resumes/`.

## Writing Style

All generated content (cover letters, resumes, summaries) must follow the conventions in `aegis/writing_style.md`. Read that file before generating any written output.

## Slash Commands

- `/cover-letter <path>` — Generate a cover letter for the given JD. Outputs to `Applications/<slug>/`.
- `/tailor-resume <path>` — Generate a tailored resume for the given JD. Outputs to `Applications/<slug>/`.
- `/aegis-tailor <path>` — Full interactive workflow: tailor career DB to JD, generate cover letter and resume YAMLs, compile PDFs.
- `/aegis-generate` — Compile PDFs from existing YAMLs in an application folder.
- `/aegis-ingest` — Parse `master_resume.md` into `master_career_db.yaml`.
- `/aegis-render` — Replicate a resume's visual design as a new Typst template.
