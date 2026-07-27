# Writing Style Guide

All skills (cover letter, resume tailoring, DB edits, etc.) must follow these conventions when
generating written content.

## Punctuation

- **No em-dashes (`—`).** Replace with a comma and space (`, `) wherever an em-dash would otherwise appear.
  - Wrong: `I know your platform — not just as an admirer but as a partner.`
  - Right: `I know your platform, not just as an admirer but as a partner.`

## General Tone

- Professional but direct. Confident without being boastful.
- First-person, active voice preferred.
- Avoid filler phrases and corporate jargon.

## De-slop (AI writing patterns)

The canonical ruleset for removing AI writing tells lives in the vendored **stop-slop** skill:

- `aegis/skills/stop-slop/SKILL.md`, core rules and the scoring rubric
- `aegis/skills/stop-slop/references/phrases.md`, banned phrases (throat-clearing, adverbs, jargon, vague declaratives)
- `aegis/skills/stop-slop/references/structures.md`, banned structures (binary contrasts, false agency, passive voice, Wh- openers)
- `aegis/skills/stop-slop/references/examples.md`, before/after transformations

Read those files when you need depth. For most generation, run this condensed **Quick-Check gate**
over any prose before emitting it, and do not output prose that fails it:

- Any adverbs (`-ly`, `really`, `just`, `simply`, `actually`, `deeply`)? Cut them.
- Any passive voice? Name the actor and put them at the front.
- Any inanimate thing doing a human verb ("the data tells us", "the decision emerges")? Name the person.
- Sentence starts with a Wh- word (What/When/Why/How)? Restructure to lead with the subject or verb.
- Any "here's what/this/that" throat-clearing opener? Cut to the point.
- Any "not X, it's Y" / "isn't X, it's Y" binary contrast? State Y directly.
- Any em-dash? Remove it (see Punctuation above).
- Any vague declarative ("The implications are significant", "The reasons are structural")? Name the specific thing.
- Any business jargon (navigate, unpack, lean into, deep dive, game-changer, circle back)? Use plain language.

### Reconciliation: format conventions win

Where a de-slop rule conflicts with resume or cover-letter **format conventions**, the format
convention wins. Do not let a general prose rule break the document's structure:

- **Parallel, verb-led bullets** stay parallel. Resume bullets lead with a strong action verb; the
  passive-voice "name the actor with you" fix does not apply to them.
- **First-person candidate voice** stays. The stop-slop "you beats people / put the reader in the
  room" rule is for essays, not a cover letter written from the candidate's perspective.
- **The 2-3 technical-pillars pattern** stays. The stop-slop "two beats three" rhythm rule does not
  override a cover letter's deliberate 2-3 pillar block.

## Attribution

The vendored `aegis/skills/stop-slop/` skill is MIT-licensed, authored by Hardik Pandya
(hvpandya.com). See `aegis/skills/stop-slop/LICENSE`.
