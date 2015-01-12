json.meta do
  json.id @resume.id
  json.name @resume.name
  json.published @resume.published
  json.created_at @resume.created_at
  json.updated_at @resume.updated_at
end

json.basics do
  json.name @resume.user.full_name
  json.label @resume.user.tagline
  json.picture @resume.user.gravatar_url
  json.email @resume.user.email
  json.phone nil
  json.website "#{request.protocol}#{tenant_instance_hostname(current_tenant)}"
  json.summary @resume.background
  # TODO: Add location support
  json.location do
    json.address nil
    json.postal_code nil
    json.city nil
    json.country_code nil
    json.region nil
  end
  json.profiles @resume.user.social_networks do |sn|
    json.network sn[:network]
    json.username sn[:username]
    json.url sn[:url]
  end
end

json.skills SkillCategory.all do |sc|
  json.name sc.name
  # TODO: Support skill levels
  json.level nil
  json.keywords sc.skills.pluck(:name)
end

json.education @resume.education_experiences,
               partial: 'education_experiences/education_experience',
               as: :education_experience

json.work @resume.work_experiences,
          partial: 'work_experiences/work_experience',
          as: :work_experience

json.projects @resume.projects,
              partial: 'projects/project',
              as: :project

# TODO: Implement these
json.volunteer []
json.awards []
json.publications []
json.languages []
json.interests []
json.references []
