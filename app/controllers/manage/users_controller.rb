module Manage
  class UsersController < ManageController
    before_action :set_user, only: [:edit, :update, :destroy, :lock, :unlock]

    def index
      @users = policy_scope(User).page params[:page]
    end

    def edit
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to manage_users_path, notice: "#{@user.full_name} successfully updated." }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @user.destroy!

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} successfully updated." }
      end
    end

    def lock
      user_disabler = UserDisabler.new(@user)
      user_disabler.disable!

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} was locked successfully." }
      end
    end

    def unlock
      @user.update!(locked_at: nil, failed_attempts: 0)

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} was unlocked successfully." }
      end
    end

    private
      def set_user
        @user = policy_scope(User).find(params[:id])
        authorize @user
      end

      def user_params
        params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation,
          :subdomain,
          :domain
        )
      end
  end
end
