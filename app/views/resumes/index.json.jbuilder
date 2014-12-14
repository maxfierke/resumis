json.array!(@resumes) do |resume|
  json.extract! resume, :id, :name, :description, :published
  json.user resume.user
  json.url resume_url(resume, subdomain: resume.user.subdomain, format: :json)
end
