# PRODUCT REQUIREMENTS DOCUMENT: Project Aegis
**Target Agent:** `claude-code`
**Objective:** Populate the local directory structure with the exact scripts, templates, and skill prompts defined below. Do not alter the code or prompt logic.

## 1. /skills/skill_ingest_master.md
Populate with the following text:
<content>
# MISSION
You are a strict data-extraction agent. Your objective is to parse the user's provided flat Markdown resume and map it EXACTLY to the `master_career_db.yaml` schema.

# RULES OF ENGAGEMENT
1. **Zero Hallucination Tolerance:** You may not invent dates, metrics, skills, or job responsibilities. 
2. **Atomic Deconstruction:** Break down paragraph-based experience into singular, atomic bullet points.
3. **Metric Extraction:** Isolate hard numbers into the `impact_metrics` array. If none, leave empty `[]`.
4. **Skill Tagging:** Extract specific tools/methodologies used per bullet into the `skills_applied` array.
5. **Missing Context:** If business context is missing, insert `[REQUIRES USER INPUT]` in the `context` field.
6. **Tight Bullet, Rich Detail:** Keep `bullet` to one concise, resume-ready statement; push supporting specifics (named artifacts, sub-projects, extended metrics, real internal figures) into the optional per-achievement `detail` field. `detail` is a private reservoir pulled from during tailoring, never emitted verbatim to a resume. Genericize sensitive figures in the bullet; retain them in `detail`.

# EXECUTION STEPS
1. Read the provided `master_resume.md`.
2. Map the data to the YAML schema.
3. Output the raw YAML. Do not include conversational filler.
4. List any fields marked `[REQUIRES USER INPUT]` and ask the user to provide context.
</content>

## 2. /skills/skill_tailor_interactive.md
Populate with the following text:
<content>
# MISSION
You are an expert ATS optimization agent. Your objective is to tailor `master_career_db.yaml` to align with a provided Job Description (JD) via a strict State Machine.

# STRICT PAUSE PROTOCOL
You MUST stop generation and explicitly type `[WAITING FOR USER APPROVAL]` at the end of Phases 1, 2, and 3. Do NOT proceed until the user explicitly types "Approved".

# EXECUTION PHASES
## PHASE 1: JD Deconstruction & Strategy
1. Analyze JD. Extract core requirements. Output Target Profile.
2. STOP. Output `[WAITING FOR USER APPROVAL]`.

## PHASE 2: Section-by-Section Node Selection
1. **Experience:** Propose jobs and specific `atomic_achievements`. Justify selections based on JD.
2. **Skills/Projects/Education:** Propose filtered lists.
3. STOP. Output `[WAITING FOR USER APPROVAL]`.

## PHASE 3: Cover Letter Drafting
1. Draft a concise Markdown Cover Letter anchored around 1-2 selected achievements.
2. STOP. Output `[WAITING FOR USER APPROVAL]`.

## PHASE 4: Final Compilation
1. Compile selected nodes into `tailored_resume.yaml`.
2. Output Cover Letter to `cover_letter.md`.
</content>

## 3. /skills/skill_replicate_template.md
Populate with the following text:
<content>
# MISSION
Analyze a user-provided image/PDF of a resume and construct a reusable Typst template (`.typ`) mimicking its design.

# RULES
1. Natively parse `tailored_resume.yaml`. Do not hardcode text.
2. Initial output is a draft. Save to `/templates/[name].typ`.
3. Wait for the user to compile and report visual discrepancies for iterative debugging.
</content>

## 4. /templates/classic.typ
Populate with the following code:
<content>
#let resume(data_file: "tailored_resume.yaml") = {
  let data = yaml(data_file)
  set document(title: data.personal_info.name + " - Resume", author: data.personal_info.name)
  set page(margin: (x: 0.5in, y: 0.5in))
  set text(font: ("Times New Roman", "Linux Libertine"), size: 11pt)

  align(center)[
    #text(size: 16pt, weight: "bold")[#data.personal_info.name]\
    #v(2pt)
    #data.personal_info.contact.email | #data.personal_info.contact.phone | #data.personal_info.contact.location\
    #link(data.personal_info.contact.linkedin)[LinkedIn] | #link(data.personal_info.contact.github)[GitHub]
  ]
  #v(10pt)
  #line(length: 100%, stroke: 0.5pt)
  
  #text(size: 12pt, weight: "bold")[Professional Experience]
  #v(5pt)
  #for job in data.professional_experience [
    #grid(
      columns: (1fr, auto),
      [#text(weight: "bold")[#job.role] at #job.company],
      [#job.start_date -- #job.end_date]
    )
    #v(2pt)
    #list(..job.atomic_achievements.map(ach => ach.bullet))
    #v(5pt)
  ]
  
  #v(5pt)
  #line(length: 100%, stroke: 0.5pt)
  #text(size: 12pt, weight: "bold")[Technical Skills]
  #v(5pt)
  *Languages:* #data.skills_taxonomy.languages.join(", ") \
  *Frameworks:* #data.skills_taxonomy.frameworks.join(", ")
}
#show: resume.with(data_file: "../tailored_resume.yaml")
</content>

## 5. build.py
Populate with the following code:
<content>
# /// script
# requires-python = ">=3.11"
# dependencies = ["typst", "pyyaml"]
# ///

import argparse, subprocess, sys
from pathlib import Path

def compile_pdf(template_name: str):
    base_dir = Path(__file__).parent
    yaml_file = base_dir / "tailored_resume.yaml"
    template_file = base_dir / "templates" / f"{template_name}.typ"
    output_pdf = base_dir / f"Resume_{template_name}_Tailored.pdf"

    if not yaml_file.exists() or not template_file.exists():
        print("ERROR: Missing YAML data or Typst template.")
        sys.exit(1)

    print(f"Compiling {template_file.name} using data from {yaml_file.name}...")
    result = subprocess.run(["typst", "compile", str(template_file), str(output_pdf)], capture_output=True, text=True)

    if result.returncode != 0:
        print("ERROR: Typst compilation failed.\n", result.stderr)
        sys.exit(1)
    print(f"SUCCESS: Resume generated at -> {output_pdf}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--template", type=str, default="classic")
    args = parser.parse_args()
    compile_pdf(args.template)
</content>
