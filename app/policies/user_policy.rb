class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user.admin? || user == record
  end
end
