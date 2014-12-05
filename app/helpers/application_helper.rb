module ApplicationHelper
  # TODO: Support multi-tenancy
  def root_user
    User.find(1) rescue nil
  end
end
