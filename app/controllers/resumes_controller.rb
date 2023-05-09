class ResumesController < ApplicationController
  layout "resume", only: [:show]

  def show
    @resume = policy_scope(Resume).includes(
      :education_experiences,
      :work_experiences,
      :projects,
      skills: [:skill_category]
    ).find(params[:id])
    authorize @resume

    @skills_by_cat = @resume.skills.group_by { |skill| skill.skill_category }

    if stale?(@resume, public: true)
      respond_to do |format|
        format.html
        format.md
        format.pdf do
          @inline_assets = true

          render pdf:           @resume.name,
                 layout:        'resume',
                 template:      'resumes/show',
                 formats: [:html],
                 page_size:     'Letter',
                 show_as_html:   params.key?('debug') && Rails.env.development?,
                 disable_external_links: false,
                 print_media_type: false
        end
      end
    end
  end
end
