json.id work_experience.id
json.company work_experience.organization
json.position work_experience.position
# TODO: Support employer website in work experience
json.website nil
json.start_date work_experience.start_date
json.end_date work_experience.end_date
json.summary work_experience.description
# TODO: Support highlights for work experience
json.highlights []

json.links [
  { rel: 'self', href: work_experience_url(work_experience, host: tenant_instance_hostname(work_experience.user)) }
]
