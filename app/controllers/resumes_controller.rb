class ResumesController < ApplicationController
  before_action :set_resume, only: [:show]

  layout "resume", only: [:show]
  respond_to :html, :json

  def show
    # Only allow viewing of published resumes, or resumes a user owns
    if not @resume.published and (!user_signed_in? or current_user.id != @resume.user.id)
      return head :forbidden
    end

    @skills_by_cat = SkillCategory.with_skills

    if stale?(@resume, public: true)
      respond_to do |format|
        format.html
        format.json
        format.md
        format.pdf do
          render pdf:           @resume.name,
                 layout:        'resume.pdf.erb',
                 template:      'resumes/show.html.erb',
                 page_size:     'Letter',
                 show_as_html:   params.key?('debug'),
                 print_media_type: false
        end
      end
    end
  end

  private
    def set_resume
      @resume = Resume.find(params[:id])
    end
end
