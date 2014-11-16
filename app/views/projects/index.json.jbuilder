json.array!(@projects) do |project|
  json.extract! project, :id, :name, :short_description, :description, :start_date, :end_date, :project_status_id
  json.url project_url(project, format: :json)
end
