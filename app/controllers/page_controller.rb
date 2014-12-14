class PageController < ApplicationController
  layout "application_public"
  def about
  end

  def bare_domain
    @users = User.all
    render :layout => 'bare',
           :template => 'errors/bare_domain'
  end
end
