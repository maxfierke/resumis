json.array!(@resumes) do |resume|
  json.extract! resume, :id, :user_id, :name, :description, :published
  json.url resume_url(resume, format: :json)
end
