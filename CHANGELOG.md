# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased]

## [0.4.0] - 2026-04-01

### Added
- `aegis/skills/skill_score_jd.md` — New skill for `/aegis-score`: scores a JD against `master_career_db.yaml` across four dimensions (technical skills, experience depth, domain alignment, leadership), identifies top 5 strengths and gaps, runs an ATS keyword check, and optionally drafts new `atomic_achievements` for fillable/partial gaps using a full approve/edit/skip review loop before writing to the DB.
- `.claude/commands/aegis-score.md` — Slash command entry point for `/aegis-score`.
- `aegis/skills/skill_db_edit.md` — New skill for `/aegis-db-edit`: accepts natural language instructions or explicit change lists, presents every proposed edit as a numbered before/after block, and requires approve/edit/skip on each change before writing to `master_career_db.yaml`. Supports "approve all" / "skip all" shortcuts and an edit confirmation loop.
- `.claude/commands/aegis-db-edit.md` — Slash command entry point for `/aegis-db-edit`.

### Changed
- `aegis/skills/skill_tailor_interactive.md` — Added **Phase 5 (DB Sync)**: after the cover letter is finalized, the agent reviews all edits made during Phases 3 and 3.5, identifies which ones represent standing wording preferences (verb/tone changes, bullet rewrites) rather than page-fit trims or cover-letter-only narrative, and proposes those changes for sync back to `master_career_db.yaml` using the same approve/edit/skip flow. Phase numbering updated; strict pause protocol updated to include Phase 5.
- `README.md` — Added **Supporting Information** section (subfolder table, usage examples) and **Examples** section (`aegis/examples/` folder guide). Updated How It Works to reflect 4-step workflow including `/aegis-score` and `/aegis-db-edit`. Directory structure diagram updated to include `Supporting_Information/`. PII removed from usage examples.
- `CHANGELOG.md` — Removed real company names from 0.2.0 examples list.
- `.gitignore` — Added `Supporting_Information/LinkedIn_Articles/`, `Supporting_Information/WhitePapers/`, and `Supporting_Information/Abstracts/` under a new labeled section; `Supporting_Information/README.md` remains tracked.

- `Supporting_Information/README.md` — Usage guide for the `Supporting_Information/` folder: describes each subfolder's purpose, expected file formats, and examples of how to reference material in skill invocations. Tracked in git; subfolder contents are gitignored.
- `aegis/skills/skill_document.md` — New skill for `/document`: identifies undocumented changes via `git diff`, updates `CHANGELOG.md` and `README.md`, runs a PII scan with a defined replacement table, and reports when docs are ready to commit. Does not commit or push.

### Changed (continued)
- `.claude/commands/document.md` — Rewired from missing `.agents/skills/document/SKILL.md` path to `aegis/skills/skill_document.md`; description updated.
- `aegis/templates/classic.typ` — ORCID rendered conditionally in the contact header; only appears when `orcid` is present and non-empty in `personal_info.contact`.
- `aegis/templates/resume.typ` — ORCID ID extracted from full URL and passed to the resume template; displayed in contact block when present.
- `aegis/skills/skill_tailor_interactive.md` — Phase 2 now includes an ORCID auto-include rule: when the JD is scientific (research, academia, pharma, biotech, materials, chemistry, physics, or similar), the agent includes the ORCID field in `tailored_resume.yaml`; otherwise the field is omitted entirely.
- `aegis/skills/skill_tailor_interactive.md` — Phase 3.5 fit-check logic replaced: overflow is no longer estimated as a percentage of page-2 word count. The agent now runs a YAML-aware paragraph analysis script that matches the last rendered line of each named field (`opening`, `career_summary`, `flagship_achievement`, each `pillar`, `education_closing`, `final_closing`) against the PDF using `pypdf` layout extraction, computes last-line fill percentage per field, and ranks candidates by `word_count / fill` — prioritizing large paragraphs with short orphaned last lines where each word removed costs the least semantic impact.

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
