#import "@preview/modern-cv:0.9.0": *

#let data_file = sys.inputs.at("data_file", default: "tailored_resume.yaml")
#let data = yaml(data_file)

// Parse name into first / last
#let name_parts = data.personal_info.name.split(" ")
#let firstname = name_parts.slice(0, name_parts.len() - 1).join(" ")
#let lastname = name_parts.last()

// Extract LinkedIn handle from full URL
#let linkedin_handle = data.personal_info.contact.linkedin.split("/").filter(x => x != "").last()

// Build custom contact items
#let custom_items = ((text: data.personal_info.contact.location, icon: "location-dot"),)

// Extract ORCID ID from full URL if present
#let orcid_id = if "orcid" in data.personal_info.contact and data.personal_info.contact.orcid != "" {
  data.personal_info.contact.orcid.split("/").filter(x => x != "").last()
} else { none }

#show: resume.with(
  author: (
    firstname: firstname,
    lastname: lastname + ", " + data.personal_info.credentials,
    email: data.personal_info.contact.email,
    phone: data.personal_info.contact.phone,
    linkedin: linkedin_handle,
    orcid: orcid_id,
    positions: (data.professional_experience.first().roles.first().title,),
    custom: custom_items,
  ),
  profile-picture: none,
  date: datetime.today().display(),
  language: "en",
  colored-headers: true,
  show-footer: false,
  paper-size: "us-letter",
)

= Summary

#data.professional_summary.replace("\n", " ").trim()

= Experience

#for job in data.professional_experience {
  let primary_role = job.roles.first()
  let oldest_role = job.roles.last()
  let display = if "display_title" in primary_role { primary_role.display_title } else { primary_role.title }
  resume-entry(
    title: display,
    location: "",
    date: oldest_role.start_date + " -- " + primary_role.end_date,
    description: job.company,
  )
  resume-item[
    #for ach in job.atomic_achievements [
      - #ach.bullet
    ]
  ]
}

= Skills

#for (category, skills) in data.skills_taxonomy {
  resume-skill-item(category.replace("_", " "), skills)
}
#block(below: 0.65em)

= Education

#for edu in data.education {
  resume-entry(
    title: edu.institution,
    location: "",
    date: edu.year,
    description: edu.degree + " in " + edu.field,
  )
  if edu.notes != "" {
    resume-item[
      - #edu.notes
    ]
  }
}

#if "patents" in data and data.patents.len() > 0 [
  = Patents / Inventions

  #for pat in data.patents [
    #text(size: 9pt)[#pat.title. #pat.status.]
    #v(3pt)
  ]
]

#if "publications" in data and data.publications.len() > 0 [
  = Selected Publications

  #for pub in data.publications [
    #text(size: 9pt)[#pub.citation]
    #v(3pt)
  ]
]
