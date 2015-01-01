json.array!(@projects) do |project|
  json.extract! project, :id, :name, :short_description, :description, :start_date, :end_date, :project_status_id, :github_url, :vimeo_url, :youtube_url, :soundcloud_url, :basecamp_url, :penflip_url
  json.url project_url(project, format: :json)
end
