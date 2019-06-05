module Manage
  class UsersController < ManageController
    before_action :set_user, except: [:index]

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
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} successfully destroyed." }
      end
    end

    def unlock
      @user.update!(locked_at: nil, failed_attempts: 0)

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} was unlocked successfully." }
      end
    end

    def disable
      user_disabler = UserDisabler.new(@user)
      user_disabler.disable!

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} was disabled successfully." }
      end
    end

    def enable
      @user.update!(disabled_at: nil, locked_at: nil, failed_attempts: 0)

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: "#{@user.full_name} was enabled successfully." }
      end
    end

    private
      def set_user
        @user = policy_scope(User).find(params[:id])
        authorize @user
      end

      def user_params
        @user_params ||= begin
          permitted = params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :subdomain,
            :domain
          )

          if permitted[:password].blank?
            permitted.extract!(:password, :password_confirmation)
          end

          permitted
        end
      end
  end
end
