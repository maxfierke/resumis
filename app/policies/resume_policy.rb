class ResumePolicy < ApplicationPolicy
  def index?
    if user.api_user?
      api_is_readable?
    else
      true
    end
  end

  def show?
    record_exists = super

    if user.api_user?
      record_exists && api_is_readable?
    else
      record_exists
    end
  end

  def create?
    if user.api_user?
      user.owns?(record) && api_is_writable?
    else
      user.owns?(record)
    end
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user.nil? || !user.current_tenant?
        scope.where(published: true)
      else
        scope
      end
    end
  end

  private def api_is_writable?
    user.has_oauth_scope?(:resumes_write)
  end

  private def api_is_readable?
    user.has_oauth_scope?(:public) || api_is_writable?
  end
end
