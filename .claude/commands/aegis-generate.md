Build the resume and cover letter PDFs for an application folder.

Arguments: `$ARGUMENTS`

Parse the arguments as follows:
- First positional arg (required): the application folder path or slug, e.g. `Applications/2026.03.25_Acme_SeniorPM` or just the slug `2026.03.25_Acme_SeniorPM`
- `--resume-template <name>` (optional, default `resume`): Typst template for the resume
- `--cover-letter-template <name>` (optional, default `coverletter2`): Typst template for the cover letter
- `--only resume` or `--only cover-letter` (optional): build only one output

If the path doesn't start with `Applications/`, prepend it automatically.

Run:
```
python3 aegis/build-all.py --app-dir <resolved-path> [--resume-template <name>] [--cover-letter-template <name>] [--only <value>]
```

Report the paths of the generated PDFs on success.
