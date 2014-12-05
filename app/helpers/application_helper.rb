module ApplicationHelper

  def exists_published_resume?
    Resume.exists?(published: true)
  end

  # TODO: Support multi-tenancy
  def root_user
    User.find(1) rescue nil
  end

  def path_to_latest_resume
    latest_resume = Resume.where(published: true).order(updated_at: :desc).first

    return resume_path(latest_resume)
  end
end
