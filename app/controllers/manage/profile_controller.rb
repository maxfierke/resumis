module Manage
  class ProfileController < ManageController
    before_action :set_user, only: [:edit, :update]

    # GET /profile/edit
    def edit
    end

    # PATCH/PUT /profile
    # PATCH/PUT /profile.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to manage_dashboard_path, notice: 'Your profile was successfully updated.' }
          format.json { render :show, status: :ok, location: manage_dashboard_path }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = current_tenant
        authorize @user
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :tagline, :about_me,
          :header_image, :avatar_image,
          :medium_handle, :github_handle, :googleplus_handle,
          :linkedin_handle, :tumblr_url, :twitter_handle,
          :avatar_label, :ga_property_id, :ga_view_id
        )
      end
  end
end
