class ResumesController < ApplicationController
  layout "resume", only: [:show]

  def show
    @resume = policy_scope(Resume).find(params[:id])
    authorize @resume
    @skills_by_cat = SkillCategory.with_skills

    if stale?(@resume, public: true)
      respond_to do |format|
        format.html
        format.md
        format.pdf do
          render pdf:           @resume.name,
                 layout:        'resume.pdf.erb',
                 template:      'resumes/show.html.erb',
                 page_size:     'Letter',
                 show_as_html:   params.key?('debug') && Rails.env.development?,
                 disable_external_links: false,
                 print_media_type: false
        end
      end
    end
  end
end
