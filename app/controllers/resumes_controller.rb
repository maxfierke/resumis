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
      end
    end
  end
end
