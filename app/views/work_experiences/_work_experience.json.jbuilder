json.extract! work_experience, :id, :organization, :description, :start_date, :end_date, :created_at, :updated_at
json.url work_experience_path(work_experience, format: :json)
