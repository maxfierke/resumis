json.extract! project, :id, :name, :short_description, :description, :start_date, :end_date, :github_url, :created_at, :updated_at
json.url project_path(project, format: :json)
json.status project.project_status
