json.extract! project, :id, :name, :short_description, :description, :start_date, :end_date, :created_at, :updated_at
json.url project_path(project, format: :json)
json.status project.project_status
