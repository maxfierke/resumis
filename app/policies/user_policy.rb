class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    true
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end

  def lock?
    user.admin?
  end

  def unlock?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user && user.admin?
        scope
      else
        scope.where(id: record.id)
      end
    end
  end
end
