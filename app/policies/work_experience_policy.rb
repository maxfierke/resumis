class WorkExperiencePolicy < ResumePolicy
  class Scope < Scope
    def resolve
      if user.nil? || !user.current_tenant?
        scope.joins(:resumes).where(resumes: { published: true })
      else
        scope
      end
    end
  end
end
