class WebhookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.current_tenant? && user.owns?(record)
  end

  def create?
    user.current_tenant?
  end

  def update?
    user.current_tenant? && user.owns?(record)
  end

  def destroy?
    update?
  end
end
