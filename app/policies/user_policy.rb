class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || !record.disabled_at
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end

  def unlock?
    user.admin?
  end

  def enable?
    user.admin?
  end

  def disable?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.nil?
        scope.enabled.where(id: user.current_tenant.id)
      elsif user.admin?
        scope
      else
        scope.enabled.where(id: user.user.id)
      end
    end
  end
end
