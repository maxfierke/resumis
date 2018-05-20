class PolicyUser
  attr_reader :user

  def initialize(user, current_tenant, doorkeeper_token: nil)
    @user = user
    @current_tenant = current_tenant
    @doorkeeper_token = doorkeeper_token
  end

  def admin?
    user && user.admin?
  end

  def api_user?
    doorkeeper_token.present?
  end

  def current_tenant?
    user == current_tenant
  end

  def nil?
    user.nil?
  end

  def has_oauth_scope?(scope)
    api_user? && oauth_scopes.include?(scope.to_sym)
  end

  def owns?(model)
    user == model.user
  end

  def oauth_scopes
    @oauth_scopes ||= if doorkeeper_token.present? && doorkeeper_token.scopes.present?
      doorkeeper_token.scopes.map { |scope| scope.to_sym }
    else
      [:public]
    end
  end

  def ==(other_user)
    case other_user
    when PolicyUser
      user == other_user.user
    when User
      user == other_user
    else
      super
    end
  end

  private

  attr_reader :current_tenant, :doorkeeper_token
end