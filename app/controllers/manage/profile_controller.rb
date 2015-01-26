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
          format.html { redirect_to profile_path, notice: 'Your profile was successfully updated.' }
          format.json { render :show, status: :ok, location: profile_path }
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
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :tagline, :header_image, :avatar_image,
                             :header_video, :header_media_type,
                             :about_me, :github_handle, :googleplus_handle, :linkedin_handle,
                             :soundcloud_handle, :tumblr_url, :twitter_handle, :vimeo_handle,
                             :youtube_handle, :avatar_label, type_ids: [])
      end
  end
end