// Read data file path from --input flag, fallback for local preview
#let data_file = sys.inputs.at("data_file", default: "tailored_resume.yaml")
#let data = yaml(data_file)

#set document(title: data.personal_info.name + " - Resume", author: data.personal_info.name)
#set page(margin: (x: 0.5in, y: 0.5in))
#set text(font: ("Linux Libertine", "Times New Roman"), size: 11pt)

// ── Header ──────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold")[#data.personal_info.name, #data.personal_info.credentials]\
  #v(2pt)
  #data.personal_info.contact.email | #data.personal_info.contact.phone | #data.personal_info.contact.location\
  #link(data.personal_info.contact.linkedin)[LinkedIn]
]

#v(8pt)
#line(length: 100%, stroke: 0.5pt)

// ── Professional Summary ─────────────────────────────────────────────────────
#text(size: 12pt, weight: "bold")[Summary]
#v(4pt)
#data.professional_summary
#v(6pt)
#line(length: 100%, stroke: 0.5pt)

// ── Professional Experience ───────────────────────────────────────────────────
#text(size: 12pt, weight: "bold")[Professional Experience]
#v(5pt)

#for job in data.professional_experience {
  let primary_role = job.roles.first()
  let oldest_role = job.roles.last()
  grid(
    columns: (1fr, auto),
    [#strong[#primary_role.title] | #emph[#job.company]],
    [#oldest_role.start_date -- #primary_role.end_date]
  )
  v(2pt)
  list(..job.atomic_achievements.map(ach => [#ach.bullet]))
  v(6pt)
}

#v(4pt)
#line(length: 100%, stroke: 0.5pt)

// ── Technical Skills ─────────────────────────────────────────────────────────
#text(size: 12pt, weight: "bold")[Technical Skills]
#v(5pt)

#for (category, skills) in data.skills_taxonomy {
  let label = category.replace("_", " ")
  [#strong[#label:] #skills.join(", ") \ ]
}

#v(4pt)
#line(length: 100%, stroke: 0.5pt)

// ── Education ────────────────────────────────────────────────────────────────
#text(size: 12pt, weight: "bold")[Education]
#v(5pt)

#for edu in data.education {
  [#strong[#edu.degree in #edu.field] | #edu.institution \ ]
  if edu.notes != "" {
    [#text(size: 10pt, style: "italic")[#edu.notes] \ ]
  }
  v(3pt)
}

// ── Selected Publications ─────────────────────────────────────────────────────
#if "publications" in data and data.publications.len() > 0 {
  v(4pt)
  line(length: 100%, stroke: 0.5pt)
  text(size: 12pt, weight: "bold")[Selected Publications]
  v(5pt)

  for pub in data.publications {
    [#text(size: 9pt)[#pub.citation] \ ]
    v(3pt)
  }
}
