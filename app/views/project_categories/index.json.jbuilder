json.array!(@project_categories) do |project_category|
  json.extract! project_category, :id, :slug, :name
  json.url project_category_url(project_category, format: :json)
end
