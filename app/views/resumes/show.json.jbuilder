json.extract! @resume, :id, :name, :description, :background, :published, :created_at, :updated_at

json.user do
  json.id @resume.user.id
  json.first_name @resume.user.first_name
  json.last_name @resume.user.last_name
  json.full_name @resume.user.full_name
end

json.education_experiences @resume.education_experiences,
                           partial: 'education_experiences/education_experience',
                           as: :education_experience

json.work_experiences @resume.work_experiences,
                      partial: 'work_experiences/work_experience',
                      as: :work_experience

json.projects @resume.projects,
              partial: 'projects/project',
              as: :project
