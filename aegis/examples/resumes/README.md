# Resume Examples

This folder holds example resume files used as visual references when designing or replicating a resume template with the `/aegis-render` skill.

## What belongs here

- `<Name>-Resume.pdf` — A rendered resume PDF to use as a design target
- `<Name>-Resume.docx` — Optional Word version for format reference

These files are gitignored (personal data).

## Purpose

The `/aegis-render` skill reads a PDF or image from this folder and replicates its visual design as a Typst template. Place the resume you want to replicate here, then run:

```
/aegis-render aegis/examples/resumes/<your-resume>.pdf
```

The resulting `.typ` template will be written to `aegis/templates/`.
