class UserDisabler
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def disable!
    ActiveRecord::Base.transaction do
      revoked_at = DateTime.current
      user.update!(locked_at: revoked_at)
      revoke_grants(revoked_at)
      revoke_tokens(revoked_at)
    end
  end

  private

  def revoke_grants(revoked_at)
    user.oauth_access_grants.
      where(revoked_at: nil).
      update_all(revoked_at: revoked_at)
  end

  def revoke_tokens(revoked_at)
    user.oauth_access_tokens.
      where(revoked_at: nil).
      update_all(revoked_at: revoked_at)
  end
end
