json.extract! @user, :id, :first_name, :last_name, :tagline, :header_image_url,
                     :gravatar_url, :created_at, :updated_at

json.about_me @user.about_me
json.about_me_html markdown(@user.about_me)

json.social @user.social_networks

json.links [
  { rel: 'latest_resume', href: latest_resume ? resume_url(latest_resume, host: tenant_instance_hostname(@user)) : nil },
  { rel: 'projects', href: projects_url(host: tenant_instance_hostname(@user)) }
]
