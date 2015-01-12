json.extract! project, :id, :name, :short_description, :start_date, :end_date, :created_at, :updated_at

json.description project.description
json.description_html markdown(project.description)

json.status do
  json.id project.project_status.id
  json.slug project.project_status.slug
  json.name project.project_status.name
  json.created_at project.project_status.created_at
  json.updated_at project.project_status.updated_at
end

# TODO: This looks awful. Find a better way to do this.
json.links (project.links << { rel: 'self', href: project_url(project, host: tenant_instance_hostname(project.user)) })
