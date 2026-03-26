# /// script
# requires-python = ">=3.11"
# dependencies = ["pyyaml"]
# ///

"""Build both resume and cover letter PDFs for an application folder."""

import argparse, subprocess, sys
from pathlib import Path


def run_build(command: str, app_dir: Path, template: str):
    result = subprocess.run(
        [sys.executable, str(Path(__file__).parent / "build.py"),
         "--app-dir", str(app_dir),
         command,
         "--template", template],
        capture_output=False,
    )
    if result.returncode != 0:
        print(f"ERROR: '{command}' build failed.")
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Build resume and cover letter PDFs for an application folder."
    )
    parser.add_argument(
        "--app-dir", type=Path, required=True,
        help="Path to the application folder, e.g. Applications/2026.03.25_Acme_SeniorPM"
    )
    parser.add_argument(
        "--resume-template", type=str, default="resume",
        help="Typst template for the resume (default: resume)"
    )
    parser.add_argument(
        "--cover-letter-template", type=str, default="coverletter2",
        help="Typst template for the cover letter (default: coverletter2)"
    )
    parser.add_argument(
        "--only", choices=["resume", "cover-letter"],
        help="Build only one output instead of both"
    )

    args = parser.parse_args()
    app_dir = args.app_dir.resolve()

    if not app_dir.exists():
        print(f"ERROR: Application directory does not exist: {app_dir}")
        sys.exit(1)

    if args.only == "resume":
        run_build("resume", app_dir, args.resume_template)
    elif args.only == "cover-letter":
        run_build("cover-letter", app_dir, args.cover_letter_template)
    else:
        run_build("resume", app_dir, args.resume_template)
        run_build("cover-letter", app_dir, args.cover_letter_template)
