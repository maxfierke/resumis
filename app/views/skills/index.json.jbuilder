json.array!(@skills) do |skill|
  json.extract! skill, :id, :name, :SkillCategory_id, :User_id
  json.url skill_url(skill, format: :json)
end
