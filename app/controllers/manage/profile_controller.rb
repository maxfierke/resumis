module Manage
  class ProfileController < ManageController
    before_action :set_user, only: [:edit, :update]

    def edit
    end

    def update
      respond_to do |format|
        @user.assign_attributes(user_params)
        if @user.valid?
          ActiveRecord::Base.transaction do
            @user.save!
            attach_images!
          end

          ProfileImageVariantGeneratorJob.perform_later(@user.id)

          format.html { redirect_to manage_dashboard_path, notice: 'Your profile was successfully updated.' }
          format.json { render :show, status: :ok, location: manage_dashboard_path }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      def attach_images!
        @user.avatar_image.attach(params[:avatar_image]) if params[:avatar_image]
        @user.header_image.attach(params[:header_image]) if params[:header_image]
      end

      def set_user
        @user = current_tenant
        authorize @user
      end

      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :tagline, :about_me,
          :header_image, :avatar_image, :avatar_label,
          :homepage_url, :blog_url,
          social_links_attributes: [
            :id,
            :network,
            :username,
            :url,
            :_destroy
          ]
        )
      end
  end
end
