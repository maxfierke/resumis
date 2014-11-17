json.array!(@education_experiences) do |education_experience|
  json.extract! education_experience, :id, :school_name, :diploma, :description, :start_date, :end_date
  json.url education_experience_url(education_experience, format: :json)
end
