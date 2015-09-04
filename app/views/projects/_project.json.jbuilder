json.extract! project, :id, :name, :short_description, :start_date, :end_date, :created_at, :updated_at

json.description project.description
json.description_html markdown(project.description)
json.date_range project.date_range

json.vimeo_url project.vimeo_url if project.vimeo_url
json.youtube_url project.youtube_url if project.youtube_url
json.soundcloud_url project.soundcloud_url if project.soundcloud_url

json.status do
  json.id project.project_status.id
  json.slug project.project_status.slug
  json.name project.project_status.name
  json.created_at project.project_status.created_at
  json.updated_at project.project_status.updated_at
end

json.categories(project.project_categories) do |cat|
  json.id cat.id
  json.slug cat.slug
  json.name cat.name
  json.created_at cat.created_at
  json.updated_at cat.updated_at
end

# TODO: This looks awful. Find a better way to do this.
json.links (project.links << { rel: 'self', href: project_url(project, host: tenant_instance_hostname(project.user)) })
