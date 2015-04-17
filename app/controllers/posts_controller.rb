class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  layout "blog", only: [:index, :show]
  respond_to :html, :json

  def index
    @posts = Post.order(id: :desc)
    if (!user_signed_in? or current_user != current_tenant)
      @posts = @posts.where(published: true)
    end

    respond_to do |format|
      format.html
      format.json
      format.rss { render :layout => false }
    end
  end

  def show
    if !@post.published and (!user_signed_in? or current_user != current_tenant)
      head :not_found
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
