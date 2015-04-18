class ProfileController < ApplicationController
  before_action :set_user, only: [:show]

  layout "public", only: [:show]

  # GET /profile
  # GET /profile.json
  def show
    @skills_by_cat = SkillCategory.with_skills
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_tenant
    end
end
