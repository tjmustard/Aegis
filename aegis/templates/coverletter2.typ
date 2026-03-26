#import "@preview/modern-cv:0.9.0": *

#let data_file = sys.inputs.at("data_file", default: "cover_letter.yaml")
#let data = yaml(data_file)

// Tighter paragraph spacing (library default is 1em top + 1em bottom)
#let coverletter-content(content) = {
  pad(top: 0.2em, bottom: 0.2em)[
    #set par(first-line-indent: 0em)
    #set text(weight: "light")
    #content
  ]
}

// Normalize YAML block-literal strings: collapse newlines to spaces so text reflows
#let p(s) = [#s.replace("\n", " ").trim()]

// Parse name
#let name_parts = data.candidate.name.split(" ")
#let firstname = name_parts.slice(0, name_parts.len() - 1).join(" ")
#let lastname = name_parts.last()
#let linkedin_handle = if "linkedin" in data.candidate { data.candidate.linkedin } else { "" }

// Extract addressee from salutation
#let addressee = data.salutation.trim("Dear ", at: start).trim(",", at: end).trim()

// Reduce 32pt name to 20pt so full name fits on one line, and override grid row
// so the header doesn't reserve dead space for the absent profile picture
#show text.where(size: 32pt): set text(size: 20pt)
#show grid: it => {
  if it.columns == (1fr, 2fr) {
    grid(columns: (0fr, 1fr), rows: (auto,), ..it.children)
  } else {
    it
  }
}

#show: coverletter.with(
  author: (
    firstname: firstname,
    lastname: lastname + ", " + data.candidate.credentials,
    email: data.candidate.email,
    phone: data.candidate.phone,
    linkedin: linkedin_handle,
    positions: (data.meta.job_title,),
  ),
  profile-picture: none,
  language: "en",
  show-footer: false,
  closing: [],
  paper-size: "us-letter",
  description: "Cover Letter - " + data.meta.company + " - " + data.meta.job_title,
  keywords: data.meta.company,
)

#letter-heading(
  job-position: data.meta.job_title,
  addressee: addressee,
)

#coverletter-content[#p(data.paragraphs.opening)]

#coverletter-content[#p(data.paragraphs.career_summary)]

#coverletter-content[#p(data.paragraphs.flagship_achievement)]

#coverletter-content[
  My technical contributions to this role include:
  #v(4pt)
  #for pillar in data.technical_pillars [
    #h(1em)#sym.bullet#h(0.4em)*#pillar.title:* #p(pillar.description)
    #v(3pt)
  ]
]

#if data.paragraphs.education_closing != "" {
  coverletter-content[#p(data.paragraphs.education_closing)]
}

#coverletter-content[#p(data.paragraphs.final_closing)]
