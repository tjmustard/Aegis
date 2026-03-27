# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased]

## [0.3.0] - 2026-03-26

### Added
- `aegis/PRD.md` — Original Product Requirements Document used to bootstrap the project; archived for reference.
- `aegis/templates/classic.typ` — Patents/Inventions section rendered between experience and publications when `patents` data is present in the YAML.
- `aegis/templates/resume.typ` — Patents/Inventions section (same placement and behavior as `classic.typ`).

### Changed
- `aegis/skills/skill_tailor_interactive.md` — Added **Phase 0**: agent now asks whether a cover letter is needed before starting. Phases 3 (Cover Letter Drafting) and 3.5 (Fit Check) are skipped entirely when the user opts out. Phase 4 build step calls `--only resume` when no cover letter is requested.
- `aegis/templates/classic.typ` — Job title rendering now respects the optional `display_title` field on a role; falls back to `title` when absent.
- `.gitignore` — Added `*-jd.md` pattern to suppress stray job-description files dropped at the repo root.

---

## [0.2.0] - 2026-03-26

### Added

#### Core Framework (`aegis/`)
- `build.py` — PEP 723 script to compile a resume or cover letter PDF from a YAML data file and a Typst template. Supports `--template` override and auto-derives output filename from `personal_info.name`.
- `build-all.py` — Wrapper script that runs both `resume` and `cover-letter` builds for a single application folder. Supports `--only resume` / `--only cover-letter` flags and per-artifact template overrides.
- `writing_style.md` — Writing conventions that all Claude-generated content (cover letters, resume bullets, summaries) must follow.
- `skills/skill_ingest_master.md` — Skill prompt for `/aegis-ingest`: parses `master_resume.md` into `master_career_db.yaml`.
- `skills/skill_replicate_template.md` — Skill prompt for `/aegis-render`: replicates a resume's visual design as a new Typst template from a PDF or image.
- `skills/skill_tailor_interactive.md` — Skill prompt for `/aegis-tailor`: full interactive tailoring workflow (career DB → tailored YAMLs → compiled PDFs).

#### Typst Templates (`aegis/templates/`)
- `resume.typ` — Primary resume template (data-driven via YAML input).
- `coverletter2.typ` — Primary cover letter template (data-driven via YAML input); default for all generated cover letters.
- `classic.typ` — Alternate classic-style resume template.
- `coverletter.typ` — Alternate cover letter template.
- `cover_letter.typ` — Second alternate cover letter template.

#### Slash Commands (`.claude/commands/`)
- `aegis-tailor.md` — Full interactive workflow: tailor career DB to JD, generate cover letter and resume YAMLs, compile PDFs.
- `aegis-generate.md` — Compile PDFs from existing YAMLs in an application folder.
- `aegis-ingest.md` — Parse `master_resume.md` into `master_career_db.yaml`.
- `aegis-render.md` — Replicate a resume's visual design as a new Typst template.
- `cover-letter.md` — Quick single-pass cover letter draft from the master resume.
- `tailor-resume.md` — Quick single-pass tailored resume draft from the master resume.
- `co-research.md` — Deep-research a topic collaboratively with an expert co-researcher persona.
- `document.md` — Update project docs to reflect recent code changes.
- `prompt-engineer.md` — Collaboratively design and iteratively refine an AI prompt.

#### Examples (`aegis/examples/`)
- `job_descriptions/EXAMPLE - Senior Software Engineer.md` — Template/reference job description showing expected format.
- `job_descriptions/AHEAD - AI Product Manager.md` — Reference JD used during development.
- `job_descriptions/AHEAD - Principal Product Manager.md` — Reference JD used during development.
- `cover_letters/README.md` — Explains what belongs in the cover letters examples folder.
- `resumes/README.md` — Explains what belongs in the resumes examples folder.

#### Project Configuration
- `CLAUDE.md` — Project instructions for Claude Code: directory structure, source-of-truth conventions, slash command reference, and writing style guidance.
- `.gitignore` — Ignores personal career data (`master_resume.md`, `master_career_db.yaml`), generated PDFs/DOCX, application folders, job description inbox, and machine-local Claude settings.

### Changed
- `README.md` — Replaced placeholder one-liner with full project documentation: how it works, prerequisites (Claude Code, uv, Typst, fonts), setup steps, slash command reference table, and directory structure overview.

---

## [0.1.0] - 2026-03-25

### Added
- Initial commit: repository created with placeholder `README.md`.
