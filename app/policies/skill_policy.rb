class SkillPolicy < ResumePolicy
  def index?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
