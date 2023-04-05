class SkillCategoryPolicy < ResumePolicy
  def index?
    true
  end

  class Scope < Scope
    def resolve
      if user.nil? || !user.current_tenant?
        scope.where(user: user.current_tenant)
      else
        scope.where(user: user.user)
      end
    end
  end
end
