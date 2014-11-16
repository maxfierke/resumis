json.array!(@work_experiences) do |work_experience|
  json.extract! work_experience, :id, :organization, :description, :start_date, :end_date
  json.url work_experience_url(work_experience, format: :json)
end
