class EducationExperiencePolicy < ResumePolicy
  class Scope < Scope
    def resolve
      if user.nil? || !user.current_tenant?
        scope.where(user: user.current_tenant).joins(:resumes).where(resumes: { published: true })
      else
        scope.where(user: user.user)
      end
    end
  end
end
