json.array!(@skills) do |skill|
  json.extract! skill, :id, :name, :skill_category_id, :user_id
  json.url skill_url(skill, format: :json)
end
