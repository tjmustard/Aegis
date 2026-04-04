# Supporting Information

This folder holds personal reference documents that Claude can read when generating cover
letters, resume bullets, and other content. The subfolders are gitignored — drop your own
files in and they stay local.

---

## Subfolders

### `LinkedIn_Articles/`
Markdown exports of your LinkedIn articles and thought leadership posts.

Claude reads these to match your writing voice, borrow strong phrasing, and reference
published work when drafting cover letters or summaries.

**Format:** One `.md` file per article. Filename should be descriptive (e.g., `article-title-slug.md`).

**Example content:**
```
# Article Title

[Article body...]
```

---

### `WhitePapers/`
Technical white papers, application notes, and product briefs you authored or co-authored.

Useful for establishing domain credibility in cover letters and for populating
`atomic_achievements` in the career DB when running `/aegis-score` or `/aegis-db-edit`.

**Format:** PDF or Markdown. Include the document title and your role (author, co-author,
contributor) in the filename when possible (e.g., `product-name-application-note_lead-author.pdf`).

---

### `Abstracts/`
Conference abstracts, poster abstracts, and program book entries.

Claude uses these to surface presentation and publication history that may not be fully
captured in `master_career_db.yaml`, particularly for scientific or research-focused roles.

**Format:** PDF or Markdown. Name files by conference and year
(e.g., `CONF2025_topic_oral-abstract.pdf`).

---

## How These Files Are Used

Skills that explicitly reference supporting material will read from this folder. You can
also point Claude here manually:

```
/aegis-tailor path/to/jd.md
> "Also check Supporting_Information/LinkedIn_Articles/article-title-slug.md for voice reference."
```

Or use `/aegis-db-edit` to propose new achievements derived from a white paper or abstract:

```
/aegis-db-edit derive new achievements from Supporting_Information/WhitePapers/product-name-application-note.pdf
```
