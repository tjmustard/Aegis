// Read data file path from --input flag
#let data_file = sys.inputs.at("data_file", default: "cover_letter.yaml")
#let data = yaml(data_file)

#set document(
  title: "Cover Letter - " + data.meta.company + " - " + data.meta.job_title,
  author: data.candidate.name
)
#set page(margin: (x: 1in, y: 1in))
#set text(font: ("Linux Libertine", "Times New Roman"), size: 11pt)
#set par(leading: 0.75em, justify: true)

// Date
#align(left)[#data.meta.date]
#v(16pt)

// Salutation
#[#data.salutation]
#v(10pt)

// Opening paragraph
#[#data.paragraphs.opening]
#v(10pt)

// Career summary paragraph
#[#data.paragraphs.career_summary]
#v(10pt)

// Flagship achievement paragraph
#[#data.paragraphs.flagship_achievement]
#v(6pt)

// Technical pillars
#[My technical contributions to this role include:]
#v(4pt)
#for pillar in data.technical_pillars [
  #h(1em)#sym.bullet#h(0.4em)*#pillar.title:* #pillar.description
  #v(4pt)
]
#v(6pt)

// Education / closing paragraph
#[#data.paragraphs.education_closing]
#v(10pt)

// Final closing paragraph
#[#data.paragraphs.final_closing]
#v(24pt)

// Sign-off
#[#data.sign_off]
#v(6pt)
#[#data.candidate.name#if data.candidate.credentials != "" [, #data.candidate.credentials]]
