# /// script
# requires-python = ">=3.11"
# dependencies = ["typst", "pyyaml"]
# ///

import argparse, subprocess, sys, re
from pathlib import Path

import yaml as pyyaml


def name_to_filename(name: str) -> str:
    """Convert '[Your Name]' -> '[Your_Name]'."""
    return re.sub(r"[^A-Za-z0-9]+", "_", name).strip("_")


def compile_pdf(template_name: str, app_dir: Path):
    yaml_file = app_dir / "tailored_resume.yaml"
    template_file = Path(__file__).parent / "templates" / f"{template_name}.typ"

    with open(yaml_file) as f:
        data = pyyaml.safe_load(f)
    name = name_to_filename(data["personal_info"]["name"])
    output_pdf = app_dir / f"{name}-Resume.pdf"

    if not yaml_file.exists() or not template_file.exists():
        print(f"ERROR: Missing {yaml_file.name} or template {template_file.name}.")
        sys.exit(1)

    print(f"Compiling {template_file.name} using data from {yaml_file}...")
    result = subprocess.run(
        ["typst", "compile", str(template_file), str(output_pdf),
         "--root", "/",
         "--input", f"data_file={yaml_file}"],
        capture_output=True, text=True
    )

    if result.returncode != 0:
        print("ERROR: Typst compilation failed.\n", result.stderr)
        sys.exit(1)
    print(f"SUCCESS: Resume generated at -> {output_pdf}")


def compile_cover_letter(template_name: str, app_dir: Path):
    yaml_file = app_dir / "cover_letter.yaml"
    template_file = Path(__file__).parent / "templates" / f"{template_name}.typ"

    with open(yaml_file) as f:
        data = pyyaml.safe_load(f)
    name = name_to_filename(data["candidate"]["name"])
    output_pdf = app_dir / f"{name}-Cover_Letter.pdf"

    if not yaml_file.exists() or not template_file.exists():
        print(f"ERROR: Missing {yaml_file.name} or template {template_file.name}.")
        sys.exit(1)

    print(f"Compiling {template_file.name} using data from {yaml_file}...")
    result = subprocess.run(
        ["typst", "compile", str(template_file), str(output_pdf),
         "--root", "/",
         "--input", f"data_file={yaml_file}"],
        capture_output=True, text=True
    )

    if result.returncode != 0:
        print("ERROR: Typst compilation failed.\n", result.stderr)
        sys.exit(1)
    print(f"SUCCESS: Cover letter generated at -> {output_pdf}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--app-dir", type=Path, required=True,
        help="Path to the application folder, e.g. Applications/2026.03.25_Acme_SeniorPM"
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    resume_parser = subparsers.add_parser("resume", help="Compile tailored resume to PDF")
    resume_parser.add_argument("--template", type=str, default="resume")

    cl_parser = subparsers.add_parser("cover-letter", help="Compile cover letter to PDF")
    cl_parser.add_argument("--template", type=str, default="coverletter2")

    args = parser.parse_args()
    app_dir = args.app_dir.resolve()

    if not app_dir.exists():
        print(f"ERROR: Application directory does not exist: {app_dir}")
        sys.exit(1)

    if args.command == "resume":
        compile_pdf(args.template, app_dir)
    elif args.command == "cover-letter":
        compile_cover_letter(args.template, app_dir)
