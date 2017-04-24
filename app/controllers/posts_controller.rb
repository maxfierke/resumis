class PostsController < ApplicationController
  layout "blog", only: [:index, :show]

  def index
    @posts = Post.order(id: :desc).where(published: true)

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @post = Post.find(params[:id])

    if !@post.published and (!user_signed_in? or current_user != current_tenant)
      head :not_found
    end

    respond_to do |format|
      format.html
    end
  end
end
